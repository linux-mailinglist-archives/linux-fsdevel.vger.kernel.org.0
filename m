Return-Path: <linux-fsdevel+bounces-22431-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F26FD917091
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 20:50:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A71EC28A75B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 18:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1330317C211;
	Tue, 25 Jun 2024 18:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FCyS6JPz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE719179206
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Jun 2024 18:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719341415; cv=none; b=qAachKr5TEcfKvWhNtkHDjnBqcKo+YcYX7QAexJhObkV9v8SYAzdDGSEyOMUWN8IZCyyd8LaWor1yMCabmTJ+WlrayLqcKdEUUNadOsvgX4xwJBTGSEQyOy7cT7nCZ02qGv8c/EQWXZNOkopDqKsG8a1A6um8hiUBoEGyUWtAF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719341415; c=relaxed/simple;
	bh=R9fUK/tto7a5gKjfGU+T7PmCRDvOJCmSH1TUOopW+fg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=McdPxJAZ6jWHEmjf6ys0MqH6Nj8ZPZEylgX6zo4N8/EsrNzXKzJWuO8guXlldnHJ4hf7C+2FZgKhXw1aQnXLH0f3j/uI1eb4JMSLSfr91KQ3QmJ/6+iLlx6fQtOquWtUO9ls194WAT/e2H8NI+1dEqKEVL7Elx3KrNxjNybZmQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FCyS6JPz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719341412;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=odVIaSYrxaWpaSKjLzWweUG/JsyIz8UD/vDjoG8NHfs=;
	b=FCyS6JPzZtsX4D8fJEzAS/L1IvxgvqIpMPYSLeJlttuTfrr3cEd0wrHc1NSb4+gQ2TU1uf
	Zp6N4ajFeDhc6IjyAOG46RrBIwPUNYzF7BQg08X1ydVvgy4GQmfOH29tSq6+BR3CSevmzQ
	w4IVyh4+mRlIbOHqacHq73AuB1IOJ88=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-352-0SAIiTtPOJeV-U6B-R51Gw-1; Tue, 25 Jun 2024 14:50:10 -0400
X-MC-Unique: 0SAIiTtPOJeV-U6B-R51Gw-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2ec5100480bso32206301fa.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Jun 2024 11:50:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719341409; x=1719946209;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=odVIaSYrxaWpaSKjLzWweUG/JsyIz8UD/vDjoG8NHfs=;
        b=jTwvsER/bxUGEmjHr1HRWE1hw5y2ilLDENtZmw0V4c7JKQobKSHYdaMZPjJwGZWcpK
         P9azUrqmvzwXXDiZT07YzjF//IpHp+pRX/nvHOMAavwqdwNvwGUq6Fs//WDeCW98gDVO
         VSndGMT09Konrsw4WnvcYbnPjXyjrCqlJgy1RcqQF/Y48VIedKqiAsLefH1DHy9MI2oe
         Bcao7IorTZ8n0UoKuxd8bj0603aeutKMMrmkvTcbcQwvDDxpQ5MgTxNu4SBAiBX1kDI2
         I3AGu6IqYpgzhIQeo5cD7iWYBxfmuleo//z24YscmH3togwiV9LizS6pG7o+zuoKS9OJ
         m4IQ==
X-Gm-Message-State: AOJu0YyWhW3fOcl3sfxQQ4EJy/jvcb78OlTqmNDoKzYCrb5d+KnYZsZj
	z910y/Q7Xs3aqfoqKVXqGZ04dy6V5DdujxPblVcbf/sfnKdE1+vuO2W4ZUJ+YU/njUpCzP7vaFs
	NOyERTHKlhmsqBGuRGFUyuJaPc2mD/EW7JVlzdMEAbP/QDyy3/hb/KyZPPLijCTg=
X-Received: by 2002:a05:6512:688:b0:52c:9d31:3f25 with SMTP id 2adb3069b0e04-52ce185f6edmr5855148e87.43.1719341409296;
        Tue, 25 Jun 2024 11:50:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGY+AXPX5nUhOVeBUY4Ch3TU9HFqtaTpZftm0gRPBqeEs6D4qe0etswXP/nompbKVIwRlychA==
X-Received: by 2002:a05:6512:688:b0:52c:9d31:3f25 with SMTP id 2adb3069b0e04-52ce185f6edmr5855137e87.43.1719341408799;
        Tue, 25 Jun 2024 11:50:08 -0700 (PDT)
