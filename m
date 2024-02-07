Return-Path: <linux-fsdevel+bounces-10632-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E390984CF7C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 18:11:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A35428B9C7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 17:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BEF9839F7;
	Wed,  7 Feb 2024 17:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smile-fr.20230601.gappssmtp.com header.i=@smile-fr.20230601.gappssmtp.com header.b="JyCIYQbZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B528288A
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Feb 2024 17:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707325852; cv=none; b=mrWPmezvPtjaJVI1HsRU0TlWjwUwhGYF/N8TrbmnP0Q9Wqo4xn5y93YgNKCLLyr0lIR14II0dFqVtVrqWmu47gBnQPykr+tJEQKHLKTlX5i11DWNcKazKzNL15fpfSgVH5JRJKq/NmhW1waBKe1xrQNfWdlDryUjaCCQvIIpwUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707325852; c=relaxed/simple;
	bh=PZg3QWq+/GKgfZZA2qyqx39P/kRDLKfoOfmCw8uE3uc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=auRKWFnEWzZcwXgeTZlnyymGg26tqYFPKPwY/nK7V8MQwS5c2sCSPykpnMj74GMM4c7baNoHg0n3GSwto9Pyij5qVsSdUHSroV59B7jTGDsNeBikwxhQs1YTRQFTxyErKsW+Y01u16rfRJN53BaNqfJ0DxCNpMauMg5F/SQcwSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smile.fr; spf=pass smtp.mailfrom=smile.fr; dkim=pass (2048-bit key) header.d=smile-fr.20230601.gappssmtp.com header.i=@smile-fr.20230601.gappssmtp.com header.b=JyCIYQbZ; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smile.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smile.fr
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4101fc00832so3982645e9.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Feb 2024 09:10:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile-fr.20230601.gappssmtp.com; s=20230601; t=1707325847; x=1707930647; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JGAprqtgwfmvAPo8XwmHq4MOLLyHp0qoLOC+fnp28mc=;
        b=JyCIYQbZG3crh+1P4QYiSzc1BeeDI2f25cbQj9t9pn8weFA8c76ctON0v31zib14uj
         UIjYGm2vZo0BVTOVvW8AI5Ia1Uk0TU/p7I/RrIX/1IILeKzuGdUx2IKVlPFTCZOPmnme
         yJshfaDn79tPPU/2m6gAlWOp4vHffwxjDp/2sSh4yvbHdIzZtazmr5Rr84gOSWZKXnK5
         3kDZRq4McbOIp5IweafGlu5Sx99iuDukod63FHf8KJ9df1cQ0V99I3xyYvFCDVv109Nn
         VbxVlWXkxxVjkOefmxsPJHkWfeM3VByI5dOtQ0PLIIvE0ivD5BZuSbyS0QGZEUYmDogn
         7Z9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707325847; x=1707930647;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JGAprqtgwfmvAPo8XwmHq4MOLLyHp0qoLOC+fnp28mc=;
        b=gzoqU5r85sVXGUBn/RAANiPW1fDk7Ed6niIVf8XtEkwYdZFziXfMuuYjrmjSJWARvy
         TBTZRLzi9yN7/XI7RHtLpGXZCz4eG0ApH8m8XADAxGCjwqN+kVCBdU5vqDjj2vjDcEOB
         sM8W/Hw3tGX/V2kn5XPL/apsVOi1nsp3Gctrae0UD9L4/kIUi6yeDxjvQYgSn0tfeS65
         cvragfxXdSAsB3GSaaqQMkoc7hIaEgWSKohn7dWkW/XfOiVLhlneb/UIb5tcJ4OliBIo
         D/lWx42vrLgAqMAtgO7FD6AzIWtIANvpusWHvKdNRZ1KbT45eu1R8Ln2xRMWN7EQ1aYQ
         JaNA==
X-Gm-Message-State: AOJu0YxC/VUWOI1HyXVSrrlEBDSHYi6nTqmq3AopH1FHHlRjTKdH3iQC
	3t2Q4TTvCYJFDo9IRi/yInr+wIz68Z9ACDgdes6sl//3bso6J3XOcmmYAfCWuAbJcdF8JxjabDL
	y+PM=
X-Google-Smtp-Source: AGHT+IEP4HUse3caW9WxO2ULwF9rR3ZtBHAYEAEuRsB20KeNbbZ44lTBpuwNyZ1EZ+H0FTfcKuPYog==
X-Received: by 2002:a5d:598a:0:b0:33b:47cf:323b with SMTP id n10-20020a5d598a000000b0033b47cf323bmr5501964wri.9.1707325847517;
        Wed, 07 Feb 2024 09:10:47 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWEqlBZgcgI5parjnRecsBfl/eRmycNK81pNWgTPMfS9d0gU9ZbfNFk6VhItAGJcFz4zedSglkdiAwV/NkpH32LZn4+mdvCOVkSk3xKDFSkmOA//4E3CpwlI7Bv/q+u/R/wBi06sC58B6mzWCCa9v/uGvWFnW2Dbse2R18e6VZCIlsrz219Rz8FxnnmiEQtSulxEbCYGs2BEhM4z50qIF1LWFl6oBkDnYkIkY6civz4b5VkvzRNaom+0onifvsdvBWS1+uKLHWov3f9OEPEZsJTdX3WHAFfRnSKtxQJQzsSBgjiNJQxhT27Wd4t8eNbz+15cYKj8rsIsroajY1eZ/Q/vV4rn+5/BfBcz+7HwZFUqASVDgoUtTlTknzfDJnbXTz/c2MzKcN26UQrKucjFhvOWfZAdWC/Rga2cLX4XbABIR2hUkea4D59DfoKYrx+uJyIgQQdifyUxvNW9/8GRgQIFXf0RTo4o31uphHDKjMavVPXEMqvbdTGJ2iTR3DfmBZazF6s4afXnlv9diteyADwbbDK643fgeeMLB4x188rYPURQ88gKj0vXFsazYtITvfQI8HJ7X8O1N/LpZv1xoicOZr6qrrNhOsERZrKFLSQCxF6TDxqrvZT4M7bvX0jmGY7kgRAds13Hfsq+sbwL1aDwt2HRMunVYdElP6MennipwO6pALIkL7xYcPMHHDIGNlRAfufNNq4tY8/xLgyM0A+aw2coGmRi0NauR0hM0u4P9Cv5gBl9UoXe+926ef1hhSHyFbExYAsQBEq2udQ9j/39TWb5YKqq0wyaahO93YXX5Uql9kJod+G6U4fRmFfOQ==
Received: from P-ASN-ECS-830T8C3.idf.intranet (static-css-ccs-204145.business.bouyguestelecom.com. [176.157.204.145])
        by smtp.gmail.com with ESMTPSA id u14-20020a05600c19ce00b0040fdf2832desm2645584wmq.12.2024.02.07.09.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 09:10:46 -0800 (PST)
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
Subject: [PATCH v5 1/3] printk: Fix LOG_CPU_MAX_BUF_SHIFT when BASE_SMALL is enabled
Date: Wed,  7 Feb 2024 18:10:18 +0100
Message-Id: <20240207171020.41036-2-yoann.congal@smile.fr>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240207171020.41036-1-yoann.congal@smile.fr>
References: <20240207171020.41036-1-yoann.congal@smile.fr>
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


