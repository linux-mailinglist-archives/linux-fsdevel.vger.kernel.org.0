Return-Path: <linux-fsdevel+bounces-10399-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D21084AAFF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 01:14:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 970101F25A16
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 00:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74431803;
	Tue,  6 Feb 2024 00:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smile-fr.20230601.gappssmtp.com header.i=@smile-fr.20230601.gappssmtp.com header.b="PElaE5FL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA07828EC
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Feb 2024 00:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707178435; cv=none; b=VvPo6E+F0z+p2k5UyvDiP0zh8M5bPiiaOrV1wLsAEjCGWKfRzzW274pFIVsDgpUM8FqoMohHNzedSgJesTZ2sgbAzgrPcscDDmQmGUx7RsmwY5QXpZHlJp/JPrZzggNzSgrWND+qN8J+vWY5HWB546JRnsecKf+EmiQgM0pmZRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707178435; c=relaxed/simple;
	bh=PZg3QWq+/GKgfZZA2qyqx39P/kRDLKfoOfmCw8uE3uc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KUkDIHci8eX1u8LNOp732UlvLCovbMSe93uPHa29eEhCx7hNYXNBX7LA4FESXyAu5qakZJKZPg9qDVVvaKcju/H491Qeb/Vq9jjrQpnUQqIOBp4SGu3Y660MPRJ/Nm0iDIbWvTEnX3mmLNaeCTuMQf3uR76zC/fG0KWqwA2ymXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smile.fr; spf=pass smtp.mailfrom=smile.fr; dkim=pass (2048-bit key) header.d=smile-fr.20230601.gappssmtp.com header.i=@smile-fr.20230601.gappssmtp.com header.b=PElaE5FL; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smile.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smile.fr
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-33b0e5d1e89so4000823f8f.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 05 Feb 2024 16:13:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile-fr.20230601.gappssmtp.com; s=20230601; t=1707178431; x=1707783231; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JGAprqtgwfmvAPo8XwmHq4MOLLyHp0qoLOC+fnp28mc=;
        b=PElaE5FLEeILIlVeSxLGe4wVM5aEf37u5b3k2Qcauh07I6v6rK2PfXkoxmdkooKxcN
         AZFOqSANlvjAbO5Wl4FMgfKUHAqErEbdLs0CY2M20hvIZmc/+n97TGqQ/LYvw2Pay62Z
         5AHjAM64kvfbJ5x/96v0FNbqoBPtpQv+VYijhob1gEWUYFiBg4A4qMHckPET7u2ADGXO
         uZdIyj9Q+ZClFGOvg3KBuqej2KVXvk5zd3B822rEBOhz00mcHT7tCOzKDI1zTqcT9fJa
         aR1GgriaiZOxe5iifa9EKAx5k3lfnoxAVqegvVB7EUZtnJoaVfj4Jfv/be6eRjD+h4cO
         9JiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707178431; x=1707783231;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JGAprqtgwfmvAPo8XwmHq4MOLLyHp0qoLOC+fnp28mc=;
        b=j7SlHJ+PcDrSimDb7JiIFkuoA6uDH+Oh0q1kNWnSKtY3e3HgdvZgPS6YalyFUG5Mzl
         xpNVVrBulBNYy5Dc4LJNLUDfQ5EEE0vcL4OwfasnSuDRMx7WrRvcdDB7AtrsYufe+bT1
         NYua/wNKgi6/fROstgDmvS/zmqxOiO1xsYdPsE5z6UiGg9CGnk6mAqP79bZHPrP2/viH
         /W3g7E734eDsHCEWFJJQYkYmZwRYFAY5JMZ/rS3vMcu9yEDH/LyPg5nuE/yYKkHGz6Cw
         vbZISF2yiQX/Mq1RJPFWKQtBFe9NgjAj5sowPaesLR/zXZ089kYzDS6XqGoO3cP3+xjM
         g2NQ==
X-Gm-Message-State: AOJu0Yx0+cPZvD7EdGoEveUgOWw8ZkWnmQn3QymU11tpOzn4Fyhb1LLX
	c99SlV4wLq0QmUe1Qvvl/IwN64EE1WZIeOSq7LuQ1e/A88hv617kvSN1fB00iuZakDcoxa2ucY5
	6gsGWEA==
