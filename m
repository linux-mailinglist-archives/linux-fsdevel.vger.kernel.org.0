Return-Path: <linux-fsdevel+bounces-49783-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BDE4AC26DD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 May 2025 17:55:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1AA247AB454
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 May 2025 15:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F8A92951C5;
	Fri, 23 May 2025 15:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nfkeyPd8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3F719CC29;
	Fri, 23 May 2025 15:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748015689; cv=none; b=n8DD1iDgnYk6Xtylz1GY/O6Odifnr1DMU+qfXKML6Zi6sePEV+dMoiFBnSyyhu+GjL8D5yNwDN1buKgvoG60n+Nwye7oN7AYtTly082qiykchiR6SspTLqr2rkCBLc+HJ6OdjsODrm8q7YAsSQcQbDy6gYEIG6HoBW2M83NmYG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748015689; c=relaxed/simple;
	bh=dvlRE+yueTCZf9ZPCkBUWr5ziJ3xmWLY/dqFBsAi7o0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZG8wY2m5MP1Uc/nnzTQD7S5F+382rCguY3sxNuGxGIcJPcuijmpCIzIY5WG77AGUbqzmn+0OwtamYmX1rXH/qfCaBmbbteC6IyUIym+MDtbcl0id1lfjelQvdsfKGIrCqwXotKY/m84Jb3mrWjNHZMP75mRZJ+Jkcw7XGY85NDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nfkeyPd8; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b26ee6be1ecso7206a12.0;
        Fri, 23 May 2025 08:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748015687; x=1748620487; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=hBPLEqXngN0s3qAab+ltd7UovwG2Np5THGjb05t+0wk=;
        b=nfkeyPd8LCP2D/GUmbHmALgTwOcERjyaWVGbJD9ugMnXSWCVjApx6Mii8g/Op9HHgN
         2SgG0TtgFh4Zy9ouVEn/VhjJa8M7sK3lQY47lw2j/x1pQYltKKKxPVrSggV0Eu1RHs1B
         MSxJyPnpJ6/PTDmgG6KsWuaTZCIaGBjmBOsS8lwi7743NVTiM5GsG72OO+7F47GCvwt5
         bawBD54A1+xdXyP5EX7fKCOvt6t1CDjBIK3/FcKkVUB9jmC2dylYi4MgWQ5M0gaA03sG
         1FykxhfXRTC3QgHa4N0VXo8HTWqmWlO1UYoE91TMZKz943t5pnahG2gs0VSTSpIHsHk2
         deBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748015687; x=1748620487;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hBPLEqXngN0s3qAab+ltd7UovwG2Np5THGjb05t+0wk=;
        b=dwqYWA682LhHp/7NXDOaa4dhwxIgcP8lSvSIDOGYnxrJLmFLl3vAxZkqd2U1LO/wRq
         gRLbAPTvDAHlZaonD+/VMc4t3cWJcZGSuqoA6cmVRRa1uln6nfooQgK77jPvaxReJfDQ
         9oJy9l2hoLpxMwmtgCafAVF6L4g8Q8IqXqlzlToDmMTWfHAPKv9quQ97LFv//EK8d/S1
         +COUwEXG6F4CZBSuJJeI37zlD38j10QzirNRUoSPDXt3J3i7tXiEfAY34deVMboCoczW
         Kz/5GJqGj9KsB8nwZCDgd1WX2dO8NyzMwX5SPM4K/1/XljdfnNTVs2jmIh4SchO6yJ6N
         pkEg==
X-Forwarded-Encrypted: i=1; AJvYcCUFinbtDFVl4HLm+O3odtDQ/7rs+B9im62Vv5jI/62dlW3ysVyjmAC9vV1ome1KFgKOpTrCndzsduxvGKB7@vger.kernel.org, AJvYcCVfqfwI1q4CYiGyhoY7HEkaByD034o042q78cqLhJ+m8wTit3AjFmJwMO4fyu20K8fNYX58P5wr/DpI+YOV@vger.kernel.org
X-Gm-Message-State: AOJu0YyP+dEptWp1M0t8zVVElgwdmncFINIop8N+HKpEfqprXVkebC4h
	ThBK/KFTl9Jdh4Ig4wY9+AJ+kLFh9kjf86tKVIPbDeDUOUylpQbFplLR
