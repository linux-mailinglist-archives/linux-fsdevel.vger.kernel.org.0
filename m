Return-Path: <linux-fsdevel+bounces-66408-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DD3C4C1E1F6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 03:25:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 56E104E0716
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 02:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE4931813A;
	Thu, 30 Oct 2025 02:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WDT5Wp6y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76363321F5F
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Oct 2025 02:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761791143; cv=none; b=AKUgJxoFH9UEE8lL4CR+a4sO7V6IV0JbUvXoKPEpo8ioUyHkcpFtAEvnugLVK2oRgxFJzk5sjeM5aL8fnx+T9YN9hCEeyP3dCLrNgEXVUIVw+7aa+2IkkNP/j4eet0sgVmgvMYAwSo3QLSvDkShkmiMwQEIUv1gjLBC95bF4848=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761791143; c=relaxed/simple;
	bh=/1eWmis339CcsmkDDuGnQyF6HgX2z2FodLnqAzdsuQQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qSOa1lTYClo92WeWKSTxdTX0t5zC8Fwr7lHtyXd7U+Z/wfiFakQ6/jYlZCnUBfsXa4zj7tEl9QdKzR4kJNOu1KZ+zbi1KB2Rs7nEz4pwINIMOo+gpG83EA/GlYVuRbpYBsVdtQ0bibEFCEsRUp1maLC0RqrIdrZdoPPJnoqL0Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WDT5Wp6y; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <4ff09b34-fc18-4dcd-91e7-2e199d88e133@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761791126;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3UyupsXh7QI3IpXLiJnSS9fzReGG9d97Eh4CpeWxH5k=;
	b=WDT5Wp6y6jrOwkHrqHxb3NYddT6JMZE1rFl8MwLNhXWLePJcpelDdcmraCl1b6kADLrvP/
	OmlCpTqqpTCiBugvw/8TnfH+ES4arI53JBx61JoEc7krBaxUolqIQxv49AWoGarxL2yDu8
	qmci9hK83UaaotYBL78770tMoTbBpGg=
Date: Thu, 30 Oct 2025 10:25:13 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 1/3] mm/huge_memory: add split_huge_page_to_order()
To: Zi Yan <ziy@nvidia.com>
Cc: kernel@pankajraghav.com, akpm@linux-foundation.org, mcgrof@kernel.org,
 nao.horiguchi@gmail.com, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 jane.chu@oracle.com, Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, "Matthew Wilcox (Oracle)"
 <willy@infradead.org>, Wei Yang <richard.weiyang@gmail.com>,
 Yang Shi <shy828301@gmail.com>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linmiaohe@huawei.com, linux-mm@kvack.org,
 david@redhat.com
References: <20251030014020.475659-1-ziy@nvidia.com>
 <20251030014020.475659-2-ziy@nvidia.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <20251030014020.475659-2-ziy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2025/10/30 09:40, Zi Yan wrote:
> When caller does not supply a list to split_huge_page_to_list_to_order(),
> use split_huge_page_to_order() instead.
> 
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> Acked-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---

Reviewed-by: Lance Yang <lance.yang@linux.dev>

