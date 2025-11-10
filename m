Return-Path: <linux-fsdevel+bounces-67643-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6BD1C45994
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 10:21:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6798B1890F28
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 09:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC862FF142;
	Mon, 10 Nov 2025 09:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1AHZDA0H";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QiNo9/Vx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87F34503B;
	Mon, 10 Nov 2025 09:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762766488; cv=none; b=tDhwtLNcT4rL7eAA96rwi1y1W6PZ8QoWnomD/4lXf8ihEv/pD8MIvzXFfvRi5ujHRr1V2TqjfDre8fkQKIxwN172o2ql8n1XdzWxzvm/yTR/1aT7hwhZvYjt55OLSWADFz4G98n7eKYpWZcjsJ/nCiDb2Ps19NgXp/N7NmcyIQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762766488; c=relaxed/simple;
	bh=UOXTFfctU+la1ZRGJ4ND5QM9NGb52PYcz12HWAlPtNs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PlMmdlb89hgstkxnQoptphjMd1yjukT5DKgF9+MgUmeH7QW87z43a57AhjMYevduMZSymEWVI1qd0IZoD0bM8/yhjrxhL9/E8eO1KfoetOEaWXMDM66bApn16FcexAFo1MTYQXqMfGl0ctS0ryzh+Hf2pL942M885y1dKpvUga0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1AHZDA0H; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QiNo9/Vx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762766484;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RH6y8AqWM02HDoXJucHQCnZ4iL8GJPZpMZrh3/buiXE=;
	b=1AHZDA0HjqDPADvCENpUEaCHCNu3clHUkAhrYHRZAj7SW8m1mWA4wwXhAxsXw9/Ypg1aql
	vC7+kpyBmfER8wn/9KvNWQO0rFSRZOGMYBF5W4dT/qMSeMaSYplCZNTCNz0Q0tmiyWSwf8
	3eqib3Jl7Vyed1Y2axixqLpWDLkSTmSXKns6RLZH/tcZQ0Pcl/heCNj7aj2vqUyV3Ul8um
	x5R7NCNT0RMZOgOxP/3EFZEU3YEKVcWTm3SG6iieA52kOiPXDyRMNWrmv78i6BSGx5WxjP
	QHs0P7xNmwUNPBEJfU6QLUlz8jMi83kpf/Q85gxF85GBgNspEwPIESQlc7M7Hg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762766484;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RH6y8AqWM02HDoXJucHQCnZ4iL8GJPZpMZrh3/buiXE=;
	b=QiNo9/Vx7XmkYNoF4Q7UPAO9m0J/JXMYstBDyeujKvFPQREVnnJ7dGQTsIZRrGya3/NmnR
	1nHl/bwTSAplPFDw==
To: Petr Mladek <pmladek@suse.com>
Cc: Joanne Koong <joannelkoong@gmail.com>, "amurray @ thegoodpenguin . co .
 uk" <amurray@thegoodpenguin.co.uk>, brauner@kernel.org, chao@kernel.org,
 djwong@kernel.org, jaegeuk@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
 syzkaller-bugs@googlegroups.com, Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH 2/2] printk_ringbuffer: Create a helper function to
 decide whether a more space is needed
In-Reply-To: <20251107194720.1231457-3-pmladek@suse.com>
References: <20251107194720.1231457-1-pmladek@suse.com>
 <20251107194720.1231457-3-pmladek@suse.com>
Date: Mon, 10 Nov 2025 10:27:23 +0106
Message-ID: <87jyzyutt8.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Petr,

Nit: For the patch subject, remove the word "a":

"Create a helper function to decide whether more space is needed"

More below...

