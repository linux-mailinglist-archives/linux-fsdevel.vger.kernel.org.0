Return-Path: <linux-fsdevel+bounces-34091-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B9C39C2580
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2024 20:23:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4E7A1C22AAE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2024 19:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 296171AA1EA;
	Fri,  8 Nov 2024 19:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="voy5FYwR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67CA233D6B
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Nov 2024 19:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731093802; cv=none; b=ECAKpX1/MDWPDs/j9aR4RdMafVFmGn29HwmOdlbnZ+gHr3hHvHHeOn+zA5y/P/R61U05rSqUokV0jR1PcxGk6NaKq58afmYQX4Q2ilprI3d51ZTmy+Rtp2xLjQed/np+x08JVTuCo1CoNPXwwXze1xBCt453Hx9gXUWJBd6Dl7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731093802; c=relaxed/simple;
	bh=1X7JLYtlrptg55OrXWwa9P8Z92gMEAjTs8uvp4LZfA8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lWfzLYF34ucwwhhY8Q86O7CPo3+mYC0NccEuz5wrwHFgPRNPbGu7sSlzP0NICKWNHKXCPkZOtW3qRvbJs6nBsV94fpyjQPgc7Dj/chPAnwN9Fm2fO5e/sFOi8O8I2joSycgmKmhssNsm8J2bB9jUNYcHH4JbKyh7fb4dUNCPzJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=voy5FYwR; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-720be27db27so2072727b3a.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Nov 2024 11:23:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731093800; x=1731698600; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Sdbg9gcnJczABHk4QBqJ5vtKlutkOJQgskA5FFfGzPs=;
        b=voy5FYwR24I1wzC8ZwWYScIM/dt61YwcHZn5BBp09VOhH6VZ319n3wN4oFHvuPk93e
         Tjk69Lel1nJCpeZKv93cVfsg7GlhtLaxk0pngBGm9xP5Uv5cw0wvmeFQ6VkPmCylf2EQ
         x4/lBntbYVihvrwoXm0+gQttSSib23hUfFUTwM0p/gRwNVq+YAyT1iYDAto4r8IrgyEN
         lMwKJnimw6p7+XyN29E+U/56l1UlrC2Ub6xU5Z6770kWnEbNc/X9tstlzB3b7Pz1O+aX
         uOhyywRU8wRfFkPDBs/gGzImYN8F0uyZbYBC0A8vMjf+rgq/j6dfV7+moFnikT9iCmRr
         VKUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731093800; x=1731698600;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Sdbg9gcnJczABHk4QBqJ5vtKlutkOJQgskA5FFfGzPs=;
        b=ZAazbuYTzyeTw2CeJiHgxDOofstOBUCUWvwcHmkxd3BycB3demyM0qBAq47EKanjfF
         93EqRY732/Ti3QQDWqlRYkDjH6jpocpkBissnwAHLBFS8gINyFituLL4drXTW67eL4Af
         Gso5NVQVHQTCegs8zp/xgpMEq0ll98scGabE8pbnAHXXv6r/5v/YXaAuWTJEzNTXvosr
         ShFFYT8O+8fqO92LHbfPPyfvhqfZD7SDBB98K3aqCJ5auBN56Q9Tek4cRN94aWvE3/Fk
         xnlbxHoqvRLTNbKljTaG5OBJRKbBKJO3o+FR2+YYVUwWKoVds658EmSMcPxZVqnWHY64
         6w5g==
X-Forwarded-Encrypted: i=1; AJvYcCU6Qt3vrjWHWdNmkfFRLW0HIeKaLbeh1sTkQ0lvylUYZhq4t/PyXZF37XWwihWSdEV507sO3zxn5nT3wR98@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8qfJF7Ik9KtuPtA4LED4nfrIGon5/9RRGrI1JsVZ89c2ZgNS7
	HFweigDt9CuiQUP3QBjmyhHx01USoDMMGdCZ1VxXU3o9eERFcdjrQL6i79WOWXqvUk8a7pgeELV
	PWPk=
X-Google-Smtp-Source: AGHT+IHHCavtzY8pfAh/RcRCXOmyqb2XFAmbo9Hz9KNi5mbeZrG+URDGuMcMVIUYVOINSPHeUOHtLw==
X-Received: by 2002:a05:6a20:840d:b0:1db:dfc7:d86e with SMTP id adf61e73a8af0-1dc22b928ccmr4223392637.45.1731093800125;
        Fri, 08 Nov 2024 11:23:20 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724078ce2d0sm4140167b3a.89.2024.11.08.11.23.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Nov 2024 11:23:19 -0800 (PST)
Message-ID: <27db341c-253b-45b2-9b18-c75a2655fd75@kernel.dk>
Date: Fri, 8 Nov 2024 12:23:18 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/13] fs: add FOP_UNCACHED flag
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, hannes@cmpxchg.org,
 clm@meta.com, linux-kernel@vger.kernel.org
References: <20241108174505.1214230-1-axboe@kernel.dk>
 <20241108174505.1214230-8-axboe@kernel.dk>
 <Zy5YHDj-8DaSP8n2@casper.infradead.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Zy5YHDj-8DaSP8n2@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/8/24 11:27 AM, Matthew Wilcox wrote:
> On Fri, Nov 08, 2024 at 10:43:30AM -0700, Jens Axboe wrote:
>> +	if (flags & RWF_UNCACHED) {
> 
> You introduce RWF_UNCACHED in the next patch, so this one's a bisection
> hazard.

Oops, I did reshuffle before sending. I'll sort that out.

-- 
Jens Axboe


