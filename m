Return-Path: <linux-fsdevel+bounces-25719-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3867394F81F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 22:20:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8D22282C6F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 20:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2364A1946AA;
	Mon, 12 Aug 2024 20:19:41 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA684194083;
	Mon, 12 Aug 2024 20:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723493980; cv=none; b=grv4oN5VxiEJMYnbawkKlL4aFlIoLCU2hJzuiPau4HS+L8eiBQpSlNdpwMxd5iTzchQDNxpt/mwFzVkMhPWwW90qqZJjthK30KueDM7Gj0I6z34hmCsseiuRWEU/8VQJSsa5mqP10hdLn24pHRbVPIFqkYFBIXrqhQvZ6Uz5iUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723493980; c=relaxed/simple;
	bh=6ximRuWHuzop8d/8wG9dBfgtQf7mlM8IAwHHjrjUXBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gZ2HFaJAxy6HROWknlA4ymCIMFWmV147i8VtnlFLY3Edn/3w4GZeJ6gYXdIJc6zss1vlIgdV+WtZ7pHNwrFmzmqbklTBa0vhT5FcEG1vX8cgqOKGAaxqm6WMyHiHyXYWD8FXByGODFz0UuyxgmLf3TFMnJwcE2PlwmCeZ0GBo08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7b0c9bbddb4so3185540a12.3;
        Mon, 12 Aug 2024 13:19:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723493978; x=1724098778;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4jlwDLAcrevBsN9Wrdokodlz9ZElcSTrs+vyN5GZdFs=;
        b=avIYmeRbjhG28SKlLGLiLoxxkNdJpkeAlfy3S863COxnwRLhjhIVwWEelfZCY7e0qr
         E4eESbK+Q9DTJOUDesHrcha/VUm1c5YnbNlbNSi4anEmy23juGtqpNn+F77cK9cPkSWE
         3KajRGBfL6MayYyS5HN7KnY4r0o46Zuom2OBeGUahdcSGCwRCUtvZsw8UYg/aymqPHLX
         0JtZkM/rhYaEnqXmr9l6DL7NC4JXcLd9yP9nvqS3MTRS9VqLBV2cGlVDuh/tKWkcklPe
         sqeAOg4ruUqahJyyt8U4lcdp0jIWZkdoeUjZG8FwtQ/SWeHGzgq+WO26QBZLxQETougQ
         cspQ==
X-Forwarded-Encrypted: i=1; AJvYcCWG3klcHsFAlbvi5QdR/SpQXNS1J3IS8hh8WSh5komexu/gLyeO3D4kwPer3J88EDE0xApBTOB9VSWCJ6fiHl2WlaSFRV8U4tva0Miq4ZA8iarH5cgmcJOzmqut8R53sLuX4HKDilFcCqK2I4O2zcpTSeJLQ3mtsUyUur5r2orjbNaZ2zmaHQ==
X-Gm-Message-State: AOJu0YxbHC/DpncsEs8JEkLdlEI3tj8lLqNkJtmQxtmytuNqEauOXSxH
	Pbp+IB2TSriW+BcT9HoHb4SAkmcjCUztU9fdx7Jpozjv73X4YdA=
X-Google-Smtp-Source: AGHT+IHwU6DzPkSwNH2RgD46M84clPNFpvjxlBM1ux2zOo68RlAzFKmPLPU1QVaBGgvUn+WCSHh3GQ==
X-Received: by 2002:a17:902:ea08:b0:1fd:a043:e3fb with SMTP id d9443c01a7336-201ca1fb2bcmr13565515ad.63.1723493978008;
        Mon, 12 Aug 2024 13:19:38 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:73b6:7410:eb24:cba4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201cd1cff62sm770945ad.292.2024.08.12.13.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 13:19:37 -0700 (PDT)
Date: Mon, 12 Aug 2024 13:19:36 -0700
From: Stanislav Fomichev <sdf@fomichev.me>
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, mkarsten@uwaterloo.ca,
	amritha.nambiar@intel.com, sridhar.samudrala@intel.com,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Breno Leitao <leitao@debian.org>,
	Christian Brauner <brauner@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Jan Kara <jack@suse.cz>,
	Jiri Pirko <jiri@resnulli.us>,
	Johannes Berg <johannes.berg@intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	"open list:FILESYSTEMS (VFS and infrastructure)" <linux-fsdevel@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [RFC net-next 0/5] Suspend IRQs during preferred busy poll
Message-ID: <ZrpuWMoXHxzPvvhL@mini-arch>
References: <20240812125717.413108-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240812125717.413108-1-jdamato@fastly.com>

