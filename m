Return-Path: <linux-fsdevel+bounces-42834-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 154B3A49466
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2025 10:07:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 121C0170543
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2025 09:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A9324C689;
	Fri, 28 Feb 2025 09:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C7Vf1FsR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8480F276D3B
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Feb 2025 09:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740733672; cv=none; b=uNgRNiZvEofe0o36/ehUb8s2Zk5ve7WOfwpZONTqhkOIojN2n/UUiw+Gl6nr9B5MYrZghxXVnV6Iia6gCwKRqFlLSYdUIoEzh8MBtIKWAUk5YRoMT5xR8nQjMAkfs5gf/mHfv5ddqeuklVzohohMDLaQRVYKgIlVApfQekww+3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740733672; c=relaxed/simple;
	bh=lOn4aRELu/gRxyVpLDamQS+gdcdBSgcn0FwNKUIKyAM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BmAuQDF0xwQ2Tf/o8a87nh7rruSjqMKS7IlET+3DdG/s8g+h49P72WDGFGxC1bHWbyh45OcbSwOnO7yqt8qkJ/UUIgqoekqX7BiRHiLHK+93SmEYO/oDcU1gEeCDa3iyUu5ybfweflRIgfBOZf5m8Uh99vzst4t3Wm6Xvac2/hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C7Vf1FsR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740733669;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=CLpDI5xGE6mXb+IR67XG43Kov2MdpYGXuo5ipHK4BBc=;
	b=C7Vf1FsRLWXGewCJ3rNtx7YOsbgHfWOfXlwXGpWqz5V1QS1IMy3t03huQPmb/u3VO/4F7n
	tyXCU4HSxRTLssQpQloZM9BGfizo5HuzrahC15GRfvGe4gPb8d1t8x7cu3M/N5NjCOrYXK
	v7Fa88pzew0yr8lTCmiB3fikDfuFZss=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-g61lmQIwP0C1MZJ16DDtSA-1; Fri, 28 Feb 2025 04:07:47 -0500
X-MC-Unique: g61lmQIwP0C1MZJ16DDtSA-1
X-Mimecast-MFC-AGG-ID: g61lmQIwP0C1MZJ16DDtSA_1740733666
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43941ad86d4so9808255e9.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Feb 2025 01:07:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740733666; x=1741338466;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CLpDI5xGE6mXb+IR67XG43Kov2MdpYGXuo5ipHK4BBc=;
        b=RNciN38YBDfrZz/PIw7pa5LbgouDiduSfUY9t8tLjAuKGwVS0KiyWZxvhtHnpe4Mnb
         TJWwVn2vEgDvKrco1F+y9eNJC/jylt/Te/klUebYAKfhGfDcTR2AqhWc8zUr+N6ngkYw
         99jhk4xgK6Rktkyi9INwydc8+cRvtLd1NZJPIERVZEE3wtQPWjNALDI26V3kbIJIQx1a
         ApXLrpN/R16x5QQqD6rcxJ5HlkDXEZM45S/4oBiAfbiIP9UK6sml3G062gsyT5RTalPX
         7lNT1KWvJBG+WcMD5qZWNtqk//FUsTQsyrOUJxU8a5NbgVHd3Z+4NzZzZOlpvp1fB/nC
         eCpQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOIxR4xLDoYibEEOCb5uAJCkYwjEQWJC4TXn6ITOfkVRyO/x3sKgMqZenjvdeARRsJaBJ8jLV8a5MX9hts@vger.kernel.org
X-Gm-Message-State: AOJu0Ywjw3epbdaNNRzUL6SjYkbZCFeQQEnROIbhWtLQJ+IIrQwJfADa
	seOCVNfXwKSEoE/dWCpamk8AqWYfjUm5boji4yKqY5TJLK+WQw42HW7ujEBNqGq31uKElLaYD9V
	hPOcssd1cJWzN4jwDAOWTzsXed6ZfyJIYmhve8zu3muUAj10v2tTHnOvnf0uyof0=
