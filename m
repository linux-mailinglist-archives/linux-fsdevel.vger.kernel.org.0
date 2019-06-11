Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 564BC3C563
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2019 09:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404382AbfFKHss (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jun 2019 03:48:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60164 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404064AbfFKHss (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jun 2019 03:48:48 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0E47B882F5;
        Tue, 11 Jun 2019 07:48:48 +0000 (UTC)
Received: from localhost (dhcp-12-130.nay.redhat.com [10.66.12.130])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 059701972C;
        Tue, 11 Jun 2019 07:48:41 +0000 (UTC)
From:   Murphy Zhou <xzhou@redhat.com>
To:     liwang@redhat.com
Cc:     ltp@lists.linux.it, amir73il@gmail.com, chrubis@suse.cz,
        linux-fsdevel@vger.kernel.org, Murphy Zhou <xzhou@redhat.com>
Subject: [PATCH v7 2/4] swapon/libswapon: add helper is_swap_supported
Date:   Tue, 11 Jun 2019 15:47:39 +0800
Message-Id: <20190611074741.31903-2-xzhou@redhat.com>
In-Reply-To: <20190611074741.31903-1-xzhou@redhat.com>
References: <CAEemH2e5b4q+bOeE3v8FG-piSUteCinPMVmxpnkVcYCmrUc4Uw@mail.gmail.com>
 <20190611074741.31903-1-xzhou@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Tue, 11 Jun 2019 07:48:48 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

To check if the filesystem we are testing on supports FIBMAP, mkswap,
swapon and swapoff operations. Survivor of this function should support
swapfile function well, like swapon and swapoff.
Modify make_swapfile function to test mkswap support status safely.

Reviewed-by: Li Wang <liwang@redhat.com>
Signed-off-by: Murphy Zhou <xzhou@redhat.com>
---
 testcases/kernel/syscalls/swapon/libswapon.c | 45 +++++++++++++++++++-
 testcases/kernel/syscalls/swapon/libswapon.h |  7 ++-
 2 files changed, 49 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/swapon/libswapon.c b/testcases/kernel/syscalls/swapon/libswapon.c
index cf6a98891..0a4501bdd 100644
--- a/testcases/kernel/syscalls/swapon/libswapon.c
+++ b/testcases/kernel/syscalls/swapon/libswapon.c
@@ -19,13 +19,15 @@
  *
  */
 
+#include <errno.h>
+#include "lapi/syscalls.h"
 #include "test.h"
 #include "libswapon.h"
 
 /*
  * Make a swap file
  */
-void make_swapfile(void (cleanup)(void), const char *swapfile)
+int make_swapfile(void (cleanup)(void), const char *swapfile, int safe)
 {
 	if (!tst_fs_has_free(NULL, ".", sysconf(_SC_PAGESIZE) * 10,
 	    TST_BYTES)) {
@@ -45,5 +47,44 @@ void make_swapfile(void (cleanup)(void), const char *swapfile)
 	argv[1] = swapfile;
 	argv[2] = NULL;
 
-	tst_run_cmd(cleanup, argv, "/dev/null", "/dev/null", 0);
+	return tst_run_cmd(cleanup, argv, "/dev/null", "/dev/null", safe);
+}
+
+/*
+ * Check swapon/swapoff support status of filesystems or files
+ * we are testing on.
+ */
+void is_swap_supported(void (cleanup)(void), const char *filename)
+{
+	int fibmap = tst_fibmap(filename);
+	long fs_type = tst_fs_type(cleanup, filename);
+	const char *fstype = tst_fs_type_name(fs_type);
+
+	int ret = make_swapfile(NULL, filename, 1);
+	if (ret != 0) {
+		if (fibmap == 1) {
+			tst_brkm(TCONF, cleanup,
+				"mkswap on %s not supported", fstype);
+		} else {
+			tst_brkm(TFAIL, cleanup,
+				"mkswap on %s failed", fstype);
+		}
+	}
+
+	TEST(ltp_syscall(__NR_swapon, filename, 0));
+	if (TEST_RETURN == -1) {
+		if (fibmap == 1 && errno == EINVAL) {
+			tst_brkm(TCONF, cleanup,
+				"Swapfile on %s not implemented", fstype);
+		} else {
+			tst_brkm(TFAIL | TERRNO, cleanup,
+				 "swapon on %s failed", fstype);
+		}
+	}
+
+	TEST(ltp_syscall(__NR_swapoff, filename, 0));
+	if (TEST_RETURN == -1) {
+		tst_brkm(TFAIL | TERRNO, cleanup,
+			"swapoff on %s failed", fstype);
+	}
 }
diff --git a/testcases/kernel/syscalls/swapon/libswapon.h b/testcases/kernel/syscalls/swapon/libswapon.h
index 7f7211eb4..a51833ec1 100644
--- a/testcases/kernel/syscalls/swapon/libswapon.h
+++ b/testcases/kernel/syscalls/swapon/libswapon.h
@@ -29,6 +29,11 @@
 /*
  * Make a swap file
  */
-void make_swapfile(void (cleanup)(void), const char *swapfile);
+int make_swapfile(void (cleanup)(void), const char *swapfile, int safe);
 
+/*
+ * Check swapon/swapoff support status of filesystems or files
+ * we are testing on.
+ */
+void is_swap_supported(void (cleanup)(void), const char *filename);
 #endif /* __LIBSWAPON_H__ */
-- 
2.21.0

