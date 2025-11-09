Return-Path: <linux-fsdevel+bounces-67591-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D30B2C4421B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 09 Nov 2025 17:14:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 316BD3B347F
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Nov 2025 16:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17730301025;
	Sun,  9 Nov 2025 16:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IQ/fnqaZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C763009C0
	for <linux-fsdevel@vger.kernel.org>; Sun,  9 Nov 2025 16:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762704829; cv=none; b=Lof748TxvZyS+MYttLltGXEgQ3N/Xg4U3dT4KRhkS6j//dXFW5Z2P6IjJHqKS4u/gYDyIrA2m7RoKVEaLgHopjBIaz/m0IzCTjAn9NhP6e8rc/c4wwCH6ciI3JfHRJonK86agj2EupXmS7NUeuufOY3hN7VesKRQ8lBepNcqSqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762704829; c=relaxed/simple;
	bh=+4+bYhDhJXiL726cnMpcrCI1T81x+W6JPXOARnAf2wY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fuSGHQIanabD/cpFVrdLltKXEsoY9KWAZ9fX3QbqFzcYiRmD9+r8Akccx3bmDz7L4UcIeMIK+kLui0nyGPYj9sa/BMsFrvS5uXaR8aqtrWETB5ehOyezvJyFBiF9hStqwOefiMZOXnIun6XO79ylpt/Msd28UbVZs91DQZCp5KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IQ/fnqaZ; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-47777000dadso5330655e9.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 09 Nov 2025 08:13:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762704825; x=1763309625; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+02kLjHGU/Uou2Bb4YXv+quy1V5TVS2wJ3k/zt0/eGY=;
        b=IQ/fnqaZrXjAgxg8YXo4/2kH5Xx7XSY7gyEQkZu1XJqxSOpQQWtEuKM/dq35NJy/cu
         OHnFTpezgZmMNxxEwhiX7gJ7d9bTvuBKL0C2D3Xbzk7KqFvK22fAX4cAYe0J2pMZ6yzu
         UJcUUYkIsndYFexRX8N3EJJKkggiYZHpwJQgKKr7MyNLz/aDZHCxdFHsdTl0XKbwVygt
         3rua42/Gc9fXu2VHYFaD4puwFttcizDzEVGp2YO+cuDoWBArLXf2UVRBNLmR38Rbni7d
         sZCbAhx7/TG+pLHDtaOkBtd6N6sA1mugz/xTX3HINjMV6jFxRKijDWqW5NSvAYpuQRfv
         +gpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762704825; x=1763309625;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+02kLjHGU/Uou2Bb4YXv+quy1V5TVS2wJ3k/zt0/eGY=;
        b=csY7NfYZWRncdPd52HQ4aZY4pAqqcH0c5eODppwXEhNCZ9bn6RQ5D5EoDE3AV0irdz
         T+cA3BnsTHUcbz8/Jw4eC07lLA43NINTRBYEmfqWpFUqloGt3IQqDDmx6xjY3LqDGGRB
         n/SoCq6mbjhBA6Qvvf3Sy30LteCxLU+Nofc1Ti0qFMBzIHm7/bF087KtLLtUspjWNxvP
         Qf1RGyUZ0ARj0WdcAztNx1l4ZKrw/kabxMaDuB543iOCCByRfz1cvbrM8YBm+D938xCh
         kyLjEN7+d8SXm7ygjq/0PZMKEFXffkD0KSz43ers8L+5GBDlxgnflw6ulvLIOcsEYzat
         7KwA==
X-Forwarded-Encrypted: i=1; AJvYcCUrgmCTLeAMO5yK5nvH0PzIxo4W5xngRrAXlgIdtk2OjMqgKBwSJ5BLOGdSaXfXZuCbW7nEuRsu1D2IgENE@vger.kernel.org
X-Gm-Message-State: AOJu0YwrbzMH//mbcrik8f3UqvCdrqFHms0scX2iDN/BKjuxnWlPuRWi
	FfWQ+LmGQO/Yn+UOHJlv4NpqixHqiA8aNdAb2V+PzuqiWQqbil4pG/aD
