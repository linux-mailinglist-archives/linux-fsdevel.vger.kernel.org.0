Return-Path: <linux-fsdevel+bounces-54275-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B9C9AFD00C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 18:05:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 837551AA0958
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 16:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C4FD2E49BD;
	Tue,  8 Jul 2025 16:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QJN0FcJw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60E82E4990
	for <linux-fsdevel@vger.kernel.org>; Tue,  8 Jul 2025 16:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751990732; cv=none; b=Is8lXOJQIEwJ3aKuF+B2E3HiAr8bnGyroOooWQ6bOTd6QqDkpDznja/XRAeqAn0VeD9dIxf7p+4T83vGwNHXV+XvQC516uRFtw42vnYK2m4jhfT4N3X+YnFSnWHLi4wqhlq8iMeccfV7V0SFCx1+U6qW2nb3KnBvhwhaUSJfc8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751990732; c=relaxed/simple;
	bh=Ivaf82r/5al4a/Ko5ZmI7j9dQkIXR0So99MV7x75R3o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gT1BA7a+GNnljQIq2GCTtW3p2SBaOyCTHY9ymtPZVQ1oBJrpue7Rv/79OfU141D1q8OJLpF37vfddihWkAJZm7ofCFAFoQkKM2O+Oo63B1VTYeN3wWNNnQoY5GNFyhC8ZZhcr36ohXVJXGllPi3R+bpjNfHtPRY3wI5RKXxyNAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QJN0FcJw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751990729;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=RfKqlWUTFAkcKT9jQrl6R7QcQLX9jXEn+qIoPM5GIlk=;
	b=QJN0FcJwcqDf6o6fKUklDMywgAbn7GA1ZhJY7Ms1NLgShgsHCRQ+PYPLF5R7YLL2/n6xYw
	8/nsGP7tR696dYbdAN7MPhpDdace4cqOjD+Wbbl0YasLfNtC6ykgwnVPJWIwfL3wkKKLla
	sK+V+x7QzKkJ056VHVpp7/YuiOSd8a8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-489-JvHPkBklOfyPgEw8h3pXPQ-1; Tue, 08 Jul 2025 12:05:27 -0400
X-MC-Unique: JvHPkBklOfyPgEw8h3pXPQ-1
X-Mimecast-MFC-AGG-ID: JvHPkBklOfyPgEw8h3pXPQ_1751990726
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a579058758so1887840f8f.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Jul 2025 09:05:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751990726; x=1752595526;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RfKqlWUTFAkcKT9jQrl6R7QcQLX9jXEn+qIoPM5GIlk=;
        b=dh2gG86mt6UUkPvmN6qiJFkSXqh0VmyPOJr3lZaywc2Hkwax7+4hi9gjmw/55c1pSn
         HOI263rC6cQ3ngZFQNpMYzks2lLa0uxcD90Hi4H5sc/CtppbyvvX384EKKC4cf3lvPgU
         1yUh6U5DGkxu0h7HwxK/0QXZME491lkijfrTluTMVt7Jzyh8p34Ya5lHsfeABmIqgC+t
         kmC4k5SuLiB144nt/pzP+KbTJqExXspAkDNu5q8u5DPOa8s+o2GEKzFJNmNq+YU+WvAm
         55tSnPRlynb/IqazknDzxtY/LvCSeOyJGjfOZataQYVfkzOdz7E3PZM0amH/AGiNxDn2
         teKw==
X-Forwarded-Encrypted: i=1; AJvYcCUbieOe5jXREqu9QrHzIQTjGjgDp6yJA/OcmD2Atloa+v54U7DlCaXx7fTYOeWu8z0vL1H6ZXnFwO+YuN2T@vger.kernel.org
X-Gm-Message-State: AOJu0YzryReNTTxEDB0KirL9kubOTZjOdxQfVvFNP/OHlFXWvLg6pP3j
	XBE+aj3oPbzj39hHL3+prKPLIsfhq7QE058vbPZIwiUxVy6w/6Od6x8pRZ+xaoE/JeTcO4A19Wx
	aJUsxOkw1r6tzIr/+glzOZiOBWZ3/lTfNFsacEOcuOcYII4hBLWXjE4I6XZYrPqV+ges=
X-Gm-Gg: ASbGncvcFbHH5Objr8iqSbt9dvcjeWjLB87/3bsuIpWBDllSTUoH9JRQhY1AdnY95OC
	TwnQaOplTYQBsQZvkGOM9p+FTZZ1/MFo+OCdOT4ZQ55jJfhaR6LwRi2j2nIlTyw9QuYtnIDggRo
	uJOOVLJ0FFEOHY3kEO4jwb7VZQw7xtz/r6pRMJF9xcC9GiGNVdopdGE9P4Cgj/0pV8EegWKPL4v
	UQi40AOOR9UPEODB1boV+1dpbl7n0rQDobQ8hU4bN4dRK6t0EtzddQtxO0D9wgjGv7sVCFLiqGr
	rbmpRifdaTOvY4EtOdO88lBwue6DzO81VOo2M08QK1NzDaJyft8aCX23VKY9NO3y/yMSBj3ke73
	3GPvql43y9FnLad/jHm1eGEetmO8I+1zFjEnHiH3Oxq9RjkhmhA==
X-Received: by 2002:adf:e19d:0:b0:3b2:dfc6:2485 with SMTP id ffacd0b85a97d-3b4964bb5ebmr12557744f8f.4.1751990725644;
        Tue, 08 Jul 2025 09:05:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFbZuDLVzHNAlTn8wV7RBmZDNOEu/3BxQ2D0H2GX6nrqGOQevN9AOG9GkpARfoLY8UJ+9I9PA==
