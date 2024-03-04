Return-Path: <linux-fsdevel+bounces-13494-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 748CC8707F3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 18:05:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AD601F2352C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 17:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E2FD5FDCB;
	Mon,  4 Mar 2024 17:05:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from kanga.kvack.org (kanga.kvack.org [205.233.56.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D28265F578;
	Mon,  4 Mar 2024 17:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.233.56.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709571905; cv=none; b=fsg8ueFK6BrQQ3cpW3jisO+MM46aIms3a924PgfVAyI8/XHo/7l22COPLzT/Y+9J98tlFRJFXIREy4BMqxW8l9RMutg5aM2fvr5ZjqJqpTdjaijr3Qs4y0huvDQle4Y0VfpV6tUhlIWDpl63yjQwMM5kS/xYW98uxZWPSQJV28g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709571905; c=relaxed/simple;
	bh=GykyLOySktTcdnN5xj9tScvKWkrbQcuU5PotoD4BMPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Mime-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XoyPemB64Qv01PkzFcqBCOR+q0oBNeaiVO4RoVcm3ewPQTjvXbg6kf3mAdPCjjADvmQEgNcas4IWjw/IHIAQFFkHmxzOJVCm4Cs9RZMEv47T1AiykyZmhBBfEKiv1aAErnbe29VY1E/XnuH75ByPwq6OjWggnOlmuOuhW+zre48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=communityfibre.ca; spf=pass smtp.mailfrom=communityfibre.ca; arc=none smtp.client-ip=205.233.56.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=communityfibre.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=communityfibre.ca
Received: by kanga.kvack.org (Postfix, from userid 63042)
	id 09E296B0080; Mon,  4 Mar 2024 12:03:43 -0500 (EST)
Date: Mon, 4 Mar 2024 12:03:43 -0500
From: Benjamin LaHaise <ben@communityfibre.ca>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Edward Adam Davis <eadavis@qq.com>,
	syzbot+b91eb2ed18f599dd3c31@syzkaller.appspotmail.com,
	brauner@kernel.org, jack@suse.cz, linux-aio@kvack.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Subject: Re: [PATCH] fs/aio: fix uaf in sys_io_cancel
Message-ID: <20240304170343.GO20455@kvack.org>
References: <0000000000006945730612bc9173@google.com> <tencent_DC4C9767C786D2D2FDC64F099FAEFDEEC106@qq.com> <14f85d0c-8303-4710-b8b1-248ce27a6e1f@acm.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14f85d0c-8303-4710-b8b1-248ce27a6e1f@acm.org>
User-Agent: Mutt/1.4.2.2i

On Mon, Mar 04, 2024 at 08:15:15AM -0800, Bart Van Assche wrote:
> On 3/3/24 04:21, Edward Adam Davis wrote:
> >The aio poll work aio_poll_complete_work() need to be synchronized with 
> >syscall
> >io_cancel(). Otherwise, when poll work executes first, syscall may access 
> >the
> >released aio_kiocb object.
> >
> >Fixes: 54cbc058d86b ("fs/aio: Make io_cancel() generate completions again")
> >Reported-and-tested-by: 
> >syzbot+b91eb2ed18f599dd3c31@syzkaller.appspotmail.com
> >Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> >---
> >  fs/aio.c | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> >
> >diff --git a/fs/aio.c b/fs/aio.c
> >index 28223f511931..0fed22ed9eb8 100644
> >--- a/fs/aio.c
> >+++ b/fs/aio.c
> >@@ -1762,9 +1762,8 @@ static void aio_poll_complete_work(struct 
> >work_struct *work)
> >  	} /* else, POLLFREE has freed the waitqueue, so we must complete */
> >  	list_del_init(&iocb->ki_list);
> >  	iocb->ki_res.res = mangle_poll(mask);
> >-	spin_unlock_irq(&ctx->ctx_lock);
> >-
> >  	iocb_put(iocb);
> >+	spin_unlock_irq(&ctx->ctx_lock);
> >  }
> >  
> >  /* assumes we are called with irqs disabled */
> >@@ -2198,7 +2197,6 @@ SYSCALL_DEFINE3(io_cancel, aio_context_t, ctx_id, 
> >struct iocb __user *, iocb,
> >  			break;
> >  		}
> >  	}
> >-	spin_unlock_irq(&ctx->ctx_lock);
> >  
> >  	/*
> >  	 * The result argument is no longer used - the io_event is always
> >@@ -2206,6 +2204,7 @@ SYSCALL_DEFINE3(io_cancel, aio_context_t, ctx_id, 
> >struct iocb __user *, iocb,
> >  	 */
> >  	if (ret == 0 && kiocb->rw.ki_flags & IOCB_AIO_RW)
> >  		aio_complete_rw(&kiocb->rw, -EINTR);
> >+	spin_unlock_irq(&ctx->ctx_lock);
> >  
> >  	percpu_ref_put(&ctx->users);

This is just so wrong there aren't even words to describe it.  I
recommending reverting all of Bart's patches since they were not reviewed
by anyone with a sufficient level of familiarity with fs/aio.c to get it
right.

		-ben

> I'm not enthusiast about the above patch because it increases the amount
> of code executed with the ctx_lock held. Wouldn't something like the
> untested patch below be a better solution?
> 
> Thanks,
> 
> Bart.
> 
> 
> diff --git a/fs/aio.c b/fs/aio.c
> index 28223f511931..c6fb10321e48 100644
> --- a/fs/aio.c
> +++ b/fs/aio.c
> @@ -2177,6 +2177,7 @@ SYSCALL_DEFINE3(io_cancel, aio_context_t, ctx_id, 
> struct iocb __user *, iocb,
>  	struct kioctx *ctx;
>  	struct aio_kiocb *kiocb;
>  	int ret = -EINVAL;
> +	bool is_cancelled_rw = false;
>  	u32 key;
>  	u64 obj = (u64)(unsigned long)iocb;
> 
> @@ -2193,6 +2194,7 @@ SYSCALL_DEFINE3(io_cancel, aio_context_t, ctx_id, 
> struct iocb __user *, iocb,
>  	/* TODO: use a hash or array, this sucks. */
>  	list_for_each_entry(kiocb, &ctx->active_reqs, ki_list) {
>  		if (kiocb->ki_res.obj == obj) {
> +			is_cancelled_rw = kiocb->rw.ki_flags & IOCB_AIO_RW;
>  			ret = kiocb->ki_cancel(&kiocb->rw);
>  			list_del_init(&kiocb->ki_list);
>  			break;
> @@ -2204,7 +2206,7 @@ SYSCALL_DEFINE3(io_cancel, aio_context_t, ctx_id, 
> struct iocb __user *, iocb,
>  	 * The result argument is no longer used - the io_event is always
>  	 * delivered via the ring buffer.
>  	 */
> -	if (ret == 0 && kiocb->rw.ki_flags & IOCB_AIO_RW)
> +	if (ret == 0 && is_cancelled_rw)
>  		aio_complete_rw(&kiocb->rw, -EINTR);
> 
>  	percpu_ref_put(&ctx->users);
> 
> 

-- 
"Thought is the essence of where you are now."

