Return-Path: <linux-fsdevel+bounces-55613-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6307B0C942
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jul 2025 19:13:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AC534E7384
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jul 2025 17:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C97D72E11B6;
	Mon, 21 Jul 2025 17:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="H1GpzBcG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937171FE44B;
	Mon, 21 Jul 2025 17:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753117995; cv=none; b=jD3W04QtZnlkNXiYq6dpkVwtLzL5tqaqykx2atOx1EEMYBe4w9UorvmF4mtuogjc9RT7Z3576vICQU358dwjmPAzcWI/DI0cyUP238Zs5Y8Ozw7jSFD7CvsNK7GaTmwCycYtvI5Ue1Kc1f8o4au1YphIbuhKIoDKs9wejFyG+aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753117995; c=relaxed/simple;
	bh=Hr1YG7QSWGyZ0LF0cFcvVQrOXI3R+NIX5I+yLOKcQwY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=exhwIEMahl1gVJPWE0f0kZb5hJxMKPbQ9Dg9pFLwwydVJ+HgWgJOLoygT8xzuPnFFqv3I/QIt7opXcmklZsVxFZp8WTIkLHAIQOhNPR+V+G/QySf1GnBKM1b0AsMLWXUKHPVlnHdoE4GXZbSiMO3oeVa5ZGEyux76C8xa1s4oSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=H1GpzBcG; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=NC6C+PjqKI/NeJ+YCHvWQarwsxh01i6R66mhx16Pca0=; b=H1GpzBcGf4l7laCmPw3QpswvEt
	yZo8vvWTeX8W8T67rreVeGZ4ZqI0Yl+6Vpe+q5OP9UfgHzlZKKrGTwh9QwbIlrgee5f+o8T8SH0dK
	li3yvE0tAiQaivIOQOrzyIIQO1SEbyuJEyBy8o1oFtt6ZRH38lSuRCI5MADyg3e91cVAh+5vs9vl0
	UjS8oiD0Gcj/rAyGP5BWU0FVSZIpMdCncI2AHJjfhrSlhoqP8EeREO7jSS3ICMus6KAV58vfBSr8j
	Q+FdrRr7aM4KNYXA+FOlSzlUPnSdY0Yof2V6WGRRHeZHcpglPx6ESlpCnEnrV7HJGGAh3EnUUHYVg
	9bGfQRkA==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1udu4c-0000000G38k-1T6I;
	Mon, 21 Jul 2025 17:13:10 +0000
Date: Mon, 21 Jul 2025 18:13:10 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
	Andrew Morton <akpm@linux-foundation.org>, kernel@collabora.com,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: Excessive page cache occupies DMA32 memory
Message-ID: <aH51JnZ8ZAqZ6N5w@casper.infradead.org>
References: <766ef20e-7569-46f3-aa3c-b576e4bab4c6@collabora.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <766ef20e-7569-46f3-aa3c-b576e4bab4c6@collabora.com>

On Mon, Jul 21, 2025 at 08:03:12PM +0500, Muhammad Usama Anjum wrote:
> Hello,
> 
> When 10-12GB our of total 16GB RAM is being used as page cache
> (active_file + inactive_file) at suspend time, the drivers fail to allocate
> dma memory at resume as dma memory is either occupied by the page cache or
> fragmented. Example:
> 
> kworker/u33:5: page allocation failure: order:7, mode:0xc04(GFP_NOIO|GFP_DMA32), nodemask=(null),cpuset=/,mems_allowed=0

Just to be clear, this is not a page cache problem.  The driver is asking
us to do a 512kB allocation without doing I/O!  This is a ridiculous
request that should be expected to fail.

The solution, whatever it may be, is not related to the page cache.
I reject your diagnosis.  Almost all of the page cache is clean and
could be dropped (as far as I can tell from the output below).

Now, I'm not too familiar with how the page allocator chooses to fail
this request.  Maybe it should be trying harder to drop bits of the page
cache.  Maybe it should be doing some compaction.  I am not inclined to
go digging on your behalf, because frankly I'm offended by the suggestion
that the page cache is at fault.

Perhaps somebody else will help you, or you can dig into this yourself.

