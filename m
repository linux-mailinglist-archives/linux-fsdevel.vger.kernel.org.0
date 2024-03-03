Return-Path: <linux-fsdevel+bounces-13402-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1FCA86F73D
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Mar 2024 22:47:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 564081F21115
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Mar 2024 21:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA1D7A707;
	Sun,  3 Mar 2024 21:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smile-fr.20230601.gappssmtp.com header.i=@smile-fr.20230601.gappssmtp.com header.b="Zl7vwCNQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30E77A70D
	for <linux-fsdevel@vger.kernel.org>; Sun,  3 Mar 2024 21:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709502438; cv=none; b=l/NYGEIoH+5hBO9pXX56/W1NPY4ccIPjyMCYMg62u3NmLU6LftWLSMPJh4Uv0ksedQ6YoFPpyzwEdg2c9GSPFUhayLzi5eTTO+bMosnDcnM4Pfb6TT8pJEYz5BXS/kL1yXUjO9uyLxfgpwTqEfdp6LZmPE3wPx8ncsc2+xBcN3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709502438; c=relaxed/simple;
	bh=Zq+5zagzhB2NHWhKHr8j9QO7mYdLe3QH2ZYtRZ8duaw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T6mKzuM3gKBCZdLw6buLEMzT2TfzbxIaAAup2Q3KicuwKcLSDjVcQ99PHXAJSh4CMEPb1AOS22uj2PLXLNJgYPaZ2xCldGyDfQanMTscICesz/EuUQ8/pQRNMwkMCtGkg5iWjbt+3Fl6vnSVGbQ1ynQgrfN/cjGIEbgVD8r0HzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smile.fr; spf=pass smtp.mailfrom=smile.fr; dkim=pass (2048-bit key) header.d=smile-fr.20230601.gappssmtp.com header.i=@smile-fr.20230601.gappssmtp.com header.b=Zl7vwCNQ; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smile.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smile.fr
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-33dcd8dec88so2386848f8f.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 03 Mar 2024 13:47:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile-fr.20230601.gappssmtp.com; s=20230601; t=1709502434; x=1710107234; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f882JABaI9Ly7gOENyYukEMkN1PY3vIfQnIQ2FnKOeM=;
        b=Zl7vwCNQy7c9a+DY4d74RRtZnIDy/ZeQtlbP5mbhA4i/TRjAWfiNrTF8JLppxHtb5c
         lvqtBBoZBFKh6WCTrMqQZwWEpuIg4wwaPr2h4N4BJ6au2N/qf/yAcIMuYr4ooIu+P0kr
         4ffG4lbT2/jU3/GE9P8xXQuLFyU1ykL5+fK6CXL333A/E34NXzqdzgCjpKY70XGnO5RG
         SposUPvsnc3Ki/H8J4zacrLUmcYbspT0B+PCzoC+CDRSmkf4cYbPJY1yQ+kZUyecxktq
         eyxSRbCgADk7Tizq/cIII13MnRYwJjww2IYEYsQRZVPhDwdKqXCJ0oloLgxbqsdQmGwB
         hQBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709502434; x=1710107234;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f882JABaI9Ly7gOENyYukEMkN1PY3vIfQnIQ2FnKOeM=;
        b=BPt/3tU87TnyaTJsXgy6oMhsZMhRvWvCMuUoeeyELJQL3LSFMFl7hU54+jgBgMwHGq
         NgJMS12Vu9TDmB2hHRJwxIo9UnJyOVtPb4TumWy//HuA4OfOoeL+gFbmjCclp5mdC7Vf
         aOJU4KYBowCXrNU2Jtl96pKgThCsgjazAOluK+ujOPpHF0ySTatRgwvoNpYtp7t6zwOY
         1OW2VL5FPem3BDil2piBj9a7jH2C3pfY9c28WzGoahUGWUt2UpUlMVEKiecZ2HiHC9e7
         SzmfKqc9Ln+gxEXo3qb/siaPQFurVTcKDXV6XbQ5wTwrts1t38VE5pMlYxXT6Yj8Z6LA
         H/2w==
X-Gm-Message-State: AOJu0YwQNBW9waRHxEiR534zSwJOPige+tMgTjt1c65g8WjADhJLBCiD
	DD1dH8E+Q2gyMvpErCwcrdZKvFKdSx6kfUf6TXGBdTBjCXZG9h/OFidWX7nDvv6/Ba/pi2bbQ+L
	CE9IlHQ==
X-Google-Smtp-Source: AGHT+IESx6M390D6dpYH+kYAnqnpNB5gV+Oyg59tLFLQGwO77v3Kgiba4g3K5zeXkeG22I+TT1+LFw==
X-Received: by 2002:a5d:6d8b:0:b0:33d:c657:6ae3 with SMTP id l11-20020a5d6d8b000000b0033dc6576ae3mr6830566wrs.7.1709502434489;
        Sun, 03 Mar 2024 13:47:14 -0800 (PST)
Received: from P-ASN-ECS-830T8C3.numericable.fr ([89.159.1.53])
        by smtp.gmail.com with ESMTPSA id bu16-20020a056000079000b0033dc3f3d689sm10525236wrb.93.2024.03.03.13.47.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Mar 2024 13:47:13 -0800 (PST)
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
Subject: [PATCH v6 1/3] printk: Fix LOG_CPU_MAX_BUF_SHIFT when BASE_SMALL is enabled
Date: Sun,  3 Mar 2024 22:46:50 +0100
Message-Id: <20240303214652.727140-2-yoann.congal@smile.fr>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240303214652.727140-1-yoann.congal@smile.fr>
References: <20240303214652.727140-1-yoann.congal@smile.fr>
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

Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Closes: https://lore.kernel.org/all/CAMuHMdWm6u1wX7efZQf=2XUAHascps76YQac6rdnQGhc8nop_Q@mail.gmail.com/
Reported-by: Vegard Nossum <vegard.nossum@oracle.com>
Closes: https://lore.kernel.org/all/f6856be8-54b7-0fa0-1d17-39632bf29ada@oracle.com/
Fixes: 4e244c10eab3 ("kconfig: remove unneeded symbol_empty variable")
Reviewed-by: Petr Mladek <pmladek@suse.com>
Reviewed-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 init/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/init/Kconfig b/init/Kconfig
index 8426d59cc634d..ad4b6f778d2bd 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -743,8 +743,8 @@ config LOG_CPU_MAX_BUF_SHIFT
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


