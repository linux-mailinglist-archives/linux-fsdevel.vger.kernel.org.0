Return-Path: <linux-fsdevel+bounces-76217-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SN9XJo47gmmVQgMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76217-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 19:16:46 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 99F69DD6D5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 19:16:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6281530091CD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Feb 2026 18:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6204C36681F;
	Tue,  3 Feb 2026 18:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dqDfhQT+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com [209.85.215.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5911B369205
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Feb 2026 18:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770142585; cv=none; b=kFj/qt8YtxpovNB9WPnOQ2fhseFqKrpVPIRnrcHRdwdTRVOUHiVEIKI8pnF9jMEG/Flp6Nh23SACdBP5og36LZOyfStEqJE1m0IvLqZHCUvGJPaFjS1VwoZbPcDcQYdHU9ETS4y7pXFhMM0D3/SuHuu3G/Qtydo3Up2Msa12X9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770142585; c=relaxed/simple;
	bh=4uJPwTtGdOf+GukpMdunMop58+8Bn2s7OyEFP8RIwsY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RHujVjeLra+D6qVJsIorcX3Q+Ofuh0G1LBUxA8us2P2Ag1d2eGg1d0aYX0GimorC18wdhT1nxSQQrn0cKItqr/jASpi6BO5jPHGGObXZ+fgx9NCp9t9rIqban1dkfOqPvVLYVhvfs+uO3XqMARZHCe+U5R24+ApMSZXp79cckZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dqDfhQT+; arc=none smtp.client-ip=209.85.215.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f194.google.com with SMTP id 41be03b00d2f7-bc274b8b15bso3941528a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Feb 2026 10:16:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770142583; x=1770747383; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mjla1q3jju6XkNYbTp39sGOpZWNK/5G6gOcu20xqemI=;
        b=dqDfhQT+YSiilM+/jAV4Di0mctg5/N+hXgFPCxfncdCoDexOjpEPPpr00uLcXWXHEy
         IejN0XxY+tM4sFdMrAZW1DnuvofJzpgYGWf4aCCJYoESWKvzTC7Vnxjrk3CLDiIktRCq
         uNCZDY7YqJSo3zLF2PWAvYREXc7cLmdeL5BFGB+xa3BRqQrlzLelcsCdJnONFW1JQ8e3
         pYV3XdVvUDAIPzclEkKkQlkzW2E42kS+KFWQXANI03K2TN9pBF0PGWfGyydDw1xT/ofe
         zUKx8kFJVcwEGr6ICOwwIauOIt5/0ZCtTs/xSlZfW1s7OC2CrS6UMCfn2YCS+rqwKzNo
         xYwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770142583; x=1770747383;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mjla1q3jju6XkNYbTp39sGOpZWNK/5G6gOcu20xqemI=;
        b=WiGhVg4cp86fAejc+fKUmg3pNNDb41Li7cE23OhhBb3oAkD9WVJ3iZZqVWAtVZRZvT
         FltqykvlAZex2UUDvNFHzSNCJftJj3KeYMMoccGOtnhfDitUcN6pLgtf8Dcl0EJ8OGxd
         SxtPoWe2jJjwwxtA4VtcfBtnEwN3utKTOfePtC3hUHcSTxiFGSSebfs8TNlsegAWVuRA
         ++FWJn2Asx/TZAtTJXDR2PX3a9HuG0S9bYUn252U5QmqC/8YuCN5CMBM4/7gc3WW6hyN
         Y23dHYOoGyKJ7XagcA3UmP2nSoDk0ktLjV/WL2K/sjsWqaC3yea5bMO9kxnb3UkGWmuU
         n7pg==
X-Forwarded-Encrypted: i=1; AJvYcCWqUQF3JvtrIfqRQAhzgKQ0koMBhldvsLGa8J/7IIhEWtLYc0ErcEbWQi8SyLcJJZZ2imzUkU9Sp1F94vO9@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh4QXCUb/T3PvhpWq4HDSlEUw0rzt9UIhTLvaBSccD94jKGM6q
	kX9VWBbHuNcMpcoiDrn7G3d8FELH7QI3wpvuButi3lGojkt8TMvFmAk=
X-Gm-Gg: AZuq6aJ2Q+EXu5NkNE8m6olCyehdvhQS0OdRKPivj2JZQ35tg9F+LKaVbxJ8GmW97bF
	tpVDivPfOY4Up3yrc3XPHJCsOWjmhYM1izkRv25obV3QZkuh82mkgZhBgqKz3LO4FHmtWlCwtkf
	rQQ2/fFYd7Y/czkKaoxJzrtAn407+8aOM4cnTqePW695Ig0c/VxKCLHxWJ8rIvxVMQpAKuYIqm5
	JC+Hh28KbLH6ww4YICxW4ycFfom5bU8Ft5c/mIEaGxFCVzuQdINgREHQuDnyJo0QTLrPzopGy8v
	jXCl9qsmYQYGp4jm+7HHdcRp+sCScmowp2TkerYf+dSwi9iI8dQ6jeEmMzX4zII3Q5H7Y5omL1I
	5Y/W/1gqNYMwBJJ9vfTZIBp8QGjRjJ0ykTWMG1ezZGS9zhXOi1cqTPdwttdfQ6iTx91Vj9Oxuvs
	L9FD3q+zKMTqonzPMPVwP+8P9x3nho7+Yj8Xqi5lU+
X-Received: by 2002:a17:90a:ec8f:b0:340:bde5:c9e8 with SMTP id 98e67ed59e1d1-3548719372cmr167467a91.22.1770142582737;
        Tue, 03 Feb 2026 10:16:22 -0800 (PST)
Received: from localhost.localdomain ([59.16.109.172])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35485eb8dc6sm313230a91.9.2026.02.03.10.16.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 10:16:22 -0800 (PST)
From: Jinseok Kim <always.starving0@gmail.com>
To: shuah@kernel.org
Cc: Jan Kara <jack@suse.cz>,
	Amir Goldstein <amir73il@gmail.com>,
	Matthew Bobrowski <repnop@google.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH] selftests: fanotify: Add basic create/modify/delete event test
