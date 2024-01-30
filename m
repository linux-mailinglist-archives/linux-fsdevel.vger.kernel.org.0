Return-Path: <linux-fsdevel+bounces-9516-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D294E8421AF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 11:43:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 864C028AC94
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 10:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF9F565BD1;
	Tue, 30 Jan 2024 10:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JbsS9ZAN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B424F605B4
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jan 2024 10:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706611409; cv=none; b=uJ+0CY8Jh+MC95VEhZqGrwLcucMkIqsTeG7uCpfG0iDNZL/ShRZsDKB7Np1Mt+3legg5uOKBDcwreKaU/YKg8sCWjCtwitG4REwFfjmgRq5/eGNM0+xV+AAPwJnpL0G72QLQFCH/cThGuLlTomIIGFEg9rA6hu0yxBq0vDOQySI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706611409; c=relaxed/simple;
	bh=owkU35HiBe4EUW9bL/iY9553g7P8YyHRpTmmFYvFxTA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aM3fzjLX+U5Ax7S6dDE5a4E4sX8M2E2W+DbMSDsilfLNzbWrIvkXrZuWRbDklL1H799esqcJdqIHg24l3KlOJyl50Ks+8JZu0ZM5F61ktmGE0jOGiPvcM78TcHvSjgQ2BPF0pyPZhUZlCHI+NUzzWx1lKk6tVW0PDijk1Iu/0bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JbsS9ZAN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706611406;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=2HONVDKuSZ2w2l05+cN156w2V56GzzGmZ9dXonpaH9I=;
	b=JbsS9ZANWadul27lgkJdXIZ8mnwUbHiVB3maQCo4ChmFj2VI7b+6umJ1epgFYrRPCWKMaH
	NtdyZLx0OENAuezVxmzIfNJVZ5jOdhVpaSpfIwOKdUoQ0DyoTekXiyXo52V0434aJM2qy6
	Dd9+oW18hbBq4LVbIwGDFKK3gvDewg4=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-KlKFbs0FMZi0tY5Puuy9kg-1; Tue, 30 Jan 2024 05:43:25 -0500
X-MC-Unique: KlKFbs0FMZi0tY5Puuy9kg-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-5110bf1635eso1703784e87.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jan 2024 02:43:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706611404; x=1707216204;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2HONVDKuSZ2w2l05+cN156w2V56GzzGmZ9dXonpaH9I=;
        b=k/Y39Uas93JJVNLa+6yHK9WU4xfSulJ+hWaW6QxouQvjE2FOR5MNJTrgpGlrV+E9TC
         ttxivoSwRPC7HvICgxVuDF3yiJENFU+0eEMRtRUDRzfCpKxtQSuN8dpijsX0ArhbYroR
         s4+EEN9aSeadiMMKdbVt+5OmIV3SDYFCfiUB+CrzBXoni7Uda8L71xmQVXtWfBbNxPvd
         q5VwVNr8HMBo04fk8rtVx3tiQbRS4SpPh7YoGHMgyZLJLJzoWmUdtQ/Zm9+n0B2EELVe
         x32uO3+jsqOMEed88kgZ2MyKxvg/u/dhK6EhlobSUBXlSKfD4ropDG8b0n9+OBTQXEGt
         iHTA==
X-Gm-Message-State: AOJu0YxbN8gdQswwic8b16MPJgIG1tNVaxYUSqtGGGd3dwiSAJymbGMD
	PHV5VXSqfV2WMfwb1oXZfy8RSsjNmugkAeheAYT50ENpULAUx+5hrQdRknpgSlZNNjz5l7TFBih
	tzsXxeNYMfJutQV2sm4mqVxzK56SaRu6dEkJExdKTAAmgFT0BYZHWU1sE1r1Cif8=
X-Received: by 2002:a05:6512:2209:b0:50e:4098:3798 with SMTP id h9-20020a056512220900b0050e40983798mr6360917lfu.60.1706611403679;
        Tue, 30 Jan 2024 02:43:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG0hoFT/mbW3gfNLOSpHj4kn6LMJFHpVVvm57xwFbQxEZ1sjrCGkbHqCeqLjjgjqBok32zPQw==
X-Received: by 2002:a05:6512:2209:b0:50e:4098:3798 with SMTP id h9-20020a056512220900b0050e40983798mr6360892lfu.60.1706611403250;
        Tue, 30 Jan 2024 02:43:23 -0800 (PST)
