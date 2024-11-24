Return-Path: <linux-fsdevel+bounces-35671-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8057E9D70C2
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2024 14:39:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D86028241C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2024 13:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAB041BC063;
	Sun, 24 Nov 2024 13:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="axu04URF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7099F18A6BC;
	Sun, 24 Nov 2024 13:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455259; cv=none; b=IyTcXnvGBhnJd7TlCinHzwzJAGWvyHX27grVwjnkLA1yn6yTyew3fp+6hNFERTvH6pxwj+fM8oYpAdQiFfCoD45VFV8On24EA5MofPOnzf/HWJj92tZuSdI2jFxwvLB1O32+L6jtC5UngXiwA0SVPg2HSuutPqWlyBPzaPWD9YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455259; c=relaxed/simple;
	bh=Uk6qoM3/bi3PrMVZDpuNfQE44d1ttBqWG2E468pnZ/E=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=cfbh0Sc0HF/osC9fWkzRZNzab1fhTeZnAkmQ6n+Otv4XIA/oCAo3R8QXoPmKQKO4cOJKFdx7sdRVugzIBIwOu1j+6VAU+Q+qUCoHfjRD8ewoCKK3aVuwYad7peaccE4hNCUjvUtp/yy5hi4ox6SMuO99CTXanZyBO7hGU4RlLpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=axu04URF; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2126e293192so7039615ad.0;
        Sun, 24 Nov 2024 05:34:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732455257; x=1733060057; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qtitWj7mwZUOuapDYi1rlQN8mBEo2KiG1ezv0q6gsEE=;
        b=axu04URFhBpwR/Ea6AeSmDS8gwu7/uzyiYbLurQf9eCHnJGwc1lrHLryVF53eHvj0T
         Qe4Mw1AF+DyfPQ/iJt/RnbXBHZV/vD2hceFnX9VEeYqehldovrGlwuI5CqvJxqOQRqgW
         Ex9Bt8cmfQ8rydFLU6JM/4B/oVhrPFWc51xGTxrCbxzf5b5GpdGNuaQlUbCnL+OVjr93
         YUXYdGxoKGW91ljazTcwVZZC9KE7xJHr0+csYMRFty84oSHWo7YTYekQr3NmiBpyJHDi
         x5vMBg1aKop4TNyuAFDcxNNLUIY6gWWPq9yi0B5bPp7j1/f8YD88MXeu9dXdmmqRsClZ
         yM8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732455257; x=1733060057;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qtitWj7mwZUOuapDYi1rlQN8mBEo2KiG1ezv0q6gsEE=;
        b=Q7bsBE/MmH+G9oEu7ZeovFPhry0X76W1eIHadFyJGNMD5nUOk1T6rQVVXhJWLYIfZk
         8os1rATfHTYWVx2dDjqgIvawfFlJ1ikUXG25fEtAYI6Pq0edub8OVd89kB1UYBBC1baz
         /HlS5n1yBxHGDMmP/CCAlu4JWnpkg52tKC2g60TogOZjAX+IJBFfk5/rsk15YI7b+MjZ
         6cm8syA8n72O5C2x5IvJTBmhVcHYJLAFFBzkRsdNurCeAD9vaGaSX4jpDUP6FBlrMqq0
         8P+LuT/DOlC/pHQ8/YB/xnivEfSH6vcBz3FRKIZHeKuc8Jy9+bXx2VYhtpHo5ZJXcAy1
         Bdkw==
X-Forwarded-Encrypted: i=1; AJvYcCUqUFv8VaDe6IYeaO2F43oLhfZ4VrFVlC1/hqafrLOmJHCJL451rLahhIIqu+CSkwycxRpeMCbuT7k2eg==@vger.kernel.org, AJvYcCUw6Bt7T6Bz0KEDqWwvT/z3HtqwXYe0t+7u0yLaS9sZEkYSy4sP/FBKbuPiDGA+MTILZ3SUmrDp/Q4sYMzFGQ==@vger.kernel.org, AJvYcCVrursYBu2zs+8Xq8RqZiieblCyjuJ9S86+uDkIo92ItJ0o24eCY+dSZuImIDftgg1cwJRuCjPutWrE@vger.kernel.org, AJvYcCXk97jTnGzcvP8hohvl8a6g/kfUFMtovfTPjdiY1wMjd3eAr0nh/yGpHYzea4eDyifMMvwaSq6Q8Lp7KQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzGU6o+RjTW5PmTWn3c2EDr+jrmmg7yf/D3AIp4Yzl0TM8UKdDe
	s8EJWaNMjp5pqRlIpkWFUEetTIX7d+GffowfJRoGLEkW8AuTT1y5
