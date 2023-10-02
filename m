Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB69A7B5831
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Oct 2023 18:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238393AbjJBQWg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Oct 2023 12:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238069AbjJBQWg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Oct 2023 12:22:36 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5411C83
        for <linux-fsdevel@vger.kernel.org>; Mon,  2 Oct 2023 09:22:33 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 00A9A1F747;
        Mon,  2 Oct 2023 16:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1696263752; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H0mz8jVMob7Wv+ZA2h683Lt78S4ILx8sJkNyW1Bu3Xs=;
        b=N8EOlJaGFKHzsYgWQfZO2fFF9uqkpMfG37wie+XlOfhp8NWw1ocCaMejxBsd1zbfVoJMob
        CvdMIj/EAqwEmUKOBarASTwnYPtbHHGapNIEZDZeaVagZhpjxjGqcmybN7jN9ERREo4SWg
        VK9FpnVMk1TiBl/YHHuddCclyD8y7ms=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1696263752;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H0mz8jVMob7Wv+ZA2h683Lt78S4ILx8sJkNyW1Bu3Xs=;
        b=L+VnrOtUF+BPO0kCfuFvCN308h8VrEWKa+5vCx1YmKRgKYOISpOh/WH0C8zMaX/gJBt0rH
        0oFvW4UwsebKZ0BQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E7A2B13456;
        Mon,  2 Oct 2023 16:22:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id /0SFOEfuGmWsHwAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 02 Oct 2023 16:22:31 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 6FB6CA07C9; Mon,  2 Oct 2023 18:22:31 +0200 (CEST)
Date:   Mon, 2 Oct 2023 18:22:31 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
        linux-fsdevel@vger.kernel.org,
        "Darrick J. Wong" <djwong@kernel.org>
Subject: Re: [PATCH 4/7] fs: remove get_active_super()
Message-ID: <20231002162231.du6q43odep5wzw7p@quack3>
References: <20230927-vfs-super-freeze-v1-0-ecc36d9ab4d9@kernel.org>
 <20230927-vfs-super-freeze-v1-4-ecc36d9ab4d9@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230927-vfs-super-freeze-v1-4-ecc36d9ab4d9@kernel.org>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 27-09-23 15:21:17, Christian Brauner wrote:
> This function is now unused so remove it. One less function that uses
> the global superblock list.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Nice. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/super.c         | 28 ----------------------------
>  include/linux/fs.h |  1 -
>  2 files changed, 29 deletions(-)
> 
> diff --git a/fs/super.c b/fs/super.c
> index 672f1837fbef..181ac8501301 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -1016,34 +1016,6 @@ void iterate_supers_type(struct file_system_type *type,
>  
>  EXPORT_SYMBOL(iterate_supers_type);
>  
> -/**
> - * get_active_super - get an active reference to the superblock of a device
> - * @bdev: device to get the superblock for
> - *
> - * Scans the superblock list and finds the superblock of the file system
> - * mounted on the device given.  Returns the superblock with an active
> - * reference or %NULL if none was found.
> - */
> -struct super_block *get_active_super(struct block_device *bdev)
> -{
> -	struct super_block *sb;
> -
> -	if (!bdev)
> -		return NULL;
> -
> -	spin_lock(&sb_lock);
> -	list_for_each_entry(sb, &super_blocks, s_list) {
> -		if (sb->s_bdev == bdev) {
> -			if (!grab_super(sb))
> -				return NULL;
> -			super_unlock_excl(sb);
> -			return sb;
> -		}
> -	}
> -	spin_unlock(&sb_lock);
> -	return NULL;
> -}
> -
>  struct super_block *user_get_super(dev_t dev, bool excl)
>  {
>  	struct super_block *sb;
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index b528f063e8ff..ad0ddc10d560 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -3052,7 +3052,6 @@ extern int vfs_readlink(struct dentry *, char __user *, int);
>  extern struct file_system_type *get_filesystem(struct file_system_type *fs);
>  extern void put_filesystem(struct file_system_type *fs);
>  extern struct file_system_type *get_fs_type(const char *name);
> -extern struct super_block *get_active_super(struct block_device *bdev);
>  extern void drop_super(struct super_block *sb);
>  extern void drop_super_exclusive(struct super_block *sb);
>  extern void iterate_supers(void (*)(struct super_block *, void *), void *);
> 
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
