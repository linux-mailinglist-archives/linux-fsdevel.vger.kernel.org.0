Return-Path: <linux-fsdevel+bounces-48611-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9195AB1547
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 15:33:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EB674E66C8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 13:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64C1B2918FF;
	Fri,  9 May 2025 13:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DxCuQokR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D1628F52F
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 May 2025 13:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746797572; cv=none; b=NYMVjJigmPKN6m3xx9zHwcI1ZrNkU3G96JByR6OzQ7czH+F9yd3LP7zRfGAL/i1yghXqmy3i0PifYCvvJxIRNddjAd0p+nknTYoNS3mTODn3wA01+20hsbzx+sEO5VqjhZasyXuLdQiPdIvqZUugpWmUtFpsOda61iHkHdYEmMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746797572; c=relaxed/simple;
	bh=uY3nvLmpTmoLd+wM1EQmA7C5ZO1MIGmz3Y2viFA0S6I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OrAh0sG8KEHL0zTPEQxMrUB9Qy77GjX3gnysKM2DqJDTbb+OezvbIrrTZv03tmW48l3g1UwZwG0ToNMkDEW4l+gmgIj4ZTfBdbKMiyBHJEhmYhI7TktSU1Xknk/1axq1zNhNbNvTaLQ5SqYr/trYOy3E492We85MUfGYRDhWnLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DxCuQokR; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3a0b135d18eso1235316f8f.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 May 2025 06:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746797569; x=1747402369; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3fcbOpqECulF4mmNhJPhX9JN0+bpJ1Vj+lA7Wi4SSms=;
        b=DxCuQokRHuXFyJ8fpQYuYfPNbm/ByeESPUScM8q9/RfQWS6VfKKLltHgCKBuS6M68i
         0cK25xwdDOTnoF3JsLkhrw3LLrR/cB7do2ZA+V1MX0A1P8T07VSdVCp5OyIuaInFuvA/
         FMsdkS7RlsHDRopwDTrRKUqlRpfeDCUDFP1iX7O1hhVShJya9yuZOKoo5+d1w8ZZzoVW
         wwEIdgC1k8un58jU9XRN+AfM55le5OxXR1q9U2XHj+a5EGkMPAXm3Joqqk7TIN6Git9C
         o/wpgYrpFaJXTrZlXh6pIPoYTZ69AXrSFiUiQpcU2p8tNGXy3GFxjiKSAlU3qn/WPb6l
         BIkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746797569; x=1747402369;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3fcbOpqECulF4mmNhJPhX9JN0+bpJ1Vj+lA7Wi4SSms=;
        b=MVyD6/fQBH+764upAO+Aa6SDnNt3sDRPKmpNW3eYWPL1ZvFID10QnT2KyjLOB8m79s
         FlI7QjhjDgR0U3v/rf02XTUIyaW3jUwbKxebT2sP+ZihbxJnYwR7JOPH6G5NkKNLdn9p
         KvZLQtZpDfQqVgLDgPBwmtmiSQXpeqGeEzyeXGMtN71blaxuxVR6fUtxHXEnbl/gjsfK
         hBv6yz2ik0hKv6+87pNdeWxW/BGz2uJVaFXQdZDv0bqOv4uUN5VT+boBpHXfxi7q9qMK
         iXLviVa1owr8S01QJL9iuf7tS02dtyrbXoR7sIM9foJX+3oTd2qXZjGMCEKDRMLP9x7n
         2YQw==
X-Forwarded-Encrypted: i=1; AJvYcCVZKSmnwPqGETGMhV98i2OmKej0RMZY0LRK3y7Er2nFe/Tz6JOVy/tSpfb67h8JGr8aej4lLiFitxFthB24@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb79NAgYaPAPpDduyH2lWwHSOSXIGYCg+puQHjfDcSgQ+07z5L
	FzjR3AVsq3qOsdGtdovFQrr1R3yHwwX3FpcX3Ukw6WjC8oam7tw1
X-Gm-Gg: ASbGncsRepGyvHMmIpQ3MH8/VQQy1aBWEi0kHC6BWkBA2wsZaBKyrZ/bdXwu5RRML6j
	9cMSPN5aMQWLQBiUZ5F4A9OhCIpR+HezFzYp79pe/Q+1JzIN5MV/Ly0ExUiIQfWYzw2qLAOhzUT
	n9gsfFZDxsLuU4eVbchr3DWQwRdzf2396ksrDhZomAMxUifNgNWRGtq8wdfKpm2KS2oTCyPZDvL
	qL4EHA+f6LAFmjuCJ2fYRCaTbI/VYUsj0hRgeBn26aYLmRnkq9If1y/d1Gk4yj74cvVaZ59+IrI
	tsDCjIru6EVUZrMn86jbX705cbf7twoEFEcpaYG+plXVVOo83ZqF6LmE9CDV5ONsUMtpvuQ2BME
	/h0aGCQjO3XlnSDOUiF7DziuuBBBzQmNrZ8h52Q==
