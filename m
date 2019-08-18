Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 594B49181A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Aug 2019 19:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbfHRQ7w (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 18 Aug 2019 12:59:52 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39837 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727117AbfHRQ7v (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 18 Aug 2019 12:59:51 -0400
Received: by mail-pl1-f196.google.com with SMTP id z3so4644620pln.6;
        Sun, 18 Aug 2019 09:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZDn2Y98kbbO22z0K+xR+AWtcv4GaQ+wX4PQ2vNgnGx0=;
        b=HZZECivaaHUGQpuuX/FAHVzlTJJLx3E0iyKj9ADCKY61mBIlC5TV6Os3rc0pFt/dsX
         KW+haRJEzqY16CKn9IDlmyyilH20DyykTBymCfAofasTklaRwyZo/hnoqEGvxfnBeduZ
         PKWJORpP5BCid1bVmi0Drt+kDcXrgwe7DOPlpA6/zveCSo9KO9uL2XF3NHSwduc1bkDI
         FqSFh8NhKnA2zZP9yFNfSNpDogJrGh1Twfb1cX5tNaeKwzI2l4Cta4NWdIT2+DiHKTHG
         wz4IzZdvnZ0+nCOZMpFFJkhk/dOFeJy5j5nUoUuOTIDnNoh9/uvfcMDkyHj0+XCJYFbU
         oLow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZDn2Y98kbbO22z0K+xR+AWtcv4GaQ+wX4PQ2vNgnGx0=;
        b=VAEOC1RCvOHsNMXC3RJ9Mdh4C7NgxJlezRO+TbYLwcShyWjXnh+/pkwd5E+PuZJSE9
         gV8PoFsE+tSSD8ZMiu+Vp3Vw9ozMfRozCfcEE39EbsVf8S+xFSF+kvzFSA/rZ8WgD9gj
         /Ou55M8sYPGC3vOtrT9K/9Nc4ynFEkeY0TgjLIFGPIcswbXTZBh+CcnLvsFmknqSXwcq
         vSoW5euLVid9ShOrO2+UxSps5tJgSQgW7zxaet/mtYFJSxf4RqUW80MPEK0eit4akxFs
         49AWbaR0zcAdZIBtkjR887BQYrWvp3d9FoMQKDzzNZdBijSuDGrJ5U3dnvr1SRi3hWPl
         Ofkw==
X-Gm-Message-State: APjAAAUYesR2noT8JbRYqsYTEznSHW3yOJKCbSn84Gdo4e/0WSLQyHwB
        acS978Ixb/mLVxjGdmOPYeM=
X-Google-Smtp-Source: APXvYqwDEc/zbsCzxpbWInKA8ux4ee6fNVm2CdnwLU0UTK0TDNa6JvgW7VDUpgedC65jtR4bP/diQw==
X-Received: by 2002:a17:902:d90a:: with SMTP id c10mr18269442plz.208.1566147590877;
        Sun, 18 Aug 2019 09:59:50 -0700 (PDT)
Received: from deepa-ubuntu.lan (c-98-234-52-230.hsd1.ca.comcast.net. [98.234.52.230])
        by smtp.gmail.com with ESMTPSA id b136sm15732831pfb.73.2019.08.18.09.59.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2019 09:59:50 -0700 (PDT)
From:   Deepa Dinamani <deepa.kernel@gmail.com>
To:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, y2038@lists.linaro.org,
        arnd@arndb.de
Subject: [PATCH v8 08/20] adfs: Fill in max and min timestamps in sb
Date:   Sun, 18 Aug 2019 09:58:05 -0700
Message-Id: <20190818165817.32634-9-deepa.kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190818165817.32634-1-deepa.kernel@gmail.com>
References: <20190818165817.32634-1-deepa.kernel@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fill in the appropriate limits to avoid inconsistencies
in the vfs cached inode times when timestamps are
outside the permitted range.

Note that the min timestamp is assumed to be
01 Jan 1970 00:00:00 (Unix epoch). This is consistent
with the way we convert timestamps in adfs_adfs2unix_time().

Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
---
 fs/adfs/adfs.h  | 13 +++++++++++++
 fs/adfs/inode.c |  8 ++------
 fs/adfs/super.c |  2 ++
 3 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/fs/adfs/adfs.h b/fs/adfs/adfs.h
index b7e844d2f321..dca8b23aa43f 100644
--- a/fs/adfs/adfs.h
+++ b/fs/adfs/adfs.h
@@ -3,6 +3,19 @@
 #include <linux/fs.h>
 #include <linux/adfs_fs.h>
 
+/*
+ * 01 Jan 1970 00:00:00 (Unix epoch) as seconds since
+ * 01 Jan 1900 00:00:00 (RISC OS epoch)
+ */
+#define RISC_OS_EPOCH_DELTA 2208988800LL
+
+/*
+ * Convert 40 bit centi seconds to seconds
+ * since 01 Jan 1900 00:00:00 (RISC OS epoch)
+ * The result is 2248-06-03 06:57:57 GMT
+ */
+#define ADFS_MAX_TIMESTAMP ((0xFFFFFFFFFFLL / 100) - RISC_OS_EPOCH_DELTA)
+
 /* Internal data structures for ADFS */
 
 #define ADFS_FREE_FRAG		 0
diff --git a/fs/adfs/inode.c b/fs/adfs/inode.c
index 124de75413a5..41eca1c451dc 100644
--- a/fs/adfs/inode.c
+++ b/fs/adfs/inode.c
@@ -167,11 +167,7 @@ static void
 adfs_adfs2unix_time(struct timespec64 *tv, struct inode *inode)
 {
 	unsigned int high, low;
-	/* 01 Jan 1970 00:00:00 (Unix epoch) as nanoseconds since
-	 * 01 Jan 1900 00:00:00 (RISC OS epoch)
-	 */
-	static const s64 nsec_unix_epoch_diff_risc_os_epoch =
-							2208988800000000000LL;
+	static const s64 nsec_unix_epoch_diff_risc_os_epoch = RISC_OS_EPOCH_DELTA * NSEC_PER_SEC;
 	s64 nsec;
 
 	if (!adfs_inode_is_stamped(inode))
@@ -216,7 +212,7 @@ adfs_unix2adfs_time(struct inode *inode, unsigned int secs)
 	if (adfs_inode_is_stamped(inode)) {
 		/* convert 32-bit seconds to 40-bit centi-seconds */
 		low  = (secs & 255) * 100;
-		high = (secs / 256) * 100 + (low >> 8) + 0x336e996a;
+		high = (secs / 256) * 100 + (low >> 8) + (RISC_OS_EPOCH_DELTA*100/256);
 
 		ADFS_I(inode)->loadaddr = (high >> 24) |
 				(ADFS_I(inode)->loadaddr & ~0xff);
diff --git a/fs/adfs/super.c b/fs/adfs/super.c
index 65b04ebb51c3..f074fe7d7158 100644
--- a/fs/adfs/super.c
+++ b/fs/adfs/super.c
@@ -463,6 +463,8 @@ static int adfs_fill_super(struct super_block *sb, void *data, int silent)
 	asb->s_map_size		= dr->nzones | (dr->nzones_high << 8);
 	asb->s_map2blk		= dr->log2bpmb - dr->log2secsize;
 	asb->s_log2sharesize	= dr->log2sharesize;
+	sb->s_time_min		= 0;
+	sb->s_time_max		= ADFS_MAX_TIMESTAMP;
 
 	asb->s_map = adfs_read_map(sb, dr);
 	if (IS_ERR(asb->s_map)) {
-- 
2.17.1

