Return-Path: <linux-fsdevel+bounces-22428-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45893917072
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 20:45:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8EFD28CAC4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 18:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F056717C7DC;
	Tue, 25 Jun 2024 18:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QZkezehZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFFC7177991
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Jun 2024 18:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719340999; cv=none; b=X9BbOVv8MK7jKWv7HjeIWvzRR38mgUAmu1imxC3+xjYrSSm4PfiMhliLVR4nlCG1UoFpjaNsjHL3P0vogL9taZj3I4s898hQdDPqhnt+9OwrjwYMRxyIr71hGF1qBqbcYPkor2Yw8Xkmht2tz7kL5Ic/N8ZbntvwYc+4oid3mao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719340999; c=relaxed/simple;
	bh=4T8zplSVDGP/25a2/9dQBVYyzCn7VHheFPmanqVzF7s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qvTBvTu3Mmd4Iu8UDPkreL8zTN8smGH44B5sDJZea9Monxcs+8bScF8BM1wUR5n42m3fJ7XPPF3aJsBJ365XgUnwV2AL3sJkVtHG02yC0uuntFW14ZxUbi1k6iCVYltzTS8XC49KsAbSjjWBhV5wfJnLS83f0poID35KAR8G7C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QZkezehZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719340996;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=BKlZK3pNZ+wzGcnEvjLqIaoCKeBTm9H3YzmiNb6G+3g=;
	b=QZkezehZIcsehrtpIwgS1Ie8r+mu16aaYrj/p0MSotmP4PoBTbgGPIVp0O5W/cio7cjS03
	/7inDkKQWBTBDZ9ri6He4O+R0W5gNm/HoXFb62TeU7H7IXsDTdUJt2o+lC2TCeVJ6EIIcz
	0SH5GIO4Dc1D6MJBCMyIGikg+7nWM+Y=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-3cC4ZrboO-Ods_ipSI-HPQ-1; Tue, 25 Jun 2024 14:43:14 -0400
X-MC-Unique: 3cC4ZrboO-Ods_ipSI-HPQ-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3644be85453so3155981f8f.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Jun 2024 11:43:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719340993; x=1719945793;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BKlZK3pNZ+wzGcnEvjLqIaoCKeBTm9H3YzmiNb6G+3g=;
        b=a4vy8FYi+1YEu7lVOQ+vHIEpb8meUAowIiNsDB6fbw1kaiDAhDURfKr2i0QZpn403p
         0GgKuEs9FlWk+jbieeUC9DLWIZveDGTz9fuGJMpl0qM5f20eNxdjBXYw2d7aObhuigZo
         LXWteO6Oqnv24PYKebv5pjv8e0Pt78szzWYPJ8nqy04IjKqlbKxmCb+9EfOPTX9pWej+
         viJcMCeAXdJiLZ3r+9f6dWKsbI58L1KgPP/57VHeIH7lrt7crLiHeIAdyHnFGQwqLz+e
         RqODxOg1CVKpEBkEWLN7vLed1G/lYlXpDKpOF1HQ7tftyLSmOMk8HAyTu8vRZGo0nDXN
         Bh/Q==
X-Gm-Message-State: AOJu0YwzLxhaSX8Y8VFr7JxDnZJb6g3deGvoJu8pIv34iq71ot/e00ck
	KoLZ2WEhPTy9bilOSVwqr3Vq9s5871awN4G0C/EvldI2y/dV9VBTUza33ygUYULvWGLrgoD1jyZ
	GzSRftE3Ayc5kpqKMtzjWnmw7GmvgJXKDynTlVBOQ6ZIoBB+EGOfON550P5RXcC0=
X-Received: by 2002:a05:6000:184d:b0:366:ebc4:2574 with SMTP id ffacd0b85a97d-366ebc425fdmr6053845f8f.33.1719340993701;
        Tue, 25 Jun 2024 11:43:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE40JIDmew9s1ZPwIzg7JyzT8Oeg/+C7vF7SC0rIHkvt7fva8hqcnM0roa+VTY43CmqAbnaTA==
X-Received: by 2002:a05:6000:184d:b0:366:ebc4:2574 with SMTP id ffacd0b85a97d-366ebc425fdmr6053826f8f.33.1719340993195;
        Tue, 25 Jun 2024 11:43:13 -0700 (PDT)
