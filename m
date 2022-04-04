Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60B6D4F1222
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Apr 2022 11:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244845AbiDDJhs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Apr 2022 05:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354372AbiDDJhj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Apr 2022 05:37:39 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BEC73057D
        for <linux-fsdevel@vger.kernel.org>; Mon,  4 Apr 2022 02:35:43 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id C412D1F388;
        Mon,  4 Apr 2022 09:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1649064941; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CWTJUDJIMX2AqX7Cv481Y6m3LpVF4wDxQMv8NSseCVo=;
        b=2WOOu7wz+W6iaKPPg8VBjSqBcF9g3dMMjoiEMf8zJ2quOc/EdtcDaGERD1LFUQ+nkYJz2Q
        dZjl6m6pjaiUznxRUXMef7Y0eZ9OMUTFrq6sBKJJSlkt445IZi8jj4QjR1b8STvt/NkQIk
        YGOAlTxijnCXABfjpzNJEUMHbhzf8rM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1649064941;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CWTJUDJIMX2AqX7Cv481Y6m3LpVF4wDxQMv8NSseCVo=;
        b=ebdOgEbKPOlFsmbxQJvnYog8PptUVxW8RbjekJ2N20Mo4cFulw4l1+5DtboL6AJskhGn3Z
        jYi3kGPd5F7oYBCA==
