Return-Path: <linux-fsdevel+bounces-32644-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C95A9AC326
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2024 11:10:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0A611F213F6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2024 09:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B5EC1547E4;
	Wed, 23 Oct 2024 09:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gdu57lT+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B73B15C158
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Oct 2024 09:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729674648; cv=none; b=ei/UKs4oaiCGQZTx6ea6UTbLChuuntB3Ov86l19EmywVB9wrOK/2TcSRUc+KHzw6go4Cuu76at7OnXDMSleOWGoS1rdabG8nNg0xHN056wYqenl+ln6Nsll+8jDsnQY551ZL8il3Em9uDXzbbELbthw+gaYHVxvn3YSceBxfOYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729674648; c=relaxed/simple;
	bh=E84kqeu0n0OuefaGKwxArs2WVk+D2wgCE5LexsFw0CI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zes71g26joABYZQ9axLCBdpk/RYCq0cl5hiuDxU/Xl3ZP4Nyolk6L4FdUGjb8mvAcYo/sqtLEgWqxQ+i1r7CGretLwKdhfGbQfo8sJSXHlSRG1FWN4hTyIjG8tCdxcoMNbyviqdSCZwlCThNRTqZMy0NwFwynqhp5OzU1Rb21jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gdu57lT+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729674645;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=4qR7s5/YcYr4WSYxIRlMa8VmM6jDfPPOY2YEUoQUJHw=;
	b=Gdu57lT+QGosfmpVJKIbYu3DFegWAw2Msc+Vk+W0uPrbpPrU17w9BNqmN7yumA2pqAaQ7/
	FIoobEbUlQxWouhDq0idUaCSpE3F3mJCDc2t7UEhNjuk+e+Tua0iQDQx13z0QFNZYSPq87
	QMArJ2HxjkfBNJuEkZ4tlH9Wge8orf4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-602-mmDTLKKqOCaja--L7qEXHQ-1; Wed, 23 Oct 2024 05:10:43 -0400
X-MC-Unique: mmDTLKKqOCaja--L7qEXHQ-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-37d3e8dccc9so3691712f8f.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Oct 2024 02:10:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729674642; x=1730279442;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4qR7s5/YcYr4WSYxIRlMa8VmM6jDfPPOY2YEUoQUJHw=;
        b=nsWmFuQYjM5qxK1p/OrCsy7AhGNoHVyqyIt1nTwTqbqatS+eTUEbcI0suT939lChv9
         3JoL/HA3Y53miGcfeoJlN7ApjeOk7huTK//ZI5lXodIXCLwPj1K8FfAPudd81wrCdoRY
         1K2+sgr95h8+R6whAPd4jb2SjuOSB5XJ11uZPMDo7coA+oUOfDHQnYtl0N9a+IvMnGSa
         29oktkzVwdWgpdqEacSh5SRnJ0k2Uol54lMwTrjpD5/jdYhpSpgNOjdcpiBOX95bhUfD
         BP+SUymZpmcxZtIt19QitUkBl8Z94zQezJHsIVhovUNLd2IOot4QgMWgJ9Nol1JOdO7L
         3rlA==
X-Forwarded-Encrypted: i=1; AJvYcCXnwu/IkdVCABMWCjzWrz5ASpy4rHXo1O+1G+qx4NXuy0hhdLJXYmprRjdeFzzy67yPsgbwdGVN0pXyCDeQ@vger.kernel.org
X-Gm-Message-State: AOJu0YweHrJ8c+fQcK43UhodMUPTI+PuDokxTc4QRXxtjuMrLgN6EM54
	7svpxaBiRfhKQiL4HPHLkO9PhrAe4eL5a+G3+eKR2Qvxx0uJ0ZKIW/vVhNPcvKEg9l7+1ZV0/LS
	b2nwInkyxFCdnBidAiPCx/9/pVTNdVzn3dzikzsZ2aomIhODBC98kvdAItXS6cwM=
