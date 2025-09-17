Return-Path: <linux-fsdevel+bounces-61937-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 055B4B7F9CD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 15:56:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02F0C1C0540E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 13:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07063319611;
	Wed, 17 Sep 2025 13:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E70KMI6a"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D367F316192
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Sep 2025 13:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758116676; cv=none; b=e9RCuzDRsiIiQOY5JNhlK7Z+9A4PGay+ekzL6SKlWMTz4wld1/EalKByNSkgkrCxFFkedg78c8vLM7PDidablv8IN7cc0I2Vwgr7CX8MfBBl8hR2hE/NNS5QE65rv9BBrfH1vTlnRX3+B/TZ4izUoKWFbnIZBu5ZIaMxhkdsJ7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758116676; c=relaxed/simple;
	bh=tVeaLOUcscUXh8ELuJYxqekBt4O2EaJZNoBmTkBToIw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A/05X4t/bggrrYbcZChJH6l/3kRvbtM/WuvujdprwvRGN8p7zJ58QEvCUG0Q1dGusTzqRYZW8GFO/L6wXhmrdfcpF+2FEM3ZJSr67fTJzHV+x34mPRsqNmW2+QUgXH3fwg0GxZS1unb9sRNnU8vhVacuJuLc2mAcWQIP72dKsjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E70KMI6a; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758116672;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=liGb+1uk63kwOPhDFfASvfeBl4VQTUkO45gHzPQGBUU=;
	b=E70KMI6aGKACkzZJaHhoPehvq90JGnqrL64eAKGueYhfDTVe7TaRoHnDhlQ6jJwnEXjsQx
	nMRU9bD94KAeh6+7fjwQ9SdXy8Bun/z4bFCgOYoanG0YsHeh3sOnRQj/T769nEqfyB6uD8
	WxP8IKPr74vjVaP9OQi1ifQmlQB6Y4U=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-373-fAclIQOLONGYU53otrLmQg-1; Wed, 17 Sep 2025 09:44:31 -0400
X-MC-Unique: fAclIQOLONGYU53otrLmQg-1
X-Mimecast-MFC-AGG-ID: fAclIQOLONGYU53otrLmQg_1758116670
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45f29c99f99so25760305e9.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Sep 2025 06:44:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758116670; x=1758721470;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=liGb+1uk63kwOPhDFfASvfeBl4VQTUkO45gHzPQGBUU=;
        b=Fd2fNUfOPBvC6ieZFaUkFesuVfn1WlVYgkfTjY8RtzfKal5gIaVevbYiQHr4+VxyLu
         zq4ZZdREvKoMnsX1+pryV39FuOv3XkSykkLq0oLKP6DbBtpu1f0KVKjSzqtZ1w+MgwLI
         qBhKhNDUPR6uzVjuqCaNI9kMCfyBcVRJGqCrEgXeRtgYmMnC6UdY56dYhRoi8uuY+rbF
         Es97LmlZoU8zAxDp8G8ONBESMQhbiUooOBU+DjSsdxLmSki32T+aXo8nqTx0t+HjC0e+
         TAh8W91LJdkxq1Vq5/lvtp5nFpLam5mt9jkcqcs/gBdC2Hq7LVtUlyQKtONe01N+5TTX
         T2kA==
X-Forwarded-Encrypted: i=1; AJvYcCW9+NwQRUOJXlTQuFGeVQL595L9LXYSIZ1puqd8lkttdhE0n7eAHbCSmYRLS74trH9oCax2neOr03KivrI+@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2/do5Mmwcy8nllKJd01BmNpsMa4TYqE2wwTlcUk685QAEKDHJ
	mRTf4Taorhokzdv4D+8H/smr2ylbMnyLGr0GY3tEli3JlGXJcTQdwQYhSJXeTalS/VQDcmnrS0x
	kauM/Z5uAoJ5vHFnO7UOyTpOor27FZl19Thhe1YEQb5Dm2yFnB0KRzdiI3i4PU0gVhYM=
X-Gm-Gg: ASbGnctrhdEqs/txZ0he6gUzEpslWfxCS8BfpDvuLgi+nPh+sy2xNFa+to95JDLZ0AC
	2yJEXQ/L5oOEwPcN8H5gTwfDKgnme3r2WONBcQQ8BjGk/fp/6uBW08Fjy9x7KXdZmZ/+/yjBtE6
	3f3BFwjKKxctOAwiKnVGO2leBhEycRfBhv9JLREm3Tk9r6p+EAIJnw9GXcusKS3i2pE+6P3v7VJ
	oXxcr8vYb5w5UgXpuny2PwVanie7GBrnx5jeBCRomNx3hRny52KtiQKnVOY0WwQudEC5cadP2ra
	DE3kJyWNZjH1ws4kjKiOdpJpOjPcNzU2PhbYxtlEg1vOGKDuImFhf/daYLFnAspaBHzZpuNHmbg
	x6ZSLTpVayVT4PfJKDE9kb3PvTOoXciunArdWsMOf90Ez2Z56rP4lKo+TKfpAtzBV
