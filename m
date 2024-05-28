Return-Path: <linux-fsdevel+bounces-20352-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A7FC8D1D54
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 15:46:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 124501C22593
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 13:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C18AD16F832;
	Tue, 28 May 2024 13:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lDODKE0/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A74816F0F9;
	Tue, 28 May 2024 13:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716903975; cv=none; b=eBFsVK8TUM8KLt6Pjk88c5lmJ0GNCmnbr914IDyC0LLPQoU3FfGS53HCt7WGCVx8P1CZ27YS2kE99+z95k6+jeCRTJy8B8FURv9gBHx+t7sxTTCvhTlFABK88mUgkdpWvZp46y8htw439l4PY9MDSkjZgmnBU9nHeXOBDXok5b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716903975; c=relaxed/simple;
	bh=iAe9634y6mwsByWHP2Co4adLQb1gGBm5cDhpRhEEFzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cCg/w7DKVHVnCvJV99fH5bCECmo4h2DiPdkkXondSHLZ4xGMTwWM2/qsOwXP1feNZ/Wh+d5FMXwAF2mq+2D31N9Vf4Xqd+whTSJ6I3JXXIJV/FE0lWxXEmQV9I1aIf+nyVnezr8bz5wftpRveUugOREPQ+1UxFdZTubCo1fA9ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lDODKE0/; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-420180b5898so5767505e9.2;
        Tue, 28 May 2024 06:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716903972; x=1717508772; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=30xqSKjOjXw7Y7njzyhoanyTf4RRJTROvAjzt4LX46I=;
        b=lDODKE0/RelM5Xch6rIXaRAgivGMsrcVaN1wN1v5U6EGVaJDaO+zCz0ImnxdXgxXDL
         l4trMOLc340LA+QBmMQZP3DinivK3VjQQTOBEmuZkrDxD3U9J/j1u+k5uLylin4JYdFx
         ft0mqThoXveE7PL9T7+FwTu4kykHPItE+lS8/rwDcXcKb5Y28y843LX1yek2vHdJXkby
         QNMSleNBQssFdSB6qhqADTsz9psc+EvtjNQe3Tn7zgqzbUCYWXipvZiPJei9wlYFcjcR
         UvQ6UOFaJnfjLvjAzTcQPyfiFy71Hqe6d45C0laja/LWh4Zhrhu5iH/XULK0pNBNjo9N
         0qRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716903972; x=1717508772;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=30xqSKjOjXw7Y7njzyhoanyTf4RRJTROvAjzt4LX46I=;
        b=F4KZKpjk54eJ0AeNevV9U/I+w9owQni210C6AbrohcNikanFyfyZxVVBbbIj6m7Oik
         TnRpvqry75ZJWtpJi06ECjYqSYO5zxzeQhpsyNwH01xqSfiWful3c9w5HqcEAknas2vq
         3tWxOrIHdZ6zVXmuPkreropZW9FCmsgW/AivV/awzevmP8QRjN9gvSTRwKOwST6SPyDU
         VgDbHhLJB5Aff3PO5/Un13MtnxXxbYh4FN2XdAv0r7Uo//EOSIqiLijqKmpsTyQfXqYg
         JQqjzJv1cSOTf6XpU1UhIQoipY6og5js01IOSoNK0BF/WYDzL9hq99yt7WpuCFvvjq1z
         JHGg==
X-Forwarded-Encrypted: i=1; AJvYcCWCiPEu3pv37ZM+GOLpRpU/O4RsvaIeL1hMy1fVtNqZ24lxmc1zDLp2wCyw0Fexx4FFB6KIMnwWN7lZjo5QJqz02GDFp9X3YZJy9nvp6Phz5WoQISjQt7vUEk080pSBzMSbm1CMvcmRPY7JdA==
X-Gm-Message-State: AOJu0YwPyInNwhqHcMlwjTNxp69fl6v+Fms7udxzlBxaVw7PlNISVchf
	RVM5LV0t6iwBVOWO1zBgG+XWib7xjsrnEq6XogxD822Be2HKeagI
