Return-Path: <linux-fsdevel+bounces-45618-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5750A79FD6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 11:19:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A41423B211A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 09:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CE1624418D;
	Thu,  3 Apr 2025 09:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g9u2zVaw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31572CA6
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Apr 2025 09:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743671941; cv=none; b=COW/6ik6MygnSOZFbStezGUAX0pV7wUPsO0DnfN7LkUoMFWdM3TSgsGehWm3VyLqKsY22vSQCQZr/veQYu+n/kBCrG/HwLalMvJLpxuqDU9K/3GLgi1FgDG+vf948J0Gt5AW08kT3G2ihiIvDAnpMUPt35hzhSUSJhueNrcWycY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743671941; c=relaxed/simple;
	bh=Xur9xbovK84+k4dXVBd9kT7lSd/F1YDm6MAoo8L0RsM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BiRQkRnOx9TCM0b/zb3tH389hZI8uYZQDPrTDsHlZt/ykrHX3erax8UmWeiVBOUvoxhndVYx+FvndRoszaIZoOc+HKOkCHSNuqd0v3NQHKuyg8xBUxULjab0ayQVVuwfUQem1n5Kgtk2NdKJwKh+dCW1uhX6y7XtiqQO1lCOSmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g9u2zVaw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743671938;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=qNhiJ0TVTyzy7hyORBz5mXEdNK4x/LjCdeFZeLz+l/4=;
	b=g9u2zVawb5SO5rMZHxZje3zIkO0I3ExFtmwfc8nH21yoJNjEAfnrZGvwPrACZo7LcCg5BN
	CYOz/T6fqRl1rm8q3sLmGsjPlWIDY54qM1YnBxnSj5MgYKU2BoU0g9lfPWtlTnvQjt1T1v
	OKfO+9ORvogXlThZ6K1cqVFPZaK8tKs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-414--WmxpeY1OFOseCEZ0cVqcg-1; Thu, 03 Apr 2025 05:18:55 -0400
X-MC-Unique: -WmxpeY1OFOseCEZ0cVqcg-1
X-Mimecast-MFC-AGG-ID: -WmxpeY1OFOseCEZ0cVqcg_1743671934
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43ceeaf1524so3738595e9.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Apr 2025 02:18:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743671934; x=1744276734;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qNhiJ0TVTyzy7hyORBz5mXEdNK4x/LjCdeFZeLz+l/4=;
        b=SXicUsTEQyGUKmo/ZM2OojOcpaElu5n7N7CvpZroknTLnd4zJmRte3oQzsnuz0bZXt
         D5PdAjEwCbYfHnsZTY+jyjM+9EMNG5ldwCpISzwIcgG8OTOS2Yf8g8SfVXD1YmJto9BF
         zjKRZiHPNUSQ94xpkol0N1SgMBf+LIQ3LlWHoZOLhfa6LO139MyjtUZFSyDwwP2fvjIg
         XQfsuVGtK1i63jz498tqtDOdor9OdXJJw7VqSfHGxj/Bok937cE8fUWmqS3+YsaDXaCM
         yMASPPfMzPeweDkaYSAiNYcmlZf+WeaIexU0psZAVUakhaf/Q24GIyjVt4E75x+rfI8f
         d+ng==
X-Forwarded-Encrypted: i=1; AJvYcCV3YutU91/8/rUPd0nimyaaNwgJNHTcSVqG/m2G3fhCN6p8xkt6keqaSjtV6J4CVhxdwLrtPxeYGarvF3Bn@vger.kernel.org
X-Gm-Message-State: AOJu0YzID95mKHWRwVBV24etnhMdMDOdLK1uZj5zIX73JbtvJfPxQo+x
	nTdUr0T/heulSTOggUZT70eWSqPnn9ghrlCqXxROL1aOqqtffwV+G8/0asehRZoFryUfBSlPd1w
	58J+iavRFJFVUxLm2cqzwW0kQvBlKTOoNVMUhOKacF9Ku8z5EANHQS3X5VGqK8dM=
