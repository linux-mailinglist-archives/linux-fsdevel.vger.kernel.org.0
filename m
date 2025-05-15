Return-Path: <linux-fsdevel+bounces-49091-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0768EAB7CD2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 07:08:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E1558C1DA0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 05:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5754286D56;
	Thu, 15 May 2025 05:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tvct00RW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E8C8C1F;
	Thu, 15 May 2025 05:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747285707; cv=none; b=k6jk/egF9y8EEcg7qnlFkx90M27+8YH4afQ6l56BDLHAheyFu5j69Pb+FqJZOnjFpOeGv1YCixQS5NbnYhC7rNBWNmZhFCImz2/ye13IwFf7SFWyXk6ELUKMi52enMAvcaR+jnQu80G0I2FlTZKvz12SN2Kn8Ga3iu7QrGKs7VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747285707; c=relaxed/simple;
	bh=DfKzu/2uN/ZhVEJNr+7vI8iANsRzWUhlIsxjCoy7V9A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TxaXf5MLrbHIatLOwHy4Yzn161LKlwiPsgmm/ldpfKDoXt2WbrMnXU8vI324QixmclXPFIcgrugmoWCUolDvoFU/cvfFr58mEiE68/b4yuDN/wjAZ3E1kfNyC5qySFSbhRDL1y117VXSMCuoXMfgX6pGBULrVGraM4EwiClFJJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tvct00RW; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7423fb98c5aso566837b3a.0;
        Wed, 14 May 2025 22:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747285705; x=1747890505; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DfKzu/2uN/ZhVEJNr+7vI8iANsRzWUhlIsxjCoy7V9A=;
        b=Tvct00RWTHIXmreMPYqy3PVY/kyTGv6Dljrt4IfWdltakXQ0BkfJp45nh+pPC8zBnz
         BKHnBsp4ozu0qezSWo0SYtLohSkvao++UjReCLaeAkv7vDzBXxaxpsubV3I6lmrdyHn+
         4MrbhclV3+RnQ40mclmP9QzUEpmg/2skIlxA62+Hdpk6I/PTAtRFmnuuEXvrDBBLKDNU
         S5D2sviW/WnExkP3aBTRVgIAwN74vd+h4KyP9wieTUOgHuPLhP1rJzLWdVMjCrEIibWL
         EszBSNJqP6qVQeQvp1B6yGDrP6d5odeub85p5DP2kTqKxCpGY1r48k4ixqNVM6dOuS69
         c0VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747285705; x=1747890505;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DfKzu/2uN/ZhVEJNr+7vI8iANsRzWUhlIsxjCoy7V9A=;
        b=vwkkCax+8o6zf1PSgwJCdMLKB8wontaBV1ky9L6JA0a9i86RI06dZ8UHtFLrAhukWv
         Eul9zG/nINagThEgQeDXBKKjnn4O6mYUtfPDFa4XmgWzxBZGyBxP4wGMFtNC0MKi+IFY
         GnScc0J2ui9Vv+1op6MyfTtWgd0VYVJ4KrHFcmBBkaLxMvKF0u5ZFiwnflkR5Rp6dZcB
         veVxvf8N5ympmUK8aRPVBFAi/sORRD9RSnYjqY7dcD6Qbp8BFEB0AAu98H9s8SxKTV9E
         ODLwTAwkOP/hRQnT069cWNm5IQ8Pz9fIk/rn6/T4rIHuxIPGajiUfq7CzTI5/FRJcXpz
         bsmA==
X-Forwarded-Encrypted: i=1; AJvYcCU2Ax5M4zBiW6ybC9zEjmDLJW54lT/9/SNpujfwcJd9XopliSwQaazASRGEjoeWTudLmTbL/YLIIqHz5muG@vger.kernel.org, AJvYcCUVhCmXB+BDKAuxvdt5l2Cs/jqWfzo9lDH6uJaa2QZSIplGXTwchDxLGYGbnnfbtL0vE7f5wgXSSeybJ5Cd@vger.kernel.org
X-Gm-Message-State: AOJu0YziL15IisWXAKzj4LapPsuKU1xsnJikkUk7RSiWceruuIPR7eEi
	NPXyuNl9l1gfBbR5vhuNPuOKR/jUG70MRvcJDt9INY3ACo64XTig
