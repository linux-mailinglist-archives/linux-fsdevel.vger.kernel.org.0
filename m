Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F23622A90AC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Nov 2020 08:48:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbgKFHsc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Nov 2020 02:48:32 -0500
Received: from verein.lst.de ([213.95.11.211]:50401 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725848AbgKFHsc (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Nov 2020 02:48:32 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id CF70C68B02; Fri,  6 Nov 2020 08:48:29 +0100 (CET)
Date:   Fri, 6 Nov 2020 08:48:29 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     linux-xfs@vger.kernel.org, david@fromorbit.com, hch@lst.de,
        fdmanana@kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/2] vfs: separate __sb_start_write into blocking and
 non-blocking helpers
Message-ID: <20201106074829.GB31133@lst.de>
References: <160463582157.1669281.13010940328517200152.stgit@magnolia> <160463583438.1669281.14783057013328963357.stgit@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <160463583438.1669281.14783057013328963357.stgit@magnolia>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 05, 2020 at 08:10:34PM -0800, Darrick J. Wong wrote:
> From: Darrick J. Wong <darrick.wong@oracle.com>
> 
> Break this function into two helpers so that it's obvious that the
> trylock versions return a value that must be checked, and the blocking
> versions don't require that.  While we're at it, clean up the return
> type mismatch.
> 
> Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
> ---
>  fs/aio.c           |    2 +-
>  fs/io_uring.c      |    3 +--
>  fs/super.c         |   18 ++++++++++++------
>  include/linux/fs.h |   21 +++++++++++----------
>  4 files changed, 25 insertions(+), 19 deletions(-)
> 
> 
> diff --git a/fs/aio.c b/fs/aio.c
> index c45c20d87538..04bb4bac327f 100644
> --- a/fs/aio.c
> +++ b/fs/aio.c
> @@ -1572,7 +1572,7 @@ static int aio_write(struct kiocb *req, const struct iocb *iocb,
>  		 * we return to userspace.
>  		 */
>  		if (S_ISREG(file_inode(file)->i_mode)) {
> -			__sb_start_write(file_inode(file)->i_sb, SB_FREEZE_WRITE, true);
> +			__sb_start_write(file_inode(file)->i_sb, SB_FREEZE_WRITE);

This should use sb_start_write()

>  	if (req->flags & REQ_F_ISREG) {
> -		__sb_start_write(file_inode(req->file)->i_sb,
> -					SB_FREEZE_WRITE, true);
> +		__sb_start_write(file_inode(req->file)->i_sb, SB_FREEZE_WRITE);

Same.

> +void __sb_start_write(struct super_block *sb, int level)
>  {
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

I think these can be inline in the headers, or even be merged into
the few callers.

> @@ -2756,14 +2757,14 @@ static inline void file_start_write(struct file *file)
>  {
>  	if (!S_ISREG(file_inode(file)->i_mode))
>  		return;
> -	__sb_start_write(file_inode(file)->i_sb, SB_FREEZE_WRITE, true);
> +	__sb_start_write(file_inode(file)->i_sb, SB_FREEZE_WRITE);

This should use sb_start_write.

>  }
>  
>  static inline bool file_start_write_trylock(struct file *file)
>  {
>  	if (!S_ISREG(file_inode(file)->i_mode))
>  		return true;
> -	return __sb_start_write(file_inode(file)->i_sb, SB_FREEZE_WRITE, false);
> +	return __sb_start_write_trylock(file_inode(file)->i_sb, SB_FREEZE_WRITE);

And this one sb_start_write_trylock.
