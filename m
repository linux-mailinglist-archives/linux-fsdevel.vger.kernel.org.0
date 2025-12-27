Return-Path: <linux-fsdevel+bounces-72138-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E0D7CDFC2D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Dec 2025 13:51:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CD6DF301EF99
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Dec 2025 12:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 745FE322B76;
	Sat, 27 Dec 2025 12:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="O5LpEZ9J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1F6322B62
	for <linux-fsdevel@vger.kernel.org>; Sat, 27 Dec 2025 12:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766837922; cv=none; b=O3CjWh7nmCQUUE86kDtlJ1uHEK+BOB3LFVZstj95wtlUI+oc5cB0rCuSVzbLrcjx3oS5i02G6MYItxsoWgRzTJMeH23w5wGkmTsuhMH6ItBRibxIwV1tkbWv6Wsg1kMN79TS3gY/izC0I0+sgoTYK0M1z3aLiGS1GFe5Ag88fmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766837922; c=relaxed/simple;
	bh=rI7fN9M4UYBhm41SNkDmrXmROIuX+aCv9rIYYOtlo+M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Od9CsVbdnFJEuMzUdr5clyzf7DPwnCXKDG6hgKJuzRik+/yj6/N7PVqRmB+fGqqddlg2G87dqzg4SiGv/3tzJ2iZN5FCUdWnu8ndvfLU95sSiNzeUGYjc1z2aJpjLGm+CP+/jep0cDhIee1C8yBrfx9/sMWR7TlqUmF00aN3xqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=O5LpEZ9J; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-477b5e0323bso43703915e9.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 27 Dec 2025 04:18:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1766837919; x=1767442719; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zBuTaAePekdaKhl7Nr4xkMCH+YbgmQZc5bDJsdsSluc=;
        b=O5LpEZ9J1AAGFjlwy1Bw8C1mEFIKZsy8OC9PToLtvE69o1nSWoYGN37SzYTdQev01Y
         5bTQSG1Q2C7W1no5i68Q68vGj4ubGnnr1Mm9uq4r9cHOhqTLjpz3uXM5iUeg5fSntuqV
         nrbasqNPftIndWD9mt6B67XF1ccAyQZJ5q76NbOx6VP1Wl6n892zuvXUBSDimVa4k8Wg
         vR7mbCPGvYYZNzlrTlyibMAmz/Va4l+nDq7Akxk7Aqu+xeeRtByKKBWssVTVcncEmDkP
         AgGrxfBPS4YrZDM9hwRSbBFMB4cYxU2ENXOQQgwEe2WNjZdFE1iImQORg8xd2dCfl0zW
         YzMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766837919; x=1767442719;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zBuTaAePekdaKhl7Nr4xkMCH+YbgmQZc5bDJsdsSluc=;
        b=K7gGuWw+v9lWeaIM8ve51uISzxUOV9LrGrIBwI5TEdijoVt81p6gkAjS2D3pPhPU8F
         TE3Qk/N6C9ahE3Muf1CprIB9BxPvc+v98/XsQ0jkl6lxgOTosYhyn7BYznZ79Fln/RLq
         k3Bod6BeLWGZ2Me6pTBbJKCxiZSJhT/rMm99LX8sAC/D4eqHAfKrodQ6P6/66yiztf5E
         4yIVzeVLrfoavlIy9w14XdcMuiMOVpfQ8+9NQ6mdOv2VmsJsIPLdYrcw8bqJooWortXI
         sbr1HlmN7wjVu6ESRzwwMrQkCWPh+jg8a9cl83r1+beQxVDbcTLV+7S+oKQIS1x9QOgk
         UpVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOg0UTJvmYK1JmQdBXHmbh3mnHvUSxQKLp+FHDfQ7w4FDFAh6PN8yf+9faFkmzFMrkRAtEsB+2fhzqo5HB@vger.kernel.org
X-Gm-Message-State: AOJu0YxKErHogNNopcJoga/dPKdtxZV/IAtquNTlODEBQPLvFZrIXeY/
	gl1RzpvKisgvvgjv/QYoYTGrh7GoRPV4sXlpH9VxvGHDV27oDYapqIxy7cih4gs9xfs=
