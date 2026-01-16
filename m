Return-Path: <linux-fsdevel+bounces-74070-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C78D2E559
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 09:55:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C57613065145
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 08:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA95F30F550;
	Fri, 16 Jan 2026 08:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="fMzegftB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1323090C1;
	Fri, 16 Jan 2026 08:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768553678; cv=none; b=NnZjRr5G5OsoiBISCqc2uqPX9KCNF79K89AEok18+P7vUBSH5vgYOFkoImjMHB6ZTSaFxdZAxv+ynGUv4ZOcE38TPEYU4Kw4e7OJl+tM8fLWCau3g+QczgCKx6uxtIKAiruGQCLJuGB8v2tSPRn0kp9ua2ttyiFQQZHzgQNp8cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768553678; c=relaxed/simple;
	bh=EYHX1kLoFb7xwMTyer8aWBsx+67Cm2Z6fFII79shq48=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Vace9YUsL0Ot9ciagTN/Rv2rF11qFImbzBx7IiPkkv1Ux5tebrLrIeNspJPDpXARMoE6EiD6OTq+Us/JmxPc9fk+O0I6s9gJU0kysS5p+z8aehKFN3I5y2fCgcTX4p1ShXMJmGwLtmEWB2KEu7iGD3zLc2XmTZpuiop9FG4/JJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=fMzegftB; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=33
	Q2PhF2WYxmq/ogA5PjyvsxiVXdLLFmrPqiyNG06ZA=; b=fMzegftBUnCngDNnH+
	agGi/V2u+xvTvI5+0nxdk1Gh6sXIDg9IMHuHcZDbVRk5oHR+Ey/74O6UnnuBIC3I
	+iUX4dkULe0kM8MGeaA5HsL5dmjmzeXUUbalCM660lkwEhpKhTK97HuA6RJxAQzh
	vkL/qBq+GBAKzurox0+0GuEDw=
