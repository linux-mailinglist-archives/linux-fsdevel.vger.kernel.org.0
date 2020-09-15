Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3B7C269AFF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Sep 2020 03:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726046AbgIOBXL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Sep 2020 21:23:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:50674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725999AbgIOBXK (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Sep 2020 21:23:10 -0400
Received: from sol.localdomain (172-10-235-113.lightspeed.sntcca.sbcglobal.net [172.10.235.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 760AD206BE;
        Tue, 15 Sep 2020 01:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600132989;
        bh=LUAPwqpjWpFFljgzVU0r6SItGNcshtNy2N3lKtU4fcs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pSah3gNPuPJfgQ4XnD4NjnWm+LNLjqvXHWDz3+zwvDgL1eFewNy2Nnv2dJ6afvZNc
         aPQGp9VKNc4Hcb6rzus06WoFcK9GaxanEsVvFae8IfP+4Lxe45LXFPmJeFw6phjTnl
         ncARpAw/pZlktWDPMsrAe1gXw5dFDQxaqtar6I7Y=
Date:   Mon, 14 Sep 2020 18:23:07 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     ceph-devel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH v3 08/16] ceph: implement -o test_dummy_encryption
 mount option
Message-ID: <20200915012307.GH899@sol.localdomain>
References: <20200914191707.380444-1-jlayton@kernel.org>
 <20200914191707.380444-9-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200914191707.380444-9-jlayton@kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 14, 2020 at 03:16:59PM -0400, Jeff Layton wrote:
> +	case Opt_test_dummy_encryption:
> +		kfree(fsopt->test_dummy_encryption);
> +#ifdef CONFIG_FS_ENCRYPTION
> +		fsopt->test_dummy_encryption = param->string;
> +		param->string = NULL;
> +		fsopt->flags |= CEPH_MOUNT_OPT_TEST_DUMMY_ENC;
> +#else
> +		warnfc(fc, "FS encryption not supported: test_dummy_encryption mount option ignored");
> +#endif

Seems that the kfree() should go in the CONFIG_FS_ENCRYPTION=y block.

Also, is there much reason to have the CEPH_MOUNT_OPT_TEST_DUMMY_ENC flag
instead of just checking fsopt->test_dummy_encryption != NULL?

> +#ifdef CONFIG_FS_ENCRYPTION
> +static int ceph_set_test_dummy_encryption(struct super_block *sb, struct fs_context *fc,
> +						struct ceph_mount_options *fsopt)
> +{
> +	struct ceph_fs_client *fsc = sb->s_fs_info;
> +
> +	if (fsopt->flags & CEPH_MOUNT_OPT_TEST_DUMMY_ENC) {
> +		substring_t arg = { };
> +
> +		/*
> +		 * No changing encryption context on remount. Note that
> +		 * fscrypt_set_test_dummy_encryption will validate the version
> +		 * string passed in (if any).
> +		 */
> +		if (fc->purpose == FS_CONTEXT_FOR_RECONFIGURE && !fsc->dummy_enc_policy.policy)
> +			return -EEXIST;

Maybe show an error message here, with errorfc()?
See the message that ext4_set_test_dummy_encryption() shows.

> +
> +		/* Ewwwwwwww */
> +		if (fsc->mount_options->test_dummy_encryption) {
> +			arg.from = fsc->mount_options->test_dummy_encryption;
> +			arg.to = arg.from + strlen(arg.from) - 1;
> +		}

We should probably make fscrypt_set_test_dummy_encryption() take a
'const char *' to avoid having to create a substring_t here.

> +		return fscrypt_set_test_dummy_encryption(sb, &arg, &fsc->dummy_enc_policy);

Likewise, maybe show an error message if this fails.

> +	} else {
> +		if (fc->purpose == FS_CONTEXT_FOR_RECONFIGURE && fsc->dummy_enc_policy.policy)
> +			return -EEXIST;

If remount on ceph behaves as "don't change options that aren't specified",
similar to ext4, then there's no need for this hunk here.

>  static int ceph_reconfigure_fc(struct fs_context *fc)
>  {
> +	int err;
>  	struct ceph_parse_opts_ctx *pctx = fc->fs_private;
>  	struct ceph_mount_options *fsopt = pctx->opts;
> -	struct ceph_fs_client *fsc = ceph_sb_to_client(fc->root->d_sb);
> +	struct super_block *sb = fc->root->d_sb;
> +	struct ceph_fs_client *fsc = ceph_sb_to_client(sb);
>  
>  	if (fsopt->flags & CEPH_MOUNT_OPT_ASYNC_DIROPS)
>  		ceph_set_mount_opt(fsc, ASYNC_DIROPS);
>  	else
>  		ceph_clear_mount_opt(fsc, ASYNC_DIROPS);
>  
> -	sync_filesystem(fc->root->d_sb);
> +	err = ceph_set_test_dummy_encryption(sb, fc, fsopt);
> +	if (err)
> +		return err;
> +
> +	sync_filesystem(sb);
>  	return 0;
>  }

Seems that ceph_set_test_dummy_encryption() should go at the beginning, since
otherwise it can fail after something was already changed.

- Eric
