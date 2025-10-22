Return-Path: <linux-fsdevel+bounces-65087-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B62BFBBE8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 13:57:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B68E54E2828
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 11:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B56633FE0B;
	Wed, 22 Oct 2025 11:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JAfOlSCa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C40333F8C0
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Oct 2025 11:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761134231; cv=none; b=KizJax55uEMWjAn+qVlAxF3ADDGZSsH6urGlK1qGk0OUsg3h8BK4JQHB/SYYS217C74uLIS5rIGJ8L4AJ+5s9H9MA8cxCL6N6yZbQlBthfq6AHygaG/wxyicslf/10ZG0HyKBm8WIQzgbri9VI6qTZSRAnrZvGEmM44Nvb5lzaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761134231; c=relaxed/simple;
	bh=URTqzJkAAJFoQOPycXd7kEr7wppHxat1qLacnS1FCiM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sqDhVFMhVdAMjSsmYVHLeQLcqGWE2Gn+sCrFBzp4nxB2uK4SdkcE9oHUZrnANdUwmwsbsCNf+RM9LMwLU4QT9jmrx4lYsIp9JOzL2GA9t2YAI1yesHAS+Zvg70sbJhGEDR5bxmuXRu9W/ZBrBrkTwM1mc1IM2Vj1PcCsKimNkvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JAfOlSCa; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-33bafd5d2adso6198563a91.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Oct 2025 04:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761134229; x=1761739029; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WzfUG+BqfKD/coIQsN8R1l6DNO8bGUEyk6UsV4mKerM=;
        b=JAfOlSCaYsES8eqnvLfEbXJcW6WxBP77WG4g8H3pSYshm1aaV5ND0ro4E4OHDTS8+G
         Rq1Op7BFiCWw7iyrjpww+F/hdTU3cS1ZuK+Gw96SdUuaKQMLzf66XjdwCw+FqEYLKBXH
         EcX3rk5okm/EdxPgi5ml2rtgXZd5a4qweNmZeUsK29hK86xT90KSPE+//HsOmtH2+8Zd
         eOnH3x1DVi/nwETowceEGoDCpMrm1llsvcjfn3LdOUBHTAaHjMnLydTlvfu4PLes4Ldk
         7l29PpssC3+PxWGvp1rK9InHT/YmGZSebA/jPCBvo0Ly+JGO53VR4efERbXBQg8XUAHu
         Hy9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761134229; x=1761739029;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WzfUG+BqfKD/coIQsN8R1l6DNO8bGUEyk6UsV4mKerM=;
        b=q7sI6bGu8mKoD/i14euwSGs0QHp7XydB7OLFTiHHoP066mUsJUqF+KXDFh3uJofCsw
         txqAo52xbjxxI1f2kCh/+LuPCISp1W9D/vGKENmxGpqvUC5wVwnrQYrAOwKwmT8Fbn+6
         WU4gY0GXEWZSk1oLTNWwbOXm86Y50MBmlwLOMKEwCfm6QLp9fZ05jPy/Xuk3soi8O2ux
         8wuVvNJL82dtczWd3FTUh5fuaPzFwCj8sot5O+QQqo8Z+YXddGNw49DvXW60gt6Ju9av
         1Q46cJ2aR9C7QkZ1QA10//3o+9Wh9ZzrfL2vKB2k06lHV+/XZQfrvCe1ncijh87YAsL2
         tUKA==
X-Forwarded-Encrypted: i=1; AJvYcCVOgBGn+0XNx3AwAHlViOoOPP38AMYOCxBtFpCtXG484W4bCJBddOoWH4qF409/Dt2Cx/17TBFTaf/c7RCM@vger.kernel.org
X-Gm-Message-State: AOJu0YzyBuxfJSFdHwVZ0K2OgqpHHezidTnu1hX3I/FAIquyTDX/m7me
	L31tDA0wCI9YLlMijoIKtXZYhaN7wI5kKu4T4fvsl2hNafeUoYgDQiJihPUYtpDPQ2g=
X-Gm-Gg: ASbGncsIDgSzeJdO5hg5NCBzzbKPfCPGJPDvABUI9JR/dGsS+jsDzsp1UzM8u+vq/Oq
	3lW7Gy5CAKn/RQ1np12vmfRlfknFkdGMdemNPrLAuTFNTm2xGOspg46yIdMuk0ADoSbJDBrBfLU
	nvMxcrwlBDMPrpwnBchEzvKe3yISG1bssaaqFBsACPxe++MA0+ficwKOMOgiRIc391A93hfz6D9
	fYVn28arRP2MRrzrX9ZP5xFOs9yDvFCP+GHJ/KwCae205pv41v0P5Tqah6EoKNmYoxP+7QMS0cz
	YR5zMQYe5FuORueP+65Si+PFpbag6wion2W9B03tnmnjJmy70BWHzmazLpQBFyzGt+Ekb8lFiBl
	YpaVsAF73FMqyGfmI9BjH/qmX8FsUPk/tXmLbZfIIabLMLK9iOPI0ezSt4eheqeTLT8dEy9PiOC
	qvnNg7eiDCiXoD3BPvRHcxF3JknmjsUWPgcC71VxMBKrs9SSYKRg8QfjEW4A==
