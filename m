Return-Path: <linux-fsdevel+bounces-79692-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2DFZFeIGrGkxjAEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79692-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 07 Mar 2026 12:07:14 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E164122B5B4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 07 Mar 2026 12:07:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 781343053CE3
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Mar 2026 11:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE34D34A3CC;
	Sat,  7 Mar 2026 11:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RKqe6afA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A393446C7
	for <linux-fsdevel@vger.kernel.org>; Sat,  7 Mar 2026 11:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772881562; cv=none; b=YEwkIoKldcmL2eWBSKRkvlUelMduJgxdQSZowe1UKkGEP/VA8iOCfLb+tDYm7ThZr+tyUIDkBSif2BZSRMQ6agQBRyHZg13blwVWOxX43KRPaL/YM3wGPJNuBdC/oNzY8JmS/IfkgloAlVEWsDL48BKvrJXD4j8St5Ix+HuIZYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772881562; c=relaxed/simple;
	bh=lkOTqvCqSOUo3O7b6tCsLWID4YSTl28gV5mB5HYBjrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bujPelhNjUsIHfIcxY6DbrQgtXKs3SiG6FNIv6Q++KPhONXuyDSQX41wgwc23XwZSxyvCQuq0MuN7c9nlliz/RUKdWb0PHLrr99J/B3zt0kviqEUWwgSwyfFdzhiI0P5+W/dHNdeRfOa/rYsHYF4BPsec8Pv99Dp8pxnnG9TrZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RKqe6afA; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b9434f706a2so147091066b.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 07 Mar 2026 03:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772881559; x=1773486359; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CiI+9cU8uYmeMsTH12PHUw+sm7JWGt2JsoGlWFT0sgI=;
        b=RKqe6afAF5mpbLiRQ96NSktIXb4UmPydqoPi0vNX6TLlx2j4moT+Jn2X+GyKh6hMdO
         0aYmtPH6VTfViAMzpDttBEsoCAh+IHtNtgbUDZ/V4BodH8PkbigM0MNtO6CaJf5chKN2
         A+cvrYhXDk8qMF6ghI9MKu71eGrQ+4JxqA7IbKI4gwU2mr1oQ4ATL/iiFwg5NqGAmbI3
         +t+GPsdJTEcb93oP2P5srW19SJ12w/wGhImkPB6Ck3T2GBjS9IjZcd+lZvZySpjGJge/
         x2eYQwIy2FuqqGozYV9RdtmdltT+EZyoOeEShLsLbMBlDBoZG2a9QxFTUW0DeBkSLX/m
         TOyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772881559; x=1773486359;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CiI+9cU8uYmeMsTH12PHUw+sm7JWGt2JsoGlWFT0sgI=;
        b=XcMPHZMEFs5rhHtVsokvYkjdBDx4IpQr652TqvVt6x/MK5s4yRrgiE/jazkkZaRwHt
         eEBEqv6MUjlGOW9nFPCUWQgmTz1b5cpCJLuNnugamxaPDIj9AemCdR9I14FpnZZapk3s
         5g6sQeQlOntOXhGnx/ICl7vqp7VrR6EjVTe64eRXYZMcx1doDMPMr5tuhPNvexojam/5
         FwvJ/jsBbMdE0+pq7mugkS986u4I36Y+WE53qbJkZ4KpMtVtW1Pi9GvSCQdpK5snZpzZ
         qMVzKUHOGB3BdzBHwS1gXYQJlawbcPeXVfJSj1cvDpApfgT1KX1hk0aikBEP1Zzfq9u1
         l82w==
X-Forwarded-Encrypted: i=1; AJvYcCUYoISQTotROfa8nx2xbyjP94f1Dgn/sntWefKgmx9ZgxvO5RX3+l9nzHILxJvHmGG/qY/DHQSW0JuHiGHy@vger.kernel.org
X-Gm-Message-State: AOJu0Ywqc+qEGdLpSZQ8HmYYCb/FawqudhK4ePVI+gFWhA7tW7mKEzh9
	y/mmufGPAlkyHVqPFlVZCLtY2UUxz6QOADmATuVDSd0R12bwB5mDIUic
