Return-Path: <linux-fsdevel+bounces-25487-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B6A394C76B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2024 01:43:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC7141C2273E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 23:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B3C016132B;
	Thu,  8 Aug 2024 23:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S03zNtKc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B220955769;
	Thu,  8 Aug 2024 23:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723160603; cv=none; b=tdgxyfTJBgs8GlqzBEme6x7evnZgA6YfxMOCv/hW3HEOlNhJh74Zvs+zm0lz9iQZBWAyMVXOk91WnjIsGb1yr8AeY69xocs3RfZK3C441ps7imt6dtASFhCveBPGJr1LuJ2MiupzHZ2uYyXFePf2xnGP3GQ/vnWyvZXO5oTkgkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723160603; c=relaxed/simple;
	bh=szmQ5vC7k46sTule7+HKD0Xf4MQ4QMeqmvqTX/s0s2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YcxC2rOQLJ8ha8NUo3+z4Rv0TslCzIOq08GDMLNf8ESm7ri5v8vrf1eqJZQ3uM/2L+Elv6EX/NEFufu7m3UAnrA9yvEie6hD6kc76HP5cFvRcNj9FcFCmMFVRxU6S2ZXcNeuicpxA78k7ltfHY4rjYD+s2JFKva55vKCUvGETX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S03zNtKc; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2f149845d81so17036061fa.0;
        Thu, 08 Aug 2024 16:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723160600; x=1723765400; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0exwGleVPp3zy85HvQnGK2Nbqg6sOajMWkZ3IiJ6ZC4=;
        b=S03zNtKcFT7ZiDen7Z6J+htISI+JIPF6pR8oKt+FYBaCFqNM1AJAt6Aa/OPHA7Ux5h
         9u6MNNKY9XgnBUlumQXuYYfMTzG0fukD41JvySdG79RC7Cs9fobieD9WQZoPb6xu98hu
         S4wlmNT5LXNgMvfsoo3sq9s9o0S3PkrleNyFyLxlhfGFtynmnti4ydUweYQEF6qnZ2CR
         ygCWfslnosJWkMp8RPGmQuMjZxbe8GsZsqpRQB/QMABc8OzXd2q/BTBZYjQm1pYGDDHA
         L7U5JhdAWhhqCK/ObG7oFfC87gVKCxfU5AXbdbwJNpRbJcZl99tg3EpWA9aEwF97cnts
         xmiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723160600; x=1723765400;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0exwGleVPp3zy85HvQnGK2Nbqg6sOajMWkZ3IiJ6ZC4=;
        b=CVU6Z20JvEcYwWGWNMUroPq49bGsmf25aEuO4tioXeDBfi2kBuEaKJPOpC1oHneRH4
         5aT813BJ8HCxzxZZVRnYG62NvMudARn72Zt65Cerz+VQoecyEPlW9V1csJE3sZjz7kBY
         +qC78Fm49zhOm6A3lMnpJElXYAt+jZaJm0Y7J5Iv7Xk0gvNXTHv3Qvsj6eHLgoq+jFaq
         t6PvsVP3nlcNCH9ubi3ob42RHtaO2rNgzPZ9Eu9ZBVxJ+iE6k052GAb+iw8Gn2oGezyC
         F1yI1XCgdovgmFmWMUCIFKFCDvtiHrfsL6u4LBCKUhBWcMN4gQa3efErpQ0fLhow5BlH
         7ifQ==
X-Forwarded-Encrypted: i=1; AJvYcCUY0XbXGakkathXIoEeyWAxGTHuf1DxVAAQjTMmBu4vvytg0ornp6EgERPFGIZZBlfR1RDyeo5e+kTSscl8qhD7vLZn9xe2cSD2ftirrpq1HM0U645TEUdQTUoSzJBnNvwOd9V64ccpZsrvYg==
X-Gm-Message-State: AOJu0Yzt1CCphKcU11Jo1xRAUODYKaPeyVh+0RPZK4wmNiKmvpHRA5uy
	1RZApEbM4ld46mysjMUw9wnFRcIzgZheJQ02GltREvwXeQnGSZBWh9fppNCO
X-Google-Smtp-Source: AGHT+IFm2KwNt1XdAOxj6J6+SLvha9c9io6RUmi5g+NE7UvuIoWK8uAgiE0x5+gZd+rbtgmdWfZU/g==
X-Received: by 2002:a2e:7a04:0:b0:2ef:22ad:77b8 with SMTP id 38308e7fff4ca-2f19de3b0femr24202371fa.23.1723160599385;
        Thu, 08 Aug 2024 16:43:19 -0700 (PDT)
Received: from f (cst-prg-72-52.cust.vodafone.cz. [46.135.72.52])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bbb2e5f857sm1049242a12.88.2024.08.08.16.43.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 16:43:18 -0700 (PDT)
Date: Fri, 9 Aug 2024 01:43:03 +0200
From: Mateusz Guzik <mjguzik@gmail.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/9] fs: add infrastructure for multigrain timestamps
Message-ID: <gcn5kkrc2eeger6uzwqe5iinxtevhrgi3qz6ru3th3bkt4nrfd@ldkkwu4ndpnn>
References: <20240715-mgtime-v6-0-48e5d34bd2ba@kernel.org>
 <20240715-mgtime-v6-1-48e5d34bd2ba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240715-mgtime-v6-1-48e5d34bd2ba@kernel.org>

