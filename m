Return-Path: <linux-fsdevel+bounces-19291-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 078808C2DBF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 May 2024 01:57:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4B2A283467
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 May 2024 23:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B8C4174EED;
	Fri, 10 May 2024 23:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NJNFS9QU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5BB628F3
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 May 2024 23:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715385435; cv=none; b=gK46I6HeoRCgq3OA0Awu+/Vw3bx2YC3peFFFT6LZIlgvhEHE2HFHgUV/KZmiqVJPXqMwSKSRFB+aOG5aWcpio9Z16WFeu6+a3VsSW+JkpghxMcsN0u8vE5RyUor0aWldW5mojL7EMPY3du885YoGfHtJXQvSsucZVKgvnwFeD/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715385435; c=relaxed/simple;
	bh=29MMlm/b9i6H0UcvGxIb5SX2Nw/gE/wuWQkKLq9GdUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qaD4G46DKV5iyzATRn2sw/NHZsZc0wehunaZw60f6atL7Fx8xjCR6L3+44HqdG24cWdEC8EaHmoCuhN0/c/3ln1Cwto5OPq++E7sE1/qiy6d02vEMScSqi+sF2j3Tc7v+zBc9tdVCJ8xDhklQVnMeCtUH8YcmmSssnJS0zEIQ/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=NJNFS9QU; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
	bh=vZhAtcjZqvSIYAYBjEmEHWr9KFoQsf5mGGmphyy7A3o=; b=NJNFS9QUEE2IczvvyrDzZcqVeA
	WbWXNbFevtcG9mkWtEN70usKsD+ek36bNQqPZXzFruDObIJKuY55YIEqYWI3PeeckvKryN7ryPdVf
	zpEnVJ7h0tq3MK7+j1YrKT5uBuIUTN5cevnr1QpJVZe/Tg3N4RPRzEIMdBrP0znguYybdsxE5J74a
	dIFJ5liL8GvxP4vQCTCRn66aYxMtL0VV/u4zC3L09apJ2HJEPyyBk8oVWysSaXTwdkNT+C1euIHUN
	Ui3qrV1AgfNfLCmtjEtj2EaedAAmxgSKFYTKmZr5aLXbB+ZD183vfncQPNIjanEPQm9t0+nLCsny1
	OtHMkoWQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s5a6t-00000006qIt-4C6g;
	Fri, 10 May 2024 23:57:08 +0000
Date: Fri, 10 May 2024 16:57:07 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Chris Mason <clm@meta.com>, Dave Chinner <david@fromorbit.com>,
	David Bueso <dave@stgolabs.net>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	"Paul E. McKenney" <paulmck@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
	linux-mm <linux-mm@kvack.org>, Daniel Gomez <da.gomez@samsung.com>,
	Pankaj Raghav <p.raghav@samsung.com>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
	Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [LSF/MM/BPF TOPIC] Measuring limits and enhancing buffered IO
Message-ID: <Zj60U5SdWepnmLzD@bombadil.infradead.org>
References: <Zdkxfspq3urnrM6I@bombadil.infradead.org>
 <Zdlsr88A6AAlJpcc@casper.infradead.org>
 <CAHk-=wjUkYLv23KtF=EyCrQcmf9NGwE8Yo1cuxdaLF8gqx5zWw@mail.gmail.com>
 <CAHk-=wj0_eGczsoTJska24Lf9Sk6VXUGrfHymcDZF_Q5ExQdxQ@mail.gmail.com>
 <CAHk-=wintzU7i5NCVAUY_es6_eo8Zpt=mD0PAyhFd0aCu65WfA@mail.gmail.com>
 <bb2e87d7-a706-4dc8-9c09-9257b69ebd5c@meta.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bb2e87d7-a706-4dc8-9c09-9257b69ebd5c@meta.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Sat, Feb 24, 2024 at 05:57:43PM -0500, Chris Mason wrote:
> Going back to Luis's original email, I'd echo Willy's suggestion for
> profiles.  Unless we're saturating memory bandwidth, buffered should be
> able to get much closer to O_DIRECT, just at a much higher overall cost.

I finally had some time to look beyond just "what locks" could be the
main culprit, David Bueso helped me review this, thanks!

Based on all the discussions on this insanely long thread, I do believe
the issue was the single threaded write-behind cache flushing back Chinner
noted.

