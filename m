Return-Path: <linux-fsdevel+bounces-6391-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D68CC817821
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Dec 2023 18:06:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEE791C225DE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Dec 2023 17:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 527E04FF98;
	Mon, 18 Dec 2023 17:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lhu2tN4Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431264FF66
	for <linux-fsdevel@vger.kernel.org>; Mon, 18 Dec 2023 17:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702919159;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZHVXfapFaNpskuHSl3q7oII90SEseCDPP+ervZTtQgI=;
	b=Lhu2tN4Zd13tHihsWQ7gfiIRqin+UFcn1fPa/udOQnYWflO7Qp+36dQ8Y390Wzji+fe96i
	ZVT3ZuY9jhbp6Kml2KkTV4Fa/mAyBivXnNC97iX5bGYmv74oQNLHtViGqCfHqxonRiqg3Q
	J6eTCT0ClsSF5zdT+5hXHBaWHECI4Ig=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-uYJsyWyCNqG8vqZW-oOiJw-1; Mon, 18 Dec 2023 12:05:55 -0500
X-MC-Unique: uYJsyWyCNqG8vqZW-oOiJw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 53A27863E88;
	Mon, 18 Dec 2023 17:05:54 +0000 (UTC)
Received: from [10.22.32.252] (unknown [10.22.32.252])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7A88E492BF0;
	Mon, 18 Dec 2023 17:05:53 +0000 (UTC)
Message-ID: <91824e90-0319-467c-a7a7-acda9464a542@redhat.com>
Date: Mon, 18 Dec 2023 12:05:53 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 43/50] lockdep: move held_lock to lockdep_types.h
Content-Language: en-US
To: Kent Overstreet <kent.overstreet@linux.dev>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org
Cc: tglx@linutronix.de, x86@kernel.org, tj@kernel.org, peterz@infradead.org,
 mathieu.desnoyers@efficios.com, paulmck@kernel.org, keescook@chromium.org,
 dave.hansen@linux.intel.com, mingo@redhat.com, will@kernel.org,
 boqun.feng@gmail.com, brauner@kernel.org
References: <20231216024834.3510073-1-kent.overstreet@linux.dev>
 <20231216033300.3553457-1-kent.overstreet@linux.dev>
 <20231216033300.3553457-11-kent.overstreet@linux.dev>
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20231216033300.3553457-11-kent.overstreet@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

