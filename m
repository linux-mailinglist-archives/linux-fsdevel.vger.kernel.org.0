Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81C5921D72
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2019 20:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729113AbfEQShF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 May 2019 14:37:05 -0400
Received: from hurricane.elijah.cs.cmu.edu ([128.2.209.191]:57646 "EHLO
        hurricane.elijah.cs.cmu.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729377AbfEQShD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 May 2019 14:37:03 -0400
Received: from jaharkes by hurricane.elijah.cs.cmu.edu with local (Exim 4.92)
        (envelope-from <jaharkes@hurricane.elijah.cs.cmu.edu>)
        id 1hRhj3-0000q7-HW; Fri, 17 May 2019 14:37:01 -0400
From:   Jan Harkes <jaharkes@cs.cmu.edu>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Jan Harkes <jaharkes@cs.cmu.edu>, linux-fsdevel@vger.kernel.org,
        Fabian Frederick <fabf@skynet.be>
Subject: [PATCH 20/22] coda: remove sysctl object from module when unused
Date:   Fri, 17 May 2019 14:36:58 -0400
Message-Id: <9afcc2cd09490849b309786bbf47fef75de7f91c.1558117389.git.jaharkes@cs.cmu.edu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1558117389.git.jaharkes@cs.cmu.edu>
References: <cover.1558117389.git.jaharkes@cs.cmu.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Fabian Frederick <fabf@skynet.be>

Inspired by NFS sysctl process

Signed-off-by: Fabian Frederick <fabf@skynet.be>
Signed-off-by: Jan Harkes <jaharkes@cs.cmu.edu>
---
 fs/coda/Makefile     |  3 ++-
 fs/coda/coda_int.h   | 10 ++++++++++
 fs/coda/coda_linux.h |  4 ----
 fs/coda/sysctl.c     | 11 -----------
 4 files changed, 12 insertions(+), 16 deletions(-)

diff --git a/fs/coda/Makefile b/fs/coda/Makefile
index 1bab69a0d347..30e4e1bd22bb 100644
--- a/fs/coda/Makefile
+++ b/fs/coda/Makefile
@@ -5,7 +5,8 @@
 obj-$(CONFIG_CODA_FS) += coda.o
 
 coda-objs := psdev.o cache.o cnode.o inode.o dir.o file.o upcall.o \
-	     coda_linux.o symlink.o pioctl.o sysctl.o 
+	     coda_linux.o symlink.o pioctl.o
+coda-$(CONFIG_SYSCTL) += sysctl.o
 
 # If you want debugging output, please uncomment the following line.
 
diff --git a/fs/coda/coda_int.h b/fs/coda/coda_int.h
index bb0b3e0ed6c2..f82b59c9dd28 100644
--- a/fs/coda/coda_int.h
+++ b/fs/coda/coda_int.h
@@ -13,9 +13,19 @@ extern int coda_fake_statfs;
 void coda_destroy_inodecache(void);
 int __init coda_init_inodecache(void);
 int coda_fsync(struct file *coda_file, loff_t start, loff_t end, int datasync);
+
+#ifdef CONFIG_SYSCTL
 void coda_sysctl_init(void);
 void coda_sysctl_clean(void);
+#else
+static inline void coda_sysctl_init(void)
+{
+}
 
+static inline void coda_sysctl_clean(void)
+{
+}
+#endif
 #endif  /*  _CODA_INT_  */
 
 
diff --git a/fs/coda/coda_linux.h b/fs/coda/coda_linux.h
index 517a363245c9..d5ebd36fb2cc 100644
--- a/fs/coda/coda_linux.h
+++ b/fs/coda/coda_linux.h
@@ -59,10 +59,6 @@ void coda_vattr_to_iattr(struct inode *, struct coda_vattr *);
 void coda_iattr_to_vattr(struct iattr *, struct coda_vattr *);
 unsigned short coda_flags_to_cflags(unsigned short);
 
-/* sysctl.h */
-void coda_sysctl_init(void);
-void coda_sysctl_clean(void);
-
 /* inode to cnode access functions */
 
 static inline struct coda_inode_info *ITOC(struct inode *inode)
diff --git a/fs/coda/sysctl.c b/fs/coda/sysctl.c
index 0301d45000a8..fda3b702b1c5 100644
--- a/fs/coda/sysctl.c
+++ b/fs/coda/sysctl.c
@@ -12,7 +12,6 @@
 
 #include "coda_int.h"
 
-#ifdef CONFIG_SYSCTL
 static struct ctl_table_header *fs_table_header;
 
 static struct ctl_table coda_table[] = {
@@ -62,13 +61,3 @@ void coda_sysctl_clean(void)
 		fs_table_header = NULL;
 	}
 }
-
-#else
-void coda_sysctl_init(void)
-{
-}
-
-void coda_sysctl_clean(void)
-{
-}
-#endif
-- 
2.20.1

