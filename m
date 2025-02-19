Return-Path: <linux-fsdevel+bounces-42053-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ED85A3BB3C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 11:09:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D807A3ABE59
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 10:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BFAE1D5142;
	Wed, 19 Feb 2025 10:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="TClOvpmz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448081C5D4B;
	Wed, 19 Feb 2025 10:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739959506; cv=none; b=kM3Puwlf2SJns01Ir945M/ITscoM8t7QZZtlk5RhdvUH6vGpqlgSzLjPuZw+MNqwdLu/be/5Z7vxCBk696dIkqaAsLp5AfdWHayaDtuxgObwU0Wl74aJExUvoobQEKPqwkBZFTS1NTEVZqkxWNtFbVf7RBGQ2RprzaQaNEXj8QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739959506; c=relaxed/simple;
	bh=YzuIjqnMTrFlB4hvEKVFysqiE8b1+xS0KXoi/G2/UUQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KjLxnqa3biUdrHpixaFe+qY10BS+sRtYL9fQdpY4Ly4WJw8snFVjMSxqmAXMSwaJqpFaSuVodBD6b48IqeYhSjfDT6SkdDXYdl8PbfVEVi6aoxkhQcVL3Mje6RWv9lZqcFek+0x/5TYzJcy9hTayCnhe8OAoetZo5Pzi0dkCQUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=TClOvpmz; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1739959499; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=WGGGatMc3XTlrHZosb11mRPJJMxCkTLAw1+W24e+j8M=;
	b=TClOvpmzbeU863V50FX13OBOPPwL0dStIJziPpazookxmeYKrElHNbcOT+dJryElZcwPiDGH4WDAjo6EDiipZ8OY79HWqrx+x1YCsRx1wt6se8fwPm6KJle5QtEMwHgxYYwfcG6jY0iPP2Au1oEN0/XNlaGNIFmf4jehLa2Xick=
Received: from 30.74.144.134(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WPp2srF_1739959498 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 19 Feb 2025 18:04:58 +0800
Message-ID: <f899d6b3-e607-480b-9acc-d64dfbc755b5@linux.alibaba.com>
Date: Wed, 19 Feb 2025 18:04:57 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] mm/shmem: use xas_try_split() in
 shmem_split_large_entry()
To: Zi Yan <ziy@nvidia.com>, Matthew Wilcox <willy@infradead.org>,
 linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins
 <hughd@google.com>, Kairui Song <kasong@tencent.com>,
 Miaohe Lin <linmiaohe@huawei.com>, linux-kernel@vger.kernel.org
References: <20250218235444.1543173-1-ziy@nvidia.com>
 <20250218235444.1543173-3-ziy@nvidia.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20250218235444.1543173-3-ziy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Zi,

Sorry for the late reply due to being busy with other things:)

On 2025/2/19 07:54, Zi Yan wrote:
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

For shmem swapin, if we cannot swap in the whole large folio by skipping 
the swap cache, we will split the large swap entry stored in the shmem 
mapping into order-0 swap entries, rather than splitting it into other 
orders of swap entries. This is because the next time we swap in a shmem 
folio through shmem_swapin_cluster(), it will still be an order 0 folio.

Moreover I did a quick test with swapping in order 6 shmem folios, 
however, my test hung, and the console was continuously filled with the 
following information. It seems there are some issues with shmem swapin 
handling. Anyway, I need more time to debug and test.

[ 1037.364644] Huh VM_FAULT_OOM leaked out to the #PF handler. Retrying PF
[ 1037.364650] Huh VM_FAULT_OOM leaked out to the #PF handler. Retrying PF
[ 1037.364652] Huh VM_FAULT_OOM leaked out to the #PF handler. Retrying PF
[ 1037.364654] Huh VM_FAULT_OOM leaked out to the #PF handler. Retrying PF
[ 1037.364656] Huh VM_FAULT_OOM leaked out to the #PF handler. Retrying PF
[ 1037.364658] Huh VM_FAULT_OOM leaked out to the #PF handler. Retrying PF
[ 1037.364659] Huh VM_FAULT_OOM leaked out to the #PF handler. Retrying PF
[ 1037.364661] Huh VM_FAULT_OOM leaked out to the #PF handler. Retrying PF
[ 1037.364663] Huh VM_FAULT_OOM leaked out to the #PF handler. Retrying PF
[ 1037.364665] Huh VM_FAULT_OOM leaked out to the #PF handler. Retrying PF
[ 1042.368539] pagefault_out_of_memory: 9268696 callbacks suppressed
.......

