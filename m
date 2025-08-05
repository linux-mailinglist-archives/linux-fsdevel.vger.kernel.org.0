Return-Path: <linux-fsdevel+bounces-56706-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94CB2B1AC2A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 03:41:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3D0818087E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 01:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82ECE1A239D;
	Tue,  5 Aug 2025 01:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="EhfvULJn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5353FA41;
	Tue,  5 Aug 2025 01:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754358106; cv=none; b=ojucn8YlHltxwYqg/WKdV7tnQjoQG/hNB2OAMtIcInt04NFKmIa5zk2nRMsWjgJlGPjC+W/4CJldC10wuyZRmZXlH9AIjs1DZiCKPu6HQ3qhGn3/t7raPVV19T2dLrZqz7zshMp0OcOHtaWtsNy9aGpf5qUzm6pyI+yRU/7XoKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754358106; c=relaxed/simple;
	bh=k5XrY1B3TV43SkDqF3kk4f9XGmVe9KKBMmYc28bmAPc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ht7/D24ufFqjhrVus9R+2sW7/weOIvMpw4PRF7dqvhWha00m4Vo35L3Ht1BFFxz+hTBKi+Lzn+jJiiyNxyQEFX0ghxtLyeVH8fywmwj6iQaGBSTpaQ5oaIYWutyMxZ+fDl0+xj1CCVfzV5YK3wUYv0/YLLKRVclu7+zA1cJ71iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=EhfvULJn; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1754358095; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=sPrO0h2D30ui+zm6MLtXYmt/y/NyN6nZoAqs4yAWrlI=;
	b=EhfvULJn+FUo3bE+4JArryhPnYn+l79EFLVTE7Lh5mYpdo6xysHVUkn08/CFrsNK3nkuZj80AYUiNm1wsw6r0B1ogi2DrN9J3+EN1RTef2j4sMa5yZ8PJXifjquEl6vBFVUjnEhBkaCzArefnsDNMhWjJqbJ49Iqj0mbPNpP0og=
Received: from 30.74.144.114(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0Wl33Qh7_1754358092 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 05 Aug 2025 09:41:33 +0800
Message-ID: <aa1666eb-022b-4d2b-9f2a-6c8f79237c50@linux.alibaba.com>
Date: Tue, 5 Aug 2025 09:41:32 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/6] mm/huge_memory: convert "tva_flags" to "enum
 tva_type"
To: Usama Arif <usamaarif642@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, david@redhat.com,
 linux-mm@kvack.org
Cc: linux-fsdevel@vger.kernel.org, corbet@lwn.net, rppt@kernel.org,
 surenb@google.com, mhocko@suse.com, hannes@cmpxchg.org, baohua@kernel.org,
 shakeel.butt@linux.dev, riel@surriel.com, ziy@nvidia.com,
 laoar.shao@gmail.com, dev.jain@arm.com, npache@redhat.com,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, ryan.roberts@arm.com,
 vbabka@suse.cz, jannh@google.com, Arnd Bergmann <arnd@arndb.de>,
 sj@kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 kernel-team@meta.com
References: <20250804154317.1648084-1-usamaarif642@gmail.com>
 <20250804154317.1648084-3-usamaarif642@gmail.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20250804154317.1648084-3-usamaarif642@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/8/4 23:40, Usama Arif wrote:
> From: David Hildenbrand <david@redhat.com>
> 
> When determining which THP orders are eligible for a VMA mapping,
> we have previously specified tva_flags, however it turns out it is
> really not necessary to treat these as flags.
> 
> Rather, we distinguish between distinct modes.
> 
> The only case where we previously combined flags was with
> TVA_ENFORCE_SYSFS, but we can avoid this by observing that this
> is the default, except for MADV_COLLAPSE or an edge cases in
> collapse_pte_mapped_thp() and hugepage_vma_revalidate(), and
> adding a mode specifically for this case - TVA_FORCED_COLLAPSE.
> 
> We have:
> * smaps handling for showing "THPeligible"
> * Pagefault handling
> * khugepaged handling
> * Forced collapse handling: primarily MADV_COLLAPSE, but also for
>    an edge case in collapse_pte_mapped_thp()
> 
> Disregarding the edge cases, we only want to ignore sysfs settings only
> when we are forcing a collapse through MADV_COLLAPSE, otherwise we
> want to enforce it, hence this patch does the following flag to enum
> conversions:
> 
> * TVA_SMAPS | TVA_ENFORCE_SYSFS -> TVA_SMAPS
> * TVA_IN_PF | TVA_ENFORCE_SYSFS -> TVA_PAGEFAULT
> * TVA_ENFORCE_SYSFS             -> TVA_KHUGEPAGED
> * 0                             -> TVA_FORCED_COLLAPSE
> 
> With this change, we immediately know if we are in the forced collapse
> case, which will be valuable next.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> Acked-by: Usama Arif <usamaarif642@gmail.com>
> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
> ---

Looks really nice. Thanks.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

