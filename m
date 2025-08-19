Return-Path: <linux-fsdevel+bounces-58316-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E323EB2C839
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 17:16:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F54B5609DD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 15:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B480127FB2D;
	Tue, 19 Aug 2025 15:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="CCEsgIa7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F7D21772D
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 Aug 2025 15:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755616294; cv=none; b=JEUXQf2/WCEV19+C+dmE+KpNY5hKr/s8P0j3Tup9H8P5MEXuVqGrC3tZ5qKxDXIiZ6kXLf2hWzzprH8zrkgVAIxA8Va+88XszG+LpzM+/9ouvVL4R94U/ZjYbRuVfWVL82gnT5td5UdzAtAAPEaMoTiqSzgUqfGV39eGncODUNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755616294; c=relaxed/simple;
	bh=QycJOek0v5nhJbP+MM3OL5pORRB5+KjDcuVnGbqGgEs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=oP0D4lPPmgrWckfdLjvmSe4uC7/n1HugZElqFk3O3SDD3zWcvURdRLz52JEojBkMLfAVdftswCLGTIZRcNlKrI0Bm+Lb+Ou6KsvsoZqT/mN1t/Ov50ejOb8SA59wYYgN/yxarcQ4F9GJc8HE8LwZ5u971NkvFR1AaU+KLtepEXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=CCEsgIa7; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3e57376f655so42446885ab.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Aug 2025 08:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1755616290; x=1756221090; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XJa+KTXC3mY3I1CFmfiLeW6ge9cWEkwQYxycSXbruFw=;
        b=CCEsgIa7xYOHvvlqiCVHe4ie/qZUUblJzn4Nn4zr3bH3GFuHl14BSH8r8ga/rpLdWY
         q+9cjg1h2aSWmnK4CDPyuhgk2wkY7ieSwu97m4qzPsgBicZVkwrRbzCaCzYYYEGJfzLY
         bZl8+bxAt/qLxqOADPEg8gJZf2nEB29m6nCr7Z00ty7EbEpSQjfGHxG5R8Oc+32sF1tF
         /IuUaeuRPP7IhkBc+vPbBR+hPPB+oGXsG85wQ6YXiud3Y8MKTuUV9P5SpdqIUNOKD8pb
         VI7Uw+eQxcjWL1lvRtp98o7hcBZwcaqzACXpjBMCXv+1Wzejtq9ohnbmg8LAaUK0AN08
         Lzpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755616290; x=1756221090;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XJa+KTXC3mY3I1CFmfiLeW6ge9cWEkwQYxycSXbruFw=;
        b=oLMfqH+MmpIj5IqXbzWZihT8vC1GVwJu8dbTmZYPJPO6RRbPJSREoEcbRneWADtiKj
         NE5tWSLLAqvwqrbEPlLBCda1t+/FJto6qIexziwYDXB3fKze5inq6BL5FJwyhIsXi0gb
         6lCuzhODNbpXt0qpQ9vLflHFAM99EGbo9iEu/e0rHw0/rf/kyCKVtHorFvcOrQWuQIBU
         yRhixnczd++dHsBjcEUKMBx8zrNN04895a3eFgTwJBhNW2X9RLyCgqHGBUshuofJhoHK
         RWFr2c3SgzzUlmIdl6Hf0olmleCfNkHLyDH19hyix8GlsVH+V8AmoLfknXMC0PUNip6R
         PPaw==
X-Forwarded-Encrypted: i=1; AJvYcCWWIdbC+ZOd5yuu4I3YBqaiSdM6ZRjLZxrm/0PYemZx//XV0ezLz6niU26XRCnuul/+RXUAA96GS+iQZo4F@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/GsFrAS0SFaLAdw4hJ4kxRG/p4fmzmOtElqiBY5CzO3YSStbV
	+obm6ozS4WRgnRned96r73QFrT5Rpayu3D5gqW9X0oB5qVlbpuXv/uEeu7G/1K1xNO8=
X-Gm-Gg: ASbGnctbK6tIb5vM9R4avmqGi/3llrt1jKQQCrtNW/kELy4Q8rdMAts3v6+DlBdggDH
	4lW83xOikguYIXKB0Z3ukyRD0RPIJmOzXD7Xkf1zKDzaxJrvWkBuiRjS4ZdNhUgYiMT90a0U8qP
	k6FCmT2YCCy96tJP3Zc9YvplOM67NQqzrkGfFTQz148a8qchJHMcOtxvgl0Jx2Q0/rxDdED0ESX
	JL+Pv4f/gtckRycBs0qBCGilzGihZN0icdjZ5rggdGEToj3JvYiO5jOJtOr8uGob2TASyXSCo4v
	K/QsWQavY6a8yvGAUzQCb54xlYHUaTnjpGbnL80sbpkwiuIEGJyeVhOhYU0lTJw8nQourzZ+zPF
	xsUnCmWY6JRY4zxSvFwiaK8pX7yZ6Vw==
X-Google-Smtp-Source: AGHT+IFY0exKSpm0+f6H/wzlf9xavbPn8hy9QGoJ0cK7LCW8RzIzjH4Cjwh92XwtseArqsfz0PbY1w==
X-Received: by 2002:a05:6e02:1549:b0:3e5:262b:8303 with SMTP id e9e14a558f8ab-3e67665cad6mr49090925ab.20.1755616290212;
        Tue, 19 Aug 2025 08:11:30 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3e58398cce3sm38224325ab.19.2025.08.19.08.11.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Aug 2025 08:11:29 -0700 (PDT)
Message-ID: <e914d653-a1b6-477d-8afa-0680a703d68f@kernel.dk>
Date: Tue, 19 Aug 2025 09:11:28 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHSET RFC 0/6] add support for name_to, open_by_handle_at(2)
 to io_uring
To: Thomas Bertschinger <tahbertschinger@gmail.com>,
 io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 viro@zeniv.linux.org.uk, brauner@kernel.org, linux-nfs@vger.kernel.org
References: <20250814235431.995876-1-tahbertschinger@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250814235431.995876-1-tahbertschinger@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

I'll take a look at this, but wanted to mention that I dabbled in this
too a while ago, here's what I had:

https://git.kernel.dk/cgit/linux/log/?h=io_uring-handle

Probably pretty incomplete, but I did try and handle some of the
cases that won't block to avoid spurious -EAGAIN and io-wq usage.

Anyway, take a look at that too, and I'll take a look at your probably
more complete set.

-- 
Jens Axboe