X-Received: by 2002:a05:6000:1e42:b0:37d:3777:2ac6 with SMTP id ffacd0b85a97d-37efcf4aa55mr1076209f8f.35.1729674642235;
        Wed, 23 Oct 2024 02:10:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzDCWQnUvtH6U4gxYTqlsphdpRkMUrgcX5wGafJCiuvfgJrDXvVXX/MmnjVlR1b6y2Ia3oTw==
X-Received: by 2002:a05:6000:1e42:b0:37d:3777:2ac6 with SMTP id ffacd0b85a97d-37efcf4aa55mr1076187f8f.35.1729674641762;
        Wed, 23 Oct 2024 02:10:41 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70c:cd00:c139:924e:3595:3b5? (p200300cbc70ccd00c139924e359503b5.dip0.t-ipconnect.de. [2003:cb:c70c:cd00:c139:924e:3595:3b5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0a614d0sm8466719f8f.63.2024.10.23.02.10.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2024 02:10:41 -0700 (PDT)
Message-ID: <f5d70d2c-b7e6-483a-bc07-48947203e832@redhat.com>
Date: Wed, 23 Oct 2024 11:10:40 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 00/17] mm: MM owner tracking for large folios
 (!hugetlb) + CONFIG_NO_PAGE_MAPCOUNT
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, cgroups@vger.kernel.org, x86@kernel.org,
 linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Tejun Heo <tj@kernel.org>,
 Zefan Li <lizefan.x@bytedance.com>, Johannes Weiner <hannes@cmpxchg.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Jonathan Corbet <corbet@lwn.net>, Andy Lutomirski <luto@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>
References: <20240829165627.2256514-1-david@redhat.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240829165627.2256514-1-david@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29.08.24 18:56, David Hildenbrand wrote:
> RMAP overhaul and optimizations, PTE batching, large mapcount,
> folio_likely_mapped_shared() introduction and optimizations, page_mapcount
> cleanups and preparations ... it's been quite some work to get to this
> point.
> 
> Next up is being able to identify -- without false positives, without
> page-mapcounts and without page table/rmap scanning -- whether a
> large folio is "mapped exclusively" into a single MM, and using that
> information to implement Copy-on-Write reuse and to improve
> folio_likely_mapped_shared() for large folios.
> 
> ... and based on that, finally introducing a kernel config option that
> let's us not use+maintain per-page mapcounts in large folios, improving
> performance of (un)map operations today, taking one step towards
> supporting large folios  > PMD_SIZE, and preparing for the bright future
> where we might no longer have a mapcount per page at all.
> 
> The bigger picture was presented at LSF/MM [1].
> 
> This series is effectively a follow-up on my early work from last
> year [2], which proposed a precise way to identify whether a large folio is
> "mapped shared" into multiple MMs or "mapped exclusively" into a single MM.
> 
> While that advanced approach has been simplified and optimized in the
> meantime, let's start with something simpler first -- "certainly mapped
> exclusive" vs. ""maybe mapped shared" -- so we can start learning about
> the effects and TODOs that some of the implied changes of losing
> per-page mapcounts has.
> 
> I have plans to exchange the simple approach used in this series at some
> point by the advanced approach, but one important thing to learn if the
> imprecision in the simple approach is relevant in practice.
> 
> 64BIT only, and unless enabled in kconfig, this series should for now
> not have any impact.
> 
> 
> 1) Patch Organization
> =====================
> 
> Patch #1 -> #4: make more room on 64BIT in order-1 folios
> 
> Patch #5 -> #7: prepare for MM owner tracking of large folios
> 
> Patch #8: implement a simple MM owner tracking approach for large folios
> 
> patch #9: simple optimization
> 
> Patch #10: COW reuse for PTE-mapped anon THP
> 
> Patch #11 -> #17: introduce and implement CONFIG_NO_PAGE_MAPCOUNT
> 
> 
> 2) MM owner tracking
> ====================
> 
> Similar to my advanced approach [2], we assign each MM a unique 20-bit ID
> ("MM ID"), to be able to squeeze more information in our folios.
> 
> Each large folios can store two MM-ID+mapcount combination:
> * mm0_id + mm0_mapcount
> * mm1_id + mm1_mapcount
> 
> Combined with the large mapcount, we can reliably identify whether one
> of these MMs is the current owner (-> owns all mappings) or even holds
> all folio references (-> owns all mappings, and all references are from
> mappings).
> 
> Stored MM IDs can only change if the corresponding mapcount is logically
> 0, and if the folio is currently "mapped exclusively".
> 
> As long as only two MMs map folio pages at a time, we can reliably identify
> whether a large folio is "mapped shared" or "mapped exclusively". The
> approach is precise.
> 
> Any MM mapping the folio while two other MMs are already mapping the folio,
> will lead to a "mapped shared" detection even after all other MMs stopped
> mapping the folio and it is actually "mapped exclusively": we can have
> false positives but never false negatives when detecting "mapped shared".
> 
> So that's where the approach gets imprecise.
> 
> For now, we use a bit-spinlock to sync the large mapcount + MM IDs + MM
> mapcounts, and make sure we do keep the machinery fast, to not degrade
> (un)map performance too much: for example, we make sure to only use a
> single atomic (when grabbing the bit-spinlock), like we would already
> perform when updating the large mapcount.
> 
> In the future, we might be able to use an arch_spin_lock(), but that's
> future work.
> 
> 
> 3) CONFIG_NO_PAGE_MAPCOUNT
> ==========================
> 
> patch #11 -> #17 spell out and document what exactly is affected when
> not maintaining the per-page mapcounts in large folios anymore.
> 
> For example, as we cannot maintain folio->_nr_pages_mapped anymore when
> (un)mapping pages, we'll account a complete folio as mapped if a
> single page is mapped.
> 
> As another example, we might now under-estimate the USS (Unique Set Size)
> of a process, but never over-estimate it.
> 
> With a more elaborate approach for MM-owner tracking like #1, some things
> could be improved (e.g., USS to some degree), but somethings just cannot be
> handled like we used to without these per-page mapcounts (e.g.,
> folio->_nr_pages_mapped).
> 
> 
> 4) Performance
> ==============
> 
> The following kernel config combinations are possible:
> 
> * Base: CONFIG_PAGE_MAPCOUNT
>    -> (existing) page-mapcount tracking
> * MM-ID: CONFIG_MM_ID && CONFIG_PAGE_MAPCOUNT
>    -> page-mapcount + MM-ID tracking
> * No-Mapcount: CONFIG_MM_ID && CONFIG_NO_PAGE_MAPCOUNT
>    -> MM-ID tracking
> 
> 
> I run my PTE-mapped-THP microbenchmarks [3] and vm-scalability on a machine
> with two NUMA nodes, with a 10-core Intel(R) Xeon(R) Silver 4210R CPU @
> 2.40GHz and 16 GiB of memory each.
> 
> 4.1) PTE-mapped-THP microbenchmarks
> -----------------------------------
> 
> All benchmarks allocate 1 GiB of THPs of a given size, to then fork()/
> munmap/... PMD-sized THPs are mapped by PTEs first.
> 
> Numbers are increase (+) / reduction (-) in runtime. Reduction (-) is
> good. "Base" is the baseline.
> 
> munmap: munmap() the allocated memory.
> 
> Folio Size |  MM-ID | No-Mapcount
> --------------------------------
>      16 KiB |   2 % |        -8 %
>      32 KiB |   3 % |        -9 %
>      64 KiB |   4 % |       -16 %
>     128 KiB |   3 % |       -17 %
>     256 KiB |   1 % |       -23 %
>     512 KiB |   1 % |       -26 %
>    1024 KiB |   0 % |       -29 %
>    2048 KiB |   0 % |       -31 %
> 
> -> 32-128 with MM-ID are a bit unexpected: we would expect to see the worst
>     case with the smallest size (16 KiB). But for these sizes also the STDEV
>     is between 1% and 2%, in contrast to the others (< 1 %). Maybe some
>     weird interaction with PCP/buddy.
> 
> fork: fork()
> 
> Folio Size |  MM-ID | No-Mapcount
> --------------------------------
>      16 KiB |    4 % |       -9 %
>      32 KiB |    1 % |      -12 %
>      64 KiB |    0 % |      -15 %
>     128 KiB |    0 % |      -15 %
>     256 KiB |    0 % |      -16 %
>     512 KiB |    0 % |      -16 %
>    1024 KiB |    0 % |      -17 %
>    2048 KiB |   -1 % |      -21 %
> 
> -> Slight slowdown with MM-ID for the smallest folio size (more what we
> expect in contrast to munmap()).
> 
> cow-byte: fork() and keep the child running. write one byte to each
>    individual page, measuring the duration of all writes.
> 
> Folio Size |  MM-ID | No-Mapcount
> --------------------------------
>      16 KiB |    0 % |        0 %
>      32 KiB |    0 % |        0 %
>      64 KiB |    0 % |        0 %
>     128 KiB |    0 % |        0 %
>     256 KiB |    0 % |        0 %
>     512 KiB |    0 % |        0 %
>    1024 KiB |    0 % |        0 %
>    2048 KiB |    0 % |        0 %
> 
> -> All other overhead dominates even when effectively unmapping
>     single pages of large folios when replacing them by a copy during write
>     faults. No change, which is great!
> 
> reuse-byte: fork() and wait until the child quit. write one byte to each
>    individual page, measuring the duration of all writes.
> 
> Folio Size |  MM-ID | No-Mapcount
> --------------------------------
>      16 KiB |  -66 % |      -66 %
>      32 KiB |  -65 % |      -65 %
>      64 KiB |  -64 % |      -64 %
>     128 KiB |  -64 % |      -64 %
>     256 KiB |  -64 % |      -64 %
>     512 KiB |  -64 % |      -64 %
>    1024 KiB |  -64 % |      -64 %
>    2048 KiB |  -64 % |      -64 %
> 
> -> No surprise, we reuse all pages instead of copying them.
> 
> child-reuse-bye: fork() and unmap the memory in the parent. write one byte
>    to each individual page in the child, measuring the duration of all writes.
> 
> Folio Size |  MM-ID | No-Mapcount
> --------------------------------
>      16 KiB |  -66 % |      -66 %
>      32 KiB |  -65 % |      -65 %
>      64 KiB |  -64 % |      -64 %
>     128 KiB |  -64 % |      -64 %
>     256 KiB |  -64 % |      -64 %
>     512 KiB |  -64 % |      -64 %
>    1024 KiB |  -64 % |      -64 %
>    2048 KiB |  -64 % |      -64 %
> 
> -> Same thing, we reuse all pages instead of copying them.
> 
> 
> For 4 KiB, there is no change in any benchmark, as expected.
> 
> 
> 4.2) vm-scalability
> -------------------
> 
> For now I only ran anon COW tests. I use 1 GiB per child process and use
> one child per core (-> 20).
> 
> case-anon-cow-rand: random writes
> 
> There is effectively no change (<0.6% throughput difference).
> 
> case-anon-cow-seq: sequential writes
> 
> MM-ID has up to 2% *lower* throughout than Base, not really correlating to
> folio size. The difference is almost as large as the STDEV (1% - 2%),
> though. It looks like there is a very slight effective slowdown.
> 
> No-Mapcount has up to 3% *higher* throughput than Base, not really
> correlating to the folio size. However, also here the difference is almost
> as large as the STDEV (up to 2%). It looks like there is a very slight
> effective speedup.
> 
> In summary, no earth-shattering slowdown with MM-ID (and we just recently
> optimized folio->_nr_pages_mapped to give us some speedup :) ), and
> another nice improvement with No-Mapcount.
> 
> 
> I did a bunch of cross-compiles and the build bots turned out very helpful
> over the last months. I did quite some testing with LTP and selftests,
> but x86-64 only.

Gentle ping. I might soon have capacity to continue working on this. If 
there is no further feedback I'll rebase and resend.

-- 
Cheers,

David / dhildenb


