Return-Path: <linux-fsdevel+bounces-26201-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4AF6955A6A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Aug 2024 01:49:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 999811C20B8F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Aug 2024 23:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1770D149E0E;
	Sat, 17 Aug 2024 23:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="xGQlNaEo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31D21386C6
	for <linux-fsdevel@vger.kernel.org>; Sat, 17 Aug 2024 23:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723938534; cv=none; b=iF10UrUTgrVKarnEZ3VACwewWQTseca1y2871ZoRr20wIG54S0XW+IiZpFSgnTZ9eZuW0yUTfjmfg9bmdSu7/cKqAuVx9ogxAvMnZex6Mgk5qh1SEjZcqkAm6krA5M7ZBfSxBXN4eeyXam7XHH5wKyCdGU/3uSACq9NuUKeFGW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723938534; c=relaxed/simple;
	bh=mbL+L0e2AoPptu0ObIaXYVLg0yzs4+RcWDy7cN6xZhM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q8ATvxKcDiHqOufLpoZJnSH7CHK2GpdmWUzwHRZDhoxWn9LqwkGb4ODfFIIdFZ7JyEJYS72bO3N2Sl3EZGbZCe4cAKBBkir3QbHMEfCY8XARPtKldxJnrJ/e9CEBy2Y5T57UzpLnjuu6i9gRW4V+u6fi67Oem/KtbxPMFg6qW2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=xGQlNaEo; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2d3bc043e81so2381262a91.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 17 Aug 2024 16:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1723938532; x=1724543332; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BlFAXsufWUif/wALfqhIK0BJVDOth+Or1PfYrEwhaSU=;
        b=xGQlNaEoSvQq6txvcYgWrQttFBUWIKe2lgdV00NO5dH/3Y92qOT8pWGZNCppGH4KWF
         /QSZW14fDG9E7Res2iQVdmOaGNkbJOirRQUg2XVSaa2YUDYFuRAod+6qCp6aTLoapDDW
         BVhq3+F/sfMn6eCdUnWCfCyL2iNm7waAQJiV0m5Dm0jE2WMcjfrob7PYfJdtLq2pnzh+
         pPU4mPEg8Rs8+AXKg6zleYgrus7l9QUNysxZ/vuOo87Y82Xfs9Hg1/PeNiRLmevr7Y4m
         EAAbJ8amU8mTQkABlaEAnX79G8zilm5XmTkOCeIgdj+YvNp/2fv+fSCZuYo620rswNmp
         5TRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723938532; x=1724543332;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BlFAXsufWUif/wALfqhIK0BJVDOth+Or1PfYrEwhaSU=;
        b=hWY0Q7/eYJABL6Sr6BPRta/AuIt25rq6+ltI4D+GtM0dZasMZNA6UGhi4NXEI8VUok
         zzCkHZrwlUpWO1XAYLnOFp0F+fV9vM40PABznCfyRX88MYO3EJ85kUqG1DlbKXuD7ceQ
         65ImbOnLzmT4q+S1MeloKMcGJqhasymq4cWlyJ11atqbtSM3qWBqt1cLPZ05ZhINnkhQ
         ofHVH/PbrLdxRewkClYSvh3DQ+1r8ObF4LmbVjKPyPAqXXruP0u5NzagPBslix/QOyMX
         /MLddNOOUc66OtWVGMwp3cAea7UQ6fNo6DRhVTEwj3kpDHjaAfmL1RZrsf+CWrdxDyPh
         oKZQ==
X-Gm-Message-State: AOJu0YycKi+8ISQnPmKhI8phD3mipWGCH9Rx2XI/DgtY7LsJmWBsnrQY
	twv3X0z5I2zAnpZIvPY8L05OdMP419YzGk66QFZ4dAvMEr0WNetDUvJUVfQgze6gcxLBB/ATMpQ
	b
