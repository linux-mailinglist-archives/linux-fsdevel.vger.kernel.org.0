Return-Path: <linux-fsdevel+bounces-38117-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA2189FC54F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Dec 2024 14:30:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56C201882887
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Dec 2024 13:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F9F51AAA24;
	Wed, 25 Dec 2024 13:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bo1/IqxL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19651175B1;
	Wed, 25 Dec 2024 13:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735133445; cv=none; b=Kc9+yoBtIBRhOa3J/Me6r6grGMHuhxgrlG/8Dq1ryv/9cUVZ2cBzr6r9RaQEYI3EN6NlR9ZuY+cgRgzjFCg/Q8GnM0uCJUHIA7Ahrvgjh5WCSfQzDYo2LyzgsndOaFdHp+iEuIWHc7g7aYc5riZn2j9fMFOejhx5aSjiT70hoBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735133445; c=relaxed/simple;
	bh=kcvBIDyPM+l2ugn6KlnNQ9qBowzEm44IhAjVxgS1hgE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VmiivSQEKdpftfC8EDCV7dU78jP0kW319Pu9KB2eppA3e+2zfV5mcohqsV2mmAksJijm49tTNvEsH/QpqAisbKMa9hXdDsTa8a9fQcCL9+66HODu+K4kPVct6FfUp+gj+q8bP2m4Qu2LTDGlng2trD29lLIPii9W4r/ZU5fGFc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bo1/IqxL; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735133444; x=1766669444;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kcvBIDyPM+l2ugn6KlnNQ9qBowzEm44IhAjVxgS1hgE=;
  b=Bo1/IqxLSrcFtm6ieo4wvPwcsYnVM8SW+40gS3PhBaMPoAEZ85iGaQMb
   QP9g5zxLAtC9vSeWj3KhBmCCBM2B/hw1ghDC9WgvHd0Qgp4b5Ja4+K+Lc
   sWpg3P4Ip80RE5pNlBMAXRaXNqSz2aF27lwz3qyqPg5gL8b850xLWtpHF
   eEAXTZhz3tobQnvqwX/tNWxAPAT/yT7Cm2gm8aAlZenthpnclfuGoYPVk
   IG0/QPiTk6al6i/W92eDuINTAquMG688nr4kRPLsQQsU+xnVQQ+NUFjMw
   gSebWz4yiytTKgFTZiHMNDS8geMWmJsRYQIPHRhjtQWBNi/NzNLTFj1f7
   w==;
X-CSE-ConnectionGUID: 0vbRHEcWS1iUxcufDM9Peg==
X-CSE-MsgGUID: ZOAGTSQ4TDWKLiMtCixm6g==
X-IronPort-AV: E=McAfee;i="6700,10204,11296"; a="23170396"
X-IronPort-AV: E=Sophos;i="6.12,263,1728975600"; 
   d="scan'208";a="23170396"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Dec 2024 05:30:42 -0800
X-CSE-ConnectionGUID: jkhGF14US/q3Ju6rco8/uw==
X-CSE-MsgGUID: nOzcGyzTR0qIr2ScwVg7JA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="104706660"
Received: from smile.fi.intel.com ([10.237.72.154])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Dec 2024 05:30:19 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tQRSg-0000000C8M1-0pGi;
	Wed, 25 Dec 2024 15:30:06 +0200
