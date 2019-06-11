Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFCF63C55F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2019 09:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404472AbfFKHsa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jun 2019 03:48:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56286 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404272AbfFKHs3 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jun 2019 03:48:29 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7C37F30860B7;
        Tue, 11 Jun 2019 07:48:29 +0000 (UTC)
Received: from localhost (dhcp-12-130.nay.redhat.com [10.66.12.130])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E8CA85C22E;
        Tue, 11 Jun 2019 07:48:26 +0000 (UTC)
From:   Murphy Zhou <xzhou@redhat.com>
To:     liwang@redhat.com
Cc:     ltp@lists.linux.it, amir73il@gmail.com, chrubis@suse.cz,
        linux-fsdevel@vger.kernel.org, Murphy Zhou <xzhou@redhat.com>
Subject: [PATCH v7 1/4] lib/tst_ioctl.c: add helper tst_fibmap
Date:   Tue, 11 Jun 2019 15:47:38 +0800
Message-Id: <20190611074741.31903-1-xzhou@redhat.com>
In-Reply-To: <CAEemH2e5b4q+bOeE3v8FG-piSUteCinPMVmxpnkVcYCmrUc4Uw@mail.gmail.com>
References: <CAEemH2e5b4q+bOeE3v8FG-piSUteCinPMVmxpnkVcYCmrUc4Uw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Tue, 11 Jun 2019 07:48:29 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

To check if FIBMAP ioctl is supported by the filesystem we are
testing on. It also can check the support status of specific
files, but that may not needed for now.

Reviewed-by: Li Wang <liwang@redhat.com>
Signed-off-by: Murphy Zhou <xzhou@redhat.com>
---
v7:
  Make tst_fibmap return value more accurate
  Print errno if fibmap ioctl does not succeed
  Make swapoff02 use new helper
  Mute some build warnnings
  cc linux-fsdevel list
  Overall diff stat:

 include/tst_fs.h                               |  5 +++++
 lib/tst_ioctl.c                                | 37 +++++++++++++++++++++++++++++++++++++
 testcases/kernel/syscalls/swapoff/Makefile     |  3 ++-
 testcases/kernel/syscalls/swapoff/Makefile.inc |  6 ++++++
 testcases/kernel/syscalls/swapoff/swapoff01.c  | 10 ++--------
 testcases/kernel/syscalls/swapoff/swapoff02.c  | 11 ++---------
 testcases/kernel/syscalls/swapon/libswapon.c   | 45 +++++++++++++++++++++++++++++++++++++++++++--
 testcases/kernel/syscalls/swapon/libswapon.h   |  7 ++++++-
 testcases/kernel/syscalls/swapon/swapon01.c    | 11 ++---------
 testcases/kernel/syscalls/swapon/swapon02.c    | 13 +++----------
 testcases/kernel/syscalls/swapon/swapon03.c    | 15 ++++-----------
 11 files changed, 112 insertions(+), 51 deletions(-)

v6:
  Modify make_swapfile() to check mkswap support status safely
  Remove whitelist
  Remove BTRFS EINVAL check
  Check mkswap status before testing swapon in helper
  If swapon pass, following swapoff failure will fail the whole test and break
  Also modify swapoff02 to remove whitelist completely
v5:
  Split to 4 patches
  Only take one filename parameter in tst_fibmap
  Add helper is_swap_supported to check swap operation support status
  Test fibmap/swapon and swapoff operation in the helper
  Keep NFS/TMPFS whitelist
  Keep BTRFS EINVAL handling logic, except above 2 situation:
    if swapon fails and fibmap is not supported, tst_brk with TCONF
    if swapon fails and fibmap is supported, tst_brk with TFAIL
  If swapon test pass in the helper, test swapoff similarly
  Put is_swap_supported helper in libswapon, link swapoff binaries to it
  Mute a sprintf filaname wanrning by the way
v4:
  Fail softly if FIBMAP nit supported, instead of skip entire testcase
v3:
  Fix fs_type undeclared in swapoff01.c
v2:
  Test FIBMAP instead of fstype whitelist

 include/tst_fs.h |  5 +++++
 lib/tst_ioctl.c  | 37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+)
 create mode 100644 lib/tst_ioctl.c

diff --git a/include/tst_fs.h b/include/tst_fs.h
index ebca065c6..6d03371ec 100644
--- a/include/tst_fs.h
+++ b/include/tst_fs.h
@@ -178,6 +178,11 @@ const char **tst_get_supported_fs_types(void);
  */
 void tst_fill_fs(const char *path, int verbose);
 
+/*
+ * test if FIBMAP ioctl is supported
+ */
+int tst_fibmap(const char *filename);
+
 #ifdef TST_TEST_H__
 static inline long tst_fs_type(const char *path)
 {
diff --git a/lib/tst_ioctl.c b/lib/tst_ioctl.c
new file mode 100644
index 000000000..364220bcd
--- /dev/null
+++ b/lib/tst_ioctl.c
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include <errno.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/ioctl.h>
+#include <linux/fs.h>
+
+#define TST_NO_DEFAULT_MAIN
+
+#include "tst_test.h"
+
+int tst_fibmap(const char *filename)
+{
+	/* test if FIBMAP ioctl is supported */
+	int fd, block = 0;
+
+	fd = open(filename, O_RDWR | O_CREAT, 0666);
+	if (fd < 0) {
+		tst_res(TWARN | TERRNO,
+			 "open(%s, O_RDWR | O_CREAT, 0666) failed", filename);
+		return -1;
+	}
+
+	if (ioctl(fd, FIBMAP, &block)) {
+		tst_res(TINFO | TERRNO, "FIBMAP ioctl is NOT supported");
+		close(fd);
+		return 1;
+	}
+	tst_res(TINFO, "FIBMAP ioctl is supported");
+
+	if (close(fd)) {
+		tst_res(TWARN | TERRNO, "close(fd) failed");
+		return -1;
+	}
+	return 0;
+}
-- 
2.21.0

