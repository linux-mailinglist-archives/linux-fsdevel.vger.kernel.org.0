Return-Path: <linux-fsdevel+bounces-59867-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC76BB3E753
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 16:37:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC1F41671CE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 14:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D799531B124;
	Mon,  1 Sep 2025 14:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="wY6NModd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD38257827
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Sep 2025 14:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756737416; cv=none; b=FfbVT1k6SgzUPMs0lddcp0Wn5WPcfnH1TgPrQRvVYzOoiSHPjffoSdiTCsf7FqFV5z9y5k66ZfdNRwWKm4OLMyeO2IZBkGiMux505gDj01wpoucigICGdVZXQyuAbyKg53PjqkAZy1mp8dwO2JZo8+w3Jh3Hz65289uRwsDEMxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756737416; c=relaxed/simple;
	bh=1ayH0f0lTuyb4iNJXaGo4tLbnZOuWSyLSgSbde36d4M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SMhbGBvq2bB+exlnOzNbZlIakvXgpN9YM1y3QVxutmr7pOKGfE+5ZXERNHJxhEl9FKO9mmGq20J3xCvXYcjRakCCxjjCGCuOrHoJtgp6OfO4vaSGPTNCrLXBrBsZi15DxZtIZzywKJiYL090MJffQz2VKn87osfP5gpimvk1oKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=wY6NModd; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-32326e5f0bfso3587322a91.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Sep 2025 07:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1756737411; x=1757342211; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/jDO19l7ZFThfdPORmAcfhKQEo58MHII4cGGvDQ4gss=;
        b=wY6NModddmdj7SfCNNL88kctK2fOzp5iUh7kk76tv5gwprnDggXYRgB5n/lzFTjHn8
         Ha9Y6QXu/3JtR/4qOy9eOOmYLOu8NxqjkCH0u/mKGxpuYybCoKcDWKC4gmMGVIAxezQH
         olh0I2KOVkPJiphIsZMHxOXUMUjh1gNi1SNVIN2LT7gKkkYJ8/7D0v0d3Xsb1uAm8vpx
         PIHaoVvRky+38W7/oH8mvtgf2Gw5Fpu3oAeSxG+wcKGcG31SQ94uwWHiIlA7mPWfy2/y
         Yik1kOKAtwwC4QaTUM4lGL10KF222hvfdA6asi1fxSyo8ejrpAO8BuTLtcGaYilBK74V
         V+ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756737411; x=1757342211;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/jDO19l7ZFThfdPORmAcfhKQEo58MHII4cGGvDQ4gss=;
        b=ctc63FdInIo+cRQHeUpeV0cyueo1dKi5Yp+Rt/iKavlmKiUaWx+gnErdbkUiloTe2f
         y60w1hhZrnSpdTxeQWrSYa67TKFEpSfFx8evtXUHYxY7FoQanK7TgmUPMg1Lt/ITFSCd
         E1b9ar/qbYP0wmqg8FHmv0iHGpesYFDWkILY6CpvO/ELYSU2zOuyUqPkn9pEKre4zOnf
         FYrzpUO+Oj0XVYS4IVPpK3XHMLK5hU1TiISySeBRH/Nj25MM6k+oQh561F0nGY3Wu5wN
         QKyS6TBCdPoIY+K17PnpyoTSGtPKDFgTmwEz9B/vnAzmH+0hpLhU7XN+qhOjFCszau5D
         m3wg==
X-Forwarded-Encrypted: i=1; AJvYcCXXjA/3k9E8Q3AUlbMCA0bXLIva6Nq/E1HHyih/oPPek5K7Ecmh+RXfPqDmC/L37EsE1i7TWH23BGS6sK0m@vger.kernel.org
X-Gm-Message-State: AOJu0YxooVdEEvX6HQO10nrs8unQs9QZ+q1SqbbFhHiySwpSHC7dZlhu
	De1pbx/bw8qY123G/ZzsweEffKjSMPaORMwGv8uZBbbXBGTaSDxPr0vyIaZighyBUxII9JPw7YE
	IZpQ+
X-Gm-Gg: ASbGncvx42dJUJbF3qAms5Sg7cK16PA2JFkZeJfcwerdaG/PmRiV8l+vwiYmseZo1jj
	nDusYE5BypnTDq7mu8TI1SDP5F+LiYbTMHzBLKBc/4rWW/l3pionCQDOz5Vb9kWsy4TlKZFzxyr
	AocOxYDW6+TdEuC/TyUzvXYet9hAoGdUVTwEAnhL2zBs6uG0lY+9EuXZziXC6aaSIsnxxKJseZb
	ZVO1E+9vLDNyLX73GWfAssu/953z6U2MHNu+lcAXd0WGpg28UNySkSly1dNhbdkXmcSncz8WbJB
	PwZPhDdH6jS94NkSTcthfYBd9v6lZPBInj5py41UF51VHi9agOYyYw9YJKzFAP8SR1F0ytSr2Zq
	GSPyA6xuRNJZc31Y5stBLRHvtlOVH4hc=
X-Google-Smtp-Source: AGHT+IEDgykLl29KvHPqIy08jfHAYC4b0vTKX+wBXLvL6c8Y4pza2EMugFk6Oq4/RciPMgqEIFybQw==
X-Received: by 2002:a17:90b:4f4a:b0:327:ceb0:6f6a with SMTP id 98e67ed59e1d1-328154128b3mr10572975a91.4.1756737411459;
        Mon, 01 Sep 2025 07:36:51 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a2b65a2sm10950463b3a.34.2025.09.01.07.36.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Sep 2025 07:36:50 -0700 (PDT)
Message-ID: <6daac09b-dd09-4642-8940-4b70f31ca570@kernel.dk>
Date: Mon, 1 Sep 2025 08:36:49 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] man/man2/readv.2: Document RWF_DONTCACHE
To: Alejandro Colomar <alx@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, "Darrick J. Wong"
 <djwong@kernel.org>, Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 linux-fsdevel@vger.kernel.org,
 "linux-man@vger.kernel.org" <linux-man@vger.kernel.org>
References: <af82ddad-82c1-4941-a5b5-25529deab129@kernel.dk>
 <9e1f1b2d6cf2640161bc84aef24ca40fdb139054.1756736414.git.alx@kernel.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <9e1f1b2d6cf2640161bc84aef24ca40fdb139054.1756736414.git.alx@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/1/25 8:22 AM, Alejandro Colomar wrote:
> Add a description of the RWF_DONTCACHE IO flag, which tells the kernel
> that any page cache instantiated by this IO, should be dropped when the
> operation has completed.
> 
> Reported-by: Christoph Hellwig <hch@infradead.org>
> Cc: "Darrick J. Wong" <djwong@kernel.org>
> Cc: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
> Cc: linux-fsdevel@vger.kernel.org
> Co-authored-by: Jens Axboe <axboe@kernel.dk>
> [alx: editorial improvements; srcfix, ffix]
> Signed-off-by: Alejandro Colomar <alx@kernel.org>
> ---
> 
> Hi Jens,
> 
> Here's the patch.  We don't need to paste it into writev(2), because
> writev(2) is documented in readv(2); they're the same page.
> 
> Thanks for the commit message!
> 
> Please sign it, if you like it.

Thanks for doing this!


Signed-off-by: Jens Axboe <axboe@kernel.dk>
-- 
Jens Axboe


