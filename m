Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69E1376D4E7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Aug 2023 19:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbjHBRPf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Aug 2023 13:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbjHBRPd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Aug 2023 13:15:33 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9502B2D69
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Aug 2023 10:15:11 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5827E1F388;
        Wed,  2 Aug 2023 17:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1690996510; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=785tkZEBHA5xDWkOMxwxbBKclnWqeqbdXKMwVbkU23E=;
        b=VS2ty1XO+qHq4+wiFs1zC64A3H41GZ1dafFGnSOOFaI3uBlDJaA9yMO1G2nB74MleAKXei
        EFINE6qM11WBMMqabqd5gCuEVO5hlHaISJGppwSawvuMxa8jI976tFdbYfQTCfj9N5CStA
        GZQBlkwzgtEsZ3GkOUvBaEN57K9mr/4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1690996510;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=785tkZEBHA5xDWkOMxwxbBKclnWqeqbdXKMwVbkU23E=;
        b=rYhlF/GTsF37NSK4tYKSk2NMh+xn+oTlKPSO/NSjxJJyUQO4B6XGIG2B8zE57kDNTxrdBc
        JJCLu5uqxRJ/emAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 48BD713919;
        Wed,  2 Aug 2023 17:15:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id HDS9ER6PymTXYAAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 02 Aug 2023 17:15:10 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id DB7E8A076B; Wed,  2 Aug 2023 19:15:09 +0200 (CEST)
Date:   Wed, 2 Aug 2023 19:15:09 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>, Karel Zak <kzak@redhat.com>,
        linux-fsdevel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v2 3/4] fs: add vfs_cmd_reconfigure()
Message-ID: <20230802171509.yramhxaxlqiuhto3@quack3>
References: <20230802-vfs-super-exclusive-v2-0-95dc4e41b870@kernel.org>
 <20230802-vfs-super-exclusive-v2-3-95dc4e41b870@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230802-vfs-super-exclusive-v2-3-95dc4e41b870@kernel.org>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 02-08-23 13:57:05, Christian Brauner wrote:
> Split the steps to reconfigure a superblock into a tiny helper instead
> of open-coding it in the switch.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/fsopen.c | 47 +++++++++++++++++++++++++++++------------------
>  1 file changed, 29 insertions(+), 18 deletions(-)
> 
> diff --git a/fs/fsopen.c b/fs/fsopen.c
> index 1de2b3576958..a69b7c9cc59c 100644
> --- a/fs/fsopen.c
> +++ b/fs/fsopen.c
> @@ -242,6 +242,34 @@ static int vfs_cmd_create(struct fs_context *fc)
>  	return 0;
>  }
>  
> +static int vfs_cmd_reconfigure(struct fs_context *fc)
> +{
> +	struct super_block *sb;
> +	int ret;
> +
> +	if (fc->phase != FS_CONTEXT_RECONF_PARAMS)
> +		return -EBUSY;
> +
> +	fc->phase = FS_CONTEXT_RECONFIGURING;
> +
> +	sb = fc->root->d_sb;
> +	if (!ns_capable(sb->s_user_ns, CAP_SYS_ADMIN)) {
> +		fc->phase = FS_CONTEXT_FAILED;
> +		return -EPERM;
> +	}
> +
> +	down_write(&sb->s_umount);
> +	ret = reconfigure_super(fc);
> +	up_write(&sb->s_umount);
> +	if (ret) {
> +		fc->phase = FS_CONTEXT_FAILED;
> +		return ret;
> +	}
> +
> +	vfs_clean_context(fc);
> +	return 0;
> +}
> +
>  /*
>   * Check the state and apply the configuration.  Note that this function is
>   * allowed to 'steal' the value by setting param->xxx to NULL before returning.
> @@ -249,7 +277,6 @@ static int vfs_cmd_create(struct fs_context *fc)
>  static int vfs_fsconfig_locked(struct fs_context *fc, int cmd,
>  			       struct fs_parameter *param)
>  {
> -	struct super_block *sb;
>  	int ret;
>  
>  	ret = finish_clean_context(fc);
> @@ -259,21 +286,7 @@ static int vfs_fsconfig_locked(struct fs_context *fc, int cmd,
>  	case FSCONFIG_CMD_CREATE:
>  		return vfs_cmd_create(fc);
>  	case FSCONFIG_CMD_RECONFIGURE:
> -		if (fc->phase != FS_CONTEXT_RECONF_PARAMS)
> -			return -EBUSY;
> -		fc->phase = FS_CONTEXT_RECONFIGURING;
> -		sb = fc->root->d_sb;
> -		if (!ns_capable(sb->s_user_ns, CAP_SYS_ADMIN)) {
> -			ret = -EPERM;
> -			break;
> -		}
> -		down_write(&sb->s_umount);
> -		ret = reconfigure_super(fc);
> -		up_write(&sb->s_umount);
> -		if (ret)
> -			break;
> -		vfs_clean_context(fc);
> -		return 0;
> +		return vfs_cmd_reconfigure(fc);
>  	default:
>  		if (fc->phase != FS_CONTEXT_CREATE_PARAMS &&
>  		    fc->phase != FS_CONTEXT_RECONF_PARAMS)
> @@ -281,8 +294,6 @@ static int vfs_fsconfig_locked(struct fs_context *fc, int cmd,
>  
>  		return vfs_parse_fs_param(fc, param);
>  	}
> -	fc->phase = FS_CONTEXT_FAILED;
> -	return ret;
>  }
>  
>  /**
> 
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
