Return-Path: <linux-fsdevel+bounces-58771-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 001DFB3161B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 13:08:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9962D1D029B3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 11:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49D1C2E92C6;
	Fri, 22 Aug 2025 11:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MJmBvEoX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D3420330;
	Fri, 22 Aug 2025 11:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755860891; cv=none; b=Dq2EWQLMBUMp0xEcx3J5ddkfFzVTGUyAI2S2R9PiLNxercV24iKJ09j027o+J4cxy8o9hCfyHD76igHVbGaUGQ6icSqlGV/EYiPnRxN5QcPUpPIqIU7PYceo8cDI4DlXjQWvILFSV+wGP3xFO07/0exTmCgS0/SYNuKlJFA6J8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755860891; c=relaxed/simple;
	bh=AGlpMmC5hFjO+G2P1kCw42ZzRLVCyBl0jY9K/8ptXkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e+dUAMATXiMVB4CHlcw9U90J0B8yJios1moljK5rDoLecWUUgLh/EtUFpDPXxJB4oedtxX391d+zihrD+j1mF75nzSHNQy6QucbuF+en/u1R6VkkBtE/AZotSpXQvl7qGkPtlUANEctse24BctXaR0DZwlKyY1eYQmmaKz04RL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MJmBvEoX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71A14C4CEED;
	Fri, 22 Aug 2025 11:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755860891;
	bh=AGlpMmC5hFjO+G2P1kCw42ZzRLVCyBl0jY9K/8ptXkU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MJmBvEoXfECrXz87V7e6tBeiJoR5/oWf9ORdwDL8Z4ZJpm1k4nNLb9tjL3DLc/KSH
	 zI4upUTn2lutdSKFnPosWFFkf/gP/AMoap70z9QxJB4j5BX5ss0rGaDx0dEDPTIMSG
	 3ioKWqlO5A7+xU70tG20Wba8jX4aY3qOt9Q4EBc8MriMU9ju7AzJtLrscAnv3Jur1j
	 VfMZkrLnRUpOnLfns8lo8eBhEV1siey5JT6pwj5fssmRBCx7pkFSnKJqeSXg2UfJNv
	 Bph3k217DOoHLP7CsWeGgDWrWJnbcXWIsDaKFHRtVXac9a5B5vTD31Wq6fdQmErjGh
	 9YKbMxuYlul4w==
Date: Fri, 22 Aug 2025 13:08:07 +0200
From: Christian Brauner <brauner@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	kernel-team@fb.com, linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, 
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH 02/50] fs: make the i_state flags an enum
Message-ID: <20250822-orcas-bemannten-728c9946b160@brauner>
References: <cover.1755806649.git.josef@toxicpanda.com>
 <02211105388c53dc68b7f4332f9b5649d5b66b71.1755806649.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <02211105388c53dc68b7f4332f9b5649d5b66b71.1755806649.git.josef@toxicpanda.com>

