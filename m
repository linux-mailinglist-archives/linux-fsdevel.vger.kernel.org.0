Return-Path: <linux-fsdevel+bounces-40625-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C63A25FBC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 17:19:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F211B1664AF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 16:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8AA920A5F8;
	Mon,  3 Feb 2025 16:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lA5PuIOx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66365204C34
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Feb 2025 16:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738599533; cv=none; b=KIF8C6hNmepIW+cgftDsIoVBVH7cfh9w1tORrHbmStK5r0mjO1Z1agkV6utP7hgzCZuxOw202ZsFWYUmf8SebkUfgjIJ6CjfwO2vIhgtZu2ibo+j3Fb9ndNkPwZuoTC/xjnRu4+RYEhMyDNooPV2FCI2jJuK1pDEp+QmZeuTbh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738599533; c=relaxed/simple;
	bh=wdDEezYDl5/kgYL/Q4CuxwRJtRbSN4iJgwiGJ2QKlp4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nasCF8eCdlMQ1c1QWxH2vNmL8SJj2W5f5yFeAPTExRIa3YG1YN+kbzJ0QPEadXUKhin/ihOy9SWZywfeQ3pUniPrAyv8bZsMXdyvUvNP8Otx9jf4uNI/hLaQ7ncDerTjsGyqFKRMQzOIxt/5RPn7Gwo9D6TE7nfxQ0QF6AK+JGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lA5PuIOx; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-aab925654d9so853825566b.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Feb 2025 08:18:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738599530; x=1739204330; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qsS1FnVegNpSecqEnSpZhNN6asS0PjGWkO0MM9+7pmw=;
        b=lA5PuIOxU5BA3L1AB0zKlGaGoNkIimz0YO684HTIqrT5eDuROiA55oUsQzZSbGau78
         5ESA6hHLZIVUB8qKffSwZudw0ApIwLkGtIEDaxAU/Kc7PNYYLJfdLbp71ahqROe6BOHk
         bX42Z/VRhask7rOBHdbGC9UJaK0TQ1ZJ6Mdx/kmXrph0d/fOtaMFcWYSuf0B05kYCrNT
         mMZjJk2Zz70o6wY7u/yA0XyDosv4u5cBUxaIPbKvChj1h/1pHsb+FusvjhvRPA8mwFdK
         0cRMqavcRiRoZRv9Dd+70mPoI+NCmu7rx7BJgA8uvQRJZYaKnWNCP5wogzl5XKeZXidi
         7plQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738599530; x=1739204330;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qsS1FnVegNpSecqEnSpZhNN6asS0PjGWkO0MM9+7pmw=;
        b=n7UkxS+Ja01dNX4mY1/ytZV1AzYaTp+RJxOSs2PkpKgom0odFXWdYbGMzzAjnBDBug
         kw3sEuY2AjSQ511qH2cB5DeiwPd2eLSKAzCn0EgiOZB52wqg6vXWC9w3nzvGKVZJz5cE
         EaoMGGA3nezHREaOcMKEIcFjqFs9sxrgU6t/tlf6cVrrKw1mZYR4kcKceV27tMhK4VDE
         Uq4VJF+hsYUcy5i/iA16NCr7wy7EVw7d+9mByT8aPWxpnj/MzTc0DXn5tlPWEllMByag
         AKDw+isDPGLYLtG8Y9WByzlbVsko01oK0yTm2R0xbdpFHTk1UW3Wcskf1dCke1pbhN5Y
         8adA==
X-Forwarded-Encrypted: i=1; AJvYcCVIwlTdw8PTjmlojcRqgO7C1I766tUKDGBdDgbEfK9ayu2cTn6FUAMgiXzz8hbUT59uHsSTw+4xkLguqtJ5@vger.kernel.org
X-Gm-Message-State: AOJu0YzdQRGe46wtJfz056KYVR3RbMa+irk3qd8g/vXZWzFwreuINBd0
	bKggFlgfFAWrdclDtLCmFR28idR1pnoQFFL1w0FiqVyXI/Om0ueR
X-Gm-Gg: ASbGncuZ6xm/snDRFr/o0oza5Qtmqe3090Xc7S/LU4MOjr5Ja7+KoUsXwMyaCjzm49o
	uIa0qgxEqlMJpupwJipZzSxP3hL+Val2EzBDuVrtH9T/FEvMCw5feKWRvciWXwdKxbpF4psq++k
	VO0zLHBWuZIpYwQUWciEQ0FeqG3QsX4lU7qKFm70NTeX4+B9SULeDHH0TA3kW162JgaJTBciouk
	hh/3fDmt7MKaI9h1usqlDE3N4UHHDSAUTdCvV2FqiThYgLYzuZAxU1VcIBlXVJppGsVjalwB1DZ
	k+3ULIP42Qoc03Dkvss=
