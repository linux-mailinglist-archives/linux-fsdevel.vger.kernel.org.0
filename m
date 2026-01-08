Return-Path: <linux-fsdevel+bounces-72808-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B3ED2D03CFA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 08 Jan 2026 16:25:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D09743040347
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jan 2026 15:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A0C3033D1;
	Thu,  8 Jan 2026 09:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lgH3Ccy6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8715344EE42
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Jan 2026 09:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767864620; cv=none; b=OEs8Hho9ewA7iACsjMV/zwRrMQlNkWkiHnLVnjlBBrlf9C39QmfahG3B45CzaXUyhqbu4Gj9tCwm6dNE2hxsEsN4YP6d3g9kjMSzpLmU4Wp+ArbuO8nbWTFuqYNPmC+ueYnhlb87MSlvSxiVl4xDPFji6I//abekvkuW/svO6BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767864620; c=relaxed/simple;
	bh=MHhOHGsRzwofCR1asR1r+Dq8f8yikazgYrATxWvUMbA=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Pun5Q3pkjd7AL1UyubkSj48lcCxn7IVgyY61n5+1RuRCqNw1AUiqiyL+2er6/1SyJWOiMjL4SJ33Hxh6b6ejCWHKCVsRlrDZfkCa+UV0HO8nLoczWQD+Tf+0yHePRq88RSDL86e4wdMBqp2sGR2RHhHCwNfxQKVKzyIKelBRd+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lgH3Ccy6; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7aa9be9f03aso1887787b3a.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Jan 2026 01:30:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767864612; x=1768469412; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:cc:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2BZj+c9peL3DJDhE+3l/bTa4UM4O6gj9bpwLXw91wmE=;
        b=lgH3Ccy6pF1pqHBAconMDBabWSCXjarBdsu+Zb5j3P46U2rLLUBg1MSsIUTemniExp
         tfF40sr+5HHMGku3bMHljHcyUgJKjYhTNmPYi1OlVw5aqU4B/PSVn5ZD5E3iN7fvXOqf
         AziXq1oQCGiys42UhvpOn2oW6zFOG4405sVzy5okYferCXWX86sSy+XBg9s29Dkn/Yld
         8YWHOXZnik6Y09Z/efAbVFhIefCMsLW4Z6jIVSpgktiImT6H3Z/EVU3R4EV6KKkZGwGa
         6R2ejLAYQM6HpiZHl8H9WXo+rG+93ZihCa+W2A0idRIdSmPAvlBueVLzPFgnX3xDuEsv
         ZDiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767864612; x=1768469412;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:cc:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2BZj+c9peL3DJDhE+3l/bTa4UM4O6gj9bpwLXw91wmE=;
        b=VC+ZTA+Vm30c8KTnt5/xpVrsbVyCvJMfKvFUfaQeIRf9QWG0Eg4XkEvU/6w9Nb7Rw0
         cXMTBzij4Dch23M3yPMNEQ0E82nQv7XuJIM6TY7EaS/pxGuSJRQ6+MLLhDmN7xo07VLq
         S7WwRpXIIIMIiSkidWGWkwayFlfHW5EFM3rGigGkEDxAOa3dFt77T30ydj4t4qgo9kNj
         pV1Kju775zP8ULiry7ypeLzNAEE6MElkPpbniknjYQmg5TLukZl/E8iLVuoM+aO6jvDe
         6VR5fE6Xcd1Mhh3c+Ps8pDdJzk4A8eHDmbPhVBi04KlInzMAOv39qfPz0EU2RHxVzokD
         8F4g==
X-Forwarded-Encrypted: i=1; AJvYcCX94KHta8YqrS3NU7vOh/tR6RU9Ubd74thvd47OaZtZEHDwzeOM5HY1ckvdmL5VeO2P4Rb5J03LdhAk6QDU@vger.kernel.org
X-Gm-Message-State: AOJu0YzDR1x8BkQJcuQUdMGCs369Px2YwYqCuq80vp5AoopVeZU8mZZR
	p8b24bxu8K5voPoX4x+fbfcfBGIhWLpgfb7HkQ3FaN59zK4wxLvwCNoj
X-Gm-Gg: AY/fxX4BNQkfDKi8OSPOFMiP0lT3t6MYgqf3v2YrelBKW12tbNmePrkfBtHUxM4Bmjo
	Fi6/+wPyuQVWVs3nPhjHPGwCEyqH2oA0/YjvBrZWeIOYY4t4/W6WPefUlHtgG6BH1jy/eSxwZ0Z
	XGzaaFPxWplFQxHu3hE8X86FikG8MFRFDLD6J3kMBRPj1ow5P3rWi9gc7acMSPqEzbHVerKdM8u
	ZcPlazLbNMR/8NzfwntBCykyuCJ682zs76+3mzYNL2TJJSGeuADmie7B4b4w3D9dpMf2qkV/2Fy
	/kpS7YafOItjEkyDJSe8xPfsyaDtVQ7vh9eWTdwCJy13vQtRVyitbGSiMhSqaM/TTrNEaMtASLX
	to0b/aklXZVvB5dUe2yk4Ct5Mp1AIIIvpFcxtOUoDHibo4+Q6/lBDJY7N2KI/Io3uvB25E6Ty26
	9OJYrNH7yavNKuYjWu+v6QlA==
X-Google-Smtp-Source: AGHT+IFI05SxiqzyVxrtwlwkOSyv5QgkYxJTLKrxiL89jyMTQiggaVXS4Xp6MUQnnRzRml9tzxON7Q==
X-Received: by 2002:a05:6a21:3297:b0:364:be7:6ffc with SMTP id adf61e73a8af0-3898f88ef78mr4557167637.18.1767864611947;
        Thu, 08 Jan 2026 01:30:11 -0800 (PST)
