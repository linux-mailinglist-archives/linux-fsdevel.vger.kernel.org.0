Return-Path: <linux-fsdevel+bounces-48422-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0EE7AAED32
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 22:43:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0797152435D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 20:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 787E928FA8F;
	Wed,  7 May 2025 20:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IAitAPop"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5BE28F952
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 May 2025 20:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746650593; cv=none; b=jkAcW/TsJvNZDYkZGU+MzgN7mAMzgFCfiMQD4C+054l3SRUtmDQV42RMcLh5vZM89qCxxoR9dtX/mtirPbJsw31Y7a4DP0UXfCwuZ7uNCRwZCveo/Ezb3K/6k99u37MLK3iGZCOF+b4e3CH69zHKQN8BXpjyOSDyLUIKTwfjx5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746650593; c=relaxed/simple;
	bh=h6eFxjInrFCmNA3dDL7Qzj6eVADZvI1uT9xKdncZxy4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y0xxjc3L493b8h3WSfTZN1sqZIXVnWUFRu9ogHbuOYiJ5Z+LkvF0stY827gD5UtzAq2wxZJpWmupfLoTPPe/J6ffG+rES1TnI9SAYUL8rCnoioCdmt/y/ArF1JUftU976DWy5adBHiEDqRnlSGEnJGaIzd56gapto/1NJNwpvRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IAitAPop; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5fbed53b421so411786a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 May 2025 13:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746650590; x=1747255390; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CXWJgZ9yWcMHC7oJQnd0pK/R9Q6jMXxuWN70bUV73gI=;
        b=IAitAPopuRNB3N3KPOIekqhw7a66bAaCK3DdPsHm31+Z7vk12Ekw/NQhzEyKQzgMb2
         D8cDraNd8+lV9I42l0cz0BGps5I/sBK0HS6XUiFnxF4IfYmmM/XdyJ6b7VY1QJq1wLJG
         yqwVZmDIIZv7Cswy+m99WBDb1+NxOrhsP4mTEjjF3rwwy2S4sPNMJm0VxbCF9zFJ13qW
         h7kMbG4Yy93+fmT+XiwZ6+VT1M60iDc8WBuztwzTA1MuFU3EHRN0KfesMLX9Xk9rMlBM
         0SVdmnvrJLYX6g7JVm96KOHYdViCwwlocgsaZezVg5bYn6l0cBkLtmMHbLcwRpfpQRRd
         Ffxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746650590; x=1747255390;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CXWJgZ9yWcMHC7oJQnd0pK/R9Q6jMXxuWN70bUV73gI=;
        b=uBUNgtlYBAQyB6kxkInVutW2vfU4MAkWsYcZtympfFPKAQ1+BbcwfxypPpF50MK0bc
         X3Z/WQD2lt+hW7iAYr/hSiWJeSRaTS7UNcrJPRTV2Bif3Tf17ua3A9gWny3NWt3nNoNT
         fFSdjlJ+fgcePs6aaNSw1L1BHAyXVDbieVNQbvpI487zYbVDTP853ac/8IRm5bU+mI07
         ABLwjTGPsx0nVR6RkENYsRQQydCIXtnD3JTykPLAMn/hdmA3cJkdAylutxYq4gL2OOjg
         jjEoa/b9wLfkEwNFt0gHrkEsUufQExpu6ZJmqQMF5bNwY6DoDJVVvZLOQqKSatj0qto9
         a1ww==
X-Forwarded-Encrypted: i=1; AJvYcCXvQ/66dg6SmwbvbvtZKJlsVKz1r7P4+lwE/0TCiSZXUG6lvI62h4l8oIQuxDfbkML/qBuyqNzP3/P6oQUg@vger.kernel.org
X-Gm-Message-State: AOJu0YxQuv3f4WcNMgpm+R4je8vmG4J7lef9KPVOy/oJ1l7NTZL1uITx
	nbSMPD3qlcN99FrdF4V2bkbyDWVA4AnEMPBqP54U2xaqT5PX4P8n
X-Gm-Gg: ASbGncvJLeaUUnSTjCcGV/CQuYWp+0tnsyVZuHU8blzMCe4d+rzB8M2zABhd0f/wLc6
	fg7P4lk6+2TmOK1bhDKOHqjkEux7uZ2ng6lOWOK90WfJJSrk5qiZJfstH5jFNNABsqubdSTf+fL
	L9eas/JghEC8n1VcXWdOWh6iNoUCA7tZQgn2bsMXDK+HId1SCNIjsq7aHkCsmSnlceqDJ07c72H
	XLc/AOcMZFQNAPSjnjkRKlwydKhQxqbDyaqrzPkxgtfLA8jewO6BF960BbTPgSSUxEZiqqaTP+C
	XitBNgQrcKjNxTUmFIgZwpTAFsDt10oG8tSE0yGJei+auxV4o05lF6bG9Uh+Hanl79BAP9gc6Fz
	IN6Iw1MxHPqmWnyiUNSAkFL6PLHkMicDM0LlcEw==
X-Google-Smtp-Source: AGHT+IERleF4YWfKNhujlvCA/kIARLF/5eG2+qrK7VZMMpGxT+6yStJXs1HmlOV7uEpJ1e6H3N7KAQ==
X-Received: by 2002:a05:6402:2111:b0:5f6:c5e3:fa98 with SMTP id 4fb4d7f45d1cf-5fc35b2fc95mr810742a12.27.1746650590098;
        Wed, 07 May 2025 13:43:10 -0700 (PDT)
Received: from amir-ThinkPad-T480.arnhem.chello.nl (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5fbfbe5c5bfsm965615a12.9.2025.05.07.13.43.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 13:43:09 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	John Hubbard <jhubbard@nvidia.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 4/5] selftests/filesystems: create get_unique_mnt_id() helper
Date: Wed,  7 May 2025 22:43:01 +0200
Message-Id: <20250507204302.460913-5-amir73il@gmail.com>
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

Add helper to utils and use it in mount-notify and statmount tests.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 .../filesystems/mount-notify/Makefile         |  3 ++
 .../mount-notify/mount-notify_test.c          | 13 ++-------
 .../selftests/filesystems/statmount/Makefile  |  3 ++
 .../filesystems/statmount/statmount_test_ns.c | 28 +++----------------
 tools/testing/selftests/filesystems/utils.c   | 20 +++++++++++++
 tools/testing/selftests/filesystems/utils.h   |  2 ++
 6 files changed, 34 insertions(+), 35 deletions(-)

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
index e553c89c5b19..9b5419e6f28d 100644
--- a/tools/testing/selftests/filesystems/utils.c
+++ b/tools/testing/selftests/filesystems/utils.c
@@ -499,3 +499,23 @@ int cap_down(cap_value_t down)
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
+		syserror("retrieving unique mount ID for %s: %s\n", path,
+			 strerror(errno));
+		return 0;
+	}
+
+	if (!(sx.stx_mask & STATX_MNT_ID_UNIQUE)) {
+		syserror("no unique mount ID available for %s\n", path);
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


