Return-Path: <linux-fsdevel+bounces-14283-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B2A887A78F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 13:29:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFE111C21301
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 12:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 518EC4086B;
	Wed, 13 Mar 2024 12:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MvCsKceH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2340405C7
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Mar 2024 12:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710332960; cv=none; b=WGX87Df8I+VqnHCXDvXAfQnokWVEY/t4S5CiV+yfKkuezpmRzyDAeCwRlC/ketvTsFrIccyhAkSatKl3IhYcu/KKaRJQXeuYOouqxuoeGGrgOzU1lMqk7dWO7gypAPfB1kuds9qDaC3iaL3j5ax8W4FvNdMqzUrhsiaOfmHxCPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710332960; c=relaxed/simple;
	bh=oSqOOOQXVNftgsoUErcdOE2GsR+PW6IzXyyX4xJ/+gw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fqYjP0wLrB/Qbmtxj6H9mlGrOhMrDCOJQeGui6uB5PYKw3UhF3RkhpRsNyrhyTDjN9Nbo3edVXXoCuLnkR34OL8yaqIXIooIqN2kHaZVucGDy6WV5FM5OF8o3p2IFho77qQEidmE2KrJzvX4gAcCXCzjtBd/CmzhbDJ7td5DUYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MvCsKceH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710332957;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=k8x5ZSVtO603+A176kqypuw3h2+JLOydtLzQlaAOVxY=;
	b=MvCsKceHoA1hFeVYQTjQP7FCm7KJ4Qcxhel7n61tRe/eQC3lG4JbjrXljQ3HbKX/UGKkHZ
	I8mggqVDENJr00Hik0HKRMJfSQBLPNRTIYg5UIfufSukZICHfaOx7OCPvRFqd8W3CnS+oZ
	aWaFihnWJ6p57BAnJpYyPl3G0ZCtf1w=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-114-WIFKLmObPeCFrzvb4zXRBg-1; Wed, 13 Mar 2024 08:29:16 -0400
X-MC-Unique: WIFKLmObPeCFrzvb4zXRBg-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-513cb05fcfdso434808e87.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Mar 2024 05:29:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710332954; x=1710937754;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k8x5ZSVtO603+A176kqypuw3h2+JLOydtLzQlaAOVxY=;
        b=mArJOXhwaL38mMr+6AU0iMDfdJEF4+8hlrfhyveG4RT9omxrshtxFrPRJ52gHQhygm
         OTVtMgOwlXMH4LvgfQZ67mbOtarMdM+LtPOQviRc9fawsu0uKFjNNQzMFNH75ixQXEn3
         NOGaPXItcPg86kpcgeLT9qM+irzhlmBrPDu2bBiI4zkLSUDNRtmD/czgvgy0C+Poyyg2
         l38tYCkuGyDRTGO7sd+MmyyVraKus4TlyO9OOTmO8Ij939DJ/Y/Tz9HPp3A1or2SZnZS
         Qjsvf8wmmqBSILFUEHuNOwU8rAAhgQdczV4CIveq26kpXYDixiE9fYKKT81e8yYqFntY
         /dAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXkNb6WVig8aLgPqmXbxKIe98byRwpbHf7mFVzVomEaRhR3sCnVSlk/Tb6SKWg0fQRTc5Txc6dFJeMqPMq4wH8LzetIjJNowWYZFSvffg==
X-Gm-Message-State: AOJu0YzCJV3tc2/+fmzjIHYI31bcZrfw2wh0uyWl5v1aN7neG/zF0oC6
	+yyP3ljp49BJTSvwEwgc370HnfyyjJXTwruRAuKF71CKDzy9h7CDy8wxn1IAoaeg7FoLIRqSKN2
	5eoXM6TlOAuwXlMJunvQIYvGRWJxpM6FyB/pIMTPDJsWsJ5PgXY20gxdMSDgmBkU=
X-Received: by 2002:ac2:430b:0:b0:513:55ea:7e2e with SMTP id l11-20020ac2430b000000b0051355ea7e2emr3382720lfh.53.1710332954528;
        Wed, 13 Mar 2024 05:29:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGfsCGI3AFEG0mu84otxaoZ5vWsgSIsgkV4jPcCeSYNL14MUNICSC9ePLEwtBpr3UTge2H3bA==
