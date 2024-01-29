Return-Path: <linux-fsdevel+bounces-9545-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ABC6B842969
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 17:35:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62E1D293B92
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 16:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA0FD86AE8;
	Tue, 30 Jan 2024 16:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bWLCiNLR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF6A38DDF;
	Tue, 30 Jan 2024 16:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706632531; cv=none; b=Dki85ZrnPuGXcLj4aoAm30GIyja4A6cUQ/pnsnh7vP/11u4Kki64+3HCJAISbkQKXpukvi0eSKWc7mVvZCYAj7YEH0lAR8eoePmSCirpC2E82K4wZ3v8Cy7akYU4AZeWjQZ85yZ+rfDxipR+/KPqig/kDPPiOrKr8wCGsmSl1fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706632531; c=relaxed/simple;
	bh=e6WGrzfI011OwRmHVj7M53wMeTl8sRp+30pwPx8VzMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fyVwGLQZkERTJn7SBfjN93AMf2lKFcYWO7HpewdfIuiUE+DlykcogVZkCHopnNKJh+mRm0tUvdxrzXGETdPdPyYqB+a5I9S90xrbnqb3X00MJC/dcD/fkvmbGVoLjR1L1hJpldKJOGoGYq/A8S2UYYPjlJAfvNf2UFUPEsofK60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bWLCiNLR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92349C43390;
	Tue, 30 Jan 2024 16:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706632530;
	bh=e6WGrzfI011OwRmHVj7M53wMeTl8sRp+30pwPx8VzMk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bWLCiNLRLkEK1vJUF+8N4E/8wRAIoYpJv5JKfnlv1euTtd2aimkBbVzG45XgTxB9S
	 7f3z9D3M4dkRVuWcdgCOlFYLwxHZNbTD0aEfPf5H4ErKorWtSffFvTXtI5qB6oKzTT
	 LglJbNnGQTgbSB3ME+1ye1rHhpzZalfIWM+aQzdE=
Date: Mon, 29 Jan 2024 14:52:23 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Sourav Panda <souravpanda@google.com>
Cc: corbet@lwn.net, rafael@kernel.org, akpm@linux-foundation.org,
	mike.kravetz@oracle.com, muchun.song@linux.dev, rppt@kernel.org,
	david@redhat.com, rdunlap@infradead.org, chenlinxuan@uniontech.com,
	yang.yang29@zte.com.cn, tomas.mudrunka@gmail.com,
	bhelgaas@google.com, ivan@cloudflare.com, pasha.tatashin@soleen.com,
	yosryahmed@google.com, hannes@cmpxchg.org, shakeelb@google.com,
	kirill.shutemov@linux.intel.com, wangkefeng.wang@huawei.com,
	adobriyan@gmail.com, vbabka@suse.cz, Liam.Howlett@oracle.com,
	surenb@google.com, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-mm@kvack.org, willy@infradead.org, weixugc@google.com
Subject: Re: [PATCH v7 1/1] mm: report per-page metadata information
Message-ID: <2024012948-hungry-tibia-5345@gregkh>
References: <20240129224204.1812062-1-souravpanda@google.com>
 <20240129224204.1812062-2-souravpanda@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240129224204.1812062-2-souravpanda@google.com>

On Mon, Jan 29, 2024 at 02:42:04PM -0800, Sourav Panda wrote:
> Adds two new per-node fields, namely nr_page_metadata and
> nr_page_metadata_boot, to /sys/devices/system/node/nodeN/vmstat
> and a global PageMetadata field to /proc/meminfo. This information can
> be used by users to see how much memory is being used by per-page
> metadata, which can vary depending on build configuration, machine
> architecture, and system use.
> 
> Per-page metadata is the amount of memory that Linux needs in order to
> manage memory at the page granularity. The majority of such memory is
> used by "struct page" and "page_ext" data structures. In contrast to
> most other memory consumption statistics, per-page metadata might not
> be included in MemTotal. For example, MemTotal does not include memblock
> allocations but includes buddy allocations. In this patch, exported
> field nr_page_metadata in /sys/devices/system/node/nodeN/vmstat would
> exclusively track buddy allocations while nr_page_metadata_boot would
> exclusively track memblock allocations. Furthermore, PageMetadata in
> /proc/meminfo would exclusively track buddy allocations allowing it to
> be compared against MemTotal.
> 
> This memory depends on build configurations, machine architectures, and
> the way system is used:
> 
> Build configuration may include extra fields into "struct page",
> and enable / disable "page_ext"
> Machine architecture defines base page sizes. For example 4K x86,
> 8K SPARC, 64K ARM64 (optionally), etc. The per-page metadata
> overhead is smaller on machines with larger page sizes.
> System use can change per-page overhead by using vmemmap
> optimizations with hugetlb pages, and emulated pmem devdax pages.
> Also, boot parameters can determine whether page_ext is needed
> to be allocated. This memory can be part of MemTotal or be outside
> MemTotal depending on whether the memory was hot-plugged, booted with,
> or hugetlb memory was returned back to the system.
> 
> Suggested-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Signed-off-by: Sourav Panda <souravpanda@google.com>
> ---
>  Documentation/filesystems/proc.rst |  3 +++
>  fs/proc/meminfo.c                  |  4 ++++
>  include/linux/mmzone.h             |  4 ++++
>  include/linux/vmstat.h             |  4 ++++
>  mm/hugetlb_vmemmap.c               | 19 ++++++++++++++----
>  mm/mm_init.c                       |  3 +++
>  mm/page_alloc.c                    |  1 +
>  mm/page_ext.c                      | 32 +++++++++++++++++++++---------
>  mm/sparse-vmemmap.c                |  8 ++++++++
>  mm/sparse.c                        |  7 ++++++-
>  mm/vmstat.c                        | 26 +++++++++++++++++++++++-
>  11 files changed, 96 insertions(+), 15 deletions(-)
> 
> diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
> index 49ef12df631b..d5901d04e082 100644
> --- a/Documentation/filesystems/proc.rst
> +++ b/Documentation/filesystems/proc.rst
> @@ -993,6 +993,7 @@ Example output. You may not have all of these fields.
>      AnonPages:       4654780 kB
>      Mapped:           266244 kB
>      Shmem:              9976 kB
> +    PageMetadata:     513419 kB
>      KReclaimable:     517708 kB
>      Slab:             660044 kB
>      SReclaimable:     517708 kB

Why are you adding it to the middle of the file?  Are you sure the
userspace tools that parse this file today can handle an unknown field
here, and not just at the end of the file?

thanks,

greg k-h