X-Received: by 2002:adf:e19d:0:b0:3b2:dfc6:2485 with SMTP id ffacd0b85a97d-3b4964bb5ebmr12557678f8f.4.1751990724978;
        Tue, 08 Jul 2025 09:05:24 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f1a:f500:4346:f17c:2bde:808c? (p200300d82f1af5004346f17c2bde808c.dip0.t-ipconnect.de. [2003:d8:2f1a:f500:4346:f17c:2bde:808c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b4708d0959sm13336298f8f.27.2025.07.08.09.05.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 09:05:24 -0700 (PDT)
Message-ID: <9a9cea9e-82e7-4411-8927-8ac911b2eb06@redhat.com>
Date: Tue, 8 Jul 2025 18:05:23 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 10/11] fuse: optimize direct io large folios processing
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, jlayton@kernel.org,
 jefflexu@linux.alibaba.com, josef@toxicpanda.com,
 bernd.schubert@fastmail.fm, willy@infradead.org, kernel-team@meta.com
References: <20250426000828.3216220-1-joannelkoong@gmail.com>
 <20250426000828.3216220-11-joannelkoong@gmail.com>
 <6d9c08dd-c1d0-48bd-aacb-b4300f87d525@redhat.com>
 <CAJnrk1bTe88hy4XSkj1RSC4r+oA=VZ-=jKymt7uoB1q75KZCYg@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAJnrk1bTe88hy4XSkj1RSC4r+oA=VZ-=jKymt7uoB1q75KZCYg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 08.07.25 01:27, Joanne Koong wrote:
> On Fri, Jul 4, 2025 at 3:24 AM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 26.04.25 02:08, Joanne Koong wrote:
>>> Optimize processing folios larger than one page size for the direct io
>>> case. If contiguous pages are part of the same folio, collate the
>>> processing instead of processing each page in the folio separately.
>>>
>>> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
>>> Reviewed-by: Jeff Layton <jlayton@kernel.org>
>>> ---
>>>    fs/fuse/file.c | 55 +++++++++++++++++++++++++++++++++++++-------------
>>>    1 file changed, 41 insertions(+), 14 deletions(-)
>>>
>>> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
>>> index 9a31f2a516b9..61eaec1c993b 100644
>>> --- a/fs/fuse/file.c
>>> +++ b/fs/fuse/file.c
>>> @@ -1490,7 +1490,8 @@ static int fuse_get_user_pages(struct fuse_args_pages *ap, struct iov_iter *ii,
>>>        }
>>>
>>>        while (nbytes < *nbytesp && nr_pages < max_pages) {
>>> -             unsigned nfolios, i;
>>> +             struct folio *prev_folio = NULL;
>>> +             unsigned npages, i;
>>>                size_t start;
>>>
>>>                ret = iov_iter_extract_pages(ii, &pages,
>>> @@ -1502,23 +1503,49 @@ static int fuse_get_user_pages(struct fuse_args_pages *ap, struct iov_iter *ii,
>>>
>>>                nbytes += ret;
>>>
>>> -             nfolios = DIV_ROUND_UP(ret + start, PAGE_SIZE);
>>> +             npages = DIV_ROUND_UP(ret + start, PAGE_SIZE);
>>>
>>> -             for (i = 0; i < nfolios; i++) {
>>> -                     struct folio *folio = page_folio(pages[i]);
>>> -                     unsigned int offset = start +
>>> -                             (folio_page_idx(folio, pages[i]) << PAGE_SHIFT);
>>> -                     unsigned int len = min_t(unsigned int, ret, PAGE_SIZE - start);
>>> +             /*
>>> +              * We must check each extracted page. We can't assume every page
>>> +              * in a large folio is used. For example, userspace may mmap() a
>>> +              * file PROT_WRITE, MAP_PRIVATE, and then store to the middle of
>>> +              * a large folio, in which case the extracted pages could be
>>> +              *
>>> +              * folio A page 0
>>> +              * folio A page 1
>>> +              * folio B page 0
>>> +              * folio A page 3
>>> +              *
>>> +              * where folio A belongs to the file and folio B is an anonymous
>>> +              * COW page.
>>> +              */
>>> +             for (i = 0; i < npages && ret; i++) {
>>> +                     struct folio *folio;
>>> +                     unsigned int offset;
>>> +                     unsigned int len;
>>> +
>>> +                     WARN_ON(!pages[i]);
>>> +                     folio = page_folio(pages[i]);
>>> +
>>> +                     len = min_t(unsigned int, ret, PAGE_SIZE - start);
>>> +
>>> +                     if (folio == prev_folio && pages[i] != pages[i - 1]) {
>>
>> I don't really understand the "pages[i] != pages[i - 1]" part.
>>
>> Why would you have to equal page pointers in there?
>>
> 
> The pages extracted are user pages from a userspace iovec. AFAICT,
> there's the possibility, eg if userspace mmaps() the file with
> copy-on-write, that the same physical page could back multiple
> contiguous virtual addresses.

Yes, I but I was rather curious why that would be a condition we are 
checking. It's quite the ... corner case :)

> 
>>
>> Something that might be simpler to understand and implement would be using
>>
>>          num_pages_contiguous()
>>
>> from
>>
>>          https://lore.kernel.org/all/20250704062602.33500-2-lizhe.67@bytedance.com/T/#u
>>
>> and then just making sure that we don't exceed the current folio, if we
>> ever get contiguous pages that cross a folio.
> 
> Thanks for the link. I think here it's common that the pages array
> would hold pages from multiple different folios, so maybe a new helper
> num_pages_contiguous_folio() would be useful to return back the number
> of contiguous pages that are within the scope of the same folio.

Yes, something like that can be useful.

-- 
Cheers,

David / dhildenb


