Return-Path: <linux-fsdevel+bounces-19699-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 422B98C8DA7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2024 23:24:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33B7A1C2142F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2024 21:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED1321411DD;
	Fri, 17 May 2024 21:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="V6VNs9MG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E4713DDB8
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 May 2024 21:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715981061; cv=none; b=uRlxJR1ztM5AfiOGm04gwZZr4FyFbqhxAy92Cnf8KoPAy1NwkAMRO24+v/3ElNSc9B5SCZ5hq5WG2wx7sQHD0gRa5R88BD0/VIxyCnI3ZNs85bYZqkloau1ebhNrGXq2CX7b7x0hAaIhMtVD+ZK1oRfpJza2REL+bd1HuAqJaEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715981061; c=relaxed/simple;
	bh=IfJYkc42KzwKWgTt9YCXYbwQ78/cdkAW+9n0nYrQkT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I+tFycqZlaD5ClhBeDdoOKrl2Pq3MFNBT7yV1XRaZ1nrKw3vZcjVkwFCo63oiYv2LNIIBNz8mkJ+GQoSC6MSwxyL9SUoaUWHDuMcAAqVJZv2Nn6PbdHgqo/DkvyAzylIz5t/kYADOSShoj9P3/7mnsT2YKwStQYZAncG0oj8QXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=V6VNs9MG; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1ec486198b6so20546415ad.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 May 2024 14:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715981059; x=1716585859; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nZePBSOIoDFc3SJ8gpxBa7DmK4+hYpUiZT8OtqItIpw=;
        b=V6VNs9MGHBDRDRF5/nhVHVDUsUgKERAAIz3nPJExq336hvd0OSlfcw3STpcM0wO+ys
         TfHDlBFSdArqjPr8ur9ElSFq2KpF5JlnLl74Aike7zMX1etlakJTCklkAcTiQ/BQZbKV
         mKrjqyeBeXKvjPT3dHEM04PCge5ek8bKMxVck=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715981059; x=1716585859;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nZePBSOIoDFc3SJ8gpxBa7DmK4+hYpUiZT8OtqItIpw=;
        b=NX7lLJP21grcNYrSEmsCNSUZll8ThNexM3926UUlw/cTdBGsaUum/dL3EFgENWDFdM
         xOa1h+XB+Fn7jYMH8+J0WSyNv6/lf1yqrDrvtwO0Tp+Q/UMAgaxSUi2sD/qWCaCcWaqj
         /5dTh2r1D0tHCLZ8tykIMdSEuTZXwaOoXsTAklWz37nBb/dbpbvHs8cX1GZBPbEFGAJh
         xRcOrcunaPT10UGSMqXQgeYXDpeKM18eByrDFVLCxOqyAlwWv5HjvKgc1zHiAUhzmw+y
         WXkE0l9Ix8AIe/cAKhQwkjVeQm5BgF481lm3OkU6Ku27sH65FvUlvRgIZIw7oGzko/YH
         7Acg==
X-Forwarded-Encrypted: i=1; AJvYcCWJq6cYvZJ6m07tXMdKImIivyCih5k0F20mV0luUlRcFyoJfBmXCneVCj7BoubzuaAkoPzNyXyYMFd3/2uk1m8VS0FhhIxv6Z+1Ufg0Tw==
X-Gm-Message-State: AOJu0YxfQQMyrfyykd36L4sq9MsLW+PBS985vHv+PESWQddF4EJ6NWi/
	2TnEj1UHizrdLVH+PzH2smH3ObjiRhlcqhYbqF8sQk7XbBQ+oa/U6y9y4F7MVA==
X-Google-Smtp-Source: AGHT+IGp7tPMh78BJ0Avg5PsASLZPSKcpqsBME5h6vFDRUhs+O+wV26Hx+4VAxiIkqft96DMjEQODQ==
X-Received: by 2002:a05:6a00:9290:b0:6f3:e6e0:d9f3 with SMTP id d2e1a72fcca58-6f4e0385654mr24139207b3a.31.1715981059389;
        Fri, 17 May 2024 14:24:19 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2a817cbsm15080510b3a.58.2024.05.17.14.24.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 14:24:18 -0700 (PDT)
Date: Fri, 17 May 2024 14:24:17 -0700
From: Kees Cook <keescook@chromium.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Matthew Wilcox <willy@infradead.org>,
	Justin Stitt <justinstitt@google.com>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Bill Wendling <morbo@google.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3] fs: fix unintentional arithmetic wraparound in offset
 calculation
Message-ID: <202405171417.B290C50A@keescook>
References: <20240517-b4-sio-read_write-v3-1-f180df0a19e6@google.com>
 <ZkavMgtP2IQFGCoQ@casper.infradead.org>
 <20240517012647.GN2118490@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240517012647.GN2118490@ZenIV>

On Fri, May 17, 2024 at 02:26:47AM +0100, Al Viro wrote:
> On Fri, May 17, 2024 at 02:13:22AM +0100, Matthew Wilcox wrote:
> > On Fri, May 17, 2024 at 12:29:06AM +0000, Justin Stitt wrote:
> > > When running syzkaller with the newly reintroduced signed integer
> > > overflow sanitizer we encounter this report:
> > 
> > why do you keep saying it's unintentional?  it's clearly intended.
> 
> Because they are short on actual bugs to be found by their tooling
> and attempt to inflate the sound/noise rate; therefore, every time

"short on bugs"? We're trying to drive it to zero. I would *love* to be
short on bugs. See my reply[1] to Ted.

> when overflow _IS_ handled correctly, it must have been an accident -
> we couldn't have possibly done the analysis correctly.  And if somebody
> insists that they _are_ capable of basic math, they must be dishonest.
> So... "unintentional" it's going to be.

As Justin said, this is a poor choice in wording. In other cases I've
tried to describe this as making changes so that intent is unambiguous
(to both a human and a compiler).

> <southpark> Math is hard, mmkay?  </southpark>
> 
> Al, more than slightly annoyed by that aspect of the entire thing...

I'm sorry about that. None of this is a commentary on code correctness;
we're just trying to refactor things so that the compiler can help us
catch the _unintended_ overflows. This one is _intended_, so here we are
to find a palatable way to leave the behavior unchanged while gaining
compiler coverage.

-Kees

[1] https://lore.kernel.org/linux-hardening/202405171329.019F2F566C@keescook/

-- 
Kees Cook

