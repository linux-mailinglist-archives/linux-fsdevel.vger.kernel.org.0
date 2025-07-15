Return-Path: <linux-fsdevel+bounces-54990-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D40EAB0621E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 16:58:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17FAC4E1575
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 14:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E03EE1FFC7B;
	Tue, 15 Jul 2025 14:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bkkG3N+h"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797431F0E3E
	for <linux-fsdevel@vger.kernel.org>; Tue, 15 Jul 2025 14:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752591211; cv=none; b=rY49s6rvNfriXyJhWNYw4it7yHh0jfZTfUIeVaKW0z0LHl51pJkemKkID/Y3s+WRDIR9wx4tS/CLDSsdrHMb1vJyWiJEHr7aMkjtsuLJFV87gAQb4K3B8yvhrTHZYZEr0eBLSeZf2z3zXe4YOf4zDNxHp/HMItuIe/LIgqX3vOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752591211; c=relaxed/simple;
	bh=Acuz1EpnmekyfO4/xEK1an8GiCH7K4OcabcTCqnfOPs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=RYCXkXxp8G62MjriYWzGsWjk+RXdUE+FA2eA2IClEiXPC/2HmoU5URpkgVKSTzwLQvv2YjYMnTJ1zOIDpwcxY7Tj0dfqQu/9z855nAnpi4C8BmWOtgP312uFblDq9GPBtdkvpfP236SisH2SsGUKK0voZ2TfkhSVcWcEmiD7V/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bkkG3N+h; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752591208;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yG7W7QXKxv1nGJlD8ktB4MquSjEIuQB5dAsyzH+sdtE=;
	b=bkkG3N+hKj4HnDrZSggAfgA+5PVEHWb5nLIARxawLrk4CgzJyDd3SyHCBfy01oNhpvdzTU
	wUXBO+/K78Qjamb9+m3Yu1QtUvNdnoMbpG3dseIAfHNHGloWpDilXjgE3K3wZLG/yrskaZ
	boBLikRGAX+V8jUUiw1swGk81sKWYl8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-451-yhApN2KxPVOUfGFUHBGxjg-1; Tue, 15 Jul 2025 10:53:27 -0400
X-MC-Unique: yhApN2KxPVOUfGFUHBGxjg-1
X-Mimecast-MFC-AGG-ID: yhApN2KxPVOUfGFUHBGxjg_1752591206
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a4f7f1b932so3331486f8f.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Jul 2025 07:53:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752591206; x=1753196006;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yG7W7QXKxv1nGJlD8ktB4MquSjEIuQB5dAsyzH+sdtE=;
        b=SZ5DMHEzt4W5NXNHdW640dqd2AyhZKaFlx2AKZrE49dP96PeWnJ8Qxu0rN9HKZotQ5
         0wj3i95S3tIGeW2XWjaVtA1LWQTGe6KOcXX6gWJQcI3f+3+jJ+HVu640hHjoy0OdvMAj
         omu6jdO+tWQLH5CnhMtBkh4P1cxCMPUfdEk0GO0fx5yrN/e1dq/BFAIDnFJf69rr1Mcg
         WYOixCCgtNvHHtIy5X82XM9VoGorS/itWKVrZRDetecuhO8FOSxw2FNBxJbejk1ld68V
         yJyAWFsszT9zTM5Bv4mjG0U6bl97uSFNRTuaJc6AUp8fP46H7iv52J1bBpA8MZaIG8e+
         GlTg==
X-Forwarded-Encrypted: i=1; AJvYcCV/rynsfj7kAqQkk588S81ZQ9AJWEbBDoF9RM/5sByzY4KbHDCRmYXKS/sFVG5IoXR/l5knWiRFMsYZF9WF@vger.kernel.org
X-Gm-Message-State: AOJu0Yxy+tcCcdyqiQ2iQHIcLuhOHwY7kv2k7iBtdgOTDI2FRrdhDuZY
	+8vThg1oSaRh/sz/GPn6uLGmZgP8166hOws9lVgxByWDCV3WlcLFbk+7njrjuHdifz60YN4gp5Y
	SFnOboe+iCaB38RLu0kHkMH1bb16PURFAvlgDT+QTZOxDKT19CM9yA3x3Ys93iMCSFZA=