X-Google-Smtp-Source: AGHT+IEngAtN70Li5molD+j7snS98JGFYbHNecNTW6v/xiqDVGMoFnXuoLD/EeV3zEBe4zC4g9taDA==
X-Received: by 2002:a1c:7902:0:b0:41b:c024:8e88 with SMTP id 5b1f17b1804b1-42108a0dc79mr77304435e9.33.1716903971518;
        Tue, 28 May 2024 06:46:11 -0700 (PDT)
Received: from f (cst-prg-92-138.cust.vodafone.cz. [46.135.92.138])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-421089ae960sm142726565e9.31.2024.05.28.06.46.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 06:46:09 -0700 (PDT)
Date: Tue, 28 May 2024 15:44:44 +0200
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
Message-ID: <5eemkb4lo5eefp7ijgncgogwmadyzmvjfjmmmvfiki6cwdskfs@hi2z4drqeuz6>
References: <c7441dc6-f3bb-dd60-c670-9f5cbd9f266@google.com>
 <bb817848-2d19-bcc8-39ca-ea179af0f0b4@google.com>
 <jh3yqdz43c24ur7w2jjutyvwodsdccefo6ycmtmjyvh25hojn4@aysycyla6pom>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <jh3yqdz43c24ur7w2jjutyvwodsdccefo6ycmtmjyvh25hojn4@aysycyla6pom>

On Sat, May 25, 2024 at 08:00:15AM +0200, Mateusz Guzik wrote:
> On Fri, Sep 29, 2023 at 08:42:45PM -0700, Hugh Dickins wrote:
> > Percpu counter's compare and add are separate functions: without locking
> > around them (which would defeat their purpose), it has been possible to
> > overflow the intended limit.  Imagine all the other CPUs fallocating
> > tmpfs huge pages to the limit, in between this CPU's compare and its add.
> > 
> > I have not seen reports of that happening; but tmpfs's recent addition
> > of dquot_alloc_block_nodirty() in between the compare and the add makes
> > it even more likely, and I'd be uncomfortable to leave it unfixed.
> > 
> > Introduce percpu_counter_limited_add(fbc, limit, amount) to prevent it.
> > 
> 
> I think the posted (and by now landed) code is racy.
> 
> I had seen there was a follow up patch which further augmented the
> routine, but it did not alter the issue below so I'm responding to this
> thread.
> 
> > +/*
> > + * Compare counter, and add amount if the total is within limit.
> > + * Return true if amount was added, false if it would exceed limit.
> > + */
> > +bool __percpu_counter_limited_add(struct percpu_counter *fbc,
> > +				  s64 limit, s64 amount, s32 batch)
> > +{
> > +	s64 count;
> > +	s64 unknown;
> > +	unsigned long flags;
> > +	bool good;
> > +
> > +	if (amount > limit)
> > +		return false;
> > +
> > +	local_irq_save(flags);
> > +	unknown = batch * num_online_cpus();
> > +	count = __this_cpu_read(*fbc->counters);
> > +
> > +	/* Skip taking the lock when safe */
> > +	if (abs(count + amount) <= batch &&
> > +	    fbc->count + unknown <= limit) {
> > +		this_cpu_add(*fbc->counters, amount);
> > +		local_irq_restore(flags);
> > +		return true;
> > +	}
> > +
> 
> Note the value of fbc->count is *not* stabilized.
> 
> > +	raw_spin_lock(&fbc->lock);
> > +	count = fbc->count + amount;
> > +
> > +	/* Skip percpu_counter_sum() when safe */
> > +	if (count + unknown > limit) {
> > +		s32 *pcount;
> > +		int cpu;
> > +
> > +		for_each_cpu_or(cpu, cpu_online_mask, cpu_dying_mask) {
> > +			pcount = per_cpu_ptr(fbc->counters, cpu);
> > +			count += *pcount;
> > +		}
> > +	}
> > +
> > +	good = count <= limit;
> > +	if (good) {
> > +		count = __this_cpu_read(*fbc->counters);
> > +		fbc->count += count + amount;
> > +		__this_cpu_sub(*fbc->counters, count);
> > +	}
> > +
> > +	raw_spin_unlock(&fbc->lock);
> > +	local_irq_restore(flags);
> > +	return good;
> > +}
> > +
> 
> Consider 2 cpus executing the func at the same time, where one is
> updating fbc->counter in the slow path while the other is testing it in
> the fast path.
> 
> cpu0						cpu1
> 						if (abs(count + amount) <= batch &&				
> 						    fbc->count + unknown <= limit)
> /* gets past the per-cpu traversal */
> /* at this point cpu0 decided to bump fbc->count, while cpu1 decided to
>  * bump the local counter */
> 							this_cpu_add(*fbc->counters, amount);
> fbc->count += count + amount;
> 
> Suppose fbc->count update puts it close enough to the limit that an
> addition from cpu1 would put the entire thing over said limit.
> 
> Since the 2 operations are not synchronized cpu1 can observe fbc->count
> prior to the bump and update it's local counter, resulting in
> aforementioned overflow.
> 
> Am I misreading something here? Is this prevented?
> 
> To my grep the only user is quotas in shmem and I wonder if that use is
> even justified. I am aware of performance realities of atomics. However,
> it very well may be that whatever codepaths which exercise the counter
> are suffering multicore issues elsewhere, making an atomic (in a
> dedicated cacheline) a perfectly sane choice for the foreseeable future.
> Should this be true there would be 0 rush working out a fixed variant of
> the routine.

