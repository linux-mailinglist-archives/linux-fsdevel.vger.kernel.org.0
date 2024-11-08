Return-Path: <linux-fsdevel+bounces-34001-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3AEA9C18DC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2024 10:12:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92E8D282A9D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2024 09:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A6761E0DDC;
	Fri,  8 Nov 2024 09:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="afwHBocK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499251E0E17
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Nov 2024 09:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731057091; cv=none; b=Sdm1IQex2hjIYs2jkW24psZ5TbAq3XLdpHKMMQpjgfFrsRJcZ2NbTOpdy4dwTtwV8rCgqB72x7Zy4CAFaO/Xc6SBY9qVra76QBC2phGhH2Khat/gH12h/NjpXsZyMSf6c+iES9PVq7yDm2qK2HdebC8iaeBDr9lyf5MuqYndvYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731057091; c=relaxed/simple;
	bh=P18VhREfrugG/qHzr6teADAUJc2Z4IK8RZWU+Ghq12s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kaWtL3zPyQtgc2fm/FFZ/BFypKyY6TvCIKug1MGPwTaCgLOy7AVPHq+9D8WO3czscHJIk9Q/k1a2XOUL/mMcQ46Q4A9NykylJqBMFgbBvbx9ll67TVHAxYJF//Kp6RF9iTSXsZdsQkQhc68R/ZeUWo3jikPcpCZBhs1AvK27juQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=afwHBocK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731057089;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=0WsuT3DC9bRgfcNtNIX7eohD3jKZ/flCBZ9q9PWdOEI=;
	b=afwHBocKo5llks//1fOhHT+4fc5x93FlwSYKhKk5xVm76hAHxS1LusyXIMINjhX3DSaA03
	MfA0bqnRxMWkHy26trpmgMca8zyd/U6wJJs65TqJgjSG3Fjc9BS/G+W3YWqqvJFxgK5WKn
	m4liLdEpiduj1+VXJcps/6OM1Aw/iGw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-7Jt2V2ZMOGq2xMBuo0AnDg-1; Fri, 08 Nov 2024 04:11:27 -0500
X-MC-Unique: 7Jt2V2ZMOGq2xMBuo0AnDg-1
X-Mimecast-MFC-AGG-ID: 7Jt2V2ZMOGq2xMBuo0AnDg
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-37d52ca258eso968386f8f.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Nov 2024 01:11:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731057086; x=1731661886;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0WsuT3DC9bRgfcNtNIX7eohD3jKZ/flCBZ9q9PWdOEI=;
        b=LnhKI0OcRobyWlT09XDc+Tm6aWHzw/xmQE4re5uJ8Jgav3eKu9P+flXjeV5U89gzdZ
         hl4vCGEKv5OIIli0luGVegjbOntwPaWidyfZ9n7Sr4wCTaSMRxBZGGaIH7Dadjyqvkxp
         21NJ7fPKpNGf5A5+UtWI73DHZH8z6Q2sFrM1xm2UNxxvcsj2T1xDn9K6jvZwOj8Zqwht
         0wzUy1ym1MKEUkj23tgZ0bNm9KiG7LINz58JTwv34ud13qY5wc4tnN5v662FKMKj4EN6
         jKm4rnZWsAuB2xkppjzBsyoDDo1QzcNwfHvh8gtzy6rTHIlg6J1WACXZ3UKZ7FTUAYte
         LLmQ==
X-Gm-Message-State: AOJu0Yyra6M4ru7xz1QdUI5IZRnv88bOFjiz5+EvqmeYr2/Tdeg1XuP9
	PiN8LoFcaav6F7ppu05Fg8ahhZkaRxK8VMm+0im+XGWisDsSMork0J7d41qfUIbjba6jU82lgA2
	2Xs0X8wPFYh5Czevrq3yGmJJuteXncsQvOKrclUWQTaE56qtlT00X65xU5Eaf2fw=
X-Received: by 2002:a05:6000:470c:b0:37d:36f2:e2cb with SMTP id ffacd0b85a97d-381f16180cdmr1817977f8f.0.1731057086607;
        Fri, 08 Nov 2024 01:11:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEzIFbKup5v9N/vkT3yVeYe4zKp1d/9iZQMTZ+mtjlmwHCic7JOR4NiaQ1QPh2UX2o2j7ng2Q==
