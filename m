Return-Path: <linux-fsdevel+bounces-40228-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 481F9A20AB3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 13:44:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8730168880
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 12:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D16151A2554;
	Tue, 28 Jan 2025 12:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="toD9BBdb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D551A00F2
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jan 2025 12:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738068233; cv=none; b=dIDFeNqpoxF9CPuigJDCdRz++6Amj6x4xJZX8rJxYL3GA6iMLk5TUVMdCwmyvevfYJBw/ygDhIbVvSxyqI86Uyvd6FEpXpK+lXGHFIzpoTI5KUgSWNGvv9xPwewBdI0IGWTTjqiGI9yoSh96P5WK9zRm9HrdELbDyUiPsQFFXLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738068233; c=relaxed/simple;
	bh=q8Er4qI4ahI2S5C3hn8Eausgk4LAf76H/o7/smjFzjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q37ezzglVRi/Wi4AKE+5Ya4KnDZ9IxjR80aODTFmVE0O1o98Apn9szFt16vjY5Z/HSjXYViab98a0NhML1G0auHK4I9dkfUgHz6N9/iVNTR+S0AyFktaA4uv5Yu3g/jagFUgrcU288qUOotM2yBW8Oax1vjNkSOpbpKk+En6myw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=toD9BBdb; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43625c4a50dso36750735e9.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jan 2025 04:43:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738068230; x=1738673030; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2npVkOuOv04Tel6DkNspjpRnmGdY5QLsfu3aoyjOBac=;
        b=toD9BBdbhIF0GcZCtbJ3Tw3KsiPxcG0sVvCcr0NxO/kgcm4Ic/7jxzdq1Hv0FbiYZU
         jal1+RCZDah5Udh88V3OY34ctqk1nRBASyjIbpFpuPtqwe9lp5iFTcE8u2xG82TKPpuY
         MbTry9YtpDmH+04+HXN8GqquIxCEjwH6E7G2tN0yzubwJoVElp38x5dW1Nb2k+qE4/0m
         VuIbrdudODy78o8CDRBY7SBrgr8qzOb6um6xlsSL78FNiYbnaCUUbBDGzaFELRLHtRhx
         pnMMYfzwUwwWVWl9EAe8dKbM/a8ikHryg62v89p9mWEQoVH01SgJ4O1MZpT/OCfWGVSh
         U9gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738068230; x=1738673030;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2npVkOuOv04Tel6DkNspjpRnmGdY5QLsfu3aoyjOBac=;
        b=qEwzyWxcrzArJBSlZ0mt9yXdtMX5hWMINEgenAj7OzK77wMpR/bX+9sSFMTtfInuN4
         4rPqrkOCpQkj3xqlKguwW5hPZcMJn3u5YLc2P+0YOtqZuKP5UXXatOWBcRe7rYLAR0uO
         4E3jZJmkjKzmHNuGNFZwOgAuB9hqFbPkZOlwmV9ucT5HAgiOFTNT+WX7hIywi5rS2R/m
         jKrTywWIYDUyuzXGSi6Svm6EC0qG9/tGkuI0tAFW0wqh+UUUaR0pVTWM8FoE3zAPzU4/
         joQlKGev77eb0UdS0I8c0pu9PUY31MHjiCrPvB9lIoCaOmYPTkuqHOveA0prvR3S9Jvs
         AswQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7DMyRiKKfJKoEJdosHAIUAp977aiLZMeWEFcKeX6BB++I+A/gpgiS4509m83ucL2tCME+qnL+z+5Rfj47@vger.kernel.org
X-Gm-Message-State: AOJu0YxV3+0zM0g2ZNPb16yijjs/lwxm3OgOQ8BONpT7efTu6e5z6R0t
	erCAm8ETDH+MdlRCDVsqYMBVL77Jj708XRF8UziqTLcmMk0DDfC1QYUdjh02wng=
X-Gm-Gg: ASbGncs2wQyeP83pZMNta3v1gPA1v3qHc5BFDyh6K0qOubo3jIJ8/ZPnce2kV472BFG
	H37+BcolxhcEcf+pDuIe8+lhkQgkCjHBANvQV45tHu3xFZP2mz1HHfAk/yhK93cgfaLzJRmhNEa
	yBY5UHDc6sVSJ1AgqHsEx1arWf2xWposqHzc6ZYvrFt2xidUt/iWVX7bPTceEXkA1KdkxYi81DH
	IMiVxKvMmwHRvzmTH56rL5e/2XAtZZcegg2xncJ8W2gwWNSmFNohMMHKGTJ9eQ96EnaGv/vnlf8
	YvssX0ecbTaPUDWqzT6Y1AxvO/K8oCE=
X-Google-Smtp-Source: AGHT+IEi1DubB0W4MOkD9qS8FRtXR4Q8D8HYzqTNZ2v21+5bX3PonF8dkrWl5tvWlJEytvuJGxKttA==
X-Received: by 2002:a05:600c:5486:b0:434:a10f:c3 with SMTP id 5b1f17b1804b1-438913cae48mr369108575e9.9.1738068229824;
        Tue, 28 Jan 2025 04:43:49 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438bd4857b8sm166100695e9.15.2025.01.28.04.43.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2025 04:43:49 -0800 (PST)
Date: Tue, 28 Jan 2025 15:43:45 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Mark Brown <broonie@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	kernelci@lists.linux.dev, Al Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	lkft@linaro.org
Subject: Re: [git pull] d_revalidate pile
Message-ID: <bef98fe7-6310-4d24-aacc-3e629fd786eb@stanley.mountain>
References: <20250127044721.GD1977892@ZenIV>
 <Z5fAOpnFoXMgpCWb@lappy>
 <CAHk-=wh=PVSpnca89fb+G6ZDBefbzbwFs+CG23+WGFpMyOHkiw@mail.gmail.com>
 <804bea31-973e-40b6-974a-0d7c6e16ac29@sirena.org.uk>
 <Z5gJcnAPTXMoKwEr@lappy>
 <3770d3ed-e261-4093-9a41-90f0dfdd393b@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3770d3ed-e261-4093-9a41-90f0dfdd393b@sirena.org.uk>

On Tue, Jan 28, 2025 at 12:14:07PM +0000, 'Mark Brown' via lkft wrote:
> I'm able to decode (just feeding a random log message in, no idea what
> specific build generated the log message so the line number is almost
> certainly wrong):
> 

All the kernels that we're planning to boot have the DEBUG_INFO enabled.
Here is the config and the vmlinux.xz for this one.

https://storage.tuxsuite.com/public/linaro/lkft/builds/2sDW1u8fB268uU3L32J8FqAxYYR/

I don't want to explain how to find this URL because I've filed a ticket
to make it prominent so the instructions will change soon.  And ideally
we would just have the line numbers on the webpage dmesg itself.

regards,
dan carpenter