Lifting the /proc/sys/vm/dirty_ratio from 20 to 90 keeps the profile
perky and nice with most top penalties seen just in userspace as seen in
the first paste exhibit a) below but as soon as we start throttling we
hit the profile on past exhibit b) below.

a) without the throttling:

Samples: 1M of event 'cycles:P', Event count (approx.): 1061541571785                                                                                                                         
  Children      Self  Command          Shared Object               Symbol                                                                                                                     
+   17.05%    16.85%  fio              fio                         [.] get_io_u                                                                                                              ◆
+    3.04%     0.01%  fio              [kernel.vmlinux]            [k] entry_SYSCALL_64                                                                                                      ▒
+    3.03%     0.02%  fio              [kernel.vmlinux]            [k] do_syscall_64                                                                                                         ▒
+    1.39%     0.04%  fio              [kernel.vmlinux]            [k] __do_sys_io_uring_enter                                                                                               ▒
+    1.33%     0.00%  fio              libc.so.6                   [.] __GI___libc_open                                                                                                      ▒
+    1.33%     0.00%  fio              [kernel.vmlinux]            [k] __x64_sys_openat                                                                                                      ▒
+    1.33%     0.00%  fio              [kernel.vmlinux]            [k] do_sys_openat2                                                                                                        ▒
+    1.33%     0.00%  fio              [unknown]                   [k] 0x312d6e65742f2f6d                                                                                                    ▒
+    1.33%     0.00%  fio              [kernel.vmlinux]            [k] do_filp_open                                                                                                          ▒
+    1.33%     0.00%  fio              [kernel.vmlinux]            [k] path_openat                                                                                                           ▒
+    1.29%     0.00%  fio              [kernel.vmlinux]            [k] down_write                                                                                                            ▒
+    1.29%     0.00%  fio              [kernel.vmlinux]            [k] rwsem_down_write_slowpath                                                                                             ▒
+    1.26%     1.25%  fio              [kernel.vmlinux]            [k] osq_lock                                                                                                              ▒
+    1.14%     0.00%  fio              fio                         [.] 0x000055bbb94449fa                                                                                                    ▒
+    1.14%     1.14%  fio              fio                         [.] 0x000000000002a9f5                                                                                                    ▒
+    0.98%     0.00%  fio              [unknown]                   [k] 0x000055bbd6310520                                                                                                    ▒
+    0.93%     0.00%  fio              fio                         [.] 0x000055bbb94b197b                                                                                                    ▒
+    0.89%     0.00%  perf             libc.so.6                   [.] __GI___libc_write                                                                                                     ▒
+    0.89%     0.00%  perf             [kernel.vmlinux]            [k] entry_SYSCALL_64                                                                                                      ▒
+    0.88%     0.00%  perf             [kernel.vmlinux]            [k] do_syscall_64                                                                                                         ▒
+    0.86%     0.00%  perf             [kernel.vmlinux]            [k] ksys_write                                                                                                            ▒
+    0.85%     0.01%  perf             [kernel.vmlinux]            [k] vfs_write                                                                                                             ▒
+    0.83%     0.00%  perf             [ext4]                      [k] ext4_buffered_write_iter                                                                                              ▒
+    0.81%     0.01%  perf             [kernel.vmlinux]            [k] generic_perform_write                                                                                                 ▒
+    0.77%     0.02%  fio              [kernel.vmlinux]            [k] io_submit_sqes                                                                                                        ▒
+    0.76%     0.00%  kworker/u513:26  [kernel.vmlinux]            [k] ret_from_fork_asm                                                                                                     ▒
+    0.76%     0.00%  kworker/u513:26  [kernel.vmlinux]            [k] ret_from_fork                                                                                                         ▒
+    0.76%     0.00%  kworker/u513:26  [kernel.vmlinux]            [k] kthread                                                                                                               ▒
+    0.76%     0.00%  kworker/u513:26  [kernel.vmlinux]            [k] worker_thread                                                                                                         ▒
+    0.76%     0.00%  kworker/u513:26  [kernel.vmlinux]            [k] process_one_work                                                                                                      ▒
+    0.76%     0.00%  kworker/u513:26  [kernel.vmlinux]            [k] wb_workfn                                                                                                             ▒
+    0.76%     0.00%  kworker/u513:26  [kernel.vmlinux]            [k] wb_writeback                                                                                                          ▒
+    0.76%     0.00%  kworker/u513:26  [kernel.vmlinux]            [k] __writeback_inodes_wb                                                                                                 ▒
+    0.76%     0.00%  kworker/u513:26  [kernel.vmlinux]            [k] writeback_sb_inodes                                                                                                   ▒
+    0.76%     0.00%  kworker/u513:26  [kernel.vmlinux]            [k] __writeback_single_inode                                                                                              ▒
+    0.76%     0.00%  kworker/u513:26  [kernel.vmlinux]            [k] do_writepages                                                                                                         ▒
+    0.76%     0.00%  kworker/u513:26  [xfs]                       [k] xfs_vm_writepages                                                                                                     ▒
+    0.75%     0.00%  kworker/u513:26  [kernel.vmlinux]            [k] submit_bio_noacct_nocheck                                                                                             ▒
+    0.75%     0.00%  kworker/u513:26  [kernel.vmlinux]            [k] iomap_submit_ioend          

