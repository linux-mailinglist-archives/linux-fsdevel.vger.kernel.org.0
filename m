Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB062F18BE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Jan 2021 15:53:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732337AbhAKOxX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Jan 2021 09:53:23 -0500
Received: from mx2.suse.de ([195.135.220.15]:36890 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730276AbhAKOxX (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Jan 2021 09:53:23 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BAF3CAB7A;
        Mon, 11 Jan 2021 14:52:40 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 71E861E0807; Mon, 11 Jan 2021 15:52:40 +0100 (CET)
Date:   Mon, 11 Jan 2021 15:52:40 +0100
From:   Jan Kara <jack@suse.cz>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        Theodore Ts'o <tytso@mit.edu>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 04/12] fat: only specify I_DIRTY_TIME when needed in
 fat_update_time()
Message-ID: <20210111145240.GC18475@quack2.suse.cz>
References: <20210109075903.208222-1-ebiggers@kernel.org>
 <20210109075903.208222-5-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210109075903.208222-5-ebiggers@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 08-01-21 23:58:55, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> As was done for generic_update_time(), only pass I_DIRTY_TIME to
> __mark_inode_dirty() when the inode's timestamps were actually updated
> and lazytime is enabled.  This avoids a weird edge case where
> I_DIRTY_TIME could be set in i_state when lazytime isn't enabled.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/fat/misc.c | 23 ++++++++++++-----------
>  1 file changed, 12 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/fat/misc.c b/fs/fat/misc.c
> index f1b2a1fc2a6a4..18a50a46b57f8 100644
> --- a/fs/fat/misc.c
> +++ b/fs/fat/misc.c
> @@ -329,22 +329,23 @@ EXPORT_SYMBOL_GPL(fat_truncate_time);
>  
>  int fat_update_time(struct inode *inode, struct timespec64 *now, int flags)
>  {
> -	int iflags = I_DIRTY_TIME;
> -	bool dirty = false;
> +	int dirty_flags = 0;
>  
>  	if (inode->i_ino == MSDOS_ROOT_INO)
>  		return 0;
>  
> -	fat_truncate_time(inode, now, flags);
> -	if (flags & S_VERSION)
> -		dirty = inode_maybe_inc_iversion(inode, false);
> -	if ((flags & (S_ATIME | S_CTIME | S_MTIME)) &&
> -	    !(inode->i_sb->s_flags & SB_LAZYTIME))
> -		dirty = true;
> +	if (flags & (S_ATIME | S_CTIME | S_MTIME)) {
> +		fat_truncate_time(inode, now, flags);
> +		if (inode->i_sb->s_flags & SB_LAZYTIME)
> +			dirty_flags |= I_DIRTY_TIME;
> +		else
> +			dirty_flags |= I_DIRTY_SYNC;
> +	}
> +
> +	if ((flags & S_VERSION) && inode_maybe_inc_iversion(inode, false))
> +		dirty_flags |= I_DIRTY_SYNC;
>  
> -	if (dirty)
> -		iflags |= I_DIRTY_SYNC;
> -	__mark_inode_dirty(inode, iflags);
> +	__mark_inode_dirty(inode, dirty_flags);
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(fat_update_time);
> -- 
> 2.30.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
