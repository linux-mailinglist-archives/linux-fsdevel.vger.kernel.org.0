Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 862A92AD555
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Nov 2020 12:35:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729662AbgKJLfZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Nov 2020 06:35:25 -0500
Received: from mx2.suse.de ([195.135.220.15]:42368 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726152AbgKJLfY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Nov 2020 06:35:24 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A0A11AC2E;
        Tue, 10 Nov 2020 11:35:22 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 226FA1E130B; Tue, 10 Nov 2020 12:35:22 +0100 (CET)
Date:   Tue, 10 Nov 2020 12:35:22 +0100
From:   Jan Kara <jack@suse.cz>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     linux-xfs@vger.kernel.org, david@fromorbit.com, hch@lst.de,
        fdmanana@kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/3] vfs: separate __sb_start_write into blocking and
 non-blocking helpers
Message-ID: <20201110113522.GD20780@quack2.suse.cz>
References: <160494580419.772573.9286165021627298770.stgit@magnolia>
 <160494581731.772573.9685036230289776579.stgit@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <160494581731.772573.9685036230289776579.stgit@magnolia>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 09-11-20 10:16:57, Darrick J. Wong wrote:
> From: Darrick J. Wong <darrick.wong@oracle.com>
> 
> Break this function into two helpers so that it's obvious that the
> trylock versions return a value that must be checked, and the blocking
> versions don't require that.  While we're at it, clean up the return
> type mismatch.
> 
> Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>

Looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/aio.c           |    2 +-
>  fs/io_uring.c      |    3 +--
>  fs/super.c         |   18 ++++++++++++------
>  include/linux/fs.h |   21 +++++++++++----------
>  4 files changed, 25 insertions(+), 19 deletions(-)
> 
> 
> diff --git a/fs/aio.c b/fs/aio.c
> index c45c20d87538..6a21d8919409 100644
> --- a/fs/aio.c
> +++ b/fs/aio.c
> @@ -1572,7 +1572,7 @@ static int aio_write(struct kiocb *req, const struct iocb *iocb,
>  		 * we return to userspace.
>  		 */
>  		if (S_ISREG(file_inode(file)->i_mode)) {
> -			__sb_start_write(file_inode(file)->i_sb, SB_FREEZE_WRITE, true);
> +			sb_start_write(file_inode(file)->i_sb);
>  			__sb_writers_release(file_inode(file)->i_sb, SB_FREEZE_WRITE);
>  		}
>  		req->ki_flags |= IOCB_WRITE;
> diff --git a/fs/io_uring.c b/fs/io_uring.c
> index b42dfa0243bf..4cbaddfe3d80 100644
> --- a/fs/io_uring.c
> +++ b/fs/io_uring.c
> @@ -3532,8 +3532,7 @@ static int io_write(struct io_kiocb *req, bool force_nonblock,
>  	 * we return to userspace.
>  	 */
>  	if (req->flags & REQ_F_ISREG) {
> -		__sb_start_write(file_inode(req->file)->i_sb,
> -					SB_FREEZE_WRITE, true);
> +		sb_start_write(file_inode(req->file)->i_sb);
>  		__sb_writers_release(file_inode(req->file)->i_sb,
>  					SB_FREEZE_WRITE);
>  	}
> diff --git a/fs/super.c b/fs/super.c
> index e1fd667454d4..59aa59279133 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -1645,16 +1645,22 @@ EXPORT_SYMBOL(__sb_end_write);
>   * This is an internal function, please use sb_start_{write,pagefault,intwrite}
>   * instead.
>   */
> -int __sb_start_write(struct super_block *sb, int level, bool wait)
> +void __sb_start_write(struct super_block *sb, int level)
>  {
> -	if (!wait)
> -		return percpu_down_read_trylock(sb->s_writers.rw_sem + level-1);
> -
> -	percpu_down_read(sb->s_writers.rw_sem + level-1);
> -	return 1;
> +	percpu_down_read(sb->s_writers.rw_sem + level - 1);
>  }
>  EXPORT_SYMBOL(__sb_start_write);
>  
> +/*
> + * This is an internal function, please use sb_start_{write,pagefault,intwrite}
> + * instead.
> + */
> +bool __sb_start_write_trylock(struct super_block *sb, int level)
> +{
> +	return percpu_down_read_trylock(sb->s_writers.rw_sem + level - 1);
> +}
> +EXPORT_SYMBOL_GPL(__sb_start_write_trylock);
> +
>  /**
>   * sb_wait_write - wait until all writers to given file system finish
>   * @sb: the super for which we wait
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 0bd126418bb6..305989afd49c 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1581,7 +1581,8 @@ extern struct timespec64 current_time(struct inode *inode);
>   */
>  
>  void __sb_end_write(struct super_block *sb, int level);
> -int __sb_start_write(struct super_block *sb, int level, bool wait);
> +void __sb_start_write(struct super_block *sb, int level);
> +bool __sb_start_write_trylock(struct super_block *sb, int level);
>  
>  #define __sb_writers_acquired(sb, lev)	\
>  	percpu_rwsem_acquire(&(sb)->s_writers.rw_sem[(lev)-1], 1, _THIS_IP_)
> @@ -1645,12 +1646,12 @@ static inline void sb_end_intwrite(struct super_block *sb)
>   */
>  static inline void sb_start_write(struct super_block *sb)
>  {
> -	__sb_start_write(sb, SB_FREEZE_WRITE, true);
> +	__sb_start_write(sb, SB_FREEZE_WRITE);
>  }
>  
> -static inline int sb_start_write_trylock(struct super_block *sb)
> +static inline bool sb_start_write_trylock(struct super_block *sb)
>  {
> -	return __sb_start_write(sb, SB_FREEZE_WRITE, false);
> +	return __sb_start_write_trylock(sb, SB_FREEZE_WRITE);
>  }
>  
>  /**
> @@ -1674,7 +1675,7 @@ static inline int sb_start_write_trylock(struct super_block *sb)
>   */
>  static inline void sb_start_pagefault(struct super_block *sb)
>  {
> -	__sb_start_write(sb, SB_FREEZE_PAGEFAULT, true);
> +	__sb_start_write(sb, SB_FREEZE_PAGEFAULT);
>  }
>  
>  /*
> @@ -1692,12 +1693,12 @@ static inline void sb_start_pagefault(struct super_block *sb)
>   */
>  static inline void sb_start_intwrite(struct super_block *sb)
>  {
> -	__sb_start_write(sb, SB_FREEZE_FS, true);
> +	__sb_start_write(sb, SB_FREEZE_FS);
>  }
>  
> -static inline int sb_start_intwrite_trylock(struct super_block *sb)
> +static inline bool sb_start_intwrite_trylock(struct super_block *sb)
>  {
> -	return __sb_start_write(sb, SB_FREEZE_FS, false);
> +	return __sb_start_write_trylock(sb, SB_FREEZE_FS);
>  }
>  
>  
> @@ -2756,14 +2757,14 @@ static inline void file_start_write(struct file *file)
>  {
>  	if (!S_ISREG(file_inode(file)->i_mode))
>  		return;
> -	__sb_start_write(file_inode(file)->i_sb, SB_FREEZE_WRITE, true);
> +	sb_start_write(file_inode(file)->i_sb);
>  }
>  
>  static inline bool file_start_write_trylock(struct file *file)
>  {
>  	if (!S_ISREG(file_inode(file)->i_mode))
>  		return true;
> -	return __sb_start_write(file_inode(file)->i_sb, SB_FREEZE_WRITE, false);
> +	return sb_start_write_trylock(file_inode(file)->i_sb);
>  }
>  
>  static inline void file_end_write(struct file *file)
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