Date: Wed,  4 Feb 2026 03:15:43 +0900
Message-ID: <20260203181549.21750-1-always.starving0@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,gmail.com,google.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76217-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alwaysstarving0@gmail.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 99F69DD6D5
X-Rspamd-Action: no action

Hello,

Currently there are almost no automated selftests for fanotify notification
events in tools/testing/selftests/ (only mount namespace
related tests exist).

This patch adds a very basic selftest that exercises three fundamental
fanotify events:
    - FAN_CREATE (file creation)
    - FAN_MODIFY (file content modification via write())
    - FAN_DELETE (file removal)

The test
    - creates a test file, appends data, and removes it
    - verifies that corresponding events are received and the masks contain
      the expected bits (0x100, 0x2, 0x200)

Test TAP output:
    ok 1 FAN_CREATE detected
    ok 2 FAN_MODIFY detected
    ok 3 FAN_DELETE detected
    # PASSED: 1 / 1 tests passed.

This is intentionally kept minimal as a starting point.

Future work ideas (not in this patch):
    - Test permission events
    - Test rename/move events
    - Verify file names
    - Run under different filesystems

Any feedback on the direction, style, or additional test cases
would be greatly appreciated.

Thanks,
Jinseok.

Signed-off-by: Jinseok Kim <always.starving0@gmail.com>
---
 tools/testing/selftests/filesystems/Makefile  |   7 +
 .../selftests/filesystems/fanotify_basic.c    | 122 ++++++++++++++++++
 2 files changed, 129 insertions(+)
 create mode 100644 tools/testing/selftests/filesystems/Makefile
 create mode 100644 tools/testing/selftests/filesystems/fanotify_basic.c