On Mon, Jul 15, 2024 at 08:48:52AM -0400, Jeff Layton wrote:
>  /**
>   * inode_set_ctime_current - set the ctime to current_time
>   * @inode: inode
>   *
> - * Set the inode->i_ctime to the current value for the inode. Returns
> - * the current value that was assigned to i_ctime.
> + * Set the inode's ctime to the current value for the inode. Returns the
> + * current value that was assigned. If this is not a multigrain inode, then we
> + * just set it to whatever the coarse_ctime is.
> + *
> + * If it is multigrain, then we first see if the coarse-grained timestamp is
> + * distinct from what we have. If so, then we'll just use that. If we have to
> + * get a fine-grained timestamp, then do so, and try to swap it into the floor.
> + * We accept the new floor value regardless of the outcome of the cmpxchg.
> + * After that, we try to swap the new value into i_ctime_nsec. Again, we take
> + * the resulting ctime, regardless of the outcome of the swap.
>   */
>  struct timespec64 inode_set_ctime_current(struct inode *inode)
>  {
> -	struct timespec64 now = current_time(inode);
> +	ktime_t now, floor = atomic64_read(&ctime_floor);
> +	struct timespec64 now_ts;
> +	u32 cns, cur;
> +
> +	now = coarse_ctime(floor);
> +
> +	/* Just return that if this is not a multigrain fs */
> +	if (!is_mgtime(inode)) {
> +		now_ts = timestamp_truncate(ktime_to_timespec64(now), inode);
> +		inode_set_ctime_to_ts(inode, now_ts);
> +		goto out;
> +	}
> +
> +	/*
> +	 * We only need a fine-grained time if someone has queried it,
> +	 * and the current coarse grained time isn't later than what's
> +	 * already there.
> +	 */
> +	cns = smp_load_acquire(&inode->i_ctime_nsec);
> +	if (cns & I_CTIME_QUERIED) {
> +		ktime_t ctime = ktime_set(inode->i_ctime_sec, cns & ~I_CTIME_QUERIED);
> +
> +		if (!ktime_after(now, ctime)) {
> +			ktime_t old, fine;
> +
> +			/* Get a fine-grained time */
> +			fine = ktime_get();
>  
> -	inode_set_ctime_to_ts(inode, now);
> -	return now;
> +			/*
> +			 * If the cmpxchg works, we take the new floor value. If
> +			 * not, then that means that someone else changed it after we
> +			 * fetched it but before we got here. That value is just
> +			 * as good, so keep it.
> +			 */
> +			old = floor;
> +			if (!atomic64_try_cmpxchg(&ctime_floor, &old, fine))
> +				fine = old;
> +			now = ktime_mono_to_real(fine);
> +		}
> +	}
> +	now_ts = timestamp_truncate(ktime_to_timespec64(now), inode);
> +	cur = cns;
> +
> +	/* No need to cmpxchg if it's exactly the same */
> +	if (cns == now_ts.tv_nsec && inode->i_ctime_sec == now_ts.tv_sec)
> +		goto out;
> +retry:
> +	/* Try to swap the nsec value into place. */
> +	if (try_cmpxchg(&inode->i_ctime_nsec, &cur, now_ts.tv_nsec)) {
> +		/* If swap occurred, then we're (mostly) done */
> +		inode->i_ctime_sec = now_ts.tv_sec;


Linux always had rather lax approach to consistency of getattr results
and I wonder if with this patchset it is no longer viable.

Ignoring the flag, suppose ctime on the inode is { nsec = 12, sec = 1 },
while the new timestamp is { nsec = 1, sec = 2 }

The current update method results in a transient state where { nsec = 1,
sec = 1 }. But this represents an earlier point in time.

Thus a thread which observed the first state and spotted the transient
value in the second one is going to conclude time went backwards. Is
this considered fine given what the multigrain stuff is trying to
accomplish?

As for fixing this, off hand I note there is a 4-byte hole in struct
inode, just enough to store a sequence counter which fill_mg_cmtime
could use to safely read the sec/nsec pair. The write side would take
the inode spinlock.

> +	} else {
> +		/*
> +		 * Was the change due to someone marking the old ctime QUERIED?
> +		 * If so then retry the swap. This can only happen once since
> +		 * the only way to clear I_CTIME_QUERIED is to stamp the inode
> +		 * with a new ctime.
> +		 */
> +		if (!(cns & I_CTIME_QUERIED) && (cns | I_CTIME_QUERIED) == cur) {
> +			cns = cur;
> +			goto retry;
> +		}
> +		/* Otherwise, keep the existing ctime */
> +		now_ts.tv_sec = inode->i_ctime_sec;
> +		now_ts.tv_nsec = cur & ~I_CTIME_QUERIED;
> +	}
> +out:
> +	return now_ts;
>  }
>  EXPORT_SYMBOL(inode_set_ctime_current);

