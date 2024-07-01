Return-Path: <linux-fsdevel+bounces-22897-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B1A91E97D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2024 22:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 897491C22962
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2024 20:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6FE417106E;
	Mon,  1 Jul 2024 20:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NR3PzA1G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C154916F85A
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Jul 2024 20:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719865224; cv=none; b=pM2cJSkR+38KRlaDY0YQs2xL1KarHceGg5qNY9MzKwTwRLEoqtP7VrO640/kaj42en8mdplgthzjqur+eztwbiFIMb/zwCuAhLrmQif7tEu8hc8ISEAe4MCnKlCIwPVrT+WNtFaqeMM4bKUKws2/hByCY9O3ZoZg89fq9wNZ9kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719865224; c=relaxed/simple;
	bh=ga4e451jvPKhfVqnj9JAcDaLsXJruiPG23fLvZNyxJ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JQwHMIegzuvOTlQY1PCiVASw644IpYUjq5/4OEah321HTppdInLaeUawfNx7OgeJMwCcDMRON/USZm+JEYMExQ89GQJEGwGkiHCbrUidxxHI2IEf1dKaK99sirHB1t0e20p1cvFjRtQtttvBwaCoQsD1RXXvo21QIJ2PWcZviQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NR3PzA1G; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719865221;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x8jZ/LHJFYFMuuhWj5aeUBvonaTg3r82OZP4JFmsMPQ=;
	b=NR3PzA1GNC6ConWJPngalN4XxteVxEA6fbMWu9YW1zfuq8XD0odGyvQvYeLnHwxe6dHrSz
	jawJKCUgSTqGFYKPFuSnqJJzvoMASnwZ83xOfD+2+A71oR5kks5+5vALUHoFd1d6VbUUWA
	jufpqiS3hacQiVa19K8zLlhI70A7BYI=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-56S2ZOZ1NN6AjWPOZ-W2lA-1; Mon, 01 Jul 2024 16:20:20 -0400
X-MC-Unique: 56S2ZOZ1NN6AjWPOZ-W2lA-1
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-375e4d55457so36049635ab.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Jul 2024 13:20:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719865219; x=1720470019;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x8jZ/LHJFYFMuuhWj5aeUBvonaTg3r82OZP4JFmsMPQ=;
        b=C2cbtkPNaILiUwXJxmqHNU0p1NjuitVD5tK4WRrh9RTN55Gy8NslFK5R8vRhF1R2GA
         /dt0psHOpJXUX7IZ2AkkIKXbVAL0cbdYfKRe6+BIFWHTuI1GULHnLq4mQ8P+0AgWwN4C
         BgIN3i+mX4vEIW/WfxQZjnVrcWvDlcJ9MofaS61gN21PH6HHdC5ioOMbVCdut9hb9qv7
         eFC5ZbI4dCIAXN/bNBQnC+yF1FQK1/B/RClfyZZ5/tyG12HY5rRmJ6QsuZjYD4thUfMn
         qyDvn60KMFqAvURruLbtSL253ss+DHvH0rWSnl0IYjJ/2tRJd1RmFVlP/igclHTxSFMH
         mktA==
X-Gm-Message-State: AOJu0YyOl5zj3J9i4cFvR10z58h4aO3zoMR8X9rq3X/hy2vMVT3nFywd
	hw8YJ2wI9esrF8zWBTrBjrgkjd3SjfMF+R7iRNLs3/SqGC5pRN0JBR6Z6S6RYyzovIng0GfRi1D
	u7nvsFKVzV9pB0KyZjqujN69zGFt/4+paZCOrl+PmuUGHhumK7zOqPBd0pdFRYqRfS3gP7O8=
X-Received: by 2002:a05:6e02:1949:b0:374:9a34:9ee with SMTP id e9e14a558f8ab-37cd31b6a0fmr66268045ab.31.1719865218955;
        Mon, 01 Jul 2024 13:20:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEF9rPDk70/9YkAFuxnveSOjPqGx+ro57vaUqyD6i0jrH9HHxjMsjghJxxQsHeGeNgV7wDYyg==
