Return-Path: <linux-fsdevel+bounces-23906-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1F68934A71
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2024 10:51:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 581A828A4A4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2024 08:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB4557D071;
	Thu, 18 Jul 2024 08:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UL3Lz5fn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA8F78C7F
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jul 2024 08:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721292659; cv=none; b=V/uwnKcj6DHR2JXvVlWzHcDcBqfTVKYSi7VyYruWFU+gNdrrnI/yWDV+yi57JR3vlgmzEkFEYX+LOlqrBiBjVaNReQwsJormSHi0NJwyFdctiWQlJ25g86JAQzOIk+6QsUBYEJGQoSCpQaINNEcG3/HLoORqWwzJlABqciZ0uSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721292659; c=relaxed/simple;
	bh=VPu62giElvSUJKmPo2jdxFfPi7JYDtl3cgHfi6gxuFk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bMnnAktZZQVfXquAxQgCEDgn3Rg8sH6XtP/vQl2AirEeaP++flFlKSgLg58fuUCEu7Fy/1e/NQ5Ep3SUthIF2VLjQHJDwnyJjOULdMurphrqU/Hr3zX7Z5aizxJQnB4V1PfXUK2TRIbFwIz9YNNYe8t92+Z034VMLHZllS7e51s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UL3Lz5fn; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2eede876fbfso8289831fa.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jul 2024 01:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1721292655; x=1721897455; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=aUXyH26QNSmClAbWu6W2K8UP580WeU1e6kGYqEWCyBc=;
        b=UL3Lz5fnjpXWxruFOrin4uyehMFBc6+/B+ylHg3kT4P38jHafz+2dTf9aAnhB07MYc
         ucjPCCgeicJKpqxVLhCr6qJ/j8Oqu+0Md/QG3qTIni+wl+HRnoHL1yRxccCtBgBry3CN
         NxZcMCA/xskNiVd9eRKfT32cCT+K2KVFNGVSnRoK87ev6Ev017MCg83nhHiA7H+GtIUn
         3nmPPkyU742PEnqXQj6MAZvo5UqQuP7iV9LTzbi3p6MiTADIN8xmJH1A04Y25uOmsmeQ
         f2/ueuT9jzlUf011X8R9Kg3UmCSPBr5bHdo+T+Y9BFmC+jPeOgHePEbhNDjfe6q9uEtu
         UFWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721292655; x=1721897455;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aUXyH26QNSmClAbWu6W2K8UP580WeU1e6kGYqEWCyBc=;
        b=Ra0eSa1bgslcw6al3IYbPPUrepr3XenpKMI2TyG5NKQF65nyv3KBssDyv78+qzBXJo
         zXguncz/eOEdOeVmCFHtIG11aBG+Wd1sHUlOzw3kAb+LhFZ3GSugKCyNgnQW/mbqfpEW
         MqghZEBY1cM+TtCSmH67NV/sMLe7I3giG51uRDKauxA2wM6DwHl0tWEqWOK9pw9v6G9+
         4CJ0j+wIJdFz0Soh97IqGjrS2zta/mjNX9xEaLOOxaV54C7lgXXWNTDqOi8nIKBlyqFa
         T/W+EJHCsuLMCwfEx1MnudS+w01auZIhMIQTXR2jydDl+J5G/jKZtvDttnF8TjU4HZ2v
         oMdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXEmQ1Wm6LTN3LN6atuIVnizoQRe7D9M+JoySflUAQdhQj7rTU3sYsy+CvwDxzo/FIGZSMJIl/zTlUVhZy3RhcGOQEYJy/WqpQd8kd+Jg==
X-Gm-Message-State: AOJu0YyPqeTgtO3upLfp0/hbtTNCxv/agU0yUWpE8606fTgNlAT0HMKD
	NwB4JoKbK5/ltEQoXdKQUjW2udMuJUIILO+T5baLYkmBiLVZeq/xJL3Og4eWN9Y=
X-Google-Smtp-Source: AGHT+IGhsQ8lEw/txY+HPUhGhnwqdejZRwl/YC9UMsP50V4lGYEbG7/8EsXBTOPhcMRIw3DDB6FHXA==
X-Received: by 2002:a05:651c:1542:b0:2ee:8777:f87a with SMTP id 38308e7fff4ca-2ef05ca17b5mr13735131fa.29.1721292654698;
        Thu, 18 Jul 2024 01:50:54 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bc274edsm87809815ad.154.2024.07.18.01.50.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jul 2024 01:50:54 -0700 (PDT)
Message-ID: <2b48a095-97e6-43bc-9f7c-13dd31ce00b8@suse.com>
Date: Thu, 18 Jul 2024 18:20:47 +0930
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] mm: skip memcg for certain address space
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
 Qu Wenruo <quwenruo.btrfs@gmx.com>, Michal Hocko <mhocko@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 Cgroups <cgroups@vger.kernel.org>, Matthew Wilcox <willy@infradead.org>
References: <cover.1720572937.git.wqu@suse.com>
 <8faa191c-a216-4da0-a92c-2456521dcf08@kernel.org>
 <Zpft2A_gzfAYBFfZ@tiehlicka> <9c0d7ce7-b17d-4d41-b98a-c50fd0c2c562@gmx.com>
 <9572fc2b-12b0-41a3-82dc-bb273bfdd51d@kernel.org>
 <3cc3e652-e058-4995-8347-337ae605ebab@suse.com>
 <ea6cfaf6-bdb8-48a4-bf59-9f54f36b112e@kernel.org>
