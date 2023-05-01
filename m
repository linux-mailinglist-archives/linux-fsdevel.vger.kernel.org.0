Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C179C6F3694
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 May 2023 21:18:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232311AbjEATSc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 May 2023 15:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231229AbjEATSa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 May 2023 15:18:30 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7611510FF;
        Mon,  1 May 2023 12:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=5UxSQNJpFaq+7dWUx985o9MhLzvQlphTHJz1Ql9KvxU=; b=m24iecrtD682Y0avrqU5+JQdF+
        nWZoQBcK2H5OgTG/EBb90D7VsXtt6xEHViWN4TIiZkBrt8C9XLDM/gMEZOQyQwaVeKhc8yKRzSnI1
        EzeIrWxb7TA+gz3k3Q34aDVhSZw8lRJrmIe+wJm7NL0+XOlWQ4vqwT7t6/7ueqwnmAdOpDQn6KWwT
        VkCLthfvJ4YhigT9Gq6pdWYrayOPmOxFENBfusjCeVkthG2cVdNBj1dKAMOInehBlzAmXZWW/R+3X
        q7ZxLkhhzsT169AYNc/Co9NhEJ8a6ViTju2j3HAEdDlsm0enI6uAvqqUbcKqpNak+lVph4GI/UUHe
        1KK6klSw==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1ptZ1u-00GeuY-36;
        Mon, 01 May 2023 19:17:47 +0000
Message-ID: <91a360d3-c876-0a57-5cb1-e3a5f419080d@infradead.org>
Date:   Mon, 1 May 2023 12:17:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 07/40] Lazy percpu counters
Content-Language: en-US
To:     Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org
Cc:     kent.overstreet@linux.dev, mhocko@suse.com, vbabka@suse.cz,
        hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de,
        dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
        corbet@lwn.net, void@manifault.com, peterz@infradead.org,
        juri.lelli@redhat.com, ldufour@linux.ibm.com,
        catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, peterx@redhat.com, david@redhat.com,
        axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org,
        nathan@kernel.org, dennis@kernel.org, tj@kernel.org,
        muchun.song@linux.dev, rppt@kernel.org, paulmck@kernel.org,
        pasha.tatashin@soleen.com, yosryahmed@google.com,
        yuzhao@google.com, dhowells@redhat.com, hughd@google.com,
        andreyknvl@gmail.com, keescook@chromium.org,
        ndesaulniers@google.com, gregkh@linuxfoundation.org,
        ebiggers@google.com, ytcoode@gmail.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        bristot@redhat.com, vschneid@redhat.com, cl@linux.com,
        penberg@kernel.org, iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com,
        glider@google.com, elver@google.com, dvyukov@google.com,
        shakeelb@google.com, songmuchun@bytedance.com, jbaron@akamai.com,
        rientjes@google.com, minchan@google.com, kaleshsingh@google.com,
        kernel-team@android.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-modules@vger.kernel.org,
        kasan-dev@googlegroups.com, cgroups@vger.kernel.org
References: <20230501165450.15352-1-surenb@google.com>
 <20230501165450.15352-8-surenb@google.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230501165450.15352-8-surenb@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi--

On 5/1/23 09:54, Suren Baghdasaryan wrote:
> From: Kent Overstreet <kent.overstreet@linux.dev>
> 
> This patch adds lib/lazy-percpu-counter.c, which implements counters
> that start out as atomics, but lazily switch to percpu mode if the
> update rate crosses some threshold (arbitrarily set at 256 per second).
> 

from submitting-patches.rst:

Describe your changes in imperative mood, e.g. "make xyzzy do frotz"
instead of "[This patch] makes xyzzy do frotz" or "[I] changed xyzzy
to do frotz", as if you are giving orders to the codebase to change
its behaviour.

> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> ---
>  include/linux/lazy-percpu-counter.h | 102 ++++++++++++++++++++++
>  lib/Kconfig                         |   3 +
>  lib/Makefile                        |   2 +
>  lib/lazy-percpu-counter.c           | 127 ++++++++++++++++++++++++++++
>  4 files changed, 234 insertions(+)
>  create mode 100644 include/linux/lazy-percpu-counter.h
>  create mode 100644 lib/lazy-percpu-counter.c
> 
> diff --git a/include/linux/lazy-percpu-counter.h b/include/linux/lazy-percpu-counter.h
> new file mode 100644
> index 000000000000..45ca9e2ce58b
> --- /dev/null
> +++ b/include/linux/lazy-percpu-counter.h
> @@ -0,0 +1,102 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Lazy percpu counters:
> + * (C) 2022 Kent Overstreet
> + *
> + * Lazy percpu counters start out in atomic mode, then switch to percpu mode if
> + * the update rate crosses some threshold.
> + *
> + * This means we don't have to decide between low memory overhead atomic
> + * counters and higher performance percpu counters - we can have our cake and
> + * eat it, too!
> + *
> + * Internally we use an atomic64_t, where the low bit indicates whether we're in
> + * percpu mode, and the high 8 bits are a secondary counter that's incremented
> + * when the counter is modified - meaning 55 bits of precision are available for
> + * the counter itself.
> + */
> +
> +#ifndef _LINUX_LAZY_PERCPU_COUNTER_H
> +#define _LINUX_LAZY_PERCPU_COUNTER_H
> +
> +#include <linux/atomic.h>
> +#include <asm/percpu.h>
> +
> +struct lazy_percpu_counter {
> +	atomic64_t			v;
> +	unsigned long			last_wrap;
> +};
> +
> +void lazy_percpu_counter_exit(struct lazy_percpu_counter *c);
> +void lazy_percpu_counter_add_slowpath(struct lazy_percpu_counter *c, s64 i);
> +void lazy_percpu_counter_add_slowpath_noupgrade(struct lazy_percpu_counter *c, s64 i);
> +s64 lazy_percpu_counter_read(struct lazy_percpu_counter *c);
> +
> +/*
> + * We use the high bits of the atomic counter for a secondary counter, which is
> + * incremented every time the counter is touched. When the secondary counter
> + * wraps, we check the time the counter last wrapped, and if it was recent
> + * enough that means the update frequency has crossed our threshold and we
> + * switch to percpu mode:
> + */
> +#define COUNTER_MOD_BITS		8
> +#define COUNTER_MOD_MASK		~(~0ULL >> COUNTER_MOD_BITS)
> +#define COUNTER_MOD_BITS_START		(64 - COUNTER_MOD_BITS)
> +
> +/*
> + * We use the low bit of the counter to indicate whether we're in atomic mode
> + * (low bit clear), or percpu mode (low bit set, counter is a pointer to actual
> + * percpu counters:
> + */
> +#define COUNTER_IS_PCPU_BIT		1
> +
> +static inline u64 __percpu *lazy_percpu_counter_is_pcpu(u64 v)
> +{
> +	if (!(v & COUNTER_IS_PCPU_BIT))
> +		return NULL;
> +
> +	v ^= COUNTER_IS_PCPU_BIT;
> +	return (u64 __percpu *)(unsigned long)v;
> +}
> +
> +/**
> + * lazy_percpu_counter_add: Add a value to a lazy_percpu_counter

For kernel-doc, the function name should be followed by '-', not ':'.
(many places)

> + *
> + * @c: counter to modify
> + * @i: value to add
> + */
> +static inline void lazy_percpu_counter_add(struct lazy_percpu_counter *c, s64 i)
> +{
> +	u64 v = atomic64_read(&c->v);
> +	u64 __percpu *pcpu_v = lazy_percpu_counter_is_pcpu(v);
> +
> +	if (likely(pcpu_v))
> +		this_cpu_add(*pcpu_v, i);
> +	else
> +		lazy_percpu_counter_add_slowpath(c, i);
> +}
> +
> +/**
> + * lazy_percpu_counter_add_noupgrade: Add a value to a lazy_percpu_counter,
> + * without upgrading to percpu mode
> + *
> + * @c: counter to modify
> + * @i: value to add
> + */
> +static inline void lazy_percpu_counter_add_noupgrade(struct lazy_percpu_counter *c, s64 i)
> +{
> +	u64 v = atomic64_read(&c->v);
> +	u64 __percpu *pcpu_v = lazy_percpu_counter_is_pcpu(v);
> +
> +	if (likely(pcpu_v))
> +		this_cpu_add(*pcpu_v, i);
> +	else
> +		lazy_percpu_counter_add_slowpath_noupgrade(c, i);
> +}
> +
> +static inline void lazy_percpu_counter_sub(struct lazy_percpu_counter *c, s64 i)
> +{
> +	lazy_percpu_counter_add(c, -i);
> +}
> +
> +#endif /* _LINUX_LAZY_PERCPU_COUNTER_H */

