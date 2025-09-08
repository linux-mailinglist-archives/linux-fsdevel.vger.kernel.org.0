Return-Path: <linux-fsdevel+bounces-60578-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D05EB49752
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 19:38:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3FECE7AF6BE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 17:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A8DA31576D;
	Mon,  8 Sep 2025 17:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zau4t3QH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7FB3148A2
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Sep 2025 17:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757353030; cv=none; b=eomebGVGboBasv4KXqfB2h05UWS7cUBhl+77RpSJybArleYAPE0ji5lmTCw2OylsqpXhv8LkqoefY+yEvSOM9ZfyqZCFCTe/jglFY/I25Y+0N+/Mm2X8JZjjTJXyW3NBbB5Fk8Nstn/H3L+sFgXyQrDE4GFHdvn3kuVpEB9IYog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757353030; c=relaxed/simple;
	bh=nwOWcisl2sQ8iPTojuZE0ZYmJOKQX1fDwEt2YMCeNM8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hX10+OHMg0P7n3KHfAL8O0wDiHNbTkKwC4gRxKJWumnWu1E05BhI9qB4mBkHAzDgyPFeoGbEnX+9sAe3C0NgxGjbp2VOf4oT1N/7I6q3YoRrVpYQZLbJDk10PWgH0OcwjV+PxzXivDqPTna00DqZGWNBUJZnUcDNbgdDQZU2whk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zau4t3QH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757353027;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ddTrLlBONI++Tc0vmAVCsKGI5mMqVsSsSog7PjuxMWA=;
	b=Zau4t3QHmlxN0roZQuyVIa9/bUdKECliUxrO7u+nDLkQozt+PgIFWSjR+peRsVBvfgLvQM
	r9d5VaTUxPIyK9PkGkusVOAoQctWtQIbhilFDbjuj0hyLi3hOtXL1h0Q0TwAjDn0xUyLyg
	VGxVMUnmZ2qz7tMBNbua7H1gaP5FObQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-574-pe5SEggNOWGqL2xNHSaZIw-1; Mon, 08 Sep 2025 13:37:06 -0400
X-MC-Unique: pe5SEggNOWGqL2xNHSaZIw-1
X-Mimecast-MFC-AGG-ID: pe5SEggNOWGqL2xNHSaZIw_1757353025
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45b467f5173so32832925e9.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 Sep 2025 10:37:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757353025; x=1757957825;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ddTrLlBONI++Tc0vmAVCsKGI5mMqVsSsSog7PjuxMWA=;
        b=V+9Nlk4sExWt0Xsqcv07k7+mCchIQZmmjAu00AWXqpqetYgXEP9b6fzJ+Ry1vAXsEy
         9aqjN1KZD++Fb5DgDivjzaCfM/4gCxw2ftOGFfJbGf/U3WDTGj0C7o47123G9YtOqS+n
         R+oT3SGAk5CxdNLtimtG6bEOI1sNTh2d+CGdYHpV4hX/T+i61HRZb0muQiVpif7i7Rx9
         awvirsqwMRkZKrn+6txQIw6zIQMG5R9XwFyAAvvq90G2I7cfMuhjdiu2Nf4mNmr92RRE
         gOaS0C/zJNrxSIxmUBDu+Mg2WK9EskSf7p73ap8KdtUAUqQUUL4ERs+WAwIZQtiLq3l9
         Ms6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUugjQyE/ciJ0cnowp8eiBu1PQhTWbhuqb/Vjho00ZUFwf4nnSP0SLKMymzOyAJmjW8jdHjvAaAQqSNfM5o@vger.kernel.org
X-Gm-Message-State: AOJu0YwzcbDVcbB45SQB/1/I8OLM0WSKfKQkzJv13gBmygm7KMns3aR1
	Wal9Fy1mhT9atUnRyR/MokyDwmoFlVxFw6/XFqpH+0klI0R/nHg9P8d7DBRjxmIcb/AtfwXwlp8
	MpGjDM2Sw9MWjk6OIl0lzPmp/nxsnJXZ5Oc430kZPdXHXYQGkylQO0I5QgJUmXi3EqHU=
X-Gm-Gg: ASbGncupn6ttgnqCWqop/RYjbHWVHoq+1svGw2VQ4q391EMvLRUcblPRCy5tRuB81n2
	Gn8gJSqn5PYXAE6yfz76ytB5fRMqrGL2cMH70wUHGk0/7tEGNCCfwXku2ZgzMMZzAO07Vd5ba9m
	XOTX76hNEz/SoV1kmQRxcsKs7d8o+0owFpDkxuCCIPZ2FZZeQykwMtgL0LEyN1PXKb/SfakjtyV
	MRgHMiwDFuLgUdbVwMLfKU6t6Qyo3cy56c2GseKLdvx3g1TbkUTkKiAnTzKizY8dzOSfrUtWHo0
	QQt+LADuj+DQB23ARbSz4OS6ws88Oi0yD/d5pz7ae2YVOyAbkdl36tqEKFTtJsq7/bxE3eJYuhY
	7goXK+Wdwa1IWy81duNiT2OR5sSl1DC7Iqbl9wdf/Hi/0kZyDBFAAs48+4UgeFCS9
X-Received: by 2002:a05:600c:4e93:b0:45d:e0d8:a0aa with SMTP id 5b1f17b1804b1-45de0d8a342mr90484905e9.17.1757353024924;
        Mon, 08 Sep 2025 10:37:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFbv9r9FbyFKOKYYRfwPOE7IG/CuXRebsq1QPIBNdBs4sMFncfDfGM1509u6wSlpw7tNCWppg==
X-Received: by 2002:a05:600c:4e93:b0:45d:e0d8:a0aa with SMTP id 5b1f17b1804b1-45de0d8a342mr90484185e9.17.1757353024430;
        Mon, 08 Sep 2025 10:37:04 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f25:700:d846:15f3:6ca0:8029? (p200300d82f250700d84615f36ca08029.dip0.t-ipconnect.de. [2003:d8:2f25:700:d846:15f3:6ca0:8029])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45de16b8b58sm99810995e9.4.2025.09.08.10.37.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 10:37:03 -0700 (PDT)
Message-ID: <7b0f5b81-e18c-4629-a715-b5fee722b4aa@redhat.com>
Date: Mon, 8 Sep 2025 19:36:59 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/16] mm: add vma_desc_size(), vma_desc_pages() helpers
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>,
 Matthew Wilcox <willy@infradead.org>, Guo Ren <guoren@kernel.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, "David S . Miller"
 <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Dan Williams <dan.j.williams@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Nicolas Pitre <nico@fluxnic.net>, Muchun Song <muchun.song@linux.dev>,
 Oscar Salvador <osalvador@suse.de>,
 Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
 Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
 Dave Young <dyoung@redhat.com>, Tony Luck <tony.luck@intel.com>,
 Reinette Chatre <reinette.chatre@intel.com>,
 Dave Martin <Dave.Martin@arm.com>, James Morse <james.morse@arm.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Hugh Dickins <hughd@google.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, Uladzislau Rezki <urezki@gmail.com>,
 Dmitry Vyukov <dvyukov@google.com>, Andrey Konovalov <andreyknvl@gmail.com>,
 Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-csky@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-s390@vger.kernel.org,
 sparclinux@vger.kernel.org, nvdimm@lists.linux.dev,
 linux-cxl@vger.kernel.org, linux-mm@kvack.org, ntfs3@lists.linux.dev,
 kexec@lists.infradead.org, kasan-dev@googlegroups.com
References: <e71b7763-4a62-4709-9969-8579bdcff595@lucifer.local>
 <20250908133224.GE616306@nvidia.com>
 <090675bd-cb18-4148-967b-52cca452e07b@lucifer.local>
 <20250908142011.GK616306@nvidia.com>
 <764d413a-43a3-4be2-99c4-616cd8cd3998@lucifer.local>
 <20250908151637.GM616306@nvidia.com>
 <8edb13fc-e58d-4480-8c94-c321da0f4d8e@redhat.com>
 <20250908153342.GA789684@nvidia.com>
 <365c1ec2-cda6-4d94-895c-b2a795101857@redhat.com>
 <3229ac90-943f-4574-a9b8-bd4f5fa6cf03@redhat.com>
 <20250908155652.GE789684@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250908155652.GE789684@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08.09.25 17:56, Jason Gunthorpe wrote:
> On Mon, Sep 08, 2025 at 05:50:18PM +0200, David Hildenbrand wrote:
> 
>> So in practice there is indeed not a big difference between a private and
>> cow mapping.
> 
> Right and most drivers just check SHARED.
> 
> But if we are being documentative why they check shared is because the
> driver cannot tolerate COW.
> 
> I think if someone is cargo culting a diver and sees
> 'vma_never_cowable' they will have a better understanding of the
> driver side issues.
> 
> Driver's don't actually care about private vs shared, except this
> indirectly implies something about cow.

I recall some corner cases, but yes, most drivers don't clear MAP_MAYWRITE so
is_cow_mapping() would just rule out what they wanted to rule out (no anon
pages / cow semantics).

FWIW, I recalled some VM_MAYWRITE magic in memfd, but it's really just for
!cow mappings, so the following should likely work:

diff --git a/mm/memfd.c b/mm/memfd.c
index 1de610e9f2ea2..2a3aa26444bbb 100644
--- a/mm/memfd.c
+++ b/mm/memfd.c
@@ -346,14 +346,11 @@ static int check_write_seal(vm_flags_t *vm_flags_ptr)
         vm_flags_t vm_flags = *vm_flags_ptr;
         vm_flags_t mask = vm_flags & (VM_SHARED | VM_WRITE);
  
-       /* If a private mapping then writability is irrelevant. */
-       if (!(mask & VM_SHARED))
+       /* If a CoW mapping then writability is irrelevant. */
+       if (is_cow_mapping(vm_flags))
                 return 0;
  
-       /*
-        * New PROT_WRITE and MAP_SHARED mmaps are not allowed when
-        * write seals are active.
-        */
+       /* New PROT_WRITE mappings are not allowed when write-sealed. */
         if (mask & VM_WRITE)
                 return -EPERM;
  


-- 
Cheers

David / dhildenb


