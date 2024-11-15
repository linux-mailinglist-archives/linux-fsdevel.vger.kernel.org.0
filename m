Return-Path: <linux-fsdevel+bounces-34886-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E2319CDC02
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 10:59:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B1A2B24BDE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 09:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28A0519D07C;
	Fri, 15 Nov 2024 09:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AEVVcjTS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099A718FC75
	for <linux-fsdevel@vger.kernel.org>; Fri, 15 Nov 2024 09:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731664761; cv=none; b=iM+DADBME2Ck87y6ju92BVKjGR2ZZnh/9dlcZyPHou6qOp52z1WwH/VWNtSfXq/iE0S+vN6dET329DK3mk4DKOfRq0mhVTbpp0uXtPAc9nDWpvb2MN0Ch6jZ9X6yE2y+GAp6n/bHDrC3mZjEnW/rHF2VZnpgxZ/JJZqzOy9Y/9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731664761; c=relaxed/simple;
	bh=iQK/5QE3w72R3EU4HwogXWvFn0p6ckid7D7ubAggQ3M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kX0RQv5znWnuUPWF10cJ5cffTv+omlqSMn2GI2FjCqf8X1oKlm48LSntT/6fI4utW9IC0gA6fZRaWAELl2SQq1ApmxL6SgDZ9oOqAQc8NufBxxnD3XaUbKzm6aHDOSB0HqnZOSRJsQVM6wf1UkD/AOudZaiLMCIlRsLFvozxAjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AEVVcjTS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731664758;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=X8E6eVxLWOK+GWUhh6BU4TxxW/inMa7I4h3tnqFTYNo=;
	b=AEVVcjTS4qjsDh/7zFnSveM6mhJPd14qw+It1kmKOVyZy8wTKhK1ZzfSFzVkqKRmtsGHMg
	T/KS59gvQQl5pNQeLyjZCQKkEKU0WQiGhJbiuP5CAirbA5BY05c327Tk025QUn0SjKT5Ad
	ANuj/iWtaUAXtdmo51ngmla0ge6XyFc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-245-OhRL6Gb1P3KmvsDRfiiMSQ-1; Fri, 15 Nov 2024 04:59:16 -0500
X-MC-Unique: OhRL6Gb1P3KmvsDRfiiMSQ-1
X-Mimecast-MFC-AGG-ID: OhRL6Gb1P3KmvsDRfiiMSQ
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-381e8cf69a6so972473f8f.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Nov 2024 01:59:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731664755; x=1732269555;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=X8E6eVxLWOK+GWUhh6BU4TxxW/inMa7I4h3tnqFTYNo=;
        b=TRrSldfvMWs2CT4edqebW5Du5sOycZM64dmFxldARO1MjML/2AwtlYSU+oEyfQny3E
         qlBcOanni16JwY1BgdpuXfwlqtBrRfWNE/hvdTHHJtvxDXu6cQrStosmlo7qkOiRArM5
         vcl+sAWdZ8G+sbDxNiW9PX3XUQRJi8K9HlqmzhEq0Ut8IdgWQjMRhKRdbq5Gq1AcLe06
         7in5qx3yg9d+xIYdk+IhLNrpX4TT9i8WEqw7iX5sCiLdOChh2Y98mimdNWmt4smr9imO
         AuLqCjnXu55VNMRg/GYD+5phwAFikcBBkacIn4NIbgeAGJDVVmMeNcsfcNzUR8CutoDN
         1C9g==
X-Forwarded-Encrypted: i=1; AJvYcCWkP2ze2YxD+ngWf3vg3tIBlSQnIizXNb3xt8eYwmBw/16yRXDAIcSzKcfRn2d3/XpBroOQ2gHdkZTBkIxS@vger.kernel.org
X-Gm-Message-State: AOJu0YzyoD5jdxHawE61vv4B7241clrJg+Lgfo3CLhoaWaqx3j6oyQbk
	9NsP+KyfGsJR9whfOX0ZRChZFxces0xKc2zwryjPeoIEI1hRj0pGlZsqZjwh7Agvl/O1LVWHCYe
	9Eia4/Fju7z0ze4tjyLV+uSP8T5Y6/cpNIDFC6AYHo/pAHbUq6ui8B44BJtjJKFY=
X-Received: by 2002:a05:6000:2c6:b0:37d:3985:8871 with SMTP id ffacd0b85a97d-38225a92969mr1465096f8f.39.1731664755026;
        Fri, 15 Nov 2024 01:59:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHZtrG1VPT+SoEB/3JsuRD2OwYh3OfRLaHmZweS8mwoREWkahoGdQaIQlreC1JDkXSdWnBgeA==
X-Received: by 2002:a05:6000:2c6:b0:37d:3985:8871 with SMTP id ffacd0b85a97d-38225a92969mr1465079f8f.39.1731664754683;
        Fri, 15 Nov 2024 01:59:14 -0800 (PST)
Received: from ?IPV6:2003:cb:c721:8100:177e:1983:5478:64ec? (p200300cbc7218100177e1983547864ec.dip0.t-ipconnect.de. [2003:cb:c721:8100:177e:1983:5478:64ec])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3821ae3102asm3937372f8f.93.2024.11.15.01.59.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Nov 2024 01:59:13 -0800 (PST)
Message-ID: <ca0dd4a7-e007-4092-8f46-446fba26c672@redhat.com>
Date: Fri, 15 Nov 2024 10:59:11 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 04/11] fs/proc/vmcore: move vmcore definitions from
 kcore.h to crash_dump.h
To: Baoquan He <bhe@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-s390@vger.kernel.org, virtualization@lists.linux.dev,
 kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 kexec@lists.infradead.org, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Janosch Frank <frankja@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>, Eric Farman
 <farman@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>
References: <20241025151134.1275575-1-david@redhat.com>
 <20241025151134.1275575-5-david@redhat.com> <ZzcYEQwLuLnGQM1y@MiWiFi-R3L-srv>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ZzcYEQwLuLnGQM1y@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15.11.24 10:44, Baoquan He wrote:
> On 10/25/24 at 05:11pm, David Hildenbrand wrote:
>> These defines are not related to /proc/kcore, move them to crash_dump.h
>> instead. While at it, rename "struct vmcore" to "struct
>> vmcore_mem_node", which is a more fitting name.
> 
> Agree it's inappropriate to put the defintions in kcore.h. However for
> 'struct vmcore', it's only used in fs/proc/vmcore.c from my code
> serching, do you think if we can put it in fs/proc/vmcore.c directly?
> And 'struct vmcoredd_node' too.

See the next patches and how virtio-mem will make use of the feactored 
out functions. Not putting them as inline functions into a header will 
require exporting symbols just do add a vmcore memory node to the list, 
which I want to avoid -- overkill for these simple helpers.

> 
> And about the renaming, with my understanding each instance of struct
> vmcore represents one memory region, isn't it a little confusing to be
> called vmcore_mem_node? I understand you probablly want to unify the
> vmcore and vmcoredd's naming. I have to admit I don't know vmcoredd well
> and its naming, while most of people have been knowing vmcore representing
> memory region very well.

I chose "vmcore_mem_node" because it is a memory range stored in a list. 
Note the symmetry with "vmcoredd_node"

If there are strong feelings I can use a different name, but 
"vmcore_mem_node" really describes what it actually is. Especially now 
that we have different vmcore nodes.

-- 
Cheers,

David / dhildenb


