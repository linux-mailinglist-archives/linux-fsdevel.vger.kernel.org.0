Return-Path: <linux-fsdevel+bounces-72139-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F108FCDFBB2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Dec 2025 13:44:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5C8DA303212C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Dec 2025 12:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB69316904;
	Sat, 27 Dec 2025 12:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="J0FA9L3E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C553164DE
	for <linux-fsdevel@vger.kernel.org>; Sat, 27 Dec 2025 12:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766837932; cv=none; b=IhTvg0Dy92iCMWnU7fVab3+EnvhWjgY1tes/UQigUsl0WCVaWa/vFW8DMpOAhzuQ39UzXobVEzijV8vs3pceZdYQrYjp3FuwQTr8Iyvcw48k1Y1VTRBaSto/lvDBo6y1cb/sDWWXR6yDT8tnGlEm6cGtznY70QQlEiFOidn6MFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766837932; c=relaxed/simple;
	bh=9A3Brx5a3gQ0NUhTGZ1ViMT9HfTuP00Tgzee1GwnjVM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BAMxdStC/pmCfq88GXkccrocdlHMKlXu9D4vJrFxVxdmkjS/P+nOP41vuojeLcLiLpO1hMwnLJ9ochGeq7b5n8im6Br8YK6nhKbpfAKnocGxAmlz5muH2KtDJXwxV5SCblb+m6nFiGpWui3aUk081tG+qUWjL7F3I0RTnKs5mU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=J0FA9L3E; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-47775fb6c56so59045945e9.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 27 Dec 2025 04:18:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1766837928; x=1767442728; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NC/xlTHSkC5720zy/KPT378kGxggptiwCzT1YNGAqrI=;
        b=J0FA9L3EEmy+IH7mL6HrvsAU2J8mMSuJmz6c7amiBc6l2t5p3f62JdTCtKxVbVw5tv
         zuNS8vF1S+3BpGWqsjsvt4ONGTmjMi/I3YD222xJdfKU3h4VJfUslK/EeDgLn42ewU0j
         LmFaia6d73wWqXt/KgBZ5iFETl+z6Rh9R0DQN/rMwXBfnCoWzcyGp4OYHq2TLfwXr2YW
         QctsoL79xnhZYvgAc/ZHZCjw/UuAClU8c2kW/VmOPYGJFt21JADcG2l5JUTrhu5ga03I
         +AJKNR7KieNZIm41zxSYT3sOU92LGB7G83JtmI3WGHaz3MQWgZVnsoOHQGzODtYm02LZ
         d4Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766837928; x=1767442728;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NC/xlTHSkC5720zy/KPT378kGxggptiwCzT1YNGAqrI=;
        b=TZQmQnLbv0LMk7iPcH/gAxSjMBzXCToy3Jdgd1jSePpOGnNX95vyqubZWtE7bskljz
         WBGWjNdSSj2PzTfkHVyeQaAjNjLS5sAoRl+Z8+hr5K3SKlujEUryte2LJcE0sNN9nNoj
         qT8TB+b/4BuOrs4jDEBtZ2iOO3klihrWrIXSJkop0Wjc6YURchz61P/hzobgaYE5Dzxl
         eW2xMvy6Uj3JTUMUPXyjw/Balr/LxCCsq3wiiascSztGGQXgJLMmomAeDMTQzPdV0+yi
         UGDaVZyPp3klyxWj7qHCFlUL18mR0qh5O1rqWoBmkleT6tn6qUOsPChIb0KLrsUP35OT
         KFUg==
X-Forwarded-Encrypted: i=1; AJvYcCWYSHiLircFRbCGrnlSIDp2krAc0rmvTF0FaCypLOv8LOUGQw5rhaJawz5r/yWb2xOsetG5Nb8lItSwML5+@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe5mZr8Wiseu4Nk5+mhWcgXDH75q+2KuqYo++PcXH1A06x7oJ/
	azU+mfVMyXLSWlHx67wIBGInflYQTVrrXgucju+76W8jxT7DvIwB3DXcvLoZiSbYpsk=
