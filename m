Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADD5E4F1224
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Apr 2022 11:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354561AbiDDJhr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Apr 2022 05:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343889AbiDDJhj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Apr 2022 05:37:39 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 530B230F5C
        for <linux-fsdevel@vger.kernel.org>; Mon,  4 Apr 2022 02:35:43 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id F09821F38A;
        Mon,  4 Apr 2022 09:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1649064941; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2v1QHuFh5RvBUDZ3GhDpQbLd1C9TE8Ju0wE/C0DyvzU=;
        b=j1QOHMtphQuj7V8F321Fs/gDSy8UAnNvoWPDMcDDTRKhC0nZBOTqa0LmUL7rP/b3BgvyMF
        hqoPWAJvHC4YPzBRRntm5fuRHImcIyufV2834vfFORLLDRzDI5roG8P/AlZhROcwR/fCjB
        8FEQOtbMnBSnw0vxRNEh2tB7XqCv/CM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1649064941;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2v1QHuFh5RvBUDZ3GhDpQbLd1C9TE8Ju0wE/C0DyvzU=;
        b=OxEFsuFIdmGlhglQdhXuHcvb2uoM+i+Vs8KDXuubqgJ8hGcSU2yOxrKdy4dH20wOaIW6vg
        gmomtnTbKNWzR4DQ==
Received: from echidna.suse.de (unknown [10.163.47.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id C9AF2A3B92;
        Mon,  4 Apr 2022 09:35:41 +0000 (UTC)
From:   David Disseldorp <ddiss@suse.de>
To:     linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     viro@zeniv.linux.org.uk, willy@infradead.org,
        David Disseldorp <ddiss@suse.de>
Subject: [PATCH v7 6/6] initramfs: support cpio extraction with file checksums
Date:   Mon,  4 Apr 2022 11:34:30 +0200
Message-Id: <20220404093429.27570-7-ddiss@suse.de>
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

Add support for extraction of checksum-enabled "070702" cpio archives,
specified in Documentation/driver-api/early-userspace/buffer-format.rst.
Fail extraction if the calculated file data checksum doesn't match the
value carried in the header.

Suggested-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: David Disseldorp <ddiss@suse.de>
---
 init/initramfs.c | 29 ++++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/init/initramfs.c b/init/initramfs.c
index b5bfed859fa9..dc84cf756cea 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -17,8 +17,11 @@
 #include <linux/init_syscalls.h>
 #include <linux/umh.h>
 
-static ssize_t __init xwrite(struct file *file, const char *p, size_t count,
-		loff_t *pos)
+static __initdata bool csum_present;
+static __initdata u32 io_csum;
+
+static ssize_t __init xwrite(struct file *file, const unsigned char *p,
+		size_t count, loff_t *pos)
 {
 	ssize_t out = 0;
 
@@ -33,6 +36,13 @@ static ssize_t __init xwrite(struct file *file, const char *p, size_t count,
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
@@ -176,15 +186,16 @@ static __initdata unsigned long body_len, name_len;
 static __initdata uid_t uid;
 static __initdata gid_t gid;
 static __initdata unsigned rdev;
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
@@ -199,6 +210,7 @@ static void __init parse_header(char *s)
 	minor = parsed[8];
 	rdev = new_encode_dev(MKDEV(parsed[9], parsed[10]));
 	name_len = parsed[11];
+	hdr_csum = parsed[12];
 }
 
 /* FSM */
@@ -267,7 +279,11 @@ static int __init do_collect(void)
 
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
@@ -362,6 +378,7 @@ static int __init do_name(void)
 			if (IS_ERR(wfile))
 				return 0;
 			wfile_pos = 0;
+			io_csum = 0;
 
 			vfs_fchown(wfile, uid, gid);
 			vfs_fchmod(wfile, mode);
@@ -394,6 +411,8 @@ static int __init do_copy(void)
 
 		do_utime_path(&wfile->f_path, mtime);
 		fput(wfile);
+		if (csum_present && io_csum != hdr_csum)
+			error("bad data checksum");
 		eat(body_len);
 		state = SkipIt;
 		return 0;
-- 
2.34.1

