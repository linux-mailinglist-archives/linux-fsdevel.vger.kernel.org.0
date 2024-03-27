Return-Path: <linux-fsdevel+bounces-15460-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6342588EC67
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Mar 2024 18:19:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94AA81C2F003
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Mar 2024 17:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EC6514D451;
	Wed, 27 Mar 2024 17:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="U5wUCTha"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C78614D6EC
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 Mar 2024 17:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711559951; cv=none; b=L3f+0i+qL4iZGJfvgjvkyFlc+kB2FCc0IGJRaqP54hYTS/a1zOVqPOelIIC90Y4T5cvg2/QYzT//REiGFpTTxrSOLyi20tI03QgYLtvMoRcftkbRcQ2D+najm888sXryJ2FHyH8TIU90w7jDEZgrX7aK61zbH6xr4HUPS5ZBIoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711559951; c=relaxed/simple;
	bh=29h2AUzAAJnDFXLXJwmwzPe73vea4EZeTwwo589Dbk8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZNkQMWt/dYdI10PP4hMJSyV25O9Dt5e2Z4u1jbdhAt8124qQQzs1IAicVgId1Tix+P6Ea0Hl4ji9BXJ1OHDPdXU4jICOp6KiWxMLJwOS5CklZX7S1d4iWzuMG400tNOUPd0yCTOTqXfYSAWLAkUxl2IYotWTt/aN0ozXusMigoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=U5wUCTha; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1e09a7735ecso70135ad.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Mar 2024 10:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1711559949; x=1712164749; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6XH30giHm4xuVAjFduERXiIJfhN32OXXVD0HlYbYbu4=;
        b=U5wUCThapf685eE9N+MygSUVV3fxDGpFK1Llr9kTGaZ1yt4KZ+CGeO4GlshLjU/+iZ
         VSbnYcPvKBLuKt2Yx64cmWiID/IxeDCWNQcI3pFtnMJ+RCnfgkh2Q72e86+eCHqT0Ygj
         28eg6KS6SOzMyZ6ebh3b44qDaQFRrjWCNg4nzwOgiU0X60AxJEn8FMDLsdcZQKdPrrUS
         PlWSJEYNMGzs3V7cpGV+GRpuRic5kD1Dm7NP6wdCUs9vP+PV1zUKiAvKFNzc5QrPtITr
         9oxQ2Jh6FJLNoljLQTarcFHb/NmDKdtY6pd6EOvVYI2zNA9EE4OaQ6rOc60RgolnBDnA
         mHDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711559949; x=1712164749;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6XH30giHm4xuVAjFduERXiIJfhN32OXXVD0HlYbYbu4=;
        b=EJymirTqDBe0rSs0+cHL4my8jCJlLxJ6DoN+K3CiICm3g2TR2tfRr+tTPu49SUkpIE
         6TfUPz1Xhbb2+2NZbI2JMDm0w0zwiWB/oz/s5GCeZSqBFA/MYCxnY1fkAEaGJ5jjA7qa
         2jx5xUs/GrsTpz5p2JRu11shXjSjrdXvd6n5zFjPMsRdyib86k0xgiypU84S4SZ4RrLk
         pb7Mc3+/AqjR/PbA1WYCOvei6xvQRlhCHnb9ZtNWClUij/XAQVbYpWSGZsJSPWv8Bp8A
         OSEPykpVxYR1PdX6d6GJStzQM1UdahG0niUuwJ2GwWSm0lAAMySqfUx2XbbkD6xonjMt
         DYfw==
X-Forwarded-Encrypted: i=1; AJvYcCUhKQE6e279jtYEb367ItfNRwQRqixWRVbjXi26h8aTGg6rbA1VEXpkiY2FSy3OVJSrsqE4w2hTdk5LFdV38r5filh+a1zs/vmuBFf3hw==
X-Gm-Message-State: AOJu0Ywt6+u7TPNIiqiX8gqw36qvz5VKEU9YUO8gKOSoGgBqT9+AO8Zn
	Kp14xb6suDVRORWFoJVTywGplQIQUdF1V+f6ivXuKh0Uv3Ar4Dd+QpWD+iAMiJw=
X-Google-Smtp-Source: AGHT+IHQbekEyHpay7l7rXYFodfJX33zwaI5uIhjFxi+PNIQFoF5Tr15zzymhsRzZ1YV5p6JX0QuZw==
X-Received: by 2002:a17:902:ab96:b0:1dd:de68:46cf with SMTP id f22-20020a170902ab9600b001ddde6846cfmr286761plr.6.1711559948631;
        Wed, 27 Mar 2024 10:19:08 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:122::1:2343? ([2620:10d:c090:600::1:bb1e])
        by smtp.gmail.com with ESMTPSA id f1-20020a170902ce8100b001dd6ebd88b0sm9290497plg.198.2024.03.27.10.19.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Mar 2024 10:19:07 -0700 (PDT)
Message-ID: <e6a61c54-6b8d-45e0-add3-3bb645466cbf@kernel.dk>
Date: Wed, 27 Mar 2024 11:19:06 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] [RFC]: fs: claw back a few FMODE_* bits
Content-Language: en-US
To: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
 Alexander Viro <viro@zeniv.linux.org.uk>, io-uring@vger.kernel.org
References: <20240327-begibt-wacht-b9b9f4d1145a@brauner>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240327-begibt-wacht-b9b9f4d1145a@brauner>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/27/24 10:45 AM, Christian Brauner wrote:
> There's a bunch of flags that are purely based on what the file
> operations support while also never being conditionally set or unset.
> IOW, they're not subject to change for individual file opens. Imho, such
> flags don't need to live in f_mode they might as well live in the fops
> structs itself. And the fops struct already has that lonely
> mmap_supported_flags member. We might as well turn that into a generic
> fops_flags member and move a few flags from FMODE_* space into FOP_*
> space. That gets us four FMODE_* bits back and the ability for new
> static flags that are about file ops to not have to live in FMODE_*
> space but in their own FOP_* space. It's not the most beautiful thing
> ever but it gets the job done. Yes, there'll be an additional pointer
> chase but hopefully that won't matter for these flags.

Not doing that extra dereference is kind of the point of the FMODE_*
flags, at least the ones that I care about. Probably not a huge deal for
these cases though, as we're generally going to call one of the f_op
handlers shortly anyway. The cases where we don't, at least for
io_uring, we already cache the state separately.

Hence more of a general observation than an objection to the patch. I do
like freeing up FMODE space, as it's (pretty) full.

-- 
Jens Axboe


