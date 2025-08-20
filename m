Return-Path: <linux-fsdevel+bounces-58401-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46DD6B2E473
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Aug 2025 19:56:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 931E31BA5144
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Aug 2025 17:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4965F276045;
	Wed, 20 Aug 2025 17:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bIL4sZY7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34CA0266B6B;
	Wed, 20 Aug 2025 17:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755712580; cv=none; b=Ez7bJRnhZcrFP9PtugzjHPRDu16qdAoeh5oOcE5UWooqraQFnPMB7jIo7+aV4dMg3J92+rXXEz3q5s/FhEzNqjtQRbnnJx8akjgKHv0tfBem7BE1c/nMyFdMWNcMdv8POeI9+U0eUFw3TwJUcC7N5TYnDaSNtAF69MK++azjUfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755712580; c=relaxed/simple;
	bh=OpMONjBtUOi/QSNOr/+nhfqsjkMyCFbyzjsLnThXOo0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IU/N8TFTYFy+4bQbb0wWtoj/qKIIfQUJdEAxpMz8a6J5jvA2DxCtQiehjeWYMEhpzQYHfuZI9nB2n29Iys4LxIBDekEeNue5js6OuO1cMLBDQTN8nR+3tf+EwWUr8Iy1V3o8KBwpcZq5kNd0MaBdYDJ1iJ/5mlFaHx6qqVLm3Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bIL4sZY7; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-76e2e89e89fso267730b3a.1;
        Wed, 20 Aug 2025 10:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755712578; x=1756317378; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OpkKXvg2DGMCCtE6dEYGs6b3fg4sVj3U6sdfAgSI6Qs=;
        b=bIL4sZY7nI3rbNX2phu7p59WrGGn54Th0v3RImyCczJAZ9/Mq+qnSZz33D+vtYmfsB
         +Izzk7h326YurhHh/4MT//TPnTN1snrjOoyeZHGFfDyN1buhl13AK6OafWdE0y2oUVtF
         S+IMDqoffnxmIqs076CPcXboGvyopN2VOXcKXCLC+0Y0Cy1Kt+CSS2p79O9J6yNdWk7Z
         31fxCoNqVs0rgxQZcI14Fa+1MNZ9bQli3lBMhZ359sKBwoz1thDpBSE30RblyXJl+b5y
         fF+b5i/6W3hfqJC/X67IIzX/x0NxsRu4GHa6yK4P4NcxWBPI4YEwfe7DHsdLDBM5Zcl7
         C39g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755712578; x=1756317378;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OpkKXvg2DGMCCtE6dEYGs6b3fg4sVj3U6sdfAgSI6Qs=;
        b=cP1utrahXTimWJEMepC9ZhTeUl1Syx+M7Hyq2NaXEDdCeqljenJQwyUj/tUeCrVc1t
         ESXgs/g2iwn2oLKoLMWV+P3TQOwNU/OuL9bxs/ohTb3mSRva6LpTecN9V78YphNQP5Rc
         VuZEbyH/UR1OKmjBMwX83PcJtTAQ/64NDQBBqs7Qw0YQZUsOLzVCEFgk4E7bXMipCo9z
         XdSFJgPqD3jQszRXWQzt6CnGbpblVuqBSR/4Q2fz4sdohA4uBwR2RC7SyVCeoVwHB8jA
         R0TxQP32NIschw1VLyH1L9rNgkiGcvZC+eUICk5wYqxzkl18oV2mY7ppjV9SEwxuN3J2
         ylag==
X-Forwarded-Encrypted: i=1; AJvYcCU6JzNlDdVzmiXlxggKYQFDLO+C0EhtiLKKjMhrY35eOhiIcAXfBVqUc2USTXh7NBcza+eJahzCIYyf2vW0nu0S@vger.kernel.org, AJvYcCWTdWX5550+mdV4uX20YO1SQi3lPfIis1t/GqJi4VcCsjz1QXMLxdbH5HHpduRf8tjmaAeetML7/JGbLlG+@vger.kernel.org, AJvYcCWlmlpLUZOVk1LEkMNl9GNGRSxn4sCopwBlr5eMWQx3mV4nv6FPfbXbOiRpxUxND3ntBj3uSrqEjDAJMIxD@vger.kernel.org
X-Gm-Message-State: AOJu0YwkSeeriLCdU21E9V2GokiWlTOWs9ItkSaVuXa8fuHmgfhxR3oO
	gmb3JPA5pwWoYzDlE1cHgUrYbpadkst0RHzMOGEEPHfegqa0286Ku6Ap
