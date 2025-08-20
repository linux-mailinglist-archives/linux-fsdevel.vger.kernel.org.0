Return-Path: <linux-fsdevel+bounces-58372-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 037D1B2D937
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Aug 2025 11:52:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7D8B1C48348
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Aug 2025 09:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F73D2E3AE3;
	Wed, 20 Aug 2025 09:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="jSGj1ahj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EECF52E3713
	for <linux-fsdevel@vger.kernel.org>; Wed, 20 Aug 2025 09:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755682865; cv=none; b=fS3+tIUM8wSVUSP50znKVlQpAgh27YpmJnuzysuL9hIxvxkwyw0AKpWUYYV+3qi8HvK8mI4my4r2+XyY4nI5cxIkjQtBZkCPWJp7Upjps9/29yBlUZLfSJ5DafVvuJD39DPl4lUz/4S7LcpgyLGz7Fq51wAhiRz9rocnJK0KiCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755682865; c=relaxed/simple;
	bh=6wqUwsH8WzM+3ALt2g9Eaqthf4maZrIXS2rpbAZW8fE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uCUAc64pJEiPKBEbquCe3Csqz5yjRfBxQxOzxw9zjicv+pydtmjSEhunVH3MJjAqidvGcS53+YDhSogpv8XYUBmb1k3aLg9y0NY0GE8xSjZxwekMkPwHX5yrL87cQUCZ3SxIv6mzj7tNShkDbVQAY6whmN3bmNuSOx4E9Gsdt3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=jSGj1ahj; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4b134aa13f5so40297121cf.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Aug 2025 02:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1755682862; x=1756287662; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6wqUwsH8WzM+3ALt2g9Eaqthf4maZrIXS2rpbAZW8fE=;
        b=jSGj1ahjX1hW3YQDzObf7fVgf09L9taWsYACuFJW+K/C3E4FvjBYvFDXvr2JchVM93
         rb6yZdGWknrP86kazUSQDi2wW0hYPBuMjR4Bf1kms4abvJAwsjwmo0D+vWQyHI/ECk6D
         tfafpZ53U3G9e+t9qveWn9MGO1Pnr37uZ0dgU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755682862; x=1756287662;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6wqUwsH8WzM+3ALt2g9Eaqthf4maZrIXS2rpbAZW8fE=;
        b=u5/zODO3uAQQWY6vv5G9ExqKvkIXbKpvCBk2rq2ehZZA0ohTM7NaTKK6p5uyZG74TT
         GJhuU28pJ3nAM/IVt1YixSfqv6mBJDCtmuw2JrV9pE4PPw9AK+daPy++z8yC0izDSozd
         2h8uJibLNpsKF3GolnhgeRjDA2Nz92c5fcSMfhWQi8Mk6L+poTkKqETX6JxEYJv3vYjK
         sk/0HK/iXGP4OTpWa3aNPk6xy9pR0nD8BEEv3PDcYeLZX2+UCU7aqsspF1kcH7Mc6s3Y
         DDdnHIVSVeeGmB1y7qf2x5WCoED8hwkXvvWHQfkgJ1SRwQs8+2/hzrp27RHDNBtch1a5
         6L4Q==
X-Gm-Message-State: AOJu0YzBMGcv9YmTXNonHRLhNMAkBXdOtTnGESxJ8oB8FaRUWSQgJ6cG
	naxJMcP2JEoNmbUQjvO90CBkx9s0mcDB0tf5jUOClbSUtI+P4rtY/69YbjXGh4WIBD+POo6Aj+f
	ZLiOZ9c2t++ZdL2/jRSGWky5bYsTKNCJve3w1aLLjrg==
X-Gm-Gg: ASbGnctRfVtsTq4gGBP/ZobcE+WRPHAE5SVnlhvvKLxPnl8AIulPQyqb1J3FHBuCp8p
	3ZYNrOMcAoxdd/7fG7YY2GcreDv4Hf2q7gko7M3THg0UHm0tmMxSzCKug5cyhfSLc71hBJ5v9U5
	kosyH9d+mn6O3J8sIocyysP6smMECFSO98cw/2Oz61Oo3xtzAmzGO2uPPCPwnFuZ+2+dlQkgJpN
	a2aDFyggA==
X-Google-Smtp-Source: AGHT+IFe5PYxr6z8JeerhWQOZqxR9975GI9X5HUWBjAueFNTiRkzfKZ+rCuFl+eHlpTLUnEOF2z9+9bGiL6EUxu1WqA=
X-Received: by 2002:a05:622a:1456:b0:4b0:701c:9435 with SMTP id
 d75a77b69052e-4b291be7279mr23846641cf.60.1755682861891; Wed, 20 Aug 2025
 02:41:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <175279449418.710975.17923641852675480305.stgit@frogsfrogsfrogs>
 <175279449542.710975.4026114067817403606.stgit@frogsfrogsfrogs>
 <CAJfpegvwGw_y1rXZtmMf_8xJ9S6D7OUeN7YK-RU5mSaOtMciqA@mail.gmail.com>
 <20250818200155.GA7942@frogsfrogsfrogs> <CAJfpegtC4Ry0FeZb_13DJuTWWezFuqR=B8s=Y7GogLLj-=k4Sg@mail.gmail.com>
 <20250819225127.GI7981@frogsfrogsfrogs> <CAJfpegt38osEYbDYUP64+qY5j_y9EZBeYFixHgc=TDn=2n7D4w@mail.gmail.com>
In-Reply-To: <CAJfpegt38osEYbDYUP64+qY5j_y9EZBeYFixHgc=TDn=2n7D4w@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 20 Aug 2025 11:40:50 +0200
X-Gm-Features: Ac12FXxukz_JmdqODUdFh4uN6WVp_RjEftxDofCVybJA4SYAQelAJHdNeChxXhY
Message-ID: <CAJfpegv4RJqpFC0K5SVi6vhTMGpxrd672qbPE4zbe0nO-=2SqQ@mail.gmail.com>
Subject: Re: [PATCH 4/7] fuse: implement file attributes mask for statx
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, neal@gompa.dev, John@groves.net, 
	bernd@bsbernd.com, joannelkoong@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 20 Aug 2025 at 11:16, Miklos Szeredi <miklos@szeredi.hu> wrote:

> As an optimization of the above, the filesystem clearing the
> request_mask for these uncached attributes means that that attribute
> is not supported by the filesystem and that *can* be cheaply cached
> (e.g. clearing fi->inval_mask).

Even better: add sx_supported to fuse_init_out, so that unsupported
ones don't generate unnecessary requests.

Thanks,
Miklos

