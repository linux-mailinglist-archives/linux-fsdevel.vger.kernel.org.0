Return-Path: <linux-fsdevel+bounces-42341-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB02CA40AE2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Feb 2025 19:03:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B367617D27D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Feb 2025 18:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F3BD207A35;
	Sat, 22 Feb 2025 18:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZQ87mR/e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8AD17C2
	for <linux-fsdevel@vger.kernel.org>; Sat, 22 Feb 2025 18:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740247395; cv=none; b=OPiK5F1ad9Qg8HLDsJzCW+qH8BbYQnhjgdmaXrEWynB4MJM3Z48vynEpi1WiUHHVnX1XirjijV0VtMlV77FOGh83VYWICIob1ySEfo0bREcRrOxt4J0NrumjsMuTa30x34UXdDQ9X7gYpx4JQRMhsV40gX8FBlskhybLSpK4C18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740247395; c=relaxed/simple;
	bh=Q2c8QH/WC2eRxBXfJjdS2Hhms0T/Lj1ac5Uo4n+4+z4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mY2Qagp2pu7ds3UiDOpHFa9qpcQGlUYNpF00h0AK+oTe2l9GwIYhPmMRLBakKxAyuFcQlCBgts8ceRbLz9jK5FJlfik5mmon/HGvaGLKmqjNvsp/rmSMmm9sQfWDOjRxURNdXfjyNJPnHf7MzsNqq2qdAzvI3j4UTzt3MJA5j6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZQ87mR/e; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 22 Feb 2025 13:03:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740247391;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3GdREV2SzieyWUR0Jf2M14Uc9ffUtrBLAjadT4w1/XM=;
	b=ZQ87mR/esWE5rtddEqyNRbo2Nv53Esn//fBOS0u5zYDstrTXhs04m6LYk8MEAEOc63LPDD
	hadXEbBPEGV08Dt6H6TNth0fU3Ow3Y41YrzQ32vpJxoJtFbFHJtjnTp4eDorN6Vd9qk6X0
	5BTkdkwHrhyW4VGVJiVmAGacIycey1E=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Kalesh Singh <kaleshsingh@google.com>
Cc: lsf-pc@lists.linux-foundation.org, 
	"open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, David Hildenbrand <david@redhat.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Juan Yescas <jyescas@google.com>, android-mm <android-mm@google.com>, 
	Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@suse.com>
Subject: Re: [LSF/MM/BPF TOPIC] Optimizing Page Cache Readahead Behavior
Message-ID: <dsvx2hyrdnv7smcrgpicqirwsmq5mcmbl7dbwmrx7dobrnxpbh@nxdhmkszdzyk>
References: <CAC_TJvfG8GcwG_2w1o6GOTZS8tfEx2h9A91qsenYfYsX8Te=Bg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAC_TJvfG8GcwG_2w1o6GOTZS8tfEx2h9A91qsenYfYsX8Te=Bg@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Feb 21, 2025 at 01:13:15PM -0800, Kalesh Singh wrote:
> Hi organizers of LSF/MM,
> 
> I realize this is a late submission, but I was hoping there might
> still be a chance to have this topic considered for discussion.
> 
> Problem Statement
> ===============
> 
> Readahead can result in unnecessary page cache pollution for mapped
> regions that are never accessed. Current mechanisms to disable
> readahead lack granularity and rather operate at the file or VMA
> level. This proposal seeks to initiate discussion at LSFMM to explore
> potential solutions for optimizing page cache/readahead behavior.
> 
> 
> Background
> =========
> 
> The read-ahead heuristics on file-backed memory mappings can
> inadvertently populate the page cache with pages corresponding to
> regions that user-space processes are known never to access e.g ELF
> LOAD segment padding regions. While these pages are ultimately
> reclaimable, their presence precipitates unnecessary I/O operations,
> particularly when a substantial quantity of such regions exists.
> 
> Although the underlying file can be made sparse in these regions to
> mitigate I/O, readahead will still allocate discrete zero pages when
> populating the page cache within these ranges. These pages, while
> subject to reclaim, introduce additional churn to the LRU. This
> reclaim overhead is further exacerbated in filesystems that support
> "fault-around" semantics, that can populate the surrounding pages’
> PTEs if found present in the page cache.
> 
> While the memory impact may be negligible for large files containing a
> limited number of sparse regions, it becomes appreciable for many
> small mappings characterized by numerous holes. This scenario can
> arise from efforts to minimize vm_area_struct slab memory footprint.
> 
> Limitations of Existing Mechanisms
> ===========================
> 
> fadvise(..., POSIX_FADV_RANDOM, ...): disables read-ahead for the
> entire file, rather than specific sub-regions. The offset and length
> parameters primarily serve the POSIX_FADV_WILLNEED [1] and
> POSIX_FADV_DONTNEED [2] cases.
> 
> madvise(..., MADV_RANDOM, ...): Similarly, this applies on the entire
> VMA, rather than specific sub-regions. [3]
> Guard Regions: While guard regions for file-backed VMAs circumvent
> fault-around concerns, the fundamental issue of unnecessary page cache
> population persists. [4]

What if we introduced something like

madvise(..., MADV_READAHEAD_BOUNDARY, offset)

Would that be sufficient? And would a single readahead boundary offset
suffice?

