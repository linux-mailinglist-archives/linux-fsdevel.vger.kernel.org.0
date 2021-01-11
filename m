Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 656D72F18AF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Jan 2021 15:50:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728949AbhAKOtj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Jan 2021 09:49:39 -0500
Received: from mx2.suse.de ([195.135.220.15]:34110 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727073AbhAKOti (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Jan 2021 09:49:38 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8074BAC95;
        Mon, 11 Jan 2021 14:48:57 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 46A7E1E0807; Mon, 11 Jan 2021 15:48:57 +0100 (CET)
Date:   Mon, 11 Jan 2021 15:48:57 +0100
From:   Jan Kara <jack@suse.cz>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        Theodore Ts'o <tytso@mit.edu>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 02/12] fs: correctly document the inode dirty flags
Message-ID: <20210111144857.GA18475@quack2.suse.cz>
References: <20210109075903.208222-1-ebiggers@kernel.org>
 <20210109075903.208222-3-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210109075903.208222-3-ebiggers@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 08-01-21 23:58:53, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> The documentation for I_DIRTY_SYNC and I_DIRTY_DATASYNC is a bit
> misleading, and I_DIRTY_TIME isn't documented at all.  Fix this.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  include/linux/fs.h | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index fd47deea7c176..45a0303b2aeb6 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2084,8 +2084,8 @@ static inline void kiocb_clone(struct kiocb *kiocb, struct kiocb *kiocb_src,
>  /*
>   * Inode state bits.  Protected by inode->i_lock
>   *
> - * Three bits determine the dirty state of the inode, I_DIRTY_SYNC,
> - * I_DIRTY_DATASYNC and I_DIRTY_PAGES.
> + * Four bits determine the dirty state of the inode: I_DIRTY_SYNC,
> + * I_DIRTY_DATASYNC, I_DIRTY_PAGES, and I_DIRTY_TIME.
>   *
>   * Four bits define the lifetime of an inode.  Initially, inodes are I_NEW,
>   * until that flag is cleared.  I_WILL_FREE, I_FREEING and I_CLEAR are set at
> @@ -2094,12 +2094,20 @@ static inline void kiocb_clone(struct kiocb *kiocb, struct kiocb *kiocb_src,
>   * Two bits are used for locking and completion notification, I_NEW and I_SYNC.
>   *
>   * I_DIRTY_SYNC		Inode is dirty, but doesn't have to be written on
> - *			fdatasync().  i_atime is the usual cause.
> - * I_DIRTY_DATASYNC	Data-related inode changes pending. We keep track of
> + *			fdatasync() (unless I_DIRTY_DATASYNC is also set).
> + *			Timestamp updates are the usual cause.
> + * I_DIRTY_DATASYNC	Data-related inode changes pending.  We keep track of
>   *			these changes separately from I_DIRTY_SYNC so that we
>   *			don't have to write inode on fdatasync() when only
> - *			mtime has changed in it.
> + *			e.g. the timestamps have changed.
>   * I_DIRTY_PAGES	Inode has dirty pages.  Inode itself may be clean.
> + * I_DIRTY_TIME		The inode itself only has dirty timestamps, and the
> + *			lazytime mount option is enabled.  We keep track of this
> + *			separately from I_DIRTY_SYNC in order to implement
> + *			lazytime.  This gets cleared if I_DIRTY_INODE
> + *			(I_DIRTY_SYNC and/or I_DIRTY_DATASYNC) gets set.  I.e.
> + *			either I_DIRTY_TIME *or* I_DIRTY_INODE can be set in
> + *			i_state, but not both.  I_DIRTY_PAGES may still be set.
>   * I_NEW		Serves as both a mutex and completion notification.
>   *			New inodes set I_NEW.  If two processes both create
>   *			the same inode, one of them will release its inode and
> -- 
> 2.30.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
