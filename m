Return-Path: <linux-fsdevel+bounces-49542-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1764ABE346
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 May 2025 21:00:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 549654C5997
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 May 2025 19:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C394927FD50;
	Tue, 20 May 2025 18:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WLrn/hri"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD7E25C6FA;
	Tue, 20 May 2025 18:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747767592; cv=none; b=TPcX+W8KjCSfKF6EnlryWNuPUyNZIGEcjX7t0KlcYdiCVmEFXq5ExFiSaJMkWm4OJd16hp2xiPe7DyyJ0eLnD4p+vbCWUq2h/9gf8JYrH+HECyJth6zQH7yvbRgvHGrXqJPWKeETnQe0Y2Jjmwym5ca8nEqQtMm1tNntdo9ULRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747767592; c=relaxed/simple;
	bh=lHhHH18Gvn/lfwPtUE2bbE5SUT2dnlX3N4jAWOw3v4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pP13dzLWYxSGEmxlOVyuJpCFmYCou/vza9a95z+2w5X30BRqcNwCHaDTHkufXR1b/H0IHq5GE0htBsdviJncId7retko/2uCzTn+jJBaKcJsZqOlnRyGVsZB5rJT96DtDB9n5sAX0hlKGuCwI7/7l/jCNCYhqTYqAAaAJu2ESlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WLrn/hri; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-87bfe95866fso958204241.1;
        Tue, 20 May 2025 11:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747767589; x=1748372389; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lHhHH18Gvn/lfwPtUE2bbE5SUT2dnlX3N4jAWOw3v4w=;
        b=WLrn/hriTUhd0/zXnIeQmP2Py86uLmDPWDSsSHUyYk64p5ZPirwh0tm+kut3pPWmmL
         Ik1zEpsgVgp4SJb/MkeX0cMDoEH2kS2oxyyiUULEKQf+Ibc1d4FJQr1TWkb6KL5hM0FF
         jjQVL238aJ9kCxmHrTQb5GW8Te87Xh+0JF6GmMaSsNtKtkcCiu5EKwiMkShfzcc4CXYE
         j+bwUegXJDx3wexAhRn4JAgqHQO+w6MsyKlYcXZ0zQ79wAYaGZL/kx3JmdI+D68/Mn3e
         Ptwxa9cdLjOc4HjVQbfh50E1eCl9CNhIYUMQgpXbLuIWmRuTdSPCwLdCr/7NlQ1m0+1A
         dbow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747767589; x=1748372389;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lHhHH18Gvn/lfwPtUE2bbE5SUT2dnlX3N4jAWOw3v4w=;
        b=hMVR9JLlza578BuN6kQQS6a07RxDLLWS2qcOZ9QJJw9KmkzRTTLUBZ5OwCQCQq+Mk4
         6/CT5dz8EFiYtuF0mau1dE1mlFYACo2NByrJNOHkHTicpvJA8lk2T4PdGR4YXxj/T+pX
         neZTRAdlXCrkCudEg2CIYjElCMwFAmzCImXyBdkzMtuSB11e3UeKiQ5v4tWvCaWoG1yZ
         dM2ntPdZ37fJSOIX32Hqzq3gsOqW0F4uKEsJEveJO76qvNR8KiDu4+HOt9iPbj8/mbjy
         FBirgM4BiJeoL77a0yRIHxL01g/f42WInl2DmBNezlnvz/2Jch66knE8tBpH0zuQRMw0
         XcRA==
X-Forwarded-Encrypted: i=1; AJvYcCWQAwmagF/LchNnUstawhX34lpGaJ8Lle/m5EJ6AsgI+vbjrV7mtSIz2IyRAJF2SLQP4cySNyspcIWbRCrp@vger.kernel.org, AJvYcCXlrWb57OwAMZNwlDGfQnf6fvl517DIxcHaKUIu0Wsq6KejlD/50LGduyhj8rI5u06Xq6/YTlgpoGuv64c3@vger.kernel.org
X-Gm-Message-State: AOJu0YzwS4mci81PkPRsv7++uMKvwp0TyWlLVeHN0hp65UeFOm/SKlPw
	pFKzhAl+OiB+A662f03f7TN3JWZUBtaGf+9YpJKxweSAyCjS2mblDUl5
