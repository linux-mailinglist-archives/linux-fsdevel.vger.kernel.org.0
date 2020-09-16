Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9D726C684
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Sep 2020 19:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727614AbgIPRwF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Sep 2020 13:52:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:42044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727554AbgIPRvX (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Sep 2020 13:51:23 -0400
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1ACC922227;
        Wed, 16 Sep 2020 12:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600260588;
        bh=ViIzrXI8juxz4GpUaQgw0altL7fO7zi+9yar4pkYCNE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=rWxficUsCHLeQ3JhySbZbqNY9IEiAlEoMoDwazd3cGJzxLQaXogCAswAm3McrBInm
         JK4ptxbaoSNprHqI3UsP+idhj/J5BVPhgBdOH9/DRgLfbJvbiwVISiqEMNt6J8sTiV
         1hzG0mv2hRi3YAHbsMqt8DXxU6dTOTSCvOS0+SH8=
Message-ID: <611ba5851c4d528dd06e21348ec31d0970069431.camel@kernel.org>
Subject: Re: [RFC PATCH v3 08/16] ceph: implement -o test_dummy_encryption
 mount option
From:   Jeff Layton <jlayton@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     ceph-devel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Date:   Wed, 16 Sep 2020 08:49:47 -0400
In-Reply-To: <20200915012307.GH899@sol.localdomain>
References: <20200914191707.380444-1-jlayton@kernel.org>
         <20200914191707.380444-9-jlayton@kernel.org>
         <20200915012307.GH899@sol.localdomain>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2020-09-14 at 18:23 -0700, Eric Biggers wrote:
> On Mon, Sep 14, 2020 at 03:16:59PM -0400, Jeff Layton wrote:
> > +	case Opt_test_dummy_encryption:
> > +		kfree(fsopt->test_dummy_encryption);
> > +#ifdef CONFIG_FS_ENCRYPTION
> > +		fsopt->test_dummy_encryption = param->string;
> > +		param->string = NULL;
> > +		fsopt->flags |= CEPH_MOUNT_OPT_TEST_DUMMY_ENC;
> > +#else
> > +		warnfc(fc, "FS encryption not supported: test_dummy_encryption mount option ignored");
> > +#endif
> 
> Seems that the kfree() should go in the CONFIG_FS_ENCRYPTION=y block.
> 
> Also, is there much reason to have the CEPH_MOUNT_OPT_TEST_DUMMY_ENC flag
> instead of just checking fsopt->test_dummy_encryption != NULL?
> 

Yes. That distinguishes between the case where someone has used
-o test_dummy_encryption and -o test_dummy_encryption=v2.

> > +#ifdef CONFIG_FS_ENCRYPTION
> > +static int ceph_set_test_dummy_encryption(struct super_block *sb, struct fs_context *fc,
> > +						struct ceph_mount_options *fsopt)
> > +{
> > +	struct ceph_fs_client *fsc = sb->s_fs_info;
> > +
> > +	if (fsopt->flags & CEPH_MOUNT_OPT_TEST_DUMMY_ENC) {
> > +		substring_t arg = { };
> > +
> > +		/*
> > +		 * No changing encryption context on remount. Note that
> > +		 * fscrypt_set_test_dummy_encryption will validate the version
> > +		 * string passed in (if any).
> > +		 */
> > +		if (fc->purpose == FS_CONTEXT_FOR_RECONFIGURE && !fsc->dummy_enc_policy.policy)
> > +			return -EEXIST;
> 
> Maybe show an error message here, with errorfc()?
> See the message that ext4_set_test_dummy_encryption() shows.
> 

Good idea. I've rolled in error messages similar to the ones in ext4.

> > +
> > +		/* Ewwwwwwww */
> > +		if (fsc->mount_options->test_dummy_encryption) {
> > +			arg.from = fsc->mount_options->test_dummy_encryption;
> > +			arg.to = arg.from + strlen(arg.from) - 1;
> > +		}
> 
> We should probably make fscrypt_set_test_dummy_encryption() take a
> 'const char *' to avoid having to create a substring_t here.
> 

Yes, please. I didn't want to do that with most of the current fscrypt-
enabled fs using the old mount API. Some of them may need to copy the
argument so that it's properly terminated.

We could also just add a wrapper that turns the const char * into a
substring_t before calling fscrypt_set_test_dummy_encryption.

> > +		return fscrypt_set_test_dummy_encryption(sb, &arg, &fsc->dummy_enc_policy);
> 
> Likewise, maybe show an error message if this fails.
> 
> > +	} else {
> > +		if (fc->purpose == FS_CONTEXT_FOR_RECONFIGURE && fsc->dummy_enc_policy.policy)
> > +			return -EEXIST;
> 
> If remount on ceph behaves as "don't change options that aren't specified",
> similar to ext4, then there's no need for this hunk here.
> 

Good point.

> >  static int ceph_reconfigure_fc(struct fs_context *fc)
> >  {
> > +	int err;
> >  	struct ceph_parse_opts_ctx *pctx = fc->fs_private;
> >  	struct ceph_mount_options *fsopt = pctx->opts;
> > -	struct ceph_fs_client *fsc = ceph_sb_to_client(fc->root->d_sb);
> > +	struct super_block *sb = fc->root->d_sb;
> > +	struct ceph_fs_client *fsc = ceph_sb_to_client(sb);
> >  
> >  	if (fsopt->flags & CEPH_MOUNT_OPT_ASYNC_DIROPS)
> >  		ceph_set_mount_opt(fsc, ASYNC_DIROPS);
> >  	else
> >  		ceph_clear_mount_opt(fsc, ASYNC_DIROPS);
> >  
> > -	sync_filesystem(fc->root->d_sb);
> > +	err = ceph_set_test_dummy_encryption(sb, fc, fsopt);
> > +	if (err)
> > +		return err;
> > +
> > +	sync_filesystem(sb);
> >  	return 0;
> >  }
> 
> Seems that ceph_set_test_dummy_encryption() should go at the beginning, since
> otherwise it can fail after something was already changed.
> 

Good catch. Fixed.

-- 
Jeff Layton <jlayton@kernel.org>

