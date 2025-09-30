Return-Path: <linux-fsdevel+bounces-63124-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 393D9BAE779
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Sep 2025 21:37:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35F453AAB01
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Sep 2025 19:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CE6D28725E;
	Tue, 30 Sep 2025 19:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="fVFJJfIh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6639E27FB2E
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Sep 2025 19:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759261030; cv=none; b=eRq/Kp30Ab7aR+UlfpxavNRev0fJhKp9hyDdN9OZVY6Rd7CnyOC5yGazM1YxBDEND08BozC4pWVvuxLg4+yYr9b7s/2zQ0RO3cS5dIYMV4ubwvGaqUF35Gesui7xSits7wtIKTMnUudD5r9H2jPiG/VhpjdQAS3NuJ4Tk7F70Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759261030; c=relaxed/simple;
	bh=BpAq1RYpOMPVq2tEX3JcUw+r6Z+YGUcZ52V2aBBfisc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NeXcIqaDZkhlt8f1VuJehln+A8YjieDl500vl6LluhWyCKTJ+QwQLPvqt7apXh/A6NRJ1GhXhpjRji6AOcZ6rHq/oJf7Pm3Lf4f40Y2nDVTdlqP3AcH5fj18HiXXmbxQ1snF/hfDPDncqLbWkw989uNV2Q8qlD7RNz70CkWP1yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=fVFJJfIh; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-633bca5451cso5239137d50.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Sep 2025 12:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1759261025; x=1759865825; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x9tjWzX9wJhSObP/Xn3aQNC+gtHovZDjrBuKIx0tizo=;
        b=fVFJJfIhXgSTZtOHwasxsbGXl5KzNeweQSwaFpkAYCNwPhP9Q9C3Rp7GqIRzfPF2PL
         vg8dmGDeApwTFnBXijj6GBEKXuuKarlPvDMH2lg2LRIO9d50N+AbX6byv+pbfXaotUya
         SsDb/uAanO3+3fr1GkHcIjvO0PMnyKfq3KEB8vNhEd56jc858gUbgJNeMHpf9zC/KrYL
         KK+HLnt4TLlUmTPos9KG9gCo22DV1uB2NNftFXuGlU8SlXlN0iA4bd9S6f4O1qXZqryj
         7rDPZSzuzStUE3VxUsLGTWKJuyzuMH3gY1jCxX9Kgkrl3pmuSg9jgUX5Qf2LGdIJrv7u
         jMcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759261025; x=1759865825;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x9tjWzX9wJhSObP/Xn3aQNC+gtHovZDjrBuKIx0tizo=;
        b=JvhwzJlOvGBdPOSPiYQRl0JAKzXVUB/gsYlhlOJVX/KJmNWZE04CsOSYpxQrE9QI2/
         4l9Gh7bbF33XJCJw2bFTS34QPWZxhvQTjjeh0o8CR044Jp8Zgj557JaNiciS5rvMvKbc
         vZs9mZnA5fONi+pJrpkwU+nIpLKoa2if4AZPDsE1KaKbKhp6CrRityiMZUWHj7Zh8k/Y
         BPT4KN1Z3nviIJy/yxDZR/2OplD0bkykoRwUqVVAedgfIjU0Zk71KYRdCi0Lzl+uteu5
         /m7gcMb/SJAnIOA08HLhCYlfMew2OsXMX5dpJM90KyNAV0CLow7NRDMsl1WA8LlzsDlq
         vEhQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRsaS8/V46wB+1zsQ/Wte7yqBQUPdrTaSpo/TKMFm7mUeH0/rdAjWbUwnIbM5ues/jkXswAgF+mqNLnomE@vger.kernel.org
X-Gm-Message-State: AOJu0YxxNt8j8VhiLZ4CuUXWLfqnf8tqgpfn6HfhjB3+24OJKesjWJ3B
	47qCku9d0wAZe1dqayJElEh89g3/9SseCuZVtywtYDB82aal+qSpwZUO+GvN3S6V04ACs26xFtE
	WHf3SMD4=
X-Gm-Gg: ASbGncumtT8IaoYqfqq0qKzOcjdVKjLzBUz7ZwLm43T1gTR2PglW0hPZ4OOpWi6BVj+
	4/gEVDji4+V6Nd7HE9FD7Wop8qCcKa6ceFXBD+iTH0AnSwtsJgUFCy4sVksRnTSWeLUaaAuHYVH
	bvW864IzC8J3mIRQqYMXepjEobPZelpZ37d3VAHYJEulrb21EXdVajpjQ0VXUR4tPAaI03dDXLv
	A/qVdqic0fz9l9+iMDavFgdl83klD1m03xIVhjeyvXc/JkTaQcwbHp79xHNDefExQ3acGzZ3Di+
	oBB27L0HtKXxQRGulbbH/pooPz6VwdUbfiXYFZCugorWuDKCrfjoVae7hX8kroJG1baqgvXPcLO
	u10lX5KliRG1hoSKLoESCpjX8fGvkeaZoPSfLKxyR+wDq86NpfsJPvK3+jITNWUepQze2flYI1A
	==
X-Google-Smtp-Source: AGHT+IHtOkDMk7rwkKstlzXTJlIEmtx2m5xNs3AKCWefD2Si7DSt3lGsmGP27wQZIjzLWxLk54Sh4g==
X-Received: by 2002:a53:b6c2:0:b0:637:eb5f:7400 with SMTP id 956f58d0204a3-63b6ff0f2a1mr1144307d50.26.1759261024937;
        Tue, 30 Sep 2025 12:37:04 -0700 (PDT)
Received: from system76-pc.attlocal.net ([2600:1700:6476:1430:d27f:13ff:20f:f4a3])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-637d39f36a7sm2762672d50.1.2025.09.30.12.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 12:37:03 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	linux-fsdevel@vger.kernel.org,
	pdonnell@redhat.com,
	amarkuze@redhat.com,
	Slava.Dubeyko@ibm.com,
	slava@dubeyko.com,
	vdubeyko@redhat.com
Subject: [PATCH v2] ceph: introduce Kunit based unit-tests for string operations
Date: Tue, 30 Sep 2025 12:35:31 -0700
Message-ID: <20250930193530.613337-2-slava@dubeyko.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>

This patch implements the Kunit based set of
unit tests for string operations. It checks
functionality of ceph_mds_state_name(),
ceph_session_op_name(), ceph_mds_op_name(),
ceph_cap_op_name(), ceph_lease_op_name(), and
ceph_snap_op_name().

./tools/testing/kunit/kunit.py run --kunitconfig ./fs/ceph/.kunitconfig
[11:05:53] Configuring KUnit Kernel ...
[11:05:53] Building KUnit Kernel ...
Populating config with:
$ make ARCH=um O=.kunit olddefconfig
Building with:
$ make all compile_commands.json scripts_gdb ARCH=um O=.kunit --jobs=22
[11:06:01] Starting KUnit Kernel (1/1)...
[11:06:01] ============================================================
Running tests with:
$ .kunit/linux kunit.enable=1 mem=1G console=tty kunit_shutdown=halt
[11:06:01] ================ ceph_strings (6 subtests) =================
[11:06:01] [PASSED] ceph_mds_state_name_test
[11:06:01] [PASSED] ceph_session_op_name_test
[11:06:01] [PASSED] ceph_mds_op_name_test
[11:06:01] [PASSED] ceph_cap_op_name_test
[11:06:01] [PASSED] ceph_lease_op_name_test
[11:06:01] [PASSED] ceph_snap_op_name_test
[11:06:01] ================== [PASSED] ceph_strings ===================
[11:06:01] ============================================================
[11:06:01] Testing complete. Ran 6 tests: passed: 6
[11:06:01] Elapsed time: 8.286s total, 0.002s configuring, 8.117s building, 0.128s running

v2
Fix sparse warnings in strings_test.c

sparse warnings: (new ones prefixed by >>)
>> fs/ceph/strings_test.c:102:11: sparse: sparse: symbol 'ceph_str_idx_2_mds_state' was not declared. Should it be static?
>> fs/ceph/strings_test.c:247:11: sparse: sparse: symbol 'ceph_str_idx_2_mds_op' was not declared. Should it be static?
>> fs/ceph/strings_test.c:459:11: sparse: sparse: symbol 'ceph_str_idx_2_lease_op' was not declared. Should it be static?

cc: Alex Markuze <amarkuze@redhat.com>
cc: Ilya Dryomov <idryomov@gmail.com>
cc: Ceph Development <ceph-devel@vger.kernel.org>
Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
---
 fs/ceph/.kunitconfig         |  16 +
 fs/ceph/Kconfig              |  12 +
 fs/ceph/Makefile             |   2 +
 fs/ceph/kunit_tests.h        |  30 ++
 fs/ceph/strings.c            | 381 +++++++++++++++++------
 fs/ceph/strings_test.c       | 588 +++++++++++++++++++++++++++++++++++
 include/linux/ceph/ceph_fs.h | 191 ++++++++----
 7 files changed, 1062 insertions(+), 158 deletions(-)
 create mode 100644 fs/ceph/.kunitconfig
 create mode 100644 fs/ceph/kunit_tests.h
 create mode 100644 fs/ceph/strings_test.c

