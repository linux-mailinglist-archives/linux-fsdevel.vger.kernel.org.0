Return-Path: <linux-fsdevel+bounces-20148-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7832A8CEDFF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 May 2024 07:50:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D63F4282088
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 May 2024 05:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98B83D29B;
	Sat, 25 May 2024 05:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="U+5NR9Jw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0BED138E;
	Sat, 25 May 2024 05:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716616203; cv=none; b=VYAC+d37bcNHyYpI/96WQ4WvOYXLnaCnR5W+rD6nxFzUu+7mCQNH5FeoNVlyMhUmQD0vIvPBYmgrD+EFkKRK2SMWT0l0yfMd0y8/8myaDO4KQ/vYYrtvZC/GBqLF+2H19Af4/BSSwC0KoSM7+ldDueWPKDY+x6fcN879xQAa4l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716616203; c=relaxed/simple;
	bh=VSJIf4tmyz34+ryR8Cz9iQWIiMNUye0lMZyO2dQZvMY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Iq/NeGipyNNescnUHF96TzVwbHHuDzKorDCI4JgSm5xRqdTy8jSRIOWwfxmUmxj2oFnMk8Fi1l1Rgm3ieUaRGtWjlrHmbcvVmJv/FKkBfqSqc2QOOmvvPEmcYOoK0A64MomY7rS4HmdfQcGzT/osjLEK4/GK7FVLsduLiO7Ef/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=U+5NR9Jw; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=NjAIpWnGAztCMT7g7qkBL9r84roWJZLVxyIj65a/6/g=; b=U+5NR9JwCWW91cWlPKNvy1chd+
	u0P/4HzM54MNe7A5vcQkxEZIlUb+dWfmrzRfJBHK7ADk3m/B4A/g3f6qMV8dGnYxd3wwq55EjRizS
	5Y+EPpe2PN/GQIounZZSCkN/jGS6Yr1LjDieV11c/QyKfnzCgNVtzXRhlxBp8T0GznxoyiwSXM5HF
	6eUbbl0Gwi3JXDOqrdPy99p+rR/7mwSWbXPya1yElAbc1ZkSoTLh0mVeGr+5zhHJ6OFisoRLbNN5A
	Xx4xVSxUaf6oksx+MpjfGzzO9xL5YETFCy1jlTvVuQ0v3XAO+xr7UnoGj7Fa2estAJlHRGJ7LJepO
	6Qz1N4sw==;
Received: from [50.53.4.147] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sAkI1-0000000ASst-1eDf;
	Sat, 25 May 2024 05:49:57 +0000
Message-ID: <9ce0c222-c80c-4049-8746-d74e612c3030@infradead.org>
Date: Fri, 24 May 2024 22:49:54 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] proc: restrict /proc/pid/mem
To: Adrian Ratiu <adrian.ratiu@collabora.com>, linux-fsdevel@vger.kernel.org
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, linux-doc@vger.kernel.org,
 kernel@collabora.com, gbiv@google.com, ryanbeltran@google.com,
 inglorion@google.com, ajordanr@google.com, jorgelo@chromium.org,
 Guenter Roeck <groeck@chromium.org>, Doug Anderson <dianders@chromium.org>,
 Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Christian Brauner <brauner@kernel.org>, Mike Frysinger <vapier@chromium.org>
References: <20240524192858.3206-1-adrian.ratiu@collabora.com>
 <20240524192858.3206-2-adrian.ratiu@collabora.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240524192858.3206-2-adrian.ratiu@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi--

On 5/24/24 12:28 PM, Adrian Ratiu wrote:
> diff --git a/security/Kconfig b/security/Kconfig
> index 412e76f1575d..0cd73f848b5a 100644
> --- a/security/Kconfig
> +++ b/security/Kconfig
> @@ -183,6 +183,74 @@ config STATIC_USERMODEHELPER_PATH
>  	  If you wish for all usermode helper programs to be disabled,
>  	  specify an empty string here (i.e. "").
>  
> +menu "Procfs mem restriction options"
> +
> +config PROC_MEM_RESTRICT_FOLL_FORCE_DEFAULT
> +	bool "Restrict all FOLL_FORCE flag usage"
> +	default n
> +	help
> +	  Restrict all FOLL_FORCE usage during /proc/*/mem RW.
> +	  Debuggerg like GDB require using FOLL_FORCE for basic

	  Debuggers

> +	  functionality.
> +
> +config PROC_MEM_RESTRICT_FOLL_FORCE_PTRACE_DEFAULT
> +	bool "Restrict FOLL_FORCE usage except for ptracers"
> +	default n
> +	help
> +	  Restrict FOLL_FORCE usage during /proc/*/mem RW, except
> +	  for ptracer processes. Debuggerg like GDB require using

	                         Debuggers

> +	  FOLL_FORCE for basic functionality.
> +
> +config PROC_MEM_RESTRICT_OPEN_READ_DEFAULT
> +	bool "Restrict all open() read access"
> +	default n
> +	help
> +	  Restrict all open() read access to /proc/*/mem files.
> +	  Use with caution: this can break init systems, debuggers,
> +	  container supervisors and other tasks using /proc/*/mem.
> +
> +config PROC_MEM_RESTRICT_OPEN_READ_PTRACE_DEFAULT
> +	bool "Restrict open() for reads except for ptracers"
> +	default n
> +	help
> +	  Restrict open() read access except for ptracer processes.
> +	  Use with caution: this can break init systems, debuggers,
> +	  container supervisors and other non-ptrace capable tasks
> +	  using /proc/*/mem.
> +
> +config PROC_MEM_RESTRICT_OPEN_WRITE_DEFAULT
> +	bool "Restrict all open() write access"
> +	default n
> +	help
> +	  Restrict all open() write access to /proc/*/mem files.
> +	  Debuggers like GDB and some container supervisors tasks
> +	  require opening as RW and may break.
> +
> +config PROC_MEM_RESTRICT_OPEN_WRITE_PTRACE_DEFAULT
> +	bool "Restrict open() for writes except for ptracers"
> +	default n
> +	help
> +	  Restrict open() write access except for ptracer processes,
> +	  usually debuggers.
> +
> +config PROC_MEM_RESTRICT_WRITE_DEFAULT
> +	bool "Restrict all write() calls"
> +	default n
> +	help
> +	  Restrict all /proc/*/mem direct write calls.
> +	  Open calls with RW modes are still allowed, this blocks
> +	  just the write() calls.
> +
> +config PROC_MEM_RESTRICT_WRITE_PTRACE_DEFAULT
> +	bool "Restrict write() calls except for ptracers"
> +	default n
> +	help
> +	  Restrict /proc/*/mem direct write calls except for ptracer processes.
> +	  Open calls with RW modes are still allowed, this blocks just
> +	  the write() calls.
> +
> +endmenu

-- 
#Randy
https://people.kernel.org/tglx/notes-about-netiquette
https://subspace.kernel.org/etiquette.html

