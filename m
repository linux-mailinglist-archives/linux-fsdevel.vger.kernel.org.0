Return-Path: <linux-fsdevel+bounces-46108-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0EA0A82A76
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 17:33:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DF739C0D16
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 15:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14A3C267393;
	Wed,  9 Apr 2025 15:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jyh/lUEU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD4C1482F5;
	Wed,  9 Apr 2025 15:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744211918; cv=none; b=ZAHdSFdg6xNVe9mDMdASGlHPlIBBIS+L4ZgLlMMhO0RoOAZlp5UFO3XV3vIa7uckHTsNRn88KluE2nsQgXb0pf0s/77h8iuvQq6zGrHErGUH8aGMczoLlpkOCJ8PzB0RBS8TyER3Iy21eFfPYI3zGgJ/n5GLocrT9ZHsaFm/ylE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744211918; c=relaxed/simple;
	bh=uViSNOAqAkmUraE/cJ3HBL1B127TQ8IrrZ680tfIqa0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jstc3qorrCrZt9qkEyx+jJ3ySlSxTjHy32hqBR6bd9ukQzpmKfZXGbAEH/c8tBYVjawK0qlqFYL3mRmnwFlw+3ejDB8QTCyTWqM05Pgw8j/GPcdS1K2SnfrloQuC6XFQMqBvQRzOYxJ5lqlfHN/iOTjbCPcBiZOpGut2J46jHDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jyh/lUEU; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-39ac56756f6so5814031f8f.2;
        Wed, 09 Apr 2025 08:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744211915; x=1744816715; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lGKy6jggFaaAC/3IEsCxAnoHmSQ+hWKoUuhM5yojB78=;
        b=jyh/lUEUMXjodMiPtgY7ZlrlZ5zeRkqbtV9XTnlT5KyBCnsWGk/emTJpDVf+sNwuGJ
         KPp5FNJOlSIy45ciFBSWtHg0Ge0xaYQbHKQJ57V2DvldixxRilA7D4MGn3QUba62yxtI
         ENKrME6gmPVv8V0esZ8Es9gByAskdXTrBy9SRqIiQLp1TbXlnKukpnA5ejbgAmp5Il5n
         aNprz1C2FPz34ZTsT1KyiedkNjReTxPZZd/K5W6dTZl7Sk32REvF4C5uwl1FXopS6w1l
         kS7XNRvRNS/2+CREW6TQDgGE8NmkuItHPOqm/giAT4QGSgLHboatRhLqzOtYBmwGfNGN
         iRrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744211915; x=1744816715;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lGKy6jggFaaAC/3IEsCxAnoHmSQ+hWKoUuhM5yojB78=;
        b=rvBP8LG4htj2rqf1x94TK1pGX2V3GSFFrmlGFuVKAe34UbyugYyt5OJ2+OfmtS18NE
         HnTaeuQF4TY7Je1/0DF1P/jqbBWI1qV+AGHUoMxRQQkw1VH6kodcqmO4lF13lU4wOYmG
         eYs8DxBh/nW6idrFjZU1CGYKiKlwde1cXIj/9WXwkusgHd3Uo8U7zTWCPVl9bR/Lrynd
         Q76zyX0oKtX5Rb67nd+AFmWGACpM22TTEhcnyHq69HAN3gma2CcancYAvqOhO9o9+Kqz
         rUsMJWcrO7MjvCQuo+7gCG8qBO3u/VezbJwBrlIcuFiBfcJ3sCo0+aU9+ypswK2Vj8Ad
         ASFg==
