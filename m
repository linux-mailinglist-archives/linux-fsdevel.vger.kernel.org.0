Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2943E33DE00
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Mar 2021 20:46:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240671AbhCPTqI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Mar 2021 15:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233157AbhCPTpQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Mar 2021 15:45:16 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99386C0613E8
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Mar 2021 12:44:50 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id lr1-20020a17090b4b81b02900ea0a3f38c1so4120574pjb.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Mar 2021 12:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yIrmegELQzDBD+K/fHYvK9pDetSTfa5MQLVDCS/2lnk=;
        b=1Fh16vtyyGMTjU4kNzOf9HKIj+pmhYXk9POqev3tZhre3RtjVmrg2H5DUc8hREMw63
         g3FMJRrnQwFoLpGlpHpyMkDHfCAEGDTp/udDHWyIZnBD+dXH+1kj2fJtx7FwOvRLsVO2
         9FDD7yVzyswv9fIqbo0tgJQt09K/447/UY3+0SYDaujkFg5oVAgJcHTCSDQF3j7BV9Wb
         feNAIvOFl0An2jHGqfkq2wMbQdfzMwo5Y/ecTri+E3WMdkIV0DUJUru0T0DrA9lEM4KZ
         U+Z0gFX7AzOu4l5K6M0LWv0Tixdynq+OJ9SXD8lRhF6t5Db85eDl9JFusca9nVE8TuA/
         BrHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yIrmegELQzDBD+K/fHYvK9pDetSTfa5MQLVDCS/2lnk=;
        b=AqTjrxbnlwmaDJFsaMs2caD4CT9DtEa2D41jhLnogCL0Vv/olBgHQWnEPKxbUX/4jM
         UPagJtsDzNsnZygqSjqaj2GMeXrBbEK53IAhzXRJd12hmaGrcCXnpehWHclNO/wK6Ex9
         XrcTcuN5jP2WyzTNAEigcyGrOLu6bXMa3H18UYEkcGSBLwkoC7lKkt+l5GXbiOmtBGJf
         jIQ3cw32FVdn29O9sUlIaE85tzbfstp+6exAP9/B0G4EL0LJ/1nFVHujIHnPxseRKGPp
         QEGAvKdHuJu9cHjw2PB3WXwINhSngksRMP+r54wAXGOaQTs1IZUQLT3Ro9CdYlyg3Kzv
         f4Vg==
X-Gm-Message-State: AOAM5301sFH62OaNq2XW9dQvcAURZkARkW3arVv375IjS/KZx/4ed9z5
        9gc9HNtSN+WBvSsGy8GI9JbTnA==
X-Google-Smtp-Source: ABdhPJxkehI52wJ+H/vnUjiLinsRUHN93QRSSEgjpMWdGlF0EQu/LCeZCOGPF5ET0RGfVex/T4MmQA==
X-Received: by 2002:a17:90a:458b:: with SMTP id v11mr590742pjg.189.1615923890003;
        Tue, 16 Mar 2021 12:44:50 -0700 (PDT)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:532])
        by smtp.gmail.com with ESMTPSA id w22sm16919104pfi.133.2021.03.16.12.44.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 12:44:49 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v4 10/11] btrfs-progs: send: stream v2 ioctl flags
Date:   Tue, 16 Mar 2021 12:44:04 -0700
Message-Id: <045eb34479405c7a27e388c4272e8ec12eec2654.1615922859.git.osandov@osandov.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1615922753.git.osandov@fb.com>
References: <cover.1615922753.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
--compressed-data. --stream-version requires an argument which it parses
as an integer and sets STREAM_V2 if the argument is 2. --compressed-data
does not require an argument and automatically implies STREAM_V2 as well
(COMPRESSED alone causes the ioctl to error out).

Some examples to illustrate edge cases:

// v1, old format and no encoded_writes
btrfs send subvol
btrfs send --stream-version 1 subvol

// v2 and compressed, we will see encoded_writes
btrfs send --compressed-data subvol
btrfs send --compressed-data --stream-version 2 subvol

// v2 only, new format but no encoded_writes
btrfs send --stream-version 2 subvol

// error: compressed needs version >= 2
btrfs send --compressed-data --stream-version 1 subvol

// error: invalid version (not 1 or 2)
btrfs send --stream-version 3 subvol
btrfs send --compressed-data --stream-version 0 subvol
btrfs send --compressed-data --stream-version 10 subvol

Signed-off-by: Boris Burkov <boris@bur.io>
---
 Documentation/btrfs-send.asciidoc | 16 ++++++++-
 cmds/send.c                       | 54 ++++++++++++++++++++++++++++++-
 ioctl.h                           | 17 +++++++++-
 libbtrfsutil/btrfs.h              | 17 +++++++++-
 send.h                            |  2 +-
 5 files changed, 101 insertions(+), 5 deletions(-)

