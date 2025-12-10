Return-Path: <linux-fsdevel+bounces-71045-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C21ACB27F8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Dec 2025 10:10:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 67429300FFBD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Dec 2025 09:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81DD930595B;
	Wed, 10 Dec 2025 09:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=grsecurity.net header.i=@grsecurity.net header.b="DZFaSpvC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0015E1EDA03
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Dec 2025 09:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765357704; cv=none; b=g8bG1gGAagMc2mLOKsbdcgZyi73QpUbKZjCkqsVeGtx/W/b7ytV9PkGLkCSLb5rwupKz6m4Fwo5t/p74hINNDM5xksGEt2t0kdpL9Wjzy/mjBKhpF9eKLW7tdOYKctrel1jZXE3RR+4zJlcO+k3hN9swJyy8Q7Rqt17FcVqI6+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765357704; c=relaxed/simple;
	bh=xGkcVZUCzLLvzOq4lQ2OLxayVkV8X5Vw0/7RxWHIAEY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=uOGB1vOCV5Sbr6H0tA6yGn3jqoF941AxNvGPX6VESvxtbKnEa66opJ0v+4E8+y/RbUDfzjOjmJYKQ6K3EJcaa7dG8AL9I0n1xJedOR13d05h0YQAK4r6SRhomusIO+VelncDuZnQKfTB5VW4PlSR8eltqZ+80PUMux9pouptiGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=grsecurity.net; spf=pass smtp.mailfrom=opensrcsec.com; dkim=pass (2048-bit key) header.d=grsecurity.net header.i=@grsecurity.net header.b=DZFaSpvC; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=grsecurity.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensrcsec.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-42e2e3c0dccso3582610f8f.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Dec 2025 01:08:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=grsecurity.net; s=grsec; t=1765357701; x=1765962501; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:cc:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=eFGSZKgyz5PKuniOct1rMsV8b7Jfvckh/uDn8qyo2tQ=;
        b=DZFaSpvCzpON6yHoJEvOUOh5IglLEGVUt6MMixb8K58IgPRI9lp6zV4An5QkmpDvUk
         ICaRT5fK2aTqoog0TscYgnXKBJdWDY2UJEcUvT4iNkjcff2hWBtZk7Afcynk2WnSFa9o
         v2aQAMgptbsrWr//VfpAot6pbT6kI6zONYxFdgFWOlmokHtY0a3vCYR1dloU3S3Wy1VR
         yO7nBfeNwlP3LCn5x8T69zlkWf91qjWWmpvkVA+kLuPXpLPgLBwkAfZ6IFlMEgY8Qb1p
         peJwL8SpmSbjecDGmcgpO7nBH43HpKBAhoqoY51u8lUmItB6ArhxY7ynUw0D1thWlcRU
         HD9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765357701; x=1765962501;
        h=content-transfer-encoding:in-reply-to:cc:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eFGSZKgyz5PKuniOct1rMsV8b7Jfvckh/uDn8qyo2tQ=;
        b=vMVn7Oe9jMgcP/fCOui2C5kLLvs6ANF6j9qik/hsPy3kx5eBk0yue2zxJHgtp/ocGl
         mh6UnfW2lQGsspBQDFTrDT/E5oPtO3YMVLlgOmUM6uwDOepfxQYi+EIpQbABYvQ/GaOg
         f5qVMPVGV7XGHVz2tWiAkvMbMuYyCY2+2hj01w+o5TP5w4L6kYn6lry0TUTS8IM1t7cI
         jPse3ExNb5w5DKD5XNk/gKNvoWUW/x97iVjghHRqg5LX9RzDJbG8pc+gfHSgSEu0nO8e
         qTJVHtcCQuhPQCfTC84g4tTzhh+HZcLwoDsDeARmXj/sp+kOJGUbYUlQOs4mPLPFjAAm
         ZrOg==
X-Gm-Message-State: AOJu0YyRAjBHYEdYxFeJy5FmGVA1yP7xCf7iokj4clmJGZlv8gv4SI/k
	bynHrLg2XVcm/zqslmxY4+hxfeMA37XJR4bD2+GKxqabF+eUUkBN3i3DemdUZsJ88C0=
