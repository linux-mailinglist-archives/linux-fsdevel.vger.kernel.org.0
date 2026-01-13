Return-Path: <linux-fsdevel+bounces-73512-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C03DD1B31E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 21:24:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E817230783FB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 20:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71FFC36AB40;
	Tue, 13 Jan 2026 20:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hAYQN5bU";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="lGISTEJw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A035F320CB3
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 Jan 2026 20:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768335823; cv=none; b=SwLe3Lo6ed1sx0KL+RE+J5QLnCevjxl7rHmLGG9Ml9NgMqrdAxTTUuSEAIVRRMQlhjgTR56rnmYdK8/X6Rns0Rru8eAb4iIAqYACVVCzOv+eBE1sCw4OCo+4dRB9X4i6Ummy8aNJ/p1P5sior7IMvO45cveJT9EujfLfSahikHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768335823; c=relaxed/simple;
	bh=XlE+bCW80iW5/YA8FQw4HMEkrwj/cUseo/dNGbfLUdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bxCVZMNNyH5s+G4/NlGhWgLi4x4+uqGclGiZLREiXjFncScwCHwtPOnZQj+p9wFJBtL2Yt+YbvfXCWa9VEbic22kR34cnRpGyOHaZ3Ix16EPdj1dM2m6NA1E48RkL9IKaCNBXi5H5z7rbD65bTYV7SPIp4kTAikl/zTwSLKqGB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hAYQN5bU; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=lGISTEJw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768335821;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LoKrgEsjVmaXB8RR+lgvPaiMnjoQkqTVAO9hkcrceb0=;
	b=hAYQN5bUpbsjc47fwYM9jbVB4VHj5Ng9nBSYCGbexp582tVcKyc/EvaXIObODufKGu+6sp
	Usq+/v1aaGY1eOtRR6hBp+o4eshaiFq4uETssFWo8Ibne3hkTWqqtv00buwj90EwZXvy4B
	RRoL7vKztwOrfycXMXDi8YfPEs/owus=
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-673-MfgpXDVxNI-yLXvMQNq_Lw-1; Tue, 13 Jan 2026 15:23:37 -0500
X-MC-Unique: MfgpXDVxNI-yLXvMQNq_Lw-1
X-Mimecast-MFC-AGG-ID: MfgpXDVxNI-yLXvMQNq_Lw_1768335817
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-93f568048ccso10391361241.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Jan 2026 12:23:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768335817; x=1768940617; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LoKrgEsjVmaXB8RR+lgvPaiMnjoQkqTVAO9hkcrceb0=;
        b=lGISTEJwYmj8D+TnRE9L60yJiwvWykSz8S46SdyBWapWszqAXmEgNcNdLiUwSUv5WU
         B9N2c1gaLwdQrTqAfEX4O0tPtS16oLplC3LBiTJpuXOg0ABmTbVJz1BatUGK5FkVTBD+
         N9Oxjuc+iWyUtBRwJHCqO9XQZqyHjikkwkS20BbMsQm/etImLeHOSu0gosDXvRwNQ2sr
         PpjysVW5TSPvKLBlAEiA+Zj0lGoy52ulN42NTSiIEX9Uy3xbA/ce/yRdq+sbVSxzz04Y
         6p5H1ibDBG1enRwaurfWqVoaUxzz8whci7oFA/xVN3lajbtnQNAxKKKfQ/QcC7lGLH0c
         Rylw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768335817; x=1768940617;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LoKrgEsjVmaXB8RR+lgvPaiMnjoQkqTVAO9hkcrceb0=;
        b=qaZPSX5fT0XGnWzLZFKu+3XZIYc55ShrDE5y/m15DOAAp566/6r5mpNFWIrCMrJF2P
         X4IEUv1Y48dvCJIAUNwXGOn2UgK3NTR93qX6HI1EQzYsCf8rjxA2jPbFDN8JAAPyOHCk
         lNFrmMAOXKjp17PSAHvXWvN05zJ0aaKHgmd7BMhe3Bh16u2I4ZTlmdOHxDt3AJegKy/x
         e55DILqyQm1rYN9Q1yan+YLCUDhJlDN5OFRlVhVQtKU1nTiM5aewGKku51uVjBIKoqNi
         4YsS+1oZPKt3GLpi5deE/R4RSk47RUBVwwHVJw5mEWhZ4UcdLHOymrwS9fJzqUljBsrD
         JZjg==
