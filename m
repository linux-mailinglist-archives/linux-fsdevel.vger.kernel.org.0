Return-Path: <linux-fsdevel+bounces-73916-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 02620D24692
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 13:14:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4E1F13013306
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 12:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81485395D85;
	Thu, 15 Jan 2026 12:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="QC/gWSUS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190AF393DE3
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jan 2026 12:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768479285; cv=none; b=a1FpuqdRJGvHOkWHtzyx8JuwxR7bURZMqxXHtj3Q5anXZC49MnSCyvDKjvveAPb6w4zZo5s9+xxuladft08KoLQuwhLGp2wW/4S2WE7lf9NXRkOB1FdmuYscRQQGCKf+POAzitmiBBmsOh+ha3gfxpQJL1yfP3xp/qS38Sf3GMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768479285; c=relaxed/simple;
	bh=BMtROxTlhcEjGTvjLejFDk2Vbg7ExK2i/Mb0lDmT8j4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aJ6yYiIlLD4Oq/JMuDsZqB9qjUdln3WbVlO6Kl88P9DzIxHj5cEQsUW36KaQFnJuzFhcolZxMaf6UcIc8ebjz6sK7JciprWp8i1N8NvtFal5RoiLU0CtfHdgrCFXjVcEg86IqSIg0Ljf18pbVdb/lNynrnT4/G2ke5yqaIMnr/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=QC/gWSUS; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-42fbc305552so712297f8f.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jan 2026 04:14:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768479281; x=1769084081; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zx4s5ogULMWiwAg3H50k8gmoVyZOh2DwfMGC+/dY5Co=;
        b=QC/gWSUSA0EAhwaYo46xYVQT8Y1ECjcpRFmmp8NFZI6gFeOCyv54QFoONL0zhD1tRb
         Wpjcalm58F07U7X6X3ElfdI2aMbZTcQHAaMqiDAUqfii1xPgbxHV2Rr+MHF/YquIzq19
         ugRBOmWQG091YmUU32AncGeAZWhNkTR6Mp48MmebVJnSiapVRAPhk0nmw029/JzlyLO2
         3wo7/niLOkIcJq11YHaoiZlxyk5NmQWmEdSgBJiPdg0jON0WU/DvEZu8cMJLNsZBeVtR
         QXw0tRC6Us8sGCxg174oOAPWPaE8M/fVUYQLmZ6JJA8mAowmTwqll4CNctmANwjapfcO
         OyuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768479281; x=1769084081;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zx4s5ogULMWiwAg3H50k8gmoVyZOh2DwfMGC+/dY5Co=;
        b=giKL3PzxZkc9q0ZLAlKJIxfpyLoAIBnb0G8rbetQgI2dEqr1j7MQOstuYC/VV9KHXp
         K8E/Cs/XeVAuxWnJwKw2Rb9VQLKeJhU/TXTkdlYnNobL4b8/scMWaoCBlkBwWjam/lkZ
         gcfdBikE4/kKlfRhbekQc8dM9W1owCJSTncFyVzhRzeNZIsqHZVGVIqK+dR/dJeYzj+y
         3IKtBGQbWO+8gm5hCUNqZYQmE94/kLu8IQMmD7A9myklxQtefcZgR5e+PA502jgUOKML
         uCnJM6ZR6GSXaB7YBvZ29sMM77qI42r6xgyaXFkpwe/2yRPewEkGrjN+tguFaDTNB8Ch
         SGCw==
X-Forwarded-Encrypted: i=1; AJvYcCU/G30N/GgLJcV/3z350Zzao/pbemEvF5T4fHXo1hVbPn4ZZ34L+Ni2MLajcQVr19Pv7ugRH8ey9P76Km0n@vger.kernel.org
X-Gm-Message-State: AOJu0YxI+zNXt+3y91JXn8xdnUKLzzHxN7hbR9T2VfHPg6KjsxRRCZCV
	uY9KTFRo9G4lmCAPgh0XhAYxGA8GR/k4Ht0IKtdrEI126cgpJgjCUhAkpclfyCu8bZo=
X-Gm-Gg: AY/fxX4AVbRgcAruw4gm09R7ffkSfT8UPbsKnARRRssghecz+Y5RGRV74/gkUmfymVr
	gkSEvpQy8YtvVXQUtyKAziCzQR5MsiUqpZJWHSmn0hVOJhoj6oNThi4xjEuPCsue1KDnzyvQI3c
	OGo39e8QgE/jh7U6kSDQKEzh83lEI7hu2xNig/o4X13PmJXKgBsepW6wKeUr3N4O7pqg+tOndlh
	xrm4VNb7OVptbsLS6suKtasnwBbsTuPRuaYlCItVgzgKYoohfJmGpQJSaMYzRU7JZrk33RaCcy0
	h3rd/zfZELES0CNpcNHMLw1dOD9TgG/KGOIEU5Z4V4Ev4utPRqsiMz9VaRTHq+lHOFb+/HlAnm8
	cz3gXMy32F627FD7G5DNs5UIEwmXSqnPH489e80DL/wDkytO80S4W5CqGfhgj5MOkaaX03RT2g/
	9E+VmKBYrpLcpHGw==
X-Received: by 2002:a05:6000:3101:b0:431:abb:942f with SMTP id ffacd0b85a97d-4342c557b93mr7715812f8f.54.1768479281353;
        Thu, 15 Jan 2026 04:14:41 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-434af64a778sm5591185f8f.3.2026.01.15.04.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 04:14:40 -0800 (PST)
Date: Thu, 15 Jan 2026 13:14:38 +0100
From: Petr Mladek <pmladek@suse.com>
To: Marcos Paulo de Souza <mpdesouza@suse.com>
Cc: Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jason Wessel <jason.wessel@windriver.com>,
	Daniel Thompson <danielt@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jiri Slaby <jirislaby@kernel.org>, Breno Leitao <leitao@debian.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Andreas Larsson <andreas@gaisler.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jacky Huang <ychuang3@nuvoton.com>,
	Shan-Chun Hung <schung@nuvoton.com>, linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net,
	linux-serial@vger.kernel.org, netdev@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org, linux-hardening@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 12/19] sparc: kernel: btext: Migrate to
 register_console_force helper
Message-ID: <aWjaLhzRoTLalIrM@pathway.suse.cz>
References: <20251227-printk-cleanup-part3-v1-0-21a291bcf197@suse.com>
 <20251227-printk-cleanup-part3-v1-12-21a291bcf197@suse.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251227-printk-cleanup-part3-v1-12-21a291bcf197@suse.com>

On Sat 2025-12-27 09:16:19, Marcos Paulo de Souza wrote:
> The register_console_force function was introduced to register consoles
> even on the presence of default consoles, replacing the CON_ENABLE flag
> that was forcing the same behavior.
> 
> No functional changes.
> 
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>

LGTM, nice cleanup!

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

