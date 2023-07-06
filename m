Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4542749FEA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jul 2023 16:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232265AbjGFOxg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jul 2023 10:53:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233719AbjGFOxQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jul 2023 10:53:16 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E6A1FEB;
        Thu,  6 Jul 2023 07:53:00 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 928F51FD65;
        Thu,  6 Jul 2023 14:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1688655179; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nDUsetCkqpDQUJVYGRErgZCuLwEHAuc+qzd91AAjCtc=;
        b=1+8rm95/EcbL2B8vzMHoMtMkfs790e2J3JpHpOixMenmgWsb/gcgn+sUZnVAZ0JW7aWVIO
        9l8YE+DNR25F2CMefU4DgtkaImwWAV1f0M/phU8ScD6WejtiZmZPAINIXubqfig8DVcpGj
        tkIqH4B6D3wewtC4ruk8kEe7lISDVYU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1688655179;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nDUsetCkqpDQUJVYGRErgZCuLwEHAuc+qzd91AAjCtc=;
        b=BC9KEnqupiXOSykkXXP6u+dxL3w9LYMrN+PTifNhZB4fjuRyeGWxgLCwJk9o47MD45RrJU
        6W2p6myuHGB6urCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 84BDE138FC;
        Thu,  6 Jul 2023 14:52:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id /vRnIEvVpmR9AwAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 06 Jul 2023 14:52:59 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 07FE3A0707; Thu,  6 Jul 2023 16:52:59 +0200 (CEST)
Date:   Thu, 6 Jul 2023 16:52:59 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 83/92] zonefs: convert to ctime accessor functions
Message-ID: <20230706145259.mnvliyi3s6nmgyvr@quack3>
References: <20230705185755.579053-1-jlayton@kernel.org>
 <20230705190309.579783-1-jlayton@kernel.org>
 <20230705190309.579783-81-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705190309.579783-81-jlayton@kernel.org>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 05-07-23 15:01:48, Jeff Layton wrote:
> In later patches, we're going to change how the inode's ctime field is
> used. Switch to using accessor functions instead of raw accesses of
> inode->i_ctime.
> 
> Acked-by: Damien Le Moal <dlemoal@kernel.org>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/zonefs/super.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
> index bbe44a26a8e5..eaaa23cf6d93 100644
> --- a/fs/zonefs/super.c
> +++ b/fs/zonefs/super.c
> @@ -658,7 +658,8 @@ static struct inode *zonefs_get_file_inode(struct inode *dir,
>  
>  	inode->i_ino = ino;
>  	inode->i_mode = z->z_mode;
> -	inode->i_ctime = inode->i_mtime = inode->i_atime = dir->i_ctime;
> +	inode->i_mtime = inode->i_atime = inode_set_ctime_to_ts(inode,
> +								inode_get_ctime(dir));
>  	inode->i_uid = z->z_uid;
>  	inode->i_gid = z->z_gid;
>  	inode->i_size = z->z_wpoffset;
> @@ -694,7 +695,8 @@ static struct inode *zonefs_get_zgroup_inode(struct super_block *sb,
>  	inode->i_ino = ino;
>  	inode_init_owner(&nop_mnt_idmap, inode, root, S_IFDIR | 0555);
>  	inode->i_size = sbi->s_zgroup[ztype].g_nr_zones;
> -	inode->i_ctime = inode->i_mtime = inode->i_atime = root->i_ctime;
> +	inode->i_mtime = inode->i_atime = inode_set_ctime_to_ts(inode,
> +								inode_get_ctime(root));
>  	inode->i_private = &sbi->s_zgroup[ztype];
>  	set_nlink(inode, 2);
>  
> @@ -1317,7 +1319,7 @@ static int zonefs_fill_super(struct super_block *sb, void *data, int silent)
>  
>  	inode->i_ino = bdev_nr_zones(sb->s_bdev);
>  	inode->i_mode = S_IFDIR | 0555;
> -	inode->i_ctime = inode->i_mtime = inode->i_atime = current_time(inode);
> +	inode->i_mtime = inode->i_atime = inode_set_ctime_current(inode);
>  	inode->i_op = &zonefs_dir_inode_operations;
>  	inode->i_fop = &zonefs_dir_operations;
>  	inode->i_size = 2;
> -- 
> 2.41.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
