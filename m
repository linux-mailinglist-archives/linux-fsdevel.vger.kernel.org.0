Return-Path: <linux-fsdevel+bounces-10989-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C08384FA5A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 17:59:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8651EB2B432
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 16:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8587983CB5;
	Fri,  9 Feb 2024 16:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="LkeSd6de"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B0080C0C
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Feb 2024 16:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707497733; cv=none; b=RhGO71X9Gz1r7AgcSG27zIGHiVW0OacCwAbazrVSnSZq6B1lijZUjILJbk+iS24MjwmQzSECmvHdyg2MjY8U8vnGohL7ArOnM+ZfPiKGSF6fVDPPXsVsljmpY5WDHYXqolzfF7ZxKo/QvzbGdhQVxiIq6VdYLLNXL0Wx+32n6Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707497733; c=relaxed/simple;
	bh=ustzi+l3+pr0aiqpQxCr5kx8+KYEHAMBXRZsfaLVyf4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GFTKwewQKA1+JqZPYomEFvc60eNW+RGaVY292NSK2ddxe1vbzlu+oSAQF2b8slCpOf15GXf/maC4Pegxb2S+P1x+AiOaI167r6RdCHS86fDINzblLbYwBxnfBjir00DsOU5eGTQiZwc5TtnUkigkjDVqEpfGFRMyRnQl91AYArk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=LkeSd6de; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7c3e06c8608so12516339f.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Feb 2024 08:55:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1707497730; x=1708102530; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kmzmubT4VmH1H6I1YLfCyIqyIIl+DdbQ1/9lvmO8VLc=;
        b=LkeSd6deqbFhRwpKXb+XL4A7pDr+066+WS8RSxwC6MmvbenE6zQz8g93twAFwWOk8p
         T1NzCMqdoJ4CUTIIYfhEGuR+cGxb32nO9LegWFL/tNmrsHZ6K1okUgabFT2Q8qTDj7Lr
         sWcEtDD8m1GJrJiEJEizycHslEfSEfAGI3V1GhZSE0Jnxoe+i4Fj5wZO1u9WnnNWoM+v
         zFosAhYDo8PefSCdot1Cpp3hO13sXOw2IcUW0pIesKCgrPPeE6zHMkiE31S1D2KKR9yH
         NJe3FRVyoOUk4IYKA4vs+iivCKH8d1dhGY2/HZ2FNkpfmD2k18vpOxJxsumnh8caklno
         szEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707497730; x=1708102530;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kmzmubT4VmH1H6I1YLfCyIqyIIl+DdbQ1/9lvmO8VLc=;
        b=L16KmAgTB3Yc++26lhtbsikcDxukJ9AO9ql4FLFjJ3cAzKCJzzAe3bhCPB14Zqun0A
         x9jhKtJ9MpbgdGUi8b9LXQzaQQyeJMgZP0pnqiZv76v3BWp0nCFpQUwwCev+m9Ri5ass
         0rc893I1THPss07M4bqkLLXZyPHDWQwRNn0tKr/jwtq7SIDyPXbdOS3HB0o64Atb8VC3
         ExpaOZ6IY7qKnURO9QL4Cm3DdhNOkFEAXq8sIqmTzY8znRGFXvRammMUnqo25DRQfXjY
         57W1KXOQd4T+nHwrMVI36Hdox9QDlxGbhJIWf74/gD1Rl59EuzZrk5qEzmrGQleTRP9Q
         zt8g==
X-Forwarded-Encrypted: i=1; AJvYcCUQ0XuDLWjHpc3KQx6Q1oEYERS0XykXR6GyrpNKYXDZRQuTr5Ue8deJcChfQiTinJa/gV4SXCqlKuEWTBJ0d/BxSy4lOguzRSVuzQ3VZQ==
X-Gm-Message-State: AOJu0YzkAqira5D91bJBBXPEAwh0r1VZHVwEQ5gaTWkzh+3vyN3qZIa9
	w+gEYpQOY4t5VApdmIt/yvTT1T2YjJIizKHV4oqbuWbOE1kJp/E3edlQ1miHLnc7oixX7mqG75g
	J5tg=
X-Google-Smtp-Source: AGHT+IGojECrpFOK4U5p113sKM9JAy3gKgc7YTKLnqILnbvJH37ELajv8Mrnx2pTKWyR4EvdFLlNvQ==
X-Received: by 2002:a5e:8d04:0:b0:7c3:f2c1:e8aa with SMTP id m4-20020a5e8d04000000b007c3f2c1e8aamr2715286ioj.0.1707497729919;
        Fri, 09 Feb 2024 08:55:29 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXa2CA7GhNQFpMVIbaFvk3LMVtJG8finHb68Hv+JqdBe2BucnPCHhdnrjZrCk2cy9cTEmbgZPVPj9UomykFbyji80ouv65z583SebCgj5Eem3HTGe5Emsr3UjxYK8MYVBI1
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id gm21-20020a0566024f5500b007c41e541b8fsm493707iob.32.2024.02.09.08.55.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Feb 2024 08:55:29 -0800 (PST)
Message-ID: <0a90a042-a56d-4c97-b4a1-12951a231a16@kernel.dk>
Date: Fri, 9 Feb 2024 09:55:28 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 0/2] io_uring: add support for ftruncate
Content-Language: en-US
To: Tony Solomonik <tony.solomonik@gmail.com>
Cc: willy@infradead.org, linux-fsdevel@vger.kernel.org, brauner@kernel.org
References: <20240124083301.8661-1-tony.solomonik@gmail.com>
 <20240202121724.17461-1-tony.solomonik@gmail.com>
 <170749718943.1657287.1724106194346542608.b4-ty@kernel.dk>
 <CAD62OrGiBX5YuKr_qRzCXPR5Cx_0Vw3Dei9f95Qww1rL45ejdA@mail.gmail.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAD62OrGiBX5YuKr_qRzCXPR5Cx_0Vw3Dei9f95Qww1rL45ejdA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/9/24 9:50 AM, Tony Solomonik wrote:
> 🎉

Just a note that your base was older than the current one. Hence
the opcode value for truncate shifted one down, FIXED_FD_INSTALL
is in there now. So had to hand-apply both patches, but nothing
major. I'll get the liburing side sorted too.

Thanks for working through this, and congrats on landing the
patches :-)

-- 
Jens Axboe



