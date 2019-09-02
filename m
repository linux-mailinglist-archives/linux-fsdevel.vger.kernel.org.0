Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A702A5C9F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2019 21:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbfIBTQW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Sep 2019 15:16:22 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39575 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726937AbfIBTQW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Sep 2019 15:16:22 -0400
Received: by mail-pf1-f195.google.com with SMTP id s12so2387897pfe.6;
        Mon, 02 Sep 2019 12:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=oVYAlVrZfSgGuhdp8J1bJOh+7e8+KCFSvF87G3dnuqA=;
        b=aQfs6DZWBspomDmj03PMKcrzoihdwGAFfddUfiMnPgm1hPtLEKwFNj8yZHEl3vicgW
         icwFH52dChjMJ1dWfy66+x//XfKaeFMnkeh+/uifDY7vp2XjEcmeMxdwR6W5b5EPqCho
         0AHQJ3lwMSfXnQle/zkFtjUKJtHMYnyFYN+tA+aSQzW57seUO/IAtuS1AjFyz8mpF+4b
         u7JiGLbIUL8RoeFG6dw+xKWO+gMtaKuEHOgpBmNOdB7LGnxbK9ALV4STRJ9A3URnrUqp
         kzoxtbmEZCuN7b0FlFPDy41xVEOFJ2enkv7inhcUh8F8t/fnDYX0pfgfHoa+Niq2NeR5
         XNEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=oVYAlVrZfSgGuhdp8J1bJOh+7e8+KCFSvF87G3dnuqA=;
        b=NANDy0YmyqmxlTmozcyPhK9AloJXe6xWp8+et0Thr9j0CKgZ0l/pZM2t4dplEl0Xl7
         wU9riEEaJOytXvYOZd+JoJ85fwxQkQ9eXKWDDntrk9Stox7yCzQ8J5xoE1i6AlY/yCRP
         vMyR+1HOL83jHD9E0xAI1J+jyqUjOC5KSzTWnp2fcuPE3b8fheXtHRf5hDsQwJ7wqPo3
         g+gwBKRa83oEz2SUDVMe5YesbufEkJ2gOgW7MIOPg8uMoj5gX9XT3gxUzDiYA8ASdwY5
         TQAYp9H6gzfdwob89F2muCr8DdFK3hqlF9RdaadJHS/ScvwGCX8dFbGDceREu/BPwdQN
         RW8g==
X-Gm-Message-State: APjAAAVHSQ0bV3ePY3+u+iR0drvSqJ9OKBGMplypDBsbQFtEsJRY2yBQ
        XcDnugjVAGFXHs8fEHihRtU=
X-Google-Smtp-Source: APXvYqxxdFKA/8zfsRJSWBrXDIOku7j0IfD0ot3/W6xQOB4IhKcz/UTJl3JSizGbGLLcQDfi+OARxw==
X-Received: by 2002:a17:90a:c694:: with SMTP id n20mr14181605pjt.24.1567451781462;
        Mon, 02 Sep 2019 12:16:21 -0700 (PDT)
Received: from deepa-ubuntu.lan (c-98-234-52-230.hsd1.ca.comcast.net. [98.234.52.230])
        by smtp.gmail.com with ESMTPSA id o35sm13021420pgm.29.2019.09.02.12.16.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2019 12:16:20 -0700 (PDT)
From:   Deepa Dinamani <deepa.kernel@gmail.com>
To:     linux@armlinux.org.uk, linux-kernel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, arnd@arndb.de,
        y2038@lists.linaro.org
Subject: [PATCH] adfs: Fill in max and min timestamps in sb
Date:   Mon,  2 Sep 2019 12:12:31 -0700
Message-Id: <20190902191231.13346-1-deepa.kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
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

This depends on the following patch in Arnd's y2038 tree:
https://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground y2038
188d20bcd1eb ("vfs: Add file timestamp range support")

 fs/adfs/adfs.h  | 13 +++++++++++++
 fs/adfs/inode.c |  8 ++++----
 fs/adfs/super.c |  2 ++
 3 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/fs/adfs/adfs.h b/fs/adfs/adfs.h
index 699c4fa8b78b..504ad80072ef 100644
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
index 5b8017ab0a98..11acd74fb099 100644
--- a/fs/adfs/inode.c
+++ b/fs/adfs/inode.c
@@ -162,7 +162,10 @@ static int adfs_mode2atts(struct super_block *sb, struct inode *inode,
 	return attr;
 }
 
-static const s64 nsec_unix_epoch_diff_risc_os_epoch = 2208988800000000000LL;
+/* 01 Jan 1970 00:00:00 (Unix epoch) as nanoseconds since
+ * 01 Jan 1900 00:00:00 (RISC OS epoch)
+ */
+static const s64 nsec_unix_epoch_diff_risc_os_epoch = RISC_OS_EPOCH_DELTA * NSEC_PER_SEC;
 
 /*
  * Convert an ADFS time to Unix time.  ADFS has a 40-bit centi-second time
@@ -173,9 +176,6 @@ static void
 adfs_adfs2unix_time(struct timespec64 *tv, struct inode *inode)
 {
 	unsigned int high, low;
-	/* 01 Jan 1970 00:00:00 (Unix epoch) as nanoseconds since
-	 * 01 Jan 1900 00:00:00 (RISC OS epoch)
-	 */
 	s64 nsec;
 
 	if (!adfs_inode_is_stamped(inode))
diff --git a/fs/adfs/super.c b/fs/adfs/super.c
index 7a3e6b394f2a..532e2afbc7a3 100644
--- a/fs/adfs/super.c
+++ b/fs/adfs/super.c
@@ -381,6 +381,8 @@ static int adfs_fill_super(struct super_block *sb, void *data, int silent)
 	sb->s_fs_info = asb;
 	sb->s_magic = ADFS_SUPER_MAGIC;
 	sb->s_time_gran = 10000000;
+	sb->s_time_min = 0;
+	sb->s_time_max = ADFS_MAX_TIMESTAMP;
 
 	/* set default options */
 	asb->s_uid = GLOBAL_ROOT_UID;
-- 
2.17.1

