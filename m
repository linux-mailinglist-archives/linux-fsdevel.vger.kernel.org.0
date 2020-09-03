Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E7AA25C33C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Sep 2020 16:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729370AbgICOr1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Sep 2020 10:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729275AbgICOYg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Sep 2020 10:24:36 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B20EC0611E0;
        Thu,  3 Sep 2020 07:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=/cLLiDTD8xZJBHOJYcLmc5ERwKhT+Ciq5XK7jpceMuE=; b=pbq83prJA+fXxcThqWYFnT6Obn
        cUYsu8Ni43+cor2RGu4rMBXxx7jfdsvpSVOSbX4n16DOzdUbgX9qa7z4CI2mQONm2tUUq3iwxvpaT
        PM+GsYXPjLEPSTSXLJ9emDurcHWPxYrAywVj6rnTZwCt3n4JkkPiYnbaL7Q6NVb2FaOUCpKaXDHe0
        PsFbVpRoGFu5Vk5sxFJBrEGV1wary0gsgg3l+jttzBGpShbLPyv4yKusnpMoZymJMX6jCQtUIP/zF
        V1lPH4wsMKGNI9oxjFTB2lfnEuD0MMrqEDlJ9FDYQUUbT7Qp6DeutsJWfrQu8SdGCw+rdyRpuJPR6
        8A94iuFw==;
Received: from [2001:4bb8:184:af1:c70:4a89:bc61:2] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kDq8d-0004bX-CJ; Thu, 03 Sep 2020 14:22:55 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 09/14] lkdtm: remove set_fs-based tests
Date:   Thu,  3 Sep 2020 16:22:37 +0200
Message-Id: <20200903142242.925828-10-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200903142242.925828-1-hch@lst.de>
References: <20200903142242.925828-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Once we can't manipulate the address limit, we also can't test what
happens when the manipulation is abused.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/misc/lkdtm/bugs.c               | 10 ----------
 drivers/misc/lkdtm/core.c               |  2 --
 drivers/misc/lkdtm/lkdtm.h              |  2 --
 drivers/misc/lkdtm/usercopy.c           | 15 ---------------
 tools/testing/selftests/lkdtm/tests.txt |  2 --
 5 files changed, 31 deletions(-)

diff --git a/drivers/misc/lkdtm/bugs.c b/drivers/misc/lkdtm/bugs.c
index 4dfbfd51bdf774..a0675d4154d2fd 100644
--- a/drivers/misc/lkdtm/bugs.c
+++ b/drivers/misc/lkdtm/bugs.c
@@ -312,16 +312,6 @@ void lkdtm_CORRUPT_LIST_DEL(void)
 		pr_err("list_del() corruption not detected!\n");
 }
 