X-Forwarded-Encrypted: i=1; AJvYcCWel++a2OA7xxrHR7843PKborGbt0dGuzLi63p9pSnJZEHOiEXDlOiBv92LFlzEkyphx8G4cV6MwACOnpyp@vger.kernel.org, AJvYcCX0OVvzCMec4dhhR/tNPG+IliWfokSBIJHZaVOG2N7SaIgoajdFaydASIovaXr3Xl+RfmZ1nMG9BE2TFhtcguY=@vger.kernel.org, AJvYcCXQpRF2vF0LYhadjis22FfgMmgty3RtW6O1ISIQkWTz1UjX5WskxWjXOS3NHNkEsHx8dtYO4KqW5e5Rx03hew==@vger.kernel.org
X-Gm-Message-State: AOJu0YwyrkKFdaLaGzjfQxtf1mIbc0J9dDVRwyPVZJWaiieOdT3K0PIo
	RQcQFXY7C5C9h+T8eKsNJvrBMc8P4yoNyfuPwL4V/CI8X5cAR3LH
X-Gm-Gg: ASbGncs8TFBlPHbsFjBz8UOCRJ0ffdzb5rVQRK2V+CMZm4ORCsJCDjv/lyMEbjbgwDS
	Imo2WpqCcRGcNA1OQgzna9E3pFG20uot/exdn+8PsFEhZLmeaPrK8KsDggwH+iqv1BHHA8z4tGo
	K46RJCEPKSqOos3CS0D3Cw5g78ZjFMky3h7Ke7bNsW7cUCN0qhEvTQXVhQ5akXgrnie32MPMCIE
	EEBTDXcb0chQ6kyGd1+0ym8LEjS7KKZlOCGPBT39nMFMddDueO8Gapz0Yy5cZG7zzAWwc2LTDM9
	81rcF9QF+zT3zQVtYWLrr7VkRMFMRJr8U1KXm06dMAFCRdF1UE7hzxVZ
X-Google-Smtp-Source: AGHT+IHrWEeUbn/ofyzKeGsGVmMQyyF7VSvjS6DBt2BYcu1AMBMUwUXtdCBz1agZtaaqRgeeGIh58g==
X-Received: by 2002:a05:6000:2aa:b0:391:158f:3d59 with SMTP id ffacd0b85a97d-39d8852ecc6mr2918176f8f.15.1744211914798;
        Wed, 09 Apr 2025 08:18:34 -0700 (PDT)
Received: from f (cst-prg-17-207.cust.vodafone.cz. [46.135.17.207])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39d89402a08sm1881192f8f.100.2025.04.09.08.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 08:18:34 -0700 (PDT)
Date: Wed, 9 Apr 2025 17:18:26 +0200
From: Mateusz Guzik <mjguzik@gmail.com>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] select: do_pollfd: add unlikely branch hint return path
Message-ID: <llt32u2qdjyu3giwhxesrahsh5a2ks6behzzkjky7fe7k6xync@pvixqbom73il>
References: <20250409143138.568173-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250409143138.568173-1-colin.i.king@gmail.com>

On Wed, Apr 09, 2025 at 03:31:38PM +0100, Colin Ian King wrote:
> Adding an unlikely() hint on the fd < 0 comparison return path improves
> run-time performance of the mincore system call. gcov based coverage
> analysis shows that this path return path is highly unlikely.
> 
> Benchmarking on an Debian based Intel(R) Core(TM) Ultra 9 285K with
> a 6.15-rc1 kernel and a poll of 1024 file descriptors with zero timeout
> shows an call reduction from 32818 ns down to 32635 ns, which is a ~0.5%
> performance improvement.
> 
> Results based on running 25 tests with turbo disabled (to reduce clock
> freq turbo changes), with 30 second run per test and comparing the number
> of poll() calls per second. The % standard deviation of the 25 tests
> was 0.08%, so results are reliable.
> 

I don't think adding a branch hint warrants benchmarking of the sort.

Instead the thing to do is to check if the prediction matches real world
uses.

While it is impossible to check this for all programs out there, it
should not be a significant time investment to look to check some of the
popular ones out there. Normally I would do it with bpftrace, but this
comes from a user-backed area instead of func args, so involved hackery
may be needed which is not warranted the change. Perhaps running strace
on a bunch of network progs would also do it (ssh, browser?).

I have to say I did not even know one can legally pass a fd < 0 to poll
and I never seen it in action, so I don't expect many users. ;)