X-Google-Smtp-Source: AGHT+IEubD0OvI6uVVM+gnAPZHbQP3Rz7U+Y/YydXiR4UWw4SnGLju39L4qJ5sYEmZqdZYH8YZdr7g==
X-Received: by 2002:a17:90b:1dc6:b0:339:a4ef:c8b1 with SMTP id 98e67ed59e1d1-33bcf8f7802mr26421431a91.22.1761134229471;
        Wed, 22 Oct 2025 04:57:09 -0700 (PDT)
Received: from localhost ([2405:201:c00c:2854:21a:7bd8:378:3750])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33e22428b1esm2401348a91.22.2025.10.22.04.57.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 04:57:08 -0700 (PDT)
From: Naresh Kamboju <naresh.kamboju@linaro.org>
To: ltp@lists.linux.it
Cc: lkft@linaro.org,
	lkft-triage@linaro.org,
	arnd@kernel.org,
	dan.carpenter@linaro.org,
	pvorel@suse.cz,
	jack@suse.cz,
	brauner@kernel.org,
	chrubis@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	lkft-triage@lists.linaro.org,
	regressions@lists.linux.dev,
	aalbersh@kernel.org,
	arnd@arndb.de,
	viro@zeniv.linux.org.uk,
	anders.roxell@linaro.org,
	benjamin.copeland@linaro.org,
	andrea.cervesato@suse.com,
	Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: [PATCH] ioctl_pidfd05: accept both EINVAL and ENOTTY as valid errors
Date: Wed, 22 Oct 2025 17:27:04 +0530
Message-ID: <20251022115704.46936-1-naresh.kamboju@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Latest kernels return ENOTTY instead of EINVAL when invoking
ioctl(pidfd, PIDFD_GET_INFO_SHORT, info_invalid).  Update the test to
accept both EINVAL and ENOTTY as valid errors to ensure compatibility
across different kernel versions.

Link: https://lore.kernel.org/all/CA+G9fYtUp3Bk-5biynickO5U98CKKN1nkE7ooxJHp7dT1g3rxw@mail.gmail.com
Signed-off-by: Naresh Kamboju <naresh.kamboju@linaro.org>
---
 .../kernel/syscalls/ioctl/ioctl_pidfd05.c     | 20 +++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/ioctl/ioctl_pidfd05.c b/testcases/kernel/syscalls/ioctl/ioctl_pidfd05.c
index d20c6f074..ec92240a1 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_pidfd05.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_pidfd05.c
@@ -4,7 +4,7 @@
  */
 
 /*\
- * Verify that ioctl() raises an EINVAL error when PIDFD_GET_INFO is used. This
+ * Verify that ioctl() raises an EINVAL or ENOTTY error when PIDFD_GET_INFO is used. This
  * happens when:
  *
  * - info parameter is NULL
@@ -14,6 +14,7 @@
 #include "tst_test.h"
 #include "lapi/pidfd.h"
 #include "lapi/sched.h"
+#include <errno.h>
 #include "ioctl_pidfd.h"
 
 struct pidfd_info_invalid {
@@ -43,7 +44,22 @@ static void run(void)
 		exit(0);
 
 	TST_EXP_FAIL(ioctl(pidfd, PIDFD_GET_INFO, NULL), EINVAL);
-	TST_EXP_FAIL(ioctl(pidfd, PIDFD_GET_INFO_SHORT, info_invalid), EINVAL);
+	/* Expect ioctl to fail; accept either EINVAL or ENOTTY */
+	TEST(ioctl(pidfd, PIDFD_GET_INFO_SHORT, info_invalid));
+	if (TEST_RETURN == -1) {
+		if (TEST_ERRNO == EINVAL || TEST_ERRNO == ENOTTY) {
+			tst_res(TPASS,
+				"ioctl(PIDFD_GET_INFO_SHORT) failed as expected with %s",
+				tst_strerrno(TEST_ERRNO));
+		} else {
+			tst_res(TFAIL,
+				"Unexpected errno: %s (expected EINVAL or ENOTTY)",
+				tst_strerrno(TEST_ERRNO));
+		}
+	} else {
+		tst_res(TFAIL, "ioctl(PIDFD_GET_INFO_SHORT) unexpectedly succeeded");
+	}
+
 
 	SAFE_CLOSE(pidfd);
 }
-- 
2.43.0