X-Google-Smtp-Source: AGHT+IFVdveHEmqxwMT4/lrRvnliU1C6woy6CYFET1Y1uqw/pAcuN254xpaVv8itNDA24IGtf/7z3g==
X-Received: by 2002:adf:f342:0:b0:33a:ec79:f923 with SMTP id e2-20020adff342000000b0033aec79f923mr42991wrp.54.1707178431092;
        Mon, 05 Feb 2024 16:13:51 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXSkm+KM6a//GM/zt8jAHlWsL+R+s9l4YXJWg1ms9wE3bjkViT7qTUvsy7b5e5PiupkD2cg693R32UTsr918zPuNWNygjG+uFSovIBuPxd5Xm7lK2IijJ2BZaSurM3ygYbTl+DotuZr2x6cWpTPXZNLyJb8/OI1MHQRo2Ghheug212Tbf6xxTZBkpMoAylnuIwCCECEsubpc09Jntn/OM89NdVfKWA3+p/ywO1gWdanNHX05R3kPNp9tFvc0P7HnuwEixWBjJX+iR3KSUD7XUrbFN6oMuhAC3uzEUTnkocCLQNsopJ3RiUcgeCAjC+Kqf8r5ORhxmxKs6nvX94tkKsvoJZBvL/rRS2V/9fmv+rg9u0A+xpyGFNPxEGRXvm1k2Y/xAcXZMlP44j9FZESuS0up5toeSJNMu1cZJ6/ggWx7n3p/ucG/mFjYeXCAM8AJDCsccm1phCeQTjjcPlgKo4jfk6EVJN0pZK2KKJpZmK0e5EvIYQ7FjcStkmYMqz00z8dmX5YR1pth/yFfrHAIch64lGYkAIMifoFVLcviHFaJ9KHw6E8/7fATdGDugocyjUvuykyXJF8ENryYOBMe7c6lkiKGYUMDp3miQX8Mgbwqp5oTYXKV9uNa6z/ANe1VjvGnwT0u1LV02nZzE11Hl84MmT5Aqgijx05nV0MLtnPuQgUHIqcXWUnqB7AwLeIIQAhAiyDEHlmhXZRxWTsboWbiDgBZksbBHmBtpJ6eEfzTHBP6/GFSaD/6Vfh1kdSf7gQdL48+HB8FBzM2VqRr0Jj6rNqZhvXiRPeQx8rcq5C/lg/qgOf9ldIZP6Tk3z8tQ==
Received: from P-ASN-ECS-830T8C3.local ([89.159.1.53])
        by smtp.gmail.com with ESMTPSA id b17-20020a5d40d1000000b0033ae7d768b2sm686959wrq.117.2024.02.05.16.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 16:13:50 -0800 (PST)
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
	Yoann Congal <yoann.congal@smile.fr>,
	Vegard Nossum <vegard.nossum@oracle.com>
Subject: [PATCH v4 1/3] printk: Fix LOG_CPU_MAX_BUF_SHIFT when BASE_SMALL is enabled
Date: Tue,  6 Feb 2024 01:13:31 +0100
Message-Id: <20240206001333.1710070-2-yoann.congal@smile.fr>
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

LOG_CPU_MAX_BUF_SHIFT default value depends on BASE_SMALL:
  config LOG_CPU_MAX_BUF_SHIFT
  	default 12 if !BASE_SMALL
  	default 0 if BASE_SMALL
But, BASE_SMALL is a config of type int and "!BASE_SMALL" is always
evaluated to true whatever is the value of BASE_SMALL.

This patch fixes this by using the correct conditional operator for int
type : BASE_SMALL != 0.

Note: This changes CONFIG_LOG_CPU_MAX_BUF_SHIFT=12 to
CONFIG_LOG_CPU_MAX_BUF_SHIFT=0 for BASE_SMALL defconfigs, but that will
not be a big impact due to this code in kernel/printk/printk.c:
  /* by default this will only continue through for large > 64 CPUs */
  if (cpu_extra <= __LOG_BUF_LEN / 2)
          return;
Systems using CONFIG_BASE_SMALL and having 64+ CPUs should be quite
rare.

John Ogness <john.ogness@linutronix.de> (printk reviewer) wrote:
> For printk this will mean that BASE_SMALL systems were probably
> previously allocating/using the dynamic ringbuffer and now they will
> just continue to use the static ringbuffer. Which is fine and saves
> memory (as it should).

Petr Mladek <pmladek@suse.com> (printk maintainer) wrote:
> More precisely, it allocated the buffer dynamically when the sum
> of per-CPU-extra space exceeded half of the default static ring
> buffer. This happened for systems with more than 64 CPUs with
> the default config values.

Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Closes: https://lore.kernel.org/all/CAMuHMdWm6u1wX7efZQf=2XUAHascps76YQac6rdnQGhc8nop_Q@mail.gmail.com/
Reported-by: Vegard Nossum <vegard.nossum@oracle.com>
Closes: https://lore.kernel.org/all/f6856be8-54b7-0fa0-1d17-39632bf29ada@oracle.com/
Fixes: 4e244c10eab3 ("kconfig: remove unneeded symbol_empty variable")

---
v3->v4:
* Fix BASE_SMALL usage instead of switching to BASE_FULL because
  BASE_FULL will be removed in the next patches of this series.
---
 init/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/init/Kconfig b/init/Kconfig
index deda3d14135bb..d50ebd2a2ce42 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -734,8 +734,8 @@ config LOG_CPU_MAX_BUF_SHIFT
 	int "CPU kernel log buffer size contribution (13 => 8 KB, 17 => 128KB)"
 	depends on SMP
 	range 0 21
-	default 12 if !BASE_SMALL
-	default 0 if BASE_SMALL
+	default 0 if BASE_SMALL != 0
+	default 12
 	depends on PRINTK
 	help
 	  This option allows to increase the default ring buffer size
-- 
2.39.2