-/* Test if unbalanced set_fs(KERNEL_DS)/set_fs(USER_DS) check exists. */
-void lkdtm_CORRUPT_USER_DS(void)
-{
-	pr_info("setting bad task size limit\n");
-	set_fs(KERNEL_DS);
-
-	/* Make sure we do not keep running with a KERNEL_DS! */
-	force_sig(SIGKILL);
-}
-
 /* Test that VMAP_STACK is actually allocating with a leading guard page */
 void lkdtm_STACK_GUARD_PAGE_LEADING(void)
 {
diff --git a/drivers/misc/lkdtm/core.c b/drivers/misc/lkdtm/core.c
index a5e344df916632..97803f213d9d45 100644
--- a/drivers/misc/lkdtm/core.c
+++ b/drivers/misc/lkdtm/core.c
@@ -112,7 +112,6 @@ static const struct crashtype crashtypes[] = {
 	CRASHTYPE(CORRUPT_STACK_STRONG),
 	CRASHTYPE(CORRUPT_LIST_ADD),
 	CRASHTYPE(CORRUPT_LIST_DEL),
-	CRASHTYPE(CORRUPT_USER_DS),
 	CRASHTYPE(STACK_GUARD_PAGE_LEADING),
 	CRASHTYPE(STACK_GUARD_PAGE_TRAILING),
 	CRASHTYPE(UNSET_SMEP),
@@ -172,7 +171,6 @@ static const struct crashtype crashtypes[] = {
 	CRASHTYPE(USERCOPY_STACK_FRAME_FROM),
 	CRASHTYPE(USERCOPY_STACK_BEYOND),
 	CRASHTYPE(USERCOPY_KERNEL),
-	CRASHTYPE(USERCOPY_KERNEL_DS),
 	CRASHTYPE(STACKLEAK_ERASING),
 	CRASHTYPE(CFI_FORWARD_PROTO),
 #ifdef CONFIG_X86_32
diff --git a/drivers/misc/lkdtm/lkdtm.h b/drivers/misc/lkdtm/lkdtm.h
index 8878538b2c1322..6dec4c9b442ff3 100644
--- a/drivers/misc/lkdtm/lkdtm.h
+++ b/drivers/misc/lkdtm/lkdtm.h
@@ -27,7 +27,6 @@ void lkdtm_OVERFLOW_UNSIGNED(void);
 void lkdtm_ARRAY_BOUNDS(void);
 void lkdtm_CORRUPT_LIST_ADD(void);
 void lkdtm_CORRUPT_LIST_DEL(void);
-void lkdtm_CORRUPT_USER_DS(void);
 void lkdtm_STACK_GUARD_PAGE_LEADING(void);
 void lkdtm_STACK_GUARD_PAGE_TRAILING(void);
 void lkdtm_UNSET_SMEP(void);
@@ -96,7 +95,6 @@ void lkdtm_USERCOPY_STACK_FRAME_TO(void);
 void lkdtm_USERCOPY_STACK_FRAME_FROM(void);
 void lkdtm_USERCOPY_STACK_BEYOND(void);
 void lkdtm_USERCOPY_KERNEL(void);
-void lkdtm_USERCOPY_KERNEL_DS(void);
 
 /* lkdtm_stackleak.c */
 void lkdtm_STACKLEAK_ERASING(void);
diff --git a/drivers/misc/lkdtm/usercopy.c b/drivers/misc/lkdtm/usercopy.c
index b833367a45d053..109e8d4302c113 100644
--- a/drivers/misc/lkdtm/usercopy.c
+++ b/drivers/misc/lkdtm/usercopy.c
@@ -325,21 +325,6 @@ void lkdtm_USERCOPY_KERNEL(void)
 	vm_munmap(user_addr, PAGE_SIZE);
 }
 
-void lkdtm_USERCOPY_KERNEL_DS(void)
-{
-	char __user *user_ptr =
-		(char __user *)(0xFUL << (sizeof(unsigned long) * 8 - 4));
-	mm_segment_t old_fs = get_fs();
-	char buf[10] = {0};
-
-	pr_info("attempting copy_to_user() to noncanonical address: %px\n",
-		user_ptr);
-	set_fs(KERNEL_DS);
-	if (copy_to_user(user_ptr, buf, sizeof(buf)) == 0)
-		pr_err("copy_to_user() to noncanonical address succeeded!?\n");
-	set_fs(old_fs);
-}
-
 void __init lkdtm_usercopy_init(void)
 {
 	/* Prepare cache that lacks SLAB_USERCOPY flag. */
diff --git a/tools/testing/selftests/lkdtm/tests.txt b/tools/testing/selftests/lkdtm/tests.txt
index 9d266e79c6a270..74a8d329a72c80 100644
--- a/tools/testing/selftests/lkdtm/tests.txt
+++ b/tools/testing/selftests/lkdtm/tests.txt
@@ -9,7 +9,6 @@ EXCEPTION
 #CORRUPT_STACK_STRONG Crashes entire system on success
 CORRUPT_LIST_ADD list_add corruption
 CORRUPT_LIST_DEL list_del corruption
-CORRUPT_USER_DS Invalid address limit on user-mode return
 STACK_GUARD_PAGE_LEADING
 STACK_GUARD_PAGE_TRAILING
 UNSET_SMEP CR4 bits went missing
@@ -67,6 +66,5 @@ USERCOPY_STACK_FRAME_TO
 USERCOPY_STACK_FRAME_FROM
 USERCOPY_STACK_BEYOND
 USERCOPY_KERNEL
-USERCOPY_KERNEL_DS
 STACKLEAK_ERASING OK: the rest of the thread stack is properly erased
 CFI_FORWARD_PROTO
-- 
2.28.0

