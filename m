Return-Path: <linux-fsdevel+bounces-59468-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 345D0B395F8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 09:51:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFE407B2D23
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 07:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7913277C95;
	Thu, 28 Aug 2025 07:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cuRlPFjk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8250E13C9C4
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Aug 2025 07:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756367511; cv=none; b=SPG97OJimCNB5YvWC1WFcCVsC4WbvUsZzc8mxYMwl71uTC1EwP5rnzZhX0mE7zY326LXFAVYaTwK9m3VWSrGBGpLoDQGsHxGWIreB/sUHJnDzOhcTPc4ri67Qxi4yWaI1j7FG8BNedoLBRuVjQj8LUseQukjWcKaOelal6qXrWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756367511; c=relaxed/simple;
	bh=aVIw0TcsxiY87h8D5K60j55G2q8/3/CdmpDHg/kInp0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XOs8ALo8aFyqRflBjQseckrZ5NyxUlDODQZKsBLOk5U9MLmVMurBUDozd2Li2Ii4xr4px5c0JfVMKuJSeQ4y1uValM+RdEr13eoE/4yzohWbwqo5vUrvhD8uXRk8R2u2iUbIXN/BpjkhIXiJiwN2eL3ub/OUj7J4Ru9KmD8dBLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cuRlPFjk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756367508;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=W9hxzTxTQo/SdIPcCftN1rfm4EWEI2PYLX2i1EjssCk=;
	b=cuRlPFjk42ml8HAgDhE4c9+UdUtac0HfiKd/vPF4LLMVCp/HP0JRA2uoQXkq0r+c8u/jWT
	1lbuL3Ym6YY3aew6Bg/VPpKiNDO1wvog2alM63H5K02MV7KqoaYFpIGWbxBt/nmj5cIAFU
	tNXMfeQd2sHrK1zUSCWjd+m+SfNHI9Q=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-126-OLq110SwP7C1baMPebgoig-1; Thu, 28 Aug 2025 03:51:47 -0400
X-MC-Unique: OLq110SwP7C1baMPebgoig-1
X-Mimecast-MFC-AGG-ID: OLq110SwP7C1baMPebgoig_1756367506
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3b9dc5c2ba0so265256f8f.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Aug 2025 00:51:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756367506; x=1756972306;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W9hxzTxTQo/SdIPcCftN1rfm4EWEI2PYLX2i1EjssCk=;
        b=PzmCj97OFBs3QMG9m6TEJs5ic4S5LJMLrzwQtaEPiShMrlu/+UP/RriNGhBcv6qx6B
         8/96Z+bPPLuREVmkXXgaIrLQdH2YlShSVeEiW6HwwJY+B2cwqt1sorK444CkdXIfFYn/
         f5mUrsez98ek2zWlaFh6nv76lhKt0+l7tw0VGl9a+ZrrKvYOkJlmy+1KVA92T3allHqr
         kJNO2gPDew+rQFxSo54s92gePMWI1NUn44M+wI0G8ho1F6u4zxbDV1gJWdLmjqtZcCY5
         J9ur/JiZ1ozar4Euu49EgcBGciqAozRnR/EC9hyl2ZFxBvNFj6Bpx4LIwKlIqYuE0CdL
         9hPA==
X-Forwarded-Encrypted: i=1; AJvYcCUOQ4BTJiawzB4lTC4VDSgzAIcARLY4cr4uQoINFeWoZ2USaoKUYZ7MFT0ZvmEhT4YYwtqdtJm3T2H6NWtG@vger.kernel.org
X-Gm-Message-State: AOJu0Yzbz8+QtiaDzU07xEygF6Frjm+aWeAFg+BQlQXZuaLqasZkPoVv
	CK5M3Mm7Zatdz4XWEpnUgJKy/vXoIcYKqwBg2zxdv4iZfckdXaruBS9sSp3Nvc3L697KLtyIadi
	0ZAimHt3VprvnYOAy7SLcN2oH9LCpjT0+r+8QDXfLwbvy5lRffSw+++8qJaxUAtlijNg=
X-Gm-Gg: ASbGncuP0H+qjAbajWyxE1eJgF2a85VhRVfw8t1vmaBnbtd3jHtDITwwl31UeTrrWsT
	ltNbNbUg9Cg919+DD4SZtbKShkraHBtrU6Ef7TjYbcw1U8vUdA6ExU9fSGJmCTZxAbkE3dFgA/x
	YIidB4P27zxJDDdYGdf7ET3GbIooedGBCDlp244eyht8IxPjeg5PYqlmapsD1Nt7I5cBbU0U2h7
	XBEW0DTJD/ZXI4vkkMiyP8bUcRZFQcWKjZDzxrrs7jYdqrRV44gCeywRLNfOhO4hfye/Www1hsH
	+RkKrmYkMjftRKdYKPGA8TtTmQUmIWJQV6LWqgd6DsPF04ZR3rKE273RB89zkNPjfUKF6Vcy7HU
	vLRAbAok1YSKQEl7tIMBqLJ/L9u0eIKRtHTniw390m7DXFafZdzooX8k5KW2eixWfJlE=
X-Received: by 2002:a05:6000:40c8:b0:3ca:5f27:46cb with SMTP id ffacd0b85a97d-3ca5f274a40mr9865728f8f.26.1756367505832;
        Thu, 28 Aug 2025 00:51:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8zgD/30H+XPzw6VmAOLABSxECVvdZkm8lTkssC7aflGskcW313GKDbwONtO4FwEoVzKVXnA==
X-Received: by 2002:a05:6000:40c8:b0:3ca:5f27:46cb with SMTP id ffacd0b85a97d-3ca5f274a40mr9865704f8f.26.1756367505361;
        Thu, 28 Aug 2025 00:51:45 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f28:c100:2225:10aa:f247:7b85? (p200300d82f28c100222510aaf2477b85.dip0.t-ipconnect.de. [2003:d8:2f28:c100:2225:10aa:f247:7b85])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ce24ba1817sm1346778f8f.36.2025.08.28.00.51.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Aug 2025 00:51:44 -0700 (PDT)
Message-ID: <dfeec4c7-b4de-486e-bcb6-8d27384b83bf@redhat.com>
Date: Thu, 28 Aug 2025 09:51:43 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] virtio_fs: fix page fault for DAX page address
To: Haiyue Wang <haiyuewa@163.com>, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, Alistair Popple <apopple@nvidia.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Vivek Goyal <vgoyal@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Miklos Szeredi <miklos@szeredi.hu>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 "open list:VIRTIO FILE SYSTEM" <virtualization@lists.linux.dev>,
 open list <linux-kernel@vger.kernel.org>
References: <20250828061023.877-1-haiyuewa@163.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250828061023.877-1-haiyuewa@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28.08.25 08:10, Haiyue Wang wrote:
> The commit ced17ee32a99 ("Revert "virtio: reject shm region if length is zero"")
> exposes the following DAX page fault bug:
> 
> The commit 21aa65bf82a7 ("mm: remove callers of pfn_t functionality") handles
> the DAX physical page address incorrectly: the removed macro 'phys_to_pfn_t()'
> should be replaced with 'PHYS_PFN()'.
> 
> [    1.390321] BUG: unable to handle page fault for address: ffffd3fb40000008
> [    1.390875] #PF: supervisor read access in kernel mode
> [    1.391257] #PF: error_code(0x0000) - not-present page
> [    1.391509] PGD 0 P4D 0
> [    1.391626] Oops: Oops: 0000 [#1] SMP NOPTI
> [    1.391806] CPU: 6 UID: 1000 PID: 162 Comm: weston Not tainted 6.17.0-rc3-WSL2-STABLE #2 PREEMPT(none)
> [    1.392361] RIP: 0010:dax_to_folio+0x14/0x60
> [    1.392653] Code: 52 c9 c3 00 66 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 44 00 00 48 c1 ef 05 48 c1 e7 06 48 03 3d 34 b5 31 01 <48> 8b 57 08 48 89 f8 f6 c2 01 75 2b 66 90 c3 cc cc cc cc f7 c7 ff
> [    1.393727] RSP: 0000:ffffaf7d04407aa8 EFLAGS: 00010086
> [    1.394003] RAX: 000000a000000000 RBX: ffffaf7d04407bb0 RCX: 0000000000000000
> [    1.394524] RDX: ffffd17b40000008 RSI: 0000000000000083 RDI: ffffd3fb40000000
> [    1.394967] RBP: 0000000000000011 R08: 000000a000000000 R09: 0000000000000000
> [    1.395400] R10: 0000000000001000 R11: ffffaf7d04407c10 R12: 0000000000000000
> [    1.395806] R13: ffffa020557be9c0 R14: 0000014000000001 R15: 0000725970e94000
> [    1.396268] FS:  000072596d6d2ec0(0000) GS:ffffa0222dc59000(0000) knlGS:0000000000000000
> [    1.396715] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    1.397100] CR2: ffffd3fb40000008 CR3: 000000011579c005 CR4: 0000000000372ef0
> [    1.397518] Call Trace:
> [    1.397663]  <TASK>
> [    1.397900]  dax_insert_entry+0x13b/0x390
> [    1.398179]  dax_fault_iter+0x2a5/0x6c0
> [    1.398443]  dax_iomap_pte_fault+0x193/0x3c0
> [    1.398750]  __fuse_dax_fault+0x8b/0x270
> [    1.398997]  ? vm_mmap_pgoff+0x161/0x210
> [    1.399175]  __do_fault+0x30/0x180
> [    1.399360]  do_fault+0xc4/0x550
> [    1.399547]  __handle_mm_fault+0x8e3/0xf50
> [    1.399731]  ? do_syscall_64+0x72/0x1e0
> [    1.399958]  handle_mm_fault+0x192/0x2f0
> [    1.400204]  do_user_addr_fault+0x20e/0x700
> [    1.400418]  exc_page_fault+0x66/0x150
> [    1.400602]  asm_exc_page_fault+0x26/0x30
> [    1.400831] RIP: 0033:0x72596d1bf703
> [    1.401076] Code: 31 f6 45 31 e4 48 8d 15 b3 73 00 00 e8 06 03 00 00 8b 83 68 01 00 00 e9 8e fa ff ff 0f 1f 00 48 8b 44 24 08 4c 89 ee 48 89 df <c7> 00 21 43 34 12 e8 72 09 00 00 e9 6a fa ff ff 0f 1f 44 00 00 e8
> [    1.402172] RSP: 002b:00007ffc350f6dc0 EFLAGS: 00010202
> [    1.402488] RAX: 0000725970e94000 RBX: 00005b7c642c2560 RCX: 0000725970d359a7
> [    1.402898] RDX: 0000000000000003 RSI: 00007ffc350f6dc0 RDI: 00005b7c642c2560
> [    1.403284] RBP: 00007ffc350f6e90 R08: 000000000000000d R09: 0000000000000000
> [    1.403634] R10: 00007ffc350f6dd8 R11: 0000000000000246 R12: 0000000000000001
> [    1.404078] R13: 00007ffc350f6dc0 R14: 0000725970e29ce0 R15: 0000000000000003
> [    1.404450]  </TASK>
> [    1.404570] Modules linked in:
> [    1.404821] CR2: ffffd3fb40000008
> [    1.405029] ---[ end trace 0000000000000000 ]---
> [    1.405323] RIP: 0010:dax_to_folio+0x14/0x60
> [    1.405556] Code: 52 c9 c3 00 66 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 44 00 00 48 c1 ef 05 48 c1 e7 06 48 03 3d 34 b5 31 01 <48> 8b 57 08 48 89 f8 f6 c2 01 75 2b 66 90 c3 cc cc cc cc f7 c7 ff
> [    1.406639] RSP: 0000:ffffaf7d04407aa8 EFLAGS: 00010086
> [    1.406910] RAX: 000000a000000000 RBX: ffffaf7d04407bb0 RCX: 0000000000000000
> [    1.407379] RDX: ffffd17b40000008 RSI: 0000000000000083 RDI: ffffd3fb40000000
> [    1.407800] RBP: 0000000000000011 R08: 000000a000000000 R09: 0000000000000000
> [    1.408246] R10: 0000000000001000 R11: ffffaf7d04407c10 R12: 0000000000000000
> [    1.408666] R13: ffffa020557be9c0 R14: 0000014000000001 R15: 0000725970e94000
> [    1.409170] FS:  000072596d6d2ec0(0000) GS:ffffa0222dc59000(0000) knlGS:0000000000000000
> [    1.409608] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    1.409977] CR2: ffffd3fb40000008 CR3: 000000011579c005 CR4: 0000000000372ef0
> [    1.410437] Kernel panic - not syncing: Fatal exception
> [    1.410857] Kernel Offset: 0xc000000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
> 
> Fixes: 21aa65bf82a7 ("mm: remove callers of pfn_t functionality")
> Signed-off-by: Haiyue Wang <haiyuewa@163.com>
> ---
>   fs/fuse/virtio_fs.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> index c826e7ca49f5..76c8fd0bfc75 100644
> --- a/fs/fuse/virtio_fs.c
> +++ b/fs/fuse/virtio_fs.c
> @@ -1016,7 +1016,7 @@ static long virtio_fs_direct_access(struct dax_device *dax_dev, pgoff_t pgoff,
>   	if (kaddr)
>   		*kaddr = fs->window_kaddr + offset;
>   	if (pfn)
> -		*pfn = fs->window_phys_addr + offset;
> +		*pfn = PHYS_PFN(fs->window_phys_addr + offset);
>   	return nr_pages > max_nr_pages ? max_nr_pages : nr_pages;
>   }
>   

Yeah, looks like that's the only instance we got wrong in that commit.

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