X-Gm-Gg: ASbGncuY+IfgEGcaYVON/ZzKHaAdmsHMwnNA/JDJeDZVUdUtBuY0fYE+rvjvYnBsLou
	c+BS5joG0xsrCmfYp5kNmOvo3rTdV/F948RV47ltiy/s0+x5ZBtUAFYqhI39XiWC+IfJ/QcHvZx
	IBbvyysRHPB4un2uyXYCYVzjvOUX3kd0mGxWr4YqNcJpT9YTRqK1scD1F7cYtSVy1ffP2XSZzjg
	5wGnWutS8iK/8Lcp5EpEk00LOEWPqApdAXkEuXSYUDwld53BBLIcs3Ynq+HG9aHOZxOU0Jc3L36
	e+cf8Ct4k1/TClgjUUCR8qXbsdzqqvA3IStgc5AWD6evuv+fTW4fy1eXjReQHKyTM9a9NjkD43R
	WUQ5wdb4o2GukM3StXfYAr+3VSlZIN9EXPJ6wNS9qM+kuz2yyyytP839fPtCZ3IKfxpYs5t/yxa
	RFbCksUKwyh3nYxr3OIgcYfqVAHJxmNJ805rnaj08J8Q==
X-Google-Smtp-Source: AGHT+IHmTHsdU2+Rz4LNGoC3vyXFsyNFTJexIZWocPy0zzCcRp/UzmZAoOUkQHxXn9FhsXI+vpUzwQ==
X-Received: by 2002:a05:600c:4583:b0:477:19b7:d3c0 with SMTP id 5b1f17b1804b1-4777322d955mr43906385e9.2.1762704824735;
        Sun, 09 Nov 2025 08:13:44 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47763e73247sm88933425e9.7.2025.11.09.08.13.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 08:13:44 -0800 (PST)
Date: Sun, 9 Nov 2025 16:13:42 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Masaharu Noguchi <nogunix@gmail.com>
Cc: jesperjuhl76@gmail.com, Jeff Layton <jlayton@kernel.org>, Chuck Lever
 <chuck.lever@oracle.com>, Alexander Aring <alex.aring@gmail.com>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] uapi: fcntl: guard AT_RENAME_* aliases
Message-ID: <20251109161342.497e7e7e@pumpkin>
In-Reply-To: <20251109071304.2415982-2-nogunix@gmail.com>
References: <CAHaCkme7C8LDpWVX8TnDQQ+feWeQy_SA3HYfpyyPNFee_+Z2EA@mail.gmail.com>
	<20251109071304.2415982-1-nogunix@gmail.com>
	<20251109071304.2415982-2-nogunix@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  9 Nov 2025 16:13:03 +0900
Masaharu Noguchi <nogunix@gmail.com> wrote:

> Signed-off-by: Masaharu Noguchi <nogunix@gmail.com>
> ---
>  include/uapi/linux/fcntl.h | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
> index 3741ea1b73d8..e3026381fbe7 100644
> --- a/include/uapi/linux/fcntl.h
> +++ b/include/uapi/linux/fcntl.h
> @@ -157,9 +157,15 @@
>   */
>  
>  /* Flags for renameat2(2) (must match legacy RENAME_* flags). */
> +#ifndef AT_RENAME_NOREPLACE
>  #define AT_RENAME_NOREPLACE	0x0001
> +#endif
> +#ifndef AT_RENAME_EXCHANGE
>  #define AT_RENAME_EXCHANGE	0x0002
> +#endif
> +#ifndef AT_RENAME_WHITEOUT
>  #define AT_RENAME_WHITEOUT	0x0004
> +#endif

That looks like the start of an 'accident waiting to happen'.
Either #undef the constants so that code is guaranteed to get the 'uapi' values,
or do explicit checks, eg:

/* stdio.h may have defined AT_RENAME_NOREPLACE */
#if !defined(AT_RENAME_NOREPLACE) || AT_RENAME_NOREPLACE != 0x0001
#define AT_RENAME_NOREPLACE 0x0001
#endif

	David


>  
>  /* Flag for faccessat(2). */
>  #define AT_EACCESS		0x200	/* Test access permitted for