X-Gm-Gg: ATEYQzw3Emf2gvdRP/wdmE0ZHpaylWqogBlhcbchu3GeQ8SUjmOHiHduI9jLka7ouBn
	i8DfyhSr5PdrzjALerDhOjHyu22xgU23EM9PBvoeRp+fnOjH1LEma/580o4Glw/O1GCNddUZRjt
	G+hw5zPmK9I5iYHB2WQk3gl+tzrumNBktedyQkQ0jHSuf26K2E4b6mVLgxHlDp4VTOY2NQ3AeB5
	KuxH6k9R0yq02Fz5pjq/YCl2bt1s1BI+6jblZTXXnPvm+uxZ3ai27xo5tnvp10PCruSmEOdJ929
	IW9U7wIsST+0eXv72q04XDp4hX5PggOUQYoiMdBKxevi0Rjh/GojKNtz36Rd4OpII3ea4MppltI
	TB6TT641JfCTwGgWm4wTXy5C1T3yL2al10lTTekO7BNa28DD1kNnzEAWoWV+lenfq8oGb1IceZJ
	sJosjDdtD16ctWZPZAmTmj28hf8U2VmhaNdCH7yJ7c/vj5KRURh8RUdEIeY1L8o6VS2t7BqNOHP
	pXhB0l9p5OM/+FmmgJynSIjgqwBvMr9gc3XJjk=
X-Received: by 2002:a17:907:72d2:b0:b94:da7:f3eb with SMTP id a640c23a62f3a-b942ddf51abmr337600466b.26.1772881558410;
        Sat, 07 Mar 2026 03:05:58 -0800 (PST)
Received: from localhost (2001-1c00-570d-ee00-7ad4-b88c-4d95-6756.cable.dynamic.v6.ziggo.nl. [2001:1c00:570d:ee00:7ad4:b88c:4d95:6756])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b942ef42a24sm134575666b.8.2026.03.07.03.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Mar 2026 03:05:57 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>,
	Lennart Poettering <lennart@poettering.net>,
	Tejun Heo <tj@kernel.org>,
	"T . J . Mercier" <tjmercier@google.com>,
	linux-fsdevel@vger.kernel.org
Subject: [RFC][PATCH 5/5] selftests/filesystems: add fanotify namespace notifications test
Date: Sat,  7 Mar 2026 12:05:50 +0100
Message-ID: <20260307110550.373762-6-amir73il@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260307110550.373762-1-amir73il@gmail.com>
References: <20260307110550.373762-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E164122B5B4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-79692-lists,linux-fsdevel=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amir73il@gmail.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-0.995];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

Test create and delete events for nsfs:
- For init userns and child userns
- Verify delete event is created regardless of vfs inode access
- Verify required ns capabilities

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 tools/include/uapi/linux/fanotify.h           |  79 +++--
 .../selftests/filesystems/fanotify/Makefile   |   3 +-
 .../filesystems/fanotify/ns-notify_test.c     | 330 ++++++++++++++++++
 3 files changed, 380 insertions(+), 32 deletions(-)
 create mode 100644 tools/testing/selftests/filesystems/fanotify/ns-notify_test.c

diff --git a/tools/include/uapi/linux/fanotify.h b/tools/include/uapi/linux/fanotify.h
index e710967c7c263..45ad484ceb473 100644
--- a/tools/include/uapi/linux/fanotify.h
+++ b/tools/include/uapi/linux/fanotify.h
@@ -5,37 +5,45 @@
 #include <linux/types.h>
 
 /* the following events that user-space can register for */
