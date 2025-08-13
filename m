Return-Path: <linux-fsdevel+bounces-57656-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AFBFDB24374
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 09:59:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80C8B189B1B9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 07:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 926132BE65A;
	Wed, 13 Aug 2025 07:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B4lpzykd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3F727E05E;
	Wed, 13 Aug 2025 07:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755071745; cv=none; b=V7ki9xCIOUVH0FWSizT6KJvYr8UYsIAjtbOESXYt2d5MfjXzBizOQspaFr1MzutDBG19hsbBGCTfLqiPZB2QvbmRpJwLXcfcfBvO+jFmWTCdSwIi+WWAVFolZUTXRs5g6iVCDYnoz3lDgWvPTNa5tdzSb8lhldIp7t/IhTHSo38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755071745; c=relaxed/simple;
	bh=pS2miqRqJu6SliuNL3Aogl9JqXwNbulvlXkWtz7n3B8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HRabHY9ByOEzZ+xfXLmBHjxcLq2pmA+BqqvUPv+WpeEB4j2QJqXkbaGLFoNFUY9/nTxtp2YRT6cgtphvteXdSGv+CVxQ2OHHFh9+mKQWq3DRxZ5odrwlcJV+bgT1mgdwetisrxnnTn0HhOJ5xmDsEk00uINsA2jfjZ60tjwWmM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B4lpzykd; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2403ceef461so53326785ad.3;
        Wed, 13 Aug 2025 00:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755071742; x=1755676542; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IjWZiyfW8kqrEjOnyCYEcgbjhFQfqaGl9Q8F2mFIbEs=;
        b=B4lpzykd76jj/ez5iomjEjAXtBbEyCQlJ3zZznHiSJOO4yCvHgCCZbPQRZ0n7ob595
         +zMtH4G2mF+1COOb5FWki84I0GiuzxMieIBfgZgeqem/wGd5yMKl//lnf94JOkMva+Xc
         fWzYOYGp+9n9EjGrCUlXoMqRy6rDztgeU0ynfxV0KUqbKBwoyfv9lsLej1x/25wfcEQ0
         RWpmXT2qqGLa6f2/Q3AypUxwTB1krVipxinNohiheVKuM4RdbXiJBiKMR0x3A4GGL9jb
         NdUQ3grNIqS8tiuobUl5DYhUjGGikg8I2M6cJrviTSysGXC+pd0P1jg9Gv5X6n3DGFSN
         tYZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755071742; x=1755676542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IjWZiyfW8kqrEjOnyCYEcgbjhFQfqaGl9Q8F2mFIbEs=;
        b=kKoiBvEwvIzFKRIGIhbVdr790SzQxEYW0fG0ySYvpYy3QJVMWM6rUKbmVuagBnyReg
         Wra6xCuGTBK57cWxCmwvkSin6UO+AARRUumHGijzV21UFaD9g/Lr1Zi8Cuex13r2eLwx
         Dnkiuvl57OK7mo7pvYfKwDV+uuhFbSmMs77lwSyVmzhwLUw5/cSORNQPpJIj/YBid+xT
         22N2V3mf8/G+maE2gXL+EkEUmh+5fqBZDXYq1x2shtCALR4AYlK3DRdfIUOgwYIrc9Cv
         nAoG+Ujtg33K+dEGZnODWPm/trjsxL9TxjF7eaIcaaSvzN4EER1zek5+BqgFHoVrKtRx
         LvFA==
X-Forwarded-Encrypted: i=1; AJvYcCVHp04pRXZ9s6NDlsreVEA8NQ6XOlQkJqHFzTG+zMDLcOsWHmJxqdl03J3DiHbhnHYRRnry1TYCF/394CKy@vger.kernel.org, AJvYcCWlxPULsipxY5kki3kWcbVkDrMmKGRzmyKBgz/cyTWUghN1SbnU4KVdKB1U+ldM15fNnJ6CmeUn1W9b0vEG77/C@vger.kernel.org
X-Gm-Message-State: AOJu0YzjCrOKSqcmtmYLjuvyzK48W1OoTSSWRzhqBgmezpIhsVFwcA3s
	eRnPwSRT5TsIQzQSrybdTBrkYVU9eGcuydSqqafEeB2mDpxDuK5cBjeA
X-Gm-Gg: ASbGncvH9n9Lv78FD4Fu5hOr0U3l5xkhvVjZniqZ9zKn8o0IoHR2T9lyWdkRorrtH+K
	KLQ4KGDPyjpi5X3F7anjEbCuWPCHCHxCpKOU6ovjcjbXVbWOZi+eKQvihbs/o2YAQXo9Vv5VTye
	waKfyudDeyxav/p0kxSPG4ORI3+wPeG51lWIrYQQDYW57WPRgvitI+Mxet3TWI1gjhAZyAHhF9H
	Cu2uEN7zGMPXRpPqpJZ8rqL3B3D2K1TPNpAhvngtbtG/V23DjNiR4UYn3HJDyYTAUWnN/+bBYSz
	++YIuRerxRuIbet8Ye4nID9Xelr0tbJ+tyaz1VqRZWxM79lOwIKpq6j82MCIHGUvMtkf86UbgPt
	41Ql3bdl5i5bvtpLovYOEjU3puPsPqAlhDViNDvQZ