X-Gm-Gg: ASbGnctgWqh8T9k9LgN/pn9jCAXEuiKNpsF8SRHfYsLSCGbztDx4rEsCIAOaV8C3d2S
	J4kZ7ROaXPi0fviGxbcNaePXOQUNagM1/Pui9Pb7mFRyvnqHzMzquCXt7x3SWtrNel5zMqHI8U6
	SAPA8JwLt8smKnNxmFkPrbxGQNypv9AhHr3hgB3Oilkj5Ix1bsrV8D7shxHspUWNlO0zTktkg/c
	pO0oksJUA4wGGvjUYrhA/pGwDSyUNjJrJEZFLI8T3Snk6ByJxaGP5FIO3BR01iOqXliBJmRqxql
	+dddKgC3Q5FxEj5E8Snqj6RxxMu/8zHtbLvfiIRf5Cpyi384asF+YUUo6ypLNm33myzEzbeZotI
	=
X-Google-Smtp-Source: AGHT+IH+z9/gvNAIgVdBiQEFnvWLdzvjUXhJQoW/YC8WK0Cl0SXJkOGyFoyiodBt7ZVwXDHT1gBPow==
X-Received: by 2002:a05:6a20:6a20:b0:1f5:55b7:1bb4 with SMTP id adf61e73a8af0-215ff0f95efmr9042786637.11.1747285705060;
        Wed, 14 May 2025 22:08:25 -0700 (PDT)
Received: from [192.168.0.120] ([59.188.211.160])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30e128c5a9dsm4077853a91.1.2025.05.14.22.08.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 May 2025 22:08:24 -0700 (PDT)
Message-ID: <e6a5a737-ce64-4d31-aeea-2e6190da2ff5@gmail.com>
Date: Thu, 15 May 2025 13:08:19 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Subject: [RFC PATCH v2 0/8] staging: apfs: init APFS filesystem
 support
To: =?UTF-8?Q?Ernesto_A=2E_Fern=C3=A1ndez?= <ernesto.mnd.fernandez@gmail.com>
Cc: Yangtao Li <frank.li@vivo.com>, ethan@ethancedwards.com,
 asahi@lists.linux.dev, brauner@kernel.org, dan.carpenter@linaro.org,
 ernesto@corellium.com, gargaditya08@live.com, gregkh@linuxfoundation.org,
 jack@suse.cz, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-staging@lists.linux.dev, sven@svenpeter.dev, tytso@mit.edu,
 viro@zeniv.linux.org.uk, willy@infradead.org, slava@dubeyko.com,
 glaubitz@physik.fu-berlin.de
References: <20250319-apfs-v2-0-475de2e25782@ethancedwards.com>
 <20250512101122.569476-1-frank.li@vivo.com> <20250512234024.GA19326@eaf>
 <63eb2228-dcec-40a6-ba02-b4f3a6e13809@gmail.com> <20250514201925.GA8597@eaf>
Content-Language: en-US
From: Nick Chan <towinchenmi@gmail.com>
In-Reply-To: <20250514201925.GA8597@eaf>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


Ernesto A. Fernández 於 2025/5/15 凌晨4:19 寫道:
> Hi Nick,
>
> On Tue, May 13, 2025 at 12:13:23PM +0800, Nick Chan wrote:
>> 2. When running Linux on iPhone, iPad, iPod touch, Apple TV (currently there are Apple A7-A11 SoC support in
>> upstream), resizing the main APFS volume is not feasible especially on A11 due to shenanigans with the encrypted
>> data volume. So the safe ish way to store a file system on the disk becomes a using linux-apfs-rw on a (possibly
>> fixed size) volume that only has one file and that file is used as a loopback device.
> That's very interesting. Fragmentation will be brutal after a while though.
> Unless you are patching away the copy-on-write somehow?'
On a fixed size (preallocated size == max size) volume with only a single non-sparse file on it,
copy-on-write should not happen. I believe the xART volume is also the same case with only
one non-sparse file.


[...]
> Ernesto
Nick Chan


