Return-Path: <linux-fsdevel+bounces-50459-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4577AACC763
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 15:10:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1404D16D155
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 13:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E0C0230BC6;
	Tue,  3 Jun 2025 13:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="DIJ6k0+a"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3AA72622
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Jun 2025 13:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748956224; cv=none; b=nT0T1VHWXtHI8Ibdd9jzw5nPdOFzJJREI99abSy40BHiI9FYw6P3IlvnLydJuqs9OEiYLcw8NloRgkuEtWiQOj+Ezn0cffs55Aszg1rGsg6CHo4Uernewi/svD5ieIweRUA7qad5lEm6EEgt+m89+h1cxThwfYG/6cPWfXfCoPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748956224; c=relaxed/simple;
	bh=xMVHeEE/SxzT62LXweskFWc6cmkvw2JtE9cfTDCDC3c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jy5nfWnVPhj9rWH3oTjQBC9elyC+vepUIZaED6K6Dws5ioWOqqeq/DPiLHn3RzCI385ygNYBqnZIB5jXMiungCrMFWFxQ8HfXkMeaOJeRVhjry/vElD/YMfvdiuDkJcm1lw2L4gUdPoUAocDowradbdZJC6Ar987VZqVI3Tb4dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=DIJ6k0+a; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-86a464849faso426285639f.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Jun 2025 06:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1748956221; x=1749561021; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dXic1cyP7amAs7cGQlwC1dvEvej7HhuJm/yLfHH0Rq8=;
        b=DIJ6k0+aIqV6p8qTL+0nMZ253lRZMdewqq47BAOgMHMTpSbH5NTee7rXMZA7QSLUL6
         PT02/5LGxnrD3OdxpxddROFr4JrbOA3TItj796tER8u2bxd9UUC4eK0WCzGFtsuhHbkI
         OhdP4cnlUTkm6ZmreHl8WbkQy9CDKL1NO87qWddUjbxvBiv3TmJhcqk+5Q38PRIZzV9u
         Se0PE/wO0LIFvSkdP9PcuC9zid5cPPTUo0wchbXRxmeztqPY8xoUwyDHpQsw0AIOJrsL
         AwpL/U98fgbmMHgyVQEK9jvlUP/Bi3Fr8LoOSFulmoWsHL7WcrVotWaRgmA1P/kBwqx9
         PRVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748956221; x=1749561021;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dXic1cyP7amAs7cGQlwC1dvEvej7HhuJm/yLfHH0Rq8=;
        b=FfRSLwIm71+tIXVwrA2AMYFwt7bnhzCZ9/QWW3T6YxALq3AEasEFT8mTfNyeOd/oeh
         8sJ6lr2N32KqvSQ1LWNAUQK+b3ISDC1MZCQgApaipRyR2zf9wAY3t4Q4nb2A1fHPnfhk
         136aS5mW/usJNCC+f7jgjtSAJHfilc/yr3taFXAlb1v0sZk6PIyzHvTSZ5LLelkXVvLI
         CfywhAy/nPtVN8T3lUrJpKUC68rbXf3O+odSo+Q8FY7sVfy06A+mXFXxU5WWEkVK+oF+
         k9GOg0GszdXC5jsUItcQOHEU73vSZtlOV0RA02M2lQTP/suAqKsRj/7fdQ+fDPw7sqcR
         bRxg==
X-Gm-Message-State: AOJu0YzpD9eSA06mk5hhTFAsY49Vv+iV2oeekGItyMO88foRPm3FPfZz
	bK2xqGVG9axRGU7BGvtP6+jsOj1sFadyY4UGXFMVGphQYq+2lBuVvxR8IKKhGHyBiLQ=
X-Gm-Gg: ASbGncuvpMROxJP8ZzNHMJdqkt8NWU9U7g40njdFub9KWFgNqMsz0PfyoldrSwojRyK
	vSh4PoZhtKMqlr2GaufJy9HQZ0CumgcLeH2L1z5Tg0Gl6yc2Pti+3v4WhzxSSKwyKEU8k4omepG
	prli6BpAAS3NHK/jDwhVkoQlBVKIhesz/sPGbajBaJgq+euJaTiQokH2J07fxYg5KXSzh8fwXC7
	MH3aIXkrQBp7sR8AY/yscGwats28IqkTjiW9vUnw+CQJbg53amoEAohnxxH86vyTuylrV7166gr
	xz0ZvSv0Z2nLtxgvtFW7yLU2DlWPjVkm+sXRz4G1uVIrb5E=
X-Google-Smtp-Source: AGHT+IEhjGsVLaDyUCLBLQkMf818NMyBy1RlDRj1zIpCbxsdhlr3jCmTevpNudNnD/tQG+muo8XfKQ==
X-Received: by 2002:a05:6e02:230a:b0:3db:72f7:d7b3 with SMTP id e9e14a558f8ab-3dd9c9887d4mr167404775ab.4.1748956221403;
        Tue, 03 Jun 2025 06:10:21 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3dd935288efsm26469425ab.1.2025.06.03.06.10.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jun 2025 06:10:20 -0700 (PDT)
Message-ID: <24b9b367-d2ef-4eb5-ad56-f43ab624dd14@kernel.dk>
Date: Tue, 3 Jun 2025 07:10:19 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: RWF_DONTCACHE documentation
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 "hch@infradead.org" <hch@infradead.org>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linux-man@vger.kernel.org" <linux-man@vger.kernel.org>
References: <aD28onWyzS-HgNcB@infradead.org>
 <cb062be5-04e4-4131-94cc-6a8d90a809ac@kernel.dk>
 <12bb8614-a3e1-474e-914c-c06171f0a35e@wdc.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <12bb8614-a3e1-474e-914c-c06171f0a35e@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/3/25 12:20 AM, Johannes Thumshirn wrote:
> On 02.06.25 17:53, Jens Axboe wrote:
>> On 6/2/25 9:00 AM, Christoph Hellwig wrote:
>>> Hi Jens,
>>>
>>> I just tried to reference RWF_DONTCACHE semantics in a standards
>>> discussion, but it doesn't seem to be documented in the man pages
>>> or in fact anywhere else I could easily find.  Could you please write
>>> up the semantics for the preadv2/pwritev2 man page?
>>
>> Sure, I can write up something for the man page.
>>
> 
> Hi Jens,
> 
> Small sidetrack here. What happened to the ext4 and btrfs support of 
> RWF_DONTCACHE? I remember seeing your series having ext4 and btrfs 
> support as well but in current master only xfs is setting FOP_DONTCACHE.

The btrfs support got queued up, that's all I know on that front. For
ext4, it needed a bit of a hack [1] and there was some chatter on
converting the write side to iomap, which would eliminate the need for
that hack. The last fs patches I had on top of the core bits was:

https://git.kernel.dk/cgit/linux/log/?h=buffered-uncached-fs.11

in case you or someone else wants to pursue those parts.

[1] https://git.kernel.dk/cgit/linux/commit/?h=buffered-uncached-fs.11&id=92df0ef308d0bfbbc26a7efa1d571a506fd8fee3

-- 
Jens Axboe

