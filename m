Return-Path: <linux-fsdevel+bounces-20590-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10EB18D53EC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 22:37:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7CAD283402
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 20:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC8C7C6D5;
	Thu, 30 May 2024 20:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="zavOYYDX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0335E6A8D2
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 May 2024 20:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717101453; cv=none; b=JfJHPoWiX61oAh3kPjIXFcm06f/PZKB7/+y3OhvWhlFCaDs1S0+Mbds9Qxb7aOjppAiQZtiN0Ow/SNYbBoK07H12BCTTI1j8LPYuSuNRkLN3l0dM2eloiF5F68E/WKpfsBTDCo8esG60dsSp4wL6B5p/PIHhmHckId6Lp/DTxnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717101453; c=relaxed/simple;
	bh=9c0/L12xPhkjfq+B197g/rMxWM+Isz+4ZfDpjnUsMKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VYqM/jzvw7qV05XfGbckxI6mwUjtz3PIEbGxhRF7GfFoFETcXh7nWRhglPvTpykbdr+AgRl/768k+xH5P6hSTepsEaO8YOKxr4X90CrspSU6YASsQEHUYh5K5a8N8UL4AaOdszy2En1KoYKyebagfPs3dSvLT0o5SZDcSMjDB8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=zavOYYDX; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-24c9f297524so707649fac.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 May 2024 13:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1717101451; x=1717706251; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uSR690JIIfktY/FWE86S+/Pe90Brn/1wrvn1e+yTLN0=;
        b=zavOYYDXxKWQw0TVWeJ0eEStdG//2Q4alOXDwU3tHbWFkLIjGYR6nDEsScfCCag5YB
         5Mm4g4ismchLTxcD62iCrjIc3NeLcUwAoF0l0ImjdlE8q+moy8K/8Mc7WriF67iOxSZQ
         BgCNrk2GVLaE2nWQHwTPXwAz43TMymLpuuW/iouSuiFOVr+EAXfLAPwlLH/RF6jLD//L
         7bGkCT8CunSQDK6YA6NxGBnI2LVRl/pvMmEbvdZGJEY9YfXONNDS1bZ6KhG6kWlBj5FE
         tsYdzB/CziYWyuxNu6VPAY6VL1roOI0POYNXkc9PKRaBK/8mBO7E1BjBG2cmXYDOb31S
         JJKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717101451; x=1717706251;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uSR690JIIfktY/FWE86S+/Pe90Brn/1wrvn1e+yTLN0=;
        b=sYYEMCpCLJ9INR7GD3k2Ew2gVEbTN1bXfjfAYF49o0SsqpI1ZJfT7Er1cGnHZ/aZy9
         5oK+lprbhZYK+zeXF7GAb1EMbqr6Qrx0Ny1eIHDp7lJtjqCSKgzXVyC2XvMc05pi9Nwb
         Zm9JgUxiJrN8WmfGMUxdSA3RNTjKX6rHC44kTuaAQf5/B56oC7xPTBU8HwhrnwfJVMjE
         VWe8TcEtqpxHvlcdekN8ee22cPZdmw39MZSAhRiI/RQMmq66xp4v1pzmn76Wa2PU1hpM
         NhyJcg1TLUubchD3UZvXa01SfaINw5QhCNCOCDcPmAbUIb1VE+8hP/YLMPIN/oS6Th8N
         89VA==
X-Forwarded-Encrypted: i=1; AJvYcCWjkansQNYr7C9Hi0caCc7L2sQkfMg6GCJamut6w7FVbKCCWtz+xdFdE62+vbErthabubcuHC2mhoDoZkeNvHCh5DvVFLl9nP4zzMp2MA==
X-Gm-Message-State: AOJu0YxMz+72L76l+8NEQsh8D25NvjmSNtWTw/DrzvgqT1+LHMDEjN0w
	ETAx7/pIXqDY2H/nqcGvYpILzyzlfy4xppc+1rZvjgqTN3zWiDpQ5hZOtFYYknI=
X-Google-Smtp-Source: AGHT+IFiv27IO7L73GdDDFQxKqcbDxsiW8v2BWHW02x0S+wL/PHKrjDW7nU65oi8GXXK69xWzyyn3A==
X-Received: by 2002:a05:6870:3294:b0:24f:cd06:c811 with SMTP id 586e51a60fabf-25060df4d61mr3738500fac.54.1717101450891;
        Thu, 30 May 2024 13:37:30 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43ff257f055sm1475841cf.84.2024.05.30.13.37.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 13:37:30 -0700 (PDT)
Date: Thu, 30 May 2024 16:37:29 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Bernd Schubert <bschubert@ddn.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>,
	linux-fsdevel@vger.kernel.org, bernd.schubert@fastmail.fm,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrei Vagin <avagin@google.com>
Subject: Re: [PATCH RFC v2 15/19] export __wake_on_current_cpu
Message-ID: <20240530203729.GG2210558@perftesting>
References: <20240529-fuse-uring-for-6-9-rfc2-out-v1-0-d149476b1d65@ddn.com>
 <20240529-fuse-uring-for-6-9-rfc2-out-v1-15-d149476b1d65@ddn.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240529-fuse-uring-for-6-9-rfc2-out-v1-15-d149476b1d65@ddn.com>

On Wed, May 29, 2024 at 08:00:50PM +0200, Bernd Schubert wrote:
> This is needed by fuse-over-io-uring to wake up the waiting
> application thread on the core it was submitted from.
> Avoiding core switching is actually a major factor for
> fuse performance improvements of fuse-over-io-uring.
> 
> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Andrei Vagin <avagin@google.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Probably best to submit this as a one-off so the sched guys can take it and it's
not in the middle of a fuse patchset they may be ignoring.  Thanks,

Josef

