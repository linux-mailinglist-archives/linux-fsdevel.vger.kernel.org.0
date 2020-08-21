Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4D0624CFBB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Aug 2020 09:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728400AbgHUHlm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Aug 2020 03:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728398AbgHUHk4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Aug 2020 03:40:56 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D154EC061350
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Aug 2020 00:40:55 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id g15so515338plj.6
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Aug 2020 00:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yvoSycF4wGFmZEGYefbZtpG0hIG/VlSxdUHeeNSYgs0=;
        b=eUl2gyDCmKzsToDNfWl5aI9WA5NN6pL3sCIY+3KLlYrhjm1f9ukiy1AlZYTxLKl4NL
         asfxVR0yHk5HohAHb65P1vNM4IJWtebZAUzQQu8nHBFrhl3ZSROs8nL52Hv1Me48GDEP
         PrpN445otWPkYgg3gKGnUjPuoMuX+PZHN6Ystz2pgWubOuIdCbFsZIbLxj+YUT1krvtg
         81wzD9rg3xfsFUOeioDf/LmXJfwoeuHIhSChKDDcwjw3o//gCigedIK4P1WUIs0uVeU1
         xSy3w71XHvH305imyHqkS6xaenQ2N9olR1jdQp1KWUSOn55StedbfPgVquxqUR8ny7La
         WeGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yvoSycF4wGFmZEGYefbZtpG0hIG/VlSxdUHeeNSYgs0=;
        b=VUcqx0Gjb3nl+m/OjTSyuhfAXBzuJu8ira/Wb6ZMRgmh0K5QMItfQEk+lMOKRRoDIM
         9KcMhNrqKAKomMPyUd9lDcfKVJ5Z3BYiur18AWXIj3eRfAGqUHovdKMqhvDFZGgAK05z
         StT0JLBTc12LSnaWq+HmzD9ShNLvvJoI1mVTPRn9DsKB5rM/Hd+hQlLnMFrPiqKX9e/E
         WBIyy2wmfzBWEQoE3CDlvFSaigZ9hBZw4OvY9ASMrqVPGWTntHOP11WZKOP8Fm3qug+g
         VqihE7PhKmjL1JxlgRinHd/Oo83+afaiBRiaEru+9+Ru8GMpbEBo7Ow+IFPTMGz3uK8F
         UyOw==
X-Gm-Message-State: AOAM533aU/neuTcBo0a7yPcI4eQVQGeLXuvn9JWv68i70LyruZ+OBBIP
        Zn8wOqkDL03t/DCoc8MPdO1Di1wU1d3d3g==
X-Google-Smtp-Source: ABdhPJwHgF0DGJDsQ1TwGS7d7/rnUydxJiwSq4qInbfmmIxhUcFpFQy3UgHN33CeMdXWkQgr6cGylg==
X-Received: by 2002:a17:90a:17ab:: with SMTP id q40mr1530279pja.28.1597995655218;
        Fri, 21 Aug 2020 00:40:55 -0700 (PDT)
Received: from exodia.tfbnw.net ([2620:10d:c090:400::5:f2a4])
        by smtp.gmail.com with ESMTPSA id jb1sm1080875pjb.9.2020.08.21.00.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 00:40:54 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 10/11] btrfs-progs: send: stream v2 ioctl flags
Date:   Fri, 21 Aug 2020 00:40:09 -0700
Message-Id: <fc4038fec127ca2f68ee448b1f5b7fdf3a4372f6.1597994354.git.osandov@osandov.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1597994106.git.osandov@osandov.com>
References: <cover.1597994106.git.osandov@osandov.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Boris Burkov <boris@bur.io>

To make the btrfs send ioctl use the stream v2 format requires passing
BTRFS_SEND_FLAG_STREAM_V2 in flags. Further, to cause the ioctl to emit
encoded_write commands for encoded extents, we must set that flag as
well as BTRFS_SEND_FLAG_COMPRESSED. Finally, we bump up the version in
send.h as well, since we are now fully compatible with v2.