X-Gm-Gg: ASbGncu9+4Ncxqj+r8otf815/jiPaqW7+TYQ4LXgluZ9kq7kuoaiZ2uHU3eKThUrien
	FxNdLtZx7p37E1Kpz4EL75YRz3rII7m5OSCYkWi18thvCdSxOqfOu2yvI+QTiZjiAGWICRZPnxn
	me0lSeBLCyf0oDnUz8y7fudxoPx7yjd3pfjCkW7q2Tsj6kHbkd/lZXi6zhXxYMaYhtBjWdCE9o2
	czoE9M8BQYPvvfo5M7mzuc/s839WLcX6/HMrwcpzU2JhuHVoiBQUEeruGRxpQ==
X-Google-Smtp-Source: AGHT+IHLvekYbaPwVuQbj7uVMH6+WJbm/aay5oOW+hS7R6I1jLZXbkDtIA8gi64je3notGAilm7kDw==
X-Received: by 2002:a05:6a20:3d8d:b0:1dc:77fc:1cd1 with SMTP id adf61e73a8af0-1e09e4004cfmr5341156637.3.1732455256584;
        Sun, 24 Nov 2024 05:34:16 -0800 (PST)
Received: from [192.168.50.136] ([118.32.98.101])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724ed55099asm3151173b3a.49.2024.11.24.05.34.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Nov 2024 05:34:16 -0800 (PST)
Message-ID: <489d941f-c4e8-4d1f-92ee-02074c713dd1@gmail.com>
Date: Sun, 24 Nov 2024 22:34:02 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 2/28] dept: Implement Dept(Dependency Tracker)
To: Byungchul Park <byungchul@sk.com>
References: <20240508094726.35754-3-byungchul@sk.com>
Content-Language: en-US
Cc: LKML <linux-kernel@vger.kernel.org>, kernel_team@skhynix.com,
 torvalds@linux-foundation.org, damien.lemoal@opensource.wdc.com,
 linux-ide@vger.kernel.org, adilger.kernel@dilger.ca,
 linux-ext4@vger.kernel.org, mingo@redhat.com, peterz@infradead.org,
 will@kernel.org, tglx@linutronix.de, rostedt@goodmis.org,
 joel@joelfernandes.org, sashal@kernel.org, daniel.vetter@ffwll.ch,
 duyuyang@gmail.com, johannes.berg@intel.com, tj@kernel.org, tytso@mit.edu,
 willy@infradead.org, david@fromorbit.com, amir73il@gmail.com,
 gregkh@linuxfoundation.org, kernel-team@lge.com, linux-mm@kvack.org,
 akpm@linux-foundation.org, mhocko@kernel.org, minchan@kernel.org,
 hannes@cmpxchg.org, vdavydov.dev@gmail.com, sj@kernel.org,
 jglisse@redhat.com, dennis@kernel.org, cl@linux.com, penberg@kernel.org,
 rientjes@google.com, vbabka@suse.cz, ngupta@vflare.org,
 linux-block@vger.kernel.org, josef@toxicpanda.com,
 linux-fsdevel@vger.kernel.org, jack@suse.cz, jlayton@kernel.org,
 dan.j.williams@intel.com, hch@infradead.org, djwong@kernel.org,
 dri-devel@lists.freedesktop.org, rodrigosiqueiramelo@gmail.com,
 melissa.srw@gmail.com, hamohammed.sa@gmail.com, 42.hyeyoo@gmail.com,
 chris.p.wilson@intel.com, gwan-gyeong.mun@intel.com,
 max.byungchul.park@gmail.com, boqun.feng@gmail.com, longman@redhat.com,
 hdanton@sina.com, her0gyugyu@gmail.com, Yeoreum Yun <yeoreum.yun@arm.com>
From: Yunseong Kim <yskelg@gmail.com>
In-Reply-To: <20240508094726.35754-3-byungchul@sk.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Byungchul,

Thank you for the great feature. Currently, DEPT has a bug in the
'dept_key_destroy()' function that must be fixed to ensure proper
operation in the upstream Linux kernel.