Date: Wed, 25 Dec 2024 15:30:05 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: WangYuli <wangyuli@uniontech.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	yushengjin@uniontech.com, zhangdandan@uniontech.com,
	guanwentao@uniontech.com, zhanjun@uniontech.com,
	oliver.sang@intel.com, ebiederm@xmission.com,
	colin.king@canonical.com, josh@joshtriplett.org,
	penberg@cs.helsinki.fi, manfred@colorfullife.com, mingo@elte.hu,
	jes@sgi.com, hch@lst.de, aia21@cantab.net, arjan@infradead.org,
	jgarzik@pobox.com, neukum@fachschaft.cup.uni-muenchen.de,
	oliver@neukum.name, dada1@cosmosbay.com, axboe@kernel.dk,
	axboe@suse.de, nickpiggin@yahoo.com.au, dhowells@redhat.com,
	nathans@sgi.com, rolandd@cisco.com, tytso@mit.edu, bunk@stusta.de,
	pbadari@us.ibm.com, ak@linux.intel.com, ak@suse.de,
	davem@davemloft.net, jsipek@cs.sunysb.edu, jens.axboe@oracle.com,
	ramsdell@mitre.org, hch@infradead.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	randy.dunlap@oracle.com, efault@gmx.de, rdunlap@infradead.org,
	haveblue@us.ibm.com, drepper@redhat.com, dm.n9107@gmail.com,
	jblunck@suse.de, davidel@xmailserver.org,
	mtk.manpages@googlemail.com, linux-arch@vger.kernel.org,
	vda.linux@googlemail.com, jmorris@namei.org, serue@us.ibm.com,
	hca@linux.ibm.com, rth@twiddle.net, lethal@linux-sh.org,
	tony.luck@intel.com, heiko.carstens@de.ibm.com, oleg@redhat.com,
	andi@firstfloor.org, corbet@lwn.net, crquan@gmail.com,
	mszeredi@suse.cz, miklos@szeredi.hu, peterz@infradead.org,
	a.p.zijlstra@chello.nl, earl_chew@agilent.com, npiggin@gmail.com,
	npiggin@suse.de, julia@diku.dk, jaxboe@fusionio.com,
	nikai@nikai.net, dchinner@redhat.com, davej@redhat.com,
	npiggin@kernel.dk, eric.dumazet@gmail.com,
	tim.c.chen@linux.intel.com, xemul@parallels.com, tj@kernel.org,
	serge.hallyn@canonical.com, gorcunov@openvz.org,
	levinsasha928@gmail.com, penberg@kernel.org, amwang@redhat.com,
	bcrl@kvack.org, muthu.lkml@gmail.com, muthur@gmail.com,
	mjt@tls.msk.ru, alan@lxorguk.ukuu.org.uk, raven@themaw.net,
	thomas@m3y3r.de, will.deacon@arm.com, will@kernel.org,
	josef@redhat.com, anatol.pomozov@gmail.com, koverstreet@google.com,
	zab@redhat.com, balbi@ti.com, gregkh@linuxfoundation.org,
	mfasheh@suse.com, jlbec@evilplan.org, rusty@rustcorp.com.au,
	asamymuthupa@micron.com, smani@micron.com, sbradshaw@micron.com,
	jmoyer@redhat.com, sim@hostway.ca, ia@cloudflare.com,
	dmonakhov@openvz.org, ebiggers3@gmail.com, socketpair@gmail.com,
	penguin-kernel@i-love.sakura.ne.jp, w@1wt.eu,
	kirill.shutemov@linux.intel.com, mhocko@suse.com,
	vdavydov.dev@gmail.com, vdavydov@virtuozzo.com, hannes@cmpxchg.org,
	mhocko@kernel.org, minchan@kernel.org, deepa.kernel@gmail.com,
	arnd@arndb.de, balbi@kernel.org, swhiteho@redhat.com,
	konishi.ryusuke@lab.ntt.co.jp, dsterba@suse.com,
	vegard.nossum@oracle.com, axboe@fb.com, pombredanne@nexb.com,
	tglx@linutronix.de, joe.lawrence@redhat.com, mpatocka@redhat.com,
	mcgrof@kernel.org, keescook@chromium.org,
	linux@dominikbrodowski.net, jannh@google.com, shakeelb@google.com,
	guro@fb.com, willy@infradead.org, khlebnikov@yandex-team.ru,
	kirr@nexedi.com, stern@rowland.harvard.edu, elver@google.com,
	parri.andrea@gmail.com, paulmck@kernel.org, rasibley@redhat.com,
	jstancek@redhat.com, avagin@gmail.com, cai@redhat.com,
	josef@toxicpanda.com, hare@suse.de, colyli@suse.de,
	johannes@sipsolutions.net, sspatil@android.com, alex_y_xu@yahoo.ca,
	mgorman@techsingularity.net, gor@linux.ibm.com, jhubbard@nvidia.com,
	crope@iki.fi, yzaikin@google.com, bfields@fieldses.org,
	jlayton@kernel.org, kernel@tuxforce.de, steve@sk2.org,
	nixiaoming@huawei.com, 0x7f454c46@gmail.com, kuniyu@amazon.co.jp,
	alexander.h.duyck@intel.com, kuni1840@gmail.com, soheil@google.com,
	sridhar.samudrala@intel.com, Vincenzo.Frascino@arm.com,
	chuck.lever@oracle.com, Kevin.Brodsky@arm.com,
	Szabolcs.Nagy@arm.com, David.Laight@aculab.com,
	Mark.Rutland@arm.com, linux-morello@op-lists.linaro.org,
	Luca.Vizzarro@arm.com, max.kellermann@ionos.com,
	adobriyan@gmail.com, lukas@schauer.dev, j.granados@samsung.com,
	djwong@kernel.org, kent.overstreet@linux.dev, linux@weissschuh.net,
	kstewart@efficios.com
Subject: Re: [RESEND PATCH] fs/pipe: Introduce a check to skip sleeping
 processes during pipe read/write