X-Google-Smtp-Source: AGHT+IFNmQd5LO6ZM6W946gea2ljZjnSthlbcCES6Su5Z1AF2+rFyTuQeYIjDuENv9TkIXKrAsBouQ==
X-Received: by 2002:a17:90b:4b47:b0:2ca:5a46:cbc8 with SMTP id 98e67ed59e1d1-2d3e00f01c2mr7798126a91.26.1723938531857;
        Sat, 17 Aug 2024 16:48:51 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-47-239.pa.nsw.optusnet.com.au. [49.181.47.239])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3ac7dcea1sm8291761a91.15.2024.08.17.16.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Aug 2024 16:48:51 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1sfTA8-003HqW-2v;
	Sun, 18 Aug 2024 09:48:48 +1000
Date: Sun, 18 Aug 2024 09:48:48 +1000
From: Dave Chinner <david@fromorbit.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>,
	David Howells <dhowells@redhat.com>,
	Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH] inode: remove __I_DIO_WAKEUP
Message-ID: <ZsE24KlMQUiekolM@dread.disaster.area>
References: <20240816-vfs-misc-dio-v1-1-80fe21a2c710@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240816-vfs-misc-dio-v1-1-80fe21a2c710@kernel.org>

On Fri, Aug 16, 2024 at 04:35:52PM +0200, Christian Brauner wrote:
> Afaict, we can just rely on inode->i_dio_count for waiting instead of
> this awkward indirection through __I_DIO_WAKEUP. This survives LTP dio
> and xfstests dio tests.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
> ---
>  fs/inode.c         | 23 +++++++++++------------
>  fs/netfs/locking.c | 18 +++---------------
>  include/linux/fs.h |  9 ++++-----
>  3 files changed, 18 insertions(+), 32 deletions(-)
> 
> diff --git a/fs/inode.c b/fs/inode.c
> index 7a4e27606fca..46bf05d826db 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -2465,18 +2465,12 @@ EXPORT_SYMBOL(inode_owner_or_capable);
>  /*
>   * Direct i/o helper functions
>   */
> -static void __inode_dio_wait(struct inode *inode)
> +bool inode_dio_finished(const struct inode *inode)
>  {
> -	wait_queue_head_t *wq = bit_waitqueue(&inode->i_state, __I_DIO_WAKEUP);
> -	DEFINE_WAIT_BIT(q, &inode->i_state, __I_DIO_WAKEUP);
> -
> -	do {
> -		prepare_to_wait(wq, &q.wq_entry, TASK_UNINTERRUPTIBLE);
> -		if (atomic_read(&inode->i_dio_count))
> -			schedule();
> -	} while (atomic_read(&inode->i_dio_count));
> -	finish_wait(wq, &q.wq_entry);
> +	smp_mb__before_atomic();
> +	return atomic_read(&inode->i_dio_count) == 0;
>  }
> +EXPORT_SYMBOL(inode_dio_finished);

What is the memory barrier here for?  i_dio_count is not a reference
count - there are no dependent inode object changes before/after it
changes that it needs to be ordered against, so I'm not sure what
the purpose of this memory barrier is supposed to be...

Memory barriers -always- need a comment describing the race
condition they are avoiding.

>  /**
>   * inode_dio_wait - wait for outstanding DIO requests to finish
> @@ -2490,11 +2484,16 @@ static void __inode_dio_wait(struct inode *inode)
>   */
>  void inode_dio_wait(struct inode *inode)
>  {
> -	if (atomic_read(&inode->i_dio_count))
> -		__inode_dio_wait(inode);
> +	wait_var_event(&inode->i_dio_count, inode_dio_finished);
>  }
>  EXPORT_SYMBOL(inode_dio_wait);
>  
> +void inode_dio_wait_interruptible(struct inode *inode)
> +{
> +	wait_var_event_interruptible(&inode->i_dio_count, inode_dio_finished);
> +}
> +EXPORT_SYMBOL(inode_dio_wait_interruptible);

Keep in mind that the prepare_to_wait() call inside
wait_var_event_interruptible() takes the waitqueue head lock before
checking the condition. This provides the necessary memory barriers
to prevent wait/wakeup races checking the inode_dio_finished()
state. Hence, AFAICT, no memory barriers are needed in
inode_dio_finished() at all....

