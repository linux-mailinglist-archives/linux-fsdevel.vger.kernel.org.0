Return-Path: <linux-fsdevel+bounces-11251-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C956852238
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 00:02:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 489DE282700
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 23:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B81251004;
	Mon, 12 Feb 2024 23:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YNoHMl8H"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B009851011
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Feb 2024 23:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707778884; cv=none; b=TtnQ9NTKxm2rK9Qw+8c9+21zaoYpGHN/M/4W2vvaE3hp5f3BGw4a1s+YRgHcZdiijfmmGoXUIgPgGKx2SRtEBLJbTPgsQC86NYawGXj1cowBybyIff3wS4hLGjU1Le0rCh/AUMfnMZ1Jfwt/wEuJp8NVKQOTpLq8soanXLHY6/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707778884; c=relaxed/simple;
	bh=tTpbh5UfZfyy28Rs/Cv2qtnww4MwOrI6Z7e146A9LpI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h4aMGl2Kdhpi5/5OPoNcIDoKIU+4DbsIM9yP1y7UWp+00Y+GyaoUCtoHR2TNXlKfBKF4pmAu/kXkIC3Q26B4XTwYX/tGjwHdRdClWgFLBy26DPSEqTQcNsWrBX9fcyATKau06WWH01Zv50SO2XNiE2HQi/5G21zMWZ+HI2IXmKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=YNoHMl8H; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6e0dcf0a936so694283b3a.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Feb 2024 15:01:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707778881; x=1708383681; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FzsjrPnusIaHUIYYiKKdbD1PNR9YsTLIdgA5piLTr48=;
        b=YNoHMl8HoMvf8bHoQ14GAwd8t1a5Tz1VLxpRPT9+25A8wfNg6DQhOHiIXVsgyL/7ph
         kjH+DoMMK4X+8kyCZW60fFI6ixvJZH8IRakeT0/mlh3TVkwU8oJze10u/z6Q/M4cXq8X
         +bXouy3+5739nJ7PwDQieSRut2Qe8ERkrzO0o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707778881; x=1708383681;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FzsjrPnusIaHUIYYiKKdbD1PNR9YsTLIdgA5piLTr48=;
        b=YHXS88/ErcgkMDlCWjWJ9NXz5FRFgJptwdm4he4G1ZaCbnEtabUdGWRC+MQyXzUApC
         xExlKrkaQXJnRTorsIPb47DJDAsPIGgueTb82Z1uSvB+qXt2153xsM3UhswuVXZHhVOc
         qeGFPXGWkWDW2qpkDiU7m/d0mTg1NuTq/XSPrqih21bG8vPEOKr9/vobTJBNDdKM70sF
         ihgYzQaqwHXLaSdriWER7E3c5WVFjRqP8GlMzNQScsWoZBQWmVRwO1jJqqLn1EgwnGfw
         AJJVfomGFah/d7hf3PFj0eX/LNhDQC1rugiOgnP50eVNkdVmciCq4QXUu9u8a2hKpp1D
         ypAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVdb+IzoRka5Up+uOCDDnspGNoU1rnpKzRYYetXJliM/6R9Mpu91u7jgZ2+y9tatKH4IbiDXaxzjWqxPLWBiB7L8VfdiZR5xMT77r5aQ==
X-Gm-Message-State: AOJu0Yz7EYpDMY+TOB/5KxnBArK02E3E31p4Xm1lvLkli7I+pXZRVgxm
	8ICNl+8XmLHJtLx977sajY4cCKcYT9fJmanQzNwzEOtdhc7rmYt+gYOdrha3iw==
