Return-Path: <linux-fsdevel+bounces-20149-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 238348CEE01
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 May 2024 08:00:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 917B21F21C19
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 May 2024 06:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99571BE4B;
	Sat, 25 May 2024 06:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uu/i44jE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F112F34;
	Sat, 25 May 2024 06:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716616830; cv=none; b=Ztix4/5RveczowSHG6t1DE1ouelnjdc82HsUgLR02FHaTtQdFF+TAsdI0tHoLXcBbhHUFLp1zleU6GBYQRvyFrgHSbs0GVY66ecAmCuPieQdPX8BXI61pyORDzgsT0nWduLMciZ3MP8QCk2xkRZjI+KSyGI13SXoCdGSO7eHgoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716616830; c=relaxed/simple;
	bh=AnekiBv9zIubqiPFYx5uilOBhpRrN04OgwZv6c9MNxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ThO6q6768VDVQ0EXXiKCUlJaGfrZu8MmkU7MY+0HnB9xJFyxv/CJY3SogSBkaxSEnGhuDnHsHqvqNXq8zpkaKD0gBLTFs7z6N/x68CujlWthCbqOyrQB8+9he7OmpZVNT2W2DrVmqdTKZ0EBm7jpC2dX0v4uysRXRh5i0yZYbgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uu/i44jE; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2e564cad1f1so109399291fa.0;
        Fri, 24 May 2024 23:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716616826; x=1717221626; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vXlAZP8x0WQzs+EYMU7oj8EUjhwn4wx4bFOBWXPpDO8=;
        b=Uu/i44jEzItjcJuWUVBo9RxB3QwbBYLFEmrXu/vY4XOBBCP1oBFBlzlifS0HnzoLcI
         DIT0WkXyCBrdVn/woBFlyygmV+HO8ruW+ixfsCfq0fk72h6/KVVm/aqYfGNgpvA/Te87
         RyFrxlJf54JQiPvRN788VfysgGmirEVV4hHEcbtIwHY6dm+J5he2oNnxOdPfD99Tooaj
         WfbkNa97McIB4AiN/nuwnUAjIQ2C5caW6cYV7yegZxSNKTBTLDIMltonfPIDXDNsDlQd
         GvLOeKq7UgsM5UJPyiMcDFY4ynVfEqSTOOlXuklRfV6+U0pPKqr7YiNN9lfo1nkL5Mud
         fPVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716616826; x=1717221626;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vXlAZP8x0WQzs+EYMU7oj8EUjhwn4wx4bFOBWXPpDO8=;
        b=h+zl7ftXn8zV8IAXM3mJ3PS0bySykDePW5p1qQfrVSFTT3x1g/xlF+cStpBUU0I1E6
         k/UJNYR87dH/PC4sW1tS7yXGdyeCwhbsmXwC9dTT5Iz7dqN0j/02IbvotaxTz/VzZ8BL
         N4glhAa0BFFsvq8XUao9g+duxDwzVKDCplJDjoNq23un3kAbeukhkiyMArfM7g6JVQn+
         MUiC08qsXi3zpkRYrk+AVdlSEpoWt7lzuZLvSOY+0t+9BEffjMKRwk/ONnwZTpIVW8rv
         iCwHvW9wWXGi3cpQKoxB6kQRDjTiQn1kZthBG7eOSa4oDBJn+ZXx+REH3TwMTT5xPVpA
         /sMw==
X-Forwarded-Encrypted: i=1; AJvYcCWoEgRy0W/Ne1325vv7WeSVVeiH2HGzXp2c2flYsD4DjoBRgs8veJiEadfwvmCiiqVMqRPzSvnl1qE8y/1RmKabEdP2asUxxAIaw13LWzeAG63tOso+wa+AVSlHKLoHBiAYej5AYAxguAabiQ==
X-Gm-Message-State: AOJu0YxBjLYjJaIHTAie6/L3i3Ww5amfgtwF8QrprFEZdMqSSsb13qZ/
	jikVP8c1bOtiHfFl7BWTOXOB/2ICZiiHbh3Laor03ZKpPsUyb7O3
X-Google-Smtp-Source: AGHT+IGoYiPjOhvAnWGMO936kkEj53fcyZhFTMUeyGzjE5/9IMlhqyNx1wEvsi9lMDhBq/CFNmEr4w==
X-Received: by 2002:a2e:8054:0:b0:2e1:aa94:cf48 with SMTP id 38308e7fff4ca-2e95b096c3dmr22772131fa.20.1716616826164;
        Fri, 24 May 2024 23:00:26 -0700 (PDT)
