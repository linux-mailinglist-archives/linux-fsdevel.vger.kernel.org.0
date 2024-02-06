Return-Path: <linux-fsdevel+bounces-10401-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 862D084AB07
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 01:14:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA2441C23E32
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 00:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48764539A;
	Tue,  6 Feb 2024 00:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smile-fr.20230601.gappssmtp.com header.i=@smile-fr.20230601.gappssmtp.com header.b="rgV6cLJB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B227C3FC7
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Feb 2024 00:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707178437; cv=none; b=nsW2nEYb/RcFoavFmdTFv7nga/vKC1PStKSYhZN1P19g84WZudrM3nRUunwHPOK/OmFMoIn0PSe/QA17EeRtp2ZqsmWrwIVdjrcqNwwVGTYJ2KCORRsBEoAjcVCpN2pErFAxV+WYha1rxjSiqHhW3pYJt1K4zYtfqFHhFTKdH1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707178437; c=relaxed/simple;
	bh=BvD7KT+7ul13q1wVJvqPxQDUSv1WiR9wKCxQbbEr318=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZnKuDvKPdUdMuoscoEw7bPoWWU6dPtE6Uff1JMDgbqZf6OKWRcG0eX7BKX9VYdKVWrSxMiHoyGXTJnY7zSazUdogylrKLq16wExlMQ+eNc9bv4/ByFlynomMU5/Vt8PrqAVOc5I6BwNohlwas0bKyB7atNuenZSGL7LJMKCuFh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smile.fr; spf=pass smtp.mailfrom=smile.fr; dkim=pass (2048-bit key) header.d=smile-fr.20230601.gappssmtp.com header.i=@smile-fr.20230601.gappssmtp.com header.b=rgV6cLJB; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smile.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smile.fr
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40fe2e746bdso229935e9.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 05 Feb 2024 16:13:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile-fr.20230601.gappssmtp.com; s=20230601; t=1707178434; x=1707783234; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sFNpFi093TpETZs6mdYZEjtXAaH8xI625rElwAZwslo=;
        b=rgV6cLJB9BmJCHfqJ7i6XQ1wFQ3K/bhMQOZuHD0bMnpzwrZjXvrpplDfavsz1jBG1l
         nhaTW42WP5l5kiUjRYDnpH6iYluRCWnwtZcxSoxyXEuVs6RUBlKVU/uejeApAKpSrhwf
         bT63NS4n1c8yS+FTqtCrVOpA45xwRGfaCIlJUGpn2QtiyRKb5PWNII7/Em+nzFWBmCIw
         a5BGFEbIaiKe60WyONXW8QOsisCHHEDgPJgL+1iL2Elx+C7V40f5cCJ3KObisQIy9uZU
         hHaQ/YT5weS9MjgRdfY+Sf7Ki4iyMViS8GUEx9mgp9zgaRew2T/6g2il60+E+VTKrxNK
         /GOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707178434; x=1707783234;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sFNpFi093TpETZs6mdYZEjtXAaH8xI625rElwAZwslo=;
        b=Y0oghc/qhJMZpMMmxC9/FNb98ANop4S7cmA5jhYeSeDg3+wAUJyQ1BjnrDlJ0DEKUR
         I/tPAbQ51UrhpYOM29Le7ZQM/Y7KCjLBAHwFMEXiKROCmfSuWJbYf7z0yf7AoIAUDCUy
         goe/TltiWSc0IhyXYK559LFFg5IOBfVKaZaXOB/2oypHWBJ0VJqln82kfr8vGkMJ/ZHn
         nStWtBW+aAIHo2ZleepT6gEXwFGhienvjyo5X2q7FxT9qBdIwrx0q/SF+2yECwsrriER
         vRx/Uo/ObJ+Oa3NQ8NhFVSEsoY6Lecf4Wr9oUCwGb8fD+ZoBCjkfysywzF9BznzXPYcY
         jVcQ==
X-Gm-Message-State: AOJu0Yy9umZGnNdagXxSo8f4qqf2oUC1BJogwRGrjXgV0J17M10tDZGh
	ioga0WcSoMiBDTJrSJZi8Plp4alVimWivPfkGtr8X2WEviwxi/w/Ns4Y/HKF/y9lnkcRCVUsC+4
	Yt/W3eg==