Received: from echidna.suse.de (unknown [10.163.47.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 9D0C9A3B8A;
        Mon,  4 Apr 2022 09:35:41 +0000 (UTC)
From:   David Disseldorp <ddiss@suse.de>
To:     linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     viro@zeniv.linux.org.uk, willy@infradead.org,
        David Disseldorp <ddiss@suse.de>
Subject: [PATCH v7 5/6] gen_init_cpio: support file checksum archiving
Date:   Mon,  4 Apr 2022 11:34:29 +0200
Message-Id: <20220404093429.27570-6-ddiss@suse.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220404093429.27570-1-ddiss@suse.de>
References: <20220404093429.27570-1-ddiss@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Documentation/driver-api/early-userspace/buffer-format.rst includes the
specification for checksum-enabled cpio archives. Implement support for
this format in gen_init_cpio via a new '-c' parameter.

Suggested-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: David Disseldorp <ddiss@suse.de>
---
 usr/gen_init_cpio.c | 54 +++++++++++++++++++++++++++++++++++++--------
 1 file changed, 45 insertions(+), 9 deletions(-)

diff --git a/usr/gen_init_cpio.c b/usr/gen_init_cpio.c
index 9a0f8c37273a..dc838e26a5b9 100644
--- a/usr/gen_init_cpio.c
+++ b/usr/gen_init_cpio.c
@@ -1,6 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <stdio.h>
 #include <stdlib.h>
+#include <stdint.h>
+#include <stdbool.h>
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <string.h>
@@ -25,6 +27,7 @@
 static unsigned int offset;
 static unsigned int ino = 721;
 static time_t default_mtime;
+static bool do_csum = false;
 
 struct file_handler {
 	const char *type;
@@ -78,7 +81,7 @@ static void cpio_trailer(void)
 
 	sprintf(s, "%s%08X%08X%08lX%08lX%08X%08lX"
 	       "%08X%08X%08X%08X%08X%08X%08X",
-		"070701",		/* magic */
+		do_csum ? "070702" : "070701", /* magic */
 		0,			/* ino */
 		0,			/* mode */
 		(long) 0,		/* uid */
@@ -110,7 +113,7 @@ static int cpio_mkslink(const char *name, const char *target,
 		name++;
 	sprintf(s,"%s%08X%08X%08lX%08lX%08X%08lX"
 	       "%08X%08X%08X%08X%08X%08X%08X",
-		"070701",		/* magic */
+		do_csum ? "070702" : "070701", /* magic */
 		ino++,			/* ino */
 		S_IFLNK | mode,		/* mode */
 		(long) uid,		/* uid */
@@ -159,7 +162,7 @@ static int cpio_mkgeneric(const char *name, unsigned int mode,
 		name++;
 	sprintf(s,"%s%08X%08X%08lX%08lX%08X%08lX"
 	       "%08X%08X%08X%08X%08X%08X%08X",
-		"070701",		/* magic */
+		do_csum ? "070702" : "070701", /* magic */
 		ino++,			/* ino */
 		mode,			/* mode */
 		(long) uid,		/* uid */
@@ -253,7 +256,7 @@ static int cpio_mknod(const char *name, unsigned int mode,
 		name++;
 	sprintf(s,"%s%08X%08X%08lX%08lX%08X%08lX"
 	       "%08X%08X%08X%08X%08X%08X%08X",
-		"070701",		/* magic */
+		do_csum ? "070702" : "070701", /* magic */
 		ino++,			/* ino */
 		mode,			/* mode */
 		(long) uid,		/* uid */
@@ -293,6 +296,29 @@ static int cpio_mknod_line(const char *line)
 	return rc;
 }
 
+static int cpio_mkfile_csum(int fd, unsigned long size, uint32_t *csum)
+{
+	while (size) {
+		unsigned char filebuf[65536];
+		ssize_t this_read;
+		size_t i, this_size = MIN(size, sizeof(filebuf));
+
+		this_read = read(fd, filebuf, this_size);
+		if (this_read <= 0 || this_read > this_size)
+			return -1;
+
+		for (i = 0; i < this_read; i++)
+			*csum += filebuf[i];
+
+		size -= this_read;
+	}
+	/* seek back to the start for data segment I/O */
+	if (lseek(fd, 0, SEEK_SET) < 0)
+		return -1;
+
+	return 0;
+}
+
 static int cpio_mkfile(const char *name, const char *location,
 			unsigned int mode, uid_t uid, gid_t gid,
 			unsigned int nlinks)
@@ -305,6 +331,7 @@ static int cpio_mkfile(const char *name, const char *location,
 	int rc = -1;
 	int namesize;
 	unsigned int i;
+	uint32_t csum = 0;
 
 	mode |= S_IFREG;
 
@@ -332,6 +359,11 @@ static int cpio_mkfile(const char *name, const char *location,
 		goto error;
 	}
 
+	if (do_csum && cpio_mkfile_csum(file, buf.st_size, &csum) < 0) {
+		fprintf(stderr, "Failed to checksum file %s\n", location);
+		goto error;
+	}
+
 	size = 0;
 	for (i = 1; i <= nlinks; i++) {
 		/* data goes on last link */
@@ -343,7 +375,7 @@ static int cpio_mkfile(const char *name, const char *location,
 		namesize = strlen(name) + 1;
 		sprintf(s,"%s%08X%08X%08lX%08lX%08X%08lX"
 		       "%08lX%08X%08X%08X%08X%08X%08X",
-			"070701",		/* magic */
+			do_csum ? "070702" : "070701", /* magic */
 			ino,			/* ino */
 			mode,			/* mode */
 			(long) uid,		/* uid */
@@ -356,7 +388,7 @@ static int cpio_mkfile(const char *name, const char *location,
 			0,			/* rmajor */
 			0,			/* rminor */
 			namesize,		/* namesize */
-			0);			/* chksum */
+			size ? csum : 0);	/* chksum */
 		push_hdr(s);
 		push_string(name);
 		push_pad();
@@ -464,7 +496,7 @@ static int cpio_mkfile_line(const char *line)
 static void usage(const char *prog)
 {
 	fprintf(stderr, "Usage:\n"
-		"\t%s [-t <timestamp>] <cpio_list>\n"
+		"\t%s [-t <timestamp>] [-c] <cpio_list>\n"
 		"\n"
 		"<cpio_list> is a file containing newline separated entries that\n"
 		"describe the files to be included in the initramfs archive:\n"
@@ -499,7 +531,8 @@ static void usage(const char *prog)
 		"\n"
 		"<timestamp> is time in seconds since Epoch that will be used\n"
 		"as mtime for symlinks, special files and directories. The default\n"
-		"is to use the current time for these entries.\n",
+		"is to use the current time for these entries.\n"
+		"-c: calculate and store 32-bit checksums for file data.\n",
 		prog);
 }
 
@@ -541,7 +574,7 @@ int main (int argc, char *argv[])
 
 	default_mtime = time(NULL);
 	while (1) {
-		int opt = getopt(argc, argv, "t:h");
+		int opt = getopt(argc, argv, "t:ch");
 		char *invalid;
 
 		if (opt == -1)
@@ -556,6 +589,9 @@ int main (int argc, char *argv[])
 				exit(1);
 			}
 			break;
+		case 'c':
+			do_csum = true;
+			break;
 		case 'h':
 		case '?':
 			usage(argv[0]);
-- 
2.34.1

