Return-Path: <linux-fsdevel+bounces-70201-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 885B9C93745
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Nov 2025 04:37:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EF5AA349E33
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Nov 2025 03:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C6D1EEA3C;
	Sat, 29 Nov 2025 03:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="RM2AAmHb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91473B2BA;
	Sat, 29 Nov 2025 03:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764387452; cv=none; b=dPIaU8J+dM5HLLBuBlbXK8TsOtCzeu+jjWj5LR8CJL917KMjE60yRejWqgdaTWtde9hW8TMd37uFyHxf9wkFmU72/BghG/zt6QIq7nH0du5dukooRrWeIc7zQwlz3kpTE7Oi2uc4K12XlixDIfDow2B8BKwN+8dyPSJewj82h+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764387452; c=relaxed/simple;
	bh=MGH/wfnN8D4I5wXf8tjl2REdP/QConuZDNJYytOO5KM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e7ZkczZNfyQEHWCFsseUWdkkbivb+SWmDwo4dNWwxEkXrWZFA1S0wC6jrdIPsd02FuFy0Q4uIIxTRtGXMVH/1+5LVXy961T3/g83aPxQ/twDbFdEvZKvfDSPaWUNwNvzupBIV3vQZxQ0XHobIsBlMlbWREJspsPQlSyJmd6g9Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=RM2AAmHb; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
	bh=DpznAaRjUo2w7LZxf6lAxjAHm9eksDcdz1NUq6/1gPM=; b=RM2AAmHbiWWjdBAvIAJPpFqKzC
	w+Imm2LS97uAx/g//eMP3HpFYUydE6Y+w3JM2a8/zUe++dKTeDANZDiDhhpz9RQhopbF5FS4u59BP
	PE1d3GCCezRATySQWYeccgXjEG2ISRJhV3jEJRAJQYUiOg1uEdQI1PcGSSQoXR3sE3gEGjYo6X1b0
	ZZAydgZNX+ONMdWvNoVHkaZNl6k/IZqlWnoW2ttA3YJ+Rq3v6tUpaDiuCU6m1/7ylKfhX+vhWnevn
	rwQhQ8i4Asi+235RfCe1TE0fqCW9cuyaCfk0NCspPUUaeA0kvHilMf+ySBiCfQyouT10czoJRpVrE
	xFYsYKig==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99 #2 (Red Hat Linux))
	id 1vPBm4-000000008wo-3AES;
	Sat, 29 Nov 2025 03:37:28 +0000
Date: Sat, 29 Nov 2025 03:37:28 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Zizhi Wo <wozizhi@huaweicloud.com>
Cc: torvalds@linux-foundation.org, jack@suse.com, brauner@kernel.org,
	hch@lst.de, akpm@linux-foundation.org, linux@armlinux.org.uk,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
	yangerkun@huawei.com, wangkefeng.wang@huawei.com,
	pangliyuan1@huawei.com, xieyuanbin1@huawei.com
Subject: Re: [Bug report] hash_name() may cross page boundary and trigger
 sleep in RCU context
Message-ID: <20251129033728.GH3538@ZenIV>
References: <20251126090505.3057219-1-wozizhi@huaweicloud.com>
 <20251126185545.GC3538@ZenIV>
 <c375dd22-8b46-404b-b0c2-815dbd4c5ec8@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c375dd22-8b46-404b-b0c2-815dbd4c5ec8@huaweicloud.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Nov 27, 2025 at 10:24:19AM +0800, Zizhi Wo wrote:

> Why does x86 have special handling in do_kern_addr_fault(), including
> logic for vmalloc faults? For example, on CONFIG_X86_32, it still takes
> the vmalloc_fault path. As noted in the x86 comments, "We can fault-in
> kernel-space virtual memory on-demand"...
> 
> But on arm64, I don’t see similar logic — is there a specific reason
> for this difference? Maybe x86's vmalloc area is mapped lazily, while
> ARM maps it fully during early boot?

x86 MMU uses the same register for kernel and userland top-level page
tables; arm64 MMU has separate page tables for those - TTBR0 and TTBR1
point to the table to be used for translation, depending upon the bit
55 of virtual address.

vmalloc works with page table of init_mm (see pgd_offset_k() uses in
there).  On arm64 that's it - TTBR1 is set to that and it stays that way,
so access to vmalloc'ed area will do the right thing.

On 32bit x86 you need to propagate the change into top-level page tables
of every thread.  That's what arch_sync_kernel_mappings() is for; look for
the calls in mm/vmalloc.c and see the discussion of race in the comment in
front of x86 vmalloc_fault().  Nothing of that sort is needed of arm64,
since all threads are using the same page table for kernel part of the
address space.

The reason why 64bit x86 doesn't need to bother is different - there we
fill all relevant top-level page table slots in preallocate_vmalloc_pages()
before any additional threads could be created.  The pointers in those
slots are not going to change and they will be propagated to all subsequent
threads by pgd_alloc(), so the page tables actually modified by vmalloc()
are shared by all threads.

AFAICS, 32bit arm is similar to 32bit x86 in that respect; propagation
is lazier, though - there arch_sync_kernel_mappings() bumps a counter
in init_mm and context switches use that to check if propagation needs
to be done.  No idea how well does that work on vfree() side of things -
hadn't looked into that rabbit hole...