X-Google-Smtp-Source: AGHT+IGxueG8VUZUtZseYHBtudaN2Dfg+xA2i2bfaWYL+JCkmwEsiBKAFZ4MHTohsZXzG6iymVm9Pw==
X-Received: by 2002:a05:600c:3c8a:b0:40f:de23:b8f3 with SMTP id bg10-20020a05600c3c8a00b0040fde23b8f3mr267229wmb.23.1707178433811;
        Mon, 05 Feb 2024 16:13:53 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXWwuJ25X3TFhf5cpubZjv3P0jtvVpxgluOyArwnSdlojbnQ4acGDwOCQfPrJE6Ev1XGktp7X3OjOkNEWC2yAp9QZw3MG7u7//ot52N8OQSL6BXaarM6yxmsJrfjFOBI3LuRCJQoLhrF2rRzhxobhoeFmtq3dhpWhv723aainhkH/CRmlvbt/WWnIMyJhu2dHqJPEM7SKlViiT3cT3VWECjVsyvwwQsr0IWdLi60kkUo6P+PpKO3E4VjYcSN4hyazIpoxZyCmXReAaDPECKyQZsEyLNJDNB8dJKgLzM+t5pa9SrRRMYhCwfrxj0yDZesLWim46+bNg+5wgJJsU9kWHgZ4XVQDaGeyYaYmsN8Af4GwvMaVRAukQHsY8dwK7S/lxgFTYSy7mki4cLxPv8tNnKbbbagqoToFaJcAAP4UBOx1MaBxCr8auuEfWN0sSG6BUqCf34j2LCFBtxK/RlrgdH0CJBVnVwRW1V8MaW1H86a1L5177676DURWdKISZO0/jJGyI/khY/ovy6RBZXJUDEVJ6UW2I6Kr2RiAsWiw1N+UADfzIFEVHhwUxh9lNBVRb0gpNjzlTjH1iY8ybmRwcQPK332VQ+XaL9M8yYVZRjK/U/WWgbFVA4u2SlDpSKHLSYAaO0DiNohXVm1fxdHjyKizT+v78PdmWH9Flv891/HffxvBd89gwEerzZVYqpcyK5Osv4DD2lMhkHc7VI1A6U6icC2G1Jo2szIa8SFb5s52iftg/IU9tIE0qAfElAxQS4W8WABNAun8aUexQA4+Q0C4pODpA=
Received: from P-ASN-ECS-830T8C3.local ([89.159.1.53])
        by smtp.gmail.com with ESMTPSA id b17-20020a5d40d1000000b0033ae7d768b2sm686959wrq.117.2024.02.05.16.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 16:13:53 -0800 (PST)
From: Yoann Congal <yoann.congal@smile.fr>
To: linux-fsdevel@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	x86@kernel.org
Cc: =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	Borislav Petkov <bp@alien8.de>,
	Darren Hart <dvhart@infradead.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Ingo Molnar <mingo@redhat.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	John Ogness <john.ogness@linutronix.de>,
	Josh Triplett <josh@joshtriplett.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Petr Mladek <pmladek@suse.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Yoann Congal <yoann.congal@smile.fr>
Subject: [PATCH v4 3/3] printk: Remove redundant CONFIG_BASE_FULL
Date: Tue,  6 Feb 2024 01:13:33 +0100
Message-Id: <20240206001333.1710070-4-yoann.congal@smile.fr>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240206001333.1710070-1-yoann.congal@smile.fr>
References: <20240206001333.1710070-1-yoann.congal@smile.fr>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CONFIG_BASE_FULL is equivalent to !CONFIG_BASE_SMALL and is enabled by
default: CONFIG_BASE_SMALL is the special case to take care of.
So, remove CONFIG_BASE_FULL and move the config choice to
CONFIG_BASE_SMALL (which defaults to 'n')

Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
v3->v4:
* Split "switch CONFIG_BASE_SMALL to bool" and "Remove the redundant
  config" (this patch) into two patches
* keep CONFIG_BASE_SMALL instead of CONFIG_BASE_FULL
---
 init/Kconfig | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/init/Kconfig b/init/Kconfig
index d4b16cad98502..4ecf2572d00ee 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1581,11 +1581,11 @@ config PCSPKR_PLATFORM
 	  This option allows to disable the internal PC-Speaker
 	  support, saving some memory.
 
-config BASE_FULL
-	default y
-	bool "Enable full-sized data structures for core" if EXPERT
+config BASE_SMALL
+	default n
+	bool "Enable smaller-sized data structures for core" if EXPERT
 	help
-	  Disabling this option reduces the size of miscellaneous core
+	  Enabling this option reduces the size of miscellaneous core
 	  kernel data structures. This saves memory on small machines,
 	  but may reduce performance.
 
@@ -1940,11 +1940,6 @@ config RT_MUTEXES
 	bool
 	default y if PREEMPT_RT
 
-config BASE_SMALL
-	bool
-	default y if !BASE_FULL
-	default n
-
 config MODULE_SIG_FORMAT
 	def_bool n
 	select SYSTEM_DATA_VERIFICATION
-- 
2.39.2