X-Gm-Gg: ASbGncuLDJotOKRb0Pf4FzSMcm4H2caWwjn5rZjmXFW1bNOZ5FqDpqq2zYQIemLxY2e
	nKsQZJLTfV9+WbvKx8DxTbvyfSEHZQOQKD+cFr2cixcOM/Ue0xDJ33Cw5307qZrupACUY9SkYlk
	Wa+BwvIciLSdSZzkGXu2scd9mA96G9IIOw8ElKZaqIdA3ZGzD3SJzDl/nhPf5bYFlnk44RKwKDD
	ZVf/W5C6S0kv8OQpfPJLQOQqpnnCjRYybVskQFzdIhrp0oeDvJ80aCKQOVBcUoyEbs9qkWJtXNd
	Clg0olhcReE2hyac/SZDHW2Bo14HuFgB1s11Df/EQ9MnSHT2ttjrnITVKZ21ldgKybT9nAI8CSz
	CO0ptvin7F6JA7vJ0hkmKYjMLqLlkd7jrSjNGQJHdMnE4QYm+zr3ISoagpKRd7OGTa2A=
X-Received: by 2002:a05:6000:1882:b0:3a3:6595:9209 with SMTP id ffacd0b85a97d-3b5f2dfdfdfmr14440933f8f.36.1752591205636;
        Tue, 15 Jul 2025 07:53:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHABYfEu0aA45rJWgW7Ehq+BxklHF1kyk/Dk0aXHgWXMrgHnaeRAV1JwoCX+I/OL/h/FHyMvw==
X-Received: by 2002:a05:6000:1882:b0:3a3:6595:9209 with SMTP id ffacd0b85a97d-3b5f2dfdfdfmr14440880f8f.36.1752591205054;
        Tue, 15 Jul 2025 07:53:25 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f28:4900:2c24:4e20:1f21:9fbd? (p200300d82f2849002c244e201f219fbd.dip0.t-ipconnect.de. [2003:d8:2f28:4900:2c24:4e20:1f21:9fbd])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454d5053725sm206624595e9.16.2025.07.15.07.53.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 07:53:24 -0700 (PDT)
Message-ID: <fbcb6038-43a9-4d47-8cf7-f5ca32824079@redhat.com>
Date: Tue, 15 Jul 2025 16:53:23 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] mm: add static PMD zero page
From: David Hildenbrand <david@redhat.com>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,
 Suren Baghdasaryan <surenb@google.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Borislav Petkov <bp@alien8.de>,
 Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>,
 Vlastimil Babka <vbabka@suse.cz>, Zi Yan <ziy@nvidia.com>,
 Mike Rapoport <rppt@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>,
 Michal Hocko <mhocko@suse.com>, Lorenzo Stoakes
 <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>,
 Thomas Gleixner <tglx@linutronix.de>, Nico Pache <npache@redhat.com>,
 Dev Jain <dev.jain@arm.com>, "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Jens Axboe <axboe@kernel.dk>
Cc: linux-kernel@vger.kernel.org, willy@infradead.org, linux-mm@kvack.org,
 x86@kernel.org, linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 "Darrick J . Wong" <djwong@kernel.org>, mcgrof@kernel.org,
 gost.dev@samsung.com, hch@lst.de, Pankaj Raghav <p.raghav@samsung.com>
References: <20250707142319.319642-1-kernel@pankajraghav.com>
 <20250707142319.319642-4-kernel@pankajraghav.com>
 <26fded53-b79d-4538-bc56-3d2055eb5d62@redhat.com>
Content-Language: en-US
Organization: Red Hat
In-Reply-To: <26fded53-b79d-4538-bc56-3d2055eb5d62@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15.07.25 16:21, David Hildenbrand wrote:
> On 07.07.25 16:23, Pankaj Raghav (Samsung) wrote:
>> From: Pankaj Raghav <p.raghav@samsung.com>
>>
>> There are many places in the kernel where we need to zeroout larger
>> chunks but the maximum segment we can zeroout at a time by ZERO_PAGE
>> is limited by PAGE_SIZE.
>>
>> This is especially annoying in block devices and filesystems where we
>> attach multiple ZERO_PAGEs to the bio in different bvecs. With multipage
>> bvec support in block layer, it is much more efficient to send out
>> larger zero pages as a part of single bvec.
>>
>> This concern was raised during the review of adding LBS support to
>> XFS[1][2].
>>
>> Usually huge_zero_folio is allocated on demand, and it will be
>> deallocated by the shrinker if there are no users of it left. At moment,
>> huge_zero_folio infrastructure refcount is tied to the process lifetime
>> that created it. This might not work for bio layer as the completitions
>> can be async and the process that created the huge_zero_folio might no
>> longer be alive.
> 
> Of course, what we could do is indicating that there is any untracked
> reference to the huge zero folio, and then simply refuse to free it for
> all eternity.
> 
> Essentially, every any non-mm reference -> un-shrinkable.
> 
> We'd still be allocating the huge zero folio dynamically. We could try
> allocating it on first usage either from memblock, or from the buddy if
> already around.
> 
> Then, we'd only need a config option to allow for that to happen.