So we see *more* penalty because of perf's own buffered IO writes of the
perf data than any writeback from from XFS.

a) when we hit throttling:

Samples: 1M of event 'cycles:P', Event count (approx.): 816903693659                                                                                                                          
  Children      Self  Command          Shared Object               Symbol                                                                                                                     
+   14.24%    14.06%  fio              fio                         [.] get_io_u                                                                                                              ◆
+    4.88%     0.00%  kworker/u513:3-  [kernel.vmlinux]            [k] ret_from_fork_asm                                                                                                     ▒
+    4.88%     0.00%  kworker/u513:3-  [kernel.vmlinux]            [k] ret_from_fork                                                                                                         ▒
+    4.88%     0.00%  kworker/u513:3-  [kernel.vmlinux]            [k] kthread                                                                                                               ▒
+    4.88%     0.00%  kworker/u513:3-  [kernel.vmlinux]            [k] worker_thread                                                                                                         ▒
+    4.88%     0.00%  kworker/u513:3-  [kernel.vmlinux]            [k] process_one_work                                                                                                      ▒
+    4.88%     0.00%  kworker/u513:3-  [kernel.vmlinux]            [k] wb_workfn                                                                                                             ▒
+    4.88%     0.00%  kworker/u513:3-  [kernel.vmlinux]            [k] wb_writeback                                                                                                          ▒
+    4.88%     0.00%  kworker/u513:3-  [kernel.vmlinux]            [k] __writeback_inodes_wb                                                                                                 ▒
+    4.88%     0.00%  kworker/u513:3-  [kernel.vmlinux]            [k] writeback_sb_inodes                                                                                                   ▒
+    4.87%     0.00%  kworker/u513:3-  [kernel.vmlinux]            [k] __writeback_single_inode                                                                                              ▒
+    4.87%     0.00%  kworker/u513:3-  [kernel.vmlinux]            [k] do_writepages                                                                                                         ▒
+    4.87%     0.00%  kworker/u513:3-  [xfs]                       [k] xfs_vm_writepages                                                                                                     ▒
+    4.82%     0.00%  kworker/u513:3-  [kernel.vmlinux]            [k] iomap_submit_ioend                                                                                                    ▒
+    4.82%     0.00%  kworker/u513:3-  [kernel.vmlinux]            [k] submit_bio_noacct_nocheck                                                                                             ▒
+    4.82%     0.00%  kworker/u513:3-  [kernel.vmlinux]            [k] __submit_bio                                                                                                          ▒
+    4.82%     0.04%  kworker/u513:3-  [nd_pmem]                   [k] pmem_submit_bio                                                                                                       ▒
+    4.78%     0.05%  kworker/u513:3-  [nd_pmem]                   [k] pmem_do_write          

Although my focus was on measuring the limits of the page cache, this
thread also had a *slew* of ideas on how to improve that status quo,
pathological or not. We have to accept some workloads are clearly
pathological, but that's the point in coming up with limits and testing
the page cache. But since there were a slew of unexpected ideas spread
out this entire thread about general improvements, even for general use
cases, I've collected all of them and put them as notes for for review
for this topic at LSFMM.

Thanks all for the feedback!

  Luis

