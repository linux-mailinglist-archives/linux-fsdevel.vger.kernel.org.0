Return-Path: <linux-fsdevel+bounces-37926-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44DEF9F9190
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 12:44:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A3561895307
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 11:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A903A1C5CD3;
	Fri, 20 Dec 2024 11:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A7FCUfy4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4D51C3F39
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Dec 2024 11:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734695072; cv=none; b=ebm4x2i26hBaSeQg0L81D82NaWzDCx5b+MCqaJtXvnqu8sv+tBqg2AsVWcMKTm7jvrSZ0e7K6pXhfZhxUW3qqKpmpSzQfnZWHItZXwWsOQ3e3N6SDrPDYcOXbhmLyqjjx3yK8YYj3S7Q6DXJzsJAZu16fymWfoxWiu1RdwuEGWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734695072; c=relaxed/simple;
	bh=zPeArk2AWCimwUzBdLBBS29OERrRDXUjdjIvbnjxaAE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ILdD/UKH/eqGrj0u/9wIU8R+LZ2UdlI1f8r72xHXVgXz/8JjpqW4tlc+kKcHMV1XPCBDg340wD0YMPfiqXwRrpBnZE85mSh/FNX0lX7FbZYVLmsaj5Je3vM90mmhwqdSCb6TPvee6uAaQq3yfltcjBt8910jSSAx8lAjssK5wdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A7FCUfy4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734695068;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ow9NqohQoR1aUaz4aWsT7z2j3IOExlkRwpNxZtEB8Rk=;
	b=A7FCUfy4B19BcrcYPpwDYDJhnxdoj/JHKuZkOeVcwWZeNLefa8MiGjs1hNejoZzNWCRBBY
	edbJ41jKc3aFrucOlK4utn9+zf4GtHWkd/CJy+EsqUbmHzyho2hGGK9oSmd5d8zo1qJv+i
	I9rUlicVar+EaXJEnUxwmyvf+vLNxoE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-444-YBlRYgXqPNqWT2K34Olq7Q-1; Fri, 20 Dec 2024 06:44:27 -0500
X-MC-Unique: YBlRYgXqPNqWT2K34Olq7Q-1
X-Mimecast-MFC-AGG-ID: YBlRYgXqPNqWT2K34Olq7Q
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43651b1ba8aso14146615e9.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Dec 2024 03:44:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734695066; x=1735299866;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ow9NqohQoR1aUaz4aWsT7z2j3IOExlkRwpNxZtEB8Rk=;
        b=ph1JWcimL7mmkiINWeTwGCN/AJhna0gdAGgKaoWineILI+3o8Jzz6L6p6Y9+8Z1d09
         T+jjbnzC2WsGHyVuCsWeaR6eUfV0oX9EXi1B03Pyn1aWIKiMBKbE9u4ZoTB09m3LWRtV
         y+FUQWd7FIEGJPIl+EfnOChZQaWfQA89WdCrnpTtNiuwphLm2o+zSDk7ivyM9KVcb718
         CZlVcLCbCqIFDSzIz5SVmTvzlSERpfqTTT3eQLk3AMfSN6NzM6OQpCR1l8szIdfo+2pY
         tTUWG5OMvVG9ZBucAj3cvKomikyctosCExrVJ7WHrvr/OzPzySJjkKF9WHa0Y9GjKtzy
         fiAw==
X-Forwarded-Encrypted: i=1; AJvYcCX5xrAyXWbWrxlCNPgZKh4NGhhU2ImBmdXBIVxAqh+AMJoP+Nan77Ix+rW73mBgQHGc7ZyDmzDDKm452BI9@vger.kernel.org
X-Gm-Message-State: AOJu0YyjzMJTFGdQMZCxJ8mfnGFxWHDNPAJwcrVDt0ZHDYvXpwnurG4J
	bH2TU6f9TUCwmt32fnSrHjT0HmRg3Gcqu2ZMY3SyPpeV7g+8xlXemZiTN7/hZXr89lCphqisJ2J
	gvWy5MPoNiMelcvzn7h8qX9mA5KkZJ0em1NwtAt1oPmXTzlUHPdcFBy6HVo9nvPo=