Received: from f (cst-prg-19-178.cust.vodafone.cz. [46.135.19.178])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-579c004108esm55388a12.23.2024.05.24.23.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 23:00:25 -0700 (PDT)
Date: Sat, 25 May 2024 08:00:15 +0200
From: Mateusz Guzik <mjguzik@gmail.com>
To: Hugh Dickins <hughd@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Tim Chen <tim.c.chen@intel.com>, Dave Chinner <dchinner@redhat.com>, 
	"Darrick J. Wong" <djwong@kernel.org>, Christian Brauner <brauner@kernel.org>, 
	Carlos Maiolino <cem@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, Jan Kara <jack@suse.cz>, 
	Matthew Wilcox <willy@infradead.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Subject: Re: [PATCH 8/8] shmem,percpu_counter: add _limited_add(fbc, limit,
 amount)
Message-ID: <jh3yqdz43c24ur7w2jjutyvwodsdccefo6ycmtmjyvh25hojn4@aysycyla6pom>
References: <c7441dc6-f3bb-dd60-c670-9f5cbd9f266@google.com>
 <bb817848-2d19-bcc8-39ca-ea179af0f0b4@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bb817848-2d19-bcc8-39ca-ea179af0f0b4@google.com>

On Fri, Sep 29, 2023 at 08:42:45PM -0700, Hugh Dickins wrote:
> Percpu counter's compare and add are separate functions: without locking
> around them (which would defeat their purpose), it has been possible to
> overflow the intended limit.  Imagine all the other CPUs fallocating
> tmpfs huge pages to the limit, in between this CPU's compare and its add.
> 
> I have not seen reports of that happening; but tmpfs's recent addition
> of dquot_alloc_block_nodirty() in between the compare and the add makes
> it even more likely, and I'd be uncomfortable to leave it unfixed.
> 
> Introduce percpu_counter_limited_add(fbc, limit, amount) to prevent it.
> 

I think the posted (and by now landed) code is racy.

I had seen there was a follow up patch which further augmented the
routine, but it did not alter the issue below so I'm responding to this
thread.

> +/*
> + * Compare counter, and add amount if the total is within limit.
> + * Return true if amount was added, false if it would exceed limit.
> + */
> +bool __percpu_counter_limited_add(struct percpu_counter *fbc,
> +				  s64 limit, s64 amount, s32 batch)
> +{
> +	s64 count;
> +	s64 unknown;
> +	unsigned long flags;
> +	bool good;
> +
> +	if (amount > limit)
> +		return false;
> +
> +	local_irq_save(flags);
> +	unknown = batch * num_online_cpus();
> +	count = __this_cpu_read(*fbc->counters);
> +
> +	/* Skip taking the lock when safe */
> +	if (abs(count + amount) <= batch &&
> +	    fbc->count + unknown <= limit) {
> +		this_cpu_add(*fbc->counters, amount);
> +		local_irq_restore(flags);
> +		return true;
> +	}
> +

Note the value of fbc->count is *not* stabilized.

> +	raw_spin_lock(&fbc->lock);
> +	count = fbc->count + amount;
> +
> +	/* Skip percpu_counter_sum() when safe */
> +	if (count + unknown > limit) {
> +		s32 *pcount;
> +		int cpu;
> +
> +		for_each_cpu_or(cpu, cpu_online_mask, cpu_dying_mask) {
> +			pcount = per_cpu_ptr(fbc->counters, cpu);
> +			count += *pcount;
> +		}
> +	}
> +
> +	good = count <= limit;
> +	if (good) {
> +		count = __this_cpu_read(*fbc->counters);
> +		fbc->count += count + amount;
> +		__this_cpu_sub(*fbc->counters, count);
> +	}
> +
> +	raw_spin_unlock(&fbc->lock);
> +	local_irq_restore(flags);
> +	return good;
> +}
> +

Consider 2 cpus executing the func at the same time, where one is
updating fbc->counter in the slow path while the other is testing it in
the fast path.

cpu0						cpu1
						if (abs(count + amount) <= batch &&				
						    fbc->count + unknown <= limit)
/* gets past the per-cpu traversal */
/* at this point cpu0 decided to bump fbc->count, while cpu1 decided to
 * bump the local counter */
							this_cpu_add(*fbc->counters, amount);
fbc->count += count + amount;

Suppose fbc->count update puts it close enough to the limit that an
addition from cpu1 would put the entire thing over said limit.

Since the 2 operations are not synchronized cpu1 can observe fbc->count
prior to the bump and update it's local counter, resulting in
aforementioned overflow.

Am I misreading something here? Is this prevented?

To my grep the only user is quotas in shmem and I wonder if that use is
even justified. I am aware of performance realities of atomics. However,
it very well may be that whatever codepaths which exercise the counter
are suffering multicore issues elsewhere, making an atomic (in a
dedicated cacheline) a perfectly sane choice for the foreseeable future.
Should this be true there would be 0 rush working out a fixed variant of
the routine.