X-Received: by 2002:a05:600c:4ec8:b0:45f:2843:e76d with SMTP id 5b1f17b1804b1-46201f8a9f5mr21886535e9.4.1758116670376;
        Wed, 17 Sep 2025 06:44:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFw1RIyEIK4TW5AJcprHmluKxUYcV6LPPbUme37h+GXCQZ40f8U9IBbOvKE8vFxsWYa4at8pA==
X-Received: by 2002:a05:600c:4ec8:b0:45f:2843:e76d with SMTP id 5b1f17b1804b1-46201f8a9f5mr21885945e9.4.1758116669885;
        Wed, 17 Sep 2025 06:44:29 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f27:6d00:7b96:afc9:83d0:5bd? (p200300d82f276d007b96afc983d005bd.dip0.t-ipconnect.de. [2003:d8:2f27:6d00:7b96:afc9:83d0:5bd])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46139122cb5sm36693815e9.8.2025.09.17.06.44.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 06:44:29 -0700 (PDT)
Message-ID: <eb7820ed-3351-4cb5-8341-d6a48ed7746f@redhat.com>
Date: Wed, 17 Sep 2025 15:44:27 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/7] mm: add assertion for VMA count limit
To: Kalesh Singh <kaleshsingh@google.com>, akpm@linux-foundation.org,
 minchan@kernel.org, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
 rppt@kernel.org, pfalcato@suse.de
Cc: kernel-team@android.com, android-mm@google.com,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Kees Cook <kees@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall
 <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
 Valentin Schneider <vschneid@redhat.com>, Jann Horn <jannh@google.com>,
 Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20250915163838.631445-1-kaleshsingh@google.com>
 <20250915163838.631445-7-kaleshsingh@google.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250915163838.631445-7-kaleshsingh@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15.09.25 18:36, Kalesh Singh wrote:
> Building on the vma_count helpers, add a VM_WARN_ON_ONCE() to detect
> cases where the VMA count exceeds the sysctl_max_map_count limit.
> 
> This check will help catch future bugs or regressions where
> the VMAs are allocated exceeding the limit.
> 
> The warning is placed in the main vma_count_*() helpers, while the
> internal *_nocheck variants bypass it. _nocheck helpers are used to
> ensure that the assertion does not trigger a false positive in
> the legitimate case of a temporary VMA increase past the limit
> by a VMA split in munmap().
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Pedro Falcato <pfalcato@suse.de>
> Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> ---
> 
> Changes in v2:
>    - Add assertions if exceeding max_vma_count limit, per Pedro
> 
>   include/linux/mm.h               | 12 ++++++--
>   mm/internal.h                    |  1 -
>   mm/vma.c                         | 49 +++++++++++++++++++++++++-------
>   tools/testing/vma/vma_internal.h |  7 ++++-
>   4 files changed, 55 insertions(+), 14 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 8bad1454984c..3a3749d7015c 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -4219,19 +4219,27 @@ static inline bool snapshot_page_is_faithful(const struct page_snapshot *ps)
>   
>   void snapshot_page(struct page_snapshot *ps, const struct page *page);
>   
> +int vma_count_remaining(const struct mm_struct *mm);
> +
>   static inline void vma_count_init(struct mm_struct *mm)
>   {
>   	ACCESS_PRIVATE(mm, __vma_count) = 0;
>   }
>   
> -static inline void vma_count_add(struct mm_struct *mm, int nr_vmas)
> +static inline void __vma_count_add_nocheck(struct mm_struct *mm, int nr_vmas)
>   {
>   	ACCESS_PRIVATE(mm, __vma_count) += nr_vmas;
>   }
>   
> +static inline void vma_count_add(struct mm_struct *mm, int nr_vmas)
> +{
> +	VM_WARN_ON_ONCE(!vma_count_remaining(mm));

Can't that fire when changing the max count from user space at just the 
wrong time?

I assume we'll have to tolerated that and might just want to drop this 
patch from the series.

-- 
Cheers

David / dhildenb


