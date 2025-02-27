Return-Path: <linux-fsdevel+bounces-42743-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B0ACA473B3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2025 04:43:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49EF67A4F11
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2025 03:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE0F1E51E7;
	Thu, 27 Feb 2025 03:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="tXqaFK2o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA1E1CAA79;
	Thu, 27 Feb 2025 03:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740627814; cv=none; b=Bn0pMcxztKD86DAHxFbw5B80diP+DB6KOdr2vS4t80gYDJwe//FmTJZQtXR7+CzudGBIi6sqyJJXO/Lpk276XRl07xRviFOppOBI4EHe4QkozNQ11TxYqxA4UgltUam2hemdX0VNXE8pCKlo8jOTuGGSFVFLRkEfdH7CSxDRkCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740627814; c=relaxed/simple;
	bh=9GlsjQr2QhDcFn03r9Qw1k4bhpLAnS5b82yQXLTd5ag=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FiZdPVjHHLpAZEdqtBvsRZzZ9+TI9ifPQjR7mdEfeb0sI9KrNUBeUYxe6qF1f0D6n1ZM9Y0EixRCJi4YDfFxUaePsP3zA1HnHpOdam0T4Pct6NVC0f7Cgl3Y53iHFxERSm3kjiZKdr8teiFcjV5xmCvQBPDami5Vgq1VvxIw3O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=tXqaFK2o; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1740627807; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=TMLk+pH9DL7fAhjLGVm//3iZnCFaZVw+B1tXOrFpX0U=;
	b=tXqaFK2ohYXbA31KmAjB7uVDIBxreqJIfcxx0sc4VoRsMkfnGFfLHrBIUon2ve+9Vr3QhvbEc91RAjXr0lh2AqE14pcofjIw5eseVG5NTfgJX2hpybh0GJLVXLyKeGgWJeKY5zFqTVRtVlykZmawznFR9gTPtGZYfqGiL2f19kE=
Received: from 30.74.144.117(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WQKuZaU_1740627805 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 27 Feb 2025 11:43:26 +0800
Message-ID: <250ce8a5-8f2c-4d29-b73b-ea9a117598f0@linux.alibaba.com>
Date: Thu, 27 Feb 2025 11:43:24 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] mm/shmem: use xas_try_split() in
 shmem_split_large_entry()
To: Zi Yan <ziy@nvidia.com>, Matthew Wilcox <willy@infradead.org>,
 linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins
 <hughd@google.com>, Kairui Song <kasong@tencent.com>,
 Miaohe Lin <linmiaohe@huawei.com>, linux-kernel@vger.kernel.org,
 David Hildenbrand <david@redhat.com>, John Hubbard <jhubbard@nvidia.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>,
 "Kirill A. Shuemov" <kirill.shutemov@linux.intel.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Yang Shi <yang@os.amperecomputing.com>,
 Yu Zhao <yuzhao@google.com>
References: <20250226210854.2045816-1-ziy@nvidia.com>
 <20250226210854.2045816-3-ziy@nvidia.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20250226210854.2045816-3-ziy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/2/27 05:08, Zi Yan wrote:
> During shmem_split_large_entry(), large swap entries are covering n slots
> and an order-0 folio needs to be inserted.
> 
> Instead of splitting all n slots, only the 1 slot covered by the folio
> need to be split and the remaining n-1 shadow entries can be retained with
> orders ranging from 0 to n-1.  This method only requires
> (n/XA_CHUNK_SHIFT) new xa_nodes instead of (n % XA_CHUNK_SHIFT) *
> (n/XA_CHUNK_SHIFT) new xa_nodes, compared to the original
> xas_split_alloc() + xas_split() one.
> 
> For example, to split an order-9 large swap entry (assuming XA_CHUNK_SHIFT
> is 6), 1 xa_node is needed instead of 8.
> 
> xas_try_split_min_order() is used to reduce the number of calls to
> xas_try_split() during split.
> 
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Kairui Song <kasong@tencent.com>
> Cc: Mattew Wilcox <willy@infradead.org>
> Cc: Miaohe Lin <linmiaohe@huawei.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
> Cc: Kirill A. Shuemov <kirill.shutemov@linux.intel.com>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: Yang Shi <yang@os.amperecomputing.com>
> Cc: Yu Zhao <yuzhao@google.com> > ---

LGTM. Feel free to add:
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Tested-by: Baolin Wang <baolin.wang@linux.alibaba.com>

