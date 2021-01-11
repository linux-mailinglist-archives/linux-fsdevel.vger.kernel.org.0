Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DFDC2F18F6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Jan 2021 15:58:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388991AbhAKO5P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Jan 2021 09:57:15 -0500
Received: from mx2.suse.de ([195.135.220.15]:39526 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727750AbhAKO5P (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Jan 2021 09:57:15 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C1EF4AD1E;
        Mon, 11 Jan 2021 14:56:33 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 967771E0807; Mon, 11 Jan 2021 15:56:33 +0100 (CET)
Date:   Mon, 11 Jan 2021 15:56:33 +0100
From:   Jan Kara <jack@suse.cz>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        Theodore Ts'o <tytso@mit.edu>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 06/12] fs: pass only I_DIRTY_INODE flags to
 ->dirty_inode
Message-ID: <20210111145633.GE18475@quack2.suse.cz>
References: <20210109075903.208222-1-ebiggers@kernel.org>
 <20210109075903.208222-7-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210109075903.208222-7-ebiggers@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 08-01-21 23:58:57, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> ->dirty_inode is now only called when I_DIRTY_INODE (I_DIRTY_SYNC and/or
> I_DIRTY_DATASYNC) is set.  However it may still be passed other dirty
> flags at the same time, provided that these other flags happened to be
> passed to __mark_inode_dirty() at the same time as I_DIRTY_INODE.
> 
> This doesn't make sense because there is no reason for filesystems to
> care about these extra flags.  Nor are filesystems notified about all
> updates to these other flags.
> 
> Therefore, mask the flags before passing them to ->dirty_inode.
> 
> Also properly document ->dirty_inode in vfs.rst.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza 

> ---
>  Documentation/filesystems/vfs.rst | 5 ++++-
>  fs/fs-writeback.c                 | 2 +-
>  2 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
> index ca52c82e5bb54..287b80948a40b 100644
> --- a/Documentation/filesystems/vfs.rst
> +++ b/Documentation/filesystems/vfs.rst
> @@ -270,7 +270,10 @@ or bottom half).
>  	->alloc_inode.
>  
>  ``dirty_inode``
> -	this method is called by the VFS to mark an inode dirty.
> +	this method is called by the VFS when an inode is marked dirty.
> +	This is specifically for the inode itself being marked dirty,
> +	not its data.  If the update needs to be persisted by fdatasync(),
> +	then I_DIRTY_DATASYNC will be set in the flags argument.
>  
>  ``write_inode``
>  	this method is called when the VFS needs to write an inode to
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index b7616bbd55336..2e6064012f7d3 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -2259,7 +2259,7 @@ void __mark_inode_dirty(struct inode *inode, int flags)
>  		trace_writeback_dirty_inode_start(inode, flags);
>  
>  		if (sb->s_op->dirty_inode)
> -			sb->s_op->dirty_inode(inode, flags);
> +			sb->s_op->dirty_inode(inode, flags & I_DIRTY_INODE);
>  
>  		trace_writeback_dirty_inode(inode, flags);
>  
> -- 
> 2.30.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