Received: from [10.189.144.225] ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c4cbf28f678sm7509050a12.3.2026.01.08.01.30.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jan 2026 01:30:11 -0800 (PST)
Message-ID: <96bae224-c971-44f6-94aa-eb0328021bc2@gmail.com>
Date: Thu, 8 Jan 2026 17:30:07 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shengyong2021@gmail.com, shengyong1@xiaomi.com,
 LKML <linux-kernel@vger.kernel.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Dusty Mabe <dusty@dustymabe.com>, =?UTF-8?Q?Timoth=C3=A9e_Ravier?=
 <tim@siosm.fr>, =?UTF-8?B?QWxla3PDqWkgTmFpZMOpbm92?= <an@digitaltide.io>,
 Amir Goldstein <amir73il@gmail.com>, Alexander Larsson <alexl@redhat.com>,
 Christian Brauner <brauner@kernel.org>, Miklos Szeredi
 <mszeredi@redhat.com>, Zhiguo Niu <niuzhiguo84@gmail.com>
Subject: Re: [PATCH v3 RESEND] erofs: don't bother with s_stack_depth
 increasing for now
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <3acec686-4020-4609-aee4-5dae7b9b0093@gmail.com>
 <20260108030709.3305545-1-hsiangkao@linux.alibaba.com>
 <243f57b8-246f-47e7-9fb1-27a771e8e9e8@gmail.com>
 <bf7f5eb0-7c9f-41e1-9a39-2278595b98e9@linux.alibaba.com>
Content-Language: en-US, fr-CH
From: Sheng Yong <shengyong2021@gmail.com>
In-Reply-To: <bf7f5eb0-7c9f-41e1-9a39-2278595b98e9@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/8/26 17:25, Gao Xiang wrote:
> Hi Sheng,
> 
> On 2026/1/8 17:14, Sheng Yong wrote:
>> On 1/8/26 11:07, Gao Xiang wrote:
>>> Previously, commit d53cd891f0e4 ("erofs: limit the level of fs stacking
>>> for file-backed mounts") bumped `s_stack_depth` by one to avoid kernel
>>> stack overflow when stacking an unlimited number of EROFS on top of
>>> each other.
>>>
>>> This fix breaks composefs mounts, which need EROFS+ovl^2 sometimes
>>> (and such setups are already used in production for quite a long time).
>>>
>>> One way to fix this regression is to bump FILESYSTEM_MAX_STACK_DEPTH
>>> from 2 to 3, but proving that this is safe in general is a high bar.
>>>
>>> After a long discussion on GitHub issues [1] about possible solutions,
>>> one conclusion is that there is no need to support nesting file-backed
>>> EROFS mounts on stacked filesystems, because there is always the option
>>> to use loopback devices as a fallback.
>>>
>>> As a quick fix for the composefs regression for this cycle, instead of
>>> bumping `s_stack_depth` for file backed EROFS mounts, we disallow
>>> nesting file-backed EROFS over EROFS and over filesystems with
>>> `s_stack_depth` > 0.
>>>
>>> This works for all known file-backed mount use cases (composefs,
>>> containerd, and Android APEX for some Android vendors), and the fix is
>>> self-contained.
>>>
>>> Essentially, we are allowing one extra unaccounted fs stacking level of
>>> EROFS below stacking filesystems, but EROFS can only be used in the read
>>> path (i.e. overlayfs lower layers), which typically has much lower stack
>>> usage than the write path.
>>>
>>> We can consider increasing FILESYSTEM_MAX_STACK_DEPTH later, after more
>>> stack usage analysis or using alternative approaches, such as splitting
>>> the `s_stack_depth` limitation according to different combinations of
>>> stacking.
>>>
>>> Fixes: d53cd891f0e4 ("erofs: limit the level of fs stacking for file-backed mounts")
>>> Reported-and-tested-by: Dusty Mabe <dusty@dustymabe.com>
>>> Reported-by: Timothée Ravier <tim@siosm.fr>
>>> Closes: https://github.com/coreos/fedora-coreos-tracker/issues/2087 [1]
>>> Reported-by: "Alekséi Naidénov" <an@digitaltide.io>
>>> Closes: https://lore.kernel.org/r/CAFHtUiYv4+=+JP_-JjARWjo6OwcvBj1wtYN=z0QXwCpec9sXtg@mail.gmail.com
>>> Acked-by: Amir Goldstein <amir73il@gmail.com>
>>> Acked-by: Alexander Larsson <alexl@redhat.com>
>>> Cc: Christian Brauner <brauner@kernel.org>
>>> Cc: Miklos Szeredi <mszeredi@redhat.com>
>>> Cc: Sheng Yong <shengyong1@xiaomi.com>
>>> Cc: Zhiguo Niu <niuzhiguo84@gmail.com>
>>> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
>>
>> Reviewed-and-tested-by: Sheng Yong <shengyong1@xiaomi.com>
>>
>> I tested the APEX scenario on an Android phone. APEX images are
>> filebacked-mounted correctly.
> 
> 
>> And for a stacked APEX testcase, it reports error as expected.
> 
Hi, Xiang,

> Just to make sure it's an invalid case (should not be used on
> Android), yes? If so, thanks for the test on the APEX side.

No, it's not a real use case, just an invalid case, and only
used to test the error handling path.

thanks,
shengyong
> 
> Thanks,
> Gao Xiang
> 
>>
>> thanks,
>> shengyong