Received: from [192.168.1.34] (p548825e3.dip0.t-ipconnect.de. [84.136.37.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4247d0c5492sm224286325e9.24.2024.06.25.11.50.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jun 2024 11:50:08 -0700 (PDT)
Message-ID: <f14a1ff2-6c25-4cf7-abf7-1428e62272b0@redhat.com>
Date: Tue, 25 Jun 2024 20:50:07 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] mm/shmem: Disable PMD-sized page cache if needed
To: Gavin Shan <gshan@redhat.com>, linux-mm@kvack.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 djwong@kernel.org, willy@infradead.org, akpm@linux-foundation.org,
 hughd@google.com, torvalds@linux-foundation.org, zhenyzha@redhat.com,
 shan.gavin@gmail.com, Ryan Roberts <ryan.roberts@arm.com>
References: <20240625090646.1194644-1-gshan@redhat.com>
 <20240625090646.1194644-5-gshan@redhat.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240625090646.1194644-5-gshan@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25.06.24 11:06, Gavin Shan wrote:
> For shmem files, it's possible that PMD-sized page cache can't be
> supported by xarray. For example, 512MB page cache on ARM64 when
> the base page size is 64KB can't be supported by xarray. It leads
> to errors as the following messages indicate when this sort of xarray
> entry is split.
> 
> WARNING: CPU: 34 PID: 7578 at lib/xarray.c:1025 xas_split_alloc+0xf8/0x128
> Modules linked in: binfmt_misc nft_fib_inet nft_fib_ipv4 nft_fib_ipv6   \
> nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject        \
> nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4  \
> ip_set rfkill nf_tables nfnetlink vfat fat virtio_balloon drm fuse xfs  \
> libcrc32c crct10dif_ce ghash_ce sha2_ce sha256_arm64 sha1_ce virtio_net \
> net_failover virtio_console virtio_blk failover dimlib virtio_mmio
> CPU: 34 PID: 7578 Comm: test Kdump: loaded Tainted: G W 6.10.0-rc5-gavin+ #9
> Hardware name: QEMU KVM Virtual Machine, BIOS edk2-20240524-1.el9 05/24/2024
> pstate: 83400005 (Nzcv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
> pc : xas_split_alloc+0xf8/0x128
> lr : split_huge_page_to_list_to_order+0x1c4/0x720
> sp : ffff8000882af5f0
> x29: ffff8000882af5f0 x28: ffff8000882af650 x27: ffff8000882af768
> x26: 0000000000000cc0 x25: 000000000000000d x24: ffff00010625b858
> x23: ffff8000882af650 x22: ffffffdfc0900000 x21: 0000000000000000
> x20: 0000000000000000 x19: ffffffdfc0900000 x18: 0000000000000000
> x17: 0000000000000000 x16: 0000018000000000 x15: 52f8004000000000
> x14: 0000e00000000000 x13: 0000000000002000 x12: 0000000000000020
> x11: 52f8000000000000 x10: 52f8e1c0ffff6000 x9 : ffffbeb9619a681c
> x8 : 0000000000000003 x7 : 0000000000000000 x6 : ffff00010b02ddb0
> x5 : ffffbeb96395e378 x4 : 0000000000000000 x3 : 0000000000000cc0
> x2 : 000000000000000d x1 : 000000000000000c x0 : 0000000000000000
> Call trace:
>   xas_split_alloc+0xf8/0x128
>   split_huge_page_to_list_to_order+0x1c4/0x720
>   truncate_inode_partial_folio+0xdc/0x160
>   shmem_undo_range+0x2bc/0x6a8
>   shmem_fallocate+0x134/0x430
>   vfs_fallocate+0x124/0x2e8
>   ksys_fallocate+0x4c/0xa0
>   __arm64_sys_fallocate+0x24/0x38
>   invoke_syscall.constprop.0+0x7c/0xd8
>   do_el0_svc+0xb4/0xd0
>   el0_svc+0x44/0x1d8
>   el0t_64_sync_handler+0x134/0x150
>   el0t_64_sync+0x17c/0x180
> 
> Fix it by disabling PMD-sized page cache when HPAGE_PMD_ORDER is
> larger than MAX_PAGECACHE_ORDER.
> 
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>   mm/shmem.c | 15 +++++++++++++--
>   1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/shmem.c b/mm/shmem.c
> index a8b181a63402..5453875e3810 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -541,8 +541,9 @@ static bool shmem_confirm_swap(struct address_space *mapping,
>   
>   static int shmem_huge __read_mostly = SHMEM_HUGE_NEVER;
>   
> -bool shmem_is_huge(struct inode *inode, pgoff_t index, bool shmem_huge_force,
> -		   struct mm_struct *mm, unsigned long vm_flags)
> +static bool __shmem_is_huge(struct inode *inode, pgoff_t index,
> +			    bool shmem_huge_force, struct mm_struct *mm,
> +			    unsigned long vm_flags)
>   {
>   	loff_t i_size;
>   
> @@ -573,6 +574,16 @@ bool shmem_is_huge(struct inode *inode, pgoff_t index, bool shmem_huge_force,
>   	}
>   }
>   
> +bool shmem_is_huge(struct inode *inode, pgoff_t index,
> +		   bool shmem_huge_force, struct mm_struct *mm,
> +		   unsigned long vm_flags)
> +{
> +	if (!__shmem_is_huge(inode, index, shmem_huge_force, mm, vm_flags))
> +		return false;
> +
> +	return HPAGE_PMD_ORDER <= MAX_PAGECACHE_ORDER;

Why not check for that upfront?

> +}
> +
>   #if defined(CONFIG_SYSFS)
>   static int shmem_parse_huge(const char *str)
>   {

This should make __thp_vma_allowable_orders() happy for shmem, and consequently, also khugepaged IIRC.

Acked-by: David Hildenbrand <david@redhat.com>


@Ryan,

should we do something like the following on top? The use of PUD_ORDER for ordinary pagecache is
wrong. Really only DAX is special and can support that in its own weird ways.

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 2aa986a5cd1b..ac63233fed6c 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -72,14 +72,25 @@ extern struct kobj_attribute shmem_enabled_attr;
  #define THP_ORDERS_ALL_ANON    ((BIT(PMD_ORDER + 1) - 1) & ~(BIT(0) | BIT(1)))
  
  /*
- * Mask of all large folio orders supported for file THP.
+ * Mask of all large folio orders supported for FSDAX THP.
   */
-#define THP_ORDERS_ALL_FILE    (BIT(PMD_ORDER) | BIT(PUD_ORDER))
+#define THP_ORDERS_ALL_DAX     (BIT(PMD_ORDER) | BIT(PUD_ORDER))
+
+
+/*
+ * Mask of all large folio orders supported for ordinary pagecache (file/shmem)
+ * THP.
+ */
+#if PMD_ORDER <= MAX_PAGECACHE_ORDER
+#define THP_ORDERS_ALL_FILE    0
+#else
+#define THP_ORDERS_ALL_FILE    (BIT(PMD_ORDER))
+#endif
  
  /*
   * Mask of all large folio orders supported for THP.
   */
-#define THP_ORDERS_ALL         (THP_ORDERS_ALL_ANON | THP_ORDERS_ALL_FILE)
+#define THP_ORDERS_ALL         (THP_ORDERS_ALL_ANON | THP_ORDERS_ALL_FILE )
  
  #define TVA_SMAPS              (1 << 0)        /* Will be used for procfs */
  #define TVA_IN_PF              (1 << 1)        /* Page fault handler */
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 89932fd0f62e..95d4a2edae39 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -88,9 +88,15 @@ unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
         bool smaps = tva_flags & TVA_SMAPS;
         bool in_pf = tva_flags & TVA_IN_PF;
         bool enforce_sysfs = tva_flags & TVA_ENFORCE_SYSFS;
+
         /* Check the intersection of requested and supported orders. */
-       orders &= vma_is_anonymous(vma) ?
-                       THP_ORDERS_ALL_ANON : THP_ORDERS_ALL_FILE;
+       if (vma_is_anonymous(vma))
+               orders &= THP_ORDERS_ALL_ANON;
+       else if (vma_is_dax(vma))
+               orders &= THP_ORDERS_ALL_DAX;
+       else
+               orders &= THP_ORDERS_ALL_FILE;
+
         if (!orders)
                 return 0;
  



-- 
Cheers,

David / dhildenb


