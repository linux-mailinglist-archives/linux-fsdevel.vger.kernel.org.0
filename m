Return-Path: <linux-fsdevel+bounces-589-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F062A7CD5B6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 09:52:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60C07281B1E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 07:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E36511C81;
	Wed, 18 Oct 2023 07:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wvJymKSb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0D58486;
	Wed, 18 Oct 2023 07:52:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FF77C433C7;
	Wed, 18 Oct 2023 07:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1697615521;
	bh=woRiGHLdU4jN8s9X4H6woCtgWH/Emk3o/3wRf0O5stM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wvJymKSbfEo8z0QgshiW8SmB7gEJp1YGkZx8jhEcuTRaIvBKTQHxQKNwgKyUmTugS
	 HuBTL0EbJ2FBW5ZgxZXEUgC21DfKHZi1yuBPeuAjFGUAl2r7ETzrBBOrG2rUeYKHAr
	 WXZjd1aR0FGnVZ6juMQ/GYSRrjvD8vr5EuIb1MWA=
Date: Wed, 18 Oct 2023 09:51:58 +0200
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
	linux-mm@kvack.org, willy@infradead.org
Subject: Re: [PATCH v2 1/1] mm: report per-page metadata information
Message-ID: <2023101824-ventricle-hacked-6450@gregkh>
References: <20231018005548.3505662-1-souravpanda@google.com>
 <20231018005548.3505662-2-souravpanda@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018005548.3505662-2-souravpanda@google.com>

On Tue, Oct 17, 2023 at 05:55:48PM -0700, Sourav Panda wrote:
> Adds a new per-node PageMetadata field to
> /sys/devices/system/node/nodeN/meminfo
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
> allocations but includes buddy allocations. While on the other hand,
> per-page metadata would include both memblock and buddy allocations.
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
> Change-Id: I4351791c9f4c1e9759cbd8e646e808565dbb595f

checkpatch.pl should have said that "Change-Id:" should be removed, why
didn't you run this on your patch before submitting it?

thanks,

greg k-h

