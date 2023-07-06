Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF2C8749A09
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jul 2023 12:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232438AbjGFK5Y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jul 2023 06:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232502AbjGFK44 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jul 2023 06:56:56 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8B44213B;
        Thu,  6 Jul 2023 03:56:04 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5393720537;
        Thu,  6 Jul 2023 10:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1688640963; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kj9bs+5DtbEOxq6mNqV+GGaLHKmQtW1pL7MgW1+MVTM=;
        b=CbW8BlYXj2iFTgnFIyyiO4jK6VCjPdrv1GjWo6tqMv+gcJWa0RiruOaJ4TAwKRClsYpbbV
        iqDMVnlT/9nygCSf7D1HLvhLylmtRAK/cKkiFanjdR5xJwJW1ddGaTxHNo27JrS7C1LiQ6
        BlRz12Kd8RfHPfnoz7boKep6zCZ5Xsw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1688640963;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kj9bs+5DtbEOxq6mNqV+GGaLHKmQtW1pL7MgW1+MVTM=;
        b=Qm2QwvN0O3X1blRe54u2mz9vP3yQobGKvTkcBOtHwi8J+VrFTuMKux8/WuV3gUiAfvOV1j
        3E5DVKtKaiQMWlBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 45744138EE;
        Thu,  6 Jul 2023 10:56:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wmfyEMOdpmSkBQAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 06 Jul 2023 10:56:03 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id E3E2EA0707; Thu,  6 Jul 2023 12:56:02 +0200 (CEST)
Date:   Thu, 6 Jul 2023 12:56:02 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 35/92] devpts: convert to ctime accessor functions
Message-ID: <20230706105602.r5dxif34hhnf7rpu@quack3>
References: <20230705185755.579053-1-jlayton@kernel.org>
 <20230705190309.579783-1-jlayton@kernel.org>
 <20230705190309.579783-33-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705190309.579783-33-jlayton@kernel.org>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 05-07-23 15:01:00, Jeff Layton wrote:
> In later patches, we're going to change how the inode's ctime field is
> used. Switch to using accessor functions instead of raw accesses of
> inode->i_ctime.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/devpts/inode.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/devpts/inode.c b/fs/devpts/inode.c
> index fe3db0eda8e4..5ede89880911 100644
> --- a/fs/devpts/inode.c
> +++ b/fs/devpts/inode.c
> @@ -338,7 +338,7 @@ static int mknod_ptmx(struct super_block *sb)
>  	}
>  
>  	inode->i_ino = 2;
> -	inode->i_mtime = inode->i_atime = inode->i_ctime = current_time(inode);
> +	inode->i_mtime = inode->i_atime = inode_set_ctime_current(inode);
>  
>  	mode = S_IFCHR|opts->ptmxmode;
>  	init_special_inode(inode, mode, MKDEV(TTYAUX_MAJOR, 2));
> @@ -451,7 +451,7 @@ devpts_fill_super(struct super_block *s, void *data, int silent)
>  	if (!inode)
>  		goto fail;
>  	inode->i_ino = 1;
> -	inode->i_mtime = inode->i_atime = inode->i_ctime = current_time(inode);
> +	inode->i_mtime = inode->i_atime = inode_set_ctime_current(inode);
>  	inode->i_mode = S_IFDIR | S_IRUGO | S_IXUGO | S_IWUSR;
>  	inode->i_op = &simple_dir_inode_operations;
>  	inode->i_fop = &simple_dir_operations;
> @@ -560,7 +560,7 @@ struct dentry *devpts_pty_new(struct pts_fs_info *fsi, int index, void *priv)
>  	inode->i_ino = index + 3;
>  	inode->i_uid = opts->setuid ? opts->uid : current_fsuid();
>  	inode->i_gid = opts->setgid ? opts->gid : current_fsgid();
> -	inode->i_mtime = inode->i_atime = inode->i_ctime = current_time(inode);
> +	inode->i_mtime = inode->i_atime = inode_set_ctime_current(inode);
>  	init_special_inode(inode, S_IFCHR|opts->mode, MKDEV(UNIX98_PTY_SLAVE_MAJOR, index));
>  
>  	sprintf(s, "%d", index);
> -- 
> 2.41.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
