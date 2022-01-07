Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBA5648784F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jan 2022 14:38:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347616AbiAGNi2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Jan 2022 08:38:28 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:44126 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347609AbiAGNiZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Jan 2022 08:38:25 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 3FD051F3A2;
        Fri,  7 Jan 2022 13:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1641562704; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a1M3BktK5WSpmRIcwuj0jxFaJnOUMmNc659XQjpfM3Q=;
        b=t1myR8V2M3A+scrb7ipawdhcW3xDvW69NeHPh4SICjV3QocRl6VFQxBWukxDBz4sgsQNA0
        knZPSU4vjctmA+7zLzJ7NvRigGHCgWl9pLzRz73suImWFU9Evv0qs4sZTqMf1hvIgUM0Lw
        s55hFbslTmwZS9P5uYccHCoUeA6r2Tw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1641562704;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a1M3BktK5WSpmRIcwuj0jxFaJnOUMmNc659XQjpfM3Q=;
        b=M0yiQefBMQFkRJoGB3w1uJF5qtNaLdycRBG5Iq8ob/08mMzOScifhvAdJbra8tPrWgU7sy
        ZI4rrJF9j7I/bPBg==
Received: from echidna.suse.de (ddiss.udp.ovpn2.nue.suse.de [10.163.47.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 15CC1A3B89;
        Fri,  7 Jan 2022 13:38:24 +0000 (UTC)
From:   David Disseldorp <ddiss@suse.de>
To:     linux-fsdevel@vger.kernel.org
Cc:     Martin Wilck <mwilck@suse.com>, viro@zeniv.linux.org.uk,
        willy@infradead.org, David Disseldorp <ddiss@suse.de>
Subject: [PATCH v6 6/6] initramfs: support cpio extraction with file checksums
Date:   Fri,  7 Jan 2022 14:38:14 +0100
Message-Id: <20220107133814.32655-7-ddiss@suse.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220107133814.32655-1-ddiss@suse.de>
References: <20220107133814.32655-1-ddiss@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add support for extraction of checksum-enabled "070702" cpio archives,
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

