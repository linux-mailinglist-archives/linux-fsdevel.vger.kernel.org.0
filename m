Return-Path: <linux-fsdevel+bounces-66615-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 110C2C266CE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 18:42:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 807DA352397
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 17:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11746301707;
	Fri, 31 Oct 2025 17:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GVm4+fJH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8CB2D661C
	for <linux-fsdevel@vger.kernel.org>; Fri, 31 Oct 2025 17:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761932557; cv=none; b=V64qnM5bd/NU2funsLDX4FMH4dD9+XE1+3IJntLL7AmTu9tsXtaX8Q0VQeV/qO83fyguNGBvoLRtqtDlD8eg8NZM7F0GTmc5GCdOyXreqnnLm5kftEhTa+kB4UqjWUdQMKGqarcAQS+Tq4EhPb8M3hGXWJTwC61wjfkGsZ2qiYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761932557; c=relaxed/simple;
	bh=d1R4iL+4wvoOBAD0zobayWZrPssfeYHyl9iEv1Doqgs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hqvttPlf0Tljcifv5fb70SmX8jA7hPJuE1m6JnUIBWeGAVoxl0FP+auBa0jTu1D9U93a6cl8txoVFOyug2yY478cPBiG4LxmYLGXs/KqcW/wikeb3kidEV8Sf4AcpB/H2EvPEoWPEZH0OIG/8nkbt5MZhpc8uH+7RQTA6MUQXso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GVm4+fJH; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-47721293fd3so14844435e9.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Oct 2025 10:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761932554; x=1762537354; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q/LvF/A8PwnfUK+jfwgeT95AEzwYHe3M659qwoSt/Tk=;
        b=GVm4+fJH4xGqJgS0JGLjbndRVra8Fy6W2+MDizEaXlsZHzEfiI1CiUlhlVhHBLra47
         l5nHMuaeC8KvDybVLr5Xtr+ld3yNx2UWu06XxVI1JvT198VXHTyuuNxaKPWjlB8dkQmg
         gY+ywyAKChkvO5ZmkZmVD1jd5nalHtqiG7ZpWu29WMr0wSeESadgcxUV08N/GAQQpQmY
         DZScKLqPvHjTBl2EJUiPLkH5kZo1xh1EtN4EsrjqbVeWQZePzKs4WCumnNm/ZLd+SbCJ
         881tqlxPk9DfwQka+j02oyPZ+n/WUVtmZ0Bsrgodwpx+AJBt+Xz6xmkQ6Cc23JkKVsgP
         WLyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761932554; x=1762537354;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q/LvF/A8PwnfUK+jfwgeT95AEzwYHe3M659qwoSt/Tk=;
        b=a7LCoAX1jjBaKomEqWLwuTASRSGGqpTk+PvQw8D1v/lt6xFGLLOIm7BGYEXfEJrNc+
         q58+2CFy1nRR7YPhgIhxWoa3qC19SITIQmDy5tNRE1KkZkJrxQkPs+sP9EkqYeKQfwD2
         FBh5BmuBqZDfHfPftD1FpnG1vYP+ur+rvn3TBQtkhJpJ5WT0XjC/WS4uJ47XAGazuHn2
         muC5k98IyRJbGdWQFZZs0w6vCRCJWsxKdusXgZZ8YGte2Q7KacWRiXxdeTrjI/jvtrdg
         rSUY9/B369TcvD+thtTrZn7c7FaQyTDG6Wo4MaKW6DtWS0ad+Y3s+sprripGYDTENfwx
         qqug==
X-Forwarded-Encrypted: i=1; AJvYcCWv6q3KHjb82nSE5IEFq1vNb2HnCDZ3Y1nvFR58x97pJjFu9Aj4s8L4G9jzp2p6lwoRPVG+0fj1bh/pDMRJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yye67RJa0QVpHyO/78mNgnQXim2kifQQUxtMcow/V5IMpqCRYiV
	QK2fiGGLz7fcQ2wPTFILzjW718Bxinb2GsZB1QWMB6yzVPCL2F0hn0gR
X-Gm-Gg: ASbGnctKReu3kUEZhrR6uiLW4QTWeQf/eDV3CCYrURVlseOLLjFlbA7NpqGyA08I4Mt
	cPAEXqWt3oZVV9w7dqjZCkXmpV3xAevuQkwKUEBCh+pdLx7S1iifdiL1mHArzrEMqSPeB+O22CM
	mk/9vdZBTgOPXD+uuhu/cIZZQVKKveFcSLJH3JNUCilZHU+pVSg4VIsRIBgqk9wOJC22bV63DSc
	kw+ipmd9ODwUjbjZZsFjwKcIy/C2XSPrT4FoogQVEDNq8sfnZPg4jfVF1tNCvjjlIdixtfy4Cuo
	OcmBE3K/faTDg0Bq8swvnrW4yIYYiipGaeMM59u/7e9v082K0alwv2DqznJPirx44a2YjV72Fq2
	RIp95eIneehX3grfxQilftlhgnUSMtcpj2mdx2cfIurBwsZduU3TJ4yg86KkZKXhQ2kJK57JbbD
	ltH8RtXPClnB4fc5UIKSTrFrYuXFVAP6qXNrvHbly374m83g0gIq593v78Su0=