Add two command line arguments to btrfs send: --stream-version and
--compressed. --stream-version requires an argument which it parses as
an integer and sets STREAM_V2 if the argument is 2. --compressed does
not require an argument and automatically implies STREAM_V2 as well
(COMPRESSED alone causes the ioctl to error out).

Some examples to illustrate edge cases:

// v1, old format and no encoded_writes
btrfs send subvol
btrfs send --stream-version 1 subvol

// v2 and compressed, we will see encoded_writes
btrfs send --compressed subvol
btrfs send --compressed --stream-version 2 subvol

// v2 only, new format but no encoded_writes
btrfs send --stream-version 2 subvol

// error: compressed needs version >= 2
btrfs send --compressed --stream-version 1 subvol

// error: invalid version (not 1 or 2)
btrfs send --stream-version 3 subvol
btrfs send --compressed --stream-version 0 subvol
btrfs send --compressed --stream-version 10 subvol

Signed-off-by: Boris Burkov <boris@bur.io>
---
 cmds/send.c          | 39 +++++++++++++++++++++++++++++++++++++--
 ioctl.h              | 17 ++++++++++++++++-
 libbtrfsutil/btrfs.h | 17 ++++++++++++++++-
 send.h               |  2 +-
 4 files changed, 70 insertions(+), 5 deletions(-)

diff --git a/cmds/send.c b/cmds/send.c
index b8e3ba12..4c4eaa84 100644
--- a/cmds/send.c
+++ b/cmds/send.c
@@ -474,6 +474,7 @@ static int cmd_send(const struct cmd_struct *cmd, int argc, char **argv)
 	int full_send = 1;
 	int new_end_cmd_semantic = 0;
 	u64 send_flags = 0;
+	long stream_version = 0;
 
 	memset(&send, 0, sizeof(send));
 	send.dump_fd = fileno(stdout);
@@ -492,11 +493,17 @@ static int cmd_send(const struct cmd_struct *cmd, int argc, char **argv)
 
 	optind = 0;
 	while (1) {
-		enum { GETOPT_VAL_SEND_NO_DATA = 256 };
+		enum {
+			GETOPT_VAL_SEND_NO_DATA = 256,
+			GETOPT_VAL_SEND_STREAM_V2,
+			GETOPT_VAL_SEND_COMPRESSED
+		};
 		static const struct option long_options[] = {
 			{ "verbose", no_argument, NULL, 'v' },
 			{ "quiet", no_argument, NULL, 'q' },
-			{ "no-data", no_argument, NULL, GETOPT_VAL_SEND_NO_DATA }
+			{ "no-data", no_argument, NULL, GETOPT_VAL_SEND_NO_DATA },
+			{ "stream-version", required_argument, NULL, GETOPT_VAL_SEND_STREAM_V2 },
+			{ "compressed", no_argument, NULL, GETOPT_VAL_SEND_COMPRESSED }
 		};
 		int c = getopt_long(argc, argv, "vqec:f:i:p:", long_options, NULL);
 
@@ -584,10 +591,38 @@ static int cmd_send(const struct cmd_struct *cmd, int argc, char **argv)
 		case GETOPT_VAL_SEND_NO_DATA:
 			send_flags |= BTRFS_SEND_FLAG_NO_FILE_DATA;
 			break;
+		case GETOPT_VAL_SEND_STREAM_V2:
+			stream_version = strtol(optarg, NULL, 10);
+			if (stream_version < 1 || stream_version > 2) {
+				ret = 1;
+				error("invalid --stream-version. valid values: {1, 2}");
+				goto out;
+			}
+			if (stream_version == 2)
+				send_flags |= BTRFS_SEND_FLAG_STREAM_V2;
+			break;
+		case GETOPT_VAL_SEND_COMPRESSED:
+			send_flags |= BTRFS_SEND_FLAG_COMPRESSED;
+			/*
+			 * We want to default to stream v2 if only compressed is
+			 * set. If stream_version is explicitly set to 0, that
+			 * will trigger its own error condition for being an
+			 * invalid version.
+			 */
+			if (stream_version == 0) {
+				stream_version = 2;
+				send_flags |= BTRFS_SEND_FLAG_STREAM_V2;
+			}
+			break;
 		default:
 			usage_unknown_option(cmd, argv);
 		}
 	}
