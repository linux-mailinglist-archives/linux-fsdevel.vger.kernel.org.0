Return-Path: <linux-fsdevel+bounces-37451-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 915079F2603
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Dec 2024 21:17:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71E4A1646A0
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Dec 2024 20:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6AC41C1F02;
	Sun, 15 Dec 2024 20:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iwQg9BSV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C8B1C07C1
	for <linux-fsdevel@vger.kernel.org>; Sun, 15 Dec 2024 20:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734293853; cv=none; b=pbq00McS5y0a0eWpknMMYS8X7jv9hbRifLWvfErk5l7ridKlIBagvtoSD83SgCHZafugwEbrOOgMSdtYcPtDMPB4UIRSH+N1n5ZRk7NZPUAJbGSDijBCOjaGnrWziNbxVrSjMNrdVaITIBconMxHLIPw8W1/QuuqEi3j+dlsHo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734293853; c=relaxed/simple;
	bh=t5ZB3S9FAPTSg7jaPhLfftiu7OGAVCaFewVNQnPC7Sk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JfTR4O03DJJ1nI1sinaa1e7EMiRljGydVmXh6c0+h2lvStJgJbPR3Rrfiec+r9HymkHUU4bUv9jRvEaTLtsrYPoRDJNEOgr56ivnHpGPFE8msUOfgsS6pieZihkzkKwOwNY11HFcrVXOvhqp3BtMLrk8mNV9KClmhqJNpz+sGyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iwQg9BSV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB5E3C4CECE;
	Sun, 15 Dec 2024 20:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734293853;
	bh=t5ZB3S9FAPTSg7jaPhLfftiu7OGAVCaFewVNQnPC7Sk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=iwQg9BSVpOryqNsgYG83Us0r5stowezKHiO8T7BozvOP7n3UuLQP3n2Fdw4vRzLV+
	 knt4hByHw2EmV5408C0uA9Yf2QsuNM0wtQgOGwCg94+XLJlXAgL3BA9St5RphByu/g
	 bfZxbYZzIgVQAV6z119z1j+On37kIGOUQ4vjyzEzRtjBdopCzCrfCAwo6qaCjRoyVG
	 nBvoT00+oa40NmC0J4YkzoNr+t2o89nilO/SahH+pamjl7d5L/9fZObAqULhRLiRTb
	 z5Dn0Z8BdQ39SPwKWccQUvPTHNgcBSxwqz05/fLQmFQ6BB9EwQCuQenO5bhfGPvCHE
	 ngvoxgwE7fooA==
From: Christian Brauner <brauner@kernel.org>
Date: Sun, 15 Dec 2024 21:17:07 +0100
Subject: [PATCH 3/3] selftests: add listmount() iteration tests
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241215-vfs-6-14-mount-work-v1-3-fd55922c4af8@kernel.org>
References: <20241215-vfs-6-14-mount-work-v1-0-fd55922c4af8@kernel.org>
In-Reply-To: <20241215-vfs-6-14-mount-work-v1-0-fd55922c4af8@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-355e8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2856; i=brauner@kernel.org;
 h=from:subject:message-id; bh=t5ZB3S9FAPTSg7jaPhLfftiu7OGAVCaFewVNQnPC7Sk=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTHW4ZldG9l+/Xpwq2UHnvpgHlJuj8/7g/wtfz1sm9n9
 L+0I14fO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACYiVc7wTyW6OMV+/trYb8F2
 jazfL7E1dj5TOrnu3TwDfrekiPj6aQy/2e+Kbk143yWT6flP+mpZ54aH6vcXX+k2tli9U1PGP7i
 MCQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Add a forward and backward iteration test for listmount().

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 .../selftests/filesystems/statmount/Makefile       |  2 +-
 .../filesystems/statmount/listmount_test.c         | 66 ++++++++++++++++++++++
 2 files changed, 67 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/filesystems/statmount/Makefile b/tools/testing/selftests/filesystems/statmount/Makefile
index 3af3136e35a4bc3671c292ab6abe41832a2be85d..14ee91a416509c7c4070fc3115c66bcfd9166011 100644
--- a/tools/testing/selftests/filesystems/statmount/Makefile
+++ b/tools/testing/selftests/filesystems/statmount/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 
 CFLAGS += -Wall -O2 -g $(KHDR_INCLUDES)
-TEST_GEN_PROGS := statmount_test statmount_test_ns
+TEST_GEN_PROGS := statmount_test statmount_test_ns listmount_test
 
 include ../../lib.mk
diff --git a/tools/testing/selftests/filesystems/statmount/listmount_test.c b/tools/testing/selftests/filesystems/statmount/listmount_test.c
new file mode 100644
index 0000000000000000000000000000000000000000..15f0834f7557c8771be9adbfe7968421c505a1ea
--- /dev/null
+++ b/tools/testing/selftests/filesystems/statmount/listmount_test.c
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+// Copyright (c) 2024 Christian Brauner <brauner@kernel.org>
+
+#define _GNU_SOURCE
+#include <fcntl.h>
+#include <sched.h>
+#include <stdio.h>
+#include <string.h>
+#include <sys/stat.h>
+#include <sys/mount.h>
+#include <unistd.h>
+
+#include "statmount.h"
+#include "../../kselftest_harness.h"
+
+#ifndef LISTMOUNT_REVERSE
+#define LISTMOUNT_REVERSE    (1 << 0) /* List later mounts first */
+#endif
+
+#define LISTMNT_BUFFER 10
+
+/* Check that all mount ids are in increasing order. */
+TEST(listmount_forward)
+{
+	uint64_t list[LISTMNT_BUFFER], last_mnt_id = 0;
+
+	for (;;) {
+		ssize_t nr_mounts;
+
+		nr_mounts = listmount(LSMT_ROOT, 0, last_mnt_id,
+				      list, LISTMNT_BUFFER, 0);
+		ASSERT_GE(nr_mounts, 0);
+		if (nr_mounts == 0)
+			break;
+
+		for (size_t cur = 0; cur < nr_mounts; cur++) {
+			if (cur < nr_mounts - 1)
+				ASSERT_LT(list[cur], list[cur + 1]);
+			last_mnt_id = list[cur];
+		}
+	}
+}
+
+/* Check that all mount ids are in decreasing order. */
+TEST(listmount_backward)
+{
+	uint64_t list[LISTMNT_BUFFER], last_mnt_id = 0;
+
+	for (;;) {
+		ssize_t nr_mounts;
+
+		nr_mounts = listmount(LSMT_ROOT, 0, last_mnt_id,
+				      list, LISTMNT_BUFFER, LISTMOUNT_REVERSE);
+		ASSERT_GE(nr_mounts, 0);
+		if (nr_mounts == 0)
+			break;
+
+		for (size_t cur = 0; cur < nr_mounts; cur++) {
+			if (cur < nr_mounts - 1)
+				ASSERT_GT(list[cur], list[cur + 1]);
+			last_mnt_id = list[cur];
+		}
+	}
+}
+
+TEST_HARNESS_MAIN

-- 
2.45.2


