Return-Path: <linux-fsdevel+bounces-62374-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB80B8F9DF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Sep 2025 10:44:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 096E87AABE4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Sep 2025 08:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E831F27A446;
	Mon, 22 Sep 2025 08:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RyAMDgh0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC502765F5
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Sep 2025 08:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758530648; cv=none; b=FTo926kMcAGFPncn6MiotXC+Q0y7Cg+SvlAW4TBxN01m2V/8siyW5hcRvJW+tFk2QCrG/GU/jHfsuaQFuJaswaQk8BWT+UksC2kxJ1a/Bn7UbbYzxKFCMc9vKpotHSWsRYPeoTIuTvyfWHTXhypox1hbLthZu11jzJ/8eh5HWwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758530648; c=relaxed/simple;
	bh=JEkA9srvwniqkGMuHIbqQi5XTnYhtmuwTcHw1pP5wdM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iYCJP9ZfIqTDsHhdbpoJPNmC1UO/Vx9sZszAuzZCVCCTgBlS3Op4exspRwbqGRQ3CIBdH/YSEGonEOO4b6TEPmPUgf1L2ljIzuWFuFljFzaIe3A2TLcLmmiLNdnS5L19h/Rey8v58nhQA7MK+2ym5jakTd/Xzg+1Hg5pFb6hsXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RyAMDgh0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758530645;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=fNbblmYwXQAJmAimXaX95p9se1gdhktlvWJfKB3OPuY=;
	b=RyAMDgh0d+fgm+LvR1f+O7sdZLfYQlgHj1Y9UqtCiHsXQKEFYxmz+MGCGOQ7h8Zq+nY+V0
	jIsYH73IQ+KKe7Te3P9SlaREX6InBrmAl/bfIQWEDZkw4slro8WfxZUQHPC8hWOTPJUVJH
	N6KZNwr4TJLemfbTjM3SwuYF+ot9TgY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-511-24pMyqe7M5OawERyZ-5v9g-1; Mon, 22 Sep 2025 04:44:03 -0400
X-MC-Unique: 24pMyqe7M5OawERyZ-5v9g-1
X-Mimecast-MFC-AGG-ID: 24pMyqe7M5OawERyZ-5v9g_1758530642
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3ecdf7b5c46so1518384f8f.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Sep 2025 01:44:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758530642; x=1759135442;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fNbblmYwXQAJmAimXaX95p9se1gdhktlvWJfKB3OPuY=;
        b=dZ7pw0qtCHIJwyJZYzwYfCo+IIDsRg/zFXqO5bv/2ulBnf+RTarEbVqYsSfkocQdLq
         /pfuhFWI580ofr3mPiM1CI2r6e0BJ48qGpgmBLx7h0bQPB7hLWB4INbmiLVNAUtTN4za
         +/qqy71YPT4NeMESZcH8s7XrSTJjoY415t6+K3fODbvLAQ9NV0yC69Nib3iaOa56J8aD
         t6+n4PDwuc/zlOOc05cO9VR1iF3aaE2ds+Q16+SeBiMbwAUTtGJHT5DqRCZ/dqjGbcSp
         iIqc+4ZhJGhZnGcvBHnwz4aFgAHG4MImK2a15omjPYllyubPBAyBOZQ6JGF68yMgYhiw
         zchw==
X-Forwarded-Encrypted: i=1; AJvYcCUFXdMwk051UwgvUkWq4b9fxiP4l/ni5eHoy55ervQ4ev9EN2OoPraFBxSRRFLiOXPkq2bYK82qofRC9BYX@vger.kernel.org
X-Gm-Message-State: AOJu0YzeyJm5HaKcq+bKCp1941dTVSnSree1Ivjnc5tUW7jlRjAZBqNh
	ZBpALlUyPKzyT6Vx77lYbWxWEVzGZ14MG9tKGJpEHMjMc6E1RK/yRgWwVSpwUIEW6XtcCyMkUVQ
	lSrfQOG056JMygW8B6Ehy3khD5OQ8EKTdSAia7ecZ7db4K2fDJaw7ItFkCP5DVIK1otQ=
X-Gm-Gg: ASbGnct5oyVepuDxFXagUNl1E/8zyxu+Dbyd6V8+ROlUH1P6zTVr2aRy9r1k33JXabr
	KDL43SrlF93ZYjkP7n+FfJ+W27/1MSyzFrL0k2J2q6xtKCMFtSDYy9wFt06x9ZT1M0+TidU2Rtl
	H2l4xJdodzMncL6/HODSPvUB2RrszqhMnP72z+4RtqM3q5ETdCoWl0/Ptory+knyO2pyL71ZIs4
	E2eipSzbAXMPgDp8/B9arsWPBeYvJgxQg6WWPiMrPcwmeZbiTGVQzBFt0yCrxIBMT1C3k5sDuYJ
	DbKxUenoPNV0VNa85ulcuD8aX3XeJMZFiYcAh9roRzhkhUPASfUM7Ejpd0VR6ilvsoc0xDmMbQR
	EchnHxy6oxu8vg3yMr0a5g2ITdBOA3KrZBSlLq/IEGNlnEHcLLKDaRJLP42C2v1o=
X-Received: by 2002:a5d:5889:0:b0:3ff:17ac:a34c with SMTP id ffacd0b85a97d-3ff17aca9ddmr1768847f8f.59.1758530642216;
        Mon, 22 Sep 2025 01:44:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYSPgfAQpR87QujIxhC+Anu99wbrmH6Axzt/nVhnSYFZszFCU4AL8USJ6UiN63i2MrsjXhdQ==
X-Received: by 2002:a5d:5889:0:b0:3ff:17ac:a34c with SMTP id ffacd0b85a97d-3ff17aca9ddmr1768815f8f.59.1758530641790;
        Mon, 22 Sep 2025 01:44:01 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f2a:e200:f98f:8d71:83f:f88? (p200300d82f2ae200f98f8d71083f0f88.dip0.t-ipconnect.de. [2003:d8:2f2a:e200:f98f:8d71:83f:f88])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee0fbc7107sm19834232f8f.30.2025.09.22.01.44.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Sep 2025 01:44:01 -0700 (PDT)
Message-ID: <715052fa-2459-4785-87fa-04c8cf30debb@redhat.com>
Date: Mon, 22 Sep 2025 10:43:59 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] fs/proc/task_mmu: check p->vec_buf for NULL
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
References: <20250922082206.6889-1-acsjakub@amazon.de>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250922082206.6889-1-acsjakub@amazon.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22.09.25 10:22, Jakub Acs wrote:
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
> Fixes: 52526ca7fdb9 ("fs/proc/task_mmu: implement IOCTL to get and optionally clear info about PTEs")
> Signed-off-by: Jakub Acs <acsjakub@amazon.de>

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


