Return-Path: <linux-fsdevel+bounces-48419-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DEFF4AAED2E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 22:43:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D64A61B65532
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 20:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FA7928F958;
	Wed,  7 May 2025 20:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WjcHbB2O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2885328F93B
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 May 2025 20:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746650592; cv=none; b=qrJ48fG2SSWqkpD3fZNIS0NI1N9ldTnobYck5eJN2bxfO3M6Wv6QkK1s1WPKuOawCfG+IJu7svIY2zfDoOUSWXjx+OeZZTtMrZkLLXlg5Wxh2FWlZ9qiGFxzjP+oWEH2O7geL7+OtmwlYeiETDIDIBPsQeyThBG51c3JU+KYvT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746650592; c=relaxed/simple;
	bh=JVN91um+oCmmttcHqTB00OJX0Fy2iP7Tva4RozmOqJ8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KLQmcTc6pfaLmTbHtnb2sPsLhBigyw2xG2e24oLuypNl7S7ugrha3tqo7kcFbjgynDRp07U/bCB2AP0Cyf+tIvXiw/ojom3ORKllF4HDUUlEsCBR7W8JYSzFZNgSfwDBb3IK7GjbbzUPZJ3hBrVEebi0TJRDlMXHT2PX5pFwjZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WjcHbB2O; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5e5e0caa151so457465a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 May 2025 13:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746650588; x=1747255388; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EZABYtHhxBap/lEXpcOsi4xVgq2Qi4CaGA0VovTtGgw=;
        b=WjcHbB2O9db9kpKxkmpmIjIb8s+eaNGyBLCz2Gf2hoiqCu05xCP6jtPBiG99IRr0Zo
         csPmzE1NsFxWmO5D2KBlXDby72CJZQgXuYu/gue8/eDSy305PmENnBrPXIXwOlGXBKKo
         vQqkekkKfbkHO3vPqXKsegIOawbg2M4Qp8jO870GExcxCEIwTkIguZ/EjUcqx6NOzQeg
         /51R15sJgk8b4tZmUeS2hQJi/+8RiU3OUlt+oR9QIpqT03mW9TsX08byYxaMsT3HvPts
         p04mIjKgcvMgHOvdc7bbsutfph3sCqBn/sd3Z/YPQw1CeMLbxDgdXKFpsA79TvW9gbVt
         FbPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746650588; x=1747255388;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EZABYtHhxBap/lEXpcOsi4xVgq2Qi4CaGA0VovTtGgw=;
        b=rUrQycze9Tb4Ae7nDyYcFCPnyyTbp3Hez4ZYutQGq+BPBH3vwPwXohru/cwD7oieUe
         cwno3SczOWcY65RHIjrbSSBeBIeBRMfBUo5srxQ88HKmG5lJMqg0DuuYjD+KP8nBuJdp
         VChf2BJZdpndhbIO5K3u8rQ/Yi0RxouYv71gEl6LsPeUIiVNyOqkn31cXxoFRj/17x89
         Bifzm68DKrINxSFmjorvKMvRDKI7fuykQrT+6vTqnRvxNcYuSyZjWQpQkHbtaI5Uix+H
         1b1eiCTuW8OjKvAk3IBm3ZPBDqSwX2gEE+CC4fdk1X8SyIhki3Ob81FY6wzUaIbUqrav
         sYkw==
X-Forwarded-Encrypted: i=1; AJvYcCVry26R3DDsJqXXT1s18MiVyy48snU//AS3p6VDC2waC4O2rSJBmTDleLlqUG6I/QPVCFvPHqAdzgp1yHMg@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5ctchgdJLlmhO5z1UjGrOevPCNgBKZwNeYxGzDeY7IGANJf3E
	kR8QNq+Ql6OLn5xBFuMO4bve8SdThQh/VMkMBJZ+uN5xHIzsoh6q
X-Gm-Gg: ASbGncveqQldfuP75R/A//h/QQGFrlMKy5ICnRE2h/1BXua+HQtOLPJY4axspuLp/15
	ADOaaCot2OC+jqBSkHYcXWxprFbs2JS/S/lEAAsEW/Jo4ry7Q+7mJ3THoiMhXyBMru+AHQ8ijxL
	LeAG3PiiC4FTspkEWnqioBCOMnWEJ8rv+WwquF506yL/inj/SRURE0WcAlFSAiY4/wsrsfsZrOp
	wG8Pl9hOeRxzOu38tiu/A5ZdMdKhWocyX1QlJ0dJHChV/266Y1WBFn8zB0q/4/q3w3TsRVwmpcM
	wdnpn/GjkoX1BNsSztTltXkf7Newi8AF5exQRKa4GyjwWpBMlOtb5DmXGWBDgCi5Nw8GelXXblH
	sEsfUxm9/UXsEdefdEpiO7d+GRCjxM750DNyvPA==
X-Google-Smtp-Source: AGHT+IFj4+PcNtjWzpnoGat41hbD6YmYcR9FDQS8GHl8PHWM9Q0AAhgiRZI/Wpf7fT+pXbeF3uDEMw==
X-Received: by 2002:a05:6402:5251:b0:5fa:964f:b8b3 with SMTP id 4fb4d7f45d1cf-5fc35a3914fmr785356a12.25.1746650587995;
        Wed, 07 May 2025 13:43:07 -0700 (PDT)