diff --git a/fs/ceph/.kunitconfig b/fs/ceph/.kunitconfig
new file mode 100644
index 000000000000..f342622020a6
--- /dev/null
+++ b/fs/ceph/.kunitconfig
@@ -0,0 +1,16 @@
+CONFIG_KUNIT=y
+CONFIG_NET=y
+CONFIG_INET=y
+CONFIG_IPV6=y
+CONFIG_CRYPTO=y
+CONFIG_CRC32=y
+CONFIG_CRYPTO_AES=y
+CONFIG_CRYPTO_CBC=y
+CONFIG_CRYPTO_GCM=y
+CONFIG_CRYPTO_HMAC=y
+CONFIG_CRYPTO_SHA256=y
+CONFIG_KEYS=y
+CONFIG_NETFS_SUPPORT=y
+CONFIG_CEPH_LIB=y
+CONFIG_CEPH_FS=y
+CONFIG_CEPH_FS_KUNIT_TEST=y
diff --git a/fs/ceph/Kconfig b/fs/ceph/Kconfig
index 3e7def3d31c1..2091fa12ed26 100644
--- a/fs/ceph/Kconfig
+++ b/fs/ceph/Kconfig
@@ -50,3 +50,15 @@ config CEPH_FS_SECURITY_LABEL
 
 	  If you are not using a security module that requires using
 	  extended attributes for file security labels, say N.
+
+config CEPH_FS_KUNIT_TEST
+	tristate "KUnit tests for Ceph FS" if !KUNIT_ALL_TESTS
+	depends on CEPH_FS && KUNIT
+	default KUNIT_ALL_TESTS
+	help
+	  This builds KUnit tests for Ceph file system functions.
+
+	  For more information on KUnit and unit tests in general, please refer
+	  to the KUnit documentation in Documentation/dev-tools/kunit.
+
+	  If unsure, say N.
diff --git a/fs/ceph/Makefile b/fs/ceph/Makefile
index 1f77ca04c426..a27309c6500a 100644
--- a/fs/ceph/Makefile
+++ b/fs/ceph/Makefile
@@ -13,3 +13,5 @@ ceph-y := super.o inode.o dir.o file.o locks.o addr.o ioctl.o \
 ceph-$(CONFIG_CEPH_FSCACHE) += cache.o
 ceph-$(CONFIG_CEPH_FS_POSIX_ACL) += acl.o
 ceph-$(CONFIG_FS_ENCRYPTION) += crypto.o
+
+obj-$(CONFIG_CEPH_FS_KUNIT_TEST) += strings_test.o
diff --git a/fs/ceph/kunit_tests.h b/fs/ceph/kunit_tests.h
new file mode 100644
index 000000000000..73a83e570e0a
--- /dev/null
+++ b/fs/ceph/kunit_tests.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * KUnit tests declarations
+ *
+ * Copyright (C) 2025, IBM Corporation
+ *
+ * Author: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
+ */
+
+#ifndef _CEPH_KUNIT_TESTS_H
+#define _CEPH_KUNIT_TESTS_H
+
+#include <kunit/visibility.h>
+
+#if IS_ENABLED(CONFIG_KUNIT)
+int ceph_mds_state_2_str_idx(int mds_state);
+extern const char *ceph_mds_state_name_strings[];
+int ceph_session_op_2_str_idx(int op);
+extern const char *ceph_session_op_name_strings[];
+int ceph_mds_op_2_str_idx(int op);
+extern const char *ceph_mds_op_name_strings[];
+int ceph_cap_op_2_str_idx(int op);
+extern const char *ceph_cap_op_name_strings[];
+int ceph_lease_op_2_str_idx(int op);
+extern const char *ceph_lease_op_name_strings[];
+int ceph_snap_op_2_str_idx(int op);
+extern const char *ceph_snap_op_name_strings[];
+#endif
+
+#endif /* _CEPH_KUNIT_TESTS_H */
diff --git a/fs/ceph/strings.c b/fs/ceph/strings.c
index e36e8948e728..6585a8b12028 100644
--- a/fs/ceph/strings.c
+++ b/fs/ceph/strings.c
@@ -5,126 +5,319 @@
 #include <linux/module.h>
 #include <linux/ceph/types.h>
 
+#include "kunit_tests.h"
 