>  /*
>   * inode_set_flags - atomically set some inode flags
>   *
> diff --git a/fs/netfs/locking.c b/fs/netfs/locking.c
> index 75dc52a49b3a..c2cfdda85230 100644
> --- a/fs/netfs/locking.c
> +++ b/fs/netfs/locking.c
> @@ -21,23 +21,11 @@
>   */
>  static int inode_dio_wait_interruptible(struct inode *inode)
>  {
> -	if (!atomic_read(&inode->i_dio_count))
> +	if (inode_dio_finished(inode))
>  		return 0;
>  
> -	wait_queue_head_t *wq = bit_waitqueue(&inode->i_state, __I_DIO_WAKEUP);
> -	DEFINE_WAIT_BIT(q, &inode->i_state, __I_DIO_WAKEUP);
> -
> -	for (;;) {
> -		prepare_to_wait(wq, &q.wq_entry, TASK_INTERRUPTIBLE);
> -		if (!atomic_read(&inode->i_dio_count))
> -			break;
> -		if (signal_pending(current))
> -			break;
> -		schedule();
> -	}
> -	finish_wait(wq, &q.wq_entry);
> -
> -	return atomic_read(&inode->i_dio_count) ? -ERESTARTSYS : 0;
> +	inode_dio_wait_interruptible(inode);
> +	return !inode_dio_finished(inode) ? -ERESTARTSYS : 0;

That looks broken. We have a private static function calling an
exported function of the same name. I suspect that this static
function needs to be named "netfs_dio_wait_interruptible()"....

> @@ -2413,8 +2411,6 @@ static inline void kiocb_clone(struct kiocb *kiocb, struct kiocb *kiocb_src,
>  #define __I_SYNC		7
>  #define I_SYNC			(1 << __I_SYNC)
>  #define I_REFERENCED		(1 << 8)
> -#define __I_DIO_WAKEUP		9
> -#define I_DIO_WAKEUP		(1 << __I_DIO_WAKEUP)
>  #define I_LINKABLE		(1 << 10)
>  #define I_DIRTY_TIME		(1 << 11)
>  #define I_WB_SWITCH		(1 << 13)
> @@ -3230,6 +3226,7 @@ static inline ssize_t blockdev_direct_IO(struct kiocb *iocb,
>  #endif
>  
>  void inode_dio_wait(struct inode *inode);
> +void inode_dio_wait_interruptible(struct inode *inode);
>  
>  /**
>   * inode_dio_begin - signal start of a direct I/O requests
> @@ -3241,6 +3238,7 @@ void inode_dio_wait(struct inode *inode);
>  static inline void inode_dio_begin(struct inode *inode)
>  {
>  	atomic_inc(&inode->i_dio_count);
> +	smp_mb__after_atomic();
>  }

Again I have no idea waht this barrier is doing. Why does this
operation need quasi-release semantics?

>  /**
> @@ -3252,8 +3250,9 @@ static inline void inode_dio_begin(struct inode *inode)
>   */
>  static inline void inode_dio_end(struct inode *inode)
>  {
> +	smp_mb__before_atomic();
>  	if (atomic_dec_and_test(&inode->i_dio_count))
> -		wake_up_bit(&inode->i_state, __I_DIO_WAKEUP);
> +		wake_up_var(&inode->i_dio_count);
>  }

atomic_dec_and_test() is a RMW atomic operation with a return value,
so has has fully ordered semanitcs according to
Documentation/atomic_t.txt:

	 - RMW operations that have a return value are fully ordered.
	[...]
	Fully ordered primitives are ordered against everything prior and everything
	subsequent. Therefore a fully ordered primitive is like having an smp_mb()
	before and an smp_mb() after the primitive.

So there's never a need for explicit barriers before/after an
atomic_dec_and_test() operation, right?

-Dave.
-- 
Dave Chinner
david@fromorbit.com