X-Gm-Gg: AY/fxX63mYMsdfBkfYGeosbtEojhlN1rvD3soxgO50ZlXEmnwC1Vlqbn7OyVancuxNr
	nVhFYMLIEqo/OqlwVEv9anpPTHYcQBPmJQCICyu7C0vphevRCNZDpEzavPrfj0024IZctbvdTbr
	5kDKMPyBwbRRNildMkPuqSW+kmJLI08hwKQrOMkOMfd9ZK7sFDHOms1P4SQ4mhE+ht4+gmLtrSi
	YkCWBpkrZJbzfWGpV9jW4mwSBMi7Ws/c3Fss31oPCFG6E51Bh7m2A4ErBo4UfkQgVQft0HEltr/
	Ixrkk4s+pKPucC9RI72XfG9mryyatc3MZnFVB7QFz8JGOWzQVZvHrHDlN2lCysZlH1oznQ2+HsW
	Re41DWTlRa57N0qtjzDQs7JNXQqoVBdbPr6Mbtea2nmtmEZTvm/8t7PhYxLnM0Y9MYVC4HX+9n9
	xVCUK/jINv
X-Google-Smtp-Source: AGHT+IEaiNWrbXUQR9Xr4SWeWCswjY7G2xsTNDPKS34qx+Z9cd/RVKqDItuoVsaN7WK8NMfB3mQH/w==
X-Received: by 2002:a05:600c:3799:b0:477:a71c:d200 with SMTP id 5b1f17b1804b1-47be29e87c1mr231953365e9.11.1766837918587;
        Sat, 27 Dec 2025 04:18:38 -0800 (PST)
Received: from [127.0.0.1] ([2804:5078:811:d400:58f2:fc97:371f:2])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121724cfdd0sm97940127c88.4.2025.12.27.04.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Dec 2025 04:18:38 -0800 (PST)
From: Marcos Paulo de Souza <mpdesouza@suse.com>
Date: Sat, 27 Dec 2025 09:16:19 -0300
Subject: [PATCH 12/19] sparc: kernel: btext: Migrate to
 register_console_force helper
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251227-printk-cleanup-part3-v1-12-21a291bcf197@suse.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766837798; l=1119;
 i=mpdesouza@suse.com; s=20231031; h=from:subject:message-id;
 bh=rI7fN9M4UYBhm41SNkDmrXmROIuX+aCv9rIYYOtlo+M=;
 b=bcNrmzf90N/BodrKZ64tr7qsRPh416urxDwc2BxCBqWgNmTslPpP/9rT1ZURe+mv3PmWaFnbq
 xnM5PWTrVU8APb7FwkkZf2fGZ3Hw2PsJVWl1KwMiIyJjzl33goH6hX9
X-Developer-Key: i=mpdesouza@suse.com; a=ed25519;
 pk=/Ni/TsKkr69EOmdZXkp1Q/BlzDonbOBRsfPa18ySIwU=

The register_console_force function was introduced to register consoles
even on the presence of default consoles, replacing the CON_ENABLE flag
that was forcing the same behavior.

No functional changes.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 arch/sparc/kernel/btext.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/kernel/btext.c b/arch/sparc/kernel/btext.c
index 2bf558a0c568..951de7733632 100644
--- a/arch/sparc/kernel/btext.c
+++ b/arch/sparc/kernel/btext.c
@@ -301,7 +301,7 @@ static void btext_console_write(struct console *con, const char *s,
 static struct console btext_console = {
 	.name	= "btext",
 	.write	= btext_console_write,
-	.flags	= CON_PRINTBUFFER | CON_ENABLED | CON_BOOT | CON_ANYTIME,
+	.flags	= CON_PRINTBUFFER | CON_BOOT | CON_ANYTIME,
 	.index	= 0,
 };
 
@@ -320,7 +320,7 @@ int __init btext_find_display(void)
 	ret = btext_initialize(node);
 	if (!ret) {
 		btext_clearscreen();
-		register_console(&btext_console);
+		register_console_force(&btext_console);
 	}
 	return ret;
 }

-- 
2.52.0


