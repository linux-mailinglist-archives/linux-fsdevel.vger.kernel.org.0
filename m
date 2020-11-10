Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A76232AD562
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Nov 2020 12:36:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730651AbgKJLga (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Nov 2020 06:36:30 -0500
Received: from mx2.suse.de ([195.135.220.15]:43708 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730308AbgKJLg3 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Nov 2020 06:36:29 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 47407AC2E;
        Tue, 10 Nov 2020 11:36:27 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id E47351E130B; Tue, 10 Nov 2020 12:36:26 +0100 (CET)
Date:   Tue, 10 Nov 2020 12:36:26 +0100
From:   Jan Kara <jack@suse.cz>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     linux-xfs@vger.kernel.org, david@fromorbit.com, hch@lst.de,
        fdmanana@kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/3] vfs: move __sb_{start,end}_write* to fs.h
Message-ID: <20201110113626.GE20780@quack2.suse.cz>
References: <160494580419.772573.9286165021627298770.stgit@magnolia>
 <160494582399.772573.10836748188202532335.stgit@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <160494582399.772573.10836748188202532335.stgit@magnolia>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 09-11-20 10:17:04, Darrick J. Wong wrote:
> From: Darrick J. Wong <darrick.wong@oracle.com>
> 
> Now that we've straightened out the callers, move these three functions
> to fs.h since they're fairly trivial.
> 
> Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>

Looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/super.c         |   30 ------------------------------
>  include/linux/fs.h |   21 ++++++++++++++++++---
>  2 files changed, 18 insertions(+), 33 deletions(-)
> 
> 
> diff --git a/fs/super.c b/fs/super.c
> index 59aa59279133..98bb0629ee10 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -1631,36 +1631,6 @@ int super_setup_bdi(struct super_block *sb)
>  }
>  EXPORT_SYMBOL(super_setup_bdi);
>  
> -/*
> - * This is an internal function, please use sb_end_{write,pagefault,intwrite}
> - * instead.
> - */
> -void __sb_end_write(struct super_block *sb, int level)
> -{
> -	percpu_up_read(sb->s_writers.rw_sem + level-1);
> -}
> -EXPORT_SYMBOL(__sb_end_write);
> -
> -/*
> - * This is an internal function, please use sb_start_{write,pagefault,intwrite}
> - * instead.
> - */
> -void __sb_start_write(struct super_block *sb, int level)
> -{
> -	percpu_down_read(sb->s_writers.rw_sem + level - 1);
> -}
> -EXPORT_SYMBOL(__sb_start_write);
> -
> -/*
> - * This is an internal function, please use sb_start_{write,pagefault,intwrite}
> - * instead.
> - */
> -bool __sb_start_write_trylock(struct super_block *sb, int level)
> -{
> -	return percpu_down_read_trylock(sb->s_writers.rw_sem + level - 1);
> -}
> -EXPORT_SYMBOL_GPL(__sb_start_write_trylock);
> -
>  /**
>   * sb_wait_write - wait until all writers to given file system finish
>   * @sb: the super for which we wait
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 305989afd49c..6dabd019cab0 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1580,9 +1580,24 @@ extern struct timespec64 current_time(struct inode *inode);
>   * Snapshotting support.
>   */
>  
> -void __sb_end_write(struct super_block *sb, int level);
> -void __sb_start_write(struct super_block *sb, int level);
> -bool __sb_start_write_trylock(struct super_block *sb, int level);
> +/*
> + * These are internal functions, please use sb_start_{write,pagefault,intwrite}
> + * instead.
> + */
> +static inline void __sb_end_write(struct super_block *sb, int level)
> +{
> +	percpu_up_read(sb->s_writers.rw_sem + level-1);
> +}
> +
> +static inline void __sb_start_write(struct super_block *sb, int level)
> +{
> +	percpu_down_read(sb->s_writers.rw_sem + level - 1);
> +}
> +
> +static inline bool __sb_start_write_trylock(struct super_block *sb, int level)
> +{
> +	return percpu_down_read_trylock(sb->s_writers.rw_sem + level - 1);
> +}
>  
>  #define __sb_writers_acquired(sb, lev)	\
>  	percpu_rwsem_acquire(&(sb)->s_writers.rw_sem[(lev)-1], 1, _THIS_IP_)
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
