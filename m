Return-Path: <linux-fsdevel+bounces-37937-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C029F94DB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 15:49:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 825131881BF3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 14:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67B67216382;
	Fri, 20 Dec 2024 14:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L2r02M4x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC691A83ED
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Dec 2024 14:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734706187; cv=none; b=QkjkGzhTIiI02srxlbOICYWluhTHGS+Ohj0dNRY88wv810d8oDIfzR/WSCTPr51V+cvPTcIery4jAGojQE+/J/X9BBG11ehB/seGGvHF4qwjBSy5u8sK57kS70I6akwwHcjR8gMZTBtE50hR2z90fRY0hlrCilebEEohH+UwDBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734706187; c=relaxed/simple;
	bh=RqIRfn27LE2oGUOCWv0ryl+puFzr0z6tSuZ5iGQCAoY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=taC1KKJSWHhTOB9plXDP5QzCG92h7+LO2P7+cdOG6nfI3lCQwRIFHg/nSqCKio/Rjj2qpTvE/mlMjwFsJrGPjR1xwVILEe3RtR+meSiIicgzcJYAmL6x28HG82qipd7nhEkpHAL22fjgO9+A8LFCuPGitrr1KLQs5xqYJrKKCS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L2r02M4x; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734706185;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=HK5E/SdnNISM/lzZXdoGhlirZfJ/48n3KlMXZ2+P1dY=;
	b=L2r02M4xIri2X+u0cVxYk/SdnfEWxw1Ie9bOB2muUdZ3Mkz/ZD//WCZvATK07Tb2ox+83S
	baFDoSmCiBeQt9zezl/35AofOoRw6aGxxI5ah7KZYq85/Fx64KBjUtluGH9tZlg2bvxsTs
	QFjgeQ5ISmitta8PF+TH+HBwojA+2Zs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-njVECvBEOGqw9jvLCu8OnA-1; Fri, 20 Dec 2024 09:49:43 -0500
X-MC-Unique: njVECvBEOGqw9jvLCu8OnA-1
X-Mimecast-MFC-AGG-ID: njVECvBEOGqw9jvLCu8OnA
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-385d7611ad3so1190306f8f.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Dec 2024 06:49:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734706183; x=1735310983;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HK5E/SdnNISM/lzZXdoGhlirZfJ/48n3KlMXZ2+P1dY=;
        b=o9y6+RowV12J2B+c4dzlfPLzi0bSS2YrhQ2Da9rIYAc4crcQRbwVIj6u2toYb7fOFQ
         36qRwyXbn7J4GOqzsor6BANT+nZTXRBKkvQQyOzH0dUH346/gpUT0NAqm5UUucsmKXWT
         BvsbxEkFp5zeJsXuSPfQNjxaPGMwyGgL6OJgWD9jGLVwN/XXaXNt+yQ9cGPimDazcwLk
         nitOfW1o8tRuQiHAgNiwrKo8a1C6SPXfp76qiwPU2iGScdcTBh78Wt5JovBZNkYLZGMn
         bCH+AOG+FsdoIViXCk0CRcyqGE3C288LKvxoDPMs02cn7UNJfjd14TtTStFctohyy7iD
         sGDA==
X-Forwarded-Encrypted: i=1; AJvYcCXxQLUDlmG2Pl65ye6glsT//S/9+o0H3PwoEz8gPVc2mGAqfImq/1uDhOLY+4G3q7ZWma/G2AiPMz6tflIH@vger.kernel.org
X-Gm-Message-State: AOJu0YxG/Bw7SlkHS0WjtfapHSSqz0+yu6zm+rlbH/dnse1yaWFl1pSZ
	GlWYHTFT54dJmAJ45F1fVaFEDdND5jLAoq+Bznj062jzY0lln5WA8l3JGVF3h7G2txknUF7D2pl
	5hsmMOIbQZetmUDEYSY8macYBn5TmzoS9wyC3Th7JP1mbL7n9uPs02vRyVInwwog=
X-Gm-Gg: ASbGncssTJMs3me2qVuW51cLvYsNHuO9yrEev5LhHcay09fDtkJvCJ2B9JgRaMjbXZi
	w6FFQeVM/kI7gv/paaF7irgA5ZuCKjUomvXnwSOIiaRG6h44u8ooM8Ixwkh1v6mu4Ib7J7a3uMo
	pWMqDgztM1nbIFvO2xmaeAjNO2ALlxhLV81PDtvRBHnW3Ro7ywg3dwWI24gTdj0rJjBi1FXdll/
	AxWCWrPpdH72D/2YAGLc9qccjHDhDL3UC6nYLMl3+iEaA+lNpyaWkY97Hr0WJo67r7OkAARhyC1
	ys7rhpDw8z9pEd9N1uUWObkzpqy24hZOQpGXIjOVKKRJ4seXHV5CEpzQIxngeX+kzm1BeIjmHsF
	7P6vrNdJf