On 12/15/23 22:32, Kent Overstreet wrote:
> held_lock is embedded in task_struct, and we don't want sched.h pulling
> in all of lockdep.h
>
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> ---
>   include/linux/lockdep.h       | 57 -----------------------------------
>   include/linux/lockdep_types.h | 57 +++++++++++++++++++++++++++++++++++
>   2 files changed, 57 insertions(+), 57 deletions(-)
>
> diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
> index dc2844b071c2..08b0d1d9d78b 100644
> --- a/include/linux/lockdep.h
> +++ b/include/linux/lockdep.h
> @@ -82,63 +82,6 @@ struct lock_chain {
>   	u64				chain_key;
>   };
>   
> -#define MAX_LOCKDEP_KEYS_BITS		13
> -#define MAX_LOCKDEP_KEYS		(1UL << MAX_LOCKDEP_KEYS_BITS)
> -#define INITIAL_CHAIN_KEY		-1
> -
> -struct held_lock {
> -	/*
> -	 * One-way hash of the dependency chain up to this point. We
> -	 * hash the hashes step by step as the dependency chain grows.
> -	 *
> -	 * We use it for dependency-caching and we skip detection
> -	 * passes and dependency-updates if there is a cache-hit, so
> -	 * it is absolutely critical for 100% coverage of the validator
> -	 * to have a unique key value for every unique dependency path
> -	 * that can occur in the system, to make a unique hash value
> -	 * as likely as possible - hence the 64-bit width.
> -	 *
> -	 * The task struct holds the current hash value (initialized
> -	 * with zero), here we store the previous hash value:
> -	 */
> -	u64				prev_chain_key;
> -	unsigned long			acquire_ip;
> -	struct lockdep_map		*instance;
> -	struct lockdep_map		*nest_lock;
> -#ifdef CONFIG_LOCK_STAT
> -	u64 				waittime_stamp;
> -	u64				holdtime_stamp;
> -#endif
> -	/*
> -	 * class_idx is zero-indexed; it points to the element in
> -	 * lock_classes this held lock instance belongs to. class_idx is in
> -	 * the range from 0 to (MAX_LOCKDEP_KEYS-1) inclusive.
> -	 */
> -	unsigned int			class_idx:MAX_LOCKDEP_KEYS_BITS;
> -	/*
> -	 * The lock-stack is unified in that the lock chains of interrupt
> -	 * contexts nest ontop of process context chains, but we 'separate'
> -	 * the hashes by starting with 0 if we cross into an interrupt
> -	 * context, and we also keep do not add cross-context lock
> -	 * dependencies - the lock usage graph walking covers that area
> -	 * anyway, and we'd just unnecessarily increase the number of
> -	 * dependencies otherwise. [Note: hardirq and softirq contexts
> -	 * are separated from each other too.]
> -	 *
> -	 * The following field is used to detect when we cross into an
> -	 * interrupt context:
> -	 */
> -	unsigned int irq_context:2; /* bit 0 - soft, bit 1 - hard */
> -	unsigned int trylock:1;						/* 16 bits */
> -
> -	unsigned int read:2;        /* see lock_acquire() comment */
> -	unsigned int check:1;       /* see lock_acquire() comment */
> -	unsigned int hardirqs_off:1;
> -	unsigned int sync:1;
> -	unsigned int references:11;					/* 32 bits */
> -	unsigned int pin_count;
> -};
> -
>   /*
>    * Initialization, self-test and debugging-output methods:
>    */
> diff --git a/include/linux/lockdep_types.h b/include/linux/lockdep_types.h
> index 2ebc323d345a..9c533c8d701e 100644
> --- a/include/linux/lockdep_types.h
> +++ b/include/linux/lockdep_types.h
> @@ -198,6 +198,63 @@ struct lockdep_map {
>   
>   struct pin_cookie { unsigned int val; };
>   
> +#define MAX_LOCKDEP_KEYS_BITS		13
> +#define MAX_LOCKDEP_KEYS		(1UL << MAX_LOCKDEP_KEYS_BITS)
> +#define INITIAL_CHAIN_KEY		-1
> +
> +struct held_lock {
> +	/*
> +	 * One-way hash of the dependency chain up to this point. We
> +	 * hash the hashes step by step as the dependency chain grows.
> +	 *
> +	 * We use it for dependency-caching and we skip detection
> +	 * passes and dependency-updates if there is a cache-hit, so
> +	 * it is absolutely critical for 100% coverage of the validator
> +	 * to have a unique key value for every unique dependency path
> +	 * that can occur in the system, to make a unique hash value
> +	 * as likely as possible - hence the 64-bit width.
> +	 *
> +	 * The task struct holds the current hash value (initialized
> +	 * with zero), here we store the previous hash value:
> +	 */
> +	u64				prev_chain_key;
> +	unsigned long			acquire_ip;
> +	struct lockdep_map		*instance;
> +	struct lockdep_map		*nest_lock;
> +#ifdef CONFIG_LOCK_STAT
> +	u64 				waittime_stamp;
> +	u64				holdtime_stamp;
> +#endif
> +	/*
> +	 * class_idx is zero-indexed; it points to the element in
> +	 * lock_classes this held lock instance belongs to. class_idx is in
> +	 * the range from 0 to (MAX_LOCKDEP_KEYS-1) inclusive.
> +	 */
> +	unsigned int			class_idx:MAX_LOCKDEP_KEYS_BITS;
> +	/*
> +	 * The lock-stack is unified in that the lock chains of interrupt
> +	 * contexts nest ontop of process context chains, but we 'separate'
> +	 * the hashes by starting with 0 if we cross into an interrupt
> +	 * context, and we also keep do not add cross-context lock
> +	 * dependencies - the lock usage graph walking covers that area
> +	 * anyway, and we'd just unnecessarily increase the number of
> +	 * dependencies otherwise. [Note: hardirq and softirq contexts
> +	 * are separated from each other too.]
> +	 *
> +	 * The following field is used to detect when we cross into an
> +	 * interrupt context:
> +	 */
> +	unsigned int irq_context:2; /* bit 0 - soft, bit 1 - hard */
> +	unsigned int trylock:1;						/* 16 bits */
> +
> +	unsigned int read:2;        /* see lock_acquire() comment */
> +	unsigned int check:1;       /* see lock_acquire() comment */
> +	unsigned int hardirqs_off:1;
> +	unsigned int sync:1;
> +	unsigned int references:11;					/* 32 bits */
> +	unsigned int pin_count;
> +};
> +
>   #else /* !CONFIG_LOCKDEP */
>   
>   /*
Acked-by: Waiman Long <longman@redhat.com>


