Return-Path: <linux-fsdevel+bounces-16621-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23D3B8A0346
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 00:27:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50BEE1C20A8B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Apr 2024 22:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EF87184133;
	Wed, 10 Apr 2024 22:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="bz/mzcdy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8086312FF7C
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Apr 2024 22:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712788039; cv=none; b=gFteg3pjX7mWkw9VZyGL0TWAPc/1RIQPqQhb6HZGOWB3Qm+8c5Z8e9M30GtsLFlsWyxmJmiBVW8DOFha3qDGElVndFPAROIDVr1qW+dNM4MEv3lWBJeWCKcukVPjE+2Bau47+FRA9TV6EJDJOn++wOmeJY/xAnwDcmMlIeoPUuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712788039; c=relaxed/simple;
	bh=GNSKKpbMF2d6HjHazkjSsi+nfHk+zDq0eehNnCdFE/w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qKpCvnpQt63oNQgTIoAfsXWPNaF+He4tX8cx3eEansz+ZvSyeFp9fMfTM8GK0jD4xPQrngIDujMp3TZ3zR1OTdOVI/EffPQAnEsFZAUC7S5RsWO5zLNnHUmi6Ar/uVSaQ3NHsvsvBrFU3sMGCbLOWxHkJDPm5//g1+iS8tLMMEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=bz/mzcdy; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7d6112ba6baso39862039f.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Apr 2024 15:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712788036; x=1713392836; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9P0aMHFsVVEdLlv0SDKAm08of/R9DQjYXYCl7/2YrKs=;
        b=bz/mzcdyOW5iC0FkNnlVirITgZp55ltOwJATvHUCyt8JvXJpNoYolTDX84OJrCdrLk
         0H91lHurYH2hkT8qrYuvrWm5RLq6J1rAzXpi9M5duyLFaRzxxunOrZl7r24wnkhkIkLT
         HALj59QHKNel4Q0jnU7ztk/BktHgKO9/0g7W+6aGIzeq7TYHh5lCaPpGR5txHE0Kwz96
         l3VJIbKd/reEqR/Sif7Ue4E+KpcoIeoL/few+j6y2jUJRJshAsYAxDO3v53dO7pc03Qf
         ydEbyOXmz7r4YFiVIFS03u3mOJ5RRRUjhBor+0WBxFHHc9voqZox8brHiM8D7MCyKxnN
         MSMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712788036; x=1713392836;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9P0aMHFsVVEdLlv0SDKAm08of/R9DQjYXYCl7/2YrKs=;
        b=ETn6BNnMKWbD2f+GiI5v5VPF8w8R5Sq45uOQexC5gpp+mZSCXLM+72jRl7eD+PyxGO
         nHkOVZkCA5+gxHtNnXufsOalIQLhEvLqucH/Qf3Jc9pOcF4V6Xw7xc2/9CdxL+psj2x0
         spSsnYjd8EbDMZYzrPMluorAAoCnSziszC9IDtdXnqE/HAXQzENX5aO8beL/M5Ya/UMK
         BAy8cCRos0bxSvOTZ025nU/0lA6XGajgD4j2Ce2WXwbyhBct72rfRns7MkClW11Tjzv+
         WVXEPG3qpuVg6GdyrHaxfLgvzrB39JcZ+/o09ZZxVTFn93RGDASTWk+7FZ1Nf6KkJF4y
         fAOw==
X-Gm-Message-State: AOJu0YyAGNRpoOr/FSIWfIjZSO7pg5YlTTF9VF0lnTd/hdPqfHtAKYhO
	iWVqjMHPhMaRMgbUqKpqaiCZY+QJKWX9nvM5mwekmZt2+XayWq3T1HuuOxccMztIv48bTf6dSEJ
	g
X-Google-Smtp-Source: AGHT+IFknhgMitGGWfix0/LMn4FqxN0i1dUymZMyVcKcwvDjGy0XNNeIgTBz5EhAbDV93SKkvD2iOw==
X-Received: by 2002:a5e:a60c:0:b0:7d5:de23:13a9 with SMTP id q12-20020a5ea60c000000b007d5de2313a9mr4122264ioi.1.1712788035906;
        Wed, 10 Apr 2024 15:27:15 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id bt3-20020a056638430300b0047ee01746f1sm15159jab.120.2024.04.10.15.27.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Apr 2024 15:27:15 -0700 (PDT)
Message-ID: <1a1c00fb-c83f-44e7-bc6a-cfe52d780c35@kernel.dk>
Date: Wed, 10 Apr 2024 16:27:14 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] timerfd: convert to ->read_iter()
Content-Language: en-US
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org, linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk
References: <20240409152438.77960-1-axboe@kernel.dk>
 <20240409152438.77960-3-axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240409152438.77960-3-axboe@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/9/24 9:22 AM, Jens Axboe wrote:
> @@ -312,8 +313,8 @@ static ssize_t timerfd_read(struct file *file, char __user *buf, size_t count,
>  		ctx->ticks = 0;
>  	}
>  	spin_unlock_irq(&ctx->wqh.lock);
> -	if (ticks)
> -		res = put_user(ticks, (u64 __user *) buf) ? -EFAULT: sizeof(ticks);
> +	if (ticks && !copy_to_iter_full(&ticks, sizeof(ticks), to))
> +		res = -EFAULT;
>  	return res;
>  }

Dumb thinko here, as that should be:

if (ticks) {                                                            
	res = copy_to_iter(&ticks, sizeof(ticks), to);                  
	if (!res)                                                       
		res = -EFAULT;                                          
}            

I've updated my branch, just a heads-up. Odd how it passing testing,
guess I got stack lucky...

-- 
Jens Axboe


