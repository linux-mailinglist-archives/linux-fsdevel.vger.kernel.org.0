Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFB9C21D77
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2019 20:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729090AbfEQShP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 May 2019 14:37:15 -0400
Received: from hurricane.elijah.cs.cmu.edu ([128.2.209.191]:57610 "EHLO
        hurricane.elijah.cs.cmu.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729372AbfEQShC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 May 2019 14:37:02 -0400
Received: from jaharkes by hurricane.elijah.cs.cmu.edu with local (Exim 4.92)
        (envelope-from <jaharkes@hurricane.elijah.cs.cmu.edu>)
        id 1hRhj3-0000pb-80; Fri, 17 May 2019 14:37:01 -0400
From:   Jan Harkes <jaharkes@cs.cmu.edu>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Jan Harkes <jaharkes@cs.cmu.edu>, linux-fsdevel@vger.kernel.org,
        David Howells <dhowells@redhat.com>
Subject: [PATCH 15/22] coda: Move internal defs out of include/linux/ [ver #2]
Date:   Fri, 17 May 2019 14:36:53 -0400
Message-Id: <3ceeee0415a929b89fb02700b6b4b3a07938acb8.1558117389.git.jaharkes@cs.cmu.edu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1558117389.git.jaharkes@cs.cmu.edu>
References: <cover.1558117389.git.jaharkes@cs.cmu.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

Move include/linux/coda_psdev.h to fs/coda/ as there's nothing else that
uses it.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Yann Droneaud <ydroneaud@opteya.com>
cc: Jan Harkes <jaharkes@cs.cmu.edu>
cc: coda@cs.cmu.edu
cc: codalist@coda.cs.cmu.edu
cc: linux-fsdevel@vger.kernel.org
Link: https://patchwork.kernel.org/patch/10590257/
Signed-off-by: Jan Harkes <jaharkes@cs.cmu.edu>
---
 fs/coda/cache.c                         |  2 +-
 fs/coda/cnode.c                         |  2 +-
 fs/coda/coda_linux.c                    |  2 +-
 {include/linux => fs/coda}/coda_psdev.h | 50 ++++++++++++-------------
 fs/coda/dir.c                           |  2 +-
 fs/coda/file.c                          |  3 +-
 fs/coda/inode.c                         |  2 +-
 fs/coda/pioctl.c                        |  3 +-
 fs/coda/psdev.c                         |  3 +-
 fs/coda/symlink.c                       |  3 +-
 fs/coda/upcall.c                        |  2 +-
 11 files changed, 35 insertions(+), 39 deletions(-)
 rename {include/linux => fs/coda}/coda_psdev.h (79%)

diff --git a/fs/coda/cache.c b/fs/coda/cache.c
index 201fc08a8b4f..3b8c4513118f 100644
--- a/fs/coda/cache.c
+++ b/fs/coda/cache.c
@@ -21,7 +21,7 @@
 #include <linux/spinlock.h>
 
 #include <linux/coda.h>
-#include <linux/coda_psdev.h>
+#include "coda_psdev.h"
 #include "coda_linux.h"
 #include "coda_cache.h"
 
diff --git a/fs/coda/cnode.c b/fs/coda/cnode.c
index 845b5a66952a..2e5badf67f98 100644
--- a/fs/coda/cnode.c
+++ b/fs/coda/cnode.c
@@ -8,8 +8,8 @@
 #include <linux/time.h>
 
 #include <linux/coda.h>
-#include <linux/coda_psdev.h>
 #include <linux/pagemap.h>
+#include "coda_psdev.h"
 #include "coda_linux.h"
 
 static inline int coda_fideq(struct CodaFid *fid1, struct CodaFid *fid2)
diff --git a/fs/coda/coda_linux.c b/fs/coda/coda_linux.c
index e4b5f02f0dd4..2e1a5a192074 100644
--- a/fs/coda/coda_linux.c
+++ b/fs/coda/coda_linux.c
@@ -18,7 +18,7 @@
 #include <linux/string.h>
 
 #include <linux/coda.h>
-#include <linux/coda_psdev.h>
+#include "coda_psdev.h"
 #include "coda_linux.h"
 
 /* initialize the debugging variables */
diff --git a/include/linux/coda_psdev.h b/fs/coda/coda_psdev.h
similarity index 79%
rename from include/linux/coda_psdev.h
rename to fs/coda/coda_psdev.h
index 9487f792770c..012e16f741a6 100644
--- a/include/linux/coda_psdev.h
+++ b/fs/coda/coda_psdev.h
@@ -4,21 +4,10 @@
 
 #include <linux/backing-dev.h>
 #include <linux/mutex.h>
-#include <uapi/linux/coda_psdev.h>
+#include <linux/coda_psdev.h>
 
 struct kstatfs;
 
-/* communication pending/processing queues */
-struct venus_comm {
-	u_long		    vc_seq;
-	wait_queue_head_t   vc_waitq; /* Venus wait queue */
-	struct list_head    vc_pending;
-	struct list_head    vc_processing;
-	int                 vc_inuse;
-	struct super_block *vc_sb;
-	struct mutex	    vc_mutex;
-};
-
 /* messages between coda filesystem in kernel and Venus */
 struct upc_req {
 	struct list_head	uc_chain;
@@ -36,6 +25,17 @@ struct upc_req {
 #define CODA_REQ_WRITE  0x4
 #define CODA_REQ_ABORT  0x8
 
+/* communication pending/processing queues */
+struct venus_comm {
+	u_long		    vc_seq;
+	wait_queue_head_t   vc_waitq; /* Venus wait queue */
+	struct list_head    vc_pending;
+	struct list_head    vc_processing;
+	int                 vc_inuse;
+	struct super_block *vc_sb;
+	struct mutex	    vc_mutex;
+};
+
 static inline struct venus_comm *coda_vcp(struct super_block *sb)
 {
 	return (struct venus_comm *)((sb)->s_fs_info);
@@ -46,30 +46,30 @@ int venus_rootfid(struct super_block *sb, struct CodaFid *fidp);
 int venus_getattr(struct super_block *sb, struct CodaFid *fid,
 		  struct coda_vattr *attr);
 int venus_setattr(struct super_block *, struct CodaFid *, struct coda_vattr *);
-int venus_lookup(struct super_block *sb, struct CodaFid *fid, 
-		 const char *name, int length, int *type, 
+int venus_lookup(struct super_block *sb, struct CodaFid *fid,
+		 const char *name, int length, int *type,
 		 struct CodaFid *resfid);
 int venus_close(struct super_block *sb, struct CodaFid *fid, int flags,
 		kuid_t uid);
 int venus_open(struct super_block *sb, struct CodaFid *fid, int flags,
 	       struct file **f);
-int venus_mkdir(struct super_block *sb, struct CodaFid *dirfid, 
-		const char *name, int length, 
+int venus_mkdir(struct super_block *sb, struct CodaFid *dirfid,
+		const char *name, int length,
 		struct CodaFid *newfid, struct coda_vattr *attrs);
-int venus_create(struct super_block *sb, struct CodaFid *dirfid, 
+int venus_create(struct super_block *sb, struct CodaFid *dirfid,
 		 const char *name, int length, int excl, int mode,
-		 struct CodaFid *newfid, struct coda_vattr *attrs) ;
-int venus_rmdir(struct super_block *sb, struct CodaFid *dirfid, 
+		 struct CodaFid *newfid, struct coda_vattr *attrs);
+int venus_rmdir(struct super_block *sb, struct CodaFid *dirfid,
 		const char *name, int length);
-int venus_remove(struct super_block *sb, struct CodaFid *dirfid, 
+int venus_remove(struct super_block *sb, struct CodaFid *dirfid,
 		 const char *name, int length);
-int venus_readlink(struct super_block *sb, struct CodaFid *fid, 
+int venus_readlink(struct super_block *sb, struct CodaFid *fid,
 		   char *buffer, int *length);
-int venus_rename(struct super_block *, struct CodaFid *new_fid, 
-		 struct CodaFid *old_fid, size_t old_length, 
-		 size_t new_length, const char *old_name, 
+int venus_rename(struct super_block *sb, struct CodaFid *new_fid,
+		 struct CodaFid *old_fid, size_t old_length,
+		 size_t new_length, const char *old_name,
 		 const char *new_name);
-int venus_link(struct super_block *sb, struct CodaFid *fid, 
+int venus_link(struct super_block *sb, struct CodaFid *fid,
 		  struct CodaFid *dirfid, const char *name, int len );
 int venus_symlink(struct super_block *sb, struct CodaFid *fid,
 		  const char *name, int len, const char *symname, int symlen);
diff --git a/fs/coda/dir.c b/fs/coda/dir.c
index 7e103eb8ffcd..716a0b932ec0 100644
--- a/fs/coda/dir.c
+++ b/fs/coda/dir.c
@@ -23,7 +23,7 @@
 #include <linux/uaccess.h>
 
 #include <linux/coda.h>
-#include <linux/coda_psdev.h>
+#include "coda_psdev.h"
 #include "coda_linux.h"
 #include "coda_cache.h"
 
diff --git a/fs/coda/file.c b/fs/coda/file.c
index 43d371551d2b..a6b32c883a50 100644
--- a/fs/coda/file.c
+++ b/fs/coda/file.c
@@ -22,8 +22,7 @@
 #include <linux/uaccess.h>
 
 #include <linux/coda.h>
-#include <linux/coda_psdev.h>
-
+#include "coda_psdev.h"
 #include "coda_linux.h"
 #include "coda_int.h"
 
diff --git a/fs/coda/inode.c b/fs/coda/inode.c
index 23f6ebd08e80..96d832ed23b5 100644
--- a/fs/coda/inode.c
+++ b/fs/coda/inode.c
@@ -27,7 +27,7 @@
 #include <linux/vmalloc.h>
 
 #include <linux/coda.h>
-#include <linux/coda_psdev.h>
+#include "coda_psdev.h"
 #include "coda_linux.h"
 #include "coda_cache.h"
 
diff --git a/fs/coda/pioctl.c b/fs/coda/pioctl.c
index e0c17b7dccce..644d48c12ce8 100644
--- a/fs/coda/pioctl.c
+++ b/fs/coda/pioctl.c
@@ -20,8 +20,7 @@
 #include <linux/uaccess.h>
 
 #include <linux/coda.h>
-#include <linux/coda_psdev.h>
-
+#include "coda_psdev.h"
 #include "coda_linux.h"
 
 /* pioctl ops */
diff --git a/fs/coda/psdev.c b/fs/coda/psdev.c
index 67092f069b32..b69b6108f595 100644
--- a/fs/coda/psdev.c
+++ b/fs/coda/psdev.c
@@ -42,8 +42,7 @@
 #include <linux/uaccess.h>
 
 #include <linux/coda.h>
-#include <linux/coda_psdev.h>
-
+#include "coda_psdev.h"
 #include "coda_linux.h"
 
 #include "coda_int.h"
diff --git a/fs/coda/symlink.c b/fs/coda/symlink.c
index 202297d156df..8907d0508198 100644
--- a/fs/coda/symlink.c
+++ b/fs/coda/symlink.c
@@ -17,8 +17,7 @@
 #include <linux/pagemap.h>
 
 #include <linux/coda.h>
-#include <linux/coda_psdev.h>
-
+#include "coda_psdev.h"
 #include "coda_linux.h"
 
 static int coda_symlink_filler(struct file *file, struct page *page)
diff --git a/fs/coda/upcall.c b/fs/coda/upcall.c
index 1e2f50722107..eb8cc30f2589 100644
--- a/fs/coda/upcall.c
+++ b/fs/coda/upcall.c
@@ -33,7 +33,7 @@
 #include <linux/vfs.h>
 
 #include <linux/coda.h>
-#include <linux/coda_psdev.h>
+#include "coda_psdev.h"
 #include "coda_linux.h"
 #include "coda_cache.h"
 
-- 
2.20.1