X-Gm-Gg: ASbGnctG0+VZ9AtA5xaUBUFYZHwn/+er6PE1BaN3BVu71h70HLWdzK5K0McSwT3K/+M
	Yoj2yDQEkVyLbQDzEIIg9umA7n0xaGHjIohXm9Quam8ZLqvLFf8p8xeqB3RMMz3dpHviopG70hy
	yDNJ5kDiKNh24nJI4TiNbUJpVyR9yc05Wyq2EQTQbZwKxpk/wfpzXQkeCo2gbxjdnN9YVBNe5a/
	BrkK7G06ontAuM6bU7Afm+kcQH3kpShroH18lLOxmDUfPegnFznft9b7fHrhYYnPhXqKfOEvEOi
	TjZXipXM8/RpwYGPeP5d0/0Q8vlW1nPruO3b4tqqQopx6Hrohha4Jg5sa18W1Hrop81w7o2rsa8
	dN98sLXal
X-Received: by 2002:a5d:6d84:0:b0:386:45e9:fc8a with SMTP id ffacd0b85a97d-38a221e1dfemr2446578f8f.5.1734695066206;
        Fri, 20 Dec 2024 03:44:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHSnyM46S7ernQ9dtOgopB5aSlUavzUNu0EQyzM4KMdGjSwVPLpv06Y17TbqsrJNkT6ty7nIg==
X-Received: by 2002:a5d:6d84:0:b0:386:45e9:fc8a with SMTP id ffacd0b85a97d-38a221e1dfemr2446546f8f.5.1734695065835;
        Fri, 20 Dec 2024 03:44:25 -0800 (PST)
Received: from ?IPV6:2003:cb:c708:9d00:edd9:835b:4bfb:2ce3? (p200300cbc7089d00edd9835b4bfb2ce3.dip0.t-ipconnect.de. [2003:cb:c708:9d00:edd9:835b:4bfb:2ce3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c8472d5sm3911850f8f.47.2024.12.20.03.44.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Dec 2024 03:44:25 -0800 (PST)
Message-ID: <71d7ac34-a5e5-4e59-802b-33d8a4256040@redhat.com>
Date: Fri, 20 Dec 2024 12:44:24 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/5] mm/migrate: skip migrating folios under writeback
 with AS_WRITEBACK_INDETERMINATE mappings
To: Shakeel Butt <shakeel.butt@linux.dev>,
 Joanne Koong <joannelkoong@gmail.com>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>, Zi Yan <ziy@nvidia.com>,
 miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
 jefflexu@linux.alibaba.com, josef@toxicpanda.com, linux-mm@kvack.org,
 kernel-team@meta.com, Matthew Wilcox <willy@infradead.org>,
 Oscar Salvador <osalvador@suse.de>, Michal Hocko <mhocko@kernel.org>
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
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <2bph7jx4hvhxpgp77shq2j7mo4xssobhqndw5v7hdvbn43jo2w@scqly5zby7bm>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 19.12.24 18:54, Shakeel Butt wrote:
> On Thu, Dec 19, 2024 at 09:44:42AM -0800, Joanne Koong wrote:
>> On Thu, Dec 19, 2024 at 9:37 AM Shakeel Butt <shakeel.butt@linux.dev> wrote:
> [...]
>>>>
>>>> The request is canceled then - that should clear the page/folio state
>>>>
>>>>
>>>> I start to wonder if we should introduce really short fuse request
>>>> timeouts and just repeat requests when things have cleared up. At least
>>>> for write-back requests (in the sense that fuse-over-network might
>>>> be slow or interrupted for some time).
>>>>
>>>>
>>>
>>> Thanks Bernd for the response. Can you tell a bit more about the request
>>> timeouts? Basically does it impact/clear the page/folio state as well?
>>
>> Request timeouts can be set by admins system-wide to protect against
>> malicious/buggy fuse servers that do not reply to requests by a
>> certain amount of time. If the request times out, then the whole
>> connection will be aborted, and pages/folios will be cleaned up
>> accordingly. The corresponding patchset is here [1]. This helps
>> mitigate the possibility of unprivileged buggy servers tieing up
>> writeback state by not replying.
>>
> 
> Thanks a lot Joanne and Bernd.
> 
> David, does these timeouts resolve your concerns?

Thanks for that information. Yes and no. :)

Bernd wrote: "I start to wonder if we should introduce really short fuse 
request timeouts and just repeat requests when things have cleared up. 
At least for write-back requests (in the sense that fuse-over-network 
might be slow or interrupted for some time).

Indicating to me that while timeouts might be supported soon (will there 
be a sane default?) even trusted implementations can run into this 
(network example above) where timeouts might actually be harmful I suppose?

I'm wondering if there would be a way to just "cancel" the writeback and 
mark the folio dirty again. That way it could be migrated, but not 
reclaimed. At least we could avoid the whole AS_WRITEBACK_INDETERMINATE 
thing.

-- 
Cheers,

David / dhildenb


