Return-Path: <linux-fsdevel+bounces-21556-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC1DF905AC6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2024 20:24:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7844D1F21E01
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2024 18:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86C1D3C467;
	Wed, 12 Jun 2024 18:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="osHdSw87"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45D5391;
	Wed, 12 Jun 2024 18:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718216629; cv=none; b=ntfLsxMakvDag+130bxCOQJ8WsfmMN9LgOhBoKd9TVRBtIT8Gi7YfiapRhoz5iUJ797XPcs7180xTG96Ld557/kv8CUVQPV4ZPB485k3oSLH26QOzwRUHUxZWPZjsPk6AWjh7tID19wpfYKHdnfHSgdtggoOS4hHC+jn8dOQ75c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718216629; c=relaxed/simple;
	bh=Tl9nyuzjb2pxEQcV7FhW1PIM12LMWMgzHS0CNeblVFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MUGol8g4LyqnvP1m+BSnaAVsWF9drJ4n7YSNsKOxioydAc33Z3o6psadCHjjJ6LTRFXqWzd1CBJxaaySrDJxJz4qzeDyG3ng/YSwyR+8JkaxZ/dIDuPvMiwfYFAcCHV1MWyMoDLHrJlOsFhMKjZlYKQHYss79OKxk5K417U44Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=osHdSw87; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89C32C116B1;
	Wed, 12 Jun 2024 18:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718216628;
	bh=Tl9nyuzjb2pxEQcV7FhW1PIM12LMWMgzHS0CNeblVFM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=osHdSw87Cm8MGSp+pdRD0gXU3j/5xUcHgwEiJYwiIjkxQR2qufAumWRxZok/xEj7+
	 ywWkOmSJWsgVK0huS2vcqDdovTWWcg/7weEVtZ0VUXx3+Nbn0pt+Ol8e1y2N/7MFfu
	 HYnRFtcv7pqCOn3ipjnNUjy0uaRriIK2knOlK1PgG2b4bm8tj9W0Fc+3ANQup5pzFI
	 m4z5t5jr2HiyvlsuHy9AxckoeL5PkTRZMFK3jm+Ronn7TW4MAlt/q/5SejBEfFN59S
	 3nho1Upyw2KmhISPvKV2E88Hf3ty/Ly00WMq5t5mHyNIaMKZzo99MTAVaRHpPjw2uX
	 nhMo/E5Qs0f8A==
Date: Wed, 12 Jun 2024 11:23:48 -0700
From: Kees Cook <kees@kernel.org>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	linux-doc@vger.kernel.org, kernel@collabora.com, gbiv@google.com,
	ryanbeltran@google.com, inglorion@google.com, ajordanr@google.com,
	jorgelo@chromium.org, Guenter Roeck <groeck@chromium.org>,
	Doug Anderson <dianders@chromium.org>, Jann Horn <jannh@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Christian Brauner <brauner@kernel.org>, Jeff Xu <jeffxu@google.com>,
	Mike Frysinger <vapier@chromium.org>
Subject: Re: [PATCH v5 2/2] proc: restrict /proc/pid/mem
Message-ID: <202406121123.B0F60E91E@keescook>
References: <20240605164931.3753-1-adrian.ratiu@collabora.com>
 <20240605164931.3753-2-adrian.ratiu@collabora.com>
 <202406060917.8DEE8E3@keescook>
 <3304e0-6669e580-9f9-33d83680@155585222>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3304e0-6669e580-9f9-33d83680@155585222>

On Wed, Jun 12, 2024 at 07:13:41PM +0100, Adrian Ratiu wrote:
> Would macros like the following be acceptable?
> I know it's more verbose but also much easier to understand and it works.
> 
> #if IS_ENABLED(CONFIG_PROC_MEM_RESTRICT_OPEN_READ_ALL)
> DEFINE_STATIC_KEY_TRUE_RO(proc_mem_restrict_open_read_all);
> DEFINE_STATIC_KEY_FALSE_RO(proc_mem_restrict_open_read_ptracer);
> #elif IS_ENABLED(CONFIG_PROC_MEM_RESTRICT_OPEN_READ_PTRACE)
> DEFINE_STATIC_KEY_FALSE_RO(proc_mem_restrict_open_read_all);
> DEFINE_STATIC_KEY_TRUE_RO(proc_mem_restrict_open_read_ptracer);
> #else
> DEFINE_STATIC_KEY_FALSE_RO(proc_mem_restrict_open_read_all);
> DEFINE_STATIC_KEY_FALSE_RO(proc_mem_restrict_open_read_ptracer);
> #endif

Yeah, that'd be fine by me. I was a little concerned I was
over-generalizing those macros. :P

-- 
Kees Cook

