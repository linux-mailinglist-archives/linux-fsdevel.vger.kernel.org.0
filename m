Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F393B3099
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Sep 2019 16:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731782AbfIOO7M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 15 Sep 2019 10:59:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:37780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726278AbfIOO7M (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 15 Sep 2019 10:59:12 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 996F520650;
        Sun, 15 Sep 2019 14:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568559550;
        bh=eUQAxrahCh1DmNEfUt4p7VrcE9y8mI9Wncke58vJ3XU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0XVEvftYsEuJbZl5S656bIcIZ+CZNp9Iv+mumjmeZOfRJaNJ1hmsK5Kmlk8NeM+NM
         PMZJ6enCcKDHQgYGUGbQh4tYwDs//574VuUsfG2TU007BWB140uCwgI+Pq4kP2lW0l
         j1TJXKNXAkfUF3JcdQvFw4fUQxql7fYj6zMuY3tg=
Date:   Sun, 15 Sep 2019 15:59:06 +0100
From:   Will Deacon <will@kernel.org>
To:     David Howells <dhowells@redhat.com>
Cc:     torvalds@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, peterz@infradead.org
Subject: Re: [RFC][PATCH] pipe: Convert ring to head/tail
Message-ID: <20190915145905.hd5xkc7uzulqhtzr@willie-the-truck>
References: <25289.1568379639@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25289.1568379639@warthog.procyon.org.uk>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi David, [+Peter]

I have a few drive-by comments on the ordering side of things. See below.

On Fri, Sep 13, 2019 at 02:00:39PM +0100, David Howells wrote:
> Convert pipes to use head and tail pointers for the buffer ring rather than
> pointer and length as the latter requires two atomic ops to update (or a
> combined op) whereas the former only requires one.
> 
>  (1) The head pointer is the point at which production occurs and points to
>      the slot in which the next buffer will be placed.  This is equivalent
>      to pipe->curbuf + pipe->nrbufs.
> 
>      The head pointer belongs to the write-side.
> 
>  (2) The tail pointer is the point at which consumption occurs.  It points
>      to the next slot to be consumed.  This is equivalent to pipe->curbuf.
> 
>      The tail pointer belongs to the read-side.
> 
>  (3) head and tail are allowed to run to UINT_MAX and wrap naturally.  They
>      are only masked off when the array is being accessed, e.g.:
> 
>         pipe->bufs[head & mask]
> 
>      This means that it is not necessary to have a dead slot in the ring as
>      head == tail isn't ambiguous.
> 
>  (4) The ring is empty if head == tail.
> 
>  (5) The occupancy of the ring is head - tail.
> 
>  (6) The amount of space in the ring is (tail + pipe->buffers) - head.
> 
>  (7) The ring is full if head == (tail + pipe->buffers) or
>      head - tail == pipe->buffers.
> 
> Barriers are also inserted, wrapped in inline functions:
> 
>  (1) unsigned int tail = pipe_get_tail_for_write(pipe);
> 
>      Read the tail pointer from the write-side.  This acts as a barrier to
>      order the tail read before the data in the ring is overwritten.  It
>      also prevents the compiler from re-reading the pointer.
> 
>  (2) unsigned int head = pipe_get_head_for_read(pipe);
> 
>      Read the head pointer from the read-side.  This acts as a barrier to
>      order the head read before the data read.  It also prevents the
>      compiler from re-reading the pointer.
> 
>  (3) pipe_post_read_barrier(pipe, unsigned int tail);
> 
>      Update the tail pointer from the read-side.  This acts as a barrier to
>      order the pointer update after the data read.  The consumed data slot
>      must not be touched after this function.
> 
>  (4) pipe_post_write_barrier(pipe, unsigned int head);
> 
>      Update the head pointer from the write-side.  This acts as a barrier
>      to order the pointer update after the data write.  The produced data
>      slot should not normally be touched after this function[*].
> 
>      [*] Unless pipe->mutex is held.
> ---
>  fs/fuse/dev.c             |   23 ++-
>  fs/pipe.c                 |  154 ++++++++++++++++----------
>  fs/splice.c               |  161 +++++++++++++++++----------
>  include/linux/pipe_fs_i.h |   76 ++++++++++++-
>  include/linux/uio.h       |    4 
>  lib/iov_iter.c            |  268 ++++++++++++++++++++++++++--------------------
>  6 files changed, 438 insertions(+), 248 deletions(-)

[...]

> diff --git a/fs/pipe.c b/fs/pipe.c
> index 8a2ab2f974bd..aa410ee0f423 100644
> --- a/fs/pipe.c
> +++ b/fs/pipe.c
> @@ -43,10 +43,10 @@ unsigned long pipe_user_pages_hard;
>  unsigned long pipe_user_pages_soft = PIPE_DEF_BUFFERS * INR_OPEN_CUR;
>  
>  /*
> - * We use a start+len construction, which provides full use of the 
> + * We use a start+len construction, which provides full use of the
>   * allocated memory.
>   * -- Florian Coosmann (FGC)
> - * 
> + *
>   * Reads with count = 0 should always return 0.
>   * -- Julian Bradfield 1999-06-07.
>   *
> @@ -285,10 +285,15 @@ pipe_read(struct kiocb *iocb, struct iov_iter *to)
>  	ret = 0;
>  	__pipe_lock(pipe);
>  	for (;;) {
> -		int bufs = pipe->nrbufs;
> -		if (bufs) {
> -			int curbuf = pipe->curbuf;
> -			struct pipe_buffer *buf = pipe->bufs + curbuf;
> +		/* Barrier: head belongs to the write side, so order reading
> +		 * the data after reading the head pointer.
> +		 */
> +		unsigned int head = READ_ONCE(pipe->head);

Hmm, I don't understand this. Since READ_ONCE() doesn't imply a barrier,
how are you enforcing the read-read ordering in the CPU?

> @@ -104,6 +104,76 @@ struct pipe_buf_operations {
>  	bool (*get)(struct pipe_inode_info *, struct pipe_buffer *);
>  };
>  
> +/**
> + * pipe_get_tail_for_write - Get pipe buffer tail pointer for write-side use
> + * @pipe: The pipe in question
> + *
> + * Get the tail pointer for use in the write-side code.  This may need to
> + * insert a barrier against the reader to order reading the tail pointer
> + * against the reader reading the buffer.

What is the purpose of saying "This may need to insert a barrier"? Can this
function be overridden or something?

> + */
> +static inline unsigned int pipe_get_tail_for_write(struct pipe_inode_info *pipe)
> +{
> +	return READ_ONCE(pipe->tail);
> +}
> +
> +/**
> + * pipe_post_read_barrier - Set pipe buffer tail pointer in the read-side
> + * @pipe: The pipe in question
> + * @tail: The new tail pointer
> + *
> + * Update the tail pointer in the read-side code.  This inserts a barrier
> + * against the writer such that the data write is ordered before the tail
> + * pointer update.
> + */
> +static inline void pipe_post_read_barrier(struct pipe_inode_info *pipe,
> +					  unsigned int tail)
> +{
> +	smp_store_release(&pipe->tail, tail);
> +}
> +
> +/**
> + * pipe_get_head_for_read - Get pipe buffer head pointer for read-side use
> + * @pipe: The pipe in question
> + *
> + * Get the head pointer for use in the read-side code.  This inserts a barrier
> + * against the reader such that the head pointer is read before the data it
> + * points to.
> + */
> +static inline unsigned int pipe_get_head_for_read(struct pipe_inode_info *pipe)
> +{
> +	return READ_ONCE(pipe->head);
> +}

Saying that "This inserts a barrier" feels misleading, because READ_ONCE()
doesn't do that.

Will
