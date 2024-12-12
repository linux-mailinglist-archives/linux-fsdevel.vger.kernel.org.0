Return-Path: <linux-fsdevel+bounces-37183-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DD319EEE2C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 16:54:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2FF11694A6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 15:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E65223E7B;
	Thu, 12 Dec 2024 15:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="GYekcX5M"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24FA3223C7D
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Dec 2024 15:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734018510; cv=none; b=BZ1kFjCfIvCtr/+gl38+UZmShHlEY0u19aIMg99/uxiFybWD2oCNXhGUItFIcB9WQ+YbBgAJYAFw4KBV77SpaP35vDjpr+yjj+nBRs3+G5zSNKVByTnuGwfERhsaB3biYnUc/08//fc6UfE380L2yhogClr7FHOjcKnkBGN0AiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734018510; c=relaxed/simple;
	bh=TMFV4DzKyPPAfoOQ6tLwtGLtOGvpKCjN8AV48PlDsoY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JdXSPwE+Rst+byWMrydUq1pd1vtWZfcoqBVKJduG9xbwkCCDKwVOw0RGBe2+pTNH5rRZwHJXqODz2vHsLOkeKkTWFJ2jzq5dDZrs87XBT0Xd5J1JeNWVLk50rqR4fxKO96DX0WBUwfB1OFGQQWaqbUyY05RdkwDHyah6TnBQ+q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=GYekcX5M; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3ad272538e8so2023145ab.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Dec 2024 07:48:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1734018507; x=1734623307; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PvBx/w2DhSklV4ojnPJsBMakpCIKbBPJ0+ZbaVI4zHA=;
        b=GYekcX5MlMuaMNE3LLOO4GQGxJZRFf+TcETm5lJ4cgJ1VNKm5Rs+WEwKI9ProMZjy9
         cy1o5Cm6AOQo29DKT7BrU/7ayQlJuk5TPmNLoWWq9ekxn2s8Nu8HE3+t2WFVLk/O8MgE
         9ez7VN02ATqrCwMHdwUA1rWXeIluVJeBd6ChFoqYbWBvwWh0vEP06z8KspKvD8Dszea1
         pmtBaKerDl+gahaonybh1cw1zcjHywPaSV+v8FynkbLqV1FcH7a8YG6QaL3NkOZYvxkw
         wP0FBl5FC6dHpNdSbJlE8Eb8Aih5ARwNXiqxgEm+P521b3mOBx/sZGOsVLpj3f8CpdjQ
         qhwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734018507; x=1734623307;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PvBx/w2DhSklV4ojnPJsBMakpCIKbBPJ0+ZbaVI4zHA=;
        b=S37tBodaW/UsSKXaJpXpi9zgTJX/a/BblZa50gxRkuulQr6ldFz17kx6AsMbzukEsS
         Ko1FEdSlV1K5x1/IUeaAQTle//DZQz7eieoHrcSd4T5NRswMZoWedsmaxcVUdNx4mgSO
         gl4GL3xBe/QnzZRNYoYnCRmM2oYPXukUlzR7wTlmlM85dnl8e37uCPGc5ZX3FWiBDsMR
         lqcstG33UIYpXyC2gVuiHmwVSR3PZb0ORML/mNS5yZGEymxKYebkjYDei2xoxW67W0vE
         kOUtWQV1qUwfuQaFPpOrJnqaJ18EyJhFF+AmT8JaJAgQD6SLqlaMF1TnwvCiLUrZWSo4
         U8Cw==
X-Forwarded-Encrypted: i=1; AJvYcCWDJUFFmTVSKjjyuEdtXnmDzdEeHZf+qDXO+vsi7sKuF9tr6xFphpvAuPATndMhyaQ++zSWvcnLjl4Wdtja@vger.kernel.org
X-Gm-Message-State: AOJu0Yzwu2WaI0EVwuLHm1M/gzIlHcrn/4AxZa4JcdxDm+iasnAXndRE
	wVUDYDyfjYqQnVsL+KtmXc35ENwKgRMjIIq0JeMuAZ3nRkrfwE+QooBjC+OVYw8=
X-Gm-Gg: ASbGncvVRc05Ii/jr0/CzgdjFRf3avqADlYRrna3HeLQoo8sceC28Y8pIhwKZrLz8sL
	lJz2z05ixo5N4HBc2BP7rZJoIh+Cx2k7lAey8WJY9B8gNGL3ollxMYdMxMxmCSlbROrr1bmItnW
	L3I2f4r078hRkvKSWBILEt8jetkpT+I4YUn/9av6T0w9wYRKA9cPvzV+7o6k2yST3ZNQLU8/jjq
	mslM+GElSWCoZv+CmZ/KZBkHx7spM0PZeDbr1xuuEaKiYYF3Ltd
X-Google-Smtp-Source: AGHT+IHAQGTQIEr3hJAJZPVw8dHIc1jCD+zOwFKHo7t0IBPz9msmAmKUzqJ4fHZUe037ZAO0zcn+QA==
X-Received: by 2002:a05:6e02:214d:b0:3a7:cce2:d349 with SMTP id e9e14a558f8ab-3ae70e32b20mr5044935ab.8.1734018507220;
        Thu, 12 Dec 2024 07:48:27 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a808e1e0d6sm44607975ab.63.2024.12.12.07.48.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2024 07:48:26 -0800 (PST)
Message-ID: <04e11417-cf68-4014-a7f7-e51392352e9d@kernel.dk>
Date: Thu, 12 Dec 2024 08:48:25 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHSET v6 0/12] Uncached buffered IO
To: Christoph Hellwig <hch@infradead.org>, "Darrick J. Wong"
 <djwong@kernel.org>
Cc: "Christoph Lameter (Ampere)" <cl@gentwo.org>, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, hannes@cmpxchg.org, clm@meta.com,
 linux-kernel@vger.kernel.org, willy@infradead.org, kirill@shutemov.name,
 bfoster@redhat.com
References: <20241203153232.92224-2-axboe@kernel.dk>
 <e31a698c-09f0-c551-3dfe-646816905e65@gentwo.org>
 <668f271f-dc44-49e1-b8dc-08e65e1fec23@kernel.dk>
 <36599cce-42ba-ddfb-656f-162548fdb300@gentwo.org>
 <f70b7fa7-f88e-4692-ad07-c1da4aba9300@kernel.dk>
 <20241204055241.GA7820@frogsfrogsfrogs> <Z1gh0lCqkCoUKHtC@infradead.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Z1gh0lCqkCoUKHtC@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/10/24 4:11 AM, Christoph Hellwig wrote:
> On Tue, Dec 03, 2024 at 09:52:41PM -0800, Darrick J. Wong wrote:
>> <shrug> RWF_DONTCACHE, to match {I,DCACHE}_DONTCACHE ? ;)
>>
>> They sound pretty similar ("load this so I can do something with it,
>> evict it immediately if possible") though I wouldn't rely on people
>> outside the kernel being familiar with the existing dontcaches.
> 
> FYI, another word for dontcache.  uncached just has too many conotations
> in the kernel context.

Sure, we can go with DONTCACHE instead. Only thing I don't like about
that is that you can use uncached as a verb and adjective, eg talking
about uncached IO. Talking about dontcached IO sounds pretty weird.

As I've said previously in this and other threads, I don't feel too
strongly about the in-kernel naming, I care more about the exposed
name. And uncached does seem to be the most descriptive and most
easily understandable by users.

-- 
Jens Axboe