-#define FAN_ACCESS		0x00000001	/* File was accessed */
-#define FAN_MODIFY		0x00000002	/* File was modified */
-#define FAN_ATTRIB		0x00000004	/* Metadata changed */
-#define FAN_CLOSE_WRITE		0x00000008	/* Writable file closed */
-#define FAN_CLOSE_NOWRITE	0x00000010	/* Unwritable file closed */
-#define FAN_OPEN		0x00000020	/* File was opened */
-#define FAN_MOVED_FROM		0x00000040	/* File was moved from X */
-#define FAN_MOVED_TO		0x00000080	/* File was moved to Y */
-#define FAN_CREATE		0x00000100	/* Subfile was created */
-#define FAN_DELETE		0x00000200	/* Subfile was deleted */
-#define FAN_DELETE_SELF		0x00000400	/* Self was deleted */
-#define FAN_MOVE_SELF		0x00000800	/* Self was moved */
-#define FAN_OPEN_EXEC		0x00001000	/* File was opened for exec */
-
-#define FAN_Q_OVERFLOW		0x00004000	/* Event queued overflowed */
-#define FAN_FS_ERROR		0x00008000	/* Filesystem error */
-
-#define FAN_OPEN_PERM		0x00010000	/* File open in perm check */
-#define FAN_ACCESS_PERM		0x00020000	/* File accessed in perm check */
-#define FAN_OPEN_EXEC_PERM	0x00040000	/* File open/exec in perm check */
-/* #define FAN_DIR_MODIFY	0x00080000 */	/* Deprecated (reserved) */
-
-#define FAN_PRE_ACCESS		0x00100000	/* Pre-content access hook */
-#define FAN_MNT_ATTACH		0x01000000	/* Mount was attached */
-#define FAN_MNT_DETACH		0x02000000	/* Mount was detached */
-
-#define FAN_EVENT_ON_CHILD	0x08000000	/* Interested in child events */
-
-#define FAN_RENAME		0x10000000	/* File was renamed */
-
-#define FAN_ONDIR		0x40000000	/* Event occurred against dir */
+#define FAN_ACCESS		0x00000001ULL	/* File was accessed */
+#define FAN_MODIFY		0x00000002ULL	/* File was modified */
+#define FAN_ATTRIB		0x00000004ULL	/* Metadata changed */
+#define FAN_CLOSE_WRITE		0x00000008ULL	/* Writable file closed */
+#define FAN_CLOSE_NOWRITE	0x00000010ULL	/* Unwritable file closed */
+#define FAN_OPEN		0x00000020ULL	/* File was opened */
+#define FAN_MOVED_FROM		0x00000040ULL	/* File was moved from X */
+#define FAN_MOVED_TO		0x00000080ULL	/* File was moved to Y */
+#define FAN_CREATE		0x00000100ULL	/* Subfile was created */
+#define FAN_DELETE		0x00000200ULL	/* Subfile was deleted */
+#define FAN_DELETE_SELF		0x00000400ULL	/* Self was deleted */
+#define FAN_MOVE_SELF		0x00000800ULL	/* Self was moved */
+#define FAN_OPEN_EXEC		0x00001000ULL	/* File was opened for exec */
+
+#define FAN_Q_OVERFLOW		0x00004000ULL	/* Event queued overflowed */
+#define FAN_FS_ERROR		0x00008000ULL	/* Filesystem error */
+
+#define FAN_OPEN_PERM		0x00010000ULL	/* File open in perm check */
+#define FAN_ACCESS_PERM		0x00020000ULL	/* File accessed in perm check */
+#define FAN_OPEN_EXEC_PERM	0x00040000ULL	/* File open/exec in perm check */
+/* #define FAN_DIR_MODIFY	0x00080000ULL */	/* Deprecated (reserved) */
+
+#define FAN_PRE_ACCESS		0x00100000ULL	/* Pre-content access hook */
+#define FAN_MNT_ATTACH		0x01000000ULL	/* Mount was attached */
+#define FAN_MNT_DETACH		0x02000000ULL	/* Mount was detached */
+
+#define FAN_EVENT_ON_CHILD	0x08000000ULL	/* Interested in child events */
+
+#define FAN_RENAME		0x10000000ULL	/* File was renamed */
+
+#define FAN_ONDIR		0x40000000ULL	/* Event occurred against dir */
+
+/*
+ * Namespace lifecycle events use the upper 32 bits of the 64-bit mask
+ * to avoid confusion with the inode-level FAN_CREATE/FAN_DELETE events.
+ * They are only valid with FAN_MARK_USERNS and FAN_REPORT_NSID.
+ */
+#define FAN_NS_CREATE		(FAN_CREATE << 32)	/* Namespace became active */
+#define FAN_NS_DELETE		(FAN_DELETE << 32)	/* Namespace became inactive */
 
 /* helper events */
 #define FAN_CLOSE		(FAN_CLOSE_WRITE | FAN_CLOSE_NOWRITE) /* close */
