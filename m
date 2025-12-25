Return-Path: <linux-fsdevel+bounces-72094-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A766CDDDE9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Dec 2025 15:58:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8C65C3013728
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Dec 2025 14:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2463C1A317D;
	Thu, 25 Dec 2025 14:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="LSL3XT14"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E151C3314
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Dec 2025 14:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766674697; cv=none; b=KxuRNPVGduhVJGau4PRBFG7Nx0A4YP4KRfjQn502DzboedOshBNQvgSvoIfhlnElfA69jEhIa1/J8GAHbtRFqxiA7AoUVcAIRS0CZdkqlb1Ksh9UC1peAjFa6meUHGSHw0EVBS1mUKuI3bBAPTt6ZiUxxXstNno7IqSKzv4MCOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766674697; c=relaxed/simple;
	bh=jhTPnm3oFKXz+ipm0uIVJtKtcYoNuBr7fAjHpdYN3Hs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RTF7jh5oB8oj7kT4wrrSkcDatWeByG8GCbNNlo1Kzs6dmj8EFN4AQAdos6jL7WJjstLeyyf8JCow129Oq2UHW4W2JxrTjNGaXkdXp/TsGHJvRBXeiTNzBS7CjqJsiEybMjBmYqP99AQlrh3TIwHBC9IYGKqII6bIyz6oKdEAiNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=LSL3XT14; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7c6e815310aso5340325a34.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Dec 2025 06:58:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1766674693; x=1767279493; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Hji0XicsQUErLbiGDeZxt0h7DdgSYTr09a/lmErjN3k=;
        b=LSL3XT14eYfRHLYQpmcNNry5SJFcXGyVmrwU50G8uJTjnuWxtyMceIiIquH6tVBDug
         3KWGrDpL1rFXV+ZiapNg8QLxo9tjTOH8cxfIAmV4HqPd1ZYSlIyLtGve+DJt3d2pV8xP
         AAoj/AWdg2I6JA7UBS9m2e0ehRInlDvoFe6pW2rzy2xxuRDKKKh2HUBqCneAEVbHW2ov
         WXVRAW8bJxxvoa51L1xFcDJ1T8yQJk0Bfj4382MQ2633QNkwoP/PRXKL0M1riFroRAs9
         6SSykEu2BgOk1HNWMaKZcO3L7vQZnrju9Gh1/6lTYb0Ry2vFT9O0F3y/pMCJ8Wc0SvPP
         VEEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766674693; x=1767279493;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hji0XicsQUErLbiGDeZxt0h7DdgSYTr09a/lmErjN3k=;
        b=XpCvqO5BVqPYlmfBqsYf6vQvg0hjxhFTBBgBR015PtHgoWg3xtKsfJ3OduyH67jumo
         FJ7LKa0BXM9HyhbVs7H0ZuV+m9cX9yMtIx6ftZH7KyjPUu4w/YQlM9QoCDWsYjFRre6k
         BOIKBDOXJJbhTMR0tZji7+mp0TdZdP0cY3GuAenIcdFbeynIifhAXujAPUfM2EW57kOK
         p+URPEnSaIVBajUoL13dbZUMJn136OfvlAncdYzfoVfYJk7ld7EKbaYcSKGNaKN3R+Lw
         Ezg8Q5qgvVS1icSA1ZXt+mwTSbNlGc9NLMxdqbe2apewHD9PAjGKJPG9E0/FBF4saUzg
         /zBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHsxhy0J2XHUj12KfauZqGRAbISQYGma0cHAtlloYBCTJ0C+g9IlcYdzxD7Y8KTOGxir9yhnt5moslTZcZ@vger.kernel.org
X-Gm-Message-State: AOJu0YyXTCVQdpP2eUgQbj/abrktkMeDd1hnka059LBREyIa0MJDpcd7
	cNM9vq6wvWGypIKKu6lNMevZ5M2gAeQOw99bxlA1D3lj2laFJfybo/4bedMebhfXFGjnYh7UfGa
	nixT0
X-Gm-Gg: AY/fxX7t+hpHg2nPZdZtqaV+SDVJTk9E5S5ON2vM50F/VlS80IAnbAgEWawb8IBtkTG
	rpjRJDACPTG7wT84f+uW9Wf/MKaHA+/klvb4ZGDx5uKZGgPWqO4/zJlICbuKX5WnD+N7MvN3Qx5
	5YFCs1iWwdWXLP/Sz/AjOyaYVxARONDOKxyB+SxioDJbd4YoXoc8HakF72rfg2s9lvoY8yyBDDM
	muiJJ3GR/KLrOSOXkEMBi4VP/2nTKXfjgSeMTCP+YUP7Mkq2t/x+L4jWUlVm/8BQvUDi7gKo4MT
	ugvZj/gvWkcAbaoSdOo7S9vM2ToZVpQOzzoERHsQHUxNk9n6ZetR5/N2n+55kEEVV7T0xVGxp61
	UznRQWZGG+TbU5tVUe0txTkz8+eZvgCyLDTrKFhKA7qFcouWJPqZ2npL2whV+0Er1dVAc/q8Mg7
	q7kQE1RtNs
X-Google-Smtp-Source: AGHT+IEl06568X86BVzNgKQ7sr4wYLSEd+yHkAPiNbCo94xUa63OAJFZtsNW2hDsBmep5OZidthgGw==
X-Received: by 2002:a05:6830:410a:b0:7ca:f50d:b2fd with SMTP id 46e09a7af769-7cc668b669fmr12509788a34.13.1766674693021;
        Thu, 25 Dec 2025 06:58:13 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cc667ead3asm13308380a34.20.2025.12.25.06.58.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Dec 2025 06:58:11 -0800 (PST)
Message-ID: <564afab7-a894-4da8-9980-7d68a0a1babc@kernel.dk>
Date: Thu, 25 Dec 2025 07:58:09 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] io_uring: fix filename leak in __io_openat_prep()
To: Prithvi Tambewagh <activprithvi@gmail.com>
Cc: io-uring@vger.kernel.org, brauner@kernel.org, jack@suse.cz,
 viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev,
 skhan@linuxfoundation.org, david.hunter.linux@gmail.com, khalid@kernel.org,
 syzbot+00e61c43eb5e4740438f@syzkaller.appspotmail.com, stable@vger.kernel.org
References: <20251225072829.44646-1-activprithvi@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20251225072829.44646-1-activprithvi@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/25/25 12:28 AM, Prithvi Tambewagh wrote:
>  __io_openat_prep() allocates a struct filename using getname(). However,
> for the condition of the file being installed in the fixed file table as
> well as having O_CLOEXEC flag set, the function returns early. At that
> point, the request doesn't have REQ_F_NEED_CLEANUP flag set. Due to this,
> the memory for the newly allocated struct filename is not cleaned up,
> causing a memory leak.
> 
> Fix this by setting the REQ_F_NEED_CLEANUP for the request just after the
> successful getname() call, so that when the request is torn down, the
> filename will be cleaned up, along with other resources needing cleanup.
> 
> Reported-by: syzbot+00e61c43eb5e4740438f@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=00e61c43eb5e4740438f
> Tested-by: syzbot+00e61c43eb5e4740438f@syzkaller.appspotmail.com
> Cc: stable@vger.kernel.org
> Signed-off-by: Prithvi Tambewagh <activprithvi@gmail.com>

Thanks, just missing a:

Fixes: b9445598d8c6 ("io_uring: openat directly into fixed fd table")

which I'll add when applying.

-- 
Jens Axboe