X-Gm-Gg: ASbGncuApoZOciiCNctIzc9JFUMBMWNR18TAhzsC+7Guu06c0tAPU/SMadTJ6+e755Q
	mWB4PgwpuylK0p27bKcp2zIh5kLY8IVItDTSe6rvdMH47THc2n2QwsecjqF7lnlYANWhWXNSOJ+
	xN2MnQvk4hAx1PRg2fo2I4vBCjfws0aPHS+e6osp5+g7tEQOhUzlzwQqfSP4gPJ1KJuHsbJb8Hv
	YBWC77NdCnjLJW5SbE0d8LIcXzhKc/ZyNArwdRFG1tTSr/3ez5KT5QqRtnwRU1MeKQsSLgRV0D7
	36GyNKdFMvT5SkD7CN8GeOI6WiwAq1fqATLhMvsdbK16odM2s1F44e9UAbg4prGSZDROOYJotny
	zBW9HLv2DBfSPi1TZn84YD7CGZ7wxybxAhbQlVF9v1Qw=
X-Received: by 2002:a05:600c:5494:b0:439:9274:8203 with SMTP id 5b1f17b1804b1-43ba66da2c6mr18843435e9.6.1740733666018;
        Fri, 28 Feb 2025 01:07:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHcowIRN1si6B/2EEwD1Z6PD6dmMdXxwC9HncOy9CKvmoKbafJCK/yvPTC25F2J3LGP00Ca1w==
X-Received: by 2002:a05:600c:5494:b0:439:9274:8203 with SMTP id 5b1f17b1804b1-43ba66da2c6mr18843165e9.6.1740733665603;
        Fri, 28 Feb 2025 01:07:45 -0800 (PST)