@@ -67,6 +75,7 @@
 #define FAN_REPORT_TARGET_FID	0x00001000	/* Report dirent target id  */
 #define FAN_REPORT_FD_ERROR	0x00002000	/* event->fd can report error */
 #define FAN_REPORT_MNT		0x00004000	/* Report mount events */
+#define FAN_REPORT_NSID		0x00008000	/* Report namespace events */
 
 /* Convenience macro - FAN_REPORT_NAME requires FAN_REPORT_DIR_FID */
 #define FAN_REPORT_DFID_NAME	(FAN_REPORT_DIR_FID | FAN_REPORT_NAME)
@@ -98,6 +107,7 @@
 #define FAN_MARK_MOUNT		0x00000010
 #define FAN_MARK_FILESYSTEM	0x00000100
 #define FAN_MARK_MNTNS		0x00000110
+#define FAN_MARK_USERNS		0x00001000
 
 /*
  * Convenience macro - FAN_MARK_IGNORE requires FAN_MARK_IGNORED_SURV_MODIFY
@@ -152,6 +162,7 @@ struct fanotify_event_metadata {
 #define FAN_EVENT_INFO_TYPE_ERROR	5
 #define FAN_EVENT_INFO_TYPE_RANGE	6
 #define FAN_EVENT_INFO_TYPE_MNT		7
+#define FAN_EVENT_INFO_TYPE_NS		8
 
 /* Special info types for FAN_RENAME */
 #define FAN_EVENT_INFO_TYPE_OLD_DFID_NAME	10
@@ -210,6 +221,12 @@ struct fanotify_event_info_mnt {
 	__u64 mnt_id;
 };
 
