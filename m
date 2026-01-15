Return-Path: <linux-fsdevel+bounces-73921-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 79095D2490C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 13:39:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CB52730B65E0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 12:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E99F039E16E;
	Thu, 15 Jan 2026 12:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YWoqPUwR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B9C397AA8
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jan 2026 12:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768480185; cv=none; b=ZIhbfgUFf0YN4EM3WXZrDDxIkPZOCAEbfcY4xVEmn2RyXv00suyWyeag225w4uvVSNMM1neZAJBe63SxiW15k76R5QsigUIzNJ1+PhWg6uvp9yJ/Lya85vNRNG0D+3xdrU0wdlwR4FDTNRBDnAFd63C5bupgCOWgApAkvZSTJJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768480185; c=relaxed/simple;
	bh=vYsdvT7Esg+O4+yVXNphLK0YKxhLuEHhcRTW8Mb/9K8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rSJsIEKoG8fhNss0Bzuyrohq2Dg1X74hwzRFzZKCrIxvjPtYdmf+swm6KqK8UyTUl8irIr5NbgzmQYLd87XTvD3nsa+vMKoEUKGB+o9eXoEC+pBcSIthh4LDZEOzKxRO2wGsDyPWEUUxm5APF+cHmOBxDWx4LyHf0pGaWl1uBsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YWoqPUwR; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-43246af170aso453538f8f.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jan 2026 04:29:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768480181; x=1769084981; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ld+As4KXLNBvjLuNePKBkF4h3CZ3gGNkmAsVzP6KebE=;
        b=YWoqPUwRhFjDNetwPJSdKBHF/sh7S1EgP7tlt+wR//RGEkO9N4XmFTkKsELsXCN+Wh
         tAaa3ENOSjTUpPILgZg/y++6goGL+uSgamekIXw8LmEugXqkm+977/byxDPFL1eoqlch
         cGOXGBs3zphBNNZNyLq/ZN0EehjhFZAUYOQqw+DHgPeteIljG+U4TPt1rzkLOeMvmZ27
         1O7Yw5joixwU3lRrqJFdpDK0eX4HermI+x+n3JLmTrJSvtJqL+AZ+HvmrKi9QhTt/+v6
         TP50tRwd+Z2mmYQDTI3Bo6Q51iA8Biw9ePX1ylXoopdCQ6oTxMlph+beE7QlfFLDppB4
         0k0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768480181; x=1769084981;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ld+As4KXLNBvjLuNePKBkF4h3CZ3gGNkmAsVzP6KebE=;
        b=BIqGRe1CDwUcZV1uxFWAotj16EL/fU33y7IO2eNcr2mhxICXgV6ap481xeNo+I9i1R
         Geo5xswwXbDafWpYdNajG+t6nixVA1+l4yvUrVNpKdCBkNnXCeot3KcXas4npnpXuU4r
         yJwkndxcfeYSs8PT9l2b6hy4qgCwkuc/fweoKgS2zacVCuAm0pmE3Wgv3aZ6lOJ4awCR
         2IPCT6tHRlndAUTRLNwCXKTDD6QVc+AFMjd7knn5YA5ND1bqN6dfVdbiB9OjF+nemcat
         obk0GRMXR78aCNB5yez17h/qvtHLyag6T5OIulDlUHCFRzAsXzyP834IM+OzVH/LkgTS
         Cdeg==
X-Forwarded-Encrypted: i=1; AJvYcCUzQkS/jY+b2hRB7Hmx3aat1Viw3phfRwGzmlTh3vPhui8Myye4JiuuWZEzyVf7ysimqw8OkW1wMUvFuvHO@vger.kernel.org
X-Gm-Message-State: AOJu0YyueX+Lu9niUUiy2MEtNgOJk5G/knr6qgXfv7O3deVNhV0IVV/1
	3KvvqN5nw02sUY4vU2KEMCmo2fvdheiFzciTBSHldGIq2dzZMBRTXoun7tGc+kmyVKc=
X-Gm-Gg: AY/fxX5jzTOmSMx+hd1qMwmZJ7TC+o9VQDdMMqWFBQ6LbKhZevSgNDOxsQ48aRySfRt
	LqB/Dqq7IGjccWCoWpQP8B896Z4GLZ83aJE8J5DKxvVixNh4zV3fOvbZ2NoOijjOg+wLHZ9ENVk
	u74it3bwmhOIzo2JuxKZcEv+PZl5cCh80MV2L0qCVXFK1McQqlawP3VlcP4ZFM5G0WIgxd/lDTY
	rh7uNFSRcydqgHVf7BUU+iEZnOvFcxtrr6IlBF4XO59vNBbmWpVvxW4de1lABgqxYlH/E4ZtM+Y
	scyTdvUKS/5plFDr0P3J0q4G7U2a1ANLvkbVi9G2pOWcE35ol4/OIG9mVLv/ig+L11kmEG5MW+r
	qnhlDLxDhRMI0MONpHVpRGCD0L/pFambhYU61WPjQ0AtmrX+idTDwVIY8PRA5jnPnOsTg3LRytl
	516Vd0JXr/tusikQ==
X-Received: by 2002:a05:6000:420a:b0:42f:f627:3a88 with SMTP id ffacd0b85a97d-434ce7324b4mr3823468f8f.4.1768480180633;
        Thu, 15 Jan 2026 04:29:40 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-434af653576sm5965022f8f.17.2026.01.15.04.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 04:29:40 -0800 (PST)
Date: Thu, 15 Jan 2026 13:29:37 +0100
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
Subject: Re: [PATCH 14/19] drivers: hwtracing: stm: console.c: Migrate to
 register_console_force helper
Message-ID: <aWjdsbYev_5zfKEC@pathway.suse.cz>
References: <20251227-printk-cleanup-part3-v1-0-21a291bcf197@suse.com>
 <20251227-printk-cleanup-part3-v1-14-21a291bcf197@suse.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251227-printk-cleanup-part3-v1-14-21a291bcf197@suse.com>

On Sat 2025-12-27 09:16:21, Marcos Paulo de Souza wrote:
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