On Thu, Aug 21, 2025 at 04:18:13PM -0400, Josef Bacik wrote:
> Adjusting i_state flags always means updating the values manually. Bring
> these forward into the 2020's and make a nice clean macro for defining
> the i_state values as an enum, providing __ variants for the cases where
> we need the bit position instead of the actual value, and leaving the
> actual NAME as the 1U << bit value.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  include/linux/fs.h | 234 +++++++++++++++++++++++----------------------
>  1 file changed, 122 insertions(+), 112 deletions(-)
> 
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 9a1ce67eed33..e741dc453c2c 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -665,6 +665,127 @@ is_uncached_acl(struct posix_acl *acl)
>  #define IOP_MGTIME	0x0020
>  #define IOP_CACHED_LINK	0x0040
>  
> +/*
> + * Inode state bits.  Protected by inode->i_lock
> + *
> + * Four bits determine the dirty state of the inode: I_DIRTY_SYNC,
> + * I_DIRTY_DATASYNC, I_DIRTY_PAGES, and I_DIRTY_TIME.
> + *
> + * Four bits define the lifetime of an inode.  Initially, inodes are I_NEW,
> + * until that flag is cleared.  I_WILL_FREE, I_FREEING and I_CLEAR are set at
> + * various stages of removing an inode.
> + *
> + * Two bits are used for locking and completion notification, I_NEW and I_SYNC.
> + *
> + * I_DIRTY_SYNC		Inode is dirty, but doesn't have to be written on
> + *			fdatasync() (unless I_DIRTY_DATASYNC is also set).
> + *			Timestamp updates are the usual cause.
> + * I_DIRTY_DATASYNC	Data-related inode changes pending.  We keep track of
> + *			these changes separately from I_DIRTY_SYNC so that we
> + *			don't have to write inode on fdatasync() when only
> + *			e.g. the timestamps have changed.
> + * I_DIRTY_PAGES	Inode has dirty pages.  Inode itself may be clean.
> + * I_DIRTY_TIME		The inode itself has dirty timestamps, and the
> + *			lazytime mount option is enabled.  We keep track of this
> + *			separately from I_DIRTY_SYNC in order to implement
> + *			lazytime.  This gets cleared if I_DIRTY_INODE
> + *			(I_DIRTY_SYNC and/or I_DIRTY_DATASYNC) gets set. But
> + *			I_DIRTY_TIME can still be set if I_DIRTY_SYNC is already
> + *			in place because writeback might already be in progress
> + *			and we don't want to lose the time update
> + * I_NEW		Serves as both a mutex and completion notification.
> + *			New inodes set I_NEW.  If two processes both create
> + *			the same inode, one of them will release its inode and
> + *			wait for I_NEW to be released before returning.
> + *			Inodes in I_WILL_FREE, I_FREEING or I_CLEAR state can
> + *			also cause waiting on I_NEW, without I_NEW actually
> + *			being set.  find_inode() uses this to prevent returning
> + *			nearly-dead inodes.
> + * I_WILL_FREE		Must be set when calling write_inode_now() if i_count
> + *			is zero.  I_FREEING must be set when I_WILL_FREE is
> + *			cleared.
> + * I_FREEING		Set when inode is about to be freed but still has dirty
> + *			pages or buffers attached or the inode itself is still
> + *			dirty.
> + * I_CLEAR		Added by clear_inode().  In this state the inode is
> + *			clean and can be destroyed.  Inode keeps I_FREEING.
> + *
> + *			Inodes that are I_WILL_FREE, I_FREEING or I_CLEAR are
> + *			prohibited for many purposes.  iget() must wait for
> + *			the inode to be completely released, then create it
> + *			anew.  Other functions will just ignore such inodes,
> + *			if appropriate.  I_NEW is used for waiting.
> + *
> + * I_SYNC		Writeback of inode is running. The bit is set during
> + *			data writeback, and cleared with a wakeup on the bit
> + *			address once it is done. The bit is also used to pin
> + *			the inode in memory for flusher thread.
> + *
> + * I_REFERENCED		Marks the inode as recently references on the LRU list.
> + *
> + * I_WB_SWITCH		Cgroup bdi_writeback switching in progress.  Used to
> + *			synchronize competing switching instances and to tell
> + *			wb stat updates to grab the i_pages lock.  See
> + *			inode_switch_wbs_work_fn() for details.
> + *
> + * I_OVL_INUSE		Used by overlayfs to get exclusive ownership on upper
> + *			and work dirs among overlayfs mounts.
> + *
> + * I_CREATING		New object's inode in the middle of setting up.
> + *
> + * I_DONTCACHE		Evict inode as soon as it is not used anymore.
> + *
> + * I_SYNC_QUEUED	Inode is queued in b_io or b_more_io writeback lists.
> + *			Used to detect that mark_inode_dirty() should not move
> + *			inode between dirty lists.
> + *
> + * I_PINNING_FSCACHE_WB	Inode is pinning an fscache object for writeback.
> + *
> + * I_LRU_ISOLATING	Inode is pinned being isolated from LRU without holding
> + *			i_count.
> + *
> + * Q: What is the difference between I_WILL_FREE and I_FREEING?
> + *
> + * __I_{SYNC,NEW,LRU_ISOLATING} are used to derive unique addresses to wait
> + * upon. There's one free address left.
> + */
> +
> +/*
> + * As simple macro to define the inode state bits, __NAME will be the bit value
> + * (0, 1, 2, ...), and NAME will be the bit mask (1U << __NAME). The __NAME_SEQ
> + * is used to reset the sequence number so the next name gets the next bit value
> + * in the sequence.
> + */
> +#define INODE_BIT(name)			\
> +	__ ## name,			\
> +	name = (1U << __ ## name),	\
> +	__ ## name ## _SEQ = __ ## name

I'm not sure if this is the future we want :D
I think it's harder to parse than what we have now.

> +
> +enum inode_state_bits {
> +	INODE_BIT(I_NEW),
> +	INODE_BIT(I_SYNC),
> +	INODE_BIT(I_LRU_ISOLATING),
> +	INODE_BIT(I_DIRTY_SYNC),
> +	INODE_BIT(I_DIRTY_DATASYNC),
> +	INODE_BIT(I_DIRTY_PAGES),
> +	INODE_BIT(I_WILL_FREE),
> +	INODE_BIT(I_FREEING),
> +	INODE_BIT(I_CLEAR),
> +	INODE_BIT(I_REFERENCED),
> +	INODE_BIT(I_LINKABLE),
> +	INODE_BIT(I_DIRTY_TIME),
> +	INODE_BIT(I_WB_SWITCH),
> +	INODE_BIT(I_OVL_INUSE),
> +	INODE_BIT(I_CREATING),
> +	INODE_BIT(I_DONTCACHE),
> +	INODE_BIT(I_SYNC_QUEUED),
> +	INODE_BIT(I_PINNING_NETFS_WB),
> +};

Good idea but I really dislike this macro indirection.
Can't we just do the really boring?

enum inode_state_bits {
	__I_BIT_NEW		= 0U
	__I_BIT_SYNC		= 1U
	__I_BIT_LRU_ISOLATING	= 2U
}

enum inode_state_flags_t {
	I_NEW			= (1U << __I_BIT_NEW)
	I_SYNC			= (1U << __I_BIT_SYNC)
	I_LRU_ISOLATING		= (1U << __I_BIT_LRU_ISOLATING)
	I_DIRTY_SYNC		= (1U << 3)
	I_DIRTY_DATASYNC	= (1U << 4)
	I_DIRTY_PAGES		= (1U << 5)
	I_WILL_FREE		= (1U << 6)
	I_FREEING		= (1U << 7)
	I_CLEAR			= (1U << 8)
	I_REFERENCED		= (1U << 9)
	I_LINKABLE		= (1U << 10)
	I_DIRTY_TIME		= (1U << 11)
	I_WB_SWITCH		= (1U << 12)
	I_OVL_INUSE		= (1U << 13)
	I_CREATING		= (1U << 14)
	I_DONTCACHE		= (1U << 15)
	I_SYNC_QUEUED		= (1U << 16)
	I_PINNING_NETFS_WB	= (1U << 17)
};

Note that inode_state_wait_address() and that only works on four bits so
we can't really use higher bits anyway without switching back to a
scheme where we have to use unsigned long and waste for bytes for
nothing on 64 bit.

With that out of the way,

Reviewed-by: Christian Brauner <brauner@kernel.org>

> +#define I_DIRTY_INODE (I_DIRTY_SYNC | I_DIRTY_DATASYNC)
> +#define I_DIRTY (I_DIRTY_INODE | I_DIRTY_PAGES)
> +#define I_DIRTY_ALL (I_DIRTY | I_DIRTY_TIME)
> +
>  /*
>   * Keep mostly read-only and often accessed (especially for
>   * the RCU path lookup and 'stat' data) fields at the beginning
> @@ -723,7 +844,7 @@ struct inode {
>  #endif
>  
>  	/* Misc */
> -	u32			i_state;
> +	enum inode_state_bits	i_state;
>  	/* 32-bit hole */
>  	struct rw_semaphore	i_rwsem;
>  
> @@ -2484,117 +2605,6 @@ static inline void kiocb_clone(struct kiocb *kiocb, struct kiocb *kiocb_src,
>  	};
>  }
>  
> -/*
> - * Inode state bits.  Protected by inode->i_lock
> - *
> - * Four bits determine the dirty state of the inode: I_DIRTY_SYNC,
> - * I_DIRTY_DATASYNC, I_DIRTY_PAGES, and I_DIRTY_TIME.
> - *
> - * Four bits define the lifetime of an inode.  Initially, inodes are I_NEW,
> - * until that flag is cleared.  I_WILL_FREE, I_FREEING and I_CLEAR are set at
> - * various stages of removing an inode.
> - *
> - * Two bits are used for locking and completion notification, I_NEW and I_SYNC.
> - *
> - * I_DIRTY_SYNC		Inode is dirty, but doesn't have to be written on
> - *			fdatasync() (unless I_DIRTY_DATASYNC is also set).
> - *			Timestamp updates are the usual cause.
> - * I_DIRTY_DATASYNC	Data-related inode changes pending.  We keep track of
> - *			these changes separately from I_DIRTY_SYNC so that we
> - *			don't have to write inode on fdatasync() when only
> - *			e.g. the timestamps have changed.
> - * I_DIRTY_PAGES	Inode has dirty pages.  Inode itself may be clean.
> - * I_DIRTY_TIME		The inode itself has dirty timestamps, and the
> - *			lazytime mount option is enabled.  We keep track of this
> - *			separately from I_DIRTY_SYNC in order to implement
> - *			lazytime.  This gets cleared if I_DIRTY_INODE
> - *			(I_DIRTY_SYNC and/or I_DIRTY_DATASYNC) gets set. But
> - *			I_DIRTY_TIME can still be set if I_DIRTY_SYNC is already
> - *			in place because writeback might already be in progress
> - *			and we don't want to lose the time update
> - * I_NEW		Serves as both a mutex and completion notification.
> - *			New inodes set I_NEW.  If two processes both create
> - *			the same inode, one of them will release its inode and
> - *			wait for I_NEW to be released before returning.
> - *			Inodes in I_WILL_FREE, I_FREEING or I_CLEAR state can
> - *			also cause waiting on I_NEW, without I_NEW actually
> - *			being set.  find_inode() uses this to prevent returning
> - *			nearly-dead inodes.
> - * I_WILL_FREE		Must be set when calling write_inode_now() if i_count
> - *			is zero.  I_FREEING must be set when I_WILL_FREE is
> - *			cleared.
> - * I_FREEING		Set when inode is about to be freed but still has dirty
> - *			pages or buffers attached or the inode itself is still
> - *			dirty.
> - * I_CLEAR		Added by clear_inode().  In this state the inode is
> - *			clean and can be destroyed.  Inode keeps I_FREEING.
> - *
> - *			Inodes that are I_WILL_FREE, I_FREEING or I_CLEAR are
> - *			prohibited for many purposes.  iget() must wait for
> - *			the inode to be completely released, then create it
> - *			anew.  Other functions will just ignore such inodes,
> - *			if appropriate.  I_NEW is used for waiting.
> - *
> - * I_SYNC		Writeback of inode is running. The bit is set during
> - *			data writeback, and cleared with a wakeup on the bit
> - *			address once it is done. The bit is also used to pin
> - *			the inode in memory for flusher thread.
> - *
> - * I_REFERENCED		Marks the inode as recently references on the LRU list.
> - *
> - * I_WB_SWITCH		Cgroup bdi_writeback switching in progress.  Used to
> - *			synchronize competing switching instances and to tell
> - *			wb stat updates to grab the i_pages lock.  See
> - *			inode_switch_wbs_work_fn() for details.
> - *
> - * I_OVL_INUSE		Used by overlayfs to get exclusive ownership on upper
> - *			and work dirs among overlayfs mounts.
> - *
> - * I_CREATING		New object's inode in the middle of setting up.
> - *
> - * I_DONTCACHE		Evict inode as soon as it is not used anymore.
> - *
> - * I_SYNC_QUEUED	Inode is queued in b_io or b_more_io writeback lists.
> - *			Used to detect that mark_inode_dirty() should not move
> - * 			inode between dirty lists.
> - *
> - * I_PINNING_FSCACHE_WB	Inode is pinning an fscache object for writeback.
> - *
> - * I_LRU_ISOLATING	Inode is pinned being isolated from LRU without holding
> - *			i_count.
> - *
> - * Q: What is the difference between I_WILL_FREE and I_FREEING?
> - *
> - * __I_{SYNC,NEW,LRU_ISOLATING} are used to derive unique addresses to wait
> - * upon. There's one free address left.
> - */
> -#define __I_NEW			0
> -#define I_NEW			(1 << __I_NEW)
> -#define __I_SYNC		1
> -#define I_SYNC			(1 << __I_SYNC)
> -#define __I_LRU_ISOLATING	2
> -#define I_LRU_ISOLATING		(1 << __I_LRU_ISOLATING)
> -
> -#define I_DIRTY_SYNC		(1 << 3)
> -#define I_DIRTY_DATASYNC	(1 << 4)
> -#define I_DIRTY_PAGES		(1 << 5)
> -#define I_WILL_FREE		(1 << 6)
> -#define I_FREEING		(1 << 7)
> -#define I_CLEAR			(1 << 8)
> -#define I_REFERENCED		(1 << 9)
> -#define I_LINKABLE		(1 << 10)
> -#define I_DIRTY_TIME		(1 << 11)
> -#define I_WB_SWITCH		(1 << 12)
> -#define I_OVL_INUSE		(1 << 13)
> -#define I_CREATING		(1 << 14)
> -#define I_DONTCACHE		(1 << 15)
> -#define I_SYNC_QUEUED		(1 << 16)
> -#define I_PINNING_NETFS_WB	(1 << 17)
> -
> -#define I_DIRTY_INODE (I_DIRTY_SYNC | I_DIRTY_DATASYNC)
> -#define I_DIRTY (I_DIRTY_INODE | I_DIRTY_PAGES)
> -#define I_DIRTY_ALL (I_DIRTY | I_DIRTY_TIME)
> -
>  extern void __mark_inode_dirty(struct inode *, int);
>  static inline void mark_inode_dirty(struct inode *inode)
>  {
> -- 
> 2.49.0
> 

