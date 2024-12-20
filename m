Return-Path: <linux-fsdevel+bounces-37934-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08C5B9F9424
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 15:21:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF9F7165C87
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 14:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B31216392;
	Fri, 20 Dec 2024 14:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="csTVOiXW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15380215F6F
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Dec 2024 14:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734704466; cv=none; b=Ol2C9AwB9WNIkRH9xAa88G29vlL3hPUoklzRKjcuSV0rmo1oVl/ijCiJJKJ+nwxddjr7QRfaaQuylu04MiKFdTiafEdWNCwgS8jyxYMWhfAQaBhTkr2ax1Gx9r2FXLbGh9ka/+CNuuyiwIzLPGFZlGuzLjYClIPuMGa3LrLTNww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734704466; c=relaxed/simple;
	bh=ZmvORrp2lZZv9x8zCaTOLAkBhQDSjTLLRa6i8Pc30dg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I3ov4CqGjH7pPwk8AJgS4rlv+bVsZFOhACyvbAjuNhoAjFIHS7DmN743+lk18T7c1URQJ7oMxUwvsi6qUOUU572/DFQDXyhu/v8AJwBPAymob28DBY1xyhH6wgGoCIStQeHPnVWzOz9WxCf2VSYdH5KINtNAGFY4mDzyBV7I3pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=csTVOiXW; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-844e9b8b0b9so159139339f.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Dec 2024 06:21:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1734704463; x=1735309263; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=31DzIQjE9S8zB8EihDSpAerIn7KsH/HS0eAgGru0OYk=;
        b=csTVOiXW2NZiyIi3cvIOvd8qx7uxqmmQbdkufGeFmqoRiTeMKpO7AXG99fKfopbfaa
         vsXCKBw75NryC0Fh6jEWSX2nrZPK8WrtO/6AAsnrJ1v7wB+SVy8YKeF5Zh60hsJ6AaUS
         Qd9eZg9jWAxjsE36xtTLllX4RMY/4s1DQ/NA17VM5HsHENrXsZNeVoQxOlvBFUtgkiVW
         wNeiAeGH+rhmkinzBZbunaQlQjMfLhvzrUWcwi6XBLG7hMcAXHLzASwZ3yKrs9UN2dXQ
         Fky/tCazmZytAeyTatSSP1e/Bce/TlYNlqZ3JL+azd02x1L1w7E3tZBYBaCl5afg5Krk
         j7lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734704463; x=1735309263;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=31DzIQjE9S8zB8EihDSpAerIn7KsH/HS0eAgGru0OYk=;
        b=K2BHckrYWTAeKJAw2l5Et53+s8NKhJl1mzgxreh4WDP8KZEbZ6e0uKD0ollrB5Q+4I
         rdZXP+G1VNMBhGHJ05cmSFu7iZ4PNOFBQ2NZQtVNqwFM4TGQgWvBXH7r2D2PK2/hJ0uh
         zYomkXROzQmV3SYKrjSX0wdgiHXkMSOqvQ5Qr4i8z+N4eFNugKPPQGd4aC6INYFizFCf
         0wTBMYLH2+aNBky045INPJMo2DRoglEjxZ/J4b7hvUeM33Oi9iSrrr3HBDARtO7VAm1w
         4V5nOkKsKiFrwf6JZIFOkyHV1/JfNI1OV+A2lNG5SN/Lw0uYS0O5mWQHQg0TTkMwKwln
         BrXg==
X-Forwarded-Encrypted: i=1; AJvYcCVcTTzmPXjCYNTgXe1MRevYlNRwOaJgteOuHeF6UzdQX5th7QNB5gJqxx09f0TdAixvsJhVOtwFeG7xRnr8@vger.kernel.org
X-Gm-Message-State: AOJu0YyZq9+19XUgvu5t72zFJ6mr25gjLxtUSyqdfUF/80FvPrwJDEk8
	NjvTJ6H+eAW0F72jWtYeXz+LW/Ne1VQqz54rkI7fjNxWURLWUAhBp5Abwc+VDuJ04PsMJ1xHFf8
	Q