X-Google-Smtp-Source: AGHT+IGY+MQOVSac22pVn99/1/lhxiuixWY6AOzv0wlruhIKASDKTlWht52/U3UE2vBRYD6YBGNNwA==
X-Received: by 2002:a17:903:2290:b0:243:3c4:ccaa with SMTP id d9443c01a7336-2430d0d4d45mr35350175ad.19.1755071741696;
        Wed, 13 Aug 2025 00:55:41 -0700 (PDT)
Received: from localhost ([192.19.38.250])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-241d1f0e757sm319437645ad.55.2025.08.13.00.55.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 00:55:40 -0700 (PDT)
From: Xing Guo <higuoxing@gmail.com>
To: amir73il@gmail.com
Cc: brauner@kernel.org,
	higuoxing@gmail.com,
	jack@suse.cz,
	jhubbard@nvidia.com,
	linux-fsdevel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	miklos@szeredi.hu,
	shuah@kernel.org,
	kernel test robot <oliver.sang@intel.com>
Subject: [PATCH] selftests/fs/mount-notify: Fix compilation failure.
Date: Wed, 13 Aug 2025 15:55:23 +0800
Message-ID: <20250813075523.102069-1-higuoxing@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <CAOQ4uxjJHscMEcAahVpbUDcDet7D8xa=X2rLr33femZsCy6t0A@mail.gmail.com>
References: <CAOQ4uxjJHscMEcAahVpbUDcDet7D8xa=X2rLr33femZsCy6t0A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit c6d9775c2066 ("selftests/fs/mount-notify: build with tools include
dir") introduces the struct __kernel_fsid_t to decouple dependency with
headers_install.  The commit forgets to define a macro for __kernel_fsid_t
and it will cause type re-definition issue.

Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202508110628.65069d92-lkp@intel.com
Signed-off-by: Xing Guo <higuoxing@gmail.com>
Acked-by: Amir Goldstein <amir73il@gmail.com>
---
 .../mount-notify/mount-notify_test.c           | 17 ++++++++---------
 .../mount-notify/mount-notify_test_ns.c        | 18 ++++++++----------
 2 files changed, 16 insertions(+), 19 deletions(-)

diff --git a/tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c b/tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c
index 63ce708d93ed..e4b7c2b457ee 100644
--- a/tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c
+++ b/tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c
@@ -2,6 +2,13 @@
 // Copyright (c) 2025 Miklos Szeredi <miklos@szeredi.hu>
 
 #define _GNU_SOURCE
+
+// Needed for linux/fanotify.h
+typedef struct {
+	int	val[2];
+} __kernel_fsid_t;
+#define __kernel_fsid_t __kernel_fsid_t
+
 #include <fcntl.h>
 #include <sched.h>
 #include <stdio.h>
@@ -10,20 +17,12 @@
 #include <sys/mount.h>
 #include <unistd.h>
 #include <sys/syscall.h>
+#include <sys/fanotify.h>
 
 #include "../../kselftest_harness.h"
 #include "../statmount/statmount.h"
 #include "../utils.h"
 
-// Needed for linux/fanotify.h
-#ifndef __kernel_fsid_t
-typedef struct {
-	int	val[2];
-} __kernel_fsid_t;
-#endif
-
-#include <sys/fanotify.h>
-
 static const char root_mntpoint_templ[] = "/tmp/mount-notify_test_root.XXXXXX";
 
 static const int mark_cmds[] = {
diff --git a/tools/testing/selftests/filesystems/mount-notify/mount-notify_test_ns.c b/tools/testing/selftests/filesystems/mount-notify/mount-notify_test_ns.c
index 090a5ca65004..9f57ca46e3af 100644
--- a/tools/testing/selftests/filesystems/mount-notify/mount-notify_test_ns.c
+++ b/tools/testing/selftests/filesystems/mount-notify/mount-notify_test_ns.c
@@ -2,6 +2,13 @@
 // Copyright (c) 2025 Miklos Szeredi <miklos@szeredi.hu>
 
 #define _GNU_SOURCE
+
+// Needed for linux/fanotify.h
+typedef struct {
+	int	val[2];
+} __kernel_fsid_t;
+#define __kernel_fsid_t __kernel_fsid_t
+
 #include <fcntl.h>
 #include <sched.h>
 #include <stdio.h>
@@ -10,21 +17,12 @@
 #include <sys/mount.h>
 #include <unistd.h>
 #include <sys/syscall.h>
+#include <sys/fanotify.h>
 
 #include "../../kselftest_harness.h"
-#include "../../pidfd/pidfd.h"
 #include "../statmount/statmount.h"
 #include "../utils.h"
 
-// Needed for linux/fanotify.h
-#ifndef __kernel_fsid_t
-typedef struct {
-	int	val[2];
-} __kernel_fsid_t;
-#endif
-
-#include <sys/fanotify.h>
-
 static const char root_mntpoint_templ[] = "/tmp/mount-notify_test_root.XXXXXX";
 
 static const int mark_types[] = {
-- 
2.50.1


