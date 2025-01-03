Return-Path: <linux-fsdevel+bounces-38369-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 997C6A00ED2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Jan 2025 21:31:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A5813A4225
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Jan 2025 20:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49DE61BEF7F;
	Fri,  3 Jan 2025 20:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AbV58Thd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767A11BD9FA
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Jan 2025 20:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735936284; cv=none; b=T2yQ/1CAMPnwPUgdOGVJVJofsKZifUwkXhQvSfkngo/UafDfvJBqBON84pfDEneDP4fzTPgMYb6rzb++WORB5I7y5NE9cjJzh24R+AQ+nlHzNaPx2QNzLZY+RmD7QD+7UcKEgngXBoopTWs8VbuQrPb5wbrOgwyOeib+vD7Icsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735936284; c=relaxed/simple;
	bh=B1d7O2PbvUe/BuE8g+IwO55+/nfEFMLwiAXk7tDBNEc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WbfQoSjkIvq2mdDud7Q7PvuxfEO4+xo9fu6Hgks+yWNEDkwVSNZgIj+j9fVnvLQi2Tz/xkgxYINL0gRdWuNvixIw1+yNOdephyhakKng3q8Sn5AeM15vgZnj6BxBIrEZ+KaR3HTLUwCYCenAE7XBSWN3V6m/NitEgNFfgIqexIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AbV58Thd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1735936280;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=gOq32L/IS4PMcxXQ+tZF3hPapwZnw44sjmuP2kXJj68=;
	b=AbV58Thd281A8t6XoHlXxfxAE3X1DgRB6j/InYMsooFfbayof0v6dimKBt04VCUQ2rSa4k
	ptlZMug6dV7kasnlqLWF3SwHBihN1xjAXBFXVlsplVvIhcDk+Ztr4dSRH4LHHA3FBCM3VY
	Rf6G45lpKH8Ikia4TmVb+PI7pmTkZcY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-245-mrGEB79iPP6cEdigLwhZgQ-1; Fri, 03 Jan 2025 15:31:18 -0500
X-MC-Unique: mrGEB79iPP6cEdigLwhZgQ-1
X-Mimecast-MFC-AGG-ID: mrGEB79iPP6cEdigLwhZgQ
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3862a49fbdaso2313734f8f.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 Jan 2025 12:31:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735936277; x=1736541077;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gOq32L/IS4PMcxXQ+tZF3hPapwZnw44sjmuP2kXJj68=;
        b=iRJmCarNi5KtDvCfH8nbTo25hGIa9sB608pv/tKhZqV42cFHFcv5EJZ7r7LDfojilX
         6ecrLheKlPXNrcntPKsg5Ou2xkhGJp3vXP8zfl7GNzYFDRBi4QTbUqNvoyqrrmoOqWzh
         p+t/CcE8PrsrOX0+jOYPXFKuyo84VQchJ6eAHuUU8p1Yfw5mtPTwjTELqN8GtpAlUako
         OR4Yl9NSKtAnWH1/47NAepAs8s/EmYy2InEIm0ZxhGqfcWWySBlGnt5VkTIqEIkDJ5H5
         CfrV6qmHajJE+X3t0OWUxupFyh2mliiCqvCMQLo4YiO9Ynv44w3WJiHYOJXmeFDvvypi
         wS/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXhIVsuTe33C2SyAGKlffqknSB4XmwibJrUZvwsK5DPJ6s7YZoYTPuc4KeLdCTii3PTXtV6jelS8svPQ39X@vger.kernel.org
X-Gm-Message-State: AOJu0YyhdK+ivnJIGYCZdIkCy3MdoFJsbB/ZDN7MZG0ZqdULpSnsF4HT
	1uRHLM7MJi2jTabwcv8fL+yT2z7JUrmAbHf3jYTV7f7azRr/JP/kOqg0wKqo8RKM86J+S/+1DIR
	Dpo6psSp4eM2siHhnHoAZGhE1cFyuiVQvh8fQBsAs7nRY9kw2TGEPEjq1snQyoIs=
X-Gm-Gg: ASbGncu8h9q6UNrEX5mf52rEdVhXbeXe/tZDE3BeISN9j3uUMKslnN1M18CJBeHI0eu
	iOOI76zdxcwGK0U6Imfsmlvpi+wVF384PK8OoFx+bveiFIOwFRPUKaxQBXh8b7MXFwvHABmPipB
	WlpdVB6KO3Zv7a/qhSSmm9o13cWAvD2Y3ZVmc1M6Io4JvDjE4jo2DSZiKA6gIjTB5fXRV25n9q4
	w2XBtK3kiIUiCqYxZy9x4hG1RgzjBbELMs0zDILiOqgc88mmLOEvCHbKWsAsW6zoFjVBCtUZW/W
	fzUogRFTGWizmcP3KXNSLulkVYoS5rhrt9cpWIr/kZxeifhdAnrySdLs1HIBfZDcALmquCy+bwG
	85vtnrQ==
X-Received: by 2002:a05:6000:1446:b0:385:fae4:424e with SMTP id ffacd0b85a97d-38a22408624mr37215423f8f.52.1735936277560;
        Fri, 03 Jan 2025 12:31:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IExiagRGnbiL52KsLcIjqXIht5dupd1jEjvaVynu3Bb+9s4SJvjFvjbpPMRfcbIR+8FZkjWig==
X-Received: by 2002:a05:6000:1446:b0:385:fae4:424e with SMTP id ffacd0b85a97d-38a22408624mr37215405f8f.52.1735936277152;
        Fri, 03 Jan 2025 12:31:17 -0800 (PST)