Received: from [192.168.1.34] (p548825e3.dip0.t-ipconnect.de. [84.136.37.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3663ada00e7sm13679617f8f.112.2024.06.25.11.43.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jun 2024 11:43:12 -0700 (PDT)
Message-ID: <ca1d734c-e755-4730-bcaa-a439a9635c38@redhat.com>
Date: Tue, 25 Jun 2024 20:43:11 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] mm/filemap: Make MAX_PAGECACHE_ORDER acceptable to
 xarray
To: Gavin Shan <gshan@redhat.com>, linux-mm@kvack.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 djwong@kernel.org, willy@infradead.org, akpm@linux-foundation.org,
 hughd@google.com, torvalds@linux-foundation.org, zhenyzha@redhat.com,
 shan.gavin@gmail.com
References: <20240625090646.1194644-1-gshan@redhat.com>
 <20240625090646.1194644-2-gshan@redhat.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240625090646.1194644-2-gshan@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25.06.24 11:06, Gavin Shan wrote:
> The largest page cache order can be HPAGE_PMD_ORDER (13) on ARM64
> with 64KB base page size. The xarray entry with this order can't
> be split as the following error messages indicate.
> 
> ------------[ cut here ]------------
> WARNING: CPU: 35 PID: 7484 at lib/xarray.c:1025 xas_split_alloc+0xf8/0x128
> Modules linked in: nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib  \
> nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct    \
> nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4    \
> ip_set rfkill nf_tables nfnetlink vfat fat virtio_balloon drm      \
> fuse xfs libcrc32c crct10dif_ce ghash_ce sha2_ce sha256_arm64      \
> sha1_ce virtio_net net_failover virtio_console virtio_blk failover \
> dimlib virtio_mmio
> CPU: 35 PID: 7484 Comm: test Kdump: loaded Tainted: G W 6.10.0-rc5-gavin+ #9
> Hardware name: QEMU KVM Virtual Machine, BIOS edk2-20240524-1.el9 05/24/2024
> pstate: 83400005 (Nzcv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
> pc : xas_split_alloc+0xf8/0x128
> lr : split_huge_page_to_list_to_order+0x1c4/0x720
> sp : ffff800087a4f6c0
> x29: ffff800087a4f6c0 x28: ffff800087a4f720 x27: 000000001fffffff
> x26: 0000000000000c40 x25: 000000000000000d x24: ffff00010625b858
> x23: ffff800087a4f720 x22: ffffffdfc0780000 x21: 0000000000000000
> x20: 0000000000000000 x19: ffffffdfc0780000 x18: 000000001ff40000
> x17: 00000000ffffffff x16: 0000018000000000 x15: 51ec004000000000
> x14: 0000e00000000000 x13: 0000000000002000 x12: 0000000000000020
> x11: 51ec000000000000 x10: 51ece1c0ffff8000 x9 : ffffbeb961a44d28
> x8 : 0000000000000003 x7 : ffffffdfc0456420 x6 : ffff0000e1aa6eb8
> x5 : 20bf08b4fe778fca x4 : ffffffdfc0456420 x3 : 0000000000000c40
> x2 : 000000000000000d x1 : 000000000000000c x0 : 0000000000000000
> Call trace:
>   xas_split_alloc+0xf8/0x128
>   split_huge_page_to_list_to_order+0x1c4/0x720
>   truncate_inode_partial_folio+0xdc/0x160
>   truncate_inode_pages_range+0x1b4/0x4a8
>   truncate_pagecache_range+0x84/0xa0
>   xfs_flush_unmap_range+0x70/0x90 [xfs]
>   xfs_file_fallocate+0xfc/0x4d8 [xfs]
>   vfs_fallocate+0x124/0x2e8
>   ksys_fallocate+0x4c/0xa0
>   __arm64_sys_fallocate+0x24/0x38
>   invoke_syscall.constprop.0+0x7c/0xd8
>   do_el0_svc+0xb4/0xd0
>   el0_svc+0x44/0x1d8
>   el0t_64_sync_handler+0x134/0x150
>   el0t_64_sync+0x17c/0x180
> 
> Fix it by decreasing MAX_PAGECACHE_ORDER to the largest supported order
> by xarray. For this specific case, MAX_PAGECACHE_ORDER is dropped from
> 13 to 11 when CONFIG_BASE_SMALL is disabled.
> 
> Fixes: 4f6617011910 ("filemap: Allow __filemap_get_folio to allocate large folios")
> Cc: stable@kernel.org # v6.6+
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>   include/linux/pagemap.h | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index 59f1df0cde5a..a0a026d2d244 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -354,11 +354,18 @@ static inline void mapping_set_gfp_mask(struct address_space *m, gfp_t mask)
>    * a good order (that's 1MB if you're using 4kB pages)
>    */
>   #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> -#define MAX_PAGECACHE_ORDER	HPAGE_PMD_ORDER
> +#define PREFERRED_MAX_PAGECACHE_ORDER	HPAGE_PMD_ORDER
>   #else
> -#define MAX_PAGECACHE_ORDER	8
> +#define PREFERRED_MAX_PAGECACHE_ORDER	8
>   #endif
>   
> +/*
> + * xas_split_alloc() does not support arbitrary orders. This implies no
> + * 512MB THP on ARM64 with 64KB base page size.
> + */
> +#define MAX_XAS_ORDER		(XA_CHUNK_SHIFT * 2 - 1)
> +#define MAX_PAGECACHE_ORDER	min(MAX_XAS_ORDER, PREFERRED_MAX_PAGECACHE_ORDER)
> +
>   /**
>    * mapping_set_large_folios() - Indicate the file supports large folios.
>    * @mapping: The file.

Thanks!

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


