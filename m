Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F23912615EF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Sep 2020 18:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731993AbgIHQ67 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Sep 2020 12:58:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:58438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731844AbgIHQUH (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:20:07 -0400
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE113206E7;
        Tue,  8 Sep 2020 16:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599581701;
        bh=buqTl7K/5yMlXLYCwbAvqNzPVouLw+rbce6yKGxpIXc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=gQvEoTOIY+aAoPVBkju8UV3zX0NFkPuEs7SJIoBUAJJAz1e4yz531RIarr3LZvs3Q
         56Pq2gZL4U5BRqGAFXy+11xsBpmejOcXideKB44S9BFRHP3Iglk3MG3BDKhTfWxslj
         Ol7ZTWZHknmOryOxVylg6OBrVuyTxVDpVTXJSdVk=
Message-ID: <f3b006d348545e83b8ae7d2eaef210627fd38a6b.camel@kernel.org>
Subject: Re: [RFC PATCH v2 09/18] ceph: crypto context handling for ceph
From:   Jeff Layton <jlayton@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-fscrypt@vger.kernel.org
Date:   Tue, 08 Sep 2020 12:14:59 -0400
In-Reply-To: <20200908042925.GI68127@sol.localdomain>
References: <20200904160537.76663-1-jlayton@kernel.org>
         <20200904160537.76663-10-jlayton@kernel.org>
         <20200908042925.GI68127@sol.localdomain>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2020-09-07 at 21:29 -0700, Eric Biggers wrote:
> On Fri, Sep 04, 2020 at 12:05:28PM -0400, Jeff Layton wrote:
> > Store the fscrypt context for an inode as an encryption.ctx xattr.
> > 
> > Also add support for "dummy" encryption (useful for testing with
> > automated test harnesses like xfstests).
> 
> Can you put the test_dummy_encryption support in a separate patch?
> 
> > +static int ceph_crypt_get_context(struct inode *inode, void *ctx, size_t len)
> > +{
> > +	int ret = __ceph_getxattr(inode, CEPH_XATTR_NAME_ENCRYPTION_CONTEXT, ctx, len);
> > +
> > +	if (ret > 0)
> > +		inode_set_flags(inode, S_ENCRYPTED, S_ENCRYPTED);
> > +	return ret;
> > +}
> > +
> > +static int ceph_crypt_set_context(struct inode *inode, const void *ctx, size_t len, void *fs_data)
> > +{
> > +	int ret;
> > +
> > +	WARN_ON_ONCE(fs_data);
> > +	ret = __ceph_setxattr(inode, CEPH_XATTR_NAME_ENCRYPTION_CONTEXT, ctx, len, XATTR_CREATE);
> > +	if (ret == 0)
> > +		inode_set_flags(inode, S_ENCRYPTED, S_ENCRYPTED);
> > +	return ret;
> > +}
> 
> get_context() shouldn't be setting the S_ENCRYPTED inode flag.
> Only set_context() should be doing that.
> 
> > +
> > +static bool ceph_crypt_empty_dir(struct inode *inode)
> > +{
> > +	struct ceph_inode_info *ci = ceph_inode(inode);
> > +
> > +	return ci->i_rsubdirs + ci->i_rfiles == 1;
> > +}
> > +
> > +static const union fscrypt_context *
> > +ceph_get_dummy_context(struct super_block *sb)
> > +{
> > +	return ceph_sb_to_client(sb)->dummy_enc_ctx.ctx;
> > +}
> > +
> > +static struct fscrypt_operations ceph_fscrypt_ops = {
> > +	.key_prefix		= "ceph:",
> 
> IMO you shouldn't set .key_prefix here, since it's deprecated.
> Just leave it unset so that ceph will only support the generic prefix "fscrypt:"
> as well as FS_IOC_ADD_ENCRYPTION_KEY.
> 
> >  enum ceph_recover_session_mode {
> > @@ -197,6 +200,8 @@ static const struct fs_parameter_spec ceph_mount_parameters[] = {
> >  	fsparam_u32	("rsize",			Opt_rsize),
> >  	fsparam_string	("snapdirname",			Opt_snapdirname),
> >  	fsparam_string	("source",			Opt_source),
> > +	fsparam_flag_no ("test_dummy_encryption",	Opt_test_dummy_encryption),
> > +	fsparam_string	("test_dummy_encryption",	Opt_test_dummy_encryption),
> 
> I think you should use fsparam_flag instead of fsparam_flag_no, since otherwise
> "notest_dummy_encryption" will be recognized.  There's not a problem with it
> per se, but none of the other filesystems that support "test_dummy_encryption"
> allow "notest_dummy_encryption".  It's nice to keep things consistent.
> 
> I.e. if "notest_dummy_encryption" is really something that would be useful
> (presumably only for remount, since it's a test-only option that will never be
> on by default), then we should add it to ext4, f2fs, and ceph -- not just ceph.
> 
> > +	/* Don't allow test_dummy_encryption to change on remount */
> > +	if (fsopt->flags & CEPH_MOUNT_OPT_TEST_DUMMY_ENC) {
> > +		if (!ceph_test_mount_opt(fsc, TEST_DUMMY_ENC))
> > +			return -EEXIST;
> > +	} else {
> > +		if (ceph_test_mount_opt(fsc, TEST_DUMMY_ENC))
> > +			return -EEXIST;
> > +	}
> > +
> 
> Can you check what ext4 and f2fs do for this?  test_dummy_encryption isn't just
> a boolean flag anymore, so this logic isn't sufficient to prevent it from
> changing during remount.  For example someone could mount with
> test_dummy_encryption=v1, then try to remount with test_dummy_encryption=v2.
> On ext4 and f2fs, that intentionally fails.

Ok, I'll see what I can do. Note that those fs' all use the old mount
API (so far) and ceph has been converted to the new one. We may need to
rework a bit of the fscrypt infrastructure to handle the new mount API.

-- 
Jeff Layton <jlayton@kernel.org>

