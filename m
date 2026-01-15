Return-Path: <linux-fsdevel+bounces-73906-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F223AD23E4F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 11:17:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8C3E030381AB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 10:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EB69362125;
	Thu, 15 Jan 2026 10:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="O1AfzI1f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A99361DDC
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jan 2026 10:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768472200; cv=none; b=Rg4aUFEc0kX9hv7TIq1ZdfyzLKG7fizufIE8CMDUTHoZkRk8mG3lD1QC2RxIDc49ZX0nIZX1H+MMtzcqBm5XFUQDrZB5cQ6YdxwHPpYnQbA+615YOP6u/ugPAhowJZe7TCDFMBcAaRnamDkIICyxRxMonzivTKIaJkEYc7R7/Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768472200; c=relaxed/simple;
	bh=zwLrvsF0GMvPSCBeAjAWQZcmbWMJVYh05GZu4CqMmyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G5WtWgKAEYHEydSGyRLzub0j6gYWMFWlY1ITN7mErGUjKnECbzLiraeXqTWVOuOJF1fQ+hliXjxFXobBbFq+cwhKFBvYAHiJYyVIAJSA5fbfpE59JnG+4cgiA5UE04eL35NyHjDbdaLYz2J0r2FxCfcwYwQjVw4kKB/DQfhullk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=O1AfzI1f; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-47ee2715254so3279485e9.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jan 2026 02:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768472195; x=1769076995; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zwLrvsF0GMvPSCBeAjAWQZcmbWMJVYh05GZu4CqMmyk=;
        b=O1AfzI1fLMDVa3SD3LO45cvIiavE+LKVM93UrB7hJYcD0m6yOptHdhokkT8bTYka6C
         3sXJ7mv88zLWCKOA1K4tTNEUpgl5sRbxQkPkY/JxJ39NJl8UGOMFq8kcmDmf/klRNfzu
         nJ2y1cuRJKr4oZuTg+fls6YXgf7Cmk8scFvR14UdHkOvJCMLVgfHdOWaDArlFHS8i+in
         /rjDe30x+8k/vU2nriXmVzYvgsK75zbtsHQliWEWoqaCQIzSRCmZBSVIuTAHgBAk/qqa
         BhvMnVF7Ni7MX4Rr/TPuFFrwopkxq3IhJQiQJ1qEZjzsylkwRiXGFMLOKcT5/GAwd0bX
         FnhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768472195; x=1769076995;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zwLrvsF0GMvPSCBeAjAWQZcmbWMJVYh05GZu4CqMmyk=;
        b=eKtEre74nFB3DsY7iv7em9e36HMCChvjBWzX3XCkwSpAWuPKA8CtIUhpMMXZ4yVl01
         g80qkz0KcjFQg2RFA+sjOUfdWocD1Rbd7W3crrrazyRhJFZ0KVuspIak6nhGu3acLuPw
         H3K5NemTqa8H4meghIYJMTZf3FbL9/OFdVRo/OEerhV9njPZStwQDnACjHIIzeXYA8+x
         1cOX9l7r0rwC+qWFq0+otfBTqTXHB0uUyvQmgTPJ2LFYSiwlLwMisaocZjO70s+U7oew
         HL+vxhfCGjBJGy40X0z70QuYSJWNEF4NqevMZsUzE0+g2tromdN6sIdbzYT7MWOgmtLT
         iwig==
X-Forwarded-Encrypted: i=1; AJvYcCXSUzzA8En7JOCWbZHPaqfDUXmWz2LGBkq7CYvW4D6kRR58D9CSwQd0zTyWuslYs2pOsBSUlgQLdsVWCC+V@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0ikoeR5ThzXkLo098JWLtBnAdBPEFblsOdXxjkybzwgGDRAFT
	HfdIXq2L1Qr/bRI3EBneXNVJG7ij5NjaGSA0vBcEu73Ou9Z+9BWQDnL1nqISnIlZyIo=
X-Gm-Gg: AY/fxX7UKm0Wivs6pkfGdRrER5/lMjrXRF4pI8/x4e5DGyIqji+r/lAcxop+SiSzY0r
	69TrfQ98jTn5kbNgHR0A6DBkRYRlsEyoi0n3c7ZVKvpB1se5WdI7tIUEXD+FSALut79VRGH3c7t
	Ol6PttpBu+bMd1w9QuFLa9P5u+oMZdQIglR9zH5U2REqt/7SOD+x1XEVQgbCoBdplLiXVa8wTTu
	OOzh5A8aVIY5JzBiNYj5ZRz54yTIi+OMB6qggS5yOMQB8spk6RFTbZ+Jf72eMuYlYA3B+Dpaooi
	LQlbXAOkwaGMkToqIPMWZcolbkeSJ7X32QAiuNxe7SPUzJ7+VheDzN8m1rrrnQoBHNq5oMTFW/j
	fPA9ru3aBrmYBIy+JBzQKf7TMslH0EIouqx8MYJA4NMhaaxHN4UC34VkMRvuMP1pGyltH3D7oE+
	kqbCb3L082/xi/PkSu372Gc1e+
X-Received: by 2002:a05:600c:608c:b0:477:a246:8398 with SMTP id 5b1f17b1804b1-47ee32e0829mr58296485e9.2.1768472195426;
        Thu, 15 Jan 2026 02:16:35 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47ee28144aasm39739585e9.11.2026.01.15.02.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 02:16:34 -0800 (PST)
Date: Thu, 15 Jan 2026 11:16:31 +0100
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
Subject: Re: [PATCH 07/19] drivers: netconsole: Migrate to
 register_console_force helper
Message-ID: <aWi-f9LBJtxGWgWs@pathway.suse.cz>
References: <20251227-printk-cleanup-part3-v1-0-21a291bcf197@suse.com>
 <20251227-printk-cleanup-part3-v1-7-21a291bcf197@suse.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251227-printk-cleanup-part3-v1-7-21a291bcf197@suse.com>

On Sat 2025-12-27 09:16:14, Marcos Paulo de Souza wrote:
> The register_console_force function was introduced to register consoles
> even on the presence of default consoles, replacing the CON_ENABLE flag
> that was forcing the same behavior.

I would add "No functional changes." like you did in the other
similar patches ;-)

> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>

Nice clean up!

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

