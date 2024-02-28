Return-Path: <linux-fsdevel+bounces-13129-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EBFE86B838
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 20:34:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2417828A5A0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 19:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC6BD15E5CA;
	Wed, 28 Feb 2024 19:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kPI9tUbD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4F57443C;
	Wed, 28 Feb 2024 19:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709148822; cv=none; b=pIruTEyksF2K4t4DVjjIoj/lRELxqvYc+nNStdpcWED8ByLcGFZNFFMu2G9EWXnwqMVrNibxefFP8qPTuZeKzpy8+rneCMXNcCaiRxWM54zNlePt/apP/xyK2/GRsckqpcAQoEFV5PLigEXowCNqL+5jKEubHI8mo7lsBOIfejM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709148822; c=relaxed/simple;
	bh=dxC+hAlOq10B4bZ7HZJwDTmNSm7HvXRBIG7Yteyn+F0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lqu6T9fiAgwjrhlWU/GOr5qTpdyaaG7LLywRJ01BqAMDwGJf/bqI26pPTs5BYHmVcemikeSFecb5tIzrdST4htfg+G0M0eWNcEtemgi7qCS4GM+i5DwtM8FqVH8gKNe8R524eU46um0OaCTuOpiz5Yax0ZiI46XSF0YElLmW4M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kPI9tUbD; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-7c7c9846910so2248139f.1;
        Wed, 28 Feb 2024 11:33:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709148820; x=1709753620; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=u8mM2p+az2pSDmE4hT9LVCRHJtuOLCaAXLm78LG7ajk=;
        b=kPI9tUbDr+bhqvCstO3kjYe6+89coMKJNOySaSqhLlWKARKlo5AqbGn3AcFFtJQSj3
         1Ew8DqkuR6ihY3p7skM7ZFivVySgbs643o6+cFC7h61P7QzWKgA4S4tfd7QdmprwnQ2S
         O+xk2zOT5bg9x06J/2M+oaz/nawYDWa6g1O0qLrXit4QTPfb0vOwRicWAOVi8xB4UnVS
         Z8u2qwJXei49CWNAoXQvsdEtdpFqf+Wq3NwgYDHXTUs8sOwb7DNxBiyaPk4AGP0kA/z1
         WukyrM8Vy4orsDnZCTZe1apxh3xagDld+qMivyCMkIbNirJTETIgd+d/E1T0Lbw/YiwQ
         3Z2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709148820; x=1709753620;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u8mM2p+az2pSDmE4hT9LVCRHJtuOLCaAXLm78LG7ajk=;
        b=SdNCr4FdNL5QFk3Mu6ZTpH8Ke+PmhmiuMeulqBzZGjKWJmJGlvalALUVeroDf351wz
         CoD2AtvRKOl1AU9+4ox830ZqBk7oplP35CywgIrfJzEcAjtnq/wqp3FGPOB1nLzz+J+O
         OnJJNwLN/GtxtiTYRhnXjZAMwXG4R/UsNbF6FpWdWnSsV1CbXRjoDc1xqKPXqKCavO31
         04KtFSuyDRJcrgf62+KHSH9fB0q0LIsYrZzrhlUkB1ckvNDO4A+eH6fxxlentemcBy2v
         nFl29Ot35KIRW8Ubv2Pb8jhqo2tNLhnC5fVqPz7q15+6gED8NSSvnKWTg7nKg6+luHsD
         QGGg==
X-Forwarded-Encrypted: i=1; AJvYcCVP+VtF4wL6PApbdnuNzdfnIFrER0hn1b6smcTLLxy2f/FDRGR31vriaTM6SRWzSA4UFQEkxFhhyYXjxwJUPS8i2seHqcQzQj9bNLz/QVlLGtbIzKtIUAKDLk6Uo93rLt7c5QQcW0UOEbo=
X-Gm-Message-State: AOJu0YzUQTHsyYVF4t2QYfm8N144PhWC3a+asoSBiLKuSv2ZO2kCPqzm
	wDWu9vJlyDmSfhxG1VcCWI/wWvBthFNS2+JxzkgItsELT8+Vdh6U
X-Google-Smtp-Source: AGHT+IGARzIk+E5EMnBMCtfIC7bdhVsSuEorAoYVZ+sT5XHXfRyxzB07QTpnHnWS/4a+8U8Et+6/YA==
X-Received: by 2002:a6b:e412:0:b0:7c7:d2f2:fe90 with SMTP id u18-20020a6be412000000b007c7d2f2fe90mr169055iog.7.1709148819783;
        Wed, 28 Feb 2024 11:33:39 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k25-20020a02c659000000b00474420a484esm4076jan.98.2024.02.28.11.33.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Feb 2024 11:33:38 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <7e1c18e3-7523-4fe6-affe-d3f143ad79e3@roeck-us.net>
Date: Wed, 28 Feb 2024 11:33:36 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ext4_mballoc_test: Internal error: Oops: map_id_range_down
 (kernel/user_namespace.c:318)
Content-Language: en-US
To: =?UTF-8?Q?Daniel_D=C3=ADaz?= <daniel.diaz@linaro.org>,
 Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: open list <linux-kernel@vger.kernel.org>,
 linux-ext4 <linux-ext4@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
 lkft-triage@lists.linaro.org, Jan Kara <jack@suse.cz>,
 Andreas Dilger <adilger.kernel@dilger.ca>, Theodore Ts'o <tytso@mit.edu>,
 Christian Brauner <brauner@kernel.org>, Randy Dunlap
 <rdunlap@infradead.org>, shikemeng@huaweicloud.com,
 Arnd Bergmann <arnd@arndb.de>, Dan Carpenter <dan.carpenter@linaro.org>
References: <CA+G9fYvnjDcmVBPwbPwhFDMewPiFj6z69iiPJrjjCP4Z7Q4AbQ@mail.gmail.com>
 <CAEUSe79PhGgg4-3ucMAzSE4fgXqgynAY_t8Xp+yiuZsw4Aj1jg@mail.gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <CAEUSe79PhGgg4-3ucMAzSE4fgXqgynAY_t8Xp+yiuZsw4Aj1jg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/28/24 11:26, Daniel Díaz wrote:
> Hello!
> 
> On Wed, 28 Feb 2024 at 12:19, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>> Kunit ext4_mballoc_test tests found following kernel oops on Linux next.
>> All ways reproducible on all the architectures and steps to reproduce shared
>> in the bottom of this email.
>>
>> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>>

[ ... ]

> +Guenter. Just the thing we were talking about, at about the same time.
> 

Good that others see the same problem. Thanks a lot for reporting!

Guenter


