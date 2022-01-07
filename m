Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC59648784E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jan 2022 14:38:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347602AbiAGNi1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Jan 2022 08:38:27 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:50264 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238886AbiAGNiZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Jan 2022 08:38:25 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id CF1B0212B8;
        Fri,  7 Jan 2022 13:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1641562703; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dT3bNEkeoqlQtpJ1IGL9Z6s5aNZ4925QHeV43AShAkw=;
        b=Y1sEYz+B6YGl0+BDwuXBxCclvNONiO1U/wqzwp7+917dgaoV723r4/3yOC2NRAe4ZJBtSN
        M5U5yBJ1uPoXLbloWhbnZvVj4fMXBjs30yozbK5OO7tBXT9L1yPSXn9NPpPrHCb0Sdi3Zz
        BbUQF1knyI1WTFFN/MHVMl4uw8ktFDc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1641562703;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dT3bNEkeoqlQtpJ1IGL9Z6s5aNZ4925QHeV43AShAkw=;
        b=vBwEVJGfFblLcwVbfBi6Z4sDWrEYOfHCZULWrXDvgA62cEP9KW02M/iBBThi/QSUmj4VgG
        zZPYZf4Iu+DXsCCw==
Received: from echidna.suse.de (ddiss.udp.ovpn2.nue.suse.de [10.163.47.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id A4348A3B87;
        Fri,  7 Jan 2022 13:38:23 +0000 (UTC)
From:   David Disseldorp <ddiss@suse.de>
To:     linux-fsdevel@vger.kernel.org
Cc:     Martin Wilck <mwilck@suse.com>, viro@zeniv.linux.org.uk,
        willy@infradead.org, David Disseldorp <ddiss@suse.de>
Subject: [PATCH v6 4/6] gen_init_cpio: fix short read file handling
Date:   Fri,  7 Jan 2022 14:38:12 +0100
Message-Id: <20220107133814.32655-5-ddiss@suse.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220107133814.32655-1-ddiss@suse.de>
References: <20220107133814.32655-1-ddiss@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When processing a "file" entry, gen_init_cpio attempts to allocate a
buffer large enough to stage the entire contents of the source file.
It then attempts to fill the buffer via a single read() call and
subsequently writes out the entire buffer length, without checking that
read() returned the full length, potentially writing uninitialized
buffer memory.

Fix this by breaking up file I/O into 64k chunks and only writing the
length returned by the prior read() call.

Signed-off-by: David Disseldorp <ddiss@suse.de>
---
 usr/gen_init_cpio.c | 44 +++++++++++++++++++++++++-------------------
 1 file changed, 25 insertions(+), 19 deletions(-)

diff --git a/usr/gen_init_cpio.c b/usr/gen_init_cpio.c
index 0e2c8a5838b1..9a0f8c37273a 100644
--- a/usr/gen_init_cpio.c
+++ b/usr/gen_init_cpio.c
@@ -20,6 +20,7 @@
 
 #define xstr(s) #s
 #define str(s) xstr(s)
+#define MIN(a, b) ((a) < (b) ? (a) : (b))
 
 static unsigned int offset;
 static unsigned int ino = 721;
@@ -297,9 +298,8 @@ static int cpio_mkfile(const char *name, const char *location,
 			unsigned int nlinks)
 {
 	char s[256];
-	char *filebuf = NULL;
 	struct stat buf;
-	long size;
+	unsigned long size;
 	int file = -1;
 	int retval;
 	int rc = -1;
@@ -326,22 +326,17 @@ static int cpio_mkfile(const char *name, const char *location,
 		buf.st_mtime = 0xffffffff;
 	}
 
-	filebuf = malloc(buf.st_size);
-	if (!filebuf) {
-		fprintf (stderr, "out of memory\n");
-		goto error;
-	}
-
-	retval = read (file, filebuf, buf.st_size);
-	if (retval < 0) {
-		fprintf (stderr, "Can not read %s file\n", location);
+	if (buf.st_size > 0xffffffff) {
+		fprintf(stderr, "%s: Size exceeds maximum cpio file size\n",
+			location);
 		goto error;
 	}
 
 	size = 0;
 	for (i = 1; i <= nlinks; i++) {
 		/* data goes on last link */
-		if (i == nlinks) size = buf.st_size;
+		if (i == nlinks)
+			size = buf.st_size;
 
 		if (name[0] == '/')
 			name++;
@@ -366,23 +361,34 @@ static int cpio_mkfile(const char *name, const char *location,
 		push_string(name);
 		push_pad();
 
-		if (size) {
-			if (fwrite(filebuf, size, 1, stdout) != 1) {
+		while (size) {
+			unsigned char filebuf[65536];
+			ssize_t this_read;
+			size_t this_size = MIN(size, sizeof(filebuf));
+
+			this_read = read(file, filebuf, this_size);
+			if (this_read <= 0 || this_read > this_size) {
+				fprintf(stderr, "Can not read %s file\n", location);
+				goto error;
+			}
+
+			if (fwrite(filebuf, this_read, 1, stdout) != 1) {
 				fprintf(stderr, "writing filebuf failed\n");
 				goto error;
 			}
-			offset += size;
-			push_pad();
+			offset += this_read;
+			size -= this_read;
 		}
+		push_pad();
 
 		name += namesize;
 	}
 	ino++;
 	rc = 0;
-	
+
 error:
-	if (filebuf) free(filebuf);
-	if (file >= 0) close(file);
+	if (file >= 0)
+		close(file);
 	return rc;
 }
 
-- 
2.31.1

