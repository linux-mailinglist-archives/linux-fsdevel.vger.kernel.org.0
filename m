Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1CD33C564
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2019 09:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404480AbfFKHsy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jun 2019 03:48:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49718 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404064AbfFKHsy (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jun 2019 03:48:54 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A5207C04B2F6;
        Tue, 11 Jun 2019 07:48:53 +0000 (UTC)
Received: from localhost (dhcp-12-130.nay.redhat.com [10.66.12.130])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1E16E60BCD;
        Tue, 11 Jun 2019 07:48:50 +0000 (UTC)
From:   Murphy Zhou <xzhou@redhat.com>
To:     liwang@redhat.com
Cc:     ltp@lists.linux.it, amir73il@gmail.com, chrubis@suse.cz,
        linux-fsdevel@vger.kernel.org, Murphy Zhou <xzhou@redhat.com>
Subject: [PATCH v7 3/4] syscalls/swapon/swapon0{1..3}: use helpers to check support status
Date:   Tue, 11 Jun 2019 15:47:40 +0800
Message-Id: <20190611074741.31903-3-xzhou@redhat.com>
In-Reply-To: <20190611074741.31903-1-xzhou@redhat.com>
References: <CAEemH2e5b4q+bOeE3v8FG-piSUteCinPMVmxpnkVcYCmrUc4Uw@mail.gmail.com>
 <20190611074741.31903-1-xzhou@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Tue, 11 Jun 2019 07:48:53 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Of swap operations.

Reviewed-by: Li Wang <liwang@redhat.com>
Signed-off-by: Murphy Zhou <xzhou@redhat.com>
---
 testcases/kernel/syscalls/swapon/swapon01.c | 11 ++---------
 testcases/kernel/syscalls/swapon/swapon02.c | 13 +++----------
 testcases/kernel/syscalls/swapon/swapon03.c | 15 ++++-----------
 3 files changed, 9 insertions(+), 30 deletions(-)

diff --git a/testcases/kernel/syscalls/swapon/swapon01.c b/testcases/kernel/syscalls/swapon/swapon01.c
index 32538f82b..f95ce0ab2 100644
--- a/testcases/kernel/syscalls/swapon/swapon01.c
+++ b/testcases/kernel/syscalls/swapon/swapon01.c
@@ -84,16 +84,9 @@ static void setup(void)
 
 	tst_tmpdir();
 
-	switch ((fs_type = tst_fs_type(cleanup, "."))) {
-	case TST_NFS_MAGIC:
-	case TST_TMPFS_MAGIC:
-		tst_brkm(TCONF, cleanup,
-			 "Cannot do swapon on a file on %s filesystem",
-			 tst_fs_type_name(fs_type));
-	break;
-	}
+	is_swap_supported(cleanup, "./tstswap");
 
-	make_swapfile(cleanup, "swapfile01");
+	make_swapfile(cleanup, "swapfile01", 0);
 }
 
 static void cleanup(void)
diff --git a/testcases/kernel/syscalls/swapon/swapon02.c b/testcases/kernel/syscalls/swapon/swapon02.c
index 4af5105c6..3d49d0c6b 100644
--- a/testcases/kernel/syscalls/swapon/swapon02.c
+++ b/testcases/kernel/syscalls/swapon/swapon02.c
@@ -132,18 +132,11 @@ static void setup(void)
 
 	tst_tmpdir();
 
-	switch ((fs_type = tst_fs_type(cleanup, "."))) {
-	case TST_NFS_MAGIC:
-	case TST_TMPFS_MAGIC:
-		tst_brkm(TCONF, cleanup,
-			 "Cannot do swapon on a file on %s filesystem",
-			 tst_fs_type_name(fs_type));
-	break;
-	}
+	is_swap_supported(cleanup, "./tstswap");
 
 	SAFE_TOUCH(cleanup, "notswap", 0777, NULL);
-	make_swapfile(cleanup, "swapfile01");
-	make_swapfile(cleanup, "alreadyused");
+	make_swapfile(cleanup, "swapfile01", 0);
+	make_swapfile(cleanup, "alreadyused", 0);
 
 	if (ltp_syscall(__NR_swapon, "alreadyused", 0)) {
 		if (fs_type != TST_BTRFS_MAGIC || errno != EINVAL)
diff --git a/testcases/kernel/syscalls/swapon/swapon03.c b/testcases/kernel/syscalls/swapon/swapon03.c
index 955ac247b..cef57150c 100644
--- a/testcases/kernel/syscalls/swapon/swapon03.c
+++ b/testcases/kernel/syscalls/swapon/swapon03.c
@@ -153,7 +153,7 @@ static int setup_swap(void)
 	int j, fd;
 	int status;
 	int res = 0;
-	char filename[15];
+	char filename[FILENAME_MAX];
 	char buf[BUFSIZ + 1];
 
 	/* Find out how many swapfiles (1 line per entry) already exist */
@@ -210,7 +210,7 @@ static int setup_swap(void)
 			}
 
 			/* Create the swapfile */
-			make_swapfile(cleanup, filename);
+			make_swapfile(cleanup, filename, 0);
 
 			/* turn on the swap file */
 			res = ltp_syscall(__NR_swapon, filename, 0);
@@ -246,7 +246,7 @@ static int setup_swap(void)
 
 	/* Create all needed extra swapfiles for testing */
 	for (j = 0; j < testfiles; j++)
-		make_swapfile(cleanup, swap_testfiles[j].filename);
+		make_swapfile(cleanup, swap_testfiles[j].filename, 0);
 
 	return 0;
 
@@ -333,14 +333,7 @@ static void setup(void)
 
 	tst_tmpdir();
 
-	switch ((fs_type = tst_fs_type(cleanup, "."))) {
-	case TST_NFS_MAGIC:
-	case TST_TMPFS_MAGIC:
-		tst_brkm(TCONF, cleanup,
-			 "Cannot do swapon on a file on %s filesystem",
-			 tst_fs_type_name(fs_type));
-	break;
-	}
+	is_swap_supported(cleanup, "./tstswap");
 
 	TEST_PAUSE;
 }
-- 
2.21.0

