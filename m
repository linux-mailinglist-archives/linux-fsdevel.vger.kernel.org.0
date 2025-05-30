Return-Path: <linux-fsdevel+bounces-50132-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0354AC86FC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 05:37:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E25451BA6889
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 03:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DEB319D07B;
	Fri, 30 May 2025 03:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="uh6IdToS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C2A9476;
	Fri, 30 May 2025 03:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748576230; cv=none; b=S57Fsup3y2Lx4X32jqc/6mFH/qHTD9YhYkq4lBGXZusLF2OihlxJtKw/XWnvwH+Ppep8/wMRE8oj9Mh4/D4+QB2T8oRWVK0D3cMgYuXHjwIRzn3LVov51NceVMPPsG0j6R8xutLjwsjdCr9vdFxfP6nBVSu4YNN3FTsk2uWwmj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748576230; c=relaxed/simple;
	bh=OSG0k/shA7/oPeCkLIqhhJKa64IsPWc6byb8m63R2lg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=boxIIo4g0Tv7e11mPk3kSYppaucGrAPvCb/QpzMQ9Mp6ph/RO9xPxDJf6YiTldjgfMiFIOOPEmrUYwjHzoPwUnCd3cLT4C3I1Vwo9wDSUTOO75ykBoiODybY1+DTA1ceMX3+7c0agEqE7AmyOTCQnaZaGDTmF8IFYTIka/JbKDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=uh6IdToS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07E1BC4CEE7;
	Fri, 30 May 2025 03:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1748576229;
	bh=OSG0k/shA7/oPeCkLIqhhJKa64IsPWc6byb8m63R2lg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uh6IdToSMXduPJ0LBRaOW7H0TbqSEGqbYCiuOrOx2biqC/urC9X8571G+b159WuzP
	 B74SmCo4aL5ncirSXsWdGPWtts6XpLJpxUtR2AGvKAuDPsMDM+qhq00g5Enpi+aDKI
	 Zyygr6GhtcZTYWAeHt7PJgJX93t5B4C4QvAJQFwA=
Date: Thu, 29 May 2025 20:37:08 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Kundan Kumar <kundan.kumar@samsung.com>
Cc: jaegeuk@kernel.org, chao@kernel.org, viro@zeniv.linux.org.uk,
 brauner@kernel.org, jack@suse.cz, miklos@szeredi.hu, agruenba@redhat.com,
 trondmy@kernel.org, anna@kernel.org, willy@infradead.org,
 mcgrof@kernel.org, clm@meta.com, david@fromorbit.com, amir73il@gmail.com,
 axboe@kernel.dk, hch@lst.de, ritesh.list@gmail.com, djwong@kernel.org,
 dave@stgolabs.net, p.raghav@samsung.com, da.gomez@samsung.com,
 linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
 gfs2@lists.linux.dev, linux-nfs@vger.kernel.org, linux-mm@kvack.org,
 gost.dev@samsung.com
Subject: Re: [PATCH 00/13] Parallelizing filesystem writeback
Message-Id: <20250529203708.9afe27783b218ad2d2babb0c@linux-foundation.org>
In-Reply-To: <20250529111504.89912-1-kundan.kumar@samsung.com>
References: <CGME20250529113215epcas5p2edd67e7b129621f386be005fdba53378@epcas5p2.samsung.com>
	<20250529111504.89912-1-kundan.kumar@samsung.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 29 May 2025 16:44:51 +0530 Kundan Kumar <kundan.kumar@samsung.com> wrote:

> Currently, pagecache writeback is performed by a single thread. Inodes
> are added to a dirty list, and delayed writeback is triggered. The single
> writeback thread then iterates through the dirty inode list, and executes
> the writeback.
> 
> This series parallelizes the writeback by allowing multiple writeback
> contexts per backing device (bdi). These writebacks contexts are executed
> as separate, independent threads, improving overall parallelism.
> 
> Would love to hear feedback in-order to move this effort forward.
> 
> Design Overview
> ================
> Following Jan Kara's suggestion [1], we have introduced a new bdi
> writeback context within the backing_dev_info structure. Specifically,
> we have created a new structure, bdi_writeback_context, which contains
> its own set of members for each writeback context.
> 
> struct bdi_writeback_ctx {
>         struct bdi_writeback wb;
>         struct list_head wb_list; /* list of all wbs */
>         struct radix_tree_root cgwb_tree;
>         struct rw_semaphore wb_switch_rwsem;
>         wait_queue_head_t wb_waitq;
> };
> 
> There can be multiple writeback contexts in a bdi, which helps in
> achieving writeback parallelism.
> 
> struct backing_dev_info {
> ...
>         int nr_wb_ctx;
>         struct bdi_writeback_ctx **wb_ctx_arr;

I don't think the "_arr" adds value. bdi->wb_contexts[i]?

> ...
> };
> 
> FS geometry and filesystem fragmentation
> ========================================
> The community was concerned that parallelizing writeback would impact
> delayed allocation and increase filesystem fragmentation.
> Our analysis of XFS delayed allocation behavior showed that merging of
> extents occurs within a specific inode. Earlier experiments with multiple
> writeback contexts [2] resulted in increased fragmentation due to the
> same inode being processed by different threads.
> 
> To address this, we now affine an inode to a specific writeback context
> ensuring that delayed allocation works effectively.
> 
> Number of writeback contexts
> ===========================
> The plan is to keep the nr_wb_ctx as 1, ensuring default single threaded
> behavior. However, we set the number of writeback contexts equal to
> number of CPUs in the current version.

Makes sense.  It would be good to test this on a non-SMP machine, if
you can find one ;)

> Later we will make it configurable
> using a mount option, allowing filesystems to choose the optimal number
> of writeback contexts.
> 
> IOPS and throughput
> ===================
> We see significant improvement in IOPS across several filesystem on both
> PMEM and NVMe devices.
> 
> Performance gains:
>   - On PMEM:
> 	Base XFS		: 544 MiB/s
> 	Parallel Writeback XFS	: 1015 MiB/s  (+86%)
> 	Base EXT4		: 536 MiB/s
> 	Parallel Writeback EXT4	: 1047 MiB/s  (+95%)
> 
>   - On NVMe:
> 	Base XFS		: 651 MiB/s
> 	Parallel Writeback XFS	: 808 MiB/s  (+24%)
> 	Base EXT4		: 494 MiB/s
> 	Parallel Writeback EXT4	: 797 MiB/s  (+61%)
> 
> We also see that there is no increase in filesystem fragmentation
> # of extents:
>   - On XFS (on PMEM):
> 	Base XFS		: 1964
> 	Parallel Writeback XFS	: 1384
> 
>   - On EXT4 (on PMEM):
> 	Base EXT4		: 21
> 	Parallel Writeback EXT4	: 11

Please test the performance on spinning disks, and with more filesystems?