X-Forwarded-Encrypted: i=1; AJvYcCUkgLGnjKkLtYB2BczmZ+6B2vznH/n76Ef3ZgHCoA2RLXfkkFAWFvvjrSEh3xHZ/DursQlUJn5cYXnPi6qb@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6nLd0HsAwQKp3Sp7jPURPeK+dttO8yfmmC2lwKeyhTNVvGVwi
	C1SXwy4eteAp7gLmcysr6IsfRlhfO1aWQBiC28E8JFoPCr0VBadGtA0j++nTxpRyQH3iBar8qzt
	pxnCyRnLqWlJ3j4UTm2Nf8asWIY1slWzWQNp50fHOK0QW4UhONVe/EdWBwYgT1auKmO4=
X-Gm-Gg: AY/fxX6TiSIHv9wXjDDoX3PUyijklNhC78YeiOL4AmRodfCVoWJgFjjD3ZZsKB23lx0
	dxoINQREFGJjE+R1hHhnjlWANSqQv/hWqWD/oEngMREwOb6Ux28ZCER25t4MzqkfrGA4S2Hpy3Y
	4ea0WNJKGxq1IQ15GhiK9FI8t7V1qwrgDAsIX70ZjShIefAkI+q6JRA90rMHdPUZTlqzCfGCWAS
	+XZJt5zqICTH/y9d/SgtxOJ/2w6C5HjRwUdAUYICFxkN1k+HgBUS15SbgUYyVSr4yie+QuV7ExX
	zAMHNiu7ziPva9VmBpl/1D1qFQU0P9vtIq4r04IJAPkq3nZkKaezNHMpfGkYwl0YbBJupMTuVEr
	PWKCxR9MKbP8GGaFZ/KBBuQvv6nqJX3jNEIv2J/hPH7LG
X-Received: by 2002:a05:6122:546:b0:55b:305b:4e46 with SMTP id 71dfb90a1353d-563a0a2ea9bmr192512e0c.18.1768335817348;
        Tue, 13 Jan 2026 12:23:37 -0800 (PST)
X-Received: by 2002:a05:6122:546:b0:55b:305b:4e46 with SMTP id 71dfb90a1353d-563a0a2ea9bmr192499e0c.18.1768335816996;
        Tue, 13 Jan 2026 12:23:36 -0800 (PST)
Received: from redhat.com (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5636f19be3csm12170952e0c.4.2026.01.13.12.23.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 12:23:36 -0800 (PST)
Date: Tue, 13 Jan 2026 15:23:19 -0500
From: Brian Masney <bmasney@redhat.com>
To: david.laight.linux@gmail.com
Cc: Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Miklos Szeredi <miklos@szeredi.hu>, Mark Brown <broonie@kernel.org>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Kees Cook <kees@kernel.org>,
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH next] fuse: Fix 'min: signedness error' in fuse_wr_pages()
Message-ID: <aWapt9vh8EEGdFUG@redhat.com>
References: <20260113192243.73983-1-david.laight.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260113192243.73983-1-david.laight.linux@gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)

On Tue, Jan 13, 2026 at 07:22:43PM +0000, david.laight.linux@gmail.com wrote:
> From: David Laight <david.laight.linux@gmail.com>
> 
> On 32bit systems 'pos' is s64 and everything else is 32bit so the
> first argument to min() is signed - generating a warning.
> On 64bit systems 'len' is 64bit unsigned forcing everything to unsigned.
> 
> Fix by reworking the exprssion to completely avoid 64bit maths on 32bit.
> Use DIV_ROUND_UP() instead of open-coding something equivalent.
> 
> Note that the 32bit 'len' cannot overflow because the syscall interface
> limits read/write (etc) to (INT_MAX - PAGE_SIZE) bytes (even on 64bit).
> 
> Fixes: 0f5bb0cfb0b4 ("fs: use min() or umin() instead of min_t()")
> Signed-off-by: David Laight <david.laight.linux@gmail.com>

Reported-by: Brian Masney <bmasney@redhat.com>
Reviewed-by: Brian Masney <bmasney@redhat.com>

This fixes the MIPS cross compiler error on arm64 that I reported. I
also tested a native arm64 build.

Brian