> CPU: 1 UID: 0 PID: 7693 Comm: kworker/u33:5 Not tainted 6.11.11-valve17-1-neptune-611-g027868a0ac03 #1 3843143b92e9da0fa2d3d5f21f51beaed15c7d59
> Hardware name: Valve Galileo/Galileo, BIOS F7G0112 08/01/2024
> Workqueue: mhi_hiprio_wq mhi_pm_st_worker [mhi]
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x4e/0x70
>  warn_alloc+0x164/0x190
>  ? srso_return_thunk+0x5/0x5f
>  ? __alloc_pages_direct_compact+0xaf/0x360
>  __alloc_pages_slowpath.constprop.0+0xc75/0xd70
>  __alloc_pages_noprof+0x321/0x350
>  __dma_direct_alloc_pages.isra.0+0x14a/0x290
>  dma_direct_alloc+0x70/0x270
>  mhi_fw_load_handler+0x126/0x340 [mhi a96cb91daba500cc77f86bad60c1f332dc3babdf]
>  mhi_pm_st_worker+0x5e8/0xac0 [mhi a96cb91daba500cc77f86bad60c1f332dc3babdf]
>  ? srso_return_thunk+0x5/0x5f
>  process_one_work+0x17e/0x330
>  worker_thread+0x2ce/0x3f0
>  ? __pfx_worker_thread+0x10/0x10
>  kthread+0xd2/0x100
>  ? __pfx_kthread+0x10/0x10
>  ret_from_fork+0x34/0x50
>  ? __pfx_kthread+0x10/0x10
>  ret_from_fork_asm+0x1a/0x30
>  </TASK>
> Mem-Info:
> active_anon:513809 inactive_anon:152 isolated_anon:0
> active_file:359315 inactive_file:2487001 isolated_file:0
> unevictable:637 dirty:19 writeback:0
> slab_reclaimable:160391 slab_unreclaimable:39729
> mapped:175836 shmem:51039 pagetables:4415
> sec_pagetables:0 bounce:0
> kernel_misc_reclaimable:0
> free:125666 free_pcp:0 free_cma:0
> Node 0 active_anon:2055236kB inactive_anon:608kB active_file:1437260kB inactive_file:9948004kB unevictable:2548kB isolated(anon):0kB isolated(file):0kB mapped:703344kB dirty:76kB writeback:0kB shmem:204156kB shmem_thp:0kB shmem_pmdmapped:0kB anon_thp:495616kB writeback_tmp:0kB kernel_stack:9440kB pagetables:17660kB sec_pagetables:0kB all_unreclaimable? no
> Node 0 DMA free:68kB boost:0kB min:68kB low:84kB high:100kB reserved_highatomic:0KB active_anon:8kB inactive_anon:0kB active_file:0kB inactive_file:13232kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
> lowmem_reserve[]: 0 1808 14772 0 0
> Node 0 DMA32 free:9796kB boost:0kB min:8264kB low:10328kB high:12392kB reserved_highatomic:0KB active_anon:14148kB inactive_anon:88kB active_file:128kB inactive_file:1757192kB unevictable:0kB writepending:0kB present:1935736kB managed:1867440kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
> lowmem_reserve[]: 0 0 12964 0 0
> Node 0 DMA: 5*4kB (U) 0*8kB 1*16kB (U) 1*32kB (U) 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 68kB
> Node 0 DMA32: 103*4kB (UME) 52*8kB (UME) 43*16kB (UME) 58*32kB (UME) 35*64kB (UME) 23*128kB (UME) 5*256kB (ME) 0*512kB 0*1024kB 0*2048kB 0*4096kB = 9836kB
> Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
> Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=2048kB
> 2897795 total pagecache pages
> 0 pages in swap cache
> Free swap  = 8630724kB
> Total swap = 8630776kB
> 3892604 pages RAM
> 0 pages HighMem/MovableOnly
> 101363 pages reserved
> 0 pages cma reserved
> 0 pages hwpoisoned
> 
> As you can see above, the ~11 GB of page cache has consumed DMA32 pages,
> leaving only 9.8MB free but heavily fragmented with no contiguous blocks
> ≥512KB. Its hard to reproduce by a test. We have received several reports
> for v6.11 kernel. As we don't have reliable reproducer yet, we cannot test
> if other kernels are also affected.
> 
> Current mitigations are:
> 1 Pre-allocate buffer in drivers and don't free them even if they are only
>   used during during initialization at boot and resume. But it wastes memory
>   and unacceptable even if its just 2-4MB.
> 2 Drop caches at suspend. But it causes latency during suspension and
>   slowness on resume. There is no way to drop only couple of GB of page
>   cache as that wouldn't take long at suspend time.
> 
> Greg dislikes 1 and rejects it which is understandable. [1]:
> > It should be reclaiming this, as it's just cache, not really used
> > memory.
> 
> Would it be reasonable to add a mechanism to limit page cache growth?
> I think, there should be some watermark or similar by which we can
> indicate to page cache to don't go above it. Or at suspend, drop only
> a part of of the page cache and not the entire page cache. What other
> options are available? 
> 
> [1] https://lore.kernel.org/all/2025071722-panther-legwarmer-d2be@gregkh 
> 
> Thanks,
> Muhammad Usama Anjum

