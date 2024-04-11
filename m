Return-Path: <linux-fsdevel+bounces-16750-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8DDA8A2046
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 22:34:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82F06282C08
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 20:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 385BF1B809;
	Thu, 11 Apr 2024 20:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="bTjlyc0+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D52257B
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Apr 2024 20:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712867684; cv=none; b=k0NIcyv3HZ0hjYwMV3JyRF2xnrrUKVzNZbLKZVhyuyLkf04Z+kLHTCm1QzxA8BvvdRb6vyeGcJkz41kwINclQO3fWWxjQBV+qxKAaxv/SoJQEQj8Xoaf+cZw9ycKrmL7H3z3Q/TL4OduogkEzVZ9hY7qvCNlpe3KV7KoYMn+46M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712867684; c=relaxed/simple;
	bh=pvL1Zd6rBjAA4vL2Y6BHYHDyyPCV5v1Mwu3xdblacAA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A+Ax++7QC97Yqky1n6Wl/C5BcSwGorvdKcmcri7c5lCG5Oq9SWx2C1x1iYtGiMr24kZTT4LghGScyiPNmcWClprPBgHhECp2zmjPrUssi9ftFMF2URx0334Z5p5BhMdAcYIgecayK8JdPzca94YuvpmK5kzZTtnInOfKEI9fNiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=bTjlyc0+; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-7c8e4c0412dso2603139f.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Apr 2024 13:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712867681; x=1713472481; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HFQrioCTLKkhRptmdIkcvOHp0QHA+wFxGV+r5aMx7Jc=;
        b=bTjlyc0+HwIIU3VomJCm/sp5XJCC1sMADa5lN7A5qtvEbwPtYvg+8o1tHea8RYsHQ2
         R47nBePXMNAhTBkL7MWvgucXNCUGUuPerMQJV5i90gkpaiaN3fh911nT8JwpJZsPWIqc
         BZDjmHrEYIwDzMors5j0dljGB4K8MbrjLhy02eQEmKae9derjbntvhClh3pFq+YdtrnT
         nRu+Dw/fe/uTkC19oM8kNai/jo3x/UuKvkeJqlNeEBq+mn15q4H7v8bWoSZu0/9Nq/GG
         gUeEdvNkC4OTWTHY6p+We5mHpJ37IgVMDa1pmluxBJ9wcAJe8wKSHCCDqF+Yt45+UXcB
         tghA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712867681; x=1713472481;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HFQrioCTLKkhRptmdIkcvOHp0QHA+wFxGV+r5aMx7Jc=;
        b=Nrvcdhj7j5b3alrhG+ymjnrBVn2BEg3z/7ZDB2PtZJ2lyEAlu52XT+3bPGIwfIeAfX
         l4ePLhIQyon0tAPG/FswiweqxaZPrbJaNz1RHTBpjeftCzqbPoRO8EV0gHGkmjz30bwc
         n3zVz2tY/v/803eg9vWj4K4F+4WmBZvDXEQZ6nPVlJ2u0rAE6T3+xnKQHb6KgXXbQNAr
         26inoPwnHnbjgpDyRQnZ0ODaCAlaCI9Q76gzbYJYKpGsGPIsLRycq6GvuDDoq9Hk3Iq3
         p3f/eYBp9c0bpQKdtJMnCXhcZ+JJFs0PKbOIExLTEj4mKKuBwSr/YguNOV8Flaz8Rxdi
         cs6g==
X-Gm-Message-State: AOJu0YzIO2Xdqa0IGSQJXMaLRAOfTX3MohljVX/zrOThxJ0RzVYdh91I
	iWqhOFyjFvRtG06g0mVhEIfXl6l9GzNWBTr83t/QydgJCd2iXKkIQQgt+okmXKA=
X-Google-Smtp-Source: AGHT+IH2/BSQLLGqgAq5/+W7YHGk2rJZKu3FRGNYECp9/GB8j1FiT0Mhj+rId81twI/jAAZAKwpqwg==
X-Received: by 2002:a6b:c34e:0:b0:7d6:7b7c:8257 with SMTP id t75-20020a6bc34e000000b007d67b7c8257mr980356iof.0.1712867681396;
        Thu, 11 Apr 2024 13:34:41 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id u20-20020a056638135400b00482ba6c8fe7sm602849jad.116.2024.04.11.13.34.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Apr 2024 13:34:40 -0700 (PDT)
Message-ID: <2378b252-678c-44a2-9303-a0450a4cea4c@kernel.dk>
Date: Thu, 11 Apr 2024 14:34:39 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: commit e57bf9cda9cd ("timerfd: convert to ->read_iter()") breaks
 booting on debian stable (bookworm, 12.5)
Content-Language: en-US
To: Bert Karwatzki <spasswolf@web.de>, linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
References: <fa36ba8c12e0243c717ba33d3fec29cf9f107556.camel@web.de>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <fa36ba8c12e0243c717ba33d3fec29cf9f107556.camel@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/11/24 2:31 PM, Bert Karwatzki wrote:
> Since linux-next-20240411 the booting process on debian stable hangs during the
> init messages. I bisected this to commit e57bf9cda9cd, and reverting this commit
> in linux-next-20240411 fixes the issue. I'm running debian stable (amd64) on an
> MSI Alpha 15 laptop with 64G ram and the following hardware:

Thanks, this is known:

https://lore.kernel.org/linux-fsdevel/20240409152438.77960-1-axboe@kernel.dk/T/#m07fe27b781a2e558ee6d260e317b79e72f401321

and the current trees have the right commit. Tomorrow's linux-next should
be fine again, sorry about that.

-- 
Jens Axboe



