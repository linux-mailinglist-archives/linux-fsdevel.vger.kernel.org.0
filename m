Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A41F65C566
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jan 2023 18:52:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232749AbjACRwE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Jan 2023 12:52:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233708AbjACRvf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Jan 2023 12:51:35 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AF856478;
        Tue,  3 Jan 2023 09:51:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6KPmKYkuGVQMb0p1rk1GNvc5vMpOMWKvDUXMCioA3/Y=; b=JwEXgEl0uy8Ssgd6MRHNx2hS49
        W0+Bo53pHu8HUzMJkL5PoTG7EhJu5GG0qXmoYtwpJhhBUMBEt9l8cbHdU4c/wzzlHQtccHtpqwKTm
        Psi2SvnxlQ7VrvIRPUOtOCR5c9GbxgCBBaob4uEv4k+O/bP8zdl9kKcnPzg527H6Nu5PjViej5Fpw
        O4PQ4XOuVotdosde+cM3CEs0rv/4MZ3Liq+2iXq1eQq8zzgnOGqFFrxCuqxbn39yLs0oQP623zhk5
        +JgL0ue2bdxr1hlTJwoLmh0XjqYujnaBlfesYuZAQuK9wE53xkfI1SzNd2x9esdq4XO5O/PPmLr4J
        lBY4Pd3Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pClRY-00EIjp-F2; Tue, 03 Jan 2023 17:51:20 +0000
Date:   Tue, 3 Jan 2023 17:51:20 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Hongchen Zhang <zhanghongchen@loongson.cn>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kuniyuki Iwashima <kuniyu@amazon.co.jp>,
        Luis Chamberlain <mcgrof@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Randy Dunlap <rdunlap@infradead.org>,
        Eric Dumazet <edumazet@google.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] pipe: use __pipe_{lock,unlock} instead of spinlock
Message-ID: <Y7RrGOE65XKkzJuz@casper.infradead.org>
References: <20230103063303.23345-1-zhanghongchen@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230103063303.23345-1-zhanghongchen@loongson.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 03, 2023 at 02:33:03PM +0800, Hongchen Zhang wrote:
> Use spinlock in pipe_read/write cost too much time,IMO

Everybody has an opinion.  Do you have data?

> pipe->{head,tail} can be protected by __pipe_{lock,unlock}.
> On the other hand, we can use __pipe_lock/unlock to protect the
> pipe->head/tail in pipe_resize_ring and post_one_notification.
> 
> Signed-off-by: Hongchen Zhang <zhanghongchen@loongson.cn>
> ---

you're supposed to write here what changes you made between v1 and v2.

>  fs/pipe.c                 | 24 ++++--------------------
>  include/linux/pipe_fs_i.h | 12 ++++++++++++
>  kernel/watch_queue.c      |  8 ++++----
>  3 files changed, 20 insertions(+), 24 deletions(-)
> 
> diff --git a/fs/pipe.c b/fs/pipe.c
> index 42c7ff41c2db..cf449779bf71 100644
> --- a/fs/pipe.c
> +++ b/fs/pipe.c
> @@ -98,16 +98,6 @@ void pipe_unlock(struct pipe_inode_info *pipe)
>  }
>  EXPORT_SYMBOL(pipe_unlock);
>  
> -static inline void __pipe_lock(struct pipe_inode_info *pipe)
> -{
> -	mutex_lock_nested(&pipe->mutex, I_MUTEX_PARENT);
> -}
> -
> -static inline void __pipe_unlock(struct pipe_inode_info *pipe)
> -{
> -	mutex_unlock(&pipe->mutex);
> -}
> -
>  void pipe_double_lock(struct pipe_inode_info *pipe1,
>  		      struct pipe_inode_info *pipe2)
>  {
> @@ -253,8 +243,7 @@ pipe_read(struct kiocb *iocb, struct iov_iter *to)
>  	 */
>  	was_full = pipe_full(pipe->head, pipe->tail, pipe->max_usage);
>  	for (;;) {
> -		/* Read ->head with a barrier vs post_one_notification() */
> -		unsigned int head = smp_load_acquire(&pipe->head);
> +		unsigned int head = pipe->head;
>  		unsigned int tail = pipe->tail;
>  		unsigned int mask = pipe->ring_size - 1;
>  
> @@ -322,14 +311,12 @@ pipe_read(struct kiocb *iocb, struct iov_iter *to)
>  
>  			if (!buf->len) {
>  				pipe_buf_release(pipe, buf);
> -				spin_lock_irq(&pipe->rd_wait.lock);
>  #ifdef CONFIG_WATCH_QUEUE
>  				if (buf->flags & PIPE_BUF_FLAG_LOSS)
>  					pipe->note_loss = true;
>  #endif
>  				tail++;
>  				pipe->tail = tail;
> -				spin_unlock_irq(&pipe->rd_wait.lock);
>  			}
>  			total_len -= chars;
>  			if (!total_len)
> @@ -506,16 +493,13 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
>  			 * it, either the reader will consume it or it'll still
>  			 * be there for the next write.
>  			 */
> -			spin_lock_irq(&pipe->rd_wait.lock);
>  
>  			head = pipe->head;
>  			if (pipe_full(head, pipe->tail, pipe->max_usage)) {
> -				spin_unlock_irq(&pipe->rd_wait.lock);
>  				continue;
>  			}
>  
>  			pipe->head = head + 1;
> -			spin_unlock_irq(&pipe->rd_wait.lock);
>  
>  			/* Insert it into the buffer array */
>  			buf = &pipe->bufs[head & mask];
> @@ -1260,14 +1244,14 @@ int pipe_resize_ring(struct pipe_inode_info *pipe, unsigned int nr_slots)
>  	if (unlikely(!bufs))
>  		return -ENOMEM;
>  
> -	spin_lock_irq(&pipe->rd_wait.lock);
> +	__pipe_lock(pipe);
>  	mask = pipe->ring_size - 1;
>  	head = pipe->head;
>  	tail = pipe->tail;
>  
>  	n = pipe_occupancy(head, tail);
>  	if (nr_slots < n) {
> -		spin_unlock_irq(&pipe->rd_wait.lock);
> +		__pipe_unlock(pipe);
>  		kfree(bufs);
>  		return -EBUSY;
>  	}
> @@ -1303,7 +1287,7 @@ int pipe_resize_ring(struct pipe_inode_info *pipe, unsigned int nr_slots)
>  	pipe->tail = tail;
>  	pipe->head = head;
>  
> -	spin_unlock_irq(&pipe->rd_wait.lock);
> +	__pipe_unlock(pipe);
>  
>  	/* This might have made more room for writers */
>  	wake_up_interruptible(&pipe->wr_wait);
> diff --git a/include/linux/pipe_fs_i.h b/include/linux/pipe_fs_i.h
> index 6cb65df3e3ba..f5084daf6eaf 100644
> --- a/include/linux/pipe_fs_i.h
> +++ b/include/linux/pipe_fs_i.h
> @@ -2,6 +2,8 @@
>  #ifndef _LINUX_PIPE_FS_I_H
>  #define _LINUX_PIPE_FS_I_H
>  
> +#include <linux/fs.h>
> +
>  #define PIPE_DEF_BUFFERS	16
>  
>  #define PIPE_BUF_FLAG_LRU	0x01	/* page is on the LRU */
> @@ -223,6 +225,16 @@ static inline void pipe_discard_from(struct pipe_inode_info *pipe,
>  #define PIPE_SIZE		PAGE_SIZE
>  
>  /* Pipe lock and unlock operations */
> +static inline void __pipe_lock(struct pipe_inode_info *pipe)
> +{
> +	mutex_lock_nested(&pipe->mutex, I_MUTEX_PARENT);
> +}
> +
> +static inline void __pipe_unlock(struct pipe_inode_info *pipe)
> +{
> +	mutex_unlock(&pipe->mutex);
> +}
> +
>  void pipe_lock(struct pipe_inode_info *);
>  void pipe_unlock(struct pipe_inode_info *);
>  void pipe_double_lock(struct pipe_inode_info *, struct pipe_inode_info *);
> diff --git a/kernel/watch_queue.c b/kernel/watch_queue.c
> index a6f9bdd956c3..92e46cfe9419 100644
> --- a/kernel/watch_queue.c
> +++ b/kernel/watch_queue.c
> @@ -108,7 +108,7 @@ static bool post_one_notification(struct watch_queue *wqueue,
>  	if (!pipe)
>  		return false;
>  
> -	spin_lock_irq(&pipe->rd_wait.lock);
> +	__pipe_lock(pipe);
>  
>  	mask = pipe->ring_size - 1;
>  	head = pipe->head;
> @@ -135,17 +135,17 @@ static bool post_one_notification(struct watch_queue *wqueue,
>  	buf->offset = offset;
>  	buf->len = len;
>  	buf->flags = PIPE_BUF_FLAG_WHOLE;
> -	smp_store_release(&pipe->head, head + 1); /* vs pipe_read() */
> +	pipe->head = head + 1;
>  
>  	if (!test_and_clear_bit(note, wqueue->notes_bitmap)) {
> -		spin_unlock_irq(&pipe->rd_wait.lock);
> +		__pipe_unlock(pipe);
>  		BUG();
>  	}
>  	wake_up_interruptible_sync_poll_locked(&pipe->rd_wait, EPOLLIN | EPOLLRDNORM);
>  	done = true;
>  
>  out:
> -	spin_unlock_irq(&pipe->rd_wait.lock);
> +	__pipe_unlock(pipe);
>  	if (done)
>  		kill_fasync(&pipe->fasync_readers, SIGIO, POLL_IN);
>  	return done;
> 
> base-commit: c8451c141e07a8d05693f6c8d0e418fbb4b68bb7
> -- 
> 2.31.1
> 