X-Gm-Gg: ASbGncvI/SYjPf5zaJfA9uO6osy2wbx2GFzIs71FVjSUantetcjCaNhGpjBmc+4tD27
	CHm5GQmk5GujLF1HQnWF+NElMJEIXp0M1GU9jsAMck8o8SQboAiQfc3dznYD0IHOJ88tAtXSEop
	z/IiBTpl+enAzVN+il/BD+Cc5Drq7V8huoevSgvtNmvMvlXSdJAKL1YDQii+WHSqP7I95NUrCd9
	+D43j894CtFZGXAFLmn0tQ9U0u+QajE8At4NaV6fpyEvqMJrAkXS84vNdHuBMfh9qC4NYbhnoju
	DQOhPISP16fZQt++oGTregOVbBhJH2upIwbAqM/oTpUC1ReoGqSu9vKkbxE2RKrSxXHJVp6pF1x
	aZ0eVf6vu2u9trfcjQVLvx/IA
X-Google-Smtp-Source: AGHT+IFBE63AeVG2/vn9MSpSdK1zUWQegeL5Lc0xb1MluLPspKWvuOzpWzInEVkoD/CVcWfvQwt8+Q==
X-Received: by 2002:a17:903:2301:b0:231:d160:adec with SMTP id d9443c01a7336-231de351d48mr406614755ad.11.1748015686914;
        Fri, 23 May 2025 08:54:46 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4eba4b1sm125798545ad.168.2025.05.23.08.54.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 May 2025 08:54:46 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <d2c93db4-6406-47ec-9096-479aa7d7fd23@roeck-us.net>
Date: Fri, 23 May 2025 08:54:44 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kernel/sysctl-test: Unregister sysctl table after test
 completion
To: Joel Granados <joel.granados@kernel.org>
Cc: Kees Cook <kees@kernel.org>, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Wen Yang <wen.yang@linux.dev>
References: <20250522013211.3341273-1-linux@roeck-us.net>
 <ce50a353-e501-4a22-9742-188edfa2a7b2@roeck-us.net>
 <yaadrvxr76up6j2cixi5hhrxrb4yd6rfus7n3pvh3fv42ahk32@vwiphrfdvj57>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <yaadrvxr76up6j2cixi5hhrxrb4yd6rfus7n3pvh3fv42ahk32@vwiphrfdvj57>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/23/25 08:01, Joel Granados wrote:
> On Thu, May 22, 2025 at 11:53:15AM -0700, Guenter Roeck wrote:
>> On Wed, May 21, 2025 at 06:32:11PM -0700, Guenter Roeck wrote:
>>> One of the sysctl tests registers a valid sysctl table. This operation
>>> is expected to succeed. However, it does not unregister the table after
>>> executing the test. If the code is built as module and the module is
>>> unloaded after the test, the next operation trying to access the table
>>> (such as 'sysctl -a') will trigger a crash.
>>>
>>> Unregister the registered table after test completiion to solve the
>>> problem.
>>>
>>
>> Never mind, I just learned that a very similar patch has been submitted
>> last December or so but was rejected, and that the acceptable (?) fix seems
>> to be stalled.
>>
>> Sorry for the noise.
>>
>> Guenter
> 
> Hey Guenter
> 
> It is part of what is getting sent for 6.16 [1]
> That test will move out of kunit into self-test.
> 

Yes, I was pointed to that. The version I have seen seems to assume that
the test is running as module, because the created sysctl entry is removed
in the module exit function. If built into the kernel, it would leave
the debug entry in place after the test is complete. Also, it moves
the affected set of tests out of the kunit infrastructure. Is that accurate
or a misunderstanding on my side ?

No criticism or objection, I am just trying to understand the direction
of unit testing and specifically of the kunit infrastructure going forward.

Thanks,
Guenter