X-Google-Smtp-Source: AGHT+IGb5PF9/DzrmA5xinK0RKh4L3oubsm6720sL8K3HAT6oPNbXpMzYDOcYjxs8XJ0330e5v/Myw==
X-Received: by 2002:a17:907:c51b:b0:aae:83c6:c679 with SMTP id a640c23a62f3a-ab6cfceabbbmr2644304566b.32.1738599528894;
        Mon, 03 Feb 2025 08:18:48 -0800 (PST)
Received: from [10.22.100.77] ([62.212.134.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab6e49ff278sm774739366b.119.2025.02.03.08.18.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Feb 2025 08:18:48 -0800 (PST)
Message-ID: <cf648cfb-7d2d-4c36-8282-fe3333a182c3@gmail.com>
Date: Mon, 3 Feb 2025 17:18:48 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] Design challenges for a new file system that
 needs to support multiple billions of file
To: Amir Goldstein <amir73il@gmail.com>
Cc: lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
 Zach Brown <zab@zabbo.net>, Christian Brauner <brauner@kernel.org>
References: <048dc2db-3d1f-4ada-ac4b-b54bf7080275@gmail.com>
 <CAOQ4uxjN5oedNhZ2kCJC2XLncdkSFMYJOWmSEC3=a-uGjd=w7Q@mail.gmail.com>
Content-Language: en-US
From: Ric Wheeler <ricwheeler@gmail.com>
In-Reply-To: <CAOQ4uxjN5oedNhZ2kCJC2XLncdkSFMYJOWmSEC3=a-uGjd=w7Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2/3/25 4:22 PM, Amir Goldstein wrote:
> On Sun, Feb 2, 2025 at 10:40 PM RIc Wheeler <ricwheeler@gmail.com> wrote:
>>
>> I have always been super interested in how much we can push the
>> scalability limits of file systems and for the workloads we need to
>> support, we need to scale up to supporting absolutely ridiculously large
>> numbers of files (a few billion files doesn't meet the need of the
>> largest customers we support).
>>
> Hi Ric,
>
> Since LSFMM is not about presentations, it would be better if the topic to
> discuss was trying to address specific technical questions that developers
> could discuss.

Totally agree - from the ancient history of LSF (before MM or BPF!) we 
also pushed for discussions over talks.

>
> If a topic cannot generate a discussion on the list, it is not very
> likely that it will
> generate a discussion on-prem.
>
> Where does the scaling with the number of files in a filesystem affect existing
> filesystems? What are the limitations that you need to overcome?

Local file systems like xfs running on "scale up" giant systems (think 
of the old super sized HP Superdomes and the like) would be likely to 
handle this well.

In a lot of ways, ngnfs means to replicate that scalability for "scale 
out" (hate buzz words!) systems that are more affordable. In effect, you 
can size your system by just adding more servers with their local NVME 
devices and build up performance and capacity in an incremental way.

Shared disk file systems like scoutfs which (also GPL'ed but not 
upstream) scale pretty well in file count but have coarse grain locking 
that causes performance bumps and the added complexity of needed RAID 
heads or SAN systems.


>
>> Zach Brown is leading a new project on ngnfs (FOSDEM talk this year gave
>> a good background on this -
>> https://www.fosdem.org/2025/schedule/speaker/zach_brown/).  We are
>> looking at taking advantage of modern low latency NVME devices and
>> today's networks to implement a distributed file system that provides
>> better concurrency that high object counts need and still have the
>> bandwidth needed to support the backend archival systems we feed.
>>
> I heard this talk and it was very interesting.
> Here's a direct link to slides from people who may be too lazy to
> follow 3 clicks:
> https://www.fosdem.org/2025/events/attachments/fosdem-2025-5471-ngnfs-a-distributed-file-system-using-block-granular-consistency/slides/236150/zach-brow_aqVkVuI.pdf
>
> I was both very impressed by the cache coherent rename example
> and very puzzled - I do not know any filesystem where rename can be
> synchronized on a single block io, and looking up ancestors is usually
> done on in-memory dentries, so I may not have understood the example.
>
>> ngnfs as a topic would go into the coherence design (and code) that
>> underpins the increased concurrency it aims to deliver.
>>
>> Clear that the project is in early days compared to most of the proposed
>> content, but it can be useful to spend some of the time on new ideas.
>>
> This sounds like an interesting topic to discuss.
> I would love it if you or Zach could share more details on the list so that more
> people could participate in the discussion leading to LSFMM.
>
> Also, I think it is important to mention, as you told me, that the
> server implementation
> of ngnfs is GPL and to provide some pointers, because IMO this is very important
> when requesting community feedback on a new filesystem.
>
> Thanks,
> Amir.

All of ngnfs is GPL'ed - no non-open source client or similar.


Regards,


Ric