Received: from ?IPV6:2003:cb:c708:2700:bdf6:739b:9f9d:862f? (p200300cbc7082700bdf6739b9f9d862f.dip0.t-ipconnect.de. [2003:cb:c708:2700:bdf6:739b:9f9d:862f])
        by smtp.gmail.com with ESMTPSA id b16-20020a05600c4e1000b0040fafc8bb3asm204081wmq.9.2024.01.30.02.43.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jan 2024 02:43:22 -0800 (PST)
Message-ID: <a754add2-de29-4c91-b4f4-cbd7eb888cb6@redhat.com>
Date: Tue, 30 Jan 2024 11:43:21 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] mm/readahead: readahead aggressively if read drops in
 willneed range
Content-Language: en-US
To: Mike Snitzer <snitzer@kernel.org>, Dave Chinner <david@fromorbit.com>
Cc: Ming Lei <ming.lei@redhat.com>, Matthew Wilcox <willy@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Don Dutile <ddutile@redhat.com>,
 Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, linux-block@vger.kernel.org
References: <ZbenbtEXY82N6tHt@casper.infradead.org>
 <Zbc0ZJceZPyt8m7q@dread.disaster.area>
 <20240128142522.1524741-1-ming.lei@redhat.com> <ZbfeBrKVMaeSwtYm@redhat.com>
 <Zbgi6wajZlEkWISO@dread.disaster.area> <Zbgq3B8nmMuJooEl@redhat.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <Zbgq3B8nmMuJooEl@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29.01.24 23:46, Mike Snitzer wrote:
> On Mon, Jan 29 2024 at  5:12P -0500,
> Dave Chinner <david@fromorbit.com> wrote:
> 
>> On Mon, Jan 29, 2024 at 12:19:02PM -0500, Mike Snitzer wrote:
>>> While I'm sure this legacy application would love to not have to
>>> change its code at all, I think we can all agree that we need to just
>>> focus on how best to advise applications that have mixed workloads
>>> accomplish efficient mmap+read of both sequential and random.
>>>
>>> To that end, I heard Dave clearly suggest 2 things:
>>>
>>> 1) update MADV/FADV_SEQUENTIAL to set file->f_ra.ra_pages to
>>>     bdi->io_pages, not bdi->ra_pages * 2
>>>
>>> 2) Have the application first issue MADV_SEQUENTIAL to convey that for
>>>     the following MADV_WILLNEED is for sequential file load (so it is
>>>     desirable to use larger ra_pages)
>>>
>>> This overrides the default of bdi->ra_pages and _should_ provide the
>>> required per-file duality of control for readahead, correct?
>>
>> I just discovered MADV_POPULATE_READ - see my reply to Ming
>> up-thread about that. The applicaiton should use that instead of
>> MADV_WILLNEED because it gives cache population guarantees that
>> WILLNEED doesn't. Then we can look at optimising the performance of
>> MADV_POPULATE_READ (if needed) as there is constrained scope we can
>> optimise within in ways that we cannot do with WILLNEED.
> 
> Nice find! Given commit 4ca9b3859dac ("mm/madvise: introduce
> MADV_POPULATE_(READ|WRITE) to prefault page tables"), I've cc'd David
> Hildenbrand just so he's in the loop.

Thanks for CCing me.

MADV_POPULATE_READ is indeed different; it doesn't give hints (not 
"might be a good idea to read some pages" like MADV_WILLNEED documents), 
it forces swapin/read/.../.

In a sense, MADV_POPULATE_READ is similar to simply reading one byte 
from each PTE, triggering page faults. However, without actually reading 
from the target pages.

MADV_POPULATE_READ has a conceptual benefit: we know exactly how much 
memory user space wants to have populated (which range). In contrast, 
page faults contain no such hints and we have to guess based on 
historical behavior. One could use that range information to *not* do 
any faultaround/readahead when we come via MADV_POPULATE_READ, and 
really only popoulate the range of interest.

Further, one can use that range information to allocate larger folios, 
without having to guess where placement of a large folio is reasonable, 
and which size we should use.

> 
> FYI, I proactively raised feedback and questions to the reporter of
> this issue:
>   
> CONTEXT: madvise(WILLNEED) doesn't convey the nature of the access,
> sequential vs random, just the range that may be accessed.

Indeed. The "problem" with MADV_SEQUENTIAL/MADV_RANDOM is that it will 
fragment/split VMAs. So applying it to smaller chunks (like one would do 
with MADV_WILLNEED) is likely not a good option.

-- 
Cheers,

David / dhildenb


