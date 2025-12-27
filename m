Return-Path: <linux-fsdevel+bounces-72140-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A33D6CDFCCD
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Dec 2025 14:11:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D6814300F5AA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Dec 2025 13:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62ADF324714;
	Sat, 27 Dec 2025 12:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WkPdkqCj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD690322C6D
	for <linux-fsdevel@vger.kernel.org>; Sat, 27 Dec 2025 12:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766837941; cv=none; b=MUKGx9ME9UBKHvrrtjfHHjeo9dVymQgzpd3Rv/SE3dRij8b41Y/8Q+Z9U2bl0+1g0QEFBrCnWkiBE6z3RbJkx68JugtATLW+m7NHx4XP5/Sn6fnlUlxUy6puPZ3J9YCQHkUgSNjoscfG74mahIFOqMS1Ny+oWRYyjaxBbiHEBtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766837941; c=relaxed/simple;
	bh=go1Xoe57mzaY/mIQIq5f3pHcbzGWVFe1Pe8aCGM93yA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qLLkQkM/CMqTkHP/Q15zIQdQ/eQwaT5+2/BxcV5H0ribr7tSxj2UbjTrWpJRPScHa6/3k8sZ2lIP1yoSRK8oRkcDD3SS2tB2ch+Cqb2y63ROoktU1mYZRDsmlzVrXEXeS5y+XDvxaJknBc5lV3fsS6aZB+5zr/IumQ9awUYhZUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=fail smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WkPdkqCj; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=suse.com
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-47795f6f5c0so42071835e9.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 27 Dec 2025 04:18:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1766837937; x=1767442737; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jl/uMa7F0AxGo9UgKbw3ayYmv5/eAGkPJCpV4UBsG/A=;
        b=WkPdkqCjvnF1WWewivsx9QKBvWv4Xkq6+Fh344PfMkM7aUVkscfEHyxnA9p64TN2H6
         jrQomrJRmmLRcyIHDzB9nMlDty3nb6h93b8ZmPlw9sOvtbZeeDcmT66uLUIA0Di07OvP
         bPe1SiO2UGhRR1eytL2fnbICWfMM5MFAY7iQw+sqAbuBql9wDEdV3AE3+sWMnUHDBSBn
         iW7EHx8A78yboH3lzk179FGsD0tX9TZtVG/1DsI3onhwFM8G4AY0Ahye4bUK9Pa0XmD/
         gcqgqd0tl7RamgGQRJoqDgwdq8cS7rhb2BfkdaFWU53nrWBUSLvGNgRBK1ChsnqneJei
         o36Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766837937; x=1767442737;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jl/uMa7F0AxGo9UgKbw3ayYmv5/eAGkPJCpV4UBsG/A=;
        b=ClI4YMX00F1+RiIa3wWBTiztJBUq3/20CpSyGdHqA7bV307AUlJwJFmFUMVKknS1uy
         BTRxBHGQ0hplt0Xp57KEEXyUTxVwFhiKat0aKYTs5sc9QZB9pCOvlCqATHaKn5Ef3qaf
         4qDYA5mA7j0RatGns0p1ylev4BJU7zAdtbIx9Gr+KCR2TcxqTo2cZVQPL4B9OMpix0ZT
         ZZCO3AD6IzaSGEPJOY4KZblIL7oH16dKtADXA9rY4eArklg72avqMw2+rM9GXEO1d7Rp
         5YzBxOGtFXh97MJWSBlflM2fYieHMNs5NhhvIskH927bgZJi+Dhzxs2NGLKcw9iQx5Fh
         +W9w==
X-Forwarded-Encrypted: i=1; AJvYcCVC7JrQOmunJX7R9cRB4IPYvIMhdv9dhaoAk8Q51dgGMTWIrWUOkVUhcY3xTPhXhIeMGag6oeM3HWaTvEci@vger.kernel.org
X-Gm-Message-State: AOJu0YwWfuI6gXjxoTCV4HyyLWXP67aIqSiaAHrkjwSwutRqn5iVDWo8
	4fLG/d6Mk+oEd1laQoU65DIJzRukBHw8HDTlbRPoxAqSE2vTDpzZv4YEqTjO1sFNiFM=