X-Google-Smtp-Source: AGHT+IEgGIpbEqFITIYD0jLuHMu6DCril9HILvlfeFDEOAO0cMDvZU9V83iSt7M2m7bKdOQ6MWIqbA==
X-Received: by 2002:a7b:ca54:0:b0:475:dc32:5600 with SMTP id 5b1f17b1804b1-477262e8fd6mr61275235e9.19.1761932553429;
        Fri, 31 Oct 2025 10:42:33 -0700 (PDT)
Received: from f.. (cst-prg-14-82.cust.vodafone.cz. [46.135.14.82])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4773c53eafbsm6728865e9.12.2025.10.31.10.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 10:42:32 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: torvalds@linux-foundation.org
Cc: brauner@kernel.org,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	tglx@linutronix.de,
	pfalcato@suse.de,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH 1/3] x86: fix access_ok() and valid_user_address() using wrong USER_PTR_MAX in modules
Date: Fri, 31 Oct 2025 18:42:18 +0100
Message-ID: <20251031174220.43458-2-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251031174220.43458-1-mjguzik@gmail.com>
References: <CAHk-=wjRA8G9eOPWa_Njz4NAk3gZNvdt0WAHZfn3iXfcVsmpcA@mail.gmail.com>
 <20251031174220.43458-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[real commit message will land here later]
---
 arch/x86/include/asm/uaccess_64.h | 17 +++++++++--------
 arch/x86/kernel/cpu/common.c      |  8 +++++---
 2 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/arch/x86/include/asm/uaccess_64.h b/arch/x86/include/asm/uaccess_64.h
index c8a5ae35c871..f60c0ed147c3 100644
--- a/arch/x86/include/asm/uaccess_64.h
+++ b/arch/x86/include/asm/uaccess_64.h
@@ -12,13 +12,14 @@
 #include <asm/cpufeatures.h>
 #include <asm/page.h>
 #include <asm/percpu.h>
-#include <asm/runtime-const.h>
 
-/*
- * Virtual variable: there's no actual backing store for this,
- * it can purely be used as 'runtime_const_ptr(USER_PTR_MAX)'
- */
-extern unsigned long USER_PTR_MAX;
+extern unsigned long user_ptr_max;
+#ifdef MODULE
+#define __user_ptr_max_accessor	user_ptr_max
+#else
+#include <asm/runtime-const.h>
+#define __user_ptr_max_accessor	runtime_const_ptr(user_ptr_max)
+#endif
 
 #ifdef CONFIG_ADDRESS_MASKING
 /*
@@ -54,7 +55,7 @@ static inline unsigned long __untagged_addr_remote(struct mm_struct *mm,
 #endif
 
 #define valid_user_address(x) \
-	likely((__force unsigned long)(x) <= runtime_const_ptr(USER_PTR_MAX))
+	likely((__force unsigned long)(x) <= __user_ptr_max_accessor)
 
 /*
  * Masking the user address is an alternative to a conditional
@@ -67,7 +68,7 @@ static inline void __user *mask_user_address(const void __user *ptr)
 	asm("cmp %1,%0\n\t"
 	    "cmova %1,%0"
 		:"=r" (ret)
-		:"r" (runtime_const_ptr(USER_PTR_MAX)),
+		:"r" (__user_ptr_max_accessor),
 		 "0" (ptr));
 	return ret;
 }
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 3ff9682d8bc4..f338f5e9adfc 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -78,6 +78,9 @@
 DEFINE_PER_CPU_READ_MOSTLY(struct cpuinfo_x86, cpu_info);
 EXPORT_PER_CPU_SYMBOL(cpu_info);
 
+unsigned long user_ptr_max __ro_after_init;
+EXPORT_SYMBOL(user_ptr_max);
+
 u32 elf_hwcap2 __read_mostly;
 
 /* Number of siblings per CPU package */
@@ -2575,14 +2578,13 @@ void __init arch_cpu_finalize_init(void)
 	alternative_instructions();
 
 	if (IS_ENABLED(CONFIG_X86_64)) {
-		unsigned long USER_PTR_MAX = TASK_SIZE_MAX;
-
+		user_ptr_max = TASK_SIZE_MAX;
 		/*
 		 * Enable this when LAM is gated on LASS support
 		if (cpu_feature_enabled(X86_FEATURE_LAM))
 			USER_PTR_MAX = (1ul << 63) - PAGE_SIZE;
 		 */
-		runtime_const_init(ptr, USER_PTR_MAX);
+		runtime_const_init(ptr, user_ptr_max);
 
 		/*
 		 * Make sure the first 2MB area is not mapped by huge pages
-- 
2.34.1