+	if (stream_version < 2 && (send_flags & BTRFS_SEND_FLAG_COMPRESSED)) {
+		ret = 1;
+		error("--compressed requires --stream-version >= 2");
+		goto out;
+	}
 
 	if (check_argc_min(argc - optind, 1))
 		return 1;
diff --git a/ioctl.h b/ioctl.h
index ade6dcb9..46de8ac8 100644
--- a/ioctl.h
+++ b/ioctl.h
@@ -653,10 +653,25 @@ BUILD_ASSERT(sizeof(struct btrfs_ioctl_received_subvol_args_32) == 192);
  */
 #define BTRFS_SEND_FLAG_OMIT_END_CMD		0x4
 
+/*
+ * Use version 2 of the send stream, which adds new commands and supports larger
+ * writes.
+ */
+#define BTRFS_SEND_FLAG_STREAM_V2		0x8
+
+/*
+ * Send compressed data using the ENCODED_WRITE command instead of decompressing
+ * the data and sending it with the WRITE command. This requires
+ * BTRFS_SEND_FLAG_STREAM_V2.
+ */
+#define BTRFS_SEND_FLAG_COMPRESSED		0x10
+
 #define BTRFS_SEND_FLAG_MASK \
 	(BTRFS_SEND_FLAG_NO_FILE_DATA | \
 	 BTRFS_SEND_FLAG_OMIT_STREAM_HEADER | \
-	 BTRFS_SEND_FLAG_OMIT_END_CMD)
+	 BTRFS_SEND_FLAG_OMIT_END_CMD | \
+	 BTRFS_SEND_FLAG_STREAM_V2 | \
+	 BTRFS_SEND_FLAG_COMPRESSED)
 
 struct btrfs_ioctl_send_args {
 	__s64 send_fd;			/* in */
diff --git a/libbtrfsutil/btrfs.h b/libbtrfsutil/btrfs.h
index 60d51ff6..8430a40d 100644
--- a/libbtrfsutil/btrfs.h
+++ b/libbtrfsutil/btrfs.h
@@ -731,10 +731,25 @@ struct btrfs_ioctl_received_subvol_args {
  */
 #define BTRFS_SEND_FLAG_OMIT_END_CMD		0x4
 
+/*
+ * Use version 2 of the send stream, which adds new commands and supports larger
+ * writes.
+ */
+#define BTRFS_SEND_FLAG_STREAM_V2		0x8
+
+/*
+ * Send compressed data using the ENCODED_WRITE command instead of decompressing
+ * the data and sending it with the WRITE command. This requires
+ * BTRFS_SEND_FLAG_STREAM_V2.
+ */
+#define BTRFS_SEND_FLAG_COMPRESSED		0x10
+
 #define BTRFS_SEND_FLAG_MASK \
 	(BTRFS_SEND_FLAG_NO_FILE_DATA | \
 	 BTRFS_SEND_FLAG_OMIT_STREAM_HEADER | \
-	 BTRFS_SEND_FLAG_OMIT_END_CMD)
+	 BTRFS_SEND_FLAG_OMIT_END_CMD | \
+	 BTRFS_SEND_FLAG_STREAM_V2 | \
+	 BTRFS_SEND_FLAG_COMPRESSED)
 
 struct btrfs_ioctl_send_args {
 	__s64 send_fd;			/* in */
diff --git a/send.h b/send.h
index 3c47e0c7..fac90588 100644
--- a/send.h
+++ b/send.h
@@ -31,7 +31,7 @@ extern "C" {
 #endif
 
 #define BTRFS_SEND_STREAM_MAGIC "btrfs-stream"
-#define BTRFS_SEND_STREAM_VERSION 1
+#define BTRFS_SEND_STREAM_VERSION 2
 
 #define BTRFS_SEND_BUF_SIZE_V1 SZ_64K
 #define BTRFS_SEND_READ_SIZE (1024 * 48)
-- 
2.28.0

