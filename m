Return-Path: <linux-fsdevel+bounces-51238-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A40EAD4D5D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 09:43:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2DA11BC0ECD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 07:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A435E2367BC;
	Wed, 11 Jun 2025 07:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="hHFZ1Ths"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC14231839;
	Wed, 11 Jun 2025 07:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749627708; cv=none; b=OIcdA+EsckrTgmAtbF4cf3oRSRFDT1begj78vqpxp844hrbSlc2WYr2QLuTgcWrSTheWqo1K43/9AgZGJop/Lq2aXdkiCxUo1qL96bxLYBupIPhuDJCn2MOhWhKZtQVJN778BTRKK1aA6e05O9f4a3OiiN9umxOytVkUFrfhclM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749627708; c=relaxed/simple;
	bh=l+BiDfw3/ID60Oy1QyNfLH/S+j5nSbuXDdxWB1eXT50=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qe+xBAH6xfEI+VauGhEJ29tE9wwVMd6DMM3DYZBZ3kSu/bS6okulETDSyNDyNCA02zi/j9P0PoxR+LvD8jNPpmTxyOIkrIb7LJoD1u54s8rGTmUkjy1jpKz+sCCIjllMPlvTNGXkIFwJREDPp4ZL39Q1lJ68K3ykLm+XznoteRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=hHFZ1Ths; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1749627696; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=uq80mpSiBoOoP0SpXROsynAkOFNz2d9hYKWr1AlfZnY=;
	b=hHFZ1Thsc89b5nTnkNqAaVoaG5hFzpC06z1s4xPs50eChwPZueMJuztZQeUmzVtyvQUARc1EdYzbHTO/pUUfwsIYJCjAeRB2S8Uwvt/oITquDSJKEeOf1cshxZ9SHhY4tIeXDqDRxsFrmQSjEHwmxduUCqT0+lbNiC0sAhECWS8=
Received: from 30.74.144.128(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WdcFevd_1749627695 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 11 Jun 2025 15:41:36 +0800
Message-ID: <24580f79-c104-41aa-bbdb-e1ce120c28a0@linux.alibaba.com>
Date: Wed, 11 Jun 2025 15:41:35 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] mm: shmem: avoid setting error on splited entries in
 shmem_set_folio_swapin_error()
To: Kemeng Shi <shikemeng@huaweicloud.com>, hughd@google.com,
 willy@infradead.org, akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
References: <20250605221037.7872-1-shikemeng@huaweicloud.com>
 <20250605221037.7872-3-shikemeng@huaweicloud.com>
 <c05b8612-83a6-47f7-84f8-72276c08a4ac@linux.alibaba.com>
 <100d50f3-95df-86a3-7965-357d72390193@huaweicloud.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <100d50f3-95df-86a3-7965-357d72390193@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/6/9 09:19, Kemeng Shi wrote:
> 
> 
> on 6/7/2025 2:20 PM, Baolin Wang wrote:
>>
>>
>> On 2025/6/6 06:10, Kemeng Shi wrote:
>>> When large entry is splited, the first entry splited from large entry
>>> retains the same entry value and index as original large entry but it's
>>> order is reduced. In shmem_set_folio_swapin_error(), if large entry is
>>> splited before xa_cmpxchg_irq(), we may replace the first splited entry
>>> with error entry while using the size of original large entry for release
>>> operations. This could lead to a WARN_ON(i_blocks) due to incorrect
>>> nr_pages used by shmem_recalc_inode() and could lead to used after free
>>> due to incorrect nr_pages used by swap_free_nr().
>>
>> I wonder if you have actually triggered this issue? When a large swap entry is split, it means the folio is already at order 0, so why would the size of the original large entry be used for release operations? Or is there another race condition?
> All issues are found during review the code of shmem as I menthioned in
> cover letter.
> The folio could be allocated from shmem_swap_alloc_folio() and the folio
> order will keep unchange when swap entry is split.

Sorry, I did not get your point. If a large swap entry is split, we must 
ensure that the corresponding folio is order 0.

However, I missed one potential case which was recently fixed by Kairui[1].

[1] https://lore.kernel.org/all/20250610181645.45922-1-ryncsn@gmail.com/

