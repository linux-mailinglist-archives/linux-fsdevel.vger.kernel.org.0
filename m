Return-Path: <linux-fsdevel+bounces-34276-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B54309C44B6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 19:15:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BDA0B2B5D4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 18:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B0651AAE1B;
	Mon, 11 Nov 2024 18:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20230601.gappssmtp.com header.i=@osandov-com.20230601.gappssmtp.com header.b="1EabeQik"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA191A9B2C
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2024 18:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731348523; cv=none; b=Spm4jfenu7dwuWJon/KI41r47lus/PNRZHam2JacIjmxb4EcKf00esVOIVDX3RLMXiKTD+YPhYXKt2lZUqtDMMDk8q0XH0yQbsab9ef9qdkxBDH10NVJgnpABpL5c+qqnwvTJ+/3qcIvwF1/47Z2JxihM2/VmgmCqPkS0Xc3fd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731348523; c=relaxed/simple;
	bh=7r78WBjtJG+lstyITe5Wl3M9woNyZBPqN7y8qQ3UJTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q1cTcnk5psvOPB5M5ILbBMulprFDQp427vETkHcfWz+RzzO+vF6W9Hw2XLQ3IayGCVcYFZFPpdxkfgc/M1wJnAnMmaG0tGJRUkxqvtQ5HZTEqTfJBKoArd0ZrcW5/ESMu9P+TyURXOGUgynsTh71ldYbzv2q5j7ATPQbTB86dh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com; spf=none smtp.mailfrom=osandov.com; dkim=pass (2048-bit key) header.d=osandov-com.20230601.gappssmtp.com header.i=@osandov-com.20230601.gappssmtp.com header.b=1EabeQik; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=osandov.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7ea6cbc90b7so192276a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2024 10:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20230601.gappssmtp.com; s=20230601; t=1731348521; x=1731953321; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QOmy7ijgjFLLlMuZ8IKU0I/D+R7VNI4abiMd6iGq1Sw=;
        b=1EabeQikQ6z5tFmySRM6Gpq81ZaC4q1sMhMtuMSuy0oPxBiWkr5IxVYFKzVQ0kHF4Q
         6TPLLGQTt5UXc1c+P8/jBfYpprR925qK7ilJ611+xcFeNop/OHlBkGwNUYLmKgIKw+7A
         wtiKxsktvfbH4Pr0nowsrNWDEbOyptqIeIi9s4+715ewv5+xvEoMKOcd9L/cp1AviXF3
         Bgpbsc9+vEFNzZU2hMnvznRYJ5KiuH7neF737b3hJBRUYAKM2+u6KOwEh6s7ZkUR7oiq
         0FnQD8YbEfQnqiQA6ZUGs8lJmicDeGfZm5mJBJhr9mfwq4wdqdX7zYIGMWAw1LJQT1vK
         nYig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731348521; x=1731953321;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QOmy7ijgjFLLlMuZ8IKU0I/D+R7VNI4abiMd6iGq1Sw=;
        b=cOR8vhTxGEE8sA+64tPxEFbGVuEXNTFQ2bvuhz56a6o7qzP+KHHX76BMfPkk+DQXP6
         lULxr5zI5JKgoBp2/wIZzhg2k0yjiQ0hSrHVfhpz8UouSusgVI5R6mNwRCBAZoYixyuh
         R8LfhQppvuxA48HfRuIXwmWtSraKEJ72oyZg+lujl2HWJdZzcGNSSZKxsudtwMwiaIbb
         kSF1tVQI8kgEw/1J5TWuap9+hu6McnM8ujHt/g+Ic1EOivoFXTC+fFeSI+1jiMkOjbt/
         9xtkNTKkYlVmOtH1DzgYqhhL21sgr4+s+FhRE4usj7d0v/sCyPtnUVotv1Sms7vOPWFx
         aleA==
X-Forwarded-Encrypted: i=1; AJvYcCUF2tDzVsqpz1zk5ygBjYHBJS5K6I2Q7mGVzgcapjAkqnhwbkl3bw6ASMkLuHMznBi/kvhA9q2NKf7yJGDH@vger.kernel.org
X-Gm-Message-State: AOJu0YwktRukfuLE7D232ExP796jV4G/7yDJEVrmXWwaRC4GH7LT2TSg
	PKNsKrHwi9/2Pd0zn75AFVQsOCNq0Y//mgEJcUaAWiBUR2epVLEIaZ0TVy1UJ1M=
X-Google-Smtp-Source: AGHT+IGPE2ZKsQeru0sZQhpul+kuXrvcms0uqLpRKvd07nytD1t72XT94XLjmkSYsRpWJq6hcWAeBw==
X-Received: by 2002:a17:90b:3a82:b0:2e9:5e1d:3375 with SMTP id 98e67ed59e1d1-2e9b1655972mr7528248a91.5.1731348521593;
        Mon, 11 Nov 2024 10:08:41 -0800 (PST)
Received: from telecaster ([2620:10d:c090:500::6:29c6])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e9a5f90cf1sm8802851a91.30.2024.11.11.10.08.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 10:08:40 -0800 (PST)
Date: Mon, 11 Nov 2024 10:08:39 -0800
From: Omar Sandoval <osandov@osandov.com>
To: Christian Brauner <brauner@kernel.org>
Cc: kernel-team@fb.com, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 0/4] proc/kcore: performance optimizations
Message-ID: <ZzJIJ4QFNj_KPPHK@telecaster>
References: <cover.1731115587.git.osandov@fb.com>
 <20241111-umgebaut-freifahrt-cb0882051b88@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241111-umgebaut-freifahrt-cb0882051b88@brauner>

On Mon, Nov 11, 2024 at 10:00:54AM +0100, Christian Brauner wrote:
> On Fri, 08 Nov 2024 17:28:38 -0800, Omar Sandoval wrote:
> > From: Omar Sandoval <osandov@fb.com>
> > 
> > Hi,
> > 
> > The performance of /proc/kcore reads has been showing up as a bottleneck
> > for drgn. drgn scripts often spend ~25% of their time in the kernel
> > reading from /proc/kcore.
> > 
> > [...]
> 
> A bit too late for v6.13, I think but certainly something we can look at
> for v6.14. And great that your stepping up to maintain it!

Thanks, v6.14 is totally fine!

I have a quick question on logistics. /proc/kcore typically only gets a
handful of patches per cycle, if any, so should we add fsdevel to the
MAINTAINERS entry so I can ask you to queue up patches in the vfs tree
once I've reviewed them? Or should I send pull requests somewhere?

Thanks,
Omar