X-Received: by 2002:a05:6000:4b0b:b0:386:37f5:99e7 with SMTP id ffacd0b85a97d-38a22201897mr3476714f8f.33.1734706182784;
        Fri, 20 Dec 2024 06:49:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFTVGz8S78H2tYQeT79FCS/JtBxgzUgnpDemzmSMVJWI71SmGeE4g9J9ThG5UuekeAgxgIrTg==
X-Received: by 2002:a05:6000:4b0b:b0:386:37f5:99e7 with SMTP id ffacd0b85a97d-38a22201897mr3476680f8f.33.1734706182396;
        Fri, 20 Dec 2024 06:49:42 -0800 (PST)
Received: from ?IPV6:2003:cb:c708:9d00:edd9:835b:4bfb:2ce3? (p200300cbc7089d00edd9835b4bfb2ce3.dip0.t-ipconnect.de. [2003:cb:c708:9d00:edd9:835b:4bfb:2ce3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c8330e0sm4165079f8f.34.2024.12.20.06.49.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Dec 2024 06:49:41 -0800 (PST)
Message-ID: <9404aaa2-4fc2-4b8b-8f95-5604c54c162a@redhat.com>
Date: Fri, 20 Dec 2024 15:49:39 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/5] mm/migrate: skip migrating folios under writeback
 with AS_WRITEBACK_INDETERMINATE mappings
To: Bernd Schubert <bernd.schubert@fastmail.fm>,
 Shakeel Butt <shakeel.butt@linux.dev>, Joanne Koong <joannelkoong@gmail.com>
Cc: Zi Yan <ziy@nvidia.com>, miklos@szeredi.hu,
 linux-fsdevel@vger.kernel.org, jefflexu@linux.alibaba.com,
 josef@toxicpanda.com, linux-mm@kvack.org, kernel-team@meta.com,
 Matthew Wilcox <willy@infradead.org>, Oscar Salvador <osalvador@suse.de>,
 Michal Hocko <mhocko@kernel.org>
References: <C34102A1-F571-4700-8D16-74642046376D@nvidia.com>
 <onnjsfrlgyv6blttpmfn5yhbv5q7niteiwbhoze3qnz2zuwldc@seooqlssrpvx>
 <43e13556-18a4-4250-b4fe-7ab736ceba7d@redhat.com>
 <ggm2n6wqpx4pnlrkvgzxclm7o7luqmzlv4655yf2huqaxrebkl@2qycr6dhcpcd>
 <968d3543-d8ac-4b5a-af8e-e6921311d5cf@redhat.com>
 <ssc3bperkpjyqdrlmdbh2woxlghua2t44tg4cywj5pkwwdcpdo@2jpzqfy5zyzf>
 <7b6b8143-d7a4-439f-ae35-a91055f9d62a@redhat.com>
 <2e13a67a-0bad-4795-9ac8-ee800b704cb6@fastmail.fm>
 <ukkygby3u7hjhk3cgrxkvs6qtmlrigdwmqb5k22ru3qqn242au@s4itdbnkmvli>
 <CAJnrk1bRk9xkVkMg8twaNi-gWBRps7A6HubMivKBHQiHzf+T8w@mail.gmail.com>
 <2bph7jx4hvhxpgp77shq2j7mo4xssobhqndw5v7hdvbn43jo2w@scqly5zby7bm>
 <71d7ac34-a5e5-4e59-802b-33d8a4256040@redhat.com>
 <b16bff80-758c-451b-a96c-b047f446f992@fastmail.fm>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <b16bff80-758c-451b-a96c-b047f446f992@fastmail.fm>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>> I'm wondering if there would be a way to just "cancel" the writeback and
>> mark the folio dirty again. That way it could be migrated, but not
>> reclaimed. At least we could avoid the whole AS_WRITEBACK_INDETERMINATE
>> thing.
>>
> 
> That is what I basically meant with short timeouts. Obviously it is not
> that simple to cancel the request and to retry - it would add in quite
> some complexity, if all the issues that arise can be solved at all.

At least it would keep that out of core-mm.

AS_WRITEBACK_INDETERMINATE really has weird smell to it ... we should 
try to improve such scenarios, not acknowledge and integrate them, then 
work around using timeouts that must be manually configured, and ca 
likely no be default enabled because it could hurt reasonable use cases :(

Right now we clear the writeback flag immediately, indicating that data 
was written back, when in fact it was not written back at all. I suspect 
fsync() currently handles that manually already, to wait for any of the 
allocated pages to actually get written back by user space, so we have 
control over when something was *actually* written back.


Similar to your proposal, I wonder if there could be a way to request 
fuse to "abort" a writeback request (instead of using fixed timeouts per 
request). Meaning, when we stumble over a folio that is under writeback 
on some paths, we would tell fuse to "end writeback now", or "end 
writeback now if it takes longer than X". Essentially hidden inside 
folio_wait_writeback().

When aborting a request, as I said, we would essentially "end writeback" 
and mark the folio as dirty again. The interesting thing is likely how 
to handle user space that wants to process this request right now (stuck 
in fuse_send_writepage() I assume?), correct?

Just throwing it out there ... no expert at all on fuse ...

-- 
Cheers,

David / dhildenb