Something incomplete and very hacky just to give an idea. It would try allocating
it if there is actual code running that would need it, and then have it
stick around forever.


diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index e0a27f80f390d..357e29e98d8d2 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -481,6 +481,7 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf);
  
  extern struct folio *huge_zero_folio;
  extern unsigned long huge_zero_pfn;
+atomic_t huge_zero_folio_is_static;
  
  static inline bool is_huge_zero_folio(const struct folio *folio)
  {
@@ -499,6 +500,16 @@ static inline bool is_huge_zero_pmd(pmd_t pmd)
  
  struct folio *mm_get_huge_zero_folio(struct mm_struct *mm);
  void mm_put_huge_zero_folio(struct mm_struct *mm);
+struct folio *__get_static_huge_zero_folio(void);
+
+static inline struct folio *get_static_huge_zero_folio(void)
+{
+       if (!IS_ENMABLED(CONFIG_STATIC_HUGE_ZERO_FOLIO))
+               return NULL;
+       if (likely(atomic_read(&huge_zero_folio_is_static)))
+               return huge_zero_folio;
+       return get_static_huge_zero_folio();
+}
  
  static inline bool thp_migration_supported(void)
  {
@@ -509,7 +520,6 @@ void split_huge_pmd_locked(struct vm_area_struct *vma, unsigned long address,
                            pmd_t *pmd, bool freeze);
  bool unmap_huge_pmd_locked(struct vm_area_struct *vma, unsigned long addr,
                            pmd_t *pmdp, struct folio *folio);
-
  #else /* CONFIG_TRANSPARENT_HUGEPAGE */
  
  static inline bool folio_test_pmd_mappable(struct folio *folio)
@@ -690,6 +700,11 @@ static inline int change_huge_pud(struct mmu_gather *tlb,
  {
         return 0;
  }
+
+static inline struct folio *static_huge_zero_folio(void)
+{
+       return NULL;
+}
  #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
  
  static inline int split_folio_to_list_to_order(struct folio *folio,
@@ -703,4 +718,14 @@ static inline int split_folio_to_order(struct folio *folio, int new_order)
         return split_folio_to_list_to_order(folio, NULL, new_order);
  }
  
+static inline struct folio *largest_zero_folio(void)
+{
+       struct folio *folio;
+
+       folio = get_static_huge_zero_folio();
+       if (folio)
+               return folio;
+       return page_folio(ZERO_PAGE(0));
+}
+
  #endif /* _LINUX_HUGE_MM_H */
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 31b5c4e61a574..eb49c69f9c8e2 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -77,6 +77,7 @@ static bool split_underused_thp = true;
  static atomic_t huge_zero_refcount;
  struct folio *huge_zero_folio __read_mostly;
  unsigned long huge_zero_pfn __read_mostly = ~0UL;
+atomic_t huge_zero_folio_is_static __read_mostly;
  unsigned long huge_anon_orders_always __read_mostly;
  unsigned long huge_anon_orders_madvise __read_mostly;
  unsigned long huge_anon_orders_inherit __read_mostly;
@@ -266,6 +267,25 @@ void mm_put_huge_zero_folio(struct mm_struct *mm)
                 put_huge_zero_page();
  }
  
+#ifdef CONFIG_STATIC_HUGE_ZERO_FOLIO
+struct folio *__get_static_huge_zero_folio(void)
+{
+       /*
+        * Our raised reference will prevent the shrinker from ever having
+        * success -> static.
+        */
+       if (atomic_read(&huge_zero_folio_is_static))
+               return huge_zero_folio;
+       /* TODO: memblock allocation if buddy is not up yet? Or Reject that earlier. */
+       if (!get_huge_zero_page())
+               return NULL;
+       if (atomic_cmpxchg(&huge_zero_folio_is_static, 0, 1) != 0)
+               put_huge_zero_page();
+       return huge_zero_folio;
+
+}
+#endif /* CONFIG_STATIC_HUGE_ZERO_FOLIO */
+
  static unsigned long shrink_huge_zero_page_count(struct shrinker *shrink,
                                         struct shrink_control *sc)
  {


-- 
Cheers,

David / dhildenb