X-Gm-Gg: ASbGncuv2qZdscCWndw7p2qcJp4ZvlwYBHcauUP1hJ5N6+jjuw8xLYyDMJEyXZg70/m
	ISayiqMfCui2z/miXQMPRqxNJwN05tz8GlrsXJC3FTpTHdXr7pNngnzAak+rEsds/HjJ6+0jEpd
	h9JbwKFmwMfg5/z+5hXZnE4zrhtEm/Z15tbDUElSwnAMXogRf2nzH5tCJH8QxG1VF3nV4/WBE/f
	DD+LajrGDYAo7Z1iLAnpFA7CLp8gEW8H80xdyWWJ9CZt8L946M5
X-Google-Smtp-Source: AGHT+IEj0xCISBX0Tk5xDDbo9glyTwomym223EgEc8tW4cI6P2VS4z3kvPSV5qtUa4FmLA3Gwp08uw==
X-Received: by 2002:a05:6e02:219c:b0:3a7:a2c6:e6d1 with SMTP id e9e14a558f8ab-3c2d5151ee6mr28309845ab.16.1734704461729;
        Fri, 20 Dec 2024 06:21:01 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3c0e3f3633esm8740715ab.59.2024.12.20.06.21.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Dec 2024 06:21:00 -0800 (PST)
Message-ID: <b5b9b6f3-218c-4360-89a7-e58a92327aca@kernel.dk>
Date: Fri, 20 Dec 2024 07:21:00 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHSET v7 0/11] Uncached buffered IO
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, hannes@cmpxchg.org,
 clm@meta.com, linux-kernel@vger.kernel.org, willy@infradead.org,
 bfoster@redhat.com
References: <20241213155557.105419-1-axboe@kernel.dk>
 <tp5nhohkf73dubmepzo7u2hkwwstl2cphuznigdgnf7usd7tst@6ba2nmyu4ugy>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <tp5nhohkf73dubmepzo7u2hkwwstl2cphuznigdgnf7usd7tst@6ba2nmyu4ugy>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/20/24 4:25 AM, Kirill A. Shutemov wrote:
>> Since v6
>> - Rename the PG_uncached flag to PG_dropbehind
>> - Shuffle patches around a bit, most notably so the foliop_uncached
>>   patch goes with the ext4 support
>> - Get rid of foliop_uncached hack for btrfs (Christoph)
>> - Get rid of passing in struct address_space to filemap_create_folio()
>> - Inline invalidate_complete_folio2() in folio_unmap_invalidate() rather
>>   than keep it as a separate helper
>> - Rebase on top of current master
> 
> Hm. v6 had a patch that cleared the PG_uncached flag if the page accessed
> via non-uncached lookup[1]. What happened to it? I don't see it here.
> 
> https://lore.kernel.org/all/20241203153232.92224-14-axboe@kernel.dk

Since I only needed these bits for the fs support, I didn't include it in
this series. However, I did move it back to the core series for v8, it's
this one:

https://git.kernel.dk/cgit/linux/commit/?h=buffered-uncached.10&id=e4b7e8f693caf84021424ebafa139f38c5599db3

to avoid having a core dependency for the patches adding support to
iomap and xfs/btrfs.

I'll send out a new version with just slight tweaks today. So far it
has the following changelog:

- Rename filemap_uncached_read() to filemap_end_dropbehind_read()
- Rename folio_end_dropbehind() to folio_end_dropbehind_write()
- Make the "mm: add FGP_DONTCACHE folio creation flag" patch part of
  the base patches series, to avoid dependencies with btrfs/xfs/iomap
- Remove now dead IOMAP_F_DONTCACHE define and setting on xfs/iomap

where moving this patch back to teh core series is one of the entries.

-- 
Jens Axboe