X-Gm-Gg: ASbGncsA3vz7AjFJO0OvFP6NiirBpeMbdPIJRZy1dOXprEwDyYVcKLQ6H+3ON5Vkq+h
	aM7GtlABUASQHJzkSUv8OAcPEbY2RQ5F2tfzARCSCzxz2EYrfb8yvJDmpEIcp75DCayO9BJu2yz
	9f6ILyh8Rlh7pb8bmH3Ga4+M5EdAo/xMX3QD8bGqqawIqvboCNOD+2LAHmxzi0qyiV5fL57RES4
	+7kuGERKtgTxpDJJ3et6LY51l+ZoaqjJIKp990n1damCDw8S2at+womOZvaf6K16WmPBQePQods
	zAgOsQ6Suu2z4oUXa7o63E9SZTL/SmPwMo61sfQ+I1nxm/fongys4EM3+9w0
X-Google-Smtp-Source: AGHT+IEAVdxlUSvPb2pr9kvVXJmFvRdZ7wx7jIGnUDEAeCUNLvgNsDDib4yRXrfZ2wG+HOOKFJZ+2Q==
X-Received: by 2002:a05:6102:2088:b0:4e2:86e6:3785 with SMTP id ada2fe7eead31-4e286e63831mr6007801137.5.1747767589373;
        Tue, 20 May 2025 11:59:49 -0700 (PDT)
Received: from eaf ([2802:8010:d580:c200:bf4a:f31b:7897:b2a9])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-87bec22769asm7856197241.31.2025.05.20.11.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 11:59:48 -0700 (PDT)
Date: Tue, 20 May 2025 15:59:39 -0300
From: Ernesto =?utf-8?Q?A=2E_Fern=C3=A1ndez?= <ernesto.mnd.fernandez@gmail.com>
To: Yangtao Li <frank.li@vivo.com>
Cc: ethan@ethancedwards.com, asahi@lists.linux.dev, brauner@kernel.org,
	dan.carpenter@linaro.org, ernesto@corellium.com,
	gargaditya08@live.com, gregkh@linuxfoundation.org, jack@suse.cz,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev, sven@svenpeter.dev, tytso@mit.edu,
	viro@zeniv.linux.org.uk, willy@infradead.org, slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de
Subject: Re: Subject: [RFC PATCH v2 0/8] staging: apfs: init APFS filesystem
 support
Message-ID: <20250520185939.GA7885@eaf>
References: <20250319-apfs-v2-0-475de2e25782@ethancedwards.com>
 <20250512101122.569476-1-frank.li@vivo.com>
 <20250512234024.GA19326@eaf>
 <226043d9-068c-496a-a72c-f3503da2f8f7@vivo.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <226043d9-068c-496a-a72c-f3503da2f8f7@vivo.com>

Hi again,

On Tue, May 20, 2025 at 01:08:54PM +0800, Yangtao Li wrote:
> Now that some current use cases have already been provided

Some interesting use cases have been mentioned, yes, but I doubt they are
common enough to convince upstream to pick up a whole new filesystem. I was
also more curious about your own personal interest in the driver, because
you are going to get some very hostile feedback if you try to get it merged.
You won't get anywhere without strong conviction in the matter.

> I'm curious about what the biggest obstacles are at present.

I don't think there are any big technical problems, the driver is fairly
usable at this point and it's been a while since xfstests found any
corruption bugs. But it's still a reverse engineered filesystem, and there
will always be risks. There's also the issue of the buffer heads, but Ted
Ts'o has said before that it doesn't matter much.

The real obstacle is that I have no idea how to convince people that this is
a good idea, and nobody else is going to do it for me. There were no replies
to Jan Kara's obvious and fairly friendly objection; it's going to get much
worse than that if you try to push this through.

Personally, I just don't mind maintaining the driver out of tree.

> APFS in the kernel should have better performance than a FUSE
> implementation.

Sure, but how much better? You could try running benchmarks against the two
existing (read-only) fuse implementations. And if the driver is indeed much
faster, does that matter to you for any particular reason? Keep in mind that
you need to convince Jan Kara, not me.

Anyway, it's nice when people get interested in your projects and I do
appreciate that. But I just don't see it happening.

Ernesto

