Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7C976D4DA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Aug 2023 19:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbjHBROB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Aug 2023 13:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbjHBROA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Aug 2023 13:14:00 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5501F2D63
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Aug 2023 10:13:44 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C68111F381;
        Wed,  2 Aug 2023 17:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1690996422; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=C45vmILARlpokHBQSQBZPt8Vy7nXTyFnR+7fzPvnZd0=;
        b=yx5qEJLf1YQeSpGp031FkZB2IArV0k5u022YcBrsQpfmv+UTBmS7wxi6YOLFxjYjYSZ69U
        OXe2Wne3HTfWDjK63/bEn7GvvAskYgWyJ/1LtjQbMoP8coqmn3jLDztcovURlCgG3+M0l6
        O+uFl82RpoyQZYSdPbzh8iUY9QNKnw8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1690996422;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=C45vmILARlpokHBQSQBZPt8Vy7nXTyFnR+7fzPvnZd0=;
        b=uFlIMuN/qswgGTAVlbVlB4Pz/h9g8x6zdkBFAqFhfnSLtNEWajQ8oImTciNMmH11td1T1+
        42Ec0KBFMTKMb7Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B7EB613919;
        Wed,  2 Aug 2023 17:13:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id KRjgLMaOymQgYAAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 02 Aug 2023 17:13:42 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 56FFFA076B; Wed,  2 Aug 2023 19:13:42 +0200 (CEST)
Date:   Wed, 2 Aug 2023 19:13:42 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>, Karel Zak <kzak@redhat.com>,
        linux-fsdevel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v2 2/4] fs: add vfs_cmd_create()
Message-ID: <20230802171342.uku6rx2ytq53in3m@quack3>
References: <20230802-vfs-super-exclusive-v2-0-95dc4e41b870@kernel.org>
 <20230802-vfs-super-exclusive-v2-2-95dc4e41b870@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230802-vfs-super-exclusive-v2-2-95dc4e41b870@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 02-08-23 13:57:04, Christian Brauner wrote:
> Split the steps to create a superblock into a tiny helper. This will
> make the next patch easier to follow.
> 
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/fsopen.c | 51 ++++++++++++++++++++++++++++++++++-----------------
>  1 file changed, 34 insertions(+), 17 deletions(-)
> 
> diff --git a/fs/fsopen.c b/fs/fsopen.c
> index fc9d2d9fd234..1de2b3576958 100644
> --- a/fs/fsopen.c
> +++ b/fs/fsopen.c
> @@ -209,6 +209,39 @@ SYSCALL_DEFINE3(fspick, int, dfd, const char __user *, path, unsigned int, flags
>  	return ret;
>  }
>  
> +static int vfs_cmd_create(struct fs_context *fc)
> +{
> +	struct super_block *sb;
> +	int ret;
> +
> +	if (fc->phase != FS_CONTEXT_CREATE_PARAMS)
> +		return -EBUSY;
> +
> +	if (!mount_capable(fc))
> +		return -EPERM;
> +
> +	fc->phase = FS_CONTEXT_CREATING;
> +
> +	ret = vfs_get_tree(fc);
> +	if (ret) {
> +		fc->phase = FS_CONTEXT_FAILED;
> +		return ret;
> +	}
> +
> +	sb = fc->root->d_sb;
> +	ret = security_sb_kern_mount(sb);
> +	if (unlikely(ret)) {
> +		fc_drop_locked(fc);
> +		fc->phase = FS_CONTEXT_FAILED;
> +		return ret;
> +	}
> +
> +	/* vfs_get_tree() callchains will have grabbed @s_umount */
> +	up_write(&sb->s_umount);
> +	fc->phase = FS_CONTEXT_AWAITING_MOUNT;
> +	return 0;
> +}
> +
>  /*
>   * Check the state and apply the configuration.  Note that this function is
>   * allowed to 'steal' the value by setting param->xxx to NULL before returning.
> @@ -224,23 +257,7 @@ static int vfs_fsconfig_locked(struct fs_context *fc, int cmd,
>  		return ret;
>  	switch (cmd) {
>  	case FSCONFIG_CMD_CREATE:
> -		if (fc->phase != FS_CONTEXT_CREATE_PARAMS)
> -			return -EBUSY;
> -		if (!mount_capable(fc))
> -			return -EPERM;
> -		fc->phase = FS_CONTEXT_CREATING;
> -		ret = vfs_get_tree(fc);
> -		if (ret)
> -			break;
> -		sb = fc->root->d_sb;
> -		ret = security_sb_kern_mount(sb);
> -		if (unlikely(ret)) {
> -			fc_drop_locked(fc);
> -			break;
> -		}
> -		up_write(&sb->s_umount);
> -		fc->phase = FS_CONTEXT_AWAITING_MOUNT;
> -		return 0;
> +		return vfs_cmd_create(fc);
>  	case FSCONFIG_CMD_RECONFIGURE:
>  		if (fc->phase != FS_CONTEXT_RECONF_PARAMS)
>  			return -EBUSY;
> 
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