diff --git a/tools/testing/selftests/filesystems/Makefile b/tools/testing/selftests/filesystems/Makefile
new file mode 100644
index 0000000..c0e0242
--- /dev/null
+++ b/tools/testing/selftests/filesystems/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0
+
+CFLAGS += $(KHDR_INCLUDES)
+TEST_GEN_PROGS := devpts_pts file_stressor anon_inode_test kernfs_test fclog fanotify_basic
+TEST_GEN_PROGS_EXTENDED := dnotify_test
+
+include ../lib.mk
diff --git a/tools/testing/selftests/filesystems/fanotify_basic.c b/tools/testing/selftests/filesystems/fanotify_basic.c
new file mode 100644
index 0000000..4a4fbb4
--- /dev/null
+++ b/tools/testing/selftests/filesystems/fanotify_basic.c
@@ -0,0 +1,122 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <fcntl.h>
+#include <sys/fanotify.h>
+#include <linux/fanotify.h>
+#include "../kselftest_harness.h"
+#include "wrappers.h"
+
+static void create_file(const char *filename)
+{
+	int fd;
+	int ret;
+
+	fd = open(filename, O_CREAT | O_WRONLY | O_TRUNC, 0644);
+	if (fd == -1)
+		ksft_exit_fail_msg("(create)open failed: %s\n", strerror(errno));
+	ret = write(fd, "create_file", 11);
+	if (ret == -1)
+		ksft_exit_fail_msg("(create) writing failed: %s\n", strerror(errno));
+	close(fd);
+}
+
+static void modify_file(const char *filename)
+{
+	int fd;
+	int ret;
+
+	fd = open(filename, O_RDWR);
+	if (fd == -1)
+		ksft_exit_fail_msg("(modify)open failed :%s\n", strerror(errno));
+	if (lseek(fd, 0, SEEK_END) < 0)
+		ksft_exit_fail_msg("(modify)lseek failed");
+	ret = write(fd, "modify_file", 11);
+	if (ret == -1)
+		ksft_exit_fail_msg("(modify)write failed :%s\n", strerror(errno));
+	if (fsync(fd) == -1)
+		ksft_exit_fail_msg("(modify)fsync failed: %s\n", strerror(errno));
+
+	close(fd);
+}
+
+TEST(fanotify_cud_test)
+{
+	int fan_fd;
+	char buf[4096];
+	int ret;
+	ssize_t len;
+	struct fanotify_event_metadata *meta;
+
+	fan_fd = fanotify_init(FAN_CLASS_NOTIF | FAN_REPORT_FID, O_RDONLY);
+	ASSERT_GE(fan_fd, 0)
+	TH_LOG("fanotify_init failed: %s", strerror(errno));
+
+	ret = fanotify_mark(fan_fd, FAN_MARK_ADD,
+				  FAN_EVENT_ON_CHILD | FAN_CREATE |
+				  FAN_MODIFY | FAN_DELETE,
+				  AT_FDCWD, "/tmp");
+	ASSERT_GE(ret, 0)
+	TH_LOG("fanotify_mark failed: %s", strerror(errno));
+
+	// FAN_CREATE Test
+	create_file("/tmp/fanotify_test");
+	len = read(fan_fd, buf, sizeof(buf));
+	ASSERT_GT(len, 0)
+	TH_LOG("No event after create_file");
+
+	meta = (void *)buf;
+	if (FAN_EVENT_OK(meta, len)) {
+		TH_LOG("Event after create: mask = 0x%llx, pid=%d",
+		       (unsigned long long)meta->mask, meta->pid);
+		if (meta->mask & FAN_CREATE)
+			ksft_test_result_pass("FAN_CREATE detected\n");
+		else
+			TH_LOG("FAN_CREATE missing");
+	} else
+		ksft_test_result_fail("Invalid event metadata after create\n");
+
+	// FAN_MODIFY Test
+	modify_file("/tmp/fanotify_test");
+	len = read(fan_fd, buf, sizeof(buf));
+	ASSERT_GT(len, 0)
+		TH_LOG("No event after modify_file");
+
+	meta = (void *)buf;
+	if (FAN_EVENT_OK(meta, len)) {
+		TH_LOG("Event after modify: mask = 0x%llx, pid=%d",
+		       (unsigned long long)meta->mask, meta->pid);
+		if (meta->mask & FAN_MODIFY)
+			ksft_test_result_pass("FAN_MODIFY detected\n");
+		else
+			ksft_test_result_fail("FAN_MODIFY missing\n");
+	} else
+		ksft_test_result_fail("Invalid event metadata after modify\n");
+
+	// FAN_DELETE
+	ASSERT_EQ(unlink("/tmp/fanotify_test"), 0)
+		TH_LOG("unlink failed: %s", strerror(errno));
+
+	len = read(fan_fd, buf, sizeof(buf));
+	ASSERT_GT(len, 0)
+		TH_LOG("No event after unlink");
+
+	meta = (void *)buf;
+	if (FAN_EVENT_OK(meta, len)) {
+		TH_LOG("Event after delete: mask = 0x%llx, pid=%d",
+		       (unsigned long long)meta->mask, meta->pid);
+		if (meta->mask & FAN_DELETE)
+			ksft_test_result_pass("FAN_DELETE detected\n");
+		else
+			ksft_test_result_fail("FAN_DELETE missing\n");
+	} else
+		ksft_test_result_fail("Invalid event metadata after delete\n");
+
+	// Clean up
+	if (fan_fd >= 0) {
+		fanotify_mark(fan_fd, FAN_MARK_REMOVE, 0, AT_FDCWD, ".");
+		close(fan_fd);
+	}
+}
+
+TEST_HARNESS_MAIN
--
2.43.0

