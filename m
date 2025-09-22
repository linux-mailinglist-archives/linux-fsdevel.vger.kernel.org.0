Return-Path: <linux-fsdevel+bounces-62372-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EE1EB8F8FF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Sep 2025 10:36:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B97617A6021
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Sep 2025 08:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47040277CAE;
	Mon, 22 Sep 2025 08:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YqOEElXU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138779463
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Sep 2025 08:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758529859; cv=none; b=hE8mXNq5kN/N51UWXZNKgPgoL+/YBrBSHJmADY6iC3zo9LrXDpZrS9XaXTkSAZYMMsyCwhO4bCpxM1RX4Kkto2eZ6ghMXtEacSZm8qWn7t00pd32oGM2fom5Q1WOfPpzaJlXsRF6ZTIMbPlsiNYXFqttBDLYOHui4zSjotYLh8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758529859; c=relaxed/simple;
	bh=7URL8Whx7YinWepO0tBloI/P9oc2FuIGpO7Ilt8qBZM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cigsbiF+mExMZrgVt+6ng8kIxx8rFaZn1lHo10/qTzBWoXtmLxP33NG3TpCKJ+m419TOlkg2/wVBgsoZJVwRa/IABAV/yzslhyaypwM+1jFuyzq9IMTCULCuJbth3yUcu6wuAuHlo09hbxmKJkUITIINyu9W+N8WfWnFxDf7RSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YqOEElXU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758529855;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=1v7AejRsDx7YJTfIsqR2wjIJYLTYoUc9DZoQno78EIs=;
	b=YqOEElXUloz8xZ+pmgSKZy6Df9HDsazC69H3PLc0HIwPVNK6uAs8EPegBvYHv9X2C4biQ7
	MkTYdhiJxennpMkBxZk1lpk78QY7f01mwUcS//PYV+Jn5JGiv70wuYRGWC6dV7dwQiTwhS
	YM7r8HFI4FzbtvmFpW11q3v4ezJ2SeM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-320-gO5j5x-NOKiHiIoULXva4g-1; Mon, 22 Sep 2025 04:30:54 -0400
X-MC-Unique: gO5j5x-NOKiHiIoULXva4g-1
X-Mimecast-MFC-AGG-ID: gO5j5x-NOKiHiIoULXva4g_1758529853
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3f93db57449so743501f8f.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Sep 2025 01:30:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758529853; x=1759134653;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1v7AejRsDx7YJTfIsqR2wjIJYLTYoUc9DZoQno78EIs=;
        b=NOhgKqtn1BZ1aPU2uTJdITfXasf1lXmin+sHg3Uc4FV550+BqjDuXV5/CiQzLgz956
         t6q0fwBAX3OfHP0KOinuz4hnH4tzfe7etS5pTG05QV96tChuSex4vYfMKG2wLi9sJOd7
         RBUunhY3J9A13nnHefVS3nlg9eeGW5MivhBjZKbQj2yX+jtwme/Do7R08zNDCY5ikK3S
         B1eBpxv0XPScs2OdPQTcWrTvFbH85kgvjsx/nOi3RUeSuAtKtRrc3EBWMUYAjjJxYg52
         FI32u+PdQgeMyozHsGEwLP1mzMASl4pHabhHWsFDs/LZLHcw+5+gHgQrTMJkgp+8/lry
         DYZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSH4Zrh0ZPzobueaRAJF8G9RcmUN/n2REi7+A1PY3ElBptiRQ0ZtyF7gCC+W52DY4Q8B7MlbmHfFRtUa6u@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1jLAPHbRgDW1Nod/uunVBEDCaCinoIz1MMjTgTduBZjvIZbMI
	fZ7RWLI9YG69dgUmrCHD8v0kuncBz9ZXZrpcocahHoqdplny60C4ZOOBG4omm3g+26OAd5KNCUw
	INWqzgn5Y1WEF6cm3EKfQBLJ5vrHUwE3x98iivmeL7nM2X7hj0HVJwOlXqAIv0MylG/A=
X-Gm-Gg: ASbGncvO9sASdCCdTmJ628fP8RfEOO4IAsiFtgfSRgLjaHwP0BvPEkzyDoWM/2ZIpVu
	nMIGvuY7TpmsUondj3hcdEnNUwHG7JFGc8beBLHaXq04HviDKTHR5v1HKNN7mmQHzUMUi8XYrNK
	VMBsWBTY/hNMhvR4lmKNkl7lrF2wtzuybnJxsvnQxJetjt+jRNeUBXK79k7ABHU7xJTFUY4UVXe
	KhI2LxdGc6HCQfTfuUEPKoRV2Fob2g9Ur8Jj4v/Zi3FqHmrY5jqY5EUykCsKfSdv0zzN7/UohwR
	MbA+grU9SqInIKitPArM5DE+pfycWCphDC04oLC7c2vnUi9qV4fpCqk+O2s+/cKYhx0XI4ntbpo
	W9baLNDFzKFs2dTM9CfYz/RzpbVBKfHZ2/5tsNyxXKJZScspjQDC344M2qe+MzXU=
