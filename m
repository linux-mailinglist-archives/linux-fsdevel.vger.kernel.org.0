Return-Path: <linux-fsdevel+bounces-24501-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CFA393FCD5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 19:54:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD42EB220F6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 17:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42F1816D4C3;
	Mon, 29 Jul 2024 17:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="juNA0XIx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4146B3D9E
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jul 2024 17:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722275669; cv=none; b=ZQDQjI39Rv6QMj+A+tNyQiJNi+x1UrR/gx7ea/vvSYHj3lSTFPdR0wevWZ0DgugKnq2QZQflNILQfW6chEFqTwjOl3tS8s/TlJUJ9P8ci2iwCRDIh1veYEC/iYS/QE85n4ueTczhKCCbU6uvCGF86Fk9C5mQk7NBh1spKAc4TZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722275669; c=relaxed/simple;
	bh=SW3oGAfVMPm0uEuuqol6Uyo/zuzF1cblDMaX0/YXz/A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R67A3TUNTd7ZdQyuAeZapBEyXpHAJvVh6UjFgA6YLwOqQjByJzq+3Bas/ypeY1KkHFLLDKOvJrEcTF+cewyqFUkTie0Elbd2ZdfY6cw9JZIq4ENuoASL34Mz3UdLrasOR1on4aZhnoFLt+eB5Vk3GgEdzGtnTeHzm2SwDooRJ9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=juNA0XIx; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1fc4fcbb131so30151325ad.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jul 2024 10:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722275667; x=1722880467; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/0hsyBFlLO2CQa/IO6w/Fj0EWeXlM4bwBriNfynea2c=;
        b=juNA0XIx0chFhC5Ovxqf+hJ0dV3pDR9zcyQ/K/5vkPbbTN5T69wa/Bzpg6ukCwuNDk
         JG1BjMAfe9dL0X0xNfwoglRl7zoucvS5DQRXWNfsXjmFcZvI/hJZr4NlG3Rczwb9bI4J
         mcJvI9AXA/dYcRcIjR5fKq6kYFxoRPfh08yT0QBd5Y+QD3UXh0jjVM0k9IUPftZnFpBS
         6/wVmsMdRq+9bsr9jcC+LQrBSlfpFrx4Is+RdG87bh5l/NC0yg4b2lx0yK6ayzSYCnQF
         lBsjzXoaZyjteqQxNHZg22Wqu74rjnJMvJkPhR3aKxy2vnB3g+Vxcm1EcLCPjY+kJd36
         jiFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722275667; x=1722880467;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/0hsyBFlLO2CQa/IO6w/Fj0EWeXlM4bwBriNfynea2c=;
        b=Maue0vjxpRkC9bnAdLINGeFqWnP/aySVwt8KjenB3MVHzGItkc658mwnyDvHys3Td8
         StTYbc1C+N/ofOtbau4Ed86vsAXO5ryRiedy16uR4Vkx02XADodfI2McHuvWEX/wpjYw
         INgbwAs0NvpFEfvfJKXCG1go9FEcj/mmcaYFJ9zBcMTt+vOJqTXSeuwg+YlXbYl0PZkm
         /8k8OJxiDGJSfEyu+MB8SEc53qzNho9BGde5S/n+7yiFU3OtD2APB8tWkfK9jYFnG5Nh
         x+DNKzGiS+ahrmVchpDOCSUSCUO6PDutakKs0b5R0lx1ZABU+sJLinAEaZtmI4Emy6gJ
         VKFw==
X-Forwarded-Encrypted: i=1; AJvYcCUnBrKoa7D0LSDIRHoUL35bIoWgwT9ONESl3+Kcn3ZVxJrRSo16+9g9Y0V2+rHeUtVX4uQk5fqgDpcbNq8KYF83b1Bt2lz5EbqUON3jfg==
X-Gm-Message-State: AOJu0YxLBrnC4SB9QtEkmSuRgliUoTYaQLns0y8XAC37ZG3UWsAJhIq2
	r5LO4IwMqehndTLJnObnhG2PK0tcLWp+HNSQcU1E1CGXJ7bqZnw/RFPfscpMWUM=
X-Google-Smtp-Source: AGHT+IHdK/BS/Ov6FIcj+CNprhIROTmKMfREYr4Hc0fd/4OepYk9deh/UPOthI/DmlyitPgPUQS8dw==
X-Received: by 2002:a17:902:ea06:b0:1fb:8e98:4468 with SMTP id d9443c01a7336-1ff048d4e62mr99796415ad.50.1722275667526;
        Mon, 29 Jul 2024 10:54:27 -0700 (PDT)
Received: from ?IPV6:2804:1b3:a7c1:1944:8c6e:e348:8840:3068? ([2804:1b3:a7c1:1944:8c6e:e348:8840:3068])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7c7fce4sm85851165ad.32.2024.07.29.10.54.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jul 2024 10:54:26 -0700 (PDT)
Message-ID: <d8a20aa6-aa21-485f-b4c0-e60f654d1733@linaro.org>
Date: Mon, 29 Jul 2024 14:54:23 -0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: posix_fallocate behavior in glibc
To: Christoph Hellwig <hch@lst.de>, Paul Eggert <eggert@cs.ucla.edu>,
 Florian Weimer <fweimer@redhat.com>
Cc: Trond Myklebust <trondmy@hammerspace.com>, libc-alpha@sourceware.org,
 linux-fsdevel@vger.kernel.org
References: <20240729160951.GA30183@lst.de>
 <91e405eb-0f55-4ffc-a01d-660e2e5d0b84@cs.ucla.edu>
 <20240729174344.GA31982@lst.de>
Content-Language: en-US
From: Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>
Organization: Linaro
In-Reply-To: <20240729174344.GA31982@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 29/07/24 14:43, Christoph Hellwig wrote:
> Hi Paul,
> 
> thanks for the answer.  I don't have a current glibc assignment, so me
> directly sending a patch is probably not productive.
> 
> I don't really know which file systems benefit from doing a zeroing
> operations - after all this requires writing the data twice which usually
> actually is a bad idea unless offset by extremely suboptimal allocation
> behavior for small allocations, which got fixed in most file systems
> people actually use.  So candidates where it actually would be useful
> might be things like hfsplus.  But these are often used on cheap
> consumer media, where the double write will actually meaningfully cause
> additional write and erase cycle harming the device lifetime and long
> term performance.
> 
> Note that the kernel has a few implementations of fallocate that are
> basically a slightly more optimized implementation of this pattern
> (fat, gfs2) so some maintainers through it useful at least for
> some workloads and use cases.

We already have discussed this some years ago, where some bug were marked
as WONTFIx:

* Bug 6865 - fallback posix_fallocate() implementation is racy
* Bug 18515 - posix_fallocate disastrous fallback behavior is no longer mandated by POSIX and should be fixed
* Bug 15661 - posix_fallocate fallback code buggy and dangerous

Florian even sent a patch to remove the posix_fallocate implementations [1],
which generated a long thread of potential pitfalls of the fallback
removal [2]. 

Florian and Carlos, has anything changes in this behavior? 


[1] https://sourceware.org/legacy-ml/libc-alpha/2015-04/msg00309.html
[2] https://sourceware.org/legacy-ml/libc-alpha/2015-05/msg00058.html

