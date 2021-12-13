Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05AFD473873
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Dec 2021 00:27:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244154AbhLMX1u (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Dec 2021 18:27:50 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:46226 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242103AbhLMX1s (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Dec 2021 18:27:48 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 3DE0A1F3C6;
        Mon, 13 Dec 2021 23:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1639438067; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mDlw3+F/2XMD4uChHoYTT839HaCwSlUPxhDd/Rgnxpo=;
        b=TcemtsPrEEprKUEcJOdcVX8GhbsreAo9v8QDRhw+3p6jBHgR7Z+k0IkdIkwfyIHlXYkdio
        eOWl/WzYf8+OOPxyRpqXFPfgx+V+XuKrWJkYiU5738JYpE+nEQJOZrgNt6zIQHkgfnOB52
        aeyBJGzHP59R+6+I7c05rsostFKoylQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1639438067;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mDlw3+F/2XMD4uChHoYTT839HaCwSlUPxhDd/Rgnxpo=;
        b=vCrOx8+8n1QopirrSKZG5j0TZZR5J02GlzgTT0h/tC6TTK2q9nZMBqBJdzZA5fm+MfMXWD
        TdcvnQwtNPizkqCg==
Received: from echidna.suse.de (unknown [10.163.47.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 12807A3B87;
        Mon, 13 Dec 2021 23:27:47 +0000 (UTC)
From:   David Disseldorp <ddiss@suse.de>
To:     linux-fsdevel@vger.kernel.org
Cc:     Martin Wilck <mwilck@suse.com>, viro@zeniv.linux.org.uk,
        willy@infradead.org, David Disseldorp <ddiss@suse.de>
Subject: [PATCH v5 5/5] initramfs: support cpio extraction with file checksums
Date:   Tue, 14 Dec 2021 00:20:08 +0100
Message-Id: <20211213232007.26851-6-ddiss@suse.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211213232007.26851-1-ddiss@suse.de>
References: <20211213232007.26851-1-ddiss@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add support for the extraction of crc-enabled "070702" cpio archives, as
specified in Documentation/driver-api/early-userspace/buffer-format.rst.
Fail extraction if the calculated file data checksum doesn't match the
value carried in the header.

Suggested-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: David Disseldorp <ddiss@suse.de>
---
 init/initramfs.c | 32 +++++++++++++++++++++++++-------
 1 file changed, 25 insertions(+), 7 deletions(-)

diff --git a/init/initramfs.c b/init/initramfs.c
index 5b4ca8ecadb5..ead3e2839f44 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -19,8 +19,11 @@
 
 #include "initramfs_mtime.h"
 
-static ssize_t __init xwrite(struct file *file, const char *p, size_t count,
-		loff_t *pos)
+static __initdata bool csum_present;
+static __initdata u32 io_csum;
+
+static ssize_t __init xwrite(struct file *file, const unsigned char *p,
+		size_t count, loff_t *pos)
 {
 	ssize_t out = 0;
 
@@ -35,6 +38,13 @@ static ssize_t __init xwrite(struct file *file, const char *p, size_t count,
 		} else if (rv == 0)
 			break;
 
+		if (csum_present) {
+			ssize_t i;
+
+			for (i = 0; i < rv; i++)
+				io_csum += p[i];
+		}
+
 		p += rv;
 		out += rv;
 		count -= rv;
@@ -118,8 +128,6 @@ static void __init free_hash(void)
 	}
 }
 
-static __initdata time64_t mtime;
-
 /* cpio header parsing */
 
 static __initdata unsigned long ino, major, minor, nlink;
@@ -128,15 +136,17 @@ static __initdata unsigned long body_len, name_len;
 static __initdata uid_t uid;
 static __initdata gid_t gid;
 static __initdata unsigned rdev;
+static __initdata time64_t mtime;
+static __initdata u32 hdr_csum;
 
 static void __init parse_header(char *s)
 {
-	unsigned long parsed[12];
+	unsigned long parsed[13];
 	char buf[9];
 	int i;
 
 	buf[8] = '\0';
-	for (i = 0, s += 6; i < 12; i++, s += 8) {
+	for (i = 0, s += 6; i < 13; i++, s += 8) {
 		memcpy(buf, s, 8);
 		parsed[i] = simple_strtoul(buf, NULL, 16);
 	}
@@ -151,6 +161,7 @@ static void __init parse_header(char *s)
 	minor = parsed[8];
 	rdev = new_encode_dev(MKDEV(parsed[9], parsed[10]));
 	name_len = parsed[11];
+	hdr_csum = parsed[12];
 }
 
 /* FSM */
@@ -219,7 +230,11 @@ static int __init do_collect(void)
 
 static int __init do_header(void)
 {
-	if (memcmp(collected, "070701", 6)) {
+	if (!memcmp(collected, "070701", 6)) {
+		csum_present = false;
+	} else if (!memcmp(collected, "070702", 6)) {
+		csum_present = true;
+	} else {
 		if (memcmp(collected, "070707", 6) == 0)
 			error("incorrect cpio method used: use -H newc option");
 		else
@@ -314,6 +329,7 @@ static int __init do_name(void)
 			if (IS_ERR(wfile))
 				return 0;
 			wfile_pos = 0;
+			io_csum = 0;
 
 			vfs_fchown(wfile, uid, gid);
 			vfs_fchmod(wfile, mode);
@@ -346,6 +362,8 @@ static int __init do_copy(void)
 
 		do_utime_path(&wfile->f_path, mtime);
 		fput(wfile);
+		if (csum_present && io_csum != hdr_csum)
+			error("bad data checksum");
 		eat(body_len);
 		state = SkipIt;
 		return 0;
-- 
2.31.1