Received: from ?IPV6:2003:cb:c73d:3300:9bad:96b:3e57:65bc? (p200300cbc73d33009bad096b3e5765bc.dip0.t-ipconnect.de. [2003:cb:c73d:3300:9bad:96b:3e57:65bc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a28f17315sm36058478f8f.108.2025.01.03.12.31.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jan 2025 12:31:15 -0800 (PST)
Message-ID: <c04b73a2-b33e-4306-afb9-0fab8655615b@redhat.com>
Date: Fri, 3 Jan 2025 21:31:13 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/5] mm/migrate: skip migrating folios under writeback
 with AS_WRITEBACK_INDETERMINATE mappings
To: Joanne Koong <joannelkoong@gmail.com>,
 Shakeel Butt <shakeel.butt@linux.dev>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>, Zi Yan <ziy@nvidia.com>,
 miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
 jefflexu@linux.alibaba.com, josef@toxicpanda.com, linux-mm@kvack.org,
 kernel-team@meta.com, Matthew Wilcox <willy@infradead.org>,
 Oscar Salvador <osalvador@suse.de>, Michal Hocko <mhocko@kernel.org>
References: <b16bff80-758c-451b-a96c-b047f446f992@fastmail.fm>
 <9404aaa2-4fc2-4b8b-8f95-5604c54c162a@redhat.com>
 <qsytb6j4j6v7kzmiygmmsrdgfkwszpjudvwbq5smkhowfd75dd@beks3genju7x>
 <3f3c7254-7171-4987-bb1b-24c323e22a0f@redhat.com>
 <kyn5ji73biubd5fqbpycu4xsheqvomb3cu45ufw7u2paj5rmhr@bhnlclvuujcu>
 <c91b6836-fa30-44a9-bc15-afc829acaba9@redhat.com>
 <h3jbqkgaatads2732mzoyucjmin6rakzsvkjvdaw2xzjlieapc@k6r7xywaeozg>
 <0ed5241e-10af-43ee-baaf-87a5b4dc9694@redhat.com>
 <CAJnrk1ZYV3hXz_fdssk=tCWPzD_fpHyMW1L_+VRJtK8fFGD-1g@mail.gmail.com>
 <446704ab-434e-45ac-a062-45fef78815e4@redhat.com>
 <hftauqdz22ujgkkgrf6jbpxuubfoms42kn5l5nuft3slfp7eaz@yy6uslmp37pn>
 <CAJnrk1aPCCjbKm+Ay9dz3HezCFehKDfsDidgsRyAMzen8Dk=-w@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAJnrk1aPCCjbKm+Ay9dz3HezCFehKDfsDidgsRyAMzen8Dk=-w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 02.01.25 19:54, Joanne Koong wrote:
> On Mon, Dec 30, 2024 at 12:11 PM Shakeel Butt <shakeel.butt@linux.dev> wrote:
>>
>> On Mon, Dec 30, 2024 at 08:52:04PM +0100, David Hildenbrand wrote:
>>>
>> [...]
>>>> I'm looking back at some of the discussions in v2 [1] and I'm still
>>>> not clear on how memory fragmentation for non-movable pages differs
>>>> from memory fragmentation from movable pages and whether one is worse
>>>> than the other. Currently fuse uses movable temp pages (allocated with
>>>> gfp flags GFP_NOFS | __GFP_HIGHMEM), and these can run into the same
>>>
>>> Why are they movable? Do you also specify __GFP_MOVABLE?
>>>
>>> If not, they are unmovable and are never allocated from
>>> ZONE_MOVABLE/MIGRATE_CMA -- and usually only from MIGRATE_UNMOVBALE, to
>>> group these unmovable pages.
>>>
>>
>> Yes, these temp pages are non-movable. (Must be a typo in Joanne's
>> email).
> 
> Sorry for the confusion, that should have been "non-movable temp pages".
> 
>>
>> [...]
>>>
>>> I assume not regarding fragmentation.
>>>
>>>
>>> In general, I see two main issues:
>>>
>>> A) We are no longer waiting on writeback, even though we expect in sane
>>> environments that writeback will happen and we it might be worthwhile to
>>> just wait for writeback so we can migrate these folios.
>>>
>>> B) We allow turning movable pages to be unmovable, possibly forever/long
>>> time, and there is no way to make them movable again (e.g., cancel
>>> writeback).
>>>
>>>
>>> I'm wondering if A) is actually a new issue introduced by this change. Can
>>> folios with busy temp pages (writeback cleared on folio, but temp pages are
>>> still around) be migrated? I will look into some details once I'm back from
>>> vacation.
>>>
> 
> Folios with busy temp pages can be migrated since fuse will clear
> writeback on the folio immediately once it's copied to the temp page.

I was rather wondering if there is something else that prevents 
migrating these folios: for example, if there is a raised refcount on 
the folio while the temp pages exist. If that is not the case, then it 
should indeed just work.

> 
> To me, these two issues seem like one and the same. No longer waiting
> on writeback renders it unmovable, which prevents
> compaction/migration.
> 
>>
>> My suggestion is to just drop the patch related to A as it is not
>> required for deadlock avoidance. For B, I think we need a long term
>> solution which is usable by other filesystems as well.
> 
> Sounds good. With that, we need to take this patchset out of
> mm-unstable or this could lead to migration infinitely waiting on
> folio writeback without the migrate patch there.

I want to try triggering it with NFS next week when I am back from PTO, 
to see if it is indeed a problem there as well on connection loss.

In any case, having movable pages be turned unmovable due to persistent 
writaback is something that must be fixed, not worked around. Likely a 
good topic for LSF/MM.

-- 
Cheers,

David / dhildenb