On 2025-11-07, Petr Mladek <pmladek@suse.com> wrote:
> The decision whether some more space is needed is tricky in the printk
> ring buffer code:
>
>   1. The given lpos values might overflow. A subtraction must be used
>      instead of a simple "lower than" check.
>
>   2. Another CPU might reuse the space in the mean time. It can be
>      detected when the subtraction is bigger than DATA_SIZE(data_ring).
>
>   3. There is exactly enough space when the result of the subtraction
>      is zero. But more space is needed when the result is exactly
>      DATA_SIZE(data_ring).
>
> Add a helper function to make sure that the check is done correctly
> in all situations. Also it helps to make the code consistent and
> better documented.
>
> Suggested-by: John Ogness <john.ogness@linutronix.de>
> Link: https://lore.kernel.org/r/87tsz7iea2.fsf@jogness.linutronix.de
> Signed-off-by: Petr Mladek <pmladek@suse.com>
> ---
>  kernel/printk/printk_ringbuffer.c | 31 +++++++++++++++++++++++++++----
>  1 file changed, 27 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
> index 3e6fd8d6fa9f..ede3039dd041 100644
> --- a/kernel/printk/printk_ringbuffer.c
> +++ b/kernel/printk/printk_ringbuffer.c
> @@ -411,6 +411,23 @@ static bool data_check_size(struct prb_data_ring *data_ring, unsigned int size)
>  	return to_blk_size(size) <= DATA_SIZE(data_ring) / 2;
>  }
>  
> +/*
> + * Compare the current and requested logical position and decide
> + * whether more space needed.
> + *
> + * Return false when @lpos_current is already at or beyond @lpos_target.
> + *
> + * Also return false when the difference between the positions is bigger
> + * than the size of the data buffer. It might happen only when the caller
> + * raced with another CPU(s) which already made and used the space.
> + */
> +static bool need_more_space(struct prb_data_ring *data_ring,
> +			    unsigned long lpos_current,
> +			    unsigned long lpos_target)
> +{
> +	return lpos_target - lpos_current - 1 < DATA_SIZE(data_ring);
> +}
> +
>  /* Query the state of a descriptor. */
>  static enum desc_state get_desc_state(unsigned long id,
>  				      unsigned long state_val)
> @@ -577,7 +594,7 @@ static bool data_make_reusable(struct printk_ringbuffer *rb,
>  	unsigned long id;
>  
>  	/* Loop until @lpos_begin has advanced to or beyond @lpos_end. */
> -	while ((lpos_end - lpos_begin) - 1 < DATA_SIZE(data_ring)) {
> +	while (need_more_space(data_ring, lpos_begin, lpos_end)) {
>  		blk = to_block(data_ring, lpos_begin);
>  
>  		/*
> @@ -668,7 +685,7 @@ static bool data_push_tail(struct printk_ringbuffer *rb, unsigned long lpos)
>  	 * sees the new tail lpos, any descriptor states that transitioned to
>  	 * the reusable state must already be visible.
>  	 */
> -	while ((lpos - tail_lpos) - 1 < DATA_SIZE(data_ring)) {
> +	while (need_more_space(data_ring, tail_lpos, lpos)) {
>  		/*
>  		 * Make all descriptors reusable that are associated with
>  		 * data blocks before @lpos.
> @@ -1148,8 +1165,14 @@ static char *data_realloc(struct printk_ringbuffer *rb, unsigned int size,
>  
>  	next_lpos = get_next_lpos(data_ring, blk_lpos->begin, size);
>  
> -	/* If the data block does not increase, there is nothing to do. */
> -	if (head_lpos - next_lpos < DATA_SIZE(data_ring)) {
> +	/*
> +	 * Use the current data block when the size does not increase.

I would like to expand the above sentence so that it is a bit clearer
how it relates to the new check. Perhaps:

	 * Use the current data block when the size does not increase, i.e.
	 * when @head_lpos is already able to accommodate the new @next_lpos.

> +	 *
> +	 * Note that need_more_space() could never return false here because
> +	 * the difference between the positions was bigger than the data
> +	 * buffer size. The data block is reopened and can't get reused.
> +	 */
> +	if (!need_more_space(data_ring, head_lpos, next_lpos)) {
>  		if (wrapped)
>  			blk = to_block(data_ring, 0);
>  		else
> -- 
> 2.51.1

Otherwise, LGTM. Thanks for choosing a name that presents contextual
purpose rather than simply function.

Reviewed-by: John Ogness <john.ogness@linutronix.de>

