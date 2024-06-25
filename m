Return-Path: <linux-fsdevel+bounces-22429-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7452291707F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 20:46:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 091B41F215C8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 18:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F90A17C7D0;
	Tue, 25 Jun 2024 18:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R5+sqn5s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B50417C7B8
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Jun 2024 18:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719341098; cv=none; b=VQQolWaoKrF3wehtPSPngKPKTL9RFICA+6ke+bOhl+tnh78LyK11vT0/8yeGuZaNhsG7rPOumquoErE5CTrEj0TwbN8/NVjdi1yOSc49Cnc8UTVSVN9SybwhqpYGsCufPnFOa/eXBqnaxK2t2JDKmfdKv2WRsslkDrDOt4T/hW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719341098; c=relaxed/simple;
	bh=HXCgRLTaZhs0CuuDEAA1FZlwgspo02JuhnLeqpKgQ8k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DIfKtVqsIG+z2iFZZD+8cZ0Xa7h/zMCfax2NUx6BEP4QjpPnJYb18iy4iFLJ4b5ArwTb9kVMvjGEvRa6kJh5Ah4B3ryR1U1HN/WGvULktiVJIJmVXD/IYIm8lxRG00VlHIIpfO70kJgxQ1X9pA2OfpdW0slK/5Hbbi0nc/0IxNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R5+sqn5s; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719341095;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=QK1faKLibJEiJW14KCJjCzw7/lN5wcXNxBNe5e7d8Ss=;
	b=R5+sqn5sFlmtnhX9CYI1XZabN0jSy6aFVz2WuU2cPIu0MYDj7ZEpwK906EofKQTtwlMuq/
	HqMLKXJJDw+hqjS97Mw1gtA8f8rPnBSht/IfELCA4QP44iWF5Chrh8qsnA6h6eTxj0H6D7
	ZDAfoqEdJ3tnuuu2YYjUueTi8KvTSxo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-113-DbnBNa0wO_6L53SctMQq0A-1; Tue, 25 Jun 2024 14:44:54 -0400
X-MC-Unique: DbnBNa0wO_6L53SctMQq0A-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4217a6a00d8so37771095e9.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Jun 2024 11:44:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719341093; x=1719945893;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QK1faKLibJEiJW14KCJjCzw7/lN5wcXNxBNe5e7d8Ss=;
        b=vpPIs2YgwdrUzpy9LCeOM3KYnxiH+9b37qQ4CrPHExHKjCF1mRotxga7LZgeJfX0p9
         J6xwSEhHxC71dnalfebNa3fnloaECaDUzU74KMaotY9dy8ZLOG2AXGWG8OzY6Wzi6Blr
         DM1EynMwoFdzMLhTvAQZedvHbsCHFS1Ax25C9RCpfrVoRpXvfpqrYC8MzF0AY+J1W/wA
         9mvIAiSD1eXO1HK1/+P2CQ+9MWKZ/AjK0u2zu8MZtfDa5OhuM8H5jeJKiSZPRAzqG+US
         MQehraWO4u6uv9sSrbYqyr4PZmWRnYr5EoxLepyv9QW1CW5LghrH23dBBeTzbNPB1kKb
         OZdg==
X-Gm-Message-State: AOJu0YxNcitrPtMwqBNx/qeM2+qgWyaXIkrkumOS8+nR9p9swuYhjtIv
	/0QTFGcHrJ4uP5PD4uoPOoTbLf3ND/PwCO7XYiM/7XPpZOp7E86fCpYUIuo334Jriem4RLzJwsi
	dC6p1yaEWfLTICfvj+nyahOQB4ka+mGMh7fpqyULRiWP2WW1Ng2R6PSanhr0Q/tc=
X-Received: by 2002:adf:e912:0:b0:365:ebb6:35e4 with SMTP id ffacd0b85a97d-366e4ed3237mr5840100f8f.23.1719341093385;
        Tue, 25 Jun 2024 11:44:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8IbgAiXyWyfFB9aA2SFjDNPPr2ccyVQH3VOdtvxAzDCDfreb/NZK51bDZkXunfoebBpv32g==
X-Received: by 2002:adf:e912:0:b0:365:ebb6:35e4 with SMTP id ffacd0b85a97d-366e4ed3237mr5840087f8f.23.1719341092949;
        Tue, 25 Jun 2024 11:44:52 -0700 (PDT)
Received: from [192.168.1.34] (p548825e3.dip0.t-ipconnect.de. [84.136.37.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36638d9c1aasm13546599f8f.55.2024.06.25.11.44.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jun 2024 11:44:52 -0700 (PDT)
Message-ID: <dc1be69e-4598-4fdf-a46e-3b2756ae27de@redhat.com>
Date: Tue, 25 Jun 2024 20:44:51 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] mm/filemap: Skip to allocate PMD-sized folios if
 needed
To: Gavin Shan <gshan@redhat.com>, linux-mm@kvack.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 djwong@kernel.org, willy@infradead.org, akpm@linux-foundation.org,
 hughd@google.com, torvalds@linux-foundation.org, zhenyzha@redhat.com,
 shan.gavin@gmail.com
References: <20240625090646.1194644-1-gshan@redhat.com>
 <20240625090646.1194644-3-gshan@redhat.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240625090646.1194644-3-gshan@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25.06.24 11:06, Gavin Shan wrote:
> On ARM64, HPAGE_PMD_ORDER is 13 when the base page size is 64KB. The
> PMD-sized page cache can't be supported by xarray as the following
> error messages indicate.
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
> Fix it by skipping to allocate PMD-sized page cache when its size
> is larger than MAX_PAGECACHE_ORDER. For this specific case, we will
> fall to regular path where the readahead window is determined by BDI's
> sysfs file (read_ahead_kb).
> 
> Fixes: 4687fdbb805a ("mm/filemap: Support VM_HUGEPAGE for file mappings")
> Cc: stable@kernel.org # v5.18+
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>   mm/filemap.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 876cc64aadd7..b306861d9d36 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -3124,7 +3124,7 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
>   
>   #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>   	/* Use the readahead code, even if readahead is disabled */
> -	if (vm_flags & VM_HUGEPAGE) {
> +	if ((vm_flags & VM_HUGEPAGE) && HPAGE_PMD_ORDER <= MAX_PAGECACHE_ORDER) {
>   		fpin = maybe_unlock_mmap_for_io(vmf, fpin);
>   		ractl._index &= ~((unsigned long)HPAGE_PMD_NR - 1);
>   		ra->size = HPAGE_PMD_NR;

As discussed, one option is for using min(HPAGE_PMD_ORDER, 
MAX_PAGECACHE_ORDER) here, but it also doesn't quite result in the 
expected performance results on arm64 with 64k.

This code dates back to PMD-THP times, so we'll leave it like that for now.

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