X-Google-Smtp-Source: AGHT+IHKYkrvWP6pn+Z0bv1j498bkNcTGlpfF62jfvH5sqEIpqwicwiMKjizBBkpoFi7tjdt3fDdpQ==
X-Received: by 2002:a05:6a00:194c:b0:6e0:6aaf:5e57 with SMTP id s12-20020a056a00194c00b006e06aaf5e57mr1150993pfk.8.1707778881054;
        Mon, 12 Feb 2024 15:01:21 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVqPDglaouwlesQHnb43T4Isv16NQxb4dXSRTJuJSE5aNgdLn5NkEJGctOyntILaXZQS0mnDZpLVHN+/xwOB9IoAgg9x0u29PK/IhT7vjo91yIRFcPvoSMBYBFTzt+86JDN1jgMokFHBEXgSllBDYGACxIo0zUFX17bzZBEU7NwjPK5esvpkzsm8ibJaJyYxi2UJsA8zbTPNgaMTjZhnLBqFB+AILhOnQMu3xiK9ZU4f7GtCTbRmKaQQgFh0z0TRcxbJff4bi+eT3yTtwdcnSLjIvBdWA0x+ELkk+GqvBo+wxUIMd3R/SyxCqpTCriDuDr9DirngV3+ShKRVfu2nluGcwRSZfrhSjApbK/fCGIR4/LdLALZhVz/s56pny6O3gcmucfFvYV4odX4ckaTFciS8AJBREeUfEUPAnq8fWaB96nB3adrPIkjaAnXVxmnTdxL5X6oM/t8wis1hvXbcOnobKCN9fFEDPgjNVeA+QNqNhdzD3YRnTrs3sRnZeZs0tuUf0LW4+UtqwmVIsYxmql8pL7fOpAREfPaCHgqX0NFpVieKkvY0fMMnu3nRh0xKbfllsY9sjEzjpCwyZQCJ/CKBP9jT9n6AKjiVTNe50JwZj4ZeSvaC/a6uMZ0lhgP0nfkvvI7EFxu+TtZRjrzuIHn6E+fxmBlhHOCFV79XFx8fJc/wu0AHsf2VzlWSUIzFXGqPnNMDjAzpTzvx/l9cNLUx4eRQl6ExPiTPL5iDDwJCxAOJ7ppGA==
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id r19-20020aa78b93000000b006da19433468sm6077507pfd.61.2024.02.12.15.01.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 15:01:20 -0800 (PST)
Date: Mon, 12 Feb 2024 15:01:19 -0800
From: Kees Cook <keescook@chromium.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, mhocko@suse.com,
	vbabka@suse.cz, hannes@cmpxchg.org, roman.gushchin@linux.dev,
	mgorman@suse.de, dave@stgolabs.net, willy@infradead.org,
	liam.howlett@oracle.com, corbet@lwn.net, void@manifault.com,
	peterz@infradead.org, juri.lelli@redhat.com,
	catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de,
	tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
	x86@kernel.org, peterx@redhat.com, david@redhat.com,
	axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org,
	nathan@kernel.org, dennis@kernel.org, tj@kernel.org,
	muchun.song@linux.dev, rppt@kernel.org, paulmck@kernel.org,
	pasha.tatashin@soleen.com, yosryahmed@google.com, yuzhao@google.com,
	dhowells@redhat.com, hughd@google.com, andreyknvl@gmail.com,
	ndesaulniers@google.com, vvvvvv@google.com,
	gregkh@linuxfoundation.org, ebiggers@google.com, ytcoode@gmail.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com,
	vschneid@redhat.com, cl@linux.com, penberg@kernel.org,
	iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, glider@google.com,
	elver@google.com, dvyukov@google.com, shakeelb@google.com,
	songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com,
	minchan@google.com, kaleshsingh@google.com, kernel-team@android.com,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, linux-arch@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com,
	cgroups@vger.kernel.org
Subject: Re: [PATCH v3 22/35] mm/slab: enable slab allocation tagging for
 kmalloc and friends
Message-ID: <202402121500.68DFA4A32D@keescook>
References: <20240212213922.783301-1-surenb@google.com>
 <20240212213922.783301-23-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240212213922.783301-23-surenb@google.com>

On Mon, Feb 12, 2024 at 01:39:08PM -0800, Suren Baghdasaryan wrote:
> Redefine kmalloc, krealloc, kzalloc, kcalloc, etc. to record allocations
> and deallocations done by these functions.
> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> Co-developed-by: Kent Overstreet <kent.overstreet@linux.dev>
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>

I'm not a big fan of the _noprof suffix, but anything else I can think
of isn't as descriptive, so:

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