Received: from amir-ThinkPad-T480.arnhem.chello.nl (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5fbfbe5c5bfsm965615a12.9.2025.05.07.13.43.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 13:43:07 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	John Hubbard <jhubbard@nvidia.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/5] selftests/filesystems: move wrapper.h out of overlayfs subdir
Date: Wed,  7 May 2025 22:42:58 +0200
Message-Id: <20250507204302.460913-2-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250507204302.460913-1-amir73il@gmail.com>
References: <20250507204302.460913-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is not an overlayfs specific header.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 tools/testing/selftests/filesystems/overlayfs/Makefile          | 2 +-
 tools/testing/selftests/filesystems/overlayfs/dev_in_maps.c     | 2 +-
 .../selftests/filesystems/overlayfs/set_layers_via_fds.c        | 2 +-
 tools/testing/selftests/filesystems/{overlayfs => }/wrappers.h  | 0
 tools/testing/selftests/mount_setattr/Makefile                  | 2 ++
 tools/testing/selftests/mount_setattr/mount_setattr_test.c      | 2 +-
 6 files changed, 6 insertions(+), 4 deletions(-)
 rename tools/testing/selftests/filesystems/{overlayfs => }/wrappers.h (100%)

diff --git a/tools/testing/selftests/filesystems/overlayfs/Makefile b/tools/testing/selftests/filesystems/overlayfs/Makefile
index 6c661232b3b5..d3ad4a77db9b 100644
--- a/tools/testing/selftests/filesystems/overlayfs/Makefile
+++ b/tools/testing/selftests/filesystems/overlayfs/Makefile
@@ -4,7 +4,7 @@ CFLAGS += -Wall
 CFLAGS += $(KHDR_INCLUDES)
 LDLIBS += -lcap
 
-LOCAL_HDRS += wrappers.h log.h
+LOCAL_HDRS += ../wrappers.h log.h
 
 TEST_GEN_PROGS := dev_in_maps
 TEST_GEN_PROGS += set_layers_via_fds
diff --git a/tools/testing/selftests/filesystems/overlayfs/dev_in_maps.c b/tools/testing/selftests/filesystems/overlayfs/dev_in_maps.c
index 3b796264223f..31db54b00e64 100644
--- a/tools/testing/selftests/filesystems/overlayfs/dev_in_maps.c
+++ b/tools/testing/selftests/filesystems/overlayfs/dev_in_maps.c
@@ -17,7 +17,7 @@
 
 #include "../../kselftest.h"
 #include "log.h"
-#include "wrappers.h"
+#include "../wrappers.h"
 
 static long get_file_dev_and_inode(void *addr, struct statx *stx)
 {
diff --git a/tools/testing/selftests/filesystems/overlayfs/set_layers_via_fds.c b/tools/testing/selftests/filesystems/overlayfs/set_layers_via_fds.c
index 5074e64e74a8..dc0449fa628f 100644
--- a/tools/testing/selftests/filesystems/overlayfs/set_layers_via_fds.c
+++ b/tools/testing/selftests/filesystems/overlayfs/set_layers_via_fds.c
@@ -16,7 +16,7 @@
 #include "../../pidfd/pidfd.h"
 #include "log.h"
 #include "../utils.h"
-#include "wrappers.h"
+#include "../wrappers.h"
 
 FIXTURE(set_layers_via_fds) {
 	int pidfd;
diff --git a/tools/testing/selftests/filesystems/overlayfs/wrappers.h b/tools/testing/selftests/filesystems/wrappers.h
similarity index 100%
rename from tools/testing/selftests/filesystems/overlayfs/wrappers.h
rename to tools/testing/selftests/filesystems/wrappers.h
diff --git a/tools/testing/selftests/mount_setattr/Makefile b/tools/testing/selftests/mount_setattr/Makefile
index 0c0d7b1234c1..4d4f810cdf2c 100644
--- a/tools/testing/selftests/mount_setattr/Makefile
+++ b/tools/testing/selftests/mount_setattr/Makefile
@@ -2,6 +2,8 @@
 # Makefile for mount selftests.
 CFLAGS = -g $(KHDR_INCLUDES) -Wall -O2 -pthread
 
+LOCAL_HDRS += ../filesystems/wrappers.h
+
 TEST_GEN_PROGS := mount_setattr_test
 
 include ../lib.mk
diff --git a/tools/testing/selftests/mount_setattr/mount_setattr_test.c b/tools/testing/selftests/mount_setattr/mount_setattr_test.c
index 432d9af23ab2..9e933925b3c2 100644
--- a/tools/testing/selftests/mount_setattr/mount_setattr_test.c
+++ b/tools/testing/selftests/mount_setattr/mount_setattr_test.c
@@ -20,7 +20,7 @@
 #include <stdarg.h>
 #include <linux/mount.h>
 
-#include "../filesystems/overlayfs/wrappers.h"
+#include "../filesystems/wrappers.h"
 #include "../kselftest_harness.h"
 
 #ifndef CLONE_NEWNS
-- 
2.34.1