On 5/8/24 6:46 오후, Byungchul Park wrote:
> CURRENT STATUS
> --------------
> Lockdep tracks acquisition order of locks in order to detect deadlock,
> and IRQ and IRQ enable/disable state as well to take accident
> acquisitions into account.
> 
> Lockdep should be turned off once it detects and reports a deadlock
> since the data structure and algorithm are not reusable after detection
> because of the complex design.
> 
> PROBLEM
> -------
> *Waits* and their *events* that never reach eventually cause deadlock.
> However, Lockdep is only interested in lock acquisition order, forcing
> to emulate lock acqusition even for just waits and events that have
> nothing to do with real lock.
> 
> Even worse, no one likes Lockdep's false positive detection because that
> prevents further one that might be more valuable. That's why all the
> kernel developers are sensitive to Lockdep's false positive.
> 
> Besides those, by tracking acquisition order, it cannot correctly deal
> with read lock and cross-event e.g. wait_for_completion()/complete() for
> deadlock detection. Lockdep is no longer a good tool for that purpose.
> 
> SOLUTION
> --------
> Again, *waits* and their *events* that never reach eventually cause
> deadlock. The new solution, Dept(DEPendency Tracker), focuses on waits
> and events themselves. Dept tracks waits and events and report it if
> any event would be never reachable.
> 
> Dept does:
>    . Works with read lock in the right way.
>    . Works with any wait and event e.i. cross-event.
>    . Continue to work even after reporting multiple times.
>    . Provides simple and intuitive APIs.
>    . Does exactly what dependency checker should do.
> 
> Q & A
> -----
> Q. Is this the first try ever to address the problem?
> A. No. Cross-release feature (b09be676e0ff2 locking/lockdep: Implement
>    the 'crossrelease' feature) addressed it 2 years ago that was a
>    Lockdep extension and merged but reverted shortly because:
> 
>    Cross-release started to report valuable hidden problems but started
>    to give report false positive reports as well. For sure, no one
>    likes Lockdep's false positive reports since it makes Lockdep stop,
>    preventing reporting further real problems.
> 
> Q. Why not Dept was developed as an extension of Lockdep?
> A. Lockdep definitely includes all the efforts great developers have
>    made for a long time so as to be quite stable enough. But I had to
>    design and implement newly because of the following:
> 
>    1) Lockdep was designed to track lock acquisition order. The APIs and
>       implementation do not fit on wait-event model.
>    2) Lockdep is turned off on detection including false positive. Which
>       is terrible and prevents developing any extension for stronger
>       detection.
> 
> Q. Do you intend to totally replace Lockdep?
> A. No. Lockdep also checks if lock usage is correct. Of course, the
>    dependency check routine should be replaced but the other functions
>    should be still there.
> 
> Q. Do you mean the dependency check routine should be replaced right
>    away?
> A. No. I admit Lockdep is stable enough thanks to great efforts kernel
>    developers have made. Lockdep and Dept, both should be in the kernel
>    until Dept gets considered stable.
> 
> Q. Stronger detection capability would give more false positive report.
>    Which was a big problem when cross-release was introduced. Is it ok
>    with Dept?
> A. It's ok. Dept allows multiple reporting thanks to simple and quite
>    generalized design. Of course, false positive reports should be fixed
>    anyway but it's no longer as a critical problem as it was.
> 
> Signed-off-by: Byungchul Park <byungchul@sk.com>

If a module previously checked for dependencies by DEPT is loaded and
then would be unloaded, a kernel panic shall occur when the kernel
reuses the corresponding memory area for other purposes. This issue must
be addressed as a priority to enable the use of DEPT. Testing this patch
on the Ubuntu kernel confirms the problem.

> +void dept_key_destroy(struct dept_key *k)
> +{
> +	struct dept_task *dt = dept_task();
> +	unsigned long flags;
> +	int sub_id;
> +
> +	if (unlikely(!dept_working()))
> +		return;
> +
> +	if (dt->recursive == 1 && dt->task_exit) {
> +		/*
> +		 * Need to allow to go ahead in this case where
> +		 * ->recursive has been set to 1 by dept_off() in
> +		 * dept_task_exit() and ->task_exit has been set to
> +		 * true in dept_task_exit().
> +		 */
> +	} else if (dt->recursive) {
> +		DEPT_STOP("Key destroying fails.\n");
> +		return;
> +	}
> +
> +	flags = dept_enter();
> +
> +	/*
> +	 * dept_key_destroy() should not fail.
> +	 *
> +	 * FIXME: Should be fixed if dept_key_destroy() causes deadlock
> +	 * with dept_lock().
> +	 */
> +	while (unlikely(!dept_lock()))
> +		cpu_relax();
> +
> +	for (sub_id = 0; sub_id < DEPT_MAX_SUBCLASSES; sub_id++) {
> +		struct dept_class *c;
> +
> +		c = lookup_class((unsigned long)k->base + sub_id);
> +		if (!c)
> +			continue;
> +
> +		hash_del_class(c);
> +		disconnect_class(c);
> +		list_del(&c->all_node);
> +		invalidate_class(c);
> +
> +		/*
> +		 * Actual deletion will happen on the rcu callback
> +		 * that has been added in disconnect_class().
> +		 */
> +		del_class(c);
> +	}
> +
> +	dept_unlock();
> +	dept_exit(flags);
> +
> +	/*
> +	 * Wait until even lockless hash_lookup_class() for the class
> +	 * returns NULL.
> +	 */
> +	might_sleep();
> +	synchronize_rcu();
> +}
> +EXPORT_SYMBOL_GPL(dept_key_destroy);

Best regards,
Yunseong Kim

