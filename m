Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31AF855A92A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Jun 2022 13:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232708AbiFYLBs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 25 Jun 2022 07:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232539AbiFYLBm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 25 Jun 2022 07:01:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24A7533E9A;
        Sat, 25 Jun 2022 04:01:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8D8DD6115D;
        Sat, 25 Jun 2022 11:01:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71245C3411C;
        Sat, 25 Jun 2022 11:01:39 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="K6s2gBOo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1656154898;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tpxB37bu5WqdF11Jy/CFE5HTN7ST9k5G7HR0wTYcqm0=;
        b=K6s2gBOo/W3UbjJiSgX01jXqc74nz06L7YAU5m4lkP8io0FRa3RhPm2oRr3GEo165devAU
        NnDkvC0nh47Wuj2TcJSnSvK6Bv69h9JeVPxiiVKPTvrGQMM4VWe+KXXamZ7a92/enD13TX
        NuFlGQ2NkStBLSnmjhULIA+lywN5/Fw=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id bbc5b776 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Sat, 25 Jun 2022 11:01:38 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH v2 6/8] fs: remove no_llseek
Date:   Sat, 25 Jun 2022 13:01:13 +0200
Message-Id: <20220625110115.39956-7-Jason@zx2c4.com>
In-Reply-To: <20220625110115.39956-1-Jason@zx2c4.com>
References: <20220625110115.39956-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now that all callers of ->llseek are going through vfs_llseek(), we
don't gain anything by keeping no_llseek around. Nothing compares it or
calls it.

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 fs/read_write.c    | 16 +++-------------
 include/linux/fs.h |  1 -
 2 files changed, 3 insertions(+), 14 deletions(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index b1b1cdfee9d3..f0ecfd0fb843 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -227,12 +227,6 @@ loff_t noop_llseek(struct file *file, loff_t offset, int whence)
 }
 EXPORT_SYMBOL(noop_llseek);
 
-loff_t no_llseek(struct file *file, loff_t offset, int whence)
-{
-	return -ESPIPE;
-}
-EXPORT_SYMBOL(no_llseek);
-
 loff_t default_llseek(struct file *file, loff_t offset, int whence)
 {
 	struct inode *inode = file_inode(file);
@@ -290,14 +284,10 @@ EXPORT_SYMBOL(default_llseek);
 
 loff_t vfs_llseek(struct file *file, loff_t offset, int whence)
 {
-	loff_t (*fn)(struct file *, loff_t, int);
+	if ((file->f_mode & FMODE_LSEEK) && file->f_op->llseek)
+		return file->f_op->llseek(file, offset, whence);
+	return -ESPIPE;
 
-	fn = no_llseek;
-	if (file->f_mode & FMODE_LSEEK) {
-		if (file->f_op->llseek)
-			fn = file->f_op->llseek;
-	}
-	return fn(file, offset, whence);
 }
 EXPORT_SYMBOL(vfs_llseek);
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 9ad5e3520fae..0cb5a1706e1f 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3022,7 +3022,6 @@ extern long do_splice_direct(struct file *in, loff_t *ppos, struct file *out,
 extern void
 file_ra_state_init(struct file_ra_state *ra, struct address_space *mapping);
 extern loff_t noop_llseek(struct file *file, loff_t offset, int whence);
-extern loff_t no_llseek(struct file *file, loff_t offset, int whence);
 extern loff_t vfs_setpos(struct file *file, loff_t offset, loff_t maxsize);
 extern loff_t generic_file_llseek(struct file *file, loff_t offset, int whence);
 extern loff_t generic_file_llseek_size(struct file *file, loff_t offset,
-- 
2.35.1

