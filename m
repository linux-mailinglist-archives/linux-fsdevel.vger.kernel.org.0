Return-Path: <linux-fsdevel+bounces-25747-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 03F7794FB6F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 03:54:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5664AB212EC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 01:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C253125DE;
	Tue, 13 Aug 2024 01:54:25 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6AF8BEF;
	Tue, 13 Aug 2024 01:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723514064; cv=none; b=uKoZcbN6hke0iym2s04MFGGkfxtSUP1xCOlA7PTsKpzL4I8j6UHBSafg7odMgkpE4bjJdUDGYlXViIK1PgsruJ2cX5A8i8Y0DxJGp8KX3+7gtiFr2cE/RQ9dgOO8zOEk01GjQalae2XXjgLfUvfEOUoi2cfnsBUxxxVGoUGXotM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723514064; c=relaxed/simple;
	bh=xf2c9r28DjNV2oZOIAFC3eioU11GutQquZEDO4E5AE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xo2rxzc62Wjx8hawahX5obyh4/BG6scg8y6YsrbgGSm9bEO4TTABHUHJ+cdYz5Jn0RIbwWdW5/sYu658wdVgp2T3QHyVIbnSqlDYBLs6eQ03bN0qYqtNQYfScX9UAVq6/W99h7VlECLxS2GtXSU9QkVH3VHDpC/7wD+AHZAD2VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-70d1d6369acso4025948b3a.0;
        Mon, 12 Aug 2024 18:54:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723514062; x=1724118862;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IR7nxsJ/on7OZmeb7iHI9ejZE2dXQFCt6FEeyf1PESQ=;
        b=nFd4KqfN0pjIAWqfYd1xBxEyiN2R0/F4HfwbHiSY5FfvvWiib+jkRbdrMNrIpb22MM
         8LA15Knnp3z7aGomqI+Z6qumjLMIURqSDCJ6QvK0uk67XrJUO5IEPxnFFijuPFgA6YsL
         28SB7X/QMSXqySzVEWWzqGtkB3w6rNsoBcmDCvMuDnhy3jnumRNXQy8OKURLdgGAoaI5
         l8e3D1nvGKXXNig2jlhDLwJujAiOB3tfZKDu1sLdqjIF7LtJS0CV9DkYhdnRvyNcmYl+
         oatlrtg+kUQtvsk/jhZsYBuJOASpOeyx/2OIQhIwvz8vGdz2OSOFmmK3ETDuM1UjafYp
         x4hw==
X-Forwarded-Encrypted: i=1; AJvYcCXvWawhFOf6maOMXQpbICm+q5OsczGWPviz4ib48FvHA0tcAzs8dTb7lrkXY9QQAzFr63cuPENZJIdETtM3mKgevBeUER2cX8DngMn5Zh97bH7jbMCf3tzu36yzk393JwJ9+jDDtIGeuXo+yvop9qESA+hSOUtYsjbtF95nXaGqTpVkDQOuBg==
X-Gm-Message-State: AOJu0YyA6DFomEADiIfkM+d8rSyKddtOt6kx0+Uremo7cC4LNa5l7oBJ
	qJqF0+qvb3NZ7RDHb6HysY1W32dT5nUO+olZLlHCEGsBwvYjKNA=
X-Google-Smtp-Source: AGHT+IFFsSTbbZeJK3+KDsL25G7biWTsuXdC31iTRrYyxom4HI+FPmn4OkMb0AGCbqMleehQ0TaICA==
X-Received: by 2002:a05:6a20:12c6:b0:1c4:8694:6be8 with SMTP id adf61e73a8af0-1c8da19049dmr2160169637.3.1723514061689;
        Mon, 12 Aug 2024 18:54:21 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:73b6:7410:eb24:cba4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710e5ab7af4sm4603819b3a.208.2024.08.12.18.54.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 18:54:21 -0700 (PDT)