-const char *ceph_mds_state_name(int s)
+const char *ceph_mds_state_name_strings[] = {
+/* 0 */		"down:dne",
+/* 1 */		"down:stopped",
+/* 2 */		"up:boot",
+/* 3 */		"up:standby",
+/* 4 */		"up:standby-replay",
+/* 5 */		"up:oneshot-replay",
+/* 6 */		"up:creating",
+/* 7 */		"up:starting",
+/* 8 */		"up:replay",
+/* 9 */		"up:resolve",
+/* 10 */	"up:reconnect",
+/* 11 */	"up:rejoin",
+/* 12 */	"up:clientreplay",
+/* 13 */	"up:active",
+/* 14 */	"up:stopping",
+/* 15 */	"???"
+};
+EXPORT_SYMBOL_IF_KUNIT(ceph_mds_state_name_strings);
+
+VISIBLE_IF_KUNIT
+int ceph_mds_state_2_str_idx(int mds_state)
 {
-	switch (s) {
+	switch (mds_state) {
 		/* down and out */
-	case CEPH_MDS_STATE_DNE:        return "down:dne";
-	case CEPH_MDS_STATE_STOPPED:    return "down:stopped";
+	case CEPH_MDS_STATE_DNE:
+		return CEPH_MDS_STATE_DNE_STR_IDX;		/* 0 */
+	case CEPH_MDS_STATE_STOPPED:
+		return CEPH_MDS_STATE_STOPPED_STR_IDX;		/* 1 */
 		/* up and out */
-	case CEPH_MDS_STATE_BOOT:       return "up:boot";
-	case CEPH_MDS_STATE_STANDBY:    return "up:standby";
-	case CEPH_MDS_STATE_STANDBY_REPLAY:    return "up:standby-replay";
-	case CEPH_MDS_STATE_REPLAYONCE: return "up:oneshot-replay";
-	case CEPH_MDS_STATE_CREATING:   return "up:creating";
-	case CEPH_MDS_STATE_STARTING:   return "up:starting";
+	case CEPH_MDS_STATE_BOOT:
+		return CEPH_MDS_STATE_BOOT_STR_IDX;		/* 2 */
+	case CEPH_MDS_STATE_STANDBY:
+		return CEPH_MDS_STATE_STANDBY_STR_IDX;		/* 3 */
+	case CEPH_MDS_STATE_STANDBY_REPLAY:
+		return CEPH_MDS_STATE_CREATING_STR_IDX;		/* 4 */
+	case CEPH_MDS_STATE_REPLAYONCE:
+		return CEPH_MDS_STATE_STARTING_STR_IDX;		/* 5 */
+	case CEPH_MDS_STATE_CREATING:
+		return CEPH_MDS_STATE_STANDBY_REPLAY_STR_IDX;	/* 6 */
+	case CEPH_MDS_STATE_STARTING:
+		return CEPH_MDS_STATE_REPLAYONCE_STR_IDX;	/* 7 */
 		/* up and in */
-	case CEPH_MDS_STATE_REPLAY:     return "up:replay";
-	case CEPH_MDS_STATE_RESOLVE:    return "up:resolve";
-	case CEPH_MDS_STATE_RECONNECT:  return "up:reconnect";
-	case CEPH_MDS_STATE_REJOIN:     return "up:rejoin";
-	case CEPH_MDS_STATE_CLIENTREPLAY: return "up:clientreplay";
-	case CEPH_MDS_STATE_ACTIVE:     return "up:active";
-	case CEPH_MDS_STATE_STOPPING:   return "up:stopping";
+	case CEPH_MDS_STATE_REPLAY:
+		return CEPH_MDS_STATE_REPLAY_STR_IDX;		/* 8 */
+	case CEPH_MDS_STATE_RESOLVE:
+		return CEPH_MDS_STATE_RESOLVE_STR_IDX;		/* 9 */
+	case CEPH_MDS_STATE_RECONNECT:
+		return CEPH_MDS_STATE_RECONNECT_STR_IDX;	/* 10 */
+	case CEPH_MDS_STATE_REJOIN:
+		return CEPH_MDS_STATE_REJOIN_STR_IDX;		/* 11 */
+	case CEPH_MDS_STATE_CLIENTREPLAY:
+		return CEPH_MDS_STATE_CLIENTREPLAY_STR_IDX;	/* 12 */
+	case CEPH_MDS_STATE_ACTIVE:
+		return CEPH_MDS_STATE_ACTIVE_STR_IDX;		/* 13 */
+	case CEPH_MDS_STATE_STOPPING:
+		return CEPH_MDS_STATE_STOPPING_STR_IDX;		/* 14 */
+	default:
+		/* do nothing */
+		break;
 	}
-	return "???";
+
+	return CEPH_MDS_STATE_UNKNOWN_NAME_STR_IDX;
+}
+EXPORT_SYMBOL_IF_KUNIT(ceph_mds_state_2_str_idx);
+
+const char *ceph_mds_state_name(int s)
+{
+	return ceph_mds_state_name_strings[ceph_mds_state_2_str_idx(s)];
+}
+EXPORT_SYMBOL_IF_KUNIT(ceph_mds_state_name);
+
+const char *ceph_session_op_name_strings[] = {
+/* 0 */		"request_open",
+/* 1 */		"open",
+/* 2 */		"request_close",
+/* 3 */		"close",
+/* 4 */		"request_renewcaps",
+/* 5 */		"renewcaps",
+/* 6 */		"stale",
+/* 7 */		"recall_state",
+/* 8 */		"flushmsg",
+/* 9 */		"flushmsg_ack",
+/* 10 */	"force_ro",
+/* 11 */	"reject",
+/* 12 */	"flush_mdlog",
+/* 13 */	"???"
+};
+EXPORT_SYMBOL_IF_KUNIT(ceph_session_op_name_strings);
+
+VISIBLE_IF_KUNIT
+int ceph_session_op_2_str_idx(int op)
+{
+	if (op < CEPH_SESSION_REQUEST_OPEN ||
+	    op >= CEPH_SESSION_UNKNOWN_NAME)
+		return CEPH_SESSION_UNKNOWN_NAME;
+
+	return op;
 }
+EXPORT_SYMBOL_IF_KUNIT(ceph_session_op_2_str_idx);
 
 const char *ceph_session_op_name(int op)
+{
+	return ceph_session_op_name_strings[ceph_session_op_2_str_idx(op)];
+}
+EXPORT_SYMBOL_IF_KUNIT(ceph_session_op_name);
+
+const char *ceph_mds_op_name_strings[] = {
+/* 0 */		"lookup",
+/* 1 */		"getattr",
+/* 2 */		"lookuphash",
+/* 3 */		"lookupparent",
+/* 4 */		"lookupino",
+/* 5 */		"lookupname",
+/* 6 */		"getvxattr",
+/* 7 */		"setxattr",
+/* 8 */		"rmxattr",
+/* 9 */		"setlayou",
+/* 10 */	"setattr",
+/* 11 */	"setfilelock",
+/* 12 */	"getfilelock",
+/* 13 */	"setdirlayout",
+/* 14 */	"mknod",
+/* 15 */	"link",
+/* 16 */	"unlink",
+/* 17 */	"rename",
+/* 18 */	"mkdir",
+/* 19 */	"rmdir",
+/* 20 */	"symlink",
+/* 21 */	"create",
+/* 22 */	"open",
+/* 23 */	"readdir",
+/* 24 */	"lookupsnap",
+/* 25 */	"mksnap",
+/* 26 */	"rmsnap",
+/* 27 */	"lssnap",
+/* 28 */	"renamesnap",
+/* 29 */	"???"
+};
+EXPORT_SYMBOL_IF_KUNIT(ceph_mds_op_name_strings);
+
+VISIBLE_IF_KUNIT
+int ceph_mds_op_2_str_idx(int op)
 {
 	switch (op) {
-	case CEPH_SESSION_REQUEST_OPEN: return "request_open";
-	case CEPH_SESSION_OPEN: return "open";
-	case CEPH_SESSION_REQUEST_CLOSE: return "request_close";
-	case CEPH_SESSION_CLOSE: return "close";
-	case CEPH_SESSION_REQUEST_RENEWCAPS: return "request_renewcaps";
-	case CEPH_SESSION_RENEWCAPS: return "renewcaps";
-	case CEPH_SESSION_STALE: return "stale";
-	case CEPH_SESSION_RECALL_STATE: return "recall_state";
-	case CEPH_SESSION_FLUSHMSG: return "flushmsg";
-	case CEPH_SESSION_FLUSHMSG_ACK: return "flushmsg_ack";
-	case CEPH_SESSION_FORCE_RO: return "force_ro";
-	case CEPH_SESSION_REJECT: return "reject";
-	case CEPH_SESSION_REQUEST_FLUSH_MDLOG: return "flush_mdlog";
+	case CEPH_MDS_OP_LOOKUP:
+		return CEPH_MDS_OP_LOOKUP_STR_IDX;		/* 0 */
+	case CEPH_MDS_OP_LOOKUPHASH:
+		return CEPH_MDS_OP_LOOKUPHASH_STR_IDX;		/* 2 */
+	case CEPH_MDS_OP_LOOKUPPARENT:
+		return CEPH_MDS_OP_LOOKUPPARENT_STR_IDX;	/* 3 */
+	case CEPH_MDS_OP_LOOKUPINO:
+		return CEPH_MDS_OP_LOOKUPINO_STR_IDX;		/* 4 */
+	case CEPH_MDS_OP_LOOKUPNAME:
+		return CEPH_MDS_OP_LOOKUPNAME_STR_IDX;		/* 5 */
+	case CEPH_MDS_OP_GETATTR:
+		return CEPH_MDS_OP_GETATTR_STR_IDX;		/* 1 */
+	case CEPH_MDS_OP_GETVXATTR:
+		return CEPH_MDS_OP_GETVXATTR_STR_IDX;		/* 6 */
+	case CEPH_MDS_OP_SETXATTR:
+		return CEPH_MDS_OP_SETXATTR_STR_IDX;		/* 7 */
+	case CEPH_MDS_OP_SETATTR:
+		return CEPH_MDS_OP_SETATTR_STR_IDX;		/* 10 */
+	case CEPH_MDS_OP_RMXATTR:
+		return CEPH_MDS_OP_RMXATTR_STR_IDX;		/* 8 */
+	case CEPH_MDS_OP_SETLAYOUT:
+		return CEPH_MDS_OP_SETLAYOUT_STR_IDX;		/* 9 */
+	case CEPH_MDS_OP_SETDIRLAYOUT:
+		return CEPH_MDS_OP_SETDIRLAYOUT_STR_IDX;	/* 13 */
+	case CEPH_MDS_OP_READDIR:
+		return CEPH_MDS_OP_READDIR_STR_IDX;		/* 23 */
+	case CEPH_MDS_OP_MKNOD:
+		return CEPH_MDS_OP_MKNOD_STR_IDX;		/* 14 */
+	case CEPH_MDS_OP_LINK:
+		return CEPH_MDS_OP_LINK_STR_IDX;		/* 15 */
+	case CEPH_MDS_OP_UNLINK:
+		return CEPH_MDS_OP_UNLINK_STR_IDX;		/* 16 */
+	case CEPH_MDS_OP_RENAME:
+		return CEPH_MDS_OP_RENAME_STR_IDX;		/* 17 */
+	case CEPH_MDS_OP_MKDIR:
+		return CEPH_MDS_OP_MKDIR_STR_IDX;		/* 18 */
+	case CEPH_MDS_OP_RMDIR:
+		return CEPH_MDS_OP_RMDIR_STR_IDX;		/* 19 */
+	case CEPH_MDS_OP_SYMLINK:
+		return CEPH_MDS_OP_SYMLINK_STR_IDX;		/* 20 */
+	case CEPH_MDS_OP_CREATE:
+		return CEPH_MDS_OP_CREATE_STR_IDX;		/* 21 */
+	case CEPH_MDS_OP_OPEN:
+		return CEPH_MDS_OP_OPEN_STR_IDX;		/* 22 */
+	case CEPH_MDS_OP_LOOKUPSNAP:
+		return CEPH_MDS_OP_LOOKUPSNAP_STR_IDX;		/* 24 */
+	case CEPH_MDS_OP_LSSNAP:
+		return CEPH_MDS_OP_LSSNAP_STR_IDX;		/* 27 */
+	case CEPH_MDS_OP_MKSNAP:
+		return CEPH_MDS_OP_MKSNAP_STR_IDX;		/* 25 */
+	case CEPH_MDS_OP_RMSNAP:
+		return CEPH_MDS_OP_RMSNAP_STR_IDX;		/* 26 */
+	case CEPH_MDS_OP_RENAMESNAP:
+		return CEPH_MDS_OP_RENAMESNAP_STR_IDX;		/* 28 */
+	case CEPH_MDS_OP_SETFILELOCK:
+		return CEPH_MDS_OP_SETFILELOCK_STR_IDX;		/* 11 */
+	case CEPH_MDS_OP_GETFILELOCK:
+		return CEPH_MDS_OP_GETFILELOCK_STR_IDX;		/* 12 */
+	default:
+		/* do nothing */
+		break;
 	}
-	return "???";
+
+	return CEPH_MDS_OP_UNKNOWN_NAME_STR_IDX;
 }
+EXPORT_SYMBOL_IF_KUNIT(ceph_mds_op_2_str_idx);
 
 const char *ceph_mds_op_name(int op)
 {
-	switch (op) {
-	case CEPH_MDS_OP_LOOKUP:  return "lookup";
-	case CEPH_MDS_OP_LOOKUPHASH:  return "lookuphash";
-	case CEPH_MDS_OP_LOOKUPPARENT:  return "lookupparent";
-	case CEPH_MDS_OP_LOOKUPINO:  return "lookupino";
-	case CEPH_MDS_OP_LOOKUPNAME:  return "lookupname";
-	case CEPH_MDS_OP_GETATTR:  return "getattr";
-	case CEPH_MDS_OP_GETVXATTR:  return "getvxattr";
-	case CEPH_MDS_OP_SETXATTR: return "setxattr";
-	case CEPH_MDS_OP_SETATTR: return "setattr";
-	case CEPH_MDS_OP_RMXATTR: return "rmxattr";
-	case CEPH_MDS_OP_SETLAYOUT: return "setlayou";
-	case CEPH_MDS_OP_SETDIRLAYOUT: return "setdirlayout";
-	case CEPH_MDS_OP_READDIR: return "readdir";
-	case CEPH_MDS_OP_MKNOD: return "mknod";
-	case CEPH_MDS_OP_LINK: return "link";
-	case CEPH_MDS_OP_UNLINK: return "unlink";
-	case CEPH_MDS_OP_RENAME: return "rename";
-	case CEPH_MDS_OP_MKDIR: return "mkdir";
-	case CEPH_MDS_OP_RMDIR: return "rmdir";
-	case CEPH_MDS_OP_SYMLINK: return "symlink";
-	case CEPH_MDS_OP_CREATE: return "create";
-	case CEPH_MDS_OP_OPEN: return "open";
-	case CEPH_MDS_OP_LOOKUPSNAP: return "lookupsnap";
-	case CEPH_MDS_OP_LSSNAP: return "lssnap";
-	case CEPH_MDS_OP_MKSNAP: return "mksnap";
-	case CEPH_MDS_OP_RMSNAP: return "rmsnap";
-	case CEPH_MDS_OP_RENAMESNAP: return "renamesnap";
-	case CEPH_MDS_OP_SETFILELOCK: return "setfilelock";
-	case CEPH_MDS_OP_GETFILELOCK: return "getfilelock";
-	}
-	return "???";
+	return ceph_mds_op_name_strings[ceph_mds_op_2_str_idx(op)];
 }
+EXPORT_SYMBOL_IF_KUNIT(ceph_mds_op_name);
+
+const char *ceph_cap_op_name_strings[] = {
+/* 0 */		"grant",
+/* 1 */		"revoke",
+/* 2 */		"trunc",
+/* 3 */		"export",
+/* 4 */		"import",
+/* 5 */		"update",
+/* 6 */		"drop",
+/* 7 */		"flush",
+/* 8 */		"flush_ack",
+/* 9 */		"flushsnap",
+/* 10 */	"flushsnap_ack",
+/* 11 */	"release",
+/* 12 */	"renew",
+/* 13 */	"???"
+};
+EXPORT_SYMBOL_IF_KUNIT(ceph_cap_op_name_strings);
+
+VISIBLE_IF_KUNIT
+int ceph_cap_op_2_str_idx(int op)
+{
+	if (op < CEPH_CAP_OP_GRANT ||
+	    op >= CEPH_CAP_OP_UNKNOWN_NAME)
+		return CEPH_SESSION_UNKNOWN_NAME;
+
+	return op;
+}
+EXPORT_SYMBOL_IF_KUNIT(ceph_cap_op_2_str_idx);
 
 const char *ceph_cap_op_name(int op)
+{
+	return ceph_cap_op_name_strings[ceph_cap_op_2_str_idx(op)];
+}
+EXPORT_SYMBOL_IF_KUNIT(ceph_cap_op_name);
+
+const char *ceph_lease_op_name_strings[] = {
+/* 0 */		"revoke",
+/* 1 */		"release",
+/* 2 */		"renew",
+/* 3 */		"revoke_ack",
+/* 4 */		"???"
+};
+EXPORT_SYMBOL_IF_KUNIT(ceph_lease_op_name_strings);
+
+VISIBLE_IF_KUNIT
+int ceph_lease_op_2_str_idx(int op)
 {
 	switch (op) {
-	case CEPH_CAP_OP_GRANT: return "grant";
-	case CEPH_CAP_OP_REVOKE: return "revoke";
-	case CEPH_CAP_OP_TRUNC: return "trunc";
-	case CEPH_CAP_OP_EXPORT: return "export";
-	case CEPH_CAP_OP_IMPORT: return "import";
-	case CEPH_CAP_OP_UPDATE: return "update";
-	case CEPH_CAP_OP_DROP: return "drop";
-	case CEPH_CAP_OP_FLUSH: return "flush";
-	case CEPH_CAP_OP_FLUSH_ACK: return "flush_ack";
-	case CEPH_CAP_OP_FLUSHSNAP: return "flushsnap";
-	case CEPH_CAP_OP_FLUSHSNAP_ACK: return "flushsnap_ack";
-	case CEPH_CAP_OP_RELEASE: return "release";
-	case CEPH_CAP_OP_RENEW: return "renew";
+	case CEPH_MDS_LEASE_REVOKE:
+		return CEPH_MDS_LEASE_REVOKE_STR_IDX;
+	case CEPH_MDS_LEASE_RELEASE:
+		return CEPH_MDS_LEASE_RELEASE_STR_IDX;
+	case CEPH_MDS_LEASE_RENEW:
+		return CEPH_MDS_LEASE_RENEW_STR_IDX;
+	case CEPH_MDS_LEASE_REVOKE_ACK:
+		return CEPH_MDS_LEASE_REVOKE_ACK_STR_IDX;
+	default:
+		/* do nothing */
+		break;
 	}
-	return "???";
+
+	return CEPH_MDS_LEASE_UNKNOWN_NAME_STR_IDX;
 }
+EXPORT_SYMBOL_IF_KUNIT(ceph_lease_op_2_str_idx);
 
-const char *ceph_lease_op_name(int o)
+const char *ceph_lease_op_name(int op)
 {
-	switch (o) {
-	case CEPH_MDS_LEASE_REVOKE: return "revoke";
-	case CEPH_MDS_LEASE_RELEASE: return "release";
-	case CEPH_MDS_LEASE_RENEW: return "renew";
-	case CEPH_MDS_LEASE_REVOKE_ACK: return "revoke_ack";
-	}
-	return "???";
+	return ceph_lease_op_name_strings[ceph_lease_op_2_str_idx(op)];
 }
+EXPORT_SYMBOL_IF_KUNIT(ceph_lease_op_name);
 
-const char *ceph_snap_op_name(int o)
+const char *ceph_snap_op_name_strings[] = {
+/* 0 */		"update",
+/* 1 */		"create",
+/* 2 */		"destroy",
+/* 3 */		"split",
+/* 4 */		"???"
+};
+EXPORT_SYMBOL_IF_KUNIT(ceph_snap_op_name_strings);
+
+VISIBLE_IF_KUNIT
+int ceph_snap_op_2_str_idx(int op)
 {
-	switch (o) {
-	case CEPH_SNAP_OP_UPDATE: return "update";
-	case CEPH_SNAP_OP_CREATE: return "create";
-	case CEPH_SNAP_OP_DESTROY: return "destroy";
-	case CEPH_SNAP_OP_SPLIT: return "split";
-	}
-	return "???";
+	if (op < CEPH_SNAP_OP_UPDATE ||
+	    op >= CEPH_SNAP_OP_UNKNOWN_NAME)
+		return CEPH_SNAP_OP_UNKNOWN_NAME;
+
+	return op;
+}
+EXPORT_SYMBOL_IF_KUNIT(ceph_snap_op_2_str_idx);
+
+const char *ceph_snap_op_name(int op)
+{
+	return ceph_snap_op_name_strings[ceph_snap_op_2_str_idx(op)];
 }
+EXPORT_SYMBOL_IF_KUNIT(ceph_snap_op_name);
diff --git a/fs/ceph/strings_test.c b/fs/ceph/strings_test.c
new file mode 100644
index 000000000000..212871943778
--- /dev/null
+++ b/fs/ceph/strings_test.c
@@ -0,0 +1,588 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * KUnit tests for fs/ceph/strings.c
+ *
+ * Copyright (C) 2025, IBM Corporation
+ *
+ * Author: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
+ */
+
+#include <kunit/test.h>
+#include <linux/ceph/types.h>
+
+#include "kunit_tests.h"
+
+#define CEPH_KUNIT_STRINGS_TEST_RANGE		(20)
+#define CEPH_KUNIT_OP_INVALID_MIN		(-999)
+#define CEPH_KUNIT_OP_INVALID_MAX		(999)
+
+typedef int (*next_op_func)(int);
+
+struct ceph_op_iterator {
+	int start;
+	int cur;
+	int next;
+	int end;
+	next_op_func get_next_op;
+};
+
+static inline
+void ceph_op_iterator_init(struct ceph_op_iterator *iter,
+			   int start, int end,
+			   next_op_func get_next_op)
+{
+	if (!iter || !get_next_op)
+		return;
+
+	iter->start = iter->cur = start;
+	iter->end = end;
+	iter->get_next_op = get_next_op;
+	iter->next = iter->get_next_op(start);
+}
+
+static inline
+int ceph_op_iterator_next(struct ceph_op_iterator *iter)
+{
+	int threshold1, threshold2;
+
+	if (!iter)
+		return CEPH_KUNIT_OP_INVALID_MAX;
+
+	if (iter->cur >= iter->end)
+		return CEPH_KUNIT_OP_INVALID_MAX;
+
+	threshold1 = iter->start + CEPH_KUNIT_STRINGS_TEST_RANGE;
+	if (threshold1 > iter->next)
+		threshold1 = iter->next;
+
+	threshold2 = iter->next - CEPH_KUNIT_STRINGS_TEST_RANGE;
+	if (threshold2 < threshold1)
+		threshold2 = iter->next;
+
+	iter->cur++;
+
+	if (iter->cur <= threshold1)
+		goto finish_method;
+
+	if (iter->cur >= threshold2 && iter->cur <= iter->next)
+		goto finish_method;
+
+	iter->start = iter->next;
+	iter->next = iter->get_next_op(iter->start);
+
+	if (iter->start >= iter->next)
+		iter->next = iter->end;
+
+finish_method:
+	return iter->cur;
+}
+
+static inline
+bool ceph_op_iterator_valid(struct ceph_op_iterator *iter)
+{
+	if (!iter)
+		return false;
+
+	return iter->cur < iter->end;
+}
+
+static inline
+int __ceph_next_op(int prev, int lower_bound, int upper_bound)
+{
+	if (prev < lower_bound)
+		return lower_bound;
+
+	if (prev >= lower_bound && prev < upper_bound)
+		return prev + 1;
+
+	return upper_bound;
+}
+
+#define CEPH_MDS_STATE_STR_COUNT	(CEPH_MDS_STATE_UNKNOWN_NAME_STR_IDX)
+static const int ceph_str_idx_2_mds_state[CEPH_MDS_STATE_STR_COUNT] = {
+/* 0 */		CEPH_MDS_STATE_DNE,
+/* 1 */		CEPH_MDS_STATE_STOPPED,
+/* 2 */		CEPH_MDS_STATE_BOOT,
+/* 3 */		CEPH_MDS_STATE_STANDBY,
+/* 4 */		CEPH_MDS_STATE_STANDBY_REPLAY,
+/* 5 */		CEPH_MDS_STATE_REPLAYONCE,
+/* 6 */		CEPH_MDS_STATE_CREATING,
+/* 7 */		CEPH_MDS_STATE_STARTING,
+/* 8 */		CEPH_MDS_STATE_REPLAY,
+/* 9 */		CEPH_MDS_STATE_RESOLVE,
+/* 10 */	CEPH_MDS_STATE_RECONNECT,
+/* 11 */	CEPH_MDS_STATE_REJOIN,
+/* 12 */	CEPH_MDS_STATE_CLIENTREPLAY,
+/* 13 */	CEPH_MDS_STATE_ACTIVE,
+/* 14 */	CEPH_MDS_STATE_STOPPING
+};
+
+static int ceph_mds_state_next_op(int prev)
+{
+	if (prev < CEPH_MDS_STATE_REPLAYONCE)
+		return CEPH_MDS_STATE_REPLAYONCE;
+
+	/* [-9..-4] */
+	if (prev >= CEPH_MDS_STATE_REPLAYONCE &&
+	    prev < CEPH_MDS_STATE_BOOT)
+		return prev + 1;
+
+	/* [-4..-1] */
+	if (prev == CEPH_MDS_STATE_BOOT)
+		return CEPH_MDS_STATE_STOPPED;
+
+	/* [-1..0] */
+	if (prev >= CEPH_MDS_STATE_STOPPED &&
+	    prev < CEPH_MDS_STATE_DNE)
+		return prev + 1;
+
+	/* [0..8] */
+	if (prev == CEPH_MDS_STATE_DNE)
+		return CEPH_MDS_STATE_REPLAY;
+
+	/* [8..14] */
+	if (prev >= CEPH_MDS_STATE_REPLAY &&
+	    prev < CEPH_MDS_STATE_STOPPING)
+		return prev + 1;
+
+	return CEPH_MDS_STATE_STOPPING;
+}
+
+static void ceph_mds_state_name_test(struct kunit *test)
+{
+	const char *unknown_name =
+		ceph_mds_state_name_strings[CEPH_MDS_STATE_UNKNOWN_NAME_STR_IDX];
+	struct ceph_op_iterator iter;
+	int start, end;
+	int i;
+
+	/* Test valid MDS states */
+	for (i = 0; i < CEPH_MDS_STATE_STR_COUNT; i++) {
+		KUNIT_EXPECT_STREQ(test,
+			   ceph_mds_state_name(ceph_str_idx_2_mds_state[i]),
+			   ceph_mds_state_name_strings[i]);
+	}
+
+	/* Test invalid/unknown states */
+	start = CEPH_MDS_STATE_REPLAYONCE - CEPH_KUNIT_STRINGS_TEST_RANGE;
+	end = CEPH_MDS_STATE_STOPPING + CEPH_KUNIT_STRINGS_TEST_RANGE;
+	ceph_op_iterator_init(&iter, start, end, ceph_mds_state_next_op);
+
+	while (ceph_op_iterator_valid(&iter)) {
+		switch (ceph_mds_state_2_str_idx(iter.cur)) {
+		case CEPH_MDS_STATE_UNKNOWN_NAME_STR_IDX:
+			KUNIT_EXPECT_STREQ(test,
+					   ceph_mds_state_name(iter.cur),
+					   unknown_name);
+			break;
+
+		default:
+			/* do nothing */
+			break;
+		}
+
+		ceph_op_iterator_next(&iter);
+	}
+
+	KUNIT_EXPECT_STREQ(test,
+			   ceph_mds_state_name(CEPH_KUNIT_OP_INVALID_MIN),
+			   unknown_name);
+	KUNIT_EXPECT_STREQ(test,
+			   ceph_mds_state_name(CEPH_KUNIT_OP_INVALID_MAX),
+			   unknown_name);
+}
+
+static int ceph_session_next_op(int prev)
+{
+	return __ceph_next_op(prev,
+			      CEPH_SESSION_REQUEST_OPEN,
+			      CEPH_SESSION_REQUEST_FLUSH_MDLOG);
+}
+
+static void ceph_session_op_name_test(struct kunit *test)
+{
+	const char *unknown_name =
+			ceph_session_op_name_strings[CEPH_SESSION_UNKNOWN_NAME];
+	struct ceph_op_iterator iter;
+	int start, end;
+	int i;
+
+	/* Test valid session operations */
+	for (i = CEPH_SESSION_REQUEST_OPEN; i < CEPH_SESSION_UNKNOWN_NAME; i++) {
+		KUNIT_EXPECT_STREQ(test,
+				   ceph_session_op_name(i),
+				   ceph_session_op_name_strings[i]);
+	}
+
+	/* Test invalid/unknown operations */
+	start = CEPH_SESSION_REQUEST_OPEN - CEPH_KUNIT_STRINGS_TEST_RANGE;
+	end = CEPH_SESSION_REQUEST_FLUSH_MDLOG + CEPH_KUNIT_STRINGS_TEST_RANGE;
+	ceph_op_iterator_init(&iter, start, end, ceph_session_next_op);
+
+	while (ceph_op_iterator_valid(&iter)) {
+		switch (ceph_session_op_2_str_idx(iter.cur)) {
+		case CEPH_SESSION_UNKNOWN_NAME:
+			KUNIT_EXPECT_STREQ(test,
+					   ceph_session_op_name(iter.cur),
+					   unknown_name);
+			break;
+
+		default:
+			/* do nothing */
+			break;
+		}
+
+		ceph_op_iterator_next(&iter);
+	}
+
+	KUNIT_EXPECT_STREQ(test,
+			   ceph_session_op_name(CEPH_KUNIT_OP_INVALID_MIN),
+			   unknown_name);
+	KUNIT_EXPECT_STREQ(test,
+			   ceph_session_op_name(CEPH_KUNIT_OP_INVALID_MAX),
+			   unknown_name);
+}
+
+#define CEPH_MDS_OP_STR_COUNT	(CEPH_MDS_OP_UNKNOWN_NAME_STR_IDX)
+static const int ceph_str_idx_2_mds_op[CEPH_MDS_OP_STR_COUNT] = {
+/* 0 */		CEPH_MDS_OP_LOOKUP,
+/* 1 */		CEPH_MDS_OP_GETATTR,
+/* 2 */		CEPH_MDS_OP_LOOKUPHASH,
+/* 3 */		CEPH_MDS_OP_LOOKUPPARENT,
+/* 4 */		CEPH_MDS_OP_LOOKUPINO,
+/* 5 */		CEPH_MDS_OP_LOOKUPNAME,
+/* 6 */		CEPH_MDS_OP_GETVXATTR,
+/* 7 */		CEPH_MDS_OP_SETXATTR,
+/* 8 */		CEPH_MDS_OP_RMXATTR,
+/* 9 */		CEPH_MDS_OP_SETLAYOUT,
+/* 10 */	CEPH_MDS_OP_SETATTR,
+/* 11 */	CEPH_MDS_OP_SETFILELOCK,
+/* 12 */	CEPH_MDS_OP_GETFILELOCK,
+/* 13 */	CEPH_MDS_OP_SETDIRLAYOUT,
+/* 14 */	CEPH_MDS_OP_MKNOD,
+/* 15 */	CEPH_MDS_OP_LINK,
+/* 16 */	CEPH_MDS_OP_UNLINK,
+/* 17 */	CEPH_MDS_OP_RENAME,
+/* 18 */	CEPH_MDS_OP_MKDIR,
+/* 19 */	CEPH_MDS_OP_RMDIR,
+/* 20 */	CEPH_MDS_OP_SYMLINK,
+/* 21 */	CEPH_MDS_OP_CREATE,
+/* 22 */	CEPH_MDS_OP_OPEN,
+/* 23 */	CEPH_MDS_OP_READDIR,
+/* 24 */	CEPH_MDS_OP_LOOKUPSNAP,
+/* 25 */	CEPH_MDS_OP_MKSNAP,
+/* 26 */	CEPH_MDS_OP_RMSNAP,
+/* 27 */	CEPH_MDS_OP_LSSNAP,
+/* 28 */	CEPH_MDS_OP_RENAMESNAP
+};
+
+static int ceph_mds_next_op(int prev)
+{
+	if (prev < CEPH_MDS_OP_LOOKUP)
+		return CEPH_MDS_OP_LOOKUP;
+
+	/* [0x00100..0x00106] */
+	if (prev >= CEPH_MDS_OP_LOOKUP &&
+	    prev < CEPH_MDS_OP_GETVXATTR)
+		return prev + 1;
+
+	/* [0x00106..0x00110] */
+	if (prev >= CEPH_MDS_OP_GETVXATTR &&
+	    prev < CEPH_MDS_OP_GETFILELOCK)
+		return CEPH_MDS_OP_GETFILELOCK;
+
+	/* [0x00110..0x00302] */
+	if (prev >= CEPH_MDS_OP_GETFILELOCK &&
+	    prev < CEPH_MDS_OP_OPEN)
+		return CEPH_MDS_OP_OPEN;
+
+	/* [0x00302..0x00305] */
+	if (prev >= CEPH_MDS_OP_OPEN &&
+	    prev < CEPH_MDS_OP_READDIR)
+		return CEPH_MDS_OP_READDIR;
+
+	/* [0x00305..0x00400] */
+	if (prev >= CEPH_MDS_OP_READDIR &&
+	    prev < CEPH_MDS_OP_LOOKUPSNAP)
+		return CEPH_MDS_OP_LOOKUPSNAP;
+
+	/* [0x00400..0x00402] */
+	if (prev >= CEPH_MDS_OP_LOOKUPSNAP &&
+	    prev < CEPH_MDS_OP_LSSNAP)
+		return CEPH_MDS_OP_LSSNAP;
+
+	/* [0x00402..0x01105] */
+	if (prev >= CEPH_MDS_OP_LSSNAP &&
+	    prev < CEPH_MDS_OP_SETXATTR)
+		return CEPH_MDS_OP_SETXATTR;
+
+	/* [0x01105..0x0110a] */
+	if (prev >= CEPH_MDS_OP_SETXATTR &&
+	    prev < CEPH_MDS_OP_SETDIRLAYOUT)
+		return prev + 1;
+
+	/* [0x0110a..0x01201] */
+	if (prev >= CEPH_MDS_OP_SETDIRLAYOUT &&
+	    prev < CEPH_MDS_OP_MKNOD)
+		return CEPH_MDS_OP_MKNOD;
+
+	/* [0x01201..0x01204] */
+	if (prev >= CEPH_MDS_OP_MKNOD &&
+	    prev < CEPH_MDS_OP_RENAME)
+		return prev + 1;
+
+	/* [0x01204..0x01220] */
+	if (prev >= CEPH_MDS_OP_RENAME &&
+	    prev < CEPH_MDS_OP_MKDIR)
+		return CEPH_MDS_OP_MKDIR;
+
+	/* [0x01220..0x01222] */
+	if (prev >= CEPH_MDS_OP_MKDIR &&
+	    prev < CEPH_MDS_OP_SYMLINK)
+		return prev + 1;
+
+	/* [0x01222..0x01301] */
+	if (prev >= CEPH_MDS_OP_SYMLINK &&
+	    prev < CEPH_MDS_OP_CREATE)
+		return CEPH_MDS_OP_CREATE;
+
+	/* [0x01301..0x01400] */
+	if (prev >= CEPH_MDS_OP_CREATE &&
+	    prev < CEPH_MDS_OP_MKSNAP)
+		return CEPH_MDS_OP_MKSNAP;
+
+	/* [0x01400..0x01401] */
+	if (prev >= CEPH_MDS_OP_MKSNAP &&
+	    prev < CEPH_MDS_OP_RMSNAP)
+		return prev + 1;
+
+	/* [0x01401..0x01403] */
+	if (prev >= CEPH_MDS_OP_RMSNAP &&
+	    prev < CEPH_MDS_OP_RENAMESNAP)
+		return CEPH_MDS_OP_RENAMESNAP;
+
+	return CEPH_MDS_OP_RENAMESNAP;
+}
+
+static void ceph_mds_op_name_test(struct kunit *test)
+{
+	const char *unknown_name =
+		ceph_mds_op_name_strings[CEPH_MDS_OP_UNKNOWN_NAME_STR_IDX];
+	struct ceph_op_iterator iter;
+	int start, end;
+	int i;
+
+	/* Test valid MDS operations */
+	for (i = 0; i < CEPH_MDS_OP_STR_COUNT; i++) {
+		KUNIT_EXPECT_STREQ(test,
+				   ceph_mds_op_name(ceph_str_idx_2_mds_op[i]),
+				   ceph_mds_op_name_strings[i]);
+	}
+
+	/* Test invalid/unknown operations */
+	start = CEPH_MDS_OP_LOOKUP - CEPH_KUNIT_STRINGS_TEST_RANGE;
+	end = CEPH_MDS_OP_RENAMESNAP + CEPH_KUNIT_STRINGS_TEST_RANGE;
+	ceph_op_iterator_init(&iter, start, end, ceph_mds_next_op);
+
+	while (ceph_op_iterator_valid(&iter)) {
+		switch (ceph_mds_op_2_str_idx(iter.cur)) {
+		case CEPH_MDS_OP_UNKNOWN_NAME_STR_IDX:
+			KUNIT_EXPECT_STREQ(test,
+					   ceph_mds_op_name(iter.cur),
+					   unknown_name);
+			break;
+
+		default:
+			/* do nothing */
+			break;
+		}
+
+		ceph_op_iterator_next(&iter);
+	}
+
+	KUNIT_EXPECT_STREQ(test, ceph_mds_op_name(-0x99999), unknown_name);
+	KUNIT_EXPECT_STREQ(test, ceph_mds_op_name(0x99999), unknown_name);
+}
+
+static int ceph_cap_next_op(int prev)
+{
+	return __ceph_next_op(prev,
+			      CEPH_CAP_OP_GRANT,
+			      CEPH_CAP_OP_RENEW);
+}
+
+static void ceph_cap_op_name_test(struct kunit *test)
+{
+	const char *unknown_name =
+			ceph_cap_op_name_strings[CEPH_CAP_OP_UNKNOWN_NAME];
+	struct ceph_op_iterator iter;
+	int start, end;
+	int i;
+
+	/* Test valid capability operations */
+	for (i = 0; i < CEPH_CAP_OP_UNKNOWN_NAME; i++) {
+		KUNIT_EXPECT_STREQ(test,
+				   ceph_cap_op_name(i),
+				   ceph_cap_op_name_strings[i]);
+	}
+
+	/* Test invalid/unknown operations */
+	start = CEPH_CAP_OP_GRANT - CEPH_KUNIT_STRINGS_TEST_RANGE;
+	end = CEPH_CAP_OP_RENEW + CEPH_KUNIT_STRINGS_TEST_RANGE;
+	ceph_op_iterator_init(&iter, start, end, ceph_cap_next_op);
+
+	while (ceph_op_iterator_valid(&iter)) {
+		switch (ceph_cap_op_2_str_idx(iter.cur)) {
+		case CEPH_CAP_OP_UNKNOWN_NAME:
+			KUNIT_EXPECT_STREQ(test,
+					   ceph_cap_op_name(iter.cur),
+					   unknown_name);
+			break;
+
+		default:
+			/* do nothing */
+			break;
+		}
+
+		ceph_op_iterator_next(&iter);
+	}
+
+	KUNIT_EXPECT_STREQ(test,
+			   ceph_cap_op_name(CEPH_KUNIT_OP_INVALID_MIN),
+			   unknown_name);
+	KUNIT_EXPECT_STREQ(test,
+			   ceph_cap_op_name(CEPH_KUNIT_OP_INVALID_MAX),
+			   unknown_name);
+}
+
+#define CEPH_MDS_LEASE_OP_STR_COUNT	(CEPH_MDS_LEASE_UNKNOWN_NAME_STR_IDX)
+static const int ceph_str_idx_2_lease_op[CEPH_MDS_LEASE_OP_STR_COUNT] = {
+/* 0 */		CEPH_MDS_LEASE_REVOKE,
+/* 1 */		CEPH_MDS_LEASE_RELEASE,
+/* 2 */		CEPH_MDS_LEASE_RENEW,
+/* 3 */		CEPH_MDS_LEASE_REVOKE_ACK
+};
+
+static int ceph_lease_next_op(int prev)
+{
+	return __ceph_next_op(prev,
+			      CEPH_MDS_LEASE_REVOKE,
+			      CEPH_MDS_LEASE_REVOKE_ACK);
+}
+
+static void ceph_lease_op_name_test(struct kunit *test)
+{
+	const char *unknown_name =
+		ceph_lease_op_name_strings[CEPH_MDS_LEASE_UNKNOWN_NAME_STR_IDX];
+	struct ceph_op_iterator iter;
+	int start, end;
+	int i;
+
+	/* Test valid lease operations */
+	for (i = 0; i < CEPH_MDS_LEASE_OP_STR_COUNT; i++) {
+		KUNIT_EXPECT_STREQ(test,
+				   ceph_lease_op_name(ceph_str_idx_2_lease_op[i]),
+				   ceph_lease_op_name_strings[i]);
+	}
+
+	/* Test invalid/unknown operations */
+	start = CEPH_MDS_LEASE_REVOKE - CEPH_KUNIT_STRINGS_TEST_RANGE;
+	end = CEPH_MDS_LEASE_REVOKE_ACK + CEPH_KUNIT_STRINGS_TEST_RANGE;
+	ceph_op_iterator_init(&iter, start, end, ceph_lease_next_op);
+
+	while (ceph_op_iterator_valid(&iter)) {
+		switch (ceph_lease_op_2_str_idx(iter.cur)) {
+		case CEPH_MDS_LEASE_UNKNOWN_NAME_STR_IDX:
+			KUNIT_EXPECT_STREQ(test,
+					   ceph_lease_op_name(iter.cur),
+					   unknown_name);
+			break;
+
+		default:
+			/* do nothing */
+			break;
+		}
+
+		ceph_op_iterator_next(&iter);
+	}
+
+	KUNIT_EXPECT_STREQ(test,
+			   ceph_lease_op_name(CEPH_KUNIT_OP_INVALID_MIN),
+			   unknown_name);
+	KUNIT_EXPECT_STREQ(test,
+			   ceph_lease_op_name(CEPH_KUNIT_OP_INVALID_MAX),
+			   unknown_name);
+}
+
+static int ceph_snap_next_op(int prev)
+{
+	return __ceph_next_op(prev,
+			      CEPH_SNAP_OP_UPDATE,
+			      CEPH_SNAP_OP_SPLIT);
+}
+
+static void ceph_snap_op_name_test(struct kunit *test)
+{
+	const char *unknown_name =
+		ceph_snap_op_name_strings[CEPH_SNAP_OP_UNKNOWN_NAME];
+	struct ceph_op_iterator iter;
+	int start, end;
+	int i;
+
+	/* Test valid snapshot operations */
+	for (i = 0; i < CEPH_SNAP_OP_UNKNOWN_NAME; i++) {
+		KUNIT_EXPECT_STREQ(test,
+				   ceph_snap_op_name(i),
+				   ceph_snap_op_name_strings[i]);
+	}
+
+	/* Test invalid/unknown operations */
+	start = CEPH_SNAP_OP_UPDATE - CEPH_KUNIT_STRINGS_TEST_RANGE;
+	end = CEPH_SNAP_OP_SPLIT + CEPH_KUNIT_STRINGS_TEST_RANGE;
+	ceph_op_iterator_init(&iter, start, end, ceph_snap_next_op);
+
+	while (ceph_op_iterator_valid(&iter)) {
+		switch (ceph_snap_op_2_str_idx(iter.cur)) {
+		case CEPH_MDS_LEASE_UNKNOWN_NAME_STR_IDX:
+			KUNIT_EXPECT_STREQ(test,
+					   ceph_snap_op_name(iter.cur),
+					   unknown_name);
+			break;
+
+		default:
+			/* do nothing */
+			break;
+		}
+
+		ceph_op_iterator_next(&iter);
+	}
+
+	KUNIT_EXPECT_STREQ(test,
+			   ceph_snap_op_name(CEPH_KUNIT_OP_INVALID_MIN),
+			   unknown_name);
+	KUNIT_EXPECT_STREQ(test,
+			   ceph_snap_op_name(CEPH_KUNIT_OP_INVALID_MAX),
+			   unknown_name);
+}
+
+static struct kunit_case ceph_strings_test_cases[] = {
+	KUNIT_CASE(ceph_mds_state_name_test),
+	KUNIT_CASE(ceph_session_op_name_test),
+	KUNIT_CASE(ceph_mds_op_name_test),
+	KUNIT_CASE(ceph_cap_op_name_test),
+	KUNIT_CASE(ceph_lease_op_name_test),
+	KUNIT_CASE(ceph_snap_op_name_test),
+	{}
+};
+
+static struct kunit_suite ceph_strings_test_suite = {
+	.name = "ceph_strings",
+	.test_cases = ceph_strings_test_cases,
+};
+
+kunit_test_suites(&ceph_strings_test_suite);
+
+MODULE_AUTHOR("Viacheslav Dubeyko <slava@dubeyko.com>");
+MODULE_DESCRIPTION("KUnit tests for ceph strings functions");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");
diff --git a/include/linux/ceph/ceph_fs.h b/include/linux/ceph/ceph_fs.h
index c7f2c63b3bc3..c41d3996a2b1 100644
--- a/include/linux/ceph/ceph_fs.h
+++ b/include/linux/ceph/ceph_fs.h
@@ -262,6 +262,25 @@ struct ceph_mon_subscribe_ack {
 #define CEPH_MDS_STATE_ACTIVE       13 /* up, active */
 #define CEPH_MDS_STATE_STOPPING     14 /* up, but exporting metadata */
 
+enum {
+/* 0 */		CEPH_MDS_STATE_DNE_STR_IDX,
+/* 1 */		CEPH_MDS_STATE_STOPPED_STR_IDX,
+/* 2 */		CEPH_MDS_STATE_BOOT_STR_IDX,
+/* 3 */		CEPH_MDS_STATE_STANDBY_STR_IDX,
+/* 4 */		CEPH_MDS_STATE_CREATING_STR_IDX,
+/* 5 */		CEPH_MDS_STATE_STARTING_STR_IDX,
+/* 6 */		CEPH_MDS_STATE_STANDBY_REPLAY_STR_IDX,
+/* 7 */		CEPH_MDS_STATE_REPLAYONCE_STR_IDX,
+/* 8 */		CEPH_MDS_STATE_REPLAY_STR_IDX,
+/* 9 */		CEPH_MDS_STATE_RESOLVE_STR_IDX,
+/* 10 */	CEPH_MDS_STATE_RECONNECT_STR_IDX,
+/* 11 */	CEPH_MDS_STATE_REJOIN_STR_IDX,
+/* 12 */	CEPH_MDS_STATE_CLIENTREPLAY_STR_IDX,
+/* 13 */	CEPH_MDS_STATE_ACTIVE_STR_IDX,
+/* 14 */	CEPH_MDS_STATE_STOPPING_STR_IDX,
+/* 15 */	CEPH_MDS_STATE_UNKNOWN_NAME_STR_IDX
+};
+
 extern const char *ceph_mds_state_name(int s);
 
 
@@ -287,19 +306,20 @@ extern const char *ceph_mds_state_name(int s);
 
 /* client_session ops */
 enum {
-	CEPH_SESSION_REQUEST_OPEN,
-	CEPH_SESSION_OPEN,
-	CEPH_SESSION_REQUEST_CLOSE,
-	CEPH_SESSION_CLOSE,
-	CEPH_SESSION_REQUEST_RENEWCAPS,
-	CEPH_SESSION_RENEWCAPS,
-	CEPH_SESSION_STALE,
-	CEPH_SESSION_RECALL_STATE,
-	CEPH_SESSION_FLUSHMSG,
-	CEPH_SESSION_FLUSHMSG_ACK,
-	CEPH_SESSION_FORCE_RO,
-	CEPH_SESSION_REJECT,
-	CEPH_SESSION_REQUEST_FLUSH_MDLOG,
+/* 0 */		CEPH_SESSION_REQUEST_OPEN,
+/* 1 */		CEPH_SESSION_OPEN,
+/* 2 */		CEPH_SESSION_REQUEST_CLOSE,
+/* 3 */		CEPH_SESSION_CLOSE,
+/* 4 */		CEPH_SESSION_REQUEST_RENEWCAPS,
+/* 5 */		CEPH_SESSION_RENEWCAPS,
+/* 6 */		CEPH_SESSION_STALE,
+/* 7 */		CEPH_SESSION_RECALL_STATE,
+/* 8 */		CEPH_SESSION_FLUSHMSG,
+/* 9 */		CEPH_SESSION_FLUSHMSG_ACK,
+/* 10 */	CEPH_SESSION_FORCE_RO,
+/* 11 */	CEPH_SESSION_REJECT,
+/* 12 */	CEPH_SESSION_REQUEST_FLUSH_MDLOG,
+/* 13 */	CEPH_SESSION_UNKNOWN_NAME
 };
 
 #define CEPH_SESSION_BLOCKLISTED	(1 << 0)  /* session blocklisted */
@@ -322,39 +342,39 @@ struct ceph_mds_session_head {
  */
 #define CEPH_MDS_OP_WRITE        0x001000
 enum {
-	CEPH_MDS_OP_LOOKUP     = 0x00100,
-	CEPH_MDS_OP_GETATTR    = 0x00101,
-	CEPH_MDS_OP_LOOKUPHASH = 0x00102,
-	CEPH_MDS_OP_LOOKUPPARENT = 0x00103,
-	CEPH_MDS_OP_LOOKUPINO  = 0x00104,
-	CEPH_MDS_OP_LOOKUPNAME = 0x00105,
-	CEPH_MDS_OP_GETVXATTR  = 0x00106,
-
-	CEPH_MDS_OP_SETXATTR   = 0x01105,
-	CEPH_MDS_OP_RMXATTR    = 0x01106,
-	CEPH_MDS_OP_SETLAYOUT  = 0x01107,
-	CEPH_MDS_OP_SETATTR    = 0x01108,
-	CEPH_MDS_OP_SETFILELOCK= 0x01109,
-	CEPH_MDS_OP_GETFILELOCK= 0x00110,
-	CEPH_MDS_OP_SETDIRLAYOUT=0x0110a,
-
-	CEPH_MDS_OP_MKNOD      = 0x01201,
-	CEPH_MDS_OP_LINK       = 0x01202,
-	CEPH_MDS_OP_UNLINK     = 0x01203,
-	CEPH_MDS_OP_RENAME     = 0x01204,
-	CEPH_MDS_OP_MKDIR      = 0x01220,
-	CEPH_MDS_OP_RMDIR      = 0x01221,
-	CEPH_MDS_OP_SYMLINK    = 0x01222,
-
-	CEPH_MDS_OP_CREATE     = 0x01301,
-	CEPH_MDS_OP_OPEN       = 0x00302,
-	CEPH_MDS_OP_READDIR    = 0x00305,
-
-	CEPH_MDS_OP_LOOKUPSNAP = 0x00400,
-	CEPH_MDS_OP_MKSNAP     = 0x01400,
-	CEPH_MDS_OP_RMSNAP     = 0x01401,
-	CEPH_MDS_OP_LSSNAP     = 0x00402,
-	CEPH_MDS_OP_RENAMESNAP = 0x01403,
+/* 0 */		CEPH_MDS_OP_LOOKUP		= 0x00100,
+/* 1 */		CEPH_MDS_OP_GETATTR		= 0x00101,
+/* 2 */		CEPH_MDS_OP_LOOKUPHASH		= 0x00102,
+/* 3 */		CEPH_MDS_OP_LOOKUPPARENT	= 0x00103,
+/* 4 */		CEPH_MDS_OP_LOOKUPINO		= 0x00104,
+/* 5 */		CEPH_MDS_OP_LOOKUPNAME		= 0x00105,
+/* 6 */		CEPH_MDS_OP_GETVXATTR		= 0x00106,
+
+/* 7 */		CEPH_MDS_OP_SETXATTR		= 0x01105,
+/* 8 */		CEPH_MDS_OP_RMXATTR		= 0x01106,
+/* 9 */		CEPH_MDS_OP_SETLAYOUT		= 0x01107,
+/* 10 */	CEPH_MDS_OP_SETATTR		= 0x01108,
+/* 11 */	CEPH_MDS_OP_SETFILELOCK		= 0x01109,
+/* 12 */	CEPH_MDS_OP_GETFILELOCK		= 0x00110,
+/* 13 */	CEPH_MDS_OP_SETDIRLAYOUT	= 0x0110a,
+
+/* 14 */	CEPH_MDS_OP_MKNOD		= 0x01201,
+/* 15 */	CEPH_MDS_OP_LINK		= 0x01202,
+/* 16 */	CEPH_MDS_OP_UNLINK		= 0x01203,
+/* 17 */	CEPH_MDS_OP_RENAME		= 0x01204,
+/* 18 */	CEPH_MDS_OP_MKDIR		= 0x01220,
+/* 19 */	CEPH_MDS_OP_RMDIR		= 0x01221,
+/* 20 */	CEPH_MDS_OP_SYMLINK		= 0x01222,
+
+/* 21 */	CEPH_MDS_OP_CREATE		= 0x01301,
+/* 22 */	CEPH_MDS_OP_OPEN		= 0x00302,
+/* 23 */	CEPH_MDS_OP_READDIR		= 0x00305,
+
+/* 24 */	CEPH_MDS_OP_LOOKUPSNAP		= 0x00400,
+/* 25 */	CEPH_MDS_OP_MKSNAP		= 0x01400,
+/* 26 */	CEPH_MDS_OP_RMSNAP		= 0x01401,
+/* 27 */	CEPH_MDS_OP_LSSNAP		= 0x00402,
+/* 28 */	CEPH_MDS_OP_RENAMESNAP		= 0x01403,
 };
 
 #define IS_CEPH_MDS_OP_NEWINODE(op) (op == CEPH_MDS_OP_CREATE     || \
@@ -362,6 +382,39 @@ enum {
 				     op == CEPH_MDS_OP_MKDIR      || \
 				     op == CEPH_MDS_OP_SYMLINK)
 
+enum {
+/* 0 */		CEPH_MDS_OP_LOOKUP_STR_IDX,
+/* 1 */		CEPH_MDS_OP_GETATTR_STR_IDX,
+/* 2 */		CEPH_MDS_OP_LOOKUPHASH_STR_IDX,
+/* 3 */		CEPH_MDS_OP_LOOKUPPARENT_STR_IDX,
+/* 4 */		CEPH_MDS_OP_LOOKUPINO_STR_IDX,
+/* 5 */		CEPH_MDS_OP_LOOKUPNAME_STR_IDX,
+/* 6 */		CEPH_MDS_OP_GETVXATTR_STR_IDX,
+/* 7 */		CEPH_MDS_OP_SETXATTR_STR_IDX,
+/* 8 */		CEPH_MDS_OP_RMXATTR_STR_IDX,
+/* 9 */		CEPH_MDS_OP_SETLAYOUT_STR_IDX,
+/* 10 */	CEPH_MDS_OP_SETATTR_STR_IDX,
+/* 11 */	CEPH_MDS_OP_SETFILELOCK_STR_IDX,
+/* 12 */	CEPH_MDS_OP_GETFILELOCK_STR_IDX,
+/* 13 */	CEPH_MDS_OP_SETDIRLAYOUT_STR_IDX,
+/* 14 */	CEPH_MDS_OP_MKNOD_STR_IDX,
+/* 15 */	CEPH_MDS_OP_LINK_STR_IDX,
+/* 16 */	CEPH_MDS_OP_UNLINK_STR_IDX,
+/* 17 */	CEPH_MDS_OP_RENAME_STR_IDX,
+/* 18 */	CEPH_MDS_OP_MKDIR_STR_IDX,
+/* 19 */	CEPH_MDS_OP_RMDIR_STR_IDX,
+/* 20 */	CEPH_MDS_OP_SYMLINK_STR_IDX,
+/* 21 */	CEPH_MDS_OP_CREATE_STR_IDX,
+/* 22 */	CEPH_MDS_OP_OPEN_STR_IDX,
+/* 23 */	CEPH_MDS_OP_READDIR_STR_IDX,
+/* 24 */	CEPH_MDS_OP_LOOKUPSNAP_STR_IDX,
+/* 25 */	CEPH_MDS_OP_MKSNAP_STR_IDX,
+/* 26 */	CEPH_MDS_OP_RMSNAP_STR_IDX,
+/* 27 */	CEPH_MDS_OP_LSSNAP_STR_IDX,
+/* 28 */	CEPH_MDS_OP_RENAMESNAP_STR_IDX,
+/* 29 */	CEPH_MDS_OP_UNKNOWN_NAME_STR_IDX
+};
+
 extern const char *ceph_mds_op_name(int op);
 
 #define CEPH_SETATTR_MODE              (1 << 0)
@@ -739,19 +792,20 @@ int ceph_flags_to_mode(int flags);
 int ceph_caps_for_mode(int mode);
 
 enum {
-	CEPH_CAP_OP_GRANT,         /* mds->client grant */
-	CEPH_CAP_OP_REVOKE,        /* mds->client revoke */
-	CEPH_CAP_OP_TRUNC,         /* mds->client trunc notify */
-	CEPH_CAP_OP_EXPORT,        /* mds has exported the cap */
-	CEPH_CAP_OP_IMPORT,        /* mds has imported the cap */
-	CEPH_CAP_OP_UPDATE,        /* client->mds update */
-	CEPH_CAP_OP_DROP,          /* client->mds drop cap bits */
-	CEPH_CAP_OP_FLUSH,         /* client->mds cap writeback */
-	CEPH_CAP_OP_FLUSH_ACK,     /* mds->client flushed */
-	CEPH_CAP_OP_FLUSHSNAP,     /* client->mds flush snapped metadata */
-	CEPH_CAP_OP_FLUSHSNAP_ACK, /* mds->client flushed snapped metadata */
-	CEPH_CAP_OP_RELEASE,       /* client->mds release (clean) cap */
-	CEPH_CAP_OP_RENEW,         /* client->mds renewal request */
+/* 0 */		CEPH_CAP_OP_GRANT,         /* mds->client grant */
+/* 1 */		CEPH_CAP_OP_REVOKE,        /* mds->client revoke */
+/* 2 */		CEPH_CAP_OP_TRUNC,         /* mds->client trunc notify */
+/* 3 */		CEPH_CAP_OP_EXPORT,        /* mds has exported the cap */
+/* 4 */		CEPH_CAP_OP_IMPORT,        /* mds has imported the cap */
+/* 5 */		CEPH_CAP_OP_UPDATE,        /* client->mds update */
+/* 6 */		CEPH_CAP_OP_DROP,          /* client->mds drop cap bits */
+/* 7 */		CEPH_CAP_OP_FLUSH,         /* client->mds cap writeback */
+/* 8 */		CEPH_CAP_OP_FLUSH_ACK,     /* mds->client flushed */
+/* 9 */		CEPH_CAP_OP_FLUSHSNAP,     /* client->mds flush snapped metadata */
+/* 10 */	CEPH_CAP_OP_FLUSHSNAP_ACK, /* mds->client flushed snapped metadata */
+/* 11 */	CEPH_CAP_OP_RELEASE,       /* client->mds release (clean) cap */
+/* 12 */	CEPH_CAP_OP_RENEW,         /* client->mds renewal request */
+/* 13 */	CEPH_CAP_OP_UNKNOWN_NAME
 };
 
 extern const char *ceph_cap_op_name(int op);
@@ -816,7 +870,15 @@ struct ceph_mds_cap_item {
 #define CEPH_MDS_LEASE_RENEW            3  /* client <-> mds    */
 #define CEPH_MDS_LEASE_REVOKE_ACK       4  /* client  -> mds    */
 
-extern const char *ceph_lease_op_name(int o);
+enum {
+/* 0 */		CEPH_MDS_LEASE_REVOKE_STR_IDX,
+/* 1 */		CEPH_MDS_LEASE_RELEASE_STR_IDX,
+/* 2 */		CEPH_MDS_LEASE_RENEW_STR_IDX,
+/* 3 */		CEPH_MDS_LEASE_REVOKE_ACK_STR_IDX,
+/* 4 */		CEPH_MDS_LEASE_UNKNOWN_NAME_STR_IDX
+};
+
+extern const char *ceph_lease_op_name(int op);
 
 /* lease msg header */
 struct ceph_mds_lease {
@@ -860,10 +922,11 @@ struct ceph_mds_snaprealm_reconnect {
  * snaps
  */
 enum {
-	CEPH_SNAP_OP_UPDATE,  /* CREATE or DESTROY */
-	CEPH_SNAP_OP_CREATE,
-	CEPH_SNAP_OP_DESTROY,
-	CEPH_SNAP_OP_SPLIT,
+/* 0 */		CEPH_SNAP_OP_UPDATE,  /* CREATE or DESTROY */
+/* 1 */		CEPH_SNAP_OP_CREATE,
+/* 2 */		CEPH_SNAP_OP_DESTROY,
+/* 3 */		CEPH_SNAP_OP_SPLIT,
+/* 4 */		CEPH_SNAP_OP_UNKNOWN_NAME
 };
 
 extern const char *ceph_snap_op_name(int o);
-- 
2.51.0


