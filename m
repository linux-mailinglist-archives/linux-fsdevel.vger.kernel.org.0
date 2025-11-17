Return-Path: <linux-fsdevel+bounces-68758-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 11A5EC657A1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 18:27:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 93F814ECBBC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 17:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBD843396FD;
	Mon, 17 Nov 2025 17:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bxbrXTDR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285BB33769F;
	Mon, 17 Nov 2025 17:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763399713; cv=none; b=M7eE9n23PYg1bX0YDX+vYOLLuy8cMpk/4q/OCs0ToSlmZlwwLaqppc/X6l/wAp/O1eYlD6llAS701BV5oCsh/RY4W5o5iomj40fkspunmo/EClj0mCLP4gLlh+U8WgYW6WoPqhzWB8QG52KcTp5A3oLscknn280977dFkt2NYHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763399713; c=relaxed/simple;
	bh=RLJWDgvqexJm3kpqTl9EZT21sIb+C2Qyt8z0WQg5EU4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nj57JjsQHLUEu46+Eqo9UakU/QfNYgDadjwEW/l6iDT9suwFIqgH3YvXviqIr0f477a4Y9/Dqaym1Wj95vG9zh0t84WotIvohjd6lzToCMXdQzCy1BoULquMff0gVdSzlabsvXafgNk4K5rbamhaRiBcuJccfwCaaCXW7wYWIkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bxbrXTDR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9913DC19422;
	Mon, 17 Nov 2025 17:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763399712;
	bh=RLJWDgvqexJm3kpqTl9EZT21sIb+C2Qyt8z0WQg5EU4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bxbrXTDR84ASz4tPia6zDAvidOkIROEQEVrS/yyvBNhsrAhCaKYTV112+R5LelGFB
	 InCyMARDK+hXkSXbbxVgeKbwVuhXdG9Yh0+m2kg9c3sQT3/8cI4SSnUY16OdAujjvW
	 uWuQddql+Nc7DiV9Sy/n7TcNnn/xIyyeGgNcjqUSSlH9+AbGVlDUt5ZqK3BZnnketu
	 Uy7uwb9ufarWAAZ75hnHiCLrhI3TYfQCzAfcflxc0CwsSTP8sO9HIfAnMH5g4qJeyh
	 nHrA8yWDZDzzkWUK3By7nEghAXuTg9/nkAPxcyCnBHAwW++NssX7203zMAgbqOcYdt
	 ZcB8/XtwKCfzQ==
Message-ID: <bcfd5575-cff0-4ead-9136-dd509bf11f64@kernel.org>
Date: Mon, 17 Nov 2025 18:15:06 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] mm/memory-failure: avoid free HWPoison high-order
 folio
To: Jiaqi Yan <jiaqiyan@google.com>, nao.horiguchi@gmail.com,
 linmiaohe@huawei.com, ziy@nvidia.com
Cc: lorenzo.stoakes@oracle.com, william.roche@oracle.com,
 harry.yoo@oracle.com, tony.luck@intel.com, wangkefeng.wang@huawei.com,
 willy@infradead.org, jane.chu@oracle.com, akpm@linux-foundation.org,
 osalvador@suse.de, muchun.song@linux.dev, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20251116014721.1561456-1-jiaqiyan@google.com>
 <20251116014721.1561456-3-jiaqiyan@google.com>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <20251116014721.1561456-3-jiaqiyan@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16.11.25 02:47, Jiaqi Yan wrote:
> At the end of dissolve_free_hugetlb_folio, when a free HugeTLB
> folio becomes non-HugeTLB, it is released to buddy allocator
> as a high-order folio, e.g. a folio that contains 262144 pages
> if the folio was a 1G HugeTLB hugepage.
> 
> This is problematic if the HugeTLB hugepage contained HWPoison
> subpages. In that case, since buddy allocator does not check
> HWPoison for non-zero-order folio, the raw HWPoison page can
> be given out with its buddy page and be re-used by either
> kernel or userspace.
> 
> Memory failure recovery (MFR) in kernel does attempt to take
> raw HWPoison page off buddy allocator after
> dissolve_free_hugetlb_folio. However, there is always a time
> window between freed to buddy allocator and taken off from
> buddy allocator.
> 
> One obvious way to avoid this problem is to add page sanity
> checks in page allocate or free path. However, it is against
> the past efforts to reduce sanity check overhead [1,2,3].
> 
> Introduce hugetlb_free_hwpoison_folio to solve this problem.
> The idea is, in case a HugeTLB folio for sure contains HWPoison
> page(s), first split the non-HugeTLB high-order folio uniformly
> into 0-order folios, then let healthy pages join the buddy
> allocator while reject the HWPoison ones.
> 
> [1] https://lore.kernel.org/linux-mm/1460711275-1130-15-git-send-email-mgorman@techsingularity.net/
> [2] https://lore.kernel.org/linux-mm/1460711275-1130-16-git-send-email-mgorman@techsingularity.net/
> [3] https://lore.kernel.org/all/20230216095131.17336-1-vbabka@suse.cz
> 
> Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>


[...]

>   /*
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 3edebb0cda30b..e6a9deba6292a 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -2002,6 +2002,49 @@ int __get_huge_page_for_hwpoison(unsigned long pfn, int flags,
>   	return ret;
>   }
>   
> +void hugetlb_free_hwpoison_folio(struct folio *folio)

What is hugetlb specific in here? :)

Hint: if there is nothing, likely it should be generic infrastructure.

But I would prefer if the page allocator could just take care of that 
when freeing a folio.

-- 
Cheers

David

