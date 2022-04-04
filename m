Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 151F04F1221
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Apr 2022 11:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354435AbiDDJhn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Apr 2022 05:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354403AbiDDJhi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Apr 2022 05:37:38 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2C443055A
        for <linux-fsdevel@vger.kernel.org>; Mon,  4 Apr 2022 02:35:42 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 96ED11F385;
        Mon,  4 Apr 2022 09:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1649064941; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Nr4+JUuKqAb66yzKMQ4LW8zmnnq4vp4Nkuufy73+L/M=;
        b=B1rCrYCW/X3l7QH0WQLktBrtLi/fPsnAIvai0HjZZe30XcB+RfT375z3rJ+NdVOrcPusJY
        QjR0CjABYB7KutLMJ6ZEETBoVDk6hamCqQY+P/gfcgjGt+2akKzvcWwS7m4Hq64OEn2YMg
        dXs5mszoa8DjVOdRBgLBoTAzbCZvKTk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1649064941;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Nr4+JUuKqAb66yzKMQ4LW8zmnnq4vp4Nkuufy73+L/M=;
        b=Xz28gIEQZFe94lL2UOl77KTMwrRwNULbN0vIblvjhijOlJWHiz/4DEP3Fkvg7o8luQShVT
        67eYACPvHYDpTdAA==
Received: from echidna.suse.de (unknown [10.163.47.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 6A270A3B89;
        Mon,  4 Apr 2022 09:35:41 +0000 (UTC)
From:   David Disseldorp <ddiss@suse.de>
To:     linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     viro@zeniv.linux.org.uk, willy@infradead.org,
        David Disseldorp <ddiss@suse.de>,
        Martin Wilck <mwilck@suse.com>
Subject: [PATCH v7 4/6] gen_init_cpio: fix short read file handling
Date:   Mon,  4 Apr 2022 11:34:28 +0200
Message-Id: <20220404093429.27570-5-ddiss@suse.de>
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

When processing a "file" entry, gen_init_cpio attempts to allocate a
buffer large enough to stage the entire contents of the source file.
It then attempts to fill the buffer via a single read() call and
subsequently writes out the entire buffer length, without checking that
read() returned the full length, potentially writing uninitialized
buffer memory.

Fix this by breaking up file I/O into 64k chunks and only writing the
length returned by the prior read() call.

Signed-off-by: David Disseldorp <ddiss@suse.de>
Reviewed-by: Martin Wilck <mwilck@suse.com>
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
2.34.1

