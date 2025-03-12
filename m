Return-Path: <linux-fsdevel+bounces-43819-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A22DDA5E16F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 17:08:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4AE2166D35
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 16:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EACBF1CD1E1;
	Wed, 12 Mar 2025 16:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="HZe/Rgjw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D531C5F0E
	for <linux-fsdevel@vger.kernel.org>; Wed, 12 Mar 2025 16:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741795647; cv=none; b=XPm398cQ33TiCMsslHfC0b28MXAeR3RmaLxA4jl7xdW/vAt5djqso9vpmHpZVe3fCdX+HPrfJ9PxuWIc69NhurhQWaoTR4CkYALsRSNfEcaW9V3L1zooJwle1ik5c9nE14E9he/qq9yLphTIicDnqeuRcLBqxZrn8uLVyRfLJJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741795647; c=relaxed/simple;
	bh=+DPcVpt5jm09eAi/Y9n5785dJsafsofbqA8F/h57dus=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XLklRswT2fvvyJy4lRMTO6k6xtO9p3kjjbqHUEwGi2O0JNa1Xi5PzaKSRaUDSuo4cT6xRrfg+kfVABoNEESre2xQWwFtn34XxxoryXccC8TnekFLv7h1msI2XjdqsgPJKXnyGXYVVvUTdw6FB5z0FT+V0DWOSL9G5SP1iWmVXX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=HZe/Rgjw; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-85dac9729c3so71263339f.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Mar 2025 09:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1741795643; x=1742400443; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ExMoY/YUEJ2sXZfuXzKCTdc9+tog41q5+FPX04PqUyM=;
        b=HZe/RgjwWI1hEqmeTUpZ7rLgRzKZbdsCLSjpiIZwywmwJMJ7rpKITg+E+bNy2VmPA3
         IXP66hluxKFO1nUuFB97+n015rW282h0l3WS6oSFD4BCQGeDnXInZkpeJJGAJx5xKHo1
         wylHfhTaRJRSVDoQX0JR0cIYXPLxmrcGiXnxPtenFa7zE4adRUaOKenn9Q6mwk2/sjpe
         ObaEDKowiY/sh2AF5g5FVxhgZZ76mQY6Xfa/1zeE1UrBHyU0gz2AWaUwnb1xhI3RbcAb
         BMkdAkiZzlHY3FyxqDwxgT5FQHU9ZZBWxOb/LHgS5vNpc7nEVtO8uWyp+B5c4UTP/PUY
         BAGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741795643; x=1742400443;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ExMoY/YUEJ2sXZfuXzKCTdc9+tog41q5+FPX04PqUyM=;
        b=YStX5ru6DSz7OxZCJbhhA4DO5yccEbgec1Jc/jgh8IDyhjDgJDxUoVEQf1PE7c0Cak
         3Szy7yKqux5TD3PAhmcZsJv3zr93igDd+w/WS715OiMmgIgdfcIRpDyz89im1EE5BhaY
         VaR5udct4X7TKkywvN/SPNyfQJA80Rit5/uNmd1tgTZnxcRtjXSblMsUVrujlFhZr/qo
         s5uqs0wZfd9VBg+UCdXee2vjiBP1t3ecY3L0yaWlDR7RlWrthN2EZnaxuI+GTrUlIOKs
         T3d8FEQ5saY7k5dsXjLBV+z258yNdrYOpuMxsOGpCiUMOQ33vP6rRyQLBCaEwynI+g+E
         7rnw==
X-Forwarded-Encrypted: i=1; AJvYcCVTXS36le/8KVBplHzDvJW+89ULD65rVi8D3diffksLlYaSR2nV/UxMp/8Ay3XudF82CWglKQYFjaSwB5qg@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ1hLp4vOdJ88TBf9OXCDPSohz8Mj1VUyVXYkd/4Jor7HIg5R/
	tcWUJKSar/OWGO3sw5YKd2WNUdxQe0+MBn+0Q0/zTQFrnQZAnDmzOPDNz+pNrxo=
X-Gm-Gg: ASbGnct+bD87Z+Xu8UlfuoqKNkZiq7MNhNSAon/b96N0Em8A2493FRFAlwAabxbmoXE
	bH+1edejmh0on/F3Et2hG6dnPOjLqr1zjbNBXjuNSMcviH7DFP3ovfMYI8hZvZpoScXBq01FuCo
	7NDd+TyE2AjfO/Z90UJpHypXC3sCxZrSKESbVy46N69TU1SuoEmGfDETQFe0tfXhYDszknuqsH5
	NK5nlHBUPCm9ErF6fMEVyrZ/eb9HC9X2u8GHBbl/cy7MQWRSqQAxDwdrjgeti1L6YF5I7CXIL8F
	419mU/qIAvjDafrHZTgVIvrAPOD6jD/f5MTr9gNA
X-Google-Smtp-Source: AGHT+IElo/nFdPS6E/5N5+GL1pAZfk0yR7kOrU1+gao2muzmo9g0AwgP1v3zMHzkrcml22cA5yeNRw==
X-Received: by 2002:a05:6602:398f:b0:85c:5521:cbfe with SMTP id ca18e2360f4ac-85d8e2233c5mr1023090939f.8.1741795642951;
        Wed, 12 Mar 2025 09:07:22 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-85b119a823asm284201939f.14.2025.03.12.09.07.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Mar 2025 09:07:22 -0700 (PDT)
Message-ID: <6115bfac-658c-4e8c-859f-d4a1a5820dae@kernel.dk>
Date: Wed, 12 Mar 2025 10:07:21 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs: dodge an atomic in putname if ref == 1
To: Mateusz Guzik <mjguzik@gmail.com>, brauner@kernel.org,
 viro@zeniv.linux.org.uk
Cc: jack@suse.cz, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
 audit@vger.kernel.org
References: <20250311181804.1165758-1-mjguzik@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250311181804.1165758-1-mjguzik@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/11/25 12:18 PM, Mateusz Guzik wrote:
> diff --git a/fs/namei.c b/fs/namei.c
> index 06765d320e7e..add90981cfcd 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -275,14 +275,19 @@ EXPORT_SYMBOL(getname_kernel);
>  
>  void putname(struct filename *name)
>  {
> +	int refcnt;
> +
>  	if (IS_ERR_OR_NULL(name))
>  		return;
>  
> -	if (WARN_ON_ONCE(!atomic_read(&name->refcnt)))
> -		return;
> +	refcnt = atomic_read(&name->refcnt);
> +	if (refcnt != 1) {
> +		if (WARN_ON_ONCE(!refcnt))
> +			return;
>  
> -	if (!atomic_dec_and_test(&name->refcnt))
> -		return;
> +		if (!atomic_dec_and_test(&name->refcnt))
> +			return;
> +	}

Looks good to me, I use this trick with bitops too all the time, to
avoid a RMW when possible.

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe

