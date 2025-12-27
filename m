Return-Path: <linux-fsdevel+bounces-72144-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F9FDCDFCDC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Dec 2025 14:12:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 66379301D66F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Dec 2025 13:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11A84328B67;
	Sat, 27 Dec 2025 12:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="RnSJgO5f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482CC327C04
	for <linux-fsdevel@vger.kernel.org>; Sat, 27 Dec 2025 12:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766837979; cv=none; b=uCtfrb/qQIMOzirQm8QwidkkRnwtH3hUwJrEVPO3KEBSIMqjTatvFoYCt2+i+vAtQlqLkDFvwkd25OvtxVkrAi3JDqUxC/7una7e9KoIDiNuuK/uSTT3K7F8YLq9eWt4/8CQ7hXeGeDKh5Twrmxk2plAOLzfl5G1+vPgR96Qh50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766837979; c=relaxed/simple;
	bh=M+RAaPiD4L8bkGcekgUNUpTeF+sJQV6vQniznC8VslM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dWz/IMMNcJTMmMks1bsrlKyHrOoaQZ6rCoNYiRBkQcg7hVSzSFTQ1GrdfPr4k+v0YvQJeB6kML4f7mDJku4SGTTNmd6yGrWOpZZtbLaVIi8LHVJzeAcix9alTQdSx6PaGsH1uOEumvvFF+kFaKcZUIkx3eKXJAu6a5bqNOcP/O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=RnSJgO5f; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-477aa218f20so47224395e9.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 27 Dec 2025 04:19:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1766837974; x=1767442774; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ltdd8M4LmPmBXDEHAaMGtcqMVaDk3ISf2NYRX3F1G54=;
        b=RnSJgO5f3vtUewM4rvTV3gj9+yMbOKfC+MYezexVwjrMMLylt/VPAyyHXH1YzFUumt
         QXxRzkBUdgGbSc6jSzUsYa3jXKAwZa4Bqp8TNo6cmEn0wTHDc7Kwx7Tv6JxfQPBXSK1Z
         Qm0UOn9K3FCagDp9yEtJZ0PgTwmlFVmfIa3bZbJLozDjG0MYnrvBOj6fARSSOgW9ISLM
         TDx3DmRqR+dAYOLhMLlQRJaunF1kHWlswsvoFGluPHPnjD4wBz+hVljhInUYK2dzJj0r
         yyuvtBwmOGTxCPGWEQwBTqKOH47FDqb650jLrsWlgqlnlGTtx51xlzhAVlIMAzFUvQdR
         obXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766837974; x=1767442774;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ltdd8M4LmPmBXDEHAaMGtcqMVaDk3ISf2NYRX3F1G54=;
        b=ppfwSdh7dSDLjfU4kPaj8fNl3k9/V3oqziKlr0k68sg758vbCw9LA/XsMWLAi1KgnP
         VXhzyVme3+usyPsCJpvt5Six6JgCJlOmDq/d8ke4xGUvWFM4WsFgy88oGVTSYj6RocGU
         g0B3MI8ZpDhQbKLLB+wsYLRkHj4+hdLUa3pbjCSNp+bnNr//EiDLYzKPvzHWTcmG+dUp
         4aH0hFaWyumDWwpPB7FW6cS4zCeiOUKVQvnfgI+kZp51t2OSuUYXgKrWBMsY+Q/orsXl
         6FxCHVA1dUhwg0Ke3yog1OnNux3xumwg8QvXip/SxUw9G8n/IJaSrZLXBxbMP9ZWDcZk
         m+zw==
X-Forwarded-Encrypted: i=1; AJvYcCXbwVxfR3vMIaMrxnz3G0WoQl6bC5VRvDjYAIE5jeK6HPJt7Ws5bfcJ775VO+bMWvqeaQzE014clJb+PLe/@vger.kernel.org
X-Gm-Message-State: AOJu0YyXjwnXECnq8lhdTQaRGYdvjMDtnJR46YdSLG1FhLGOm8MPh6HY
	3ur9APZ8wzhRSuuAZPTMcQ9B0kOYFpl4gOL3l38u+bQqUQYTcOcwSyrK5wJOAOAzZMQ=
X-Gm-Gg: AY/fxX4WJYFwvWLvIDcb/Yy/14wCLb5PzfH0ignTQ8v+dqDVHpsp6GRcRRCWFoGh09k
	0XRU+vzZlLvfD89eNUHEaICTYrS1lqgV4hauB9oVAcgwlLed8TNPcnLfeWS791Qg3sQzgo9r+SG
	3uiqSmDbgGkBTDty+QU3dxwlXI0SUfkgEFRyi2uxnGIM+CMF9H8auxJe1aQ6lI6qBCWFmw4LqjT
	ka8RByAdks1w/0rY1hDPk7QiTyuPSFNvNyxjYfh631SQait7fWeY+9keQCo7pMb2wT0dK2bultz
	r0Z6j1H39gre0JO+YmVP+MPzerDgGlgTnety26Rj4S83xZIdKayAXxKPSIqXWtjx1MFrKhWPN3J
	DtVw6GOBYIMMP+hKgMO/g18JwKYmZMYq1Ji6TUA5LLP1K+ZSrlkYZutDP3EYpfQWeq6gWXbgcwQ
	+ocL0WWDZR
X-Google-Smtp-Source: AGHT+IHMLS3VfYivW6iZyjAkGRbHMebp8EGQujmDyd6LpCoRzo/q2pR4OLsY4m1yHd+Dy1qj+iz1Lw==
X-Received: by 2002:a05:600c:5288:b0:47a:75b6:32c with SMTP id 5b1f17b1804b1-47d19532f91mr239061855e9.2.1766837974046;
        Sat, 27 Dec 2025 04:19:34 -0800 (PST)
Received: from [127.0.0.1] ([2804:5078:811:d400:58f2:fc97:371f:2])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121724cfdd0sm97940127c88.4.2025.12.27.04.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Dec 2025 04:19:33 -0800 (PST)
From: Marcos Paulo de Souza <mpdesouza@suse.com>
Date: Sat, 27 Dec 2025 09:16:25 -0300
Subject: [PATCH 18/19] drivers: braille: console: Drop CON_ENABLED console
 flag
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251227-printk-cleanup-part3-v1-18-21a291bcf197@suse.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766837798; l=917;
 i=mpdesouza@suse.com; s=20231031; h=from:subject:message-id;
 bh=M+RAaPiD4L8bkGcekgUNUpTeF+sJQV6vQniznC8VslM=;
 b=VNcSKbW4wn0ZJDPmlW3fCDrj2qqqMiKzMUpnoUVSmYqwNJRukKGa+p9lja5itToGTVwI9LN+2
 mQPFka3TIBIDqDnH2JmGqErVL6l4YMmEx/hbdpLg4Ll2XIa+vBtsfSS
X-Developer-Key: i=mpdesouza@suse.com; a=ed25519;
 pk=/Ni/TsKkr69EOmdZXkp1Q/BlzDonbOBRsfPa18ySIwU=

The braille console doesn't take the same path on register_console
that other console drivers. At this point, it only registers the console
and do not receive any printk message, so we can drop the CON_ENABLED.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 drivers/accessibility/braille/braille_console.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/accessibility/braille/braille_console.c b/drivers/accessibility/braille/braille_console.c
index 06b43b678d6e..0b7ec68b305c 100644
--- a/drivers/accessibility/braille/braille_console.c
+++ b/drivers/accessibility/braille/braille_console.c
@@ -360,7 +360,6 @@ int braille_register_console(struct console *console, int index,
 		if (ret != 0)
 			return ret;
 	}
-	console->flags |= CON_ENABLED;
 	console->index = index;
 	braille_co = console;
 	register_keyboard_notifier(&keyboard_notifier_block);

-- 
2.52.0