X-Google-Smtp-Source: AGHT+IGcXz+wsVL94waVQacTvTstIkyxrBVkCVeJ4R9e6m/JbwTNPrHeff9/thse8BQU/hQnatmX+A==
X-Received: by 2002:a05:6000:184f:b0:3a0:b8b0:4407 with SMTP id ffacd0b85a97d-3a1f643fa3dmr3099230f8f.33.1746797568889;
        Fri, 09 May 2025 06:32:48 -0700 (PDT)
Received: from amir-ThinkPad-T480.arnhem.chello.nl (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f57ddfd6sm3232899f8f.4.2025.05.09.06.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 06:32:48 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	John Hubbard <jhubbard@nvidia.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 6/8] selftests/filesystems: create get_unique_mnt_id() helper
Date: Fri,  9 May 2025 15:32:38 +0200
Message-Id: <20250509133240.529330-7-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250509133240.529330-1-amir73il@gmail.com>
References: <20250509133240.529330-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add helper to utils.c and use it in mount-notify and statmount tests.

Linking with utils.c drags in a dependecy with libcap, so add it to the
Makefile of the tests.

Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 .../filesystems/mount-notify/Makefile         |  3 ++
 .../mount-notify/mount-notify_test.c          | 13 ++-------
 .../selftests/filesystems/statmount/Makefile  |  3 ++
 .../filesystems/statmount/statmount_test_ns.c | 28 +++----------------
 tools/testing/selftests/filesystems/utils.c   | 22 +++++++++++++++
 tools/testing/selftests/filesystems/utils.h   |  2 ++
 6 files changed, 36 insertions(+), 35 deletions(-)

diff --git a/tools/testing/selftests/filesystems/mount-notify/Makefile b/tools/testing/selftests/filesystems/mount-notify/Makefile
index 41ebfe558a0a..55a2e5399e8a 100644
--- a/tools/testing/selftests/filesystems/mount-notify/Makefile
+++ b/tools/testing/selftests/filesystems/mount-notify/Makefile
@@ -1,7 +1,10 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 
 CFLAGS += -Wall -O2 -g $(KHDR_INCLUDES) $(TOOLS_INCLUDES)
+LDLIBS += -lcap
 
 TEST_GEN_PROGS := mount-notify_test
 
 include ../../lib.mk
+
+$(OUTPUT)/mount-notify_test: ../utils.c
diff --git a/tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c b/tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c
index 4f0f325379b5..63ce708d93ed 100644
--- a/tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c
+++ b/tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c
@@ -13,6 +13,7 @@
 
 #include "../../kselftest_harness.h"
 #include "../statmount/statmount.h"
+#include "../utils.h"
 
 // Needed for linux/fanotify.h
 #ifndef __kernel_fsid_t
