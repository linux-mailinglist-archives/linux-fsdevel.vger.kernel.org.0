Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79BF62F18B6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Jan 2021 15:51:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731611AbhAKOvL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Jan 2021 09:51:11 -0500
Received: from mx2.suse.de ([195.135.220.15]:35080 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728850AbhAKOvL (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Jan 2021 09:51:11 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DDED9AB7A;
        Mon, 11 Jan 2021 14:50:29 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id AF3721E0807; Mon, 11 Jan 2021 15:50:29 +0100 (CET)
Date:   Mon, 11 Jan 2021 15:50:29 +0100
From:   Jan Kara <jack@suse.cz>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        Theodore Ts'o <tytso@mit.edu>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 03/12] fs: only specify I_DIRTY_TIME when needed in
 generic_update_time()
Message-ID: <20210111145029.GB18475@quack2.suse.cz>
References: <20210109075903.208222-1-ebiggers@kernel.org>
 <20210109075903.208222-4-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210109075903.208222-4-ebiggers@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 08-01-21 23:58:54, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> generic_update_time() always passes I_DIRTY_TIME to
> __mark_inode_dirty(), which doesn't really make sense because (a)
> generic_update_time() might be asked to do only an i_version update, not
> also a timestamps update; and (b) I_DIRTY_TIME is only supposed to be
> set in i_state if the filesystem has lazytime enabled, so using it
> unconditionally in generic_update_time() is inconsistent.
> 
> As a result there is a weird edge case where if only an i_version update
> was requested (not also a timestamps update) but it is no longer needed
> (i.e. inode_maybe_inc_iversion() returns false), then I_DIRTY_TIME will
> be set in i_state even if the filesystem isn't mounted with lazytime.
> 
> Fix this by only passing I_DIRTY_TIME to __mark_inode_dirty() if the
> timestamps were updated and the filesystem has lazytime enabled.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza


> ---
>  fs/inode.c | 38 ++++++++++++++++++++------------------
>  1 file changed, 20 insertions(+), 18 deletions(-)
> 
> diff --git a/fs/inode.c b/fs/inode.c
> index 6442d97d9a4ab..d0fa43d8e9d5c 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -1743,24 +1743,26 @@ static int relatime_need_update(struct vfsmount *mnt, struct inode *inode,
>  
>  int generic_update_time(struct inode *inode, struct timespec64 *time, int flags)
>  {
> -	int iflags = I_DIRTY_TIME;
> -	bool dirty = false;
> -
> -	if (flags & S_ATIME)
> -		inode->i_atime = *time;
> -	if (flags & S_VERSION)
> -		dirty = inode_maybe_inc_iversion(inode, false);
> -	if (flags & S_CTIME)
> -		inode->i_ctime = *time;
> -	if (flags & S_MTIME)
> -		inode->i_mtime = *time;
> -	if ((flags & (S_ATIME | S_CTIME | S_MTIME)) &&
> -	    !(inode->i_sb->s_flags & SB_LAZYTIME))
> -		dirty = true;
> -
> -	if (dirty)
> -		iflags |= I_DIRTY_SYNC;
> -	__mark_inode_dirty(inode, iflags);
> +	int dirty_flags = 0;
> +
> +	if (flags & (S_ATIME | S_CTIME | S_MTIME)) {
> +		if (flags & S_ATIME)
> +			inode->i_atime = *time;
> +		if (flags & S_CTIME)
> +			inode->i_ctime = *time;
> +		if (flags & S_MTIME)
> +			inode->i_mtime = *time;
> +
> +		if (inode->i_sb->s_flags & SB_LAZYTIME)
> +			dirty_flags |= I_DIRTY_TIME;
> +		else
> +			dirty_flags |= I_DIRTY_SYNC;
> +	}
> +
> +	if ((flags & S_VERSION) && inode_maybe_inc_iversion(inode, false))
> +		dirty_flags |= I_DIRTY_SYNC;
> +
> +	__mark_inode_dirty(inode, dirty_flags);
>  	return 0;
>  }
>  EXPORT_SYMBOL(generic_update_time);
> -- 
> 2.30.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