Date: Mon, 12 Aug 2024 18:54:20 -0700
From: Stanislav Fomichev <sdf@fomichev.me>
To: Martin Karsten <mkarsten@uwaterloo.ca>
Cc: netdev@vger.kernel.org, Joe Damato <jdamato@fastly.com>,
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
Message-ID: <Zrq8zCy1-mfArXka@mini-arch>
References: <20240812125717.413108-1-jdamato@fastly.com>
 <ZrpuWMoXHxzPvvhL@mini-arch>
 <2bb121dd-3dcd-4142-ab87-02ccf4afd469@uwaterloo.ca>
 <ZrqU3kYgL4-OI-qj@mini-arch>
 <d53e8aa6-a5eb-41f4-9a4c-70d04a5ca748@uwaterloo.ca>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d53e8aa6-a5eb-41f4-9a4c-70d04a5ca748@uwaterloo.ca>

On 08/12, Martin Karsten wrote:
> On 2024-08-12 19:03, Stanislav Fomichev wrote:
> > On 08/12, Martin Karsten wrote:
> > > On 2024-08-12 16:19, Stanislav Fomichev wrote:
> > > > On 08/12, Joe Damato wrote:
> > > > > Greetings:
> > > > > 
> > > > > Martin Karsten (CC'd) and I have been collaborating on some ideas about
> > > > > ways of reducing tail latency when using epoll-based busy poll and we'd
> > > > > love to get feedback from the list on the code in this series. This is
> > > > > the idea I mentioned at netdev conf, for those who were there. Barring
> > > > > any major issues, we hope to submit this officially shortly after RFC.
> > > > > 
> > > > > The basic idea for suspending IRQs in this manner was described in an
> > > > > earlier paper presented at Sigmetrics 2024 [1].
> > > > 
> > > > Let me explicitly call out the paper. Very nice analysis!
> > > 
> > > Thank you!
> > > 
> > > [snip]
> > > 
> > > > > Here's how it is intended to work:
> > > > >     - An administrator sets the existing sysfs parameters for
> > > > >       defer_hard_irqs and gro_flush_timeout to enable IRQ deferral.
> > > > > 
> > > > >     - An administrator sets the new sysfs parameter irq_suspend_timeout
> > > > >       to a larger value than gro-timeout to enable IRQ suspension.
> > > > 
> > > > Can you expand more on what's the problem with the existing gro_flush_timeout?
> > > > Is it defer_hard_irqs_count? Or you want a separate timeout only for the
> > > > perfer_busy_poll case(why?)? Because looking at the first two patches,
> > > > you essentially replace all usages of gro_flush_timeout with a new variable
> > > > and I don't see how it helps.
> > > 
> > > gro-flush-timeout (in combination with defer-hard-irqs) is the default irq
> > > deferral mechanism and as such, always active when configured. Its static
> > > periodic softirq processing leads to a situation where:
> > > 
> > > - A long gro-flush-timeout causes high latencies when load is sufficiently
> > > below capacity, or
> > > 
> > > - a short gro-flush-timeout causes overhead when softirq execution
> > > asynchronously competes with application processing at high load.
> > > 
> > > The shortcomings of this are documented (to some extent) by our experiments.
> > > See defer20 working well at low load, but having problems at high load,
> > > while defer200 having higher latency at low load.
> > > 
> > > irq-suspend-timeout is only active when an application uses
> > > prefer-busy-polling and in that case, produces a nice alternating pattern of
> > > application processing and networking processing (similar to what we
> > > describe in the paper). This then works well with both low and high load.
> > 
> > So you only want it for the prefer-busy-pollingc case, makes sense. I was
> > a bit confused by the difference between defer200 and suspend200,
> > but now I see that defer200 does not enable busypoll.
> > 
> > I'm assuming that if you enable busypool in defer200 case, the numbers
> > should be similar to suspend200 (ignoring potentially affecting
> > non-busypolling queues due to higher gro_flush_timeout).
> 
> defer200 + napi busy poll is essentially what we labelled "busy" and it does
> not perform as well, since it still suffers interference between application
> and softirq processing.

With all your patches applied? Why? Userspace not keeping up?

> > > > Maybe expand more on what code paths are we trying to improve? Existing
> > > > busy polling code is not super readable, so would be nice to simplify
> > > > it a bit in the process (if possible) instead of adding one more tunable.
> > > 
> > > There are essentially three possible loops for network processing:
> > > 
> > > 1) hardirq -> softirq -> napi poll; this is the baseline functionality
> > > 
> > > 2) timer -> softirq -> napi poll; this is deferred irq processing scheme
> > > with the shortcomings described above
> > > 
> > > 3) epoll -> busy-poll -> napi poll
> > > 
> > > If a system is configured for 1), not much can be done, as it is difficult
> > > to interject anything into this loop without adding state and side effects.
> > > This is what we tried for the paper, but it ended up being a hack.
> > > 
> > > If however the system is configured for irq deferral, Loops 2) and 3)
> > > "wrestle" with each other for control. Injecting the larger
> > > irq-suspend-timeout for 'timer' in Loop 2) essentially tilts this in favour
> > > of Loop 3) and creates the nice pattern describe above.
> > 
> > And you hit (2) when the epoll goes to sleep and/or when the userspace
> > isn't fast enough to keep up with the timer, presumably? I wonder
> > if need to use this opportunity and do proper API as Joe hints in the
> > cover letter. Something over netlink to say "I'm gonna busy-poll on
> > this queue / napi_id and with this timeout". And then we can essentially make
> > gro_flush_timeout per queue (and avoid
> > napi_resume_irqs/napi_suspend_irqs). Existing gro_flush_timeout feels
> > too hacky already :-(
> 
> If someone would implement the necessary changes to make these parameters
> per-napi, this would improve things further, but note that the current
> proposal gives strong performance across a range of workloads, which is
> otherwise difficult to impossible to achieve.

Let's see what other people have to say. But we tried to do a similar
setup at Google recently and getting all these parameters right
was not trivial. Joe's recent patch series to push some of these into
epoll context are a step in the right direction. It would be nice to
have more explicit interface to express busy poling preference for
the users vs chasing a bunch of global tunables and fighting against softirq
wakups.

> Note that napi_suspend_irqs/napi_resume_irqs is needed even for the sake of
> an individual queue or application to make sure that IRQ suspension is
> enabled/disabled right away when the state of the system changes from busy
> to idle and back.

Can we not handle everything in napi_busy_loop? If we can mark some napi
contexts as "explicitly polled by userspace with a larger defer timeout",
we should be able to do better compared to current NAPI_F_PREFER_BUSY_POLL
which is more like "this particular napi_poll call is user busy polling".

> > > [snip]
> > > 
> > > > >     - suspendX:
> > > > >       - set defer_hard_irqs to 100
> > > > >       - set gro_flush_timeout to X,000
> > > > >       - set irq_suspend_timeout to 20,000,000
> > > > >       - enable busy poll via the existing ioctl (busy_poll_usecs = 0,
> > > > >         busy_poll_budget = 64, prefer_busy_poll = true)
> > > > 
> > > > What's the intention of `busy_poll_usecs = 0` here? Presumably we fallback
> > > > to busy_poll sysctl value?
> > > 
> > > Before this patch set, ep_poll only calls napi_busy_poll, if busy_poll
> > > (sysctl) or busy_poll_usecs is nonzero. However, this might lead to
> > > busy-polling even when the application does not actually need or want it.
> > > Only one iteration through the busy loop is needed to make the new scheme
> > > work. Additional napi busy polling over and above is optional.
> > 
> > Ack, thanks, was trying to understand why not stay with
> > busy_poll_usecs=64 for consistency. But I guess you were just
> > trying to show that patch 4/5 works.
> 
> Right, and we would potentially be wasting CPU cycles by adding more
> busy-looping.

Or potentially improving the latency more if you happen to get more packets
during busy_poll_usecs duration? I'd imagine some applications might
prefer to 100% busy poll without ever going to sleep (that would probably
require getting rid of napi_id tracking in epoll, but that's a different story).