Received: from zhaoxin-MS-7E12.. (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wD3A6R9_Glp7FkOGA--.61S2;
	Fri, 16 Jan 2026 16:53:19 +0800 (CST)
From: Xin Zhao <jackzxcui1989@163.com>
To: lorenzo.stoakes@oracle.com
Cc: Liam.Howlett@oracle.com,
	akpm@linux-foundation.org,
	axelrasmussen@google.com,
	david@kernel.org,
	hannes@cmpxchg.org,
	harry.yoo@oracle.com,
	jackzxcui1989@163.com,
	jannh@google.com,
	kuba@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	mhocko@kernel.org,
	riel@surriel.com,
	shakeel.butt@linux.dev,
	vbabka@suse.cz,
	weixugc@google.com,
	willy@infradead.org,
	yuanchu@google.com,
	zhengqi.arch@bytedance.com
Subject: Re: [PATCH] mm: vmscan: add skipexec mode not to reclaim pages with VM_EXEC vma flag
Date: Fri, 16 Jan 2026 16:53:16 +0800
Message-Id: <20260116085317.3945633-1-jackzxcui1989@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <14110b70-19e7-474d-b0dd-ba80e8bed9b0@lucifer.local>
References: <14110b70-19e7-474d-b0dd-ba80e8bed9b0@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3A6R9_Glp7FkOGA--.61S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3Jw47tF4Dur1UArWxGryUZFb_yoW3ArWxpF
	Z3Gryjkr4kXF1xJws2yw4DWw1rA395GF45Jr9xC34xC345Wr129rs2kryjyFyxCrnrGr1a
	qr429rykZa15AaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0p_jg4JUUUUU=
X-CM-SenderInfo: pmdfy650fxxiqzyzqiywtou0bp/xtbC6B8THWlp-H80CwAA3F

On Fri, 16 Jan 2026 08:20:08 +0000, Lorenzo wrote:

> We already absolutely deprioritise reclaim of VM_EXEC regions, so you must
> surely be under some heavy memory pressure?
> 
> > The iowait problem becomes even more severe due to the following reasons:
> >
> > 1. The reclaimed code segments are often those that handle exceptional
> > scenarios, which are not frequently executed. When memory pressure
> > increases, the entire system can become sluggish, leading to execution of
> > these seldom-used exception-handling code segments. Since these segments
> > are more likely to be reclaimed from memory, this exacerbates system
> > sluggishness.
> >
> > 2. The reclaimed code segments used for exception handling are often
> > shared by multiple tasks, causing these tasks to wait on the folio's
> > PG_locked bit, further increasing I/O wait.
> >
> > 3. Under memory pressure, the reclamation of code segments is often
> > scattered and randomly distributed, slowing down the efficiency of block
> > device reads and further exacerbating I/O wait.
> >
> > While this issue could be addressed by preloading a library mlock all
> > executable segments, it would lead to many code segments that are never
> > used being locked, resulting in memory waste.
> >
> > In systems where code execution is relatively fixed, preventing currently
> > in-use code segments from being reclaimed makes sense. This acts as a
> > self-adaptive way for the system to lock the necessary portions, which
> > saves memory compared to locking all code segments with mlock.
> 
> This seems like you're trying to solve an issue with reclaim not working
> correctly, that is causing some kind of thrashing scenario to occur.
> 
> There's also nothing 'self-adaptive' about a user having to specify a
> sysctl like this.
> 
> The fix should be part of the reclaim code, not a sysctl.
> 
> >
> > Introduce /proc/sys/vm/skipexec_enabled that can be set to 1 to enable
> 
> No thinks, we emphatically do _not_ want a new sysctl.
> 
> sysctl's in general should be the last resort - users very often have
> absolutely no idea how to use them, and it in effect defers decisions that
> the kernel should make to userland.
> 
> > this feature. When this feature is enabled, during memory reclamation
> > logic, a flag TTU_SKIP_EXEC will be passed to try_to_unmap, allowing
> > try_to_unmap_one to check if the vma has the VM_EXEC attribute when flag
> > TTU_SKIP_EXEC is present. If the VM_EXEC attribute is set, it will skip
> > the unmap operation.
> 
> Hm I really don't like the idea that was pass around a flag to essentially
> say 'hey that thing that has been scheduled for reclaim? Just don't'.
> 
> >
> > In the same scenario of locking a large file with vmtouch -l, our tests
> > showed that without enabling the skipexec_enabled feature, the number of
> > occurrences where iowait exceeded 20ms was 47,457, the longest iowait is
> > 3 seconds. After enabling the skipexec_enabled feature, the number of
> > occurrences dropped to only 34, the longest iowait is only 44ms, and none
> > of these 34 instances were due to page cache file pages causing I/O wait.
> >
> > Signed-off-by: Xin Zhao <jackzxcui1989@163.com>
> 
> So yeah I'm not happy with this patch at all and I think you're doing this
> entirely wrong.
> 
> You really need to dig into the reclaim algorithm and figure out why it is
> not correctly protecting VM_EXEC mappings.
> 
> Consider:
> 
> 		/*
> 		 * Activate file-backed executable folios after first usage.
> 		 */
> 		if ((vm_flags & VM_EXEC) && folio_is_file_lru(folio))
> 			return FOLIOREF_ACTIVATE;
> 
> In folio_check_references() and:
> 
> 		/* Referenced or rmap lock contention: rotate */
> 		if (folio_referenced(folio, 0, sc->target_mem_cgroup,
> 				     &vm_flags) != 0) {
> 			/*
> 			 * Identify referenced, file-backed active folios and
> 			 * give them one more trip around the active list. So
> 			 * that executable code get better chances to stay in
> 			 * memory under moderate memory pressure.  Anon folios
> 			 * are not likely to be evicted by use-once streaming
> 			 * IO, plus JVM can create lots of anon VM_EXEC folios,
> 			 * so we ignore them here.
> 			 */
> 			if ((vm_flags & VM_EXEC) && folio_is_file_lru(folio)) {
> 				nr_rotated += folio_nr_pages(folio);
> 				list_add(&folio->lru, &l_active);
> 				continue;
> 			}
> 		}
> 
> In shrink_active_list().
> 
> We _already_ take into account VM_EXEC regions, but for some reason your
> use case either encounters such extreme memory pressure that VM_EXEC
> regions end up being the least recently used.
> 
> It may be your workloads are doing something crazy here or you would end up
> thrashing anyway, or you simply need to mlock() them?
> 
> In any case this needs deeper analysis on your side and any proposed patch
> should be in the reclaim mechanism, not to provide a 'ignore reclaim'
> sysctl.

Thank you for your reply. Your response has been very helpful to me. I will go
back and investigate the reasons why the algorithm is not correctly protecting
VM_EXEC mappings during reclamation. In our project, we indeed encountered
situations with a lot of I/O wait exceeding 200ms, which led to significant
latency spikes affecting many tasks. During this time, we did not enable any
extra mechanisms for pagecache shrink.

Earlier, in our x86 project, we developed some customized features to limit
pagecache and set a theoretical threshold. We also encountered significant I/O
wait issues, and I suspect it may be related to the priority settings in the
logic below. You are right to point this out; I should take a look at this
reclamation logic to see if it can be optimized and whether I can reproduce the
earlier I/O wait problem. Perhaps there are incorrect priority values set in
the following algorithm:

void __memcg_pagecache_shrink(struct mem_cgroup *memcg,
			      bool may_unmap, gfp_t gfp_mask)
{
	unsigned long nr_should_reclaim;
	bool need_requeue = 0;
	struct scan_control sc = {
		.gfp_mask = (current_gfp_context(gfp_mask) & GFP_RECLAIM_MASK) |
				(GFP_HIGHUSER_MOVABLE & ~GFP_RECLAIM_MASK),
		.reclaim_idx = ZONE_MOVABLE,
		.may_swap = 0,
		.may_unmap = may_unmap,
		.may_writepage = 0,
		.priority = DEF_PRIORITY,
		.target_mem_cgroup  = memcg,
	};

	/*
	 * We recheck here mainly in case the pagecache is already satisfied,
	 * especially in asynchronous scenarios.
	 */
	nr_should_reclaim = memcg_get_pgcache_overflow_size(memcg);
	if (!nr_should_reclaim)
		return;

	sc.nr_to_reclaim = max(nr_should_reclaim, SWAP_CLUSTER_MAX);
	sc.nr_to_reclaim = min(sc.nr_to_reclaim, memcg->pgcache_once_reclaim);
	if (sc.nr_to_reclaim == memcg->pgcache_once_reclaim)
		need_requeue = 1;
	do {
		if (!is_memcg_pgcache_limit_enabled(memcg))
			break;

		if (sc.nr_reclaimed >= sc.nr_to_reclaim)
			break;
		/*
		 * In case there are not enough pagecache to be reclaimed during
		 * direct reclaim, we only enable mapped pages to be reclaimed
		 * when priority value is smaller than DEF_PRIORITY - 4.
		 */
		if (memcg->pgcache_limit_sync &&
		    (sc.priority < DEF_PRIORITY - 4))
			sc.may_unmap = 1;

		/*
		 * We only enable dirty pages to be reclaimed when priority
		 * value is smaller than DEF_PRIORITY - 2, and the reclaim
		 * must be in an asynchronous scenario, in order to minimize the
		 * performance jitter when dirty pages are reclaimed.
		 */
		if (current_is_kswapd() && !memcg->pgcache_limit_sync &&
		    (sc.priority < DEF_PRIORITY - 2))
			sc.may_writepage = 1;

		if (__pagecache_shrink(memcg, &sc) < 0) {
			need_requeue = 1;
			break;
		}

		/* Avoid hogging CPU in preempt voluntary */
		cond_resched();
	} while (--sc.priority >= 0);

	if (need_requeue) {
		/* Update memory static stats, avoid over-reclaim */
		mem_cgroup_flush_stats();
		queue_delayed_work_on(memcg->pgcache_limit_core, memcg_pgcache_limit_wq,
								&memcg->pgcache_limit_work,
								msecs_to_jiffies(READ_ONCE(memcg->pgcache_limit_interval)));
	}
}


