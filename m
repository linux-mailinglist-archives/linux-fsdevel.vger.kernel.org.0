Return-Path: <linux-fsdevel+bounces-43157-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A759CA4EC3B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 19:46:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7507188E70E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 18:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 217AD207E09;
	Tue,  4 Mar 2025 18:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aRm8FIc4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793402E3397;
	Tue,  4 Mar 2025 18:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741113391; cv=none; b=baY+DpEef6wVf5YM6pGSQU+IRAoRD2Fehg5GadX30AGqGEJ2+K45u0ywZHQBikPD4ogbyjI1uWN+z8ZMbNi7wtnAD1gWhderEsyFc2ALKREe8WMLGr8deUXfFrxLn5w64YBewJZSYRtuc4PU8SQEPt2ZLbt6RCmKAbn2Tt6D6Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741113391; c=relaxed/simple;
	bh=YFAjSFcxHKSK09jHDmexez6pBBSG3imyFyu/hbpWRug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DlF5QJdIoQqTHB2Yq/MJmc7IrCIoS+1Cb8oyEX783NC9Zc6s5FDPP8uJiY8ZtXrQT+1QezrjknZZGQo7yh+hOABCC6QvMPo65I/ZPc4a6yIKsDP8kW4PvMxqo/8qs0+aN0TxisF9bWJI3HFxwFMrfQWycFa+pPuNltZ6k2wU/QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aRm8FIc4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59030C4CEE5;
	Tue,  4 Mar 2025 18:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741113390;
	bh=YFAjSFcxHKSK09jHDmexez6pBBSG3imyFyu/hbpWRug=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aRm8FIc4TyTPTOmROjMxwIazcNLGryQbJy956hAtFn5WpaZp33cYXDGERv3Lsn4Wo
	 Sjz9KlvFz5gXvWXRFnwClIFTVZFSb62lNfxadIb2RgjVHuaHaPznG3BwbeDUoP9Pxs
	 2OfddvgJyb/aDwIvLoLXiwPuue95k9vToweJJp+YBZX2FbgpAlHmmq5/0FWRBSFjeu
	 eIJajbB7vTZ30GvBQYr4y0rN4hvvFYfUiRMR6FhNC9LJdeFT13dfIVx5+BdontJbgh
	 GjXtVr7CDIDTWSrMnr46zNF6AhuKDWBKdx1Cjp6HFnGryMRFoBiW1Zh6ImNVC2UMTM
	 HJVUi1wuqX2OA==
Date: Tue, 4 Mar 2025 19:36:24 +0100
From: Alexey Gladkov <legion@kernel.org>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Swapnil Sapkal <swapnil.sapkal@amd.com>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jan Kara <jack@suse.cz>, Mateusz Guzik <mjguzik@gmail.com>,
	Manfred Spraul <manfred@colorfullife.com>,
	David Howells <dhowells@redhat.com>,
	WangYuli <wangyuli@uniontech.com>, Hillf Danton <hdanton@sina.com>,
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>,
	Neeraj.Upadhyay@amd.com, Ananth.narayan@amd.com
Subject: Re: [PATCH] fs/pipe: Read pipe->{head,tail} atomically outside
 pipe->mutex
Message-ID: <Z8dIKGCSRWqUqAEI@example.org>
References: <CAHk-=wiA-7pdaQm2nV0iv-fihyhWX-=KjZwQTHNKoDqid46F0w@mail.gmail.com>
 <20250304135138.1278-1-kprateek.nayak@amd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304135138.1278-1-kprateek.nayak@amd.com>