X-Gm-Gg: ASbGncs/jynXXwemQwydwKKbX+08N2BNf2rKGlqlckkGcTZ0RRHeHNNOfxKUy0Sf7cn
	50MkXia9xOY9tz+j/c/OaRvmqLxrcN0gp4xXuPmcka3E3SI3RCo0E+yGWUAjKpSf1Q2JaJGXxLM
	4FEGi2BuCMTHmJk22mEuFZ92cfYrAoC9pwzCb+pQqCPyUwfnl+P8Bw5ZAQM2tnbKHscCzxTLc5v
	qa102nh56R8bBAU/0YZYNo04w7kOWf0He5THg4cJ5mM0RbFyBd1G6jBluzZzLibyBp3Kj6nHqEO
	SsnbiJgTbMbOptoFmdD49X36/gi2hDFMMzDof/G4SNk5
X-Received: by 2002:a05:600c:83c3:b0:43c:ed33:a500 with SMTP id 5b1f17b1804b1-43ec630446dmr11271835e9.10.1743671934239;
        Thu, 03 Apr 2025 02:18:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHjyoyF1GHQQlY2uXtE3gHeNZFz3BliaRjpJ0lsHL1dj5dQyGSumuJ7TXlq43bEhE+fmiBc1A==
X-Received: by 2002:a05:600c:83c3:b0:43c:ed33:a500 with SMTP id 5b1f17b1804b1-43ec630446dmr11271445e9.10.1743671933764;
        Thu, 03 Apr 2025 02:18:53 -0700 (PDT)
Received: from [192.168.3.141] (p4ff23029.dip0.t-ipconnect.de. [79.242.48.41])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec1630f21sm16096415e9.8.2025.04.03.02.18.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Apr 2025 02:18:53 -0700 (PDT)
Message-ID: <1577c4be-c6ee-4bc6-bb9c-d0a6d553b156@redhat.com>
Date: Thu, 3 Apr 2025 11:18:52 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/5] mm/migrate: skip migrating folios under writeback
 with AS_WRITEBACK_INDETERMINATE mappings
To: Jingbo Xu <jefflexu@linux.alibaba.com>,
 Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, shakeel.butt@linux.dev,
 josef@toxicpanda.com, bernd.schubert@fastmail.fm, linux-mm@kvack.org,
 kernel-team@meta.com, Matthew Wilcox <willy@infradead.org>,
 Zi Yan <ziy@nvidia.com>, Oscar Salvador <osalvador@suse.de>,
 Michal Hocko <mhocko@kernel.org>
References: <20241122232359.429647-1-joannelkoong@gmail.com>
 <20241122232359.429647-5-joannelkoong@gmail.com>
 <c9a76cb3-5827-4b2c-850f-8c830a090196@redhat.com>
 <CAJnrk1aXOJ-dAUdSmP07ZP6NPBJrdjPPJeaGbBULZfY=tBdn=Q@mail.gmail.com>
 <1036199a-3145-464b-8bbb-13726be86f46@linux.alibaba.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <1036199a-3145-464b-8bbb-13726be86f46@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 03.04.25 05:31, Jingbo Xu wrote:
> 
> 
> On 4/3/25 5:34 AM, Joanne Koong wrote:
>> On Thu, Dec 19, 2024 at 5:05 AM David Hildenbrand <david@redhat.com> wrote:
>>>
>>> On 23.11.24 00:23, Joanne Koong wrote:
>>>> For migrations called in MIGRATE_SYNC mode, skip migrating the folio if
>>>> it is under writeback and has the AS_WRITEBACK_INDETERMINATE flag set on its
>>>> mapping. If the AS_WRITEBACK_INDETERMINATE flag is set on the mapping, the
>>>> writeback may take an indeterminate amount of time to complete, and
>>>> waits may get stuck.
>>>>
>>>> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
>>>> Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>
>>>> ---
>>>>    mm/migrate.c | 5 ++++-
>>>>    1 file changed, 4 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/mm/migrate.c b/mm/migrate.c
>>>> index df91248755e4..fe73284e5246 100644
>>>> --- a/mm/migrate.c
>>>> +++ b/mm/migrate.c
>>>> @@ -1260,7 +1260,10 @@ static int migrate_folio_unmap(new_folio_t get_new_folio,
>>>>                 */
>>>>                switch (mode) {
>>>>                case MIGRATE_SYNC:
>>>> -                     break;
>>>> +                     if (!src->mapping ||
>>>> +                         !mapping_writeback_indeterminate(src->mapping))
>>>> +                             break;
>>>> +                     fallthrough;
>>>>                default:
>>>>                        rc = -EBUSY;
>>>>                        goto out;
>>>
>>> Ehm, doesn't this mean that any fuse user can essentially completely
>>> block CMA allocations, memory compaction, memory hotunplug, memory
>>> poisoning... ?!
>>>
>>> That sounds very bad.
>>
>> I took a closer look at the migration code and the FUSE code. In the
>> migration code in migrate_folio_unmap(), I see that any MIGATE_SYNC
>> mode folio lock holds will block migration until that folio is
>> unlocked. This is the snippet in migrate_folio_unmap() I'm looking at:
>>
>>          if (!folio_trylock(src)) {
>>                  if (mode == MIGRATE_ASYNC)
>>                          goto out;
>>
>>                  if (current->flags & PF_MEMALLOC)
>>                          goto out;
>>
>>                  if (mode == MIGRATE_SYNC_LIGHT && !folio_test_uptodate(src))
>>                          goto out;
>>
>>                  folio_lock(src);
>>          }
>>

Right, I raised that also in my LSF/MM talk: waiting for readahead 
currently implies waiting for the folio lock (there is no separate 
readahead flag like there would be for writeback).

The more I look into this and fuse, the more I realize that what fuse 
does is just completely broken right now.

>> If this is all that is needed for a malicious FUSE server to block
>> migration, then it makes no difference if AS_WRITEBACK_INDETERMINATE
>> mappings are skipped in migration. A malicious server has easier and
>> more powerful ways of blocking migration in FUSE than trying to do it
>> through writeback. For a malicious fuse server, we in fact wouldn't
>> even get far enough to hit writeback - a write triggers
>> aops->write_begin() and a malicious server would deliberately hang
>> forever while the folio is locked in write_begin().
> 
> Indeed it seems possible.  A malicious FUSE server may already be
> capable of blocking the synchronous migration in this way.

Yes, I think the conclusion is that we should advise people from not 
using unprivileged FUSE if they care about any features that rely on 
page migration or page reclaim.

> 
> 
>>
>> I looked into whether we could eradicate all the places in FUSE where
>> we may hold the folio lock for an indeterminate amount of time,
>> because if that is possible, then we should not add this writeback way
>> for a malicious fuse server to affect migration. But I don't think we
>> can, for example taking one case, the folio lock needs to be held as
>> we read in the folio from the server when servicing page faults, else
>> the page cache would contain stale data if there was a concurrent
>> write that happened just before, which would lead to data corruption
>> in the filesystem. Imo, we need a more encompassing solution for all
>> these cases if we're serious about preventing FUSE from blocking
>> migration, which probably looks like a globally enforced default
>> timeout of some sort or an mm solution for mitigating the blast radius
>> of how much memory can be blocked from migration, but that is outside
>> the scope of this patchset and is its own standalone topic.

I'm still skeptical about timeouts: we can only get it wrong.

I think a proper solution is making these pages movable, which does seem 
feasible if (a) splice is not involved and (b) we can find a way to not 
hold the folio lock forever e.g., in the readahead case.

Maybe readahead would have to be handled more similar to writeback 
(e.g., having a separate flag, or using a combination of e.g., 
writeback+uptodate flag, not sure)

In both cases (readahead+writeback), we'd want to call into the FS to 
migrate a folio that is under readahread/writeback. In case of fuse 
without splice, a migration might be doable, and as discussed, splice 
might just be avoided.

>>
>> I don't see how this patch has any additional negative impact on
>> memory migration for the case of malicious servers that the server
>> can't already (and more easily) do. In fact, this patchset if anything
>> helps memory given that malicious servers now can't also trigger page
>> allocations for temp pages that would never get freed.
>>
> 
> If that's true, maybe we could drop this patch out of this patchset? So
> that both before and after this patchset, synchronous migration could be
> blocked by a malicious FUSE server, while the usability of continuous
> memory (CMA) won't be affected.

I had exactly the same thought: if we can block forever on the folio 
lock, there is no need for AS_WRITEBACK_INDETERMINATE. It's already all 
completely broken.

-- 
Cheers,

David / dhildenb