> diff --git a/lib/lazy-percpu-counter.c b/lib/lazy-percpu-counter.c
> new file mode 100644
> index 000000000000..4f4e32c2dc09
> --- /dev/null
> +++ b/lib/lazy-percpu-counter.c
> @@ -0,0 +1,127 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include <linux/atomic.h>
> +#include <linux/gfp.h>
> +#include <linux/jiffies.h>
> +#include <linux/lazy-percpu-counter.h>
> +#include <linux/percpu.h>
> +
> +static inline s64 lazy_percpu_counter_atomic_val(s64 v)
> +{
> +	/* Ensure output is sign extended properly: */
> +	return (v << COUNTER_MOD_BITS) >>
> +		(COUNTER_MOD_BITS + COUNTER_IS_PCPU_BIT);
> +}
> +
...
> +
> +/**
> + * lazy_percpu_counter_exit: Free resources associated with a
> + * lazy_percpu_counter

Same kernel-doc comment.

> + *
> + * @c: counter to exit
> + */
> +void lazy_percpu_counter_exit(struct lazy_percpu_counter *c)
> +{
> +	free_percpu(lazy_percpu_counter_is_pcpu(atomic64_read(&c->v)));
> +}
> +EXPORT_SYMBOL_GPL(lazy_percpu_counter_exit);
> +
> +/**
> + * lazy_percpu_counter_read: Read current value of a lazy_percpu_counter
> + *
> + * @c: counter to read
> + */
> +s64 lazy_percpu_counter_read(struct lazy_percpu_counter *c)
> +{
> +	s64 v = atomic64_read(&c->v);
> +	u64 __percpu *pcpu_v = lazy_percpu_counter_is_pcpu(v);
> +
> +	if (pcpu_v) {
> +		int cpu;
> +
> +		v = 0;
> +		for_each_possible_cpu(cpu)
> +			v += *per_cpu_ptr(pcpu_v, cpu);
> +	} else {
> +		v = lazy_percpu_counter_atomic_val(v);
> +	}
> +
> +	return v;
> +}
> +EXPORT_SYMBOL_GPL(lazy_percpu_counter_read);
> +
> +void lazy_percpu_counter_add_slowpath(struct lazy_percpu_counter *c, s64 i)
> +{
> +	u64 atomic_i;
> +	u64 old, v = atomic64_read(&c->v);
> +	u64 __percpu *pcpu_v;
> +
> +	atomic_i  = i << COUNTER_IS_PCPU_BIT;
> +	atomic_i &= ~COUNTER_MOD_MASK;
> +	atomic_i |= 1ULL << COUNTER_MOD_BITS_START;
> +
> +	do {
> +		pcpu_v = lazy_percpu_counter_is_pcpu(v);
> +		if (pcpu_v) {
> +			this_cpu_add(*pcpu_v, i);
> +			return;
> +		}
> +
> +		old = v;
> +	} while ((v = atomic64_cmpxchg(&c->v, old, old + atomic_i)) != old);
> +
> +	if (unlikely(!(v & COUNTER_MOD_MASK))) {
> +		unsigned long now = jiffies;
> +
> +		if (c->last_wrap &&
> +		    unlikely(time_after(c->last_wrap + HZ, now)))
> +			lazy_percpu_counter_switch_to_pcpu(c);
> +		else
> +			c->last_wrap = now;
> +	}
> +}
> +EXPORT_SYMBOL(lazy_percpu_counter_add_slowpath);
> +
> +void lazy_percpu_counter_add_slowpath_noupgrade(struct lazy_percpu_counter *c, s64 i)
> +{
> +	u64 atomic_i;
> +	u64 old, v = atomic64_read(&c->v);
> +	u64 __percpu *pcpu_v;
> +
> +	atomic_i  = i << COUNTER_IS_PCPU_BIT;
> +	atomic_i &= ~COUNTER_MOD_MASK;
> +
> +	do {
> +		pcpu_v = lazy_percpu_counter_is_pcpu(v);
> +		if (pcpu_v) {
> +			this_cpu_add(*pcpu_v, i);
> +			return;
> +		}
> +
> +		old = v;
> +	} while ((v = atomic64_cmpxchg(&c->v, old, old + atomic_i)) != old);
> +}
> +EXPORT_SYMBOL(lazy_percpu_counter_add_slowpath_noupgrade);

These last 2 exported functions could use some comments, preferably in
kernel-doc format.

Thanks.
-- 
~Randy
