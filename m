Return-Path: <linux-fsdevel+bounces-73919-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A014D24780
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 13:29:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C59530B23AC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 12:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5013396B92;
	Thu, 15 Jan 2026 12:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="AavSW8zD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F40F394469
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jan 2026 12:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768479886; cv=none; b=NOHwG8zilmHWEZ6PCRPIVgCIW06syhquq3F1RFoRQK9UVKfw6ZYLG5C5LxRiG1QOKH0V4becJRm3gE/iCMmoH5BaXw57vRik4SjkogXGkHVGpbBDnaWLCpjpYOeO38UuPgmSy/PEFn+dzlJgUEqYx/gz6iVCwwiQ3w779bVD+aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768479886; c=relaxed/simple;
	bh=L1TTyH0HQfm7i7n+eqeYhrSGiuwmELmvtw7QQ3GNH2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HJTgVFWp6XqWBZHm5yK2Uxo3C0olNZlzwK68XSYkkI7tShmM5rhkD+PfU3yEL99mAn/6MAbzfW76ThUK2tMsqYaYv+YKWNbAOsXU+Bl4jJieDZ1B0oQBn8axQ4WX5jNs/d4JDKk/RM2RrMuK23r70gw9NVuCX2P35S6RRoRDJUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=AavSW8zD; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-430f5ecaa08so435786f8f.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jan 2026 04:24:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768479883; x=1769084683; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jS491F7pY/6VV44vwrzsFaAyA9RjAqjEAkamZCNInAE=;
        b=AavSW8zDa7wyUQOrKCsE5mEiLhCbCgtNLUJDLiygsCIz5MtcNfL5qg5hmiFSH/hnLF
         dY1NM5kxU9pSW9DgohxUfSzAVt+iLYuHkRY/WkdFE1XVmgvI8pljiAwerID8UL6g7PU/
         eolJwYFX6Yj0B7yZch1EvVk8qqbK6y7rtIhghbakTGjeNT0IeZm0hOjwyUU0ncWi7Ohd
         fORx/nYcwlXu0aeT6z2nysNJs2vxMwjVnQi03RkyIvPvmebQbr0uJa/GOMbQXodXURQ6
         +ZErOfCH6CKBneuJM1DXIQJeb7qxioDN+X5ZyEYo1486PL/QTstgRmV32S5n4c6fMV9G
         3dqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768479883; x=1769084683;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jS491F7pY/6VV44vwrzsFaAyA9RjAqjEAkamZCNInAE=;
        b=LnDfzD+RlIzzLB9I/1a3rjHSjwA8QiCeoYgepBZGIcy+bKIOqrasYH4vyggykXYRbN
         H7TaaBBLmgeEKPsNi0WBPIitJi7pT+UYTQcfVRUcbufKxF2wLH/xug7fL++hMP54VVSM
         AipCsq9UjAECblUwQWTEz1eO94A5HlN4yP170Ixhb3HjbsjOjUYU7O0OOdTXfZrf4IKz
         MSf3+r2AgI5cu1CFzybexDvuabgTZ9yJxbM9ekB0jG9pLz1COldM3KS5Ga+LEbvWD7uT
         nyP8AwkAkAMp+Uu92LeQJ+A2GT10ygT1QuhgNVQbjeaxSn6UGhpvQOOhRGgUoTlLmbEB
         EeTg==
X-Forwarded-Encrypted: i=1; AJvYcCX7TTPkHY5F04BUZRJyvu1B+GPO63LjYgZlwww3ifLjSAIWregJH5s6e7wN4JLy5ygBYkuTuNkRSC93L6O+@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2C4pIovNhoMcCPN0EKVJJjLONMXO0vfCLM6XjA37fbDzgnGlA
	sFf5BwV1/FvRH2GIbrkPdoSmOZsTp1qfJiK0n5E5LHw7d7QCxaRgj0ohn14T+vMVSsE=
X-Gm-Gg: AY/fxX55zYIaMp4qhTBuAAunWaCnWbeFy2X3Wx9N6UgtztD2lrcezOWIZOJrimhEXjp
	8zVJUzyZhbAMi5541sCDlt2QBXRavwuF+MWrhVI8VQMxnEJ8dzw67JuBEDuySdjuvxdr1wbxqgK
	qBa8Qfr/AQ7tiWEEWx9/x1pf1/yvbagkhrwOTGXMsDtJDG6Kc142Z2UBThphKdwvV4EEYPYdr8C
	qk0vUVrh6dIl5LUkrWgcd1Uo2OouuY53M5O6qFZb4OuJZooj/LlvgMgS/wN6JUvZ01+vAQFSc84
	v7vm3YXMbCBy0u/CWtrvYmaPiQo58z6eDKUmfVRRBNEuY5vsCTyXOAy4A0lCoYFWj+Y18Rtlo8i
	JDIsaC4HQk6rbtEDHHzgJtZhXIMub9F5bt4A97Tmf/es+fA18HTu8orKHZKYYNsRUf1oKDkesq5
	ViQm7euW9Z+InXdQ==
X-Received: by 2002:a05:6000:1789:b0:432:5c43:64 with SMTP id ffacd0b85a97d-4342c547aa9mr7495008f8f.41.1768479882771;
        Thu, 15 Jan 2026 04:24:42 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-434af64a650sm5653238f8f.4.2026.01.15.04.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 04:24:42 -0800 (PST)
Date: Thu, 15 Jan 2026 13:24:39 +0100
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
Subject: Re: [PATCH 13/19] um: drivers: mconsole_kern.c: Migrate to
 register_console_force helper
Message-ID: <aWjch-EcYm7tkF0t@pathway.suse.cz>
References: <20251227-printk-cleanup-part3-v1-0-21a291bcf197@suse.com>
 <20251227-printk-cleanup-part3-v1-13-21a291bcf197@suse.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251227-printk-cleanup-part3-v1-13-21a291bcf197@suse.com>

On Sat 2025-12-27 09:16:20, Marcos Paulo de Souza wrote:
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