So I tried it out and I don't believe a per-cpu counter for mem usage of
shmem is warranted at this time. In a setting where usage keeps changing
there is a massive bottleneck around folio_lruvec_lock.

The rare case where a bunch of memory is just populated one off on a
tmpfs mount can probably suffer the atomic, it can only go so far up
before you are out of memory.

For the value to keep changing some of the pages will have to be
released and this is what I'm testing below by slapping ftruncate on a
test doing 1MB file writes in a loop (in will-it-scale):

diff --git a/tests/write1.c b/tests/write1.c
index d860904..790ddb3 100644
--- a/tests/write1.c
+++ b/tests/write1.c
@@ -28,6 +28,7 @@ void testcase(unsigned long long *iterations, unsigned long nr)
                        size = 0;
                        lseek(fd, 0, SEEK_SET);
                }
+               ftruncate(fd, 0);

                (*iterations)++;
        }

That this is allocates pages for 1MB size and releases them continously.

When mounting tmpfs on /tmp and benching with "./write1_processes -t 20"
(20 workers) I see almost all of the time spent spinning in
__pv_queued_spin_lock_slowpath.

As such I don't believe the per-cpu split buys anything in terms of
scalability and as I explained in the previous mail I think the routine
used here is buggy, while shmem is the only user. Should this switch to
a centralized atomic (either cmpxchg loop or xadd + backpedal) there
should be no loss in scalability given the lruvec problem. Then the
routine could be commented out or whacked for the time being.

backtraces for interested:

bpftrace -e 'kprobe:__pv_queued_spin_lock_slowpath { @[kstack()] = count(); }'

@[
    __pv_queued_spin_lock_slowpath+5
    _raw_spin_lock_irqsave+61
    folio_lruvec_lock_irqsave+95
    __page_cache_release+130
    folios_put_refs+139
    shmem_undo_range+702
    shmem_setattr+983
    notify_change+556
    do_truncate+131
    do_ftruncate+254
    __x64_sys_ftruncate+62
    do_syscall_64+87
    entry_SYSCALL_64_after_hwframe+118
]: 4750931
@[
    __pv_queued_spin_lock_slowpath+5
    _raw_spin_lock_irqsave+61
    folio_lruvec_lock_irqsave+95
    folio_batch_move_lru+139
    lru_add_drain_cpu+141
    __folio_batch_release+49
    shmem_undo_range+702
    shmem_setattr+983
    notify_change+556
    do_truncate+131
    do_ftruncate+254
    __x64_sys_ftruncate+62
    do_syscall_64+87
    entry_SYSCALL_64_after_hwframe+118
]: 4761483