X-Gm-Gg: ASbGncsu0Zpjn9g2LGL0YJ0LW2G63KEyIbXQATuB7d7nAM6N0qtAdRZZQo3nZNY89IF
	2V3UOgcZ52sgrVQc/s1q6+3qVsCnOMCyLlUL6/bzKvjgwFB+Gh849rDWtJdWxoKzvm4cCjAZE1O
	KgJy564NQIWcHrJLFFe7Y4b5T659mkQSrT6QP/TYHoAUKZGsy3nc55nsPBvG0R+bmtcM1Gh20lJ
	ZJhtlWoftWLsRzMhqYQLX57GCdzbyXYy67291MpyzIcy7UKZ6c+LnmiCn3qt69kngB+VSHJwPSm
	qfG4md/XqLm1pmYMV4riZORCcwXnWhpfZ45jLSdVUY2XKRs29C2/t2P2ljpLIdUHh/8LSV1mVz3
	6a83tUzNEQlgdXsj5xL72voGA3lqZRNAnvQ==
X-Google-Smtp-Source: AGHT+IHUZKGHRdExYpj6kJNm30eqT1Ccbq83SzG1Im1hgBPAnKcFamJmgGS3Q2KZP3PJ2sZ1xLv69g==
X-Received: by 2002:a05:6a20:3945:b0:243:15b9:7796 with SMTP id adf61e73a8af0-2431b9be0eamr6362611637.58.1755712578350;
        Wed, 20 Aug 2025 10:56:18 -0700 (PDT)
Received: from server.. ([103.250.145.167])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4763fba4c2sm2826739a12.5.2025.08.20.10.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 10:56:17 -0700 (PDT)
From: Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>
To: shuah@kernel.org
Cc: surenb@google.com,
	akpm@linux-foundation.org,
	skhan@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>
Subject: [PATCH] selftests: proc: mark vsyscall strings maybe-unused
Date: Wed, 20 Aug 2025 23:26:10 +0530
Message-ID: <20250820175610.83014-1-reddybalavignesh9979@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The str_vsyscall_* constants in proc-pid-vm.c triggers
-Wunused-const-variable warnings with gcc-13.32 and clang 18.1.

Define and apply __maybe_unused locally to suppress the warnings.
No functional change

Fixes compiler warning:
warning: ‘str_vsyscall_*’ defined but not used[-Wunused-const-variable]

Signed-off-by: Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>
---
 tools/testing/selftests/proc/proc-pid-vm.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/proc/proc-pid-vm.c b/tools/testing/selftests/proc/proc-pid-vm.c
index d04685771952..978cbcb3eb11 100644
--- a/tools/testing/selftests/proc/proc-pid-vm.c
+++ b/tools/testing/selftests/proc/proc-pid-vm.c
@@ -47,6 +47,10 @@
 #include <sys/resource.h>
 #include <linux/fs.h>
 
+#ifndef __maybe_unused
+#define __maybe_unused __attribute__((__unused__))
+#endif
+
 #include "../kselftest.h"
 
 static inline long sys_execveat(int dirfd, const char *pathname, char **argv, char **envp, int flags)
@@ -218,12 +222,12 @@ static int make_exe(const uint8_t *payload, size_t len)
  * 2: vsyscall VMA is r-xp		vsyscall=emulate
  */
 static volatile int g_vsyscall;
-static const char *str_vsyscall;
+static const char *str_vsyscall __maybe_unused;
 
-static const char str_vsyscall_0[] = "";
-static const char str_vsyscall_1[] =
+static const char str_vsyscall_0[] __maybe_unused = "";
+static const char str_vsyscall_1[] __maybe_unused =
 "ffffffffff600000-ffffffffff601000 --xp 00000000 00:00 0                  [vsyscall]\n";
-static const char str_vsyscall_2[] =
+static const char str_vsyscall_2[] __maybe_unused =
 "ffffffffff600000-ffffffffff601000 r-xp 00000000 00:00 0                  [vsyscall]\n";
 
 #ifdef __x86_64__
-- 
2.43.0