Received: from ?IPV6:2003:cb:c701:e300:af53:3949:eced:246d? (p200300cbc701e300af533949eced246d.dip0.t-ipconnect.de. [2003:cb:c701:e300:af53:3949:eced:246d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ab2c4051bsm84198565e9.0.2025.02.28.01.07.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Feb 2025 01:07:45 -0800 (PST)
Message-ID: <2dcaa0a6-c20d-4e57-80df-b288d2faa58d@redhat.com>
Date: Fri, 28 Feb 2025 10:07:43 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Optimizing Page Cache Readahead
 Behavior
To: Matthew Wilcox <willy@infradead.org>, Dave Chinner <david@fromorbit.com>
Cc: Kalesh Singh <kaleshsingh@google.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Jan Kara <jack@suse.cz>,
 lsf-pc@lists.linux-foundation.org,
 "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Suren Baghdasaryan <surenb@google.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Juan Yescas
 <jyescas@google.com>, android-mm <android-mm@google.com>,
 Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@suse.com>,
 "Cc: Android Kernel" <kernel-team@android.com>
References: <CAC_TJvfG8GcwG_2w1o6GOTZS8tfEx2h9A91qsenYfYsX8Te=Bg@mail.gmail.com>
 <hep2a5d6k2kwth5klatzhl3ejbc6g2opqu6tyxyiohbpdyhvwp@lkg2wbb4zhy3>
 <3bd275ed-7951-4a55-9331-560981770d30@lucifer.local>
 <ivnv2crd3et76p2nx7oszuqhzzah756oecn5yuykzqfkqzoygw@yvnlkhjjssoz>
 <82fbe53b-98c4-4e55-9eeb-5a013596c4c6@lucifer.local>
 <CAC_TJvcnD731xyudgapjHx=dvVHY+cxoO1--2us7oo9TqA9-_g@mail.gmail.com>
 <Z70HJWliB4wXE-DD@dread.disaster.area>
 <Z8DjYmYPRDArpsqx@casper.infradead.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <Z8DjYmYPRDArpsqx@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27.02.25 23:12, Matthew Wilcox wrote:
> On Tue, Feb 25, 2025 at 10:56:21AM +1100, Dave Chinner wrote:
>>>  From the previous discussions that Matthew shared [7], it seems like
>>> Dave proposed an alternative to moving the extents to the VFS layer to
>>> invert the IO read path operations [8]. Maybe this is a move
>>> approachable solution since there is precedence for the same in the
>>> write path?
>>>
>>> [7] https://lore.kernel.org/linux-fsdevel/Zs97qHI-wA1a53Mm@casper.infradead.org/
>>> [8] https://lore.kernel.org/linux-fsdevel/ZtAPsMcc3IC1VaAF@dread.disaster.area/
>>
>> Yes, if we are going to optimise away redundant zeros being stored
>> in the page cache over holes, we need to know where the holes in the
>> file are before the page cache is populated.
> 
> Well, you shot that down when I started trying to flesh it out:
> https://lore.kernel.org/linux-fsdevel/Zs+2u3%2FUsoaUHuid@dread.disaster.area/
> 
>> As for efficient hole tracking in the mapping tree, I suspect that
>> we should be looking at using exceptional entries in the mapping
>> tree for holes, not inserting mulitple references to the zero folio.
>> i.e. the important information for data storage optimisation is that
>> the region covers a hole, not that it contains zeros.
> 
> The xarray is very much optimised for storing power-of-two sized &
> aligned objects.  It makes no sense to try to track extents using the
> mapping tree.  Now, if we abandon the radix tree for the maple tree, we
> could talk about storing zero extents in the same data structure.
> But that's a big change with potentially significant downsides.
> It's something I want to play with, but I'm a little busy right now.
> 
>> For buffered reads, all that is required when such an exceptional
>> entry is returned is a memset of the user buffer. For buffered
>> writes, we simply treat it like a normal folio allocating write and
>> replace the exceptional entry with the allocated (and zeroed) folio.
> 
> ... and unmap the zero page from any mappings.
> 
>> For read page faults, the zero page gets mapped (and maybe
>> accounted) via the vma rather than the mapping tree entry. For write
>> faults, a folio gets allocated and the exception entry replaced
>> before we call into ->page_mkwrite().
>>
>> Invalidation simply removes the exceptional entries.
> 
> ... and unmap the zero page from any mappings.
> 

I'll add one detail for future reference; not sure about the priority 
this should have, but it's one of these nasty corner cases that are not 
the obvious to spot when having the shared zeropage in MAP_SHARED mappings:

Currently, only FS-DAX makes use of the shared zeropage in "ordinary 
MAP_SHARED" mappings. It doesn't use it for "holes" but for "logically 
zero" pages, to avoid allocating disk blocks (-> translating to actual 
DAX memory) on read-only access.

There is one issue between gup(FOLL_LONGTERM | FOLL_PIN) and the shared 
zeropage in MAP_SHARED mappings. It so far does not apply to fsdax,
because ... we don't support FOLL_LONGTERM for fsdax at all.

I spelled out part of the issue in fce831c92092 ("mm/memory: cleanly 
support zeropage in vm_insert_page*(), vm_map_pages*() and 
vmf_insert_mixed()").

In general, the problem is that gup(FOLL_LONGTERM | FOLL_PIN) will have 
to decide if it is okay to longterm-pin the shared zeropage in a 
MAP_SHARED mapping (which might just be fine with a R/O file in some 
cases?), and if not, it would have to trigger FAULT_FLAG_UNSHARE similar 
to how we break COW in MAP_PRIVATE mappings (shared zeropage -> 
anonymous folio).

If gup(FOLL_LONGTERM | FOLL_PIN) would just always longterm-pin the 
shared zeropage, and somebody else would end up triggering replacement 
of the shared zeropage in the pagecache (e.g., write() to the file 
offset, write access to the VMA that triggers a write fault etc.), you'd 
get a disconnect between what the GUP user sees and what the pagecache 
actually contains.

The file system fault logic will have to be taught about 
FAULT_FLAG_UNSHARE and handle it accordingly (e.g., allocate fill file 
hole, allocate disk space, allocate an actual folio ...).

Things like memfd_pin_folios() might require similar care -- that one in 
particular should likely never return the shared zeropage.

Likely gup(FOLL_LONGTERM | FOLL_PIN) users like RDMA or VFIO will be 
able to trigger it.


Not using the shared zeropage but instead some "hole" PTE marker could 
avoid this problem. Of course, not allowing for reading the shared 
zeropage there, but maybe that's not strictly required?

-- 
Cheers,

David / dhildenb