X-Received: by 2002:a05:6e02:1949:b0:374:9a34:9ee with SMTP id e9e14a558f8ab-37cd31b6a0fmr66267915ab.31.1719865218601;
        Mon, 01 Jul 2024 13:20:18 -0700 (PDT)
Received: from [10.0.0.71] (sandeen.net. [63.231.237.45])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-37ad2f412d4sm20215295ab.45.2024.07.01.13.20.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jul 2024 13:20:18 -0700 (PDT)
Message-ID: <ef8519df-a1f4-4f90-9e42-0c8d91bd982d@redhat.com>
Date: Mon, 1 Jul 2024 15:20:17 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2 V2] fat: Convert to new mount api
To: Eric Sandeen <sandeen@sandeen.net>,
 OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
References: <fe6baab2-a7a0-4fb0-9b94-17c58f73ed62@redhat.com>
 <2509d003-7153-4ce3-8a04-bc0e1f00a1d5@redhat.com>
 <72d3f126-ac1c-46d3-b346-6e941f377e1e@redhat.com>
 <87v81p8ahf.fsf@mail.parknet.co.jp>
 <216b2317-cec3-4cfd-9dc2-ed9d29b5c099@sandeen.net>
Content-Language: en-US
From: Eric Sandeen <sandeen@redhat.com>
In-Reply-To: <216b2317-cec3-4cfd-9dc2-ed9d29b5c099@sandeen.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/1/24 12:35 PM, Eric Sandeen wrote:
> On 7/1/24 9:15 AM, OGAWA Hirofumi wrote:
>> Eric Sandeen <sandeen@redhat.com> writes:

[...]

>> [...]
>>
>>> +	/* If user doesn't specify allow_utime, it's initialized from dmask. */
>>> +	if (opts->allow_utime == (unsigned short)-1)
>>> +		opts->allow_utime = ~opts->fs_dmask & (S_IWGRP | S_IWOTH);
>>> +	if (opts->unicode_xlate)
>>> +		opts->utf8 = 0;
>>
>> Probably, this should move to fat_parse_param()?
> 
> In my conversions, I have treated parse_param as simply handling one option at
> a time, and not dealing with combinations, because we don't have the "full view"
> of all options until we are done (previously we parsed everything, and then could
> "clean up" at the bottom of the function). So now, I was handling this sort of
> checking after parsing was complete, and fill_super seemed an OK place to do it.
> 
> But sure - I will look at whether doing it in fat_parse_param makes sense.
> 

I don't think that will work.

For example, for the allow_utime adjustment...

Before parsing begins, allow_utime is defaulted to -1 (unset) and
fs_dmask is defaulted to current_umask()

If we put the 

+	if (opts->allow_utime == (unsigned short)-1)
+		opts->allow_utime = ~opts->fs_dmask & (S_IWGRP | S_IWOTH);

test at the bottom of parse_param, then this sequence of parsing:

("mount -o fs_uid=42,fs_dmask=0XYZ")

fs_uid=42
 --> sets opts->allow_utime to (~opts->fs_dmask & (S_IWGRP | S_IWOTH))
     where fs_dmask is default / current_umask()
fs_dmask=0XYZ
 --> changes fs_dmask from default, but does not update allow_utime which
     was set based on the old fs_dmask

leads to different results than:

("mount -o fs_dmask=0XYZ",fs_uid=42)

fs_dmask=0XYZ
 --> changes fs_dmask from the default
     updates allow_utime based on this user-specified fs_dmask rather than default
fs_uid=42
 --> allow_utime is now set, so no further changes are made

IOWS, the final allow_utime value may differ depending on the order of option
parsing, unless we wait until parsing is complete before we inspect and adjust it.

dhowells did, however, suggest that perhaps these adjustments should generally
be done in get_tree rather than fill_super, so I'll give that a shot.

Sound ok?

-Eric