Content-Language: en-US
From: Qu Wenruo <wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJjTSJVBQkNOgemAAoJEMI9kfOh
 Jf6oapEH/3r/xcalNXMvyRODoprkDraOPbCnULLPNwwp4wLP0/nKXvAlhvRbDpyx1+Ht/3gW
 p+Klw+S9zBQemxu+6v5nX8zny8l7Q6nAM5InkLaD7U5OLRgJ0O1MNr/UTODIEVx3uzD2X6MR
 ECMigQxu9c3XKSELXVjTJYgRrEo8o2qb7xoInk4mlleji2rRrqBh1rS0pEexImWphJi+Xgp3
 dxRGHsNGEbJ5+9yK9Nc5r67EYG4bwm+06yVT8aQS58ZI22C/UeJpPwcsYrdABcisd7dddj4Q
 RhWiO4Iy5MTGUD7PdfIkQ40iRcQzVEL1BeidP8v8C4LVGmk4vD1wF6xTjQRKfXHOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJjTSJuBQkNOge/AAoJEMI9kfOhJf6o
 rq8H/3LJmWxL6KO2y/BgOMYDZaFWE3TtdrlIEG8YIDJzIYbNIyQ4lw61RR+0P4APKstsu5VJ
 9E3WR7vfxSiOmHCRIWPi32xwbkD5TwaA5m2uVg6xjb5wbdHm+OhdSBcw/fsg19aHQpsmh1/Q
 bjzGi56yfTxxt9R2WmFIxe6MIDzLlNw3JG42/ark2LOXywqFRnOHgFqxygoMKEG7OcGy5wJM
 AavA+Abj+6XoedYTwOKkwq+RX2hvXElLZbhYlE+npB1WsFYn1wJ22lHoZsuJCLba5lehI+//
 ShSsZT5Tlfgi92e9P7y+I/OzMvnBezAll+p/Ly2YczznKM5tV0gboCWeusM=
In-Reply-To: <ea6cfaf6-bdb8-48a4-bf59-9f54f36b112e@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/7/18 17:58, Vlastimil Babka (SUSE) 写道:
> On 7/18/24 9:52 AM, Qu Wenruo wrote:
>>
>>
>> 在 2024/7/18 16:47, Vlastimil Babka (SUSE) 写道:
>>> On 7/18/24 12:38 AM, Qu Wenruo wrote:
>> [...]
>>>> Another question is, I only see this hang with larger folio (order 2 vs
>>>> the old order 0) when adding to the same address space.
>>>>
>>>> Does the folio order has anything related to the problem or just a
>>>> higher order makes it more possible?
>>>
>>> I didn't spot anything in the memcg charge path that would depend on the
>>> order directly, hm. Also what kernel version was showing these soft lockups?
>>
>> The previous rc kernel. IIRC it's v6.10-rc6.
>>
>> But that needs extra btrfs patches, or btrfs are still only doing the
>> order-0 allocation, then add the order-0 folio into the filemap.
>>
>> The extra patch just direct btrfs to allocate an order 2 folio (matching
>> the default 16K nodesize), then attach the folio to the metadata filemap.
>>
>> With extra coding handling corner cases like different folio sizes etc.
> 
> Hm right, but the same code is triggered for high-order folios (at least for
> user mappable page cache) today by some filesystems AFAIK, so we should be
> seeing such lockups already? btrfs case might be special that it's for the
> internal node as you explain, but that makes no difference for
> filemap_add_folio(), right? Or is it the only user with GFP_NOFS? Also is
> that passed as gfp directly or are there some extra scoped gfp resctrictions
> involved? (memalloc_..._save()).

I'm not sure about other fses, but for that hang case, it's very 
metadata heavy, and ALL folios for that btree inode filemap is in order 
2, since we're always allocating the order folios using GFP_NOFAIL, and 
attaching that folio into the filemap using GFP_NOFAIL too.

Not sure if other fses can have such situation.

[...]
>> If I understand it correctly, we have implemented release_folio()
>> callback, which does the btrfs metadata checks to determine if we can
>> release the current folio, and avoid releasing folios that's still under
>> IO etc.
> 
> I see, thanks. Sounds like there might be potentially some suboptimal
> handling in that the folio will appear inactive because there's no
> references that folio_check_references() can detect, unless there's some
> folio_mark_accessed() calls involved (I see some FGP_ACCESSED in btrfs so
> maybe that's fine enough) so reclaim could consider it often, only to be
> stopped by release_folio failing.

For the page accessed part, btrfs handles it by 
mark_extent_buffer_accessed() call, and it's called every time we try to 
grab an extent buffer structure (the structure used to represent a 
metadata block inside btrfs).

So the accessed flag part should be fine I guess?

Thanks,
Qu
> 
>>>
>>> (sorry if the questions seem noob, I'm not that much familiar with the page
>>> cache side of mm)
>>
>> No worry at all, I'm also a newbie on the whole mm part.
>>
>> Thanks,
>> Qu
>>
>>>
>>>> Thanks,
>>>> Qu
>>>
> 