X-Gm-Gg: AY/fxX5HnKFcxooKS73RYiPPr9H6AUQdlgeZ64XXuejdDorjhDQP+elM/Jf+O8+xVnd
	jM56ce/jRE9kXIUuPWAe7LOFxGfRYvVt2HIpr/Sex/IJ+2En/3Vdpn94UOsUtvV7zKY1Uf+kjDh
	P7JLtx7znDnjkgfTLs7cznSR9D3GPntzPmHgAXsRA9TD7iqzA+MJ4W9KZzo54XB+t43vWl7fBeb
	RudI1E9lPabbxZMzppHZf1wInD5Dzb6SfjkAQh7uJ3EsMsH/dXBbakiu9ZMNqeaeFAKFAkRREpi
	F0UhcVc0zbwWDEvESo70BxJS91EAmZ0HTQAHodV8FiOXM54o+REnN0VE9me9LRr+TW6xhrv6jhx
	LrlCJq18iuKHTUjXrMhdCFhSZVgymXYqtGHX73+vO3LFqvf9Kv1KTMv6AgNYiLgzrbGOcm/fUMl
	veY7W/LN2L
X-Google-Smtp-Source: AGHT+IEilNPw9ykBXsWasfDesGg5n0pMdngWI0y9wCDnaTUFF7DpZ4wL0dzMcGNMkGv8jBn79QEjlQ==
X-Received: by 2002:a05:600c:5249:b0:456:1a69:94fa with SMTP id 5b1f17b1804b1-47d1954a128mr290319795e9.13.1766837937081;
        Sat, 27 Dec 2025 04:18:57 -0800 (PST)
Received: from [127.0.0.1] ([2804:5078:811:d400:58f2:fc97:371f:2])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121724cfdd0sm97940127c88.4.2025.12.27.04.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Dec 2025 04:18:56 -0800 (PST)
From: Marcos Paulo de Souza <mpdesouza@suse.com>
Date: Sat, 27 Dec 2025 09:16:21 -0300
Subject: [PATCH 14/19] drivers: hwtracing: stm: console.c: Migrate to
 register_console_force helper
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251227-printk-cleanup-part3-v1-14-21a291bcf197@suse.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766837798; l=940;
 i=mpdesouza@suse.com; s=20231031; h=from:subject:message-id;
 bh=go1Xoe57mzaY/mIQIq5f3pHcbzGWVFe1Pe8aCGM93yA=;
 b=2O7MS+wSbmBy5GHviNZc0eUrBGjBqbDvdZl/gWh/gmVWu32K1VqnWzIxEikovOvxtxQ1Ut5k4
 SCkXkL827NRAROp5vOzN3LiFx30TLjgXwQqt3ej5ptdr+YtakhrR7Rs
X-Developer-Key: i=mpdesouza@suse.com; a=ed25519;
 pk=/Ni/TsKkr69EOmdZXkp1Q/BlzDonbOBRsfPa18ySIwU=

The register_console_force function was introduced to register consoles
even on the presence of default consoles, replacing the CON_ENABLE flag
that was forcing the same behavior.

No functional changes.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 drivers/hwtracing/stm/console.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwtracing/stm/console.c b/drivers/hwtracing/stm/console.c
index 097a00ac43a7..d3ae633e3bf1 100644
--- a/drivers/hwtracing/stm/console.c
+++ b/drivers/hwtracing/stm/console.c
@@ -42,8 +42,8 @@ static int stm_console_link(struct stm_source_data *data)
 
 	strcpy(sc->console.name, "stm_console");
 	sc->console.write = stm_console_write;
-	sc->console.flags = CON_ENABLED | CON_PRINTBUFFER;
-	register_console(&sc->console);
+	sc->console.flags = CON_PRINTBUFFER;
+	register_console_force(&sc->console);
 
 	return 0;
 }

-- 
2.52.0


