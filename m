Return-Path: <linux-fsdevel+bounces-63830-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E02BCEE8A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Oct 2025 04:26:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0378E4E664D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Oct 2025 02:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 677101A5BBF;
	Sat, 11 Oct 2025 02:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vB0mJX1W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE44199920
	for <linux-fsdevel@vger.kernel.org>; Sat, 11 Oct 2025 02:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760149579; cv=none; b=EVHWCT/M77d4/w1/FEuueC39zOvK+u7p3t5Ng4r9iJ3aSuAJjpkMYqsrzE9nsDDGWfEwecRzSoZOSaT+HNnSO3bhIy1RocEETJaxc64jZ6rbxRMXIkJMNzaeGXMVR+UDyQ6sKCLm31ajYVUeL/sSftOopX7LbzB7KWvFjzjIKps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760149579; c=relaxed/simple;
	bh=Spz8mgNeIjLrnK+JA8dUU8ss8GpWIUU8Zz7CSq+cc3Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uu2oYR3tQc5DZV/gf6KUtolwTe1lT59cu5VtUtullcjQOhr9rR4zk1tJutnIfT/pOHZGUI+KHijIzJBhEQ7Ys2xfoafC9uYOiPeQ7LQaFFIhqvC7HWfdbLPQQTUnPad3vtCRBy1I+tjBDtOqM0b1ndozmrooLSXsTz5nrmwMG34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vB0mJX1W; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <11b98453-560d-4c55-8ac9-43d1cf7b3543@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760149565;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=glw7LqX8YIF4goQyas3LH1XhAoGCNP4CDVbcxVzULlQ=;
	b=vB0mJX1WVLm7p2+PYMb4d3Gf9q72xxjJYKQXYBSlGMDS4/eVHrskJn/asTnChLcoJ0RmpH
	mJ7bDtyRWQqx4L7XV0wU9hikly6seWylvUH4KKCX0+/tnHQsTKs/tAQdCEoB5zA13MZOwN
	EBdJA7KzGc6Yh8OqTjb42OHX926M5D0=
Date: Sat, 11 Oct 2025 10:25:57 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] mm/huge_memory: do not change split_huge_page*()
 target order silently.
Content-Language: en-US
To: Zi Yan <ziy@nvidia.com>
Cc: akpm@linux-foundation.org, syzkaller-bugs@googlegroups.com,
 mcgrof@kernel.org, nao.horiguchi@gmail.com,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, kernel@pankajraghav.com,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, jane.chu@oracle.com,
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 linux-fsdevel@vger.kernel.org, david@redhat.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, linmiaohe@huawei.com,
 syzbot+e6367ea2fdab6ed46056@syzkaller.appspotmail.com
References: <20251010173906.3128789-1-ziy@nvidia.com>
 <20251010173906.3128789-2-ziy@nvidia.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <20251010173906.3128789-2-ziy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2025/10/11 01:39, Zi Yan wrote:
> Page cache folios from a file system that support large block size (LBS)
> can have minimal folio order greater than 0, thus a high order folio might
> not be able to be split down to order-0. Commit e220917fa507 ("mm: split a
> folio in minimum folio order chunks") bumps the target order of
> split_huge_page*() to the minimum allowed order when splitting a LBS folio.
> This causes confusion for some split_huge_page*() callers like memory
> failure handling code, since they expect after-split folios all have
> order-0 when split succeeds but in really get min_order_for_split() order
> folios.
> 
> Fix it by failing a split if the folio cannot be split to the target order.
> 
> Fixes: e220917fa507 ("mm: split a folio in minimum folio order chunks")
> [The test poisons LBS folios, which cannot be split to order-0 folios, and
> also tries to poison all memory. The non split LBS folios take more memory
> than the test anticipated, leading to OOM. The patch fixed the kernel
> warning and the test needs some change to avoid OOM.]
> Reported-by: syzbot+e6367ea2fdab6ed46056@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/68d2c943.a70a0220.1b52b.02b3.GAE@google.com/
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---
>   include/linux/huge_mm.h | 28 +++++-----------------------
>   mm/huge_memory.c        |  9 +--------
>   mm/truncate.c           |  6 ++++--
>   3 files changed, 10 insertions(+), 33 deletions(-)
> 
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index 8eec7a2a977b..9950cda1526a 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -394,34 +394,16 @@ static inline int split_huge_page_to_list_to_order(struct page *page, struct lis
>    * Return: 0: split is successful, otherwise split failed.
>    */
>   static inline int try_folio_split(struct folio *folio, struct page *page,
> -		struct list_head *list)
> +		struct list_head *list, unsigned int order)

Seems like we need to add the order parameter to the stub for 
try_folio_split() as well?

#ifdef CONFIG_TRANSPARENT_HUGEPAGE

...

#else /* CONFIG_TRANSPARENT_HUGEPAGE */

static inline int try_folio_split(struct folio *folio, struct page *page,
		struct list_head *list)
{
	VM_WARN_ON_ONCE_FOLIO(1, folio);
	return -EINVAL;
}

#endif /* CONFIG_TRANSPARENT_HUGEPAGE */

Cheers,
Lance