@@ -23,16 +24,6 @@ typedef struct {
 
 #include <sys/fanotify.h>
 
-static uint64_t get_mnt_id(struct __test_metadata *const _metadata,
-			   const char *path)
-{
-	struct statx sx;
-
-	ASSERT_EQ(statx(AT_FDCWD, path, 0, STATX_MNT_ID_UNIQUE, &sx), 0);
-	ASSERT_TRUE(!!(sx.stx_mask & STATX_MNT_ID_UNIQUE));
-	return sx.stx_mnt_id;
-}
-
 static const char root_mntpoint_templ[] = "/tmp/mount-notify_test_root.XXXXXX";
 
 static const int mark_cmds[] = {
@@ -81,7 +72,7 @@ FIXTURE_SETUP(fanotify)
 
 	ASSERT_EQ(mkdir("b", 0700), 0);
 
-	self->root_id = get_mnt_id(_metadata, "/");
+	self->root_id = get_unique_mnt_id("/");
 	ASSERT_NE(self->root_id, 0);
 
 	for (i = 0; i < NUM_FAN_FDS; i++) {
diff --git a/tools/testing/selftests/filesystems/statmount/Makefile b/tools/testing/selftests/filesystems/statmount/Makefile
index 19adebfc2620..8e354fe99b44 100644
--- a/tools/testing/selftests/filesystems/statmount/Makefile
+++ b/tools/testing/selftests/filesystems/statmount/Makefile
@@ -1,7 +1,10 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 
 CFLAGS += -Wall -O2 -g $(KHDR_INCLUDES) $(TOOLS_INCLUDES)
+LDLIBS += -lcap
 
 TEST_GEN_PROGS := statmount_test statmount_test_ns listmount_test
 
 include ../../lib.mk
+
+$(OUTPUT)/statmount_test_ns: ../utils.c
diff --git a/tools/testing/selftests/filesystems/statmount/statmount_test_ns.c b/tools/testing/selftests/filesystems/statmount/statmount_test_ns.c
index 70cb0c8b21cf..375a52101d08 100644
--- a/tools/testing/selftests/filesystems/statmount/statmount_test_ns.c
+++ b/tools/testing/selftests/filesystems/statmount/statmount_test_ns.c
@@ -14,6 +14,7 @@
 #include <linux/stat.h>
 
 #include "statmount.h"
+#include "../utils.h"
 #include "../../kselftest.h"
 
 #define NSID_PASS 0
@@ -78,27 +79,6 @@ static int get_mnt_ns_id(const char *mnt_ns, uint64_t *mnt_ns_id)
 	return NSID_PASS;
 }
 
-static int get_mnt_id(const char *path, uint64_t *mnt_id)
-{
-	struct statx sx;
-	int ret;
-
-	ret = statx(AT_FDCWD, path, 0, STATX_MNT_ID_UNIQUE, &sx);
-	if (ret == -1) {
-		ksft_print_msg("retrieving unique mount ID for %s: %s\n", path,
-			       strerror(errno));
-		return NSID_ERROR;
-	}
-
-	if (!(sx.stx_mask & STATX_MNT_ID_UNIQUE)) {
-		ksft_print_msg("no unique mount ID available for %s\n", path);
-		return NSID_ERROR;
-	}
-
-	*mnt_id = sx.stx_mnt_id;
-	return NSID_PASS;
-}
-
 static int write_file(const char *path, const char *val)
 {
 	int fd = open(path, O_WRONLY);
@@ -174,9 +154,9 @@ static int _test_statmount_mnt_ns_id(void)
 	if (ret != NSID_PASS)
 		return ret;
 
-	ret = get_mnt_id("/", &root_id);
-	if (ret != NSID_PASS)
-		return ret;
+	root_id = get_unique_mnt_id("/");
+	if (!root_id)
+		return NSID_ERROR;
 
 	ret = statmount(root_id, 0, STATMOUNT_MNT_NS_ID, &sm, sizeof(sm), 0);
 	if (ret == -1) {
diff --git a/tools/testing/selftests/filesystems/utils.c b/tools/testing/selftests/filesystems/utils.c
index e553c89c5b19..5a114af822af 100644
--- a/tools/testing/selftests/filesystems/utils.c
+++ b/tools/testing/selftests/filesystems/utils.c
@@ -19,6 +19,8 @@
 #include <sys/wait.h>
 #include <sys/xattr.h>
 
+#include "../kselftest.h"
+#include "wrappers.h"
 #include "utils.h"
 
 #define MAX_USERNS_LEVEL 32
@@ -499,3 +501,23 @@ int cap_down(cap_value_t down)
 	cap_free(caps);
 	return fret;
 }
+
+uint64_t get_unique_mnt_id(const char *path)
+{
+	struct statx sx;
+	int ret;
+
+	ret = statx(AT_FDCWD, path, 0, STATX_MNT_ID_UNIQUE, &sx);
+	if (ret == -1) {
+		ksft_print_msg("retrieving unique mount ID for %s: %s\n", path,
+			 strerror(errno));
+		return 0;
+	}
+
+	if (!(sx.stx_mask & STATX_MNT_ID_UNIQUE)) {
+		ksft_print_msg("no unique mount ID available for %s\n", path);
+		return 0;
+	}
+
+	return sx.stx_mnt_id;
+}
diff --git a/tools/testing/selftests/filesystems/utils.h b/tools/testing/selftests/filesystems/utils.h
index 7f1df2a3e94c..d9cf145b321a 100644
--- a/tools/testing/selftests/filesystems/utils.h
+++ b/tools/testing/selftests/filesystems/utils.h
@@ -42,4 +42,6 @@ static inline bool switch_userns(int fd, uid_t uid, gid_t gid, bool drop_caps)
 	return true;
 }
 
+extern uint64_t get_unique_mnt_id(const char *path);
+
 #endif /* __IDMAP_UTILS_H */
-- 
2.34.1