X-Gm-Gg: AY/fxX5tPNJwqrhe3gx5PBN3P2SdYOeytFpAqL/ENvGSUbikqjavr+s47UPYxdaeL+n
	nsmcHTbe4RWb0+Uaxee66X2CmLhgZ6wV047S/TsLl2Toie4NA4Vjiqp2En+9/b+QSAtNPb13PL+
	0FgA1uSvZ8CU6RrgoAju9O1wMh8wsenRs4MN8wfZ5yZsXRiSSaBdgAinORkJCDXwWOZJIJhw6V0
	dx6WDwL7Fy5oZXYSTagJOsfrWumk9WiJFwX4Ru1U/Vu33Zu8dLaJwiHYjxGv+IxIyef96KfZ/ZS
	uwXstZoB0Rwb6nqtc9o5Hk8cOsdLM4kjRhl8GHCeUbsxx4DBPRi0wWjP1uUMBW7Z25DKHcCLQjM
	+L+CajEWWCVcdUohAUOfVrGdWd/KpZ5bVjXPRYaZJnPLfKHIOmX2eIfh5ekDsutf0YeBACj7w1S
	HdBVqgSqpZv4tzou3SwATFaBdCFJ+yFHQ5cCjEz6DGYkAHDbHdcNC6/j7r79KIpgsTmZWRogIvE
	v5zk7wuiCBo+T69J0vvvzsZEJfj3On+Wz/8h0TwYIGS7Q==
X-Google-Smtp-Source: AGHT+IF+bmv5DJxtoF33Y2/6VkyXuFcNDyGVOEnmztaVmLguYEZ72kLuSfT1A3w0t0K0vz2zq2++XQ==
X-Received: by 2002:a05:6000:2409:b0:42b:3090:2680 with SMTP id ffacd0b85a97d-42fa39ced51mr1720192f8f.10.1765357701050;
        Wed, 10 Dec 2025 01:08:21 -0800 (PST)
Received: from ?IPV6:2003:fa:af29:b100:e8b2:7dbf:b11:65fc? (p200300faaf29b100e8b27dbf0b1165fc.dip0.t-ipconnect.de. [2003:fa:af29:b100:e8b2:7dbf:b11:65fc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7cbe9032sm34232623f8f.1.2025.12.10.01.08.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Dec 2025 01:08:20 -0800 (PST)
Message-ID: <3cb859da-6ef1-4e68-8dc9-fe1845761b06@grsecurity.net>
Date: Wed, 10 Dec 2025 10:08:20 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: media: mc: fix potential use-after-free in media_request_alloc()
To: linux-media@vger.kernel.org, Christian Brauner <brauner@kernel.org>
References: <20251209210903.603958-1-minipli@grsecurity.net>
 <69389178.050a0220.3dc1cb.281b@mx.google.com>
Content-Language: en-US, de-DE
From: Mathias Krause <minipli@grsecurity.net>
Autocrypt: addr=minipli@grsecurity.net; keydata=
 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
 RzDVkdgPJkL/NFTKZHo5foFXNi89kA==
Cc: linux-fsdevel@vger.kernel.org
In-Reply-To: <69389178.050a0220.3dc1cb.281b@mx.google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09.12.25 22:15, Patchwork Integration wrote:
> Dear Mathias Krause:
> 
> Thanks for your patches! Unfortunately the Media CI robot has not been
> able to test them.
> 
> Make sure that the whole series 20251209210903.603958-1-minipli@grsecurity.net is
> available at lore. And that it can be cherry-picked on top the "next"
> branch of "https://gitlab.freedesktop.org/linux-media/media-committers.git".
> 
> You can try something like this:
>     git fetch https://gitlab.freedesktop.org/linux-media/media-committers.git next
>     git checkout FETCH_HEAD
>     b4 shazam 20251209210903.603958-1-minipli@grsecurity.net
> 
> Error message:
> Trying branch next f7231cff1f3ff8259bef02dc4999bc132abf29cf...
> Running in OFFLINE mode
> Analyzing 1 messages in the thread
> Checking attestation on all messages, may take a moment...
> ---
>   [PATCH] media: mc: fix potential use-after-free in media_request_alloc()
>     + Link: https://lore.kernel.org/r/20251209210903.603958-1-minipli@grsecurity.net
> ---
> Total patches: 1
> ---
> Applying: media: mc: fix potential use-after-free in media_request_alloc()
> Patch failed at 0001 media: mc: fix potential use-after-free in media_request_alloc()
> [...]
> error: patch failed: drivers/media/mc/mc-request.c:315
> error: drivers/media/mc/mc-request.c: patch does not apply
> [...]

Yeah, that's because media-committers.git#next doesn't yet have commit
6f504cbf108a ("media: convert media_request_alloc() to FD_PREPARE()")
which was only recently integrated upstream during the merge window.

Maybe Christian should take the fix instead, as it was his pull
request[1] that introduced the bug?

Thanks,
Mathias

[1] https://git.kernel.org/linus/1b5dd29869b1

