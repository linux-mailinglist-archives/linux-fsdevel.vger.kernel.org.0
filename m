Return-Path: <linux-fsdevel+bounces-6393-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17251817969
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Dec 2023 19:13:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78D522831C7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Dec 2023 18:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A2025D75A;
	Mon, 18 Dec 2023 18:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VcKvotVb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A34E5D723
	for <linux-fsdevel@vger.kernel.org>; Mon, 18 Dec 2023 18:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702923174;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cr06QuF3rqXGM0lEDf0Zam9OMb9ZlxtmpjelXPxsrrM=;
	b=VcKvotVbR+wVJvxAdixlUE1wkH7UtbXJXml7CV8bGA71mCkoOd0ZhjNFy8DT2hU2fouOhC
	hnkFbX8zXOcha5GYFHJzJQgUFZY8/Fm6VoWLpJNn6LOxJmCtnPh0EFUXJpr7Fc1OuIcys3
	9fIHNwfg0RVjrpt03tBZnBEoPHmPFEk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-98-x3tSkIYlOTmH7IxH_NaibA-1; Mon,
 18 Dec 2023 13:12:49 -0500
X-MC-Unique: x3tSkIYlOTmH7IxH_NaibA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D939D1C06359;
	Mon, 18 Dec 2023 18:12:47 +0000 (UTC)
Received: from [10.22.32.252] (unknown [10.22.32.252])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9757B2166B31;
	Mon, 18 Dec 2023 18:12:46 +0000 (UTC)
Message-ID: <2ef22a69-e19b-4456-9d01-151c4b4a941e@redhat.com>
Date: Mon, 18 Dec 2023 13:12:46 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 19/50] locking/mutex: split out mutex_types.h
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
To: Kent Overstreet <kent.overstreet@linux.dev>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org
Cc: tglx@linutronix.de, x86@kernel.org, tj@kernel.org, peterz@infradead.org,
 mathieu.desnoyers@efficios.com, paulmck@kernel.org, keescook@chromium.org,
 dave.hansen@linux.intel.com, mingo@redhat.com, will@kernel.org,
 boqun.feng@gmail.com, brauner@kernel.org
References: <20231216024834.3510073-1-kent.overstreet@linux.dev>
 <20231216032651.3553101-1-kent.overstreet@linux.dev>
 <20231216032651.3553101-9-kent.overstreet@linux.dev>
 <7066c278-28e0-45eb-a046-eb684c4a659c@redhat.com>
In-Reply-To: <7066c278-28e0-45eb-a046-eb684c4a659c@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

On 12/15/23 22:26, Kent Overstreet wrote:
> Trimming down sched.h dependencies: we don't want to include more than
> the base types.
>
> Signed-off-by: Kent Overstreet<kent.overstreet@linux.dev>
> Cc: Peter Zijlstra<peterz@infradead.org>
> Cc: Ingo Molnar<mingo@redhat.com>
> Cc: Will Deacon<will@kernel.org>
> Cc: Waiman Long<longman@redhat.com>
> Cc: Boqun Feng<boqun.feng@gmail.com>
> Signed-off-by: Kent Overstreet<kent.overstreet@linux.dev>
> ---
>   include/linux/mutex.h       | 52 +--------------------------
>   include/linux/mutex_types.h | 71 +++++++++++++++++++++++++++++++++++++
>   include/linux/sched.h       |  2 +-
>   3 files changed, 73 insertions(+), 52 deletions(-)
>   create mode 100644 include/linux/mutex_types.h
>
> diff --git a/include/linux/mutex.h b/include/linux/mutex.h
> index a33aa9eb9fc3..0dfba5df6524 100644
> --- a/include/linux/mutex.h
> +++ b/include/linux/mutex.h
> @@ -20,6 +20,7 @@
>   #include <linux/osq_lock.h>
>   #include <linux/debug_locks.h>
>   #include <linux/cleanup.h>
> +#include <linux/mutex_types.h>
>   
>   #ifdef CONFIG_DEBUG_LOCK_ALLOC
>   # define __DEP_MAP_MUTEX_INITIALIZER(lockname)			\
> @@ -33,49 +34,6 @@
>   
>   #ifndef CONFIG_PREEMPT_RT
>   
> -/*
> - * Simple, straightforward mutexes with strict semantics:
> - *
> - * - only one task can hold the mutex at a time
> - * - only the owner can unlock the mutex
> - * - multiple unlocks are not permitted
> - * - recursive locking is not permitted
> - * - a mutex object must be initialized via the API
> - * - a mutex object must not be initialized via memset or copying
> - * - task may not exit with mutex held
> - * - memory areas where held locks reside must not be freed
> - * - held mutexes must not be reinitialized
> - * - mutexes may not be used in hardware or software interrupt
> - *   contexts such as tasklets and timers
> - *
> - * These semantics are fully enforced when DEBUG_MUTEXES is
> - * enabled. Furthermore, besides enforcing the above rules, the mutex
> - * debugging code also implements a number of additional features
> - * that make lock debugging easier and faster:
> - *
> - * - uses symbolic names of mutexes, whenever they are printed in debug output
> - * - point-of-acquire tracking, symbolic lookup of function names
> - * - list of all locks held in the system, printout of them
> - * - owner tracking
> - * - detects self-recursing locks and prints out all relevant info
> - * - detects multi-task circular deadlocks and prints out all affected
> - *   locks and tasks (and only those tasks)
> - */
> -struct mutex {
> -	atomic_long_t		owner;
> -	raw_spinlock_t		wait_lock;
> -#ifdef CONFIG_MUTEX_SPIN_ON_OWNER
> -	struct optimistic_spin_queue osq; /* Spinner MCS lock */
> -#endif
> -	struct list_head	wait_list;
> -#ifdef CONFIG_DEBUG_MUTEXES
> -	void			*magic;
> -#endif
> -#ifdef CONFIG_DEBUG_LOCK_ALLOC
> -	struct lockdep_map	dep_map;
> -#endif
> -};
> -
>   #ifdef CONFIG_DEBUG_MUTEXES
>   
>   #define __DEBUG_MUTEX_INITIALIZER(lockname)				\
> @@ -131,14 +89,6 @@ extern bool mutex_is_locked(struct mutex *lock);
>   /*
>    * Preempt-RT variant based on rtmutexes.
>    */
> -#include <linux/rtmutex.h>

Including rtmutex.h here means that mutex_types.h is no longer a simple 
header for types only. So unless you also break out a rtmutex_types.h, 
it is inconsistent.

Besides, the kernel/sched code does use mutex_lock/unlock calls quite 
frequently. With this patch, mutex.h will not be directly included. I 
suspect that it is indirectly included via other header files. This may 
be an issue with some configurations.

Cheers, Longman