X-Received: by 2002:ac2:430b:0:b0:513:55ea:7e2e with SMTP id l11-20020ac2430b000000b0051355ea7e2emr3382706lfh.53.1710332954000;
        Wed, 13 Mar 2024 05:29:14 -0700 (PDT)
Received: from [10.32.64.142] (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id q18-20020adf9dd2000000b0033e90e98886sm9006066wre.71.2024.03.13.05.29.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Mar 2024 05:29:13 -0700 (PDT)
Message-ID: <420b6d5f-adef-4415-b8cb-16c234dcec38@redhat.com>
Date: Wed, 13 Mar 2024 13:29:12 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 06/24] fsverity: pass tree_blocksize to
 end_enable_verity()
Content-Language: en-US
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>,
 Andrey Albershteyn <aalbersh@redhat.com>, fsverity@lists.linux.dev,
 linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 chandan.babu@oracle.com, akpm@linux-foundation.org, linux-mm@kvack.org,
 Eric Biggers <ebiggers@kernel.org>
References: <20240304191046.157464-2-aalbersh@redhat.com>
 <20240304191046.157464-8-aalbersh@redhat.com>
 <20240305005242.GE17145@sol.localdomain>
 <20240306163000.GP1927156@frogsfrogsfrogs>
 <20240307220224.GA1799@sol.localdomain>
 <20240308034650.GK1927156@frogsfrogsfrogs>
 <20240308044017.GC8111@sol.localdomain>
 <20240311223815.GW1927156@frogsfrogsfrogs>
 <9927568e-9f36-4417-9d26-c8a05c220399@redhat.com>
 <08905bcc-677d-4981-926d-7f407b2f6a4a@redhat.com>
 <20240312164444.GG1927156@frogsfrogsfrogs>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 xsFNBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABzSREYXZpZCBIaWxk
 ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT7CwZgEEwEIAEICGwMGCwkIBwMCBhUIAgkKCwQW
 AgMBAh4BAheAAhkBFiEEG9nKrXNcTDpGDfzKTd4Q9wD/g1oFAl8Ox4kFCRKpKXgACgkQTd4Q
 9wD/g1oHcA//a6Tj7SBNjFNM1iNhWUo1lxAja0lpSodSnB2g4FCZ4R61SBR4l/psBL73xktp
 rDHrx4aSpwkRP6Epu6mLvhlfjmkRG4OynJ5HG1gfv7RJJfnUdUM1z5kdS8JBrOhMJS2c/gPf
 wv1TGRq2XdMPnfY2o0CxRqpcLkx4vBODvJGl2mQyJF/gPepdDfcT8/PY9BJ7FL6Hrq1gnAo4
 3Iv9qV0JiT2wmZciNyYQhmA1V6dyTRiQ4YAc31zOo2IM+xisPzeSHgw3ONY/XhYvfZ9r7W1l
 pNQdc2G+o4Di9NPFHQQhDw3YTRR1opJaTlRDzxYxzU6ZnUUBghxt9cwUWTpfCktkMZiPSDGd
 KgQBjnweV2jw9UOTxjb4LXqDjmSNkjDdQUOU69jGMUXgihvo4zhYcMX8F5gWdRtMR7DzW/YE
 BgVcyxNkMIXoY1aYj6npHYiNQesQlqjU6azjbH70/SXKM5tNRplgW8TNprMDuntdvV9wNkFs
 9TyM02V5aWxFfI42+aivc4KEw69SE9KXwC7FSf5wXzuTot97N9Phj/Z3+jx443jo2NR34XgF
 89cct7wJMjOF7bBefo0fPPZQuIma0Zym71cP61OP/i11ahNye6HGKfxGCOcs5wW9kRQEk8P9
 M/k2wt3mt/fCQnuP/mWutNPt95w9wSsUyATLmtNrwccz63XOwU0EVcufkQEQAOfX3n0g0fZz
 Bgm/S2zF/kxQKCEKP8ID+Vz8sy2GpDvveBq4H2Y34XWsT1zLJdvqPI4af4ZSMxuerWjXbVWb
 T6d4odQIG0fKx4F8NccDqbgHeZRNajXeeJ3R7gAzvWvQNLz4piHrO/B4tf8svmRBL0ZB5P5A
 2uhdwLU3NZuK22zpNn4is87BPWF8HhY0L5fafgDMOqnf4guJVJPYNPhUFzXUbPqOKOkL8ojk
 CXxkOFHAbjstSK5Ca3fKquY3rdX3DNo+EL7FvAiw1mUtS+5GeYE+RMnDCsVFm/C7kY8c2d0G
 NWkB9pJM5+mnIoFNxy7YBcldYATVeOHoY4LyaUWNnAvFYWp08dHWfZo9WCiJMuTfgtH9tc75
 7QanMVdPt6fDK8UUXIBLQ2TWr/sQKE9xtFuEmoQGlE1l6bGaDnnMLcYu+Asp3kDT0w4zYGsx
 5r6XQVRH4+5N6eHZiaeYtFOujp5n+pjBaQK7wUUjDilPQ5QMzIuCL4YjVoylWiBNknvQWBXS
 lQCWmavOT9sttGQXdPCC5ynI+1ymZC1ORZKANLnRAb0NH/UCzcsstw2TAkFnMEbo9Zu9w7Kv
 AxBQXWeXhJI9XQssfrf4Gusdqx8nPEpfOqCtbbwJMATbHyqLt7/oz/5deGuwxgb65pWIzufa
 N7eop7uh+6bezi+rugUI+w6DABEBAAHCwXwEGAEIACYCGwwWIQQb2cqtc1xMOkYN/MpN3hD3
 AP+DWgUCXw7HsgUJEqkpoQAKCRBN3hD3AP+DWrrpD/4qS3dyVRxDcDHIlmguXjC1Q5tZTwNB
 boaBTPHSy/Nksu0eY7x6HfQJ3xajVH32Ms6t1trDQmPx2iP5+7iDsb7OKAb5eOS8h+BEBDeq
 3ecsQDv0fFJOA9ag5O3LLNk+3x3q7e0uo06XMaY7UHS341ozXUUI7wC7iKfoUTv03iO9El5f
 XpNMx/YrIMduZ2+nd9Di7o5+KIwlb2mAB9sTNHdMrXesX8eBL6T9b+MZJk+mZuPxKNVfEQMQ
 a5SxUEADIPQTPNvBewdeI80yeOCrN+Zzwy/Mrx9EPeu59Y5vSJOx/z6OUImD/GhX7Xvkt3kq
 Er5KTrJz3++B6SH9pum9PuoE/k+nntJkNMmQpR4MCBaV/J9gIOPGodDKnjdng+mXliF3Ptu6
 3oxc2RCyGzTlxyMwuc2U5Q7KtUNTdDe8T0uE+9b8BLMVQDDfJjqY0VVqSUwImzTDLX9S4g/8
 kC4HRcclk8hpyhY2jKGluZO0awwTIMgVEzmTyBphDg/Gx7dZU1Xf8HFuE+UZ5UDHDTnwgv7E
 th6RC9+WrhDNspZ9fJjKWRbveQgUFCpe1sa77LAw+XFrKmBHXp9ZVIe90RMe2tRL06BGiRZr
 jPrnvUsUUsjRoRNJjKKA/REq+sAnhkNPPZ/NNMjaZ5b8Tovi8C0tmxiCHaQYqj7G2rgnT0kt
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240312164444.GG1927156@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12.03.24 17:44, Darrick J. Wong wrote:
> On Tue, Mar 12, 2024 at 04:33:14PM +0100, David Hildenbrand wrote:
>> On 12.03.24 16:13, David Hildenbrand wrote:
>>> On 11.03.24 23:38, Darrick J. Wong wrote:
>>>> [add willy and linux-mm]
>>>>
>>>> On Thu, Mar 07, 2024 at 08:40:17PM -0800, Eric Biggers wrote:
>>>>> On Thu, Mar 07, 2024 at 07:46:50PM -0800, Darrick J. Wong wrote:
>>>>>>> BTW, is xfs_repair planned to do anything about any such extra blocks?
>>>>>>
>>>>>> Sorry to answer your question with a question, but how much checking is
>>>>>> $filesystem expected to do for merkle trees?
>>>>>>
>>>>>> In theory xfs_repair could learn how to interpret the verity descriptor,
>>>>>> walk the merkle tree blocks, and even read the file data to confirm
>>>>>> intactness.  If the descriptor specifies the highest block address then
>>>>>> we could certainly trim off excess blocks.  But I don't know how much of
>>>>>> libfsverity actually lets you do that; I haven't looked into that
>>>>>> deeply. :/
>>>>>>
>>>>>> For xfs_scrub I guess the job is theoretically simpler, since we only
>>>>>> need to stream reads of the verity files through the page cache and let
>>>>>> verity tell us if the file data are consistent.
>>>>>>
>>>>>> For both tools, if something finds errors in the merkle tree structure
>>>>>> itself, do we turn off verity?  Or do we do something nasty like
>>>>>> truncate the file?
>>>>>
>>>>> As far as I know (I haven't been following btrfs-progs, but I'm familiar with
>>>>> e2fsprogs and f2fs-tools), there isn't yet any precedent for fsck actually
>>>>> validating the data of verity inodes against their Merkle trees.
>>>>>
>>>>> e2fsck does delete the verity metadata of inodes that don't have the verity flag
>>>>> enabled.  That handles cleaning up after a crash during FS_IOC_ENABLE_VERITY.
>>>>>
>>>>> I suppose that ideally, if an inode's verity metadata is invalid, then fsck
>>>>> should delete that inode's verity metadata and remove the verity flag from the
>>>>> inode.  Checking for a missing or obviously corrupt fsverity_descriptor would be
>>>>> fairly straightforward, but it probably wouldn't catch much compared to actually
>>>>> validating the data against the Merkle tree.  And actually validating the data
>>>>> against the Merkle tree would be complex and expensive.  Note, none of this
>>>>> would work on files that are encrypted.
>>>>>
>>>>> Re: libfsverity, I think it would be possible to validate a Merkle tree using
>>>>> libfsverity_compute_digest() and the callbacks that it supports.  But that's not
>>>>> quite what it was designed for.
>>>>>
>>>>>> Is there an ioctl or something that allows userspace to validate an
>>>>>> entire file's contents?  Sort of like what BLKVERIFY would have done for
>>>>>> block devices, except that we might believe its answers?
>>>>>
>>>>> Just reading the whole file and seeing whether you get an error would do it.
>>>>>
>>>>> Though if you want to make sure it's really re-reading the on-disk data, it's
>>>>> necessary to drop the file's pagecache first.
>>>>
>>>> I tried a straight pagecache read and it worked like a charm!
>>>>
>>>> But then I thought to myself, do I really want to waste memory bandwidth
>>>> copying a bunch of data?  No.  I don't even want to incur system call
>>>> overhead from reading a single byte every $pagesize bytes.
>>>>
>>>> So I created 2M mmap areas and read a byte every $pagesize bytes.  That
>>>> worked too, insofar as SIGBUSes are annoying to handle.  But it's
>>>> annoying to take signals like that.
>>>>
>>>> Then I started looking at madvise.  MADV_POPULATE_READ looked exactly
>>>> like what I wanted -- it prefaults in the pages, and "If populating
>>>> fails, a SIGBUS signal is not generated; instead, an error is returned."
>>>>
>>>
>>> Yes, these were the expected semantics :)
>>>
>>>> But then I tried rigging up a test to see if I could catch an EIO, and
>>>> instead I had to SIGKILL the process!  It looks filemap_fault returns
>>>> VM_FAULT_RETRY to __xfs_filemap_fault, which propagates up through
>>>> __do_fault -> do_read_fault -> do_fault -> handle_pte_fault ->
>>>> handle_mm_fault -> faultin_page -> __get_user_pages.  At faultin_pages,
>>>> the VM_FAULT_RETRY is translated to -EBUSY.
>>>>
>>>> __get_user_pages squashes -EBUSY to 0, so faultin_vma_page_range returns
>>>> that to madvise_populate.  Unfortunately, madvise_populate increments
>>>> its loop counter by the return value (still 0) so it runs in an
>>>> infinite loop.  The only way out is SIGKILL.
>>>
>>> That's certainly unexpected. One user I know is QEMU, which primarily
>>> uses MADV_POPULATE_WRITE to prefault page tables. Prefaulting in QEMU is
>>> primarily used with shmem/hugetlb, where I haven't heard of any such
>>> endless loops.
>>>
>>>>
>>>> So I don't know what the correct behavior is here, other than the
>>>> infinite loop seems pretty suspect.  Is it the correct behavior that
>>>> madvise_populate returns EIO if __get_user_pages ever returns zero?
>>>> That doesn't quite sound right if it's the case that a zero return could
>>>> also happen if memory is tight.
>>>
>>> madvise_populate() ends up calling faultin_vma_page_range() in a loop.
>>> That one calls __get_user_pages().
>>>
>>> __get_user_pages() documents: "0 return value is possible when the fault
>>> would need to be retried."
>>>
>>> So that's what the caller does. IIRC, there are cases where we really
>>> have to retry (at least once) and will make progress, so treating "0" as
>>> an error would be wrong.
>>>
>>> Staring at other __get_user_pages() users, __get_user_pages_locked()
>>> documents: "Please note that this function, unlike __get_user_pages(),
>>> will not return 0 for nr_pages > 0, unless FOLL_NOWAIT is used.".
>>>
>>> But there is some elaborate retry logic in there, whereby the retry will
>>> set FOLL_TRIED->FAULT_FLAG_TRIED, and I think we'd fail on the second
>>> retry attempt (there are cases where we retry more often, but that's
>>> related to something else I believe).
>>>
>>> So maybe we need a similar retry logic in faultin_vma_page_range()? Or
>>> make it use __get_user_pages_locked(), but I recall when I introduced
>>> MADV_POPULATE_READ, there was a catch to it.
>>
>> I'm trying to figure out who will be setting the VM_FAULT_SIGBUS in the
>> mmap()+access case you describe above.
>>
>> Staring at arch/x86/mm/fault.c:do_user_addr_fault(), I don't immediately see
>> how we would transition from a VM_FAULT_RETRY loop to VM_FAULT_SIGBUS.
>> Because VM_FAULT_SIGBUS would be required for that function to call
>> do_sigbus().
> 
> The code I was looking at yesterday in filemap_fault was:
> 
> page_not_uptodate:
> 	/*
> 	 * Umm, take care of errors if the page isn't up-to-date.
> 	 * Try to re-read it _once_. We do this synchronously,
> 	 * because there really aren't any performance issues here
> 	 * and we need to check for errors.
> 	 */
> 	fpin = maybe_unlock_mmap_for_io(vmf, fpin);
> 	error = filemap_read_folio(file, mapping->a_ops->read_folio, folio);
> 	if (fpin)
> 		goto out_retry;
> 	folio_put(folio);
> 
> 	if (!error || error == AOP_TRUNCATED_PAGE)
> 		goto retry_find;
> 	filemap_invalidate_unlock_shared(mapping);
> 
> 	return VM_FAULT_SIGBUS;
> 
> Wherein I /think/ fpin is non-null in this case, so if
> filemap_read_folio returns an error, we'll do this instead:
> 
> out_retry:
> 	/*
> 	 * We dropped the mmap_lock, we need to return to the fault handler to
> 	 * re-find the vma and come back and find our hopefully still populated
> 	 * page.
> 	 */
> 	if (!IS_ERR(folio))
> 		folio_put(folio);
> 	if (mapping_locked)
> 		filemap_invalidate_unlock_shared(mapping);
> 	if (fpin)
> 		fput(fpin);
> 	return ret | VM_FAULT_RETRY;
> 
> and since ret was 0 before the goto, the only return code is
> VM_FAULT_RETRY.  I had speculated that perhaps we could instead do:
> 
> 	if (fpin) {
> 		if (error)
> 			ret |= VM_FAULT_SIGBUS;
> 		goto out_retry;
> 	}
> 
> But I think the hard part here is that there doesn't seem to be any
> distinction between transient read errors (e.g. disk cable fell out) vs.
> semi-permanent errors (e.g. verity says the hash doesn't match).
> AFAICT, either the read(ahead) sets uptodate and callers read the page,
> or it doesn't set it and callers treat that as an error-retry
> opportunity.
> 
> For the transient error case VM_FAULT_RETRY makes perfect sense; for the
> second case I imagine we'd want something closer to _SIGBUS.


Agreed, it's really hard to judge when it's the right time to give up 
retrying. At least with MADV_POPULATE_READ we should try achieving the 
same behavior as with mmap()+read access. So if the latter manages to 
trigger SIGBUS, MADV_POPULATE_READ should return an error.

Is there an easy way to for me to reproduce this scenario?

-- 
Cheers,

David / dhildenb


