Return-Path: <linux-fsdevel+bounces-49470-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03D56ABCDB7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 May 2025 05:16:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F3EA4A2535
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 May 2025 03:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3386A1F416A;
	Tue, 20 May 2025 03:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ll2qeVuw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEDB225743E
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 May 2025 03:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747710983; cv=none; b=SBSfCZIL1+q6BfTBGW5Tep3P+3+oAMInFMjBnkG+87xMqI7Smgjr5i/zOnshyRI1bpY8RSQywXJfXMyvHqACM6kPXkfMTqHXeuBuEEA+4GQv4dqvGl9s6fNBi1K5l95PTWQIviyAVgxL0cZueAp1nhRBHEnAMV6/EhTio1IEfKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747710983; c=relaxed/simple;
	bh=wr/SokuYkrOkEZ/CQiuuek5E2zh5L7FO0f9nUPx6fM0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z++plpbIaizMAWoNU+foYJxocnZsowVUzRlmYmt2mYo7KJ8NXVirHaq43Ww78xGcA88mM4ogKUu6s+t4/xiOecUNl3r+bW568B6jsn9GWjMNRtYhu4z6y1ERTziV5pv7b3FtV3PvNGd3+o381wDWtwemQGSqex58vLCCUeafZT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ll2qeVuw; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ab20e420-dd11-4b39-97b9-bf8041ab62fc@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747710967;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oQfMDoQ260BGjCMrcScg0wHQ7wmLuw8S4sagjFqk5vA=;
	b=ll2qeVuwHYlqF06nbJapV7M04PIb5JWw4ezsb3LpeLlHEgtvPM+woEGuhfJ+qNRUi6arka
	5OrguEJWF2vBokVj0MAr24gB/mhPhZo/ZnGi1wrPXet3sYHISKXoMZ30IpS/Z4khtvFrEJ
	Ru/x3IjYboKkfu6GrysovtojXIv9V7s=
Date: Tue, 20 May 2025 11:15:55 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 2/4] mm: ksm: refer to special VMAs via VM_SPECIAL in
 ksm_compatible()
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>, David Hildenbrand <david@redhat.com>,
 Xu Xin <xu.xin16@zte.com.cn>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <cover.1747431920.git.lorenzo.stoakes@oracle.com>
 <ec973573540c6871683ee763d291b74bd851990f.1747431920.git.lorenzo.stoakes@oracle.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <ec973573540c6871683ee763d291b74bd851990f.1747431920.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2025/5/19 16:51, Lorenzo Stoakes wrote:
> There's no need to spell out all the special cases, also doing it this way
> makes it absolutely clear that we preclude unmergeable VMAs in general, and
> puts the other excluded flags in stark and clear contrast.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Nice.

Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>

Thanks!

> ---
>   mm/ksm.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/ksm.c b/mm/ksm.c
> index 08d486f188ff..d0c763abd499 100644
> --- a/mm/ksm.c
> +++ b/mm/ksm.c
> @@ -679,9 +679,8 @@ static int break_ksm(struct vm_area_struct *vma, unsigned long addr, bool lock_v
>   
>   static bool ksm_compatible(const struct file *file, vm_flags_t vm_flags)
>   {
> -	if (vm_flags & (VM_SHARED   | VM_MAYSHARE   | VM_PFNMAP  |
> -			VM_IO       | VM_DONTEXPAND | VM_HUGETLB |
> -			VM_MIXEDMAP | VM_DROPPABLE))
> +	if (vm_flags & (VM_SHARED  | VM_MAYSHARE | VM_SPECIAL |
> +			VM_HUGETLB | VM_DROPPABLE))
>   		return false;		/* just ignore the advice */
>   
>   	if (file_is_dax(file))