X-Received: by 2002:a05:6000:290a:b0:3ee:14db:701a with SMTP id ffacd0b85a97d-3ee7e1063f3mr7948416f8f.16.1758529853066;
        Mon, 22 Sep 2025 01:30:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFIKEf6CNiFSeyuoRMV+Qi16RvMz8aVWLd4utQVYrC2+GOOlUDYYUCvQGJsHP0Q6y2iPCqQnQ==
X-Received: by 2002:a05:6000:290a:b0:3ee:14db:701a with SMTP id ffacd0b85a97d-3ee7e1063f3mr7948396f8f.16.1758529852698;
        Mon, 22 Sep 2025 01:30:52 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f2a:e200:f98f:8d71:83f:f88? (p200300d82f2ae200f98f8d71083f0f88.dip0.t-ipconnect.de. [2003:d8:2f2a:e200:f98f:8d71:83f:f88])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee1227cc37sm17569892f8f.7.2025.09.22.01.30.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Sep 2025 01:30:52 -0700 (PDT)
Message-ID: <aed8db95-8380-456c-9dc8-d36e58b31e4c@redhat.com>
Date: Mon, 22 Sep 2025 10:30:50 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fs/proc: check p->vec_buf for NULL
To: Jakub Acs <acsjakub@amazon.de>, linux-fsdevel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Vlastimil Babka <vbabka@suse.cz>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Jinjiang Tu <tujinjiang@huawei.com>, Suren Baghdasaryan <surenb@google.com>,
 Penglei Jiang <superman.xpt@gmail.com>, Mark Brown <broonie@kernel.org>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Andrei Vagin <avagin@gmail.com>,
 =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
 Stephen Rothwell <sfr@canb.auug.org.au>,
 Muhammad Usama Anjum <usama.anjum@collabora.com>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20250922081713.77303-1-acsjakub@amazon.de>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250922081713.77303-1-acsjakub@amazon.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22.09.25 10:17, Jakub Acs wrote:
> When PAGEMAP_SCAN ioctl invoked with vec_len = 0 reaches
> pagemap_scan_backout_range(), kernel panics with null-ptr-deref:
> 
> [   44.936808] Oops: general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] SMP DEBUG_PAGEALLOC KASAN NOPTI
> [   44.937797] KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
> [   44.938391] CPU: 1 UID: 0 PID: 2480 Comm: reproducer Not tainted 6.17.0-rc6 #22 PREEMPT(none)
> [   44.939062] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
> [   44.939935] RIP: 0010:pagemap_scan_thp_entry.isra.0+0x741/0xa80
> 
> <snip registers, unreliable trace>
> 
> [   44.946828] Call Trace:
> [   44.947030]  <TASK>
> [   44.949219]  pagemap_scan_pmd_entry+0xec/0xfa0
> [   44.952593]  walk_pmd_range.isra.0+0x302/0x910
> [   44.954069]  walk_pud_range.isra.0+0x419/0x790
> [   44.954427]  walk_p4d_range+0x41e/0x620
> [   44.954743]  walk_pgd_range+0x31e/0x630
> [   44.955057]  __walk_page_range+0x160/0x670
> [   44.956883]  walk_page_range_mm+0x408/0x980
> [   44.958677]  walk_page_range+0x66/0x90
> [   44.958984]  do_pagemap_scan+0x28d/0x9c0
> [   44.961833]  do_pagemap_cmd+0x59/0x80
> [   44.962484]  __x64_sys_ioctl+0x18d/0x210
> [   44.962804]  do_syscall_64+0x5b/0x290
> [   44.963111]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> vec_len = 0 in pagemap_scan_init_bounce_buffer() means no buffers are
> allocated and p->vec_buf remains set to NULL.
> 
> This breaks an assumption made later in pagemap_scan_backout_range(),
> that page_region is always allocated for p->vec_buf_index.
> 
> Fix it by explicitly checking p->vec_buf for NULL before dereferencing.
> 
> Other sites that might run into same deref-issue are already (directly
> or transitively) protected by checking p->vec_buf.
> 
> Note:
>  From PAGEMAP_SCAN man page, it seems vec_len = 0 is valid when no output
> is requested and it's only the side effects caller is interested in,
> hence it passes check in pagemap_scan_get_args().
> 
> This issue was found by syzkaller.
> 

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


