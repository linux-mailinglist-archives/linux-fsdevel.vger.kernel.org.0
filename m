Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 383023C565
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2019 09:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404485AbfFKHs4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jun 2019 03:48:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54424 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404064AbfFKHsz (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jun 2019 03:48:55 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A9B803082E25;
        Tue, 11 Jun 2019 07:48:55 +0000 (UTC)
Received: from localhost (dhcp-12-130.nay.redhat.com [10.66.12.130])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2626360BC9;
        Tue, 11 Jun 2019 07:48:54 +0000 (UTC)
From:   Murphy Zhou <xzhou@redhat.com>
To:     liwang@redhat.com
Cc:     ltp@lists.linux.it, amir73il@gmail.com, chrubis@suse.cz,
        linux-fsdevel@vger.kernel.org, Murphy Zhou <xzhou@redhat.com>
Subject: [PATCH v7 4/4] syscalls/swapoff/swapoff0{1,2}: use helpers to check support status
Date:   Tue, 11 Jun 2019 15:47:41 +0800
Message-Id: <20190611074741.31903-4-xzhou@redhat.com>
In-Reply-To: <20190611074741.31903-1-xzhou@redhat.com>
References: <CAEemH2e5b4q+bOeE3v8FG-piSUteCinPMVmxpnkVcYCmrUc4Uw@mail.gmail.com>
 <20190611074741.31903-1-xzhou@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Tue, 11 Jun 2019 07:48:55 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Of swap operations. Change Makefile to use functions from
../swapon/libswapon.c

Reviewed-by: Li Wang <liwang@redhat.com>
Signed-off-by: Murphy Zhou <xzhou@redhat.com>
---
 testcases/kernel/syscalls/swapoff/Makefile     |  3 ++-
 testcases/kernel/syscalls/swapoff/Makefile.inc |  6 ++++++
 testcases/kernel/syscalls/swapoff/swapoff01.c  | 10 ++--------
 testcases/kernel/syscalls/swapoff/swapoff02.c  | 11 ++---------
 4 files changed, 12 insertions(+), 18 deletions(-)
 create mode 100644 testcases/kernel/syscalls/swapoff/Makefile.inc

diff --git a/testcases/kernel/syscalls/swapoff/Makefile b/testcases/kernel/syscalls/swapoff/Makefile
index bd617d806..536b2dbac 100644
--- a/testcases/kernel/syscalls/swapoff/Makefile
+++ b/testcases/kernel/syscalls/swapoff/Makefile
@@ -19,5 +19,6 @@
 top_srcdir		?= ../../../..
 
 include $(top_srcdir)/include/mk/testcases.mk
-
+include $(abs_srcdir)/./Makefile.inc
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
+$(MAKE_TARGETS): %: %.o ../swapon/libswapon.o
diff --git a/testcases/kernel/syscalls/swapoff/Makefile.inc b/testcases/kernel/syscalls/swapoff/Makefile.inc
new file mode 100644
index 000000000..65350cbeb
--- /dev/null
+++ b/testcases/kernel/syscalls/swapoff/Makefile.inc
@@ -0,0 +1,6 @@
+LIBDIR			+= ../swapon/
+LIBSWAPON		:= $(LIBDIR)/libswapon.o
+$(LIBSWAPON):
+	$(MAKE) -C $(LIBDIR)
+CPPFLAGS		+= -I$(abs_srcdir)/$(LIBDIR)
+LDFLAGS			+= -L$(abs_builddir)/$(LIBDIR)
diff --git a/testcases/kernel/syscalls/swapoff/swapoff01.c b/testcases/kernel/syscalls/swapoff/swapoff01.c
index a63e661a5..e115269c0 100644
--- a/testcases/kernel/syscalls/swapoff/swapoff01.c
+++ b/testcases/kernel/syscalls/swapoff/swapoff01.c
@@ -25,6 +25,7 @@
 #include <stdlib.h>
 #include "config.h"
 #include "lapi/syscalls.h"
+#include "../swapon/libswapon.h"
 
 static void setup(void);
 static void cleanup(void);
@@ -86,14 +87,7 @@ static void setup(void)
 
 	tst_tmpdir();
 
-	switch ((fs_type = tst_fs_type(cleanup, "."))) {
-	case TST_NFS_MAGIC:
-	case TST_TMPFS_MAGIC:
-		tst_brkm(TCONF, cleanup,
-			 "Cannot do swapoff on a file on %s filesystem",
-			 tst_fs_type_name(fs_type));
-	break;
-	}
+	is_swap_supported(cleanup, "./tstswap");
 
 	if (!tst_fs_has_free(NULL, ".", 64, TST_MB)) {
 		tst_brkm(TBROK, cleanup,
diff --git a/testcases/kernel/syscalls/swapoff/swapoff02.c b/testcases/kernel/syscalls/swapoff/swapoff02.c
index b5c6312a1..8954f975f 100644
--- a/testcases/kernel/syscalls/swapoff/swapoff02.c
+++ b/testcases/kernel/syscalls/swapoff/swapoff02.c
@@ -33,6 +33,7 @@
 #include "test.h"
 #include "lapi/syscalls.h"
 #include "safe_macros.h"
+#include "../swapon/libswapon.h"
 
 static void setup(void);
 static void cleanup(void);
@@ -124,7 +125,6 @@ static void cleanup01(void)
 
 static void setup(void)
 {
-	long type;
 	struct passwd *nobody;
 
 	tst_sig(FORK, DEF_HANDLER, cleanup);
@@ -138,14 +138,7 @@ static void setup(void)
 
 	tst_tmpdir();
 
-	switch ((type = tst_fs_type(cleanup, "."))) {
-	case TST_NFS_MAGIC:
-	case TST_TMPFS_MAGIC:
-		tst_brkm(TCONF, cleanup,
-			 "Cannot do swapoff on a file on %s filesystem",
-			 tst_fs_type_name(type));
-	break;
-	}
+	is_swap_supported(cleanup, "./tstswap");
 
 	if (!tst_fs_has_free(NULL, ".", 1, TST_KB)) {
 		tst_brkm(TBROK, cleanup,
-- 
2.21.0