+struct fanotify_event_info_ns {
+	struct fanotify_event_info_header hdr;
+	__u64 self_nsid;	/* ns_id of the namespace */
+	__u64 owner_nsid;	/* ns_id of its owning user namespace */
+};
+
 /*
  * User space may need to record additional information about its decision.
  * The extra information type records what kind of information is included.
diff --git a/tools/testing/selftests/filesystems/fanotify/Makefile b/tools/testing/selftests/filesystems/fanotify/Makefile
index 836a4eb7be062..d251249630985 100644
--- a/tools/testing/selftests/filesystems/fanotify/Makefile
+++ b/tools/testing/selftests/filesystems/fanotify/Makefile
@@ -3,9 +3,10 @@
 CFLAGS += -Wall -O2 -g $(KHDR_INCLUDES) $(TOOLS_INCLUDES)
 LDLIBS += -lcap
 
-TEST_GEN_PROGS := mount-notify_test mount-notify_test_ns
+TEST_GEN_PROGS := mount-notify_test mount-notify_test_ns ns-notify_test
 
 include ../../lib.mk
 
 $(OUTPUT)/mount-notify_test: ../utils.c
 $(OUTPUT)/mount-notify_test_ns: ../utils.c
+$(OUTPUT)/ns-notify_test: ../utils.c
diff --git a/tools/testing/selftests/filesystems/fanotify/ns-notify_test.c b/tools/testing/selftests/filesystems/fanotify/ns-notify_test.c
new file mode 100644
index 0000000000000..012a62c92ee4a
--- /dev/null
+++ b/tools/testing/selftests/filesystems/fanotify/ns-notify_test.c
@@ -0,0 +1,330 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2025
+
+#define _GNU_SOURCE
+
+// Needed for linux/fanotify.h
+typedef struct {
+	int	val[2];
+} __kernel_fsid_t;
+#define __kernel_fsid_t __kernel_fsid_t
+
+#include <fcntl.h>
+#include <sched.h>
+#include <signal.h>
+#include <stdio.h>
+#include <string.h>
+#include <sys/fanotify.h>
+#include <sys/wait.h>
+#include <unistd.h>
+
+#include "kselftest_harness.h"
+#include "../utils.h"
+
+#include <linux/fanotify.h>
+
+/*
+ * Retrieve the ns_id of a namespace fd via name_to_handle_at().
+ * nsfs encodes { ns_id(u64), ns_type(u32), ns_inum(u32) } in f_handle.
+ */
+static uint64_t get_ns_id(int fd)
+{
+	struct {
+		struct file_handle fh;
+		uint64_t ns_id;
+		uint32_t ns_type;
+		uint32_t ns_inum;
+	} h = { .fh.handle_bytes = sizeof(uint64_t) + sizeof(uint32_t) * 2 };
+	int mnt_id;
+
+	if (name_to_handle_at(fd, "", &h.fh, &mnt_id, AT_EMPTY_PATH))
+		return 0;
+	return h.ns_id;
+}
+
+static void read_ns_event_fd(struct __test_metadata *const _metadata,
+			     int fd, char *buf, size_t buf_size,
+			     uint64_t expect_mask,
+			     uint64_t *self_nsid_out, uint64_t *owner_nsid_out)
+{
+	struct fanotify_event_metadata *meta;
+	struct fanotify_event_info_ns *info;
+	ssize_t len;
+
+	len = read(fd, buf, buf_size);
+	ASSERT_GT(len, 0);
+
+	meta = (struct fanotify_event_metadata *)buf;
+	ASSERT_TRUE(FAN_EVENT_OK(meta, len));
+	ASSERT_EQ(meta->mask, expect_mask);
+	ASSERT_EQ(meta->fd, FAN_NOFD);
+	ASSERT_EQ(meta->event_len,
+		  sizeof(*meta) + sizeof(struct fanotify_event_info_ns));
+
+	info = (struct fanotify_event_info_ns *)(meta + 1);
+	ASSERT_EQ(info->hdr.info_type, FAN_EVENT_INFO_TYPE_NS);
+	ASSERT_EQ(info->hdr.len, sizeof(*info));
+
+	*self_nsid_out  = info->self_nsid;
+	*owner_nsid_out = info->owner_nsid;
+}
+
+/* =========================================================================
+ * Outer tests: watch init_user_ns from root context (no setup_userns).
+ * ========================================================================= */
+
+/*
+ * Root-only: watch init_user_ns, fork a child that creates a user namespace
+ * owned by init_user_ns, verify FAN_CREATE, let the child exit, verify
+ * FAN_DELETE.  The watched namespace is created and destroyed entirely within
+ * the test body so both events are observable.
+ */
+TEST(outer_create_delete_userns)
+{
+	int fan_fd, ns_fd;
+	int pipefd[2];
+	pid_t pid;
+	uint64_t ns_nsid, create_self, create_owner;
+	uint64_t delete_self, delete_owner;
+	char buf[256];
+	char c;
+
+	if (geteuid() != 0)
+		SKIP(return, "requires root");
+
+	ns_fd = open("/proc/self/ns/user", O_RDONLY);
+	ASSERT_GE(ns_fd, 0);
+
+	ns_nsid = get_ns_id(ns_fd);
+	ASSERT_NE(ns_nsid, 0);
+
+	fan_fd = fanotify_init(FAN_REPORT_NSID, 0);
+	ASSERT_GE(fan_fd, 0);
+
+	errno = 0;
+	ASSERT_EQ(fanotify_mark(fan_fd, FAN_MARK_ADD | FAN_MARK_USERNS,
+				FAN_NS_CREATE | FAN_NS_DELETE, ns_fd, NULL), 0)
+		TH_LOG("fanotify_mark errno=%d (%s)", errno, strerror(errno));
+
+	ASSERT_EQ(pipe(pipefd), 0);
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		close(pipefd[0]);
+		if (unshare(CLONE_NEWUSER))
+			_exit(1);
+		if (write(pipefd[1], "r", 1) < 0)
+			_exit(1);
+		close(pipefd[1]);
+		pause();
+		_exit(0);
+	}
+
+	close(pipefd[1]);
+	ASSERT_EQ(read(pipefd[0], &c, 1), 1);
+	close(pipefd[0]);
+
+	/* --- FAN_NS_CREATE: new user namespace owned by init_user_ns --- */
+	read_ns_event_fd(_metadata, fan_fd, buf, sizeof(buf),
+			 FAN_NS_CREATE, &create_self, &create_owner);
+	ASSERT_NE(create_self, 0);
+	ASSERT_EQ(create_owner, ns_nsid);
+
+	/* Let child exit, deactivating its user namespace */
+	kill(pid, SIGTERM);
+	waitpid(pid, NULL, 0);
+
+	/* --- FAN_NS_DELETE --- */
+	read_ns_event_fd(_metadata, fan_fd, buf, sizeof(buf),
+			 FAN_NS_DELETE, &delete_self, &delete_owner);
+	ASSERT_EQ(delete_self, create_self);
+	ASSERT_EQ(delete_owner, ns_nsid);
+
+	close(fan_fd);
+	close(ns_fd);
+}
+
+/* =========================================================================
+ * Inner tests: watch a child userns from within it (via setup_userns).
+ * ========================================================================= */
+
+FIXTURE(userns_notify) {
+	int fan_fd;
+	int userns_fd;
+	int outer_ns_fd;	/* init_user_ns fd, captured before setup_userns() */
+	uint64_t userns_nsid;
+	char buf[256];
+};
+
+FIXTURE_SETUP(userns_notify)
+{
+	int ret;
+
+	/* Capture the outer user namespace fd before setup_userns() */
+	self->outer_ns_fd = open("/proc/self/ns/user", O_RDONLY);
+	ASSERT_GE(self->outer_ns_fd, 0);
+
+	ret = setup_userns();
+	ASSERT_EQ(ret, 0);
+
+	self->userns_fd = open("/proc/self/ns/user", O_RDONLY);
+	ASSERT_GE(self->userns_fd, 0);
+
+	self->userns_nsid = get_ns_id(self->userns_fd);
+	ASSERT_NE(self->userns_nsid, 0);
+
+	self->fan_fd = fanotify_init(FAN_REPORT_NSID, 0);
+	ASSERT_GE(self->fan_fd, 0);
+
+	errno = 0;
+	ret = fanotify_mark(self->fan_fd, FAN_MARK_ADD | FAN_MARK_USERNS,
+			    FAN_NS_CREATE | FAN_NS_DELETE,
+			    self->userns_fd, NULL);
+	ASSERT_EQ(ret, 0)
+		TH_LOG("fanotify_mark errno=%d (%s)", errno, strerror(errno));
+}
+
+FIXTURE_TEARDOWN(userns_notify)
+{
+	close(self->fan_fd);
+	close(self->userns_fd);
+	close(self->outer_ns_fd);
+}
+
+static void read_ns_event(struct __test_metadata *const _metadata,
+			  FIXTURE_DATA(userns_notify) *self,
+			  uint64_t expect_mask,
+			  uint64_t *self_nsid_out, uint64_t *owner_nsid_out)
+{
+	read_ns_event_fd(_metadata, self->fan_fd, self->buf, sizeof(self->buf),
+			 expect_mask, self_nsid_out, owner_nsid_out);
+}
+
+/*
+ * Create a UTS namespace inside the watched user namespace, verify
+ * FAN_CREATE, then let the child exit and verify FAN_DELETE.
+ * Cross-check self_nsid against the actual ns_id obtained via
+ * name_to_handle_at() on the child's /proc/pid/ns/uts.
+ */
+TEST_F(userns_notify, inner_create_delete_uts)
+{
+	int pipefd[2];
+	pid_t pid;
+	uint64_t create_self, create_owner;
+	uint64_t delete_self, delete_owner;
+	char c;
+
+	ASSERT_EQ(pipe(pipefd), 0);
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		close(pipefd[0]);
+		if (unshare(CLONE_NEWUTS))
+			_exit(1);
+		if (write(pipefd[1], "r", 1) < 0)
+			_exit(1);
+		close(pipefd[1]);
+		pause();
+		_exit(0);
+	}
+
+	close(pipefd[1]);
+	ASSERT_EQ(read(pipefd[0], &c, 1), 1);
+	close(pipefd[0]);
+
+	/* --- FAN_NS_CREATE --- */
+	read_ns_event(_metadata, self, FAN_NS_CREATE, &create_self, &create_owner);
+	ASSERT_NE(create_self, 0);
+	ASSERT_EQ(create_owner, self->userns_nsid);
+
+	/* Cross-check self_nsid against the child's actual UTS ns_id */
+	char path[64];
+	int ns_fd;
+	uint64_t uts_nsid;
+
+	snprintf(path, sizeof(path), "/proc/%d/ns/uts", pid);
+	ns_fd = open(path, O_RDONLY);
+	ASSERT_GE(ns_fd, 0);
+	uts_nsid = get_ns_id(ns_fd);
+	close(ns_fd);
+	ASSERT_EQ(uts_nsid, create_self);
+
+	kill(pid, SIGTERM);
+	waitpid(pid, NULL, 0);
+
+	/* --- FAN_NS_DELETE --- */
+	read_ns_event(_metadata, self, FAN_NS_DELETE, &delete_self, &delete_owner);
+	ASSERT_EQ(delete_self, create_self);
+	ASSERT_EQ(delete_owner, self->userns_nsid);
+}
+
+/*
+ * Same as inner_create_delete_uts but the namespace fd is never opened, so
+ * the stashed nsfs dentry/inode is never populated.  Verifies that FAN_CREATE
+ * and FAN_DELETE are still delivered and carry a consistent self_nsid.
+ */
+TEST_F(userns_notify, inner_create_delete_uts_no_open)
+{
+	int pipefd[2];
+	pid_t pid;
+	uint64_t create_self, create_owner;
+	uint64_t delete_self, delete_owner;
+	char c;
+
+	ASSERT_EQ(pipe(pipefd), 0);
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		close(pipefd[0]);
+		if (unshare(CLONE_NEWUTS))
+			_exit(1);
+		if (write(pipefd[1], "r", 1) < 0)
+			_exit(1);
+		close(pipefd[1]);
+		pause();
+		_exit(0);
+	}
+
+	close(pipefd[1]);
+	ASSERT_EQ(read(pipefd[0], &c, 1), 1);
+	close(pipefd[0]);
+
+	/* --- FAN_NS_CREATE (no open of /proc/pid/ns/uts) --- */
+	read_ns_event(_metadata, self, FAN_NS_CREATE, &create_self, &create_owner);
+	ASSERT_NE(create_self, 0);
+	ASSERT_EQ(create_owner, self->userns_nsid);
+
+	kill(pid, SIGTERM);
+	waitpid(pid, NULL, 0);
+
+	/* --- FAN_NS_DELETE --- */
+	read_ns_event(_metadata, self, FAN_NS_DELETE, &delete_self, &delete_owner);
+	ASSERT_EQ(delete_self, create_self);
+	ASSERT_EQ(delete_owner, self->userns_nsid);
+}
+
+/*
+ * Attempt to set a FAN_MARK_USERNS watch on the initial user namespace.
+ * Requires CAP_SYS_ADMIN in init_user_ns.  Since FIXTURE_SETUP calls
+ * setup_userns(), the process lives in a child user namespace and cannot
+ * hold capabilities in init_user_ns, so the call must fail with EPERM
+ * regardless of the outer uid.
+ */
+TEST_F(userns_notify, inner_mark_init_userns_eperm)
+{
+	int ret;
+
+	ret = fanotify_mark(self->fan_fd, FAN_MARK_ADD | FAN_MARK_USERNS,
+			    FAN_NS_CREATE | FAN_NS_DELETE,
+			    self->outer_ns_fd, NULL);
+	EXPECT_EQ(ret, -1);
+	EXPECT_EQ(errno, EPERM);
+}
+
+TEST_HARNESS_MAIN
-- 
2.53.0