X-Received: by 2002:a05:6000:470c:b0:37d:36f2:e2cb with SMTP id ffacd0b85a97d-381f16180cdmr1817947f8f.0.1731057086207;
        Fri, 08 Nov 2024 01:11:26 -0800 (PST)
Received: from ?IPV6:2003:cb:c70f:b600:4a55:861a:f768:72a8? (p200300cbc70fb6004a55861af76872a8.dip0.t-ipconnect.de. [2003:cb:c70f:b600:4a55:861a:f768:72a8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381ed97cfefsm3976303f8f.26.2024.11.08.01.11.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Nov 2024 01:11:25 -0800 (PST)
Message-ID: <6099e202-ef0a-4d21-958c-2c42db43a5bb@redhat.com>
Date: Fri, 8 Nov 2024 10:11:24 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [ISSUE] split_folio() and dirty IOMAP folios
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, "linux-mm@kvack.org" <linux-mm@kvack.org>,
 kvm@vger.kernel.org, Zi Yan <ziy@nvidia.com>,
 Christian Brauner <brauner@kernel.org>, "Darrick J. Wong"
 <djwong@kernel.org>, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>, Thomas Huth <thuth@redhat.com>
References: <4febc035-a4ff-4afe-a9a0-d127826852a9@redhat.com>
 <ZyzmUW7rKrkIbQ0X@casper.infradead.org>
 <ada851da-70c2-424e-b396-6153cecf7179@redhat.com>
 <Zy0g8DdnuZxQly3b@casper.infradead.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <Zy0g8DdnuZxQly3b@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07.11.24 21:20, Matthew Wilcox wrote:
> On Thu, Nov 07, 2024 at 05:34:40PM +0100, David Hildenbrand wrote:
>> On 07.11.24 17:09, Matthew Wilcox wrote:
>>> On Thu, Nov 07, 2024 at 04:07:08PM +0100, David Hildenbrand wrote:
>>>> I'm debugging an interesting problem: split_folio() will fail on dirty
>>>> folios on XFS, and I am not sure who will trigger the writeback in a timely
>>>> manner so code relying on the split to work at some point (in sane setups
>>>> where page pinning is not applicable) can make progress.
>>>
>>> You could call something like filemap_write_and_wait_range()?
>>
>> Thanks, have to look into some details of that.
>>
>> Looks like the folio_clear_dirty_for_io() is buried in
>> folio_prepare_writeback(), so that part is taken care of.
>>
>> Guess I have to fo from folio to "mapping,lstart,lend" such that
>> __filemap_fdatawrite_range() would look up the folio again. Sounds doable.
>>
>> (I assume I have to drop the folio lock+reference before calling that)
> 
> I was thinking you'd do it higher in the callchain than
> gmap_make_secure().  Presumably userspace says "I want to make this
> 256MB range secure" and we can start by writing back that entire
> 256MB chunk of address space.
> 
> That doesn't prevent anybody from dirtying it in-between, of course,
> so you can still get -EBUSY and have to loop round again.

I'm afraid that won't really work.

On the one hand, we might be allocating these pages (+disk blocks) 
during the unpack operation -- where we essentially trigger page faults 
first using gmap_fault() -- so the pages might not even exist before the 
gmap_make_secure() during unpack. One work around would be to 
preallocate+writeback from user space, but it doesn't sound quite right.

But the bigger problem I see is that the initial "unpack" operation is 
not the only case where we trigger this conversion to "secure" state. 
Once the VM is running, we can see calls on arbitrary guest memory even 
during page faults, when gmap_make_secure() is called via 
gmap_convert_to_secure().


I'm still not sure why we see essentially no progress being made, even 
though we temporarily drop the PTL, mmap lock, folio lock, folio ref ... 
maybe related to us triggering a write fault that somehow ends up 
setting the folio dirty :/ Or because writeback is simply too slow / 
backs off.

I'll play with handling -EBUSY from split_folio() differently: if the 
folio is under writeback, wait on that. If the folio is dirty, trigger 
writeback. And I'll look into whether we really need a writable PTE, I 
suspect not, because we are not actually "modifying" page content.

-- 
Cheers,

David / dhildenb