X-Gm-Gg: AY/fxX6Y7O+4oYIG269nV9Grte4vtA3kheX4T7G9IDStKQGSNOMAFViIt2siI9TNjKw
	zn1DZ32aFOORTCw8HzyzHNV3pI2BSWFC9GjoOdxpZIuuqx+ud0ppHMawDKj+K2TL65Y3zCvVzsF
	vKn4I211THTaioT5FHMBiw1NtWiM8cVlULfwPWwznH+EYgpGIJk0kWiOTKR8Gu4NNasF2uekYyv
	zxFDxkqRNdCApwI0pEVahOW8SqSwAXbOZK6vLxq/ziy7Y5rcIUmoEOd7uuxkVgag5LWpm6KhJwI
	bZNsvqb7xtXT+fEFSbnKqIZjsrRRLlEkJfGoCVVNoJ/u0cG3yDgJJ108gz923anpdcA3pGEbzU6
	Ervvgu6cNC2cW6GbZy5nbZbFQQQEMsHu8+52Q/r6OrM96563BnwthHVorMvpfjbPRWMlSUeXTQq
	DzzjX+reXv
X-Google-Smtp-Source: AGHT+IFbCGvkCxGExFQLBl5yaU008gmiVvRdmeb7k0sjyaCh7Z1nYJocCXv7ZLYKC/Juko66305eyA==
X-Received: by 2002:a05:600c:8183:b0:477:fad:acd9 with SMTP id 5b1f17b1804b1-47d195a9834mr270395745e9.34.1766837927833;
        Sat, 27 Dec 2025 04:18:47 -0800 (PST)
Received: from [127.0.0.1] ([2804:5078:811:d400:58f2:fc97:371f:2])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121724cfdd0sm97940127c88.4.2025.12.27.04.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Dec 2025 04:18:47 -0800 (PST)
From: Marcos Paulo de Souza <mpdesouza@suse.com>
Date: Sat, 27 Dec 2025 09:16:20 -0300
Subject: [PATCH 13/19] um: drivers: mconsole_kern.c: Migrate to
 register_console_force helper
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251227-printk-cleanup-part3-v1-13-21a291bcf197@suse.com>
References: <20251227-printk-cleanup-part3-v1-0-21a291bcf197@suse.com>
In-Reply-To: <20251227-printk-cleanup-part3-v1-0-21a291bcf197@suse.com>
To: Richard Weinberger <richard@nod.at>, 
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
 Johannes Berg <johannes@sipsolutions.net>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jason Wessel <jason.wessel@windriver.com>, 
 Daniel Thompson <danielt@kernel.org>, 
 Douglas Anderson <dianders@chromium.org>, Petr Mladek <pmladek@suse.com>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 John Ogness <john.ogness@linutronix.de>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Breno Leitao <leitao@debian.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Geert Uytterhoeven <geert@linux-m68k.org>, Kees Cook <kees@kernel.org>, 
 Tony Luck <tony.luck@intel.com>, 
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Andreas Larsson <andreas@gaisler.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Jacky Huang <ychuang3@nuvoton.com>, Shan-Chun Hung <schung@nuvoton.com>, 
 Laurentiu Tudor <laurentiu.tudor@nxp.com>
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, 
 kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org, 
 netdev@vger.kernel.org, linux-m68k@lists.linux-m68k.org, 
 linux-hardening@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 sparclinux@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
 Marcos Paulo de Souza <mpdesouza@suse.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766837798; l=961;
 i=mpdesouza@suse.com; s=20231031; h=from:subject:message-id;
 bh=9A3Brx5a3gQ0NUhTGZ1ViMT9HfTuP00Tgzee1GwnjVM=;
 b=gNLF1CEZIFvupLFUy4kgNSgx2QLue8Fjf3sjVi+zSBhpSIWUfb0laNahgF6qahlq6x3pophwD
 dRykPPu3R/nALZM8P2pCpkq//4oDFgsmNLGc4Tixc+Z0JIXH+9rAGGe
X-Developer-Key: i=mpdesouza@suse.com; a=ed25519;
 pk=/Ni/TsKkr69EOmdZXkp1Q/BlzDonbOBRsfPa18ySIwU=

The register_console_force function was introduced to register consoles
even on the presence of default consoles, replacing the CON_ENABLE flag
that was forcing the same behavior.

No functional changes.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 arch/um/drivers/mconsole_kern.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/um/drivers/mconsole_kern.c b/arch/um/drivers/mconsole_kern.c
index ff4bda95b9c7..ce4f4ceb7f27 100644
--- a/arch/um/drivers/mconsole_kern.c
+++ b/arch/um/drivers/mconsole_kern.c
@@ -582,12 +582,11 @@ static void console_write(struct console *console, const char *string,
 
 static struct console mc_console = { .name	= "mc",
 				     .write	= console_write,
-				     .flags	= CON_ENABLED,
 				     .index	= -1 };
 
 static int mc_add_console(void)
 {
-	register_console(&mc_console);
+	register_console_force(&mc_console);
 	return 0;
 }
 

-- 
2.52.0