On 08/12, Joe Damato wrote:
> Greetings:
> 
> Martin Karsten (CC'd) and I have been collaborating on some ideas about
> ways of reducing tail latency when using epoll-based busy poll and we'd
> love to get feedback from the list on the code in this series. This is
> the idea I mentioned at netdev conf, for those who were there. Barring
> any major issues, we hope to submit this officially shortly after RFC.
> 
> The basic idea for suspending IRQs in this manner was described in an
> earlier paper presented at Sigmetrics 2024 [1].

Let me explicitly call out the paper. Very nice analysis!

> Previously, commit 18e2bf0edf4d ("eventpoll: Add epoll ioctl for
> epoll_params") introduced the ability to enable or disable preferred
> busy poll mode on a specific epoll context using an ioctl
> (EPIOCSPARAMS).
> 
> This series extends preferred busy poll mode by adding a sysfs parameter,
> irq_suspend_timeout, which when used in combination with preferred busy
> poll suspends device IRQs up to irq_suspend_timeout nanoseconds.
> 
> Important call outs:
>   - Enabling per epoll-context preferred busy poll will now effectively
>     lead to a nonblocking iteration through napi_busy_loop, even when
>     busy_poll_usecs is 0. See patch 4.
> 
>   - Patches apply cleanly on net-next commit c4e82c025b3f ("net: dsa:
>     microchip: ksz9477: split half-duplex monitoring function"),  but
>     may need to be respun if/when commit b4988e3bd1f0 ("eventpoll: Annotate
>     data-race of busy_poll_usecs") picked up by the vfs folks makes its way
>     into net-next.
> 
>   - In the future, time permitting, I hope to enable support for
>     napi_defer_hard_irqs, gro_flush_timeout (introduced in commit
>     6f8b12d661d0 ("net: napi: add hard irqs deferral feature")), and
>     irq_suspend_timeout (introduced in this series) on a per-NAPI basis
>     (presumably via netdev-genl).
> 
> ~ Description of the changes
> 
> The overall idea is that IRQ suspension is introduced via a sysfs
> parameter which controls the maximum time that IRQs can be suspended.
> 
> Here's how it is intended to work:
>   - An administrator sets the existing sysfs parameters for
>     defer_hard_irqs and gro_flush_timeout to enable IRQ deferral.
> 
>   - An administrator sets the new sysfs parameter irq_suspend_timeout
>     to a larger value than gro-timeout to enable IRQ suspension.

Can you expand more on what's the problem with the existing gro_flush_timeout?
Is it defer_hard_irqs_count? Or you want a separate timeout only for the
perfer_busy_poll case(why?)? Because looking at the first two patches,
you essentially replace all usages of gro_flush_timeout with a new variable
and I don't see how it helps.

Maybe expand more on what code paths are we trying to improve? Existing
busy polling code is not super readable, so would be nice to simplify
it a bit in the process (if possible) instead of adding one more tunable.

>   - The user application issues the existing epoll ioctl to set the
>     prefer_busy_poll flag on the epoll context.
> 
>   - The user application then calls epoll_wait to busy poll for network
>     events, as it normally would.
> 
>   - If epoll_wait returns events to userland, IRQ are suspended for the
>     duration of irq_suspend_timeout.
> 
>   - If epoll_wait finds no events and the thread is about to go to
>     sleep, IRQ handling using gro_flush_timeout and defer_hard_irqs is
>     resumed.
> 
> As long as epoll_wait is retrieving events, IRQs (and softirq
> processing) for the NAPI being polled remain disabled. Unless IRQ
> suspension is continued by subsequent calls to epoll_wait, it
> automatically times out after the irq_suspend_timeout timer expires.
> 
> When network traffic reduces, eventually a busy poll loop in the kernel
> will retrieve no data. When this occurs, regular deferral using
> gro_flush_timeout for the polled NAPI is immediately re-enabled. Regular
> deferral is also immediately re-enabled when the epoll context is
> destroyed.
> 
> ~ Benchmark configs & descriptions
> 
> These changes were benchmarked with memcached [2] using the
> benchmarking tool mutilate [3].
> 
> To facilitate benchmarking, a small patch [4] was applied to
> memcached 1.6.29 (the latest memcached release as of this RFC) to allow
> setting per-epoll context preferred busy poll and other settings
> via environment variables.
> 
> Multiple scenarios were benchmarked as described below
> and the scripts used for producing these results can be found on
> github [5].
> 
> (note: all scenarios use NAPI-based traffic splitting via SO_INCOMING_ID
> by passing -N to memcached):
> 
>   - base: Other than NAPI-based traffic splitting, no other options are
>     enabled.
>   - busy:
>     - set defer_hard_irqs to 100
>     - set gro_flush_timeout to 200,000
>     - enable busy poll via the existing ioctl (busy_poll_usecs = 64,
>       busy_poll_budget = 64, prefer_busy_poll = true)
>   - deferX:
>     - set defer_hard_irqs to 100
>     - set gro_flush_timeout to X,000

[..]

>   - suspendX:
>     - set defer_hard_irqs to 100
>     - set gro_flush_timeout to X,000
>     - set irq_suspend_timeout to 20,000,000
>     - enable busy poll via the existing ioctl (busy_poll_usecs = 0,
>       busy_poll_budget = 64, prefer_busy_poll = true)

What's the intention of `busy_poll_usecs = 0` here? Presumably we fallback
to busy_poll sysctl value?