On Tue, Mar 04, 2025 at 01:51:38PM +0000, K Prateek Nayak wrote:
> From: Linus Torvalds <torvalds@linux-foundation.org>
> 
> pipe_readable(), pipe_writable(), and pipe_poll() can read "pipe->head"
> and "pipe->tail" outside of "pipe->mutex" critical section. When the
> head and the tail are read individually in that order, there is a window
> for interruption between the two reads in which both the head and the
> tail can be updated by concurrent readers and writers.
> 
> One of the problematic scenarios observed with hackbench running
> multiple groups on a large server on a particular pipe inode is as
> follows:
> 
>     pipe->head = 36
>     pipe->tail = 36
> 
>     hackbench-118762  [057] .....  1029.550548: pipe_write: *wakes up: pipe not full*
>     hackbench-118762  [057] .....  1029.550548: pipe_write: head: 36 -> 37 [tail: 36]
>     hackbench-118762  [057] .....  1029.550548: pipe_write: *wake up next reader 118740*
>     hackbench-118762  [057] .....  1029.550548: pipe_write: *wake up next writer 118768*
> 
>     hackbench-118768  [206] .....  1029.55055X: pipe_write: *writer wakes up*
>     hackbench-118768  [206] .....  1029.55055X: pipe_write: head = READ_ONCE(pipe->head) [37]
>     ... CPU 206 interrupted (exact wakeup was not traced but 118768 did read head at 37 in traces)
> 
>     hackbench-118740  [057] .....  1029.550558: pipe_read:  *reader wakes up: pipe is not empty*
>     hackbench-118740  [057] .....  1029.550558: pipe_read:  tail: 36 -> 37 [head = 37]
>     hackbench-118740  [057] .....  1029.550559: pipe_read:  *pipe is empty; wakeup writer 118768*
>     hackbench-118740  [057] .....  1029.550559: pipe_read:  *sleeps*
> 
>     hackbench-118766  [185] .....  1029.550592: pipe_write: *New writer comes in*
>     hackbench-118766  [185] .....  1029.550592: pipe_write: head: 37 -> 38 [tail: 37]
>     hackbench-118766  [185] .....  1029.550592: pipe_write: *wakes up reader 118766*
> 
>     hackbench-118740  [185] .....  1029.550598: pipe_read:  *reader wakes up; pipe not empty*
>     hackbench-118740  [185] .....  1029.550599: pipe_read:  tail: 37 -> 38 [head: 38]
>     hackbench-118740  [185] .....  1029.550599: pipe_read:  *pipe is empty*
>     hackbench-118740  [185] .....  1029.550599: pipe_read:  *reader sleeps; wakeup writer 118768*
> 
>     ... CPU 206 switches back to writer
>     hackbench-118768  [206] .....  1029.550601: pipe_write: tail = READ_ONCE(pipe->tail) [38]
>     hackbench-118768  [206] .....  1029.550601: pipe_write: pipe_full()? (u32)(37 - 38) >= 16? Yes
>     hackbench-118768  [206] .....  1029.550601: pipe_write: *writer goes back to sleep*
> 
>     [ Tasks 118740 and 118768 can then indefinitely wait on each other. ]
> 
> The unsigned arithmetic in pipe_occupancy() wraps around when
> "pipe->tail > pipe->head" leading to pipe_full() returning true despite
> the pipe being empty.
> 
> The case of genuine wraparound of "pipe->head" is handled since pipe
> buffer has data allowing readers to make progress until the pipe->tail
> wraps too after which the reader will wakeup a sleeping writer, however,
> mistaking the pipe to be full when it is in fact empty can lead to
> readers and writers waiting on each other indefinitely.
> 
> This issue became more problematic and surfaced as a hang in hackbench
> after the optimization in commit aaec5a95d596 ("pipe_read: don't wake up
> the writer if the pipe is still full") significantly reduced the number
> of spurious wakeups of writers that had previously helped mask the
> issue.
> 
> To avoid missing any updates between the reads of "pipe->head" and
> "pipe->write", unionize the two with a single unsigned long
> "pipe->head_tail" member that can be loaded atomically.
> 
> Using "pipe->head_tail" to read the head and the tail ensures the
> lockless checks do not miss any updates to the head or the tail and
> since those two are only updated under "pipe->mutex", it ensures that
> the head is always ahead of, or equal to the tail resulting in correct
> calculations.
> 
>   [ prateek: commit log, testing on x86 platforms. ]
> 
> Reported-and-debugged-by: Swapnil Sapkal <swapnil.sapkal@amd.com>
> Closes: https://lore.kernel.org/lkml/e813814e-7094-4673-bc69-731af065a0eb@amd.com/
> Reported-by: Alexey Gladkov <legion@kernel.org>
> Closes: https://lore.kernel.org/all/Z8Wn0nTvevLRG_4m@example.org/
> Fixes: 8cefc107ca54 ("pipe: Use head and tail pointers for the ring, not cursor and length")
> Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> Tested-by: Swapnil Sapkal <swapnil.sapkal@amd.com>
> Reviewed-by: Oleg Nesterov <oleg@redhat.com>
> Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>

With this patch, I'm also not reproducing the problem. Thanks!

> ---
> Changes are based on:
> 
>   git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs-6.15.pipe
> 
> at commit commit ee5eda8ea595 ("pipe: change pipe_write() to never add a
> zero-sized buffer") but also applies cleanly on top of v6.14-rc5.
> 
> The diff from Linus is kept as is except for removing the whitespaces in
> front of the typedef that checkpatch complained about (the warning on
> usage of typedef itself has been ignored since I could not think of a
> better alternative other than #ifdef hackery in pipe_inode_info and the
> newly introduced pipe_index union.) and the suggestion from Oleg to
> explicitly initialize the "head_tail" with:
> 
>     union pipe_index idx = { .head_tail = READ_ONCE(pipe->head_tail) }
> 
> I went with commit 8cefc107ca54 ("pipe: Use head and tail pointers for
> the ring, not cursor and length") for the "Fixes:" tag since pipe_poll()
> added:
> 
>     unsigned int head = READ_ONCE(pipe->head);
>     unsigned int tail = READ_ONCE(pipe->tail);
> 
>     poll_wait(filp, &pipe->wait, wait);
> 
>     BUG_ON(pipe_occupancy(head, tail) > pipe->ring_size);
> 
> and the race described can trigger that BUG_ON() but as Linus pointed
> out in [1] the commit 85190d15f4ea ("pipe: don't use 'pipe_wait() for
> basic pipe IO") is probably the one that can cause the writers to
> sleep on empty pipe since the pipe_wait() used prior did not drop the
> pipe lock until it called schedule() and prepare_to_wait() was called
> before pipe_unlock() ensuring no races.
> 
> [1] https://lore.kernel.org/all/CAHk-=wh804HX8H86VRUSKoJGVG0eBe8sPz8=E3d8LHftOCSqwQ@mail.gmail.com/
> 
> Please let me know if the patch requires any modifications and I'll jump
> right on it. The changes have been tested on both a 5th Generation AMD
> EPYC system and on a dual socket Intel Emerald Rapids system with
> multiple thousand iterations of hackbench for small and large loop
> counts. Thanks a ton to Swapnil for all the help.
> ---
>  fs/pipe.c                 | 19 ++++++++-----------
>  include/linux/pipe_fs_i.h | 39 +++++++++++++++++++++++++++++++++++++--
>  2 files changed, 45 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/pipe.c b/fs/pipe.c
> index b0641f75b1ba..780990f307ab 100644
> --- a/fs/pipe.c
> +++ b/fs/pipe.c
> @@ -210,11 +210,10 @@ static const struct pipe_buf_operations anon_pipe_buf_ops = {
>  /* Done while waiting without holding the pipe lock - thus the READ_ONCE() */
>  static inline bool pipe_readable(const struct pipe_inode_info *pipe)
>  {
> -	unsigned int head = READ_ONCE(pipe->head);
> -	unsigned int tail = READ_ONCE(pipe->tail);
> +	union pipe_index idx = { .head_tail = READ_ONCE(pipe->head_tail) };
>  	unsigned int writers = READ_ONCE(pipe->writers);
>  
> -	return !pipe_empty(head, tail) || !writers;
> +	return !pipe_empty(idx.head, idx.tail) || !writers;
>  }
>  
>  static inline unsigned int pipe_update_tail(struct pipe_inode_info *pipe,
> @@ -403,11 +402,10 @@ static inline int is_packetized(struct file *file)
>  /* Done while waiting without holding the pipe lock - thus the READ_ONCE() */
>  static inline bool pipe_writable(const struct pipe_inode_info *pipe)
>  {
> -	unsigned int head = READ_ONCE(pipe->head);
> -	unsigned int tail = READ_ONCE(pipe->tail);
> +	union pipe_index idx = { .head_tail = READ_ONCE(pipe->head_tail) };
>  	unsigned int max_usage = READ_ONCE(pipe->max_usage);
>  
> -	return !pipe_full(head, tail, max_usage) ||
> +	return !pipe_full(idx.head, idx.tail, max_usage) ||
>  		!READ_ONCE(pipe->readers);
>  }
>  
> @@ -649,7 +647,7 @@ pipe_poll(struct file *filp, poll_table *wait)
>  {
>  	__poll_t mask;
>  	struct pipe_inode_info *pipe = filp->private_data;
> -	unsigned int head, tail;
> +	union pipe_index idx;
>  
>  	/* Epoll has some historical nasty semantics, this enables them */
>  	WRITE_ONCE(pipe->poll_usage, true);
> @@ -670,19 +668,18 @@ pipe_poll(struct file *filp, poll_table *wait)
>  	 * if something changes and you got it wrong, the poll
>  	 * table entry will wake you up and fix it.
>  	 */
> -	head = READ_ONCE(pipe->head);
> -	tail = READ_ONCE(pipe->tail);
> +	idx.head_tail = READ_ONCE(pipe->head_tail);
>  
>  	mask = 0;
>  	if (filp->f_mode & FMODE_READ) {
> -		if (!pipe_empty(head, tail))
> +		if (!pipe_empty(idx.head, idx.tail))
>  			mask |= EPOLLIN | EPOLLRDNORM;
>  		if (!pipe->writers && filp->f_pipe != pipe->w_counter)
>  			mask |= EPOLLHUP;
>  	}
>  
>  	if (filp->f_mode & FMODE_WRITE) {
> -		if (!pipe_full(head, tail, pipe->max_usage))
> +		if (!pipe_full(idx.head, idx.tail, pipe->max_usage))
>  			mask |= EPOLLOUT | EPOLLWRNORM;
>  		/*
>  		 * Most Unices do not set EPOLLERR for FIFOs but on Linux they
> diff --git a/include/linux/pipe_fs_i.h b/include/linux/pipe_fs_i.h
> index 8ff23bf5a819..3cc4f8eab853 100644
> --- a/include/linux/pipe_fs_i.h
> +++ b/include/linux/pipe_fs_i.h
> @@ -31,6 +31,33 @@ struct pipe_buffer {
>  	unsigned long private;
>  };
>  
> +/*
> + * Really only alpha needs 32-bit fields, but
> + * might as well do it for 64-bit architectures
> + * since that's what we've historically done,
> + * and it makes 'head_tail' always be a simple
> + * 'unsigned long'.
> + */
> +#ifdef CONFIG_64BIT
> +typedef unsigned int pipe_index_t;
> +#else
> +typedef unsigned short pipe_index_t;
> +#endif
> +
> +/*
> + * We have to declare this outside 'struct pipe_inode_info',
> + * but then we can't use 'union pipe_index' for an anonymous
> + * union, so we end up having to duplicate this declaration
> + * below. Annoying.
> + */
> +union pipe_index {
> +	unsigned long head_tail;
> +	struct {
> +		pipe_index_t head;
> +		pipe_index_t tail;
> +	};
> +};
> +
>  /**
>   *	struct pipe_inode_info - a linux kernel pipe
>   *	@mutex: mutex protecting the whole thing
> @@ -58,8 +85,16 @@ struct pipe_buffer {
>  struct pipe_inode_info {
>  	struct mutex mutex;
>  	wait_queue_head_t rd_wait, wr_wait;
> -	unsigned int head;
> -	unsigned int tail;
> +
> +	/* This has to match the 'union pipe_index' above */
> +	union {
> +		unsigned long head_tail;
> +		struct {
> +			pipe_index_t head;
> +			pipe_index_t tail;
> +		};
> +	};
> +
>  	unsigned int max_usage;
>  	unsigned int ring_size;
>  	unsigned int nr_accounted;
> 
> base-commit: ee5eda8ea59546af2e8f192c060fbf29862d7cbd
> -- 
> 2.34.1
> 

-- 
Rgrds, legion