Message-ID: <Z2wI3dmmrhMRT-48@smile.fi.intel.com>
References: <75B06EE0B67747ED+20241225094202.597305-1-wangyuli@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75B06EE0B67747ED+20241225094202.597305-1-wangyuli@uniontech.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

Don't you think the Cc list is a bit overloaded?

On Wed, Dec 25, 2024 at 05:42:02PM +0800, WangYuli wrote:
> When a user calls the read/write system call and passes a pipe
> descriptor, the pipe_read/pipe_write functions are invoked:
> 
> 1. pipe_read():
>   1). Checks if the pipe is valid and if there is any data in the
> pipe buffer.
>   2). Waits for data:
>     *If there is no data in the pipe and the write end is still open,
> the current process enters a sleep state (wait_event()) until data
> is written.
>     *If the write end is closed, return 0.
>   3). Reads data:
>     *Wakes up the process and copies data from the pipe's memory
> buffer to user space.
>     *When the buffer is full, the writing process will go to sleep,
> waiting for the pipe state to change to be awakened (using the
> wake_up_interruptible_sync_poll() mechanism). Once data is read
> from the buffer, the writing process can continue writing, and the
> reading process can continue reading new data.
>   4). Returns the number of bytes read upon successful read.
> 
> 2. pipe_write():
>   1). Checks if the pipe is valid and if there is any available
> space in the pipe buffer.
>   2). Waits for buffer space:
>     *If the pipe buffer is full and the reading process has not
> read any data, pipe_write() may put the current process to sleep
> until there is space in the buffer.
>     *If the read end of the pipe is closed (no process is waiting
> to read), an error code -EPIPE is returned, and a SIGPIPE signal may
> be sent to the process.
>   3). Writes data:
>     *If there is enough space in the pipe buffer, pipe_write() copies
> data from the user space buffer to the kernel buffer of the pipe
> (using copy_from_user()).
>     *If the amount of data the user requests to write is larger than
> the available space in the buffer, multiple writes may be required,
> or the process may wait for new space to be freed.
>   4). Wakes up waiting reading processes:
>     *After the data is successfully written, pipe_write() wakes up
> any processes that may be waiting to read data (using the
> wake_up_interruptible_sync_poll() mechanism).
>   5). Returns the number of bytes successfully written.
> 
> Check if there are any waiting processes in the process wait queue
> by introducing wq_has_sleeper() when waking up processes for pipe
> read/write operations.
> 
> If no processes are waiting, there's no need to execute
> wake_up_interruptible_sync_poll(), thus avoiding unnecessary wake-ups.
> 
> Unnecessary wake-ups can lead to context switches, where a process
> is woken up to handle I/O events even when there is no immediate
> need.
> 
> Only wake up processes when there are actually waiting processes to
> reduce context switches and system overhead by checking
> with wq_has_sleeper().
> 
> Additionally, by reducing unnecessary synchronization and wake-up
> operations, wq_has_sleeper() can decrease system resource waste and
> lock contention, improving overall system performance.
> 
> For pipe read/write operations, this eliminates ineffective scheduling
> and enhances concurrency.
> 
> It's important to note that enabling this option means invoking
> wq_has_sleeper() to check for sleeping processes in the wait queue
> for every read or write operation.
> 
> While this is a lightweight operation, it still incurs some overhead.
> 
> In low-load or single-task scenarios, this overhead may not yield
> significant benefits and could even introduce minor performance
> degradation.
> 
> UnixBench Pipe benchmark results on Zhaoxin KX-U6780A processor:
> 
> With the option disabled: Single-core: 841.8, Multi-core (8): 4621.6
> With the option enabled:  Single-core: 877.8, Multi-core (8): 4854.7
> 
> Single-core performance improved by 4.1%, multi-core performance
> improved by 4.8%.

...

> +config PIPE_SKIP_SLEEPER
> +	bool "Skip sleeping processes during pipe read/write"
> +	default n

'n' is the default 'default', no need to have this line.

> +	help
> +	  This option introduces a check whether the sleep queue will
> +	  be awakened during pipe read/write.
> +
> +	  It often leads to a performance improvement. However, in
> +	  low-load or single-task scenarios, it may introduce minor
> +	  performance overhead.

> +	  If unsure, say N.

Illogical, it's already N as you stated by putting a redundant line, but after
removing that line it will make sense.

...

> +static inline bool

Have you build this with Clang and `make W=1 ...`?

> +pipe_check_wq_has_sleeper(struct wait_queue_head *wq_head)
> +{
> +	if (IS_ENABLED(CONFIG_PIPE_SKIP_SLEEPER))
> +		return wq_has_sleeper(wq_head);
> +	else

Redundant.

> +		return true;

	if (!foo)
		return true;

	return bar(...);

> +}

-- 
With Best Regards,
Andy Shevchenko



