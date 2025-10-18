Return-Path: <linux-fsdevel+bounces-64567-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 611B2BED3A4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Oct 2025 18:13:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DEA1A4E69C5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Oct 2025 16:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89F502459D7;
	Sat, 18 Oct 2025 16:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="msvctw3b"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2B923D7E0
	for <linux-fsdevel@vger.kernel.org>; Sat, 18 Oct 2025 16:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760804026; cv=none; b=TvNwbYwRS2JZs/UUtA/WqpE3X6M1UUEYoaBZg2qtHyqa3I7B158H0HSPKr/o7pn0iZ4QGHtCQ21nPlUoxgK60kQtOXaVkjOBC6mKhqhyHOl3zBczzhAnyA4XOfxz7LKNK4PoLahHblYLnrmcCQqbZB0uFMBBF++kzGC8caC45W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760804026; c=relaxed/simple;
	bh=pLKk0UA5x9txz2pzbD022hS7+sQLw1lvQiEUDBqTXvA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=XWGJ/sTt83tWW1CiaNs3BH1eJse7uQJJqQRcz2/WPGrp9sL/NTIJfX9VqrtWgLPqOJBB1FCcn5SD0oay0MtwZqLvcgjW3v1vYh/Plw457UOHAXGsSO/v93WT4BAgXW9JxOwcIiF/7Mvnn4x0UPKY/hS7XBGmJfXaGxQGSoViK1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=msvctw3b; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-47105eb92d8so4796005e9.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 18 Oct 2025 09:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760804022; x=1761408822; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=f0pOHV9nv1hxJzjc+rhs/0yX1sV8PPggM1YFk5/tT9Q=;
        b=msvctw3bfEUxwkWMzay3rarQMRNov/LmVY7Yn7vJIfyMnMa4LdkusMRmkI8nWIQlAd
         hWh8a1jI4f1KXLzfOOC66E4kVhvUl0tu9PMSeJPf+Mm5QNBcHYjpL39RK6XGHBfIYngT
         YWzUW7sp/LTtKUc6AEqeRaN7zl8gkb6RuqYbVNay8stW8NjBbOt/Za06cjYVBG52XhJR
         toKp5E0P2yi5gYNhw7madupKthUAxGGs+eRucPYOSBNuU/JeA5vntm3H70PyxEY8IP0X
         tvaNLzz9jeRRTjOTvNGQgVdoAUBQVKqEvayeH59uNY2NWi8iaqAOLfXzkR7Q606mOsXg
         nc1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760804022; x=1761408822;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f0pOHV9nv1hxJzjc+rhs/0yX1sV8PPggM1YFk5/tT9Q=;
        b=ti7DMm9y7IX8ItxcYqpq7ondKJNkPPwCCRmQZz6ftXmlVmt7VRaOL/yjqD0R89tsa5
         AQdqcO0iFGflFNkFiJzsLWZF6uS1EaqOfPUbxvr4/5Y0kyHDSRUrl+G0305BYJfe5lr7
         vaBISpMfaLhzDICCVT9FM4m/fy4pfZAbAcAoERVXF45p5QuyAQZ8nxQQxWr2UXHNx6MP
         1L4TfRWG3eqH9PwMoO6ssDGVqoOn9htSRm3EiCrdGPAzL2D0oOPpb3E2AV1Cy6RPc3fY
         YWqU8WgTmtRUJSz6dR/VPrsteOveU9CzvKLvCIyhjeLD6k1RXM1a6Jk0SNP3pb1L3Xvd
         3rFw==
X-Forwarded-Encrypted: i=1; AJvYcCWjhlso0YDqCA833vqsrnxAb28JZm3DA96JSdlV8yel2g12PjKPwKl71ktXjQnEduKYBWftqI0aP8YHYqXj@vger.kernel.org
X-Gm-Message-State: AOJu0YwlEcm3/5QQUUrGTj95HTg6JK6xHJDKh2rQVVpgb9MAJQFSN6qS
	PDQgw0Bk95wLmaF+tfw/txMpXpuIPzgRthXGqYo9QAGyhlrMeCPJzPpV
X-Gm-Gg: ASbGnct8ndcrXSjqJv76HgHtnrCK3Taenq/0B9dPNwNcP7zjSROq0IgeMFXrtlYQVSg
	lD0WjSVzlNBSh+Qzgloc+IVkymNz9L7u3Tm9dV8lgXocwo6ercH8uCkhl5KawFDNlVA2AIIuueC
	v/zry0m8Oqyn83y+JW3OiOcsdhE+9v1azhMPLCuTNuGyAEyoQx/X4Aq5OvFKp/Oc0/+7WV0hb6a
	aVJBT8TwzH6FNbrmNH3RV+3d8KrzXOObFmhDVVgofeFCTmyxUt0bSrEsHairD/9oyVPbGvtv5Pt
	F9evljufTf4YnDRUS247o3yiI/EO8cBT7TcCCstPcaHWX/NkdTLS858XJBLnKl8dPdG7dJvy2rO
	cpbRhFuro/jt8U2lLlCAdsrhI8vxyLkSitvhNchOW62CzgWYw67J7oKq4/8KKKJ8eObhMTKpVmO
	sghd6UhEvG9PisqhmePmKqjzJ9Wy31AIM=
X-Google-Smtp-Source: AGHT+IGOxLwcjmXvE3Lb0mSlFrm9lnVnNEmJmV5uOeoSLYYaZp87Dibu/aojvz+uM+vnxkS8QeEjKQ==
X-Received: by 2002:a05:600c:3b8d:b0:471:703:c206 with SMTP id 5b1f17b1804b1-47117917718mr31981905e9.5.1760804022334;
        Sat, 18 Oct 2025 09:13:42 -0700 (PDT)
Received: from [192.168.1.105] ([165.50.121.102])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f009a6c5sm5665372f8f.28.2025.10.18.09.13.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Oct 2025 09:13:42 -0700 (PDT)
Message-ID: <ccaa911b-f405-477e-a542-fe4f6bcb618d@gmail.com>
Date: Sat, 18 Oct 2025 18:13:35 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] init: Use kcalloc() instead of kzalloc()
From: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
 david.hunter.linux@gmail.com, linux-kernel-mentees@lists.linuxfoundation.org
References: <20250930083542.18915-1-mehdi.benhadjkhelifa@gmail.com>
 <20251002023657.GF39973@ZenIV>
 <b0388977-413c-46d0-b0e1-fc8d26ef9323@gmail.com>
Content-Language: en-US
In-Reply-To: <b0388977-413c-46d0-b0e1-fc8d26ef9323@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/3/25 11:40 AM, Mehdi Ben Hadj Khelifa wrote:
> On 10/2/25 3:36 AM, Al Viro wrote:
>> On Tue, Sep 30, 2025 at 09:35:37AM +0100, Mehdi Ben Hadj Khelifa wrote:
>>> Replace kzalloc() with kcalloc() in init/initramfs_test.c since the
>>> calculation inside kzalloc is dynamic and could overflow.
>>
>> Really?  Could you explain how
>>     a) ARRAY_SIZE(local variable) * (CPIO_HDRLEN + PATH_MAX + 3)
>> could possibly be dynamic and
> I missed that c is in local scope.It's already of size 3 and since 
> CPIO_HDRLEN is 110 and PATH_MAX is 4096 + 3, it's far from the limit and 
> it is calculated at compile time since all values are deducible.>     b) 
> just how large would that array have to be for it to "overflow"?
> If c could be of any size, it would have to be of size 1,020,310 for 32- 
> bit kernels and a lot for 64-bit kernels around 4.4 quadrillion 
> elements. Which is unrealistic.
> 
>> Incidentally, here the use of kcalloc would be unidiomatic - it's _not_
>> allocating an array of that many fixed-sized elements.  CPIO_HDRLEN +
>> PATH_MAX + 3 is not an element size - it's an upper bound on the amount
>> of space we might need for a single element.  Chunks of data generated
>> from array elements are placed into that buffer without any gaps -
>> it's really an array of bytes, large enough to fit all of them.
> Yes I get it now. But Even if the CPIO_HDRLEN + PATH_MAX + 3 is the 
> upper bound on the amount of space and in use it doesn't have any gaps 
> in memory, Shouldn't we change kzalloc() to kcalloc() since kzalloc() is 
> deprecated[1]?
> Regards,
> Mehdi Ben Hadj Khelifa
> 
> [1]:https://docs.kernel.org/process/deprecated.html

Hello viro,
I'm just resending reply in case if you missed it.

Best regards,
Mehdi Ben Hadj Khelifa

