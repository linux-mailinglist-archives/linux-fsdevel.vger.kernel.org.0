Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF6A260990
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Sep 2020 06:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726919AbgIHE33 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Sep 2020 00:29:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:53980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725802AbgIHE32 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Sep 2020 00:29:28 -0400
Received: from sol.localdomain (172-10-235-113.lightspeed.sntcca.sbcglobal.net [172.10.235.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49A6721532;
        Tue,  8 Sep 2020 04:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599539367;
        bh=wO/iRGyiMInh1AkYgaXt9PXgr/0hIzeDIVv0N3kxDiU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=erF4NRT0HYm0jjOv2QtgT/VskzBhS37H9mIV2P5iSGHuFs4Fo+DMWXj9hKzF7kKg1
         7B+UiqpHEhhYMv38guSpK1EsHAwUPb2pOcyFNDiEKJ1Qa5zKjmok98pPdamdmpgqe2
         SEdQm90R3l3GqPc97c2jnOnPAo+6KxuaF8qd2GlA=
Date:   Mon, 7 Sep 2020 21:29:25 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-fscrypt@vger.kernel.org
Subject: Re: [RFC PATCH v2 09/18] ceph: crypto context handling for ceph
Message-ID: <20200908042925.GI68127@sol.localdomain>
References: <20200904160537.76663-1-jlayton@kernel.org>
 <20200904160537.76663-10-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904160537.76663-10-jlayton@kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 04, 2020 at 12:05:28PM -0400, Jeff Layton wrote:
> Store the fscrypt context for an inode as an encryption.ctx xattr.
> 
> Also add support for "dummy" encryption (useful for testing with
> automated test harnesses like xfstests).

Can you put the test_dummy_encryption support in a separate patch?

> +static int ceph_crypt_get_context(struct inode *inode, void *ctx, size_t len)
> +{
> +	int ret = __ceph_getxattr(inode, CEPH_XATTR_NAME_ENCRYPTION_CONTEXT, ctx, len);
> +
> +	if (ret > 0)
> +		inode_set_flags(inode, S_ENCRYPTED, S_ENCRYPTED);
> +	return ret;
> +}
> +
> +static int ceph_crypt_set_context(struct inode *inode, const void *ctx, size_t len, void *fs_data)
> +{
> +	int ret;
> +
> +	WARN_ON_ONCE(fs_data);
> +	ret = __ceph_setxattr(inode, CEPH_XATTR_NAME_ENCRYPTION_CONTEXT, ctx, len, XATTR_CREATE);
> +	if (ret == 0)
> +		inode_set_flags(inode, S_ENCRYPTED, S_ENCRYPTED);
> +	return ret;
> +}

get_context() shouldn't be setting the S_ENCRYPTED inode flag.
Only set_context() should be doing that.

> +
> +static bool ceph_crypt_empty_dir(struct inode *inode)
> +{
> +	struct ceph_inode_info *ci = ceph_inode(inode);
> +
> +	return ci->i_rsubdirs + ci->i_rfiles == 1;
> +}
> +
> +static const union fscrypt_context *
> +ceph_get_dummy_context(struct super_block *sb)
> +{
> +	return ceph_sb_to_client(sb)->dummy_enc_ctx.ctx;
> +}
> +
> +static struct fscrypt_operations ceph_fscrypt_ops = {
> +	.key_prefix		= "ceph:",

IMO you shouldn't set .key_prefix here, since it's deprecated.
Just leave it unset so that ceph will only support the generic prefix "fscrypt:"
as well as FS_IOC_ADD_ENCRYPTION_KEY.

>  enum ceph_recover_session_mode {
> @@ -197,6 +200,8 @@ static const struct fs_parameter_spec ceph_mount_parameters[] = {
>  	fsparam_u32	("rsize",			Opt_rsize),
>  	fsparam_string	("snapdirname",			Opt_snapdirname),
>  	fsparam_string	("source",			Opt_source),
> +	fsparam_flag_no ("test_dummy_encryption",	Opt_test_dummy_encryption),
> +	fsparam_string	("test_dummy_encryption",	Opt_test_dummy_encryption),

I think you should use fsparam_flag instead of fsparam_flag_no, since otherwise
"notest_dummy_encryption" will be recognized.  There's not a problem with it
per se, but none of the other filesystems that support "test_dummy_encryption"
allow "notest_dummy_encryption".  It's nice to keep things consistent.

I.e. if "notest_dummy_encryption" is really something that would be useful
(presumably only for remount, since it's a test-only option that will never be
on by default), then we should add it to ext4, f2fs, and ceph -- not just ceph.

> +	/* Don't allow test_dummy_encryption to change on remount */
> +	if (fsopt->flags & CEPH_MOUNT_OPT_TEST_DUMMY_ENC) {
> +		if (!ceph_test_mount_opt(fsc, TEST_DUMMY_ENC))
> +			return -EEXIST;
> +	} else {
> +		if (ceph_test_mount_opt(fsc, TEST_DUMMY_ENC))
> +			return -EEXIST;
> +	}
> +

Can you check what ext4 and f2fs do for this?  test_dummy_encryption isn't just
a boolean flag anymore, so this logic isn't sufficient to prevent it from
changing during remount.  For example someone could mount with
test_dummy_encryption=v1, then try to remount with test_dummy_encryption=v2.
On ext4 and f2fs, that intentionally fails.

- Eric