diff --git a/Documentation/btrfs-send.asciidoc b/Documentation/btrfs-send.asciidoc
index c4a05672..202bcd97 100644
--- a/Documentation/btrfs-send.asciidoc
+++ b/Documentation/btrfs-send.asciidoc
@@ -55,7 +55,21 @@ send in 'NO_FILE_DATA' mode
 The output stream does not contain any file
 data and thus cannot be used to transfer changes. This mode is faster and
 is useful to show the differences in metadata.
--q|--quiet::::
+
+--stream-version <1|2>::
+Use the given send stream version. The default is 1. Version 2 encodes file
+data slightly more efficiently; it is also required for sending compressed data
+directly (see '--compressed-data'). Version 2 requires at least btrfs-progs
+5.12 on both the sender and receiver and at least Linux 5.12 on the sender.
+
+--compressed-data::
+Send data that is compressed on the filesystem directly without decompressing
+it. If the receiver supports encoded I/O (see `encoded_io`(7)), it can also
+write it directly without decompressing it. Otherwise, the receiver will fall
+back to decompressing it and writing it normally. This implies
+'--stream-version 2'.
+
+-q|--quiet::
 (deprecated) alias for global '-q' option
 -v|--verbose::
 (deprecated) alias for global '-v' option
diff --git a/cmds/send.c b/cmds/send.c
index 3bfc69f5..80eb2510 100644
--- a/cmds/send.c
+++ b/cmds/send.c
@@ -452,6 +452,21 @@ static const char * const cmd_send_usage[] = {
 	"                 does not contain any file data and thus cannot be used",
 	"                 to transfer changes. This mode is faster and useful to",
 	"                 show the differences in metadata.",
+	"--stream-version <1|2>",
+	"                 Use the given send stream version. The default is",
+	"                 1. Version 2 encodes file data slightly more",
+	"                 efficiently; it is also required for sending",
+	"                 compressed data directly (see --compressed-data).",
+	"                 Version 2 requires at least btrfs-progs 5.12 on both",
+	"                 the sender and receiver and at least Linux 5.12 on the",
+	"                 sender.",
+	"--compressed-data",
+	"                 Send data that is compressed on the filesystem",
+	"                 directly without decompressing it. If the receiver",
+	"                 supports encoded I/O, it can also write it directly",
+	"                 without decompressing it. Otherwise, the receiver will",
+	"                 fall back to decompressing it and writing it normally.",
+	"                 This implies --stream-version 2.",
 	"-v|--verbose     deprecated, alias for global -v option",
 	"-q|--quiet       deprecated, alias for global -q option",
 	HELPINFO_INSERT_GLOBALS,
@@ -463,6 +478,7 @@ static const char * const cmd_send_usage[] = {
 static int cmd_send(const struct cmd_struct *cmd, int argc, char **argv)
 {
 	char *subvol = NULL;
+	char *end;
 	int ret;
 	char outname[PATH_MAX];
 	struct btrfs_send send;
@@ -474,6 +490,7 @@ static int cmd_send(const struct cmd_struct *cmd, int argc, char **argv)
 	int full_send = 1;
 	int new_end_cmd_semantic = 0;
 	u64 send_flags = 0;
+	long stream_version = 0;
 
 	memset(&send, 0, sizeof(send));
 	send.dump_fd = fileno(stdout);
@@ -492,11 +509,17 @@ static int cmd_send(const struct cmd_struct *cmd, int argc, char **argv)
 
 	optind = 0;
 	while (1) {
-		enum { GETOPT_VAL_SEND_NO_DATA = 256 };
+		enum {
+			GETOPT_VAL_SEND_NO_DATA = 256,
+			GETOPT_VAL_SEND_STREAM_V2,
+			GETOPT_VAL_SEND_COMPRESSED_DATA,
+		};
 		static const struct option long_options[] = {
 			{ "verbose", no_argument, NULL, 'v' },
 			{ "quiet", no_argument, NULL, 'q' },
 			{ "no-data", no_argument, NULL, GETOPT_VAL_SEND_NO_DATA },
+			{ "stream-version", required_argument, NULL, GETOPT_VAL_SEND_STREAM_V2 },
+			{ "compressed-data", no_argument, NULL, GETOPT_VAL_SEND_COMPRESSED_DATA },
 			{ NULL, 0, NULL, 0 }
 		};
 		int c = getopt_long(argc, argv, "vqec:f:i:p:", long_options, NULL);
@@ -585,10 +608,39 @@ static int cmd_send(const struct cmd_struct *cmd, int argc, char **argv)
 		case GETOPT_VAL_SEND_NO_DATA:
 			send_flags |= BTRFS_SEND_FLAG_NO_FILE_DATA;
 			break;
+		case GETOPT_VAL_SEND_STREAM_V2:
+			stream_version = strtol(optarg, &end, 10);
+			if (*end != '\0' ||
+			    stream_version < 1 || stream_version > 2) {
+				ret = 1;
+				error("invalid --stream-version. valid values: {1, 2}");
+				goto out;
+			}
+			if (stream_version == 2)
+				send_flags |= BTRFS_SEND_FLAG_STREAM_V2;
+			break;
+		case GETOPT_VAL_SEND_COMPRESSED_DATA:
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
2.30.2

