Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 210E645EA43
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Nov 2021 10:22:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376320AbhKZJ0D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Nov 2021 04:26:03 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:56368 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234287AbhKZJYB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Nov 2021 04:24:01 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id D0F312193C;
        Fri, 26 Nov 2021 09:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637918447; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QdjEKJOZrPvXhoOk+Zsag/sNiydOpw6QEa8Pxqsbrl4=;
        b=ZctW8zTGvD4SqW7yIHnvwawGZLuNdwprRzVyB74rB3XsyZ323alS24Zq8ko9rC5pY3ML/D
        Gsekb7bM6CeW8Gms8AneRzhv81bx5OfJQvDaGNszh86NhYudE/Pt8VHcwW2+ZhduEFLZ55
        ASdTCGkjD+Akywj3p9+zsOGEkXBlFAU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637918447;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QdjEKJOZrPvXhoOk+Zsag/sNiydOpw6QEa8Pxqsbrl4=;
        b=dvK2X6B3JYtoN2TXLc5r0mszJpIVy27DM68fdqbz9INRCfFC8IJzj2e4gYO/agh5ssF05w
        L6jir5YWDKLb+TBw==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id C0B4BA3B81;
        Fri, 26 Nov 2021 09:20:47 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id B41971E11F3; Fri, 26 Nov 2021 10:20:47 +0100 (CET)
Date:   Fri, 26 Nov 2021 10:20:47 +0100
From:   Jan Kara <jack@suse.cz>
To:     Chengguang Xu <cgxu519@mykernel.net>
Cc:     miklos@szeredi.hu, jack@suse.cz, amir73il@gmail.com,
        linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chengguang Xu <charliecgxu@tencent.com>
Subject: Re: [RFC PATCH V6 5/7] fs: export wait_sb_inodes()
Message-ID: <20211126092047.GE13004@quack2.suse.cz>
References: <20211122030038.1938875-1-cgxu519@mykernel.net>
 <20211122030038.1938875-6-cgxu519@mykernel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211122030038.1938875-6-cgxu519@mykernel.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 22-11-21 11:00:36, Chengguang Xu wrote:
> From: Chengguang Xu <charliecgxu@tencent.com>
> 
> In order to wait syncing upper inodes we need to
> call wait_sb_inodes() in overlayfs' ->sync_fs.
> 
> Signed-off-by: Chengguang Xu <charliecgxu@tencent.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/fs-writeback.c         | 3 ++-
>  include/linux/writeback.h | 1 +
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index 81ec192ce067..0438c911241e 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -2505,7 +2505,7 @@ EXPORT_SYMBOL(__mark_inode_dirty);
>   * completed by the time we have gained the lock and waited for all IO that is
>   * in progress regardless of the order callers are granted the lock.
>   */
> -static void wait_sb_inodes(struct super_block *sb)
> +void wait_sb_inodes(struct super_block *sb)
>  {
>  	LIST_HEAD(sync_list);
>  
> @@ -2589,6 +2589,7 @@ static void wait_sb_inodes(struct super_block *sb)
>  	rcu_read_unlock();
>  	mutex_unlock(&sb->s_sync_lock);
>  }
> +EXPORT_SYMBOL(wait_sb_inodes);
>  
>  static void __writeback_inodes_sb_nr(struct super_block *sb, unsigned long nr,
>  				     enum wb_reason reason, bool skip_if_busy)
> diff --git a/include/linux/writeback.h b/include/linux/writeback.h
> index d1f65adf6a26..d7aacd0434cf 100644
> --- a/include/linux/writeback.h
> +++ b/include/linux/writeback.h
> @@ -198,6 +198,7 @@ void wakeup_flusher_threads_bdi(struct backing_dev_info *bdi,
>  				enum wb_reason reason);
>  void inode_wait_for_writeback(struct inode *inode);
>  void inode_io_list_del(struct inode *inode);
> +void wait_sb_inodes(struct super_block *sb);
>  
>  /* writeback.h requires fs.h; it, too, is not included from here. */
>  static inline void wait_on_inode(struct inode *inode)
> -- 
> 2.27.0
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
