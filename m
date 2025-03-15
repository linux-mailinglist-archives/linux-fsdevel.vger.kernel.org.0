Return-Path: <linux-fsdevel+bounces-44117-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9D45A62CEB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Mar 2025 13:49:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29358177694
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Mar 2025 12:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57B271862;
	Sat, 15 Mar 2025 12:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="RMSpSpat"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5D31E1020
	for <linux-fsdevel@vger.kernel.org>; Sat, 15 Mar 2025 12:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742042960; cv=none; b=mXU6IEnjwGML+uvGqlRmo96YXIs8iJo9zCqQiH6BV35x+SKx5DOmf6EFzqo+yoaMb8ozDfszZlU0jP4JQ5jc1raylCejsX7ANeTG0dINzwbe0cCYVi/VWfzv2JqwtJFIpc+Zvzig8wBq0oZ5tLZ2vxytybL51bW+/EL3CThpng4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742042960; c=relaxed/simple;
	bh=05JSQo4E4e16yna6TaRjgUO/dZL7kxC7dKCEImr2GTs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bTuU0CwXx81SbE1gniYESa3Aj8pWbi/K3+f3CYSETgMYc6P55za+cBgJpieNPksEnCLGcWhEAgSkRkUoN6vbS2qH3gb3xuTEyNIgxdJ8RC0oayGpGAZ8QNOndsagOoEXGI/rfyznIa02is/dWYYZCeIEnAqr5x1No6D+NfNavzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=RMSpSpat; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3d439dc0548so10503985ab.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 15 Mar 2025 05:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1742042956; x=1742647756; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wmlHeMPLZ4MzXIMkVv0Emzj2xXJe/d+YNdrC71hs5UY=;
        b=RMSpSpath70UTowSNuZ4dhx/PC5/f6USLnnQdVO6tP4vmEgZsv1zLXfS1RDB1MPB7D
         dA/U4tLRCtI9ZUq5cQJJGGpsQHzWZaQqOAY6MQ+dTaQ9aufuRtBCzYzvjrvtwgcPpmf4
         EHo3VuWwSs5rKQiNz3wPp4AoMOEbxUmDVyS7Htld2/O3sfp3sKNKzmsbkDo9bntTbwKz
         Tx14m0CvtaEPVZhP5PWy5cdH3k7A5t46r6C9Ai0AASsE2/iu7RhyLhg8zSCBlr1RDba8
         4gtJ/6IiMbfb3tKvwdr9ToXLmTZYg1X4K8FmRq0LFu0JTUrjmbex0qzPJti7xomoaEo6
         5ZxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742042956; x=1742647756;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wmlHeMPLZ4MzXIMkVv0Emzj2xXJe/d+YNdrC71hs5UY=;
        b=cM1hsQLdtQloCAGJa3go6njcuVkuWz20A8PJ4O4CfeInD0C2JqJ/E4mcD2w1hzcEGG
         71jPMOI7UCEnoao3eIwfzDut+GzOeyIFuaXudaYxFMZLx7/6BrLutfmKQ0CGMTUmOf8Q
         5cZQYQc4CO4jGkboFyu3J4Ylzay54waEmhIYLsNOc/CBeN07GlF2yY62J0JozLQyC4MH
         f5hFd3/SKVbZgu7qO/6kex1TncgrUfoQ1nrfW7/VoFXejvXy1VrrTxci0RLHZztN+mDE
         vBnK2qR4r/+eclOIlxW2+uHrp9Ka4H9dR9CWGkI5GljheOZx36hkWI65sungNTA8TelD
         Q2sA==
X-Forwarded-Encrypted: i=1; AJvYcCWHcNf4WMTA8Sfi08RlnGoF0sqJWGvpvU6c/7/xxMdn9ym5ifteJ3T5Vc5IoOqI9xuHvZRDkBW1ldz3nqvV@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1PVYozTl/bc6GqMYN4l9y0pvo2VGD0IFl8spNTtgZ7axJpH3t
	VnjcC/2akYerP0AZ9XYpGnayZ6ZC0xzti9dYep0z3C02s9o9wmN0QLyMdy/wTcM=
X-Gm-Gg: ASbGnctuXDLquMBTCFdmL66FQ697KIpOsvhTUVuRMyGzcsqJVNyoGNvyk4IkdkoCcXm
	T+ZBkvQeg/VjhCMn2H9qOwN4cT388HE9QtTid9zKghrh3KkYSFIXKR9/qMVd8jLDg+0Cd6C3vtO
	cAMrqfPSb35uHBfRwwii6kjIWkbRV/AliJ2jPT5UdRFKwDGTCUMtG+vr6cauyJ988qSOFlujfyI
	AgTjXTBekxG43U33l13Ic/YUl9Ev4OHbFrnFMF1jJT406MuN5Qv0xuI+73sXodoN/O3R0dAktX3
	fdVk+p4BeYZ3JivKm4Bys85BbNES+bqLuAqswMYN7g==
X-Google-Smtp-Source: AGHT+IF+CRvPDGmWHAB+4PB2tRha7ylWNaFaXgmGRwUHKHOa4BSkiy1X26EDqqzUYWNC2M43P9DUsA==
X-Received: by 2002:a05:6e02:3f8b:b0:3d2:b0f1:f5bd with SMTP id e9e14a558f8ab-3d4839febd3mr60107935ab.3.1742042956387;
        Sat, 15 Mar 2025 05:49:16 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d47a72c8e4sm14787445ab.58.2025.03.15.05.49.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Mar 2025 05:49:15 -0700 (PDT)
Message-ID: <23e12af4-87aa-42c8-b3fb-045a23b9b18a@kernel.dk>
Date: Sat, 15 Mar 2025 06:49:14 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] xfsprogs: Add support for preadv2() and
 RWF_DONTCACHE
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, linux-xfs@vger.kernel.org
Cc: "Darrick J . Wong" <djwong@kernel.org>, linux-fsdevel@vger.kernel.org
References: <cover.1741340857.git.ritesh.list@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <cover.1741340857.git.ritesh.list@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/15/25 2:20 AM, Ritesh Harjani (IBM) wrote:
> This adds following support to xfs_io:
> - Support for preadv2()
> - Support for uncached buffered I/O (RWF_DONTCACHE) for preadv2() and pwritev2()

Looks good to me:

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe


