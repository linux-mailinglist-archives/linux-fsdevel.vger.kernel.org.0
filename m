Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5079245E03
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Aug 2020 09:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbgHQHdI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Aug 2020 03:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726836AbgHQHc2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Aug 2020 03:32:28 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51B43C061389;
        Mon, 17 Aug 2020 00:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Y/gPSrkcO0WTBRy6i45H6VgYWvtoV6CDlRazRsDykmI=; b=mDbBIzqpRFZmPKJME9zJ5B6R80
        fAir7UfNE2GI1NIAug65/QMmCPxR8FLQLYWm2LtvqDRk0UOz/OsfX6aM6ILoUjPONfhm/Owd4xyEO
        XHyPQZmphYMb2tzsOd5O015Fm4+he404d4ul0XJHyfUGOUYHKSq1nrrhsgbLQeBcJkMgFbO++HYv7
        nIIgiAWsUb5Z2doPvKSiUNRZY5InCEefBFmun51u9FHVm/KL1BmdUv4X04LpmI6xZUwIFs66tKBpj
        TQNxZWavJtci0faEGIVLJOePM6jbSorgyIS/q9vkKYsPq5NyRZf6FqV8tHuF/oPLFGvbW2Vcl4OJo
        QnegHBKQ==;
Received: from [2001:4bb8:188:3918:4550:cdf7:3d45:afb9] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k7Zd1-0000wH-QO; Mon, 17 Aug 2020 07:32:24 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 06/11] lkdtm: disable set_fs-based tests for !CONFIG_SET_FS
Date:   Mon, 17 Aug 2020 09:32:07 +0200
Message-Id: <20200817073212.830069-7-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817073212.830069-1-hch@lst.de>
References: <20200817073212.830069-1-hch@lst.de>
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
 drivers/misc/lkdtm/bugs.c     | 2 ++
 drivers/misc/lkdtm/core.c     | 4 ++++
 drivers/misc/lkdtm/usercopy.c | 2 ++
 3 files changed, 8 insertions(+)

diff --git a/drivers/misc/lkdtm/bugs.c b/drivers/misc/lkdtm/bugs.c
index 4dfbfd51bdf774..66f1800b1cb82d 100644
--- a/drivers/misc/lkdtm/bugs.c
+++ b/drivers/misc/lkdtm/bugs.c
@@ -312,6 +312,7 @@ void lkdtm_CORRUPT_LIST_DEL(void)
 		pr_err("list_del() corruption not detected!\n");
 }
 
+#ifdef CONFIG_SET_FS
 /* Test if unbalanced set_fs(KERNEL_DS)/set_fs(USER_DS) check exists. */
 void lkdtm_CORRUPT_USER_DS(void)
 {
@@ -321,6 +322,7 @@ void lkdtm_CORRUPT_USER_DS(void)
 	/* Make sure we do not keep running with a KERNEL_DS! */
 	force_sig(SIGKILL);
 }
+#endif
 
 /* Test that VMAP_STACK is actually allocating with a leading guard page */
 void lkdtm_STACK_GUARD_PAGE_LEADING(void)
diff --git a/drivers/misc/lkdtm/core.c b/drivers/misc/lkdtm/core.c
index a5e344df916632..aae08b33a7ee2a 100644
--- a/drivers/misc/lkdtm/core.c
+++ b/drivers/misc/lkdtm/core.c
@@ -112,7 +112,9 @@ static const struct crashtype crashtypes[] = {
 	CRASHTYPE(CORRUPT_STACK_STRONG),
 	CRASHTYPE(CORRUPT_LIST_ADD),
 	CRASHTYPE(CORRUPT_LIST_DEL),
+#ifdef CONFIG_SET_FS
 	CRASHTYPE(CORRUPT_USER_DS),
+#endif
 	CRASHTYPE(STACK_GUARD_PAGE_LEADING),
 	CRASHTYPE(STACK_GUARD_PAGE_TRAILING),
 	CRASHTYPE(UNSET_SMEP),
@@ -172,7 +174,9 @@ static const struct crashtype crashtypes[] = {
 	CRASHTYPE(USERCOPY_STACK_FRAME_FROM),
 	CRASHTYPE(USERCOPY_STACK_BEYOND),
 	CRASHTYPE(USERCOPY_KERNEL),
+#ifdef CONFIG_SET_FS
 	CRASHTYPE(USERCOPY_KERNEL_DS),
+#endif
 	CRASHTYPE(STACKLEAK_ERASING),
 	CRASHTYPE(CFI_FORWARD_PROTO),
 #ifdef CONFIG_X86_32
diff --git a/drivers/misc/lkdtm/usercopy.c b/drivers/misc/lkdtm/usercopy.c
index b833367a45d053..4b632fe79ab6bb 100644
--- a/drivers/misc/lkdtm/usercopy.c
+++ b/drivers/misc/lkdtm/usercopy.c
@@ -325,6 +325,7 @@ void lkdtm_USERCOPY_KERNEL(void)
 	vm_munmap(user_addr, PAGE_SIZE);
 }
 
+#ifdef CONFIG_SET_FS
 void lkdtm_USERCOPY_KERNEL_DS(void)
 {
 	char __user *user_ptr =
@@ -339,6 +340,7 @@ void lkdtm_USERCOPY_KERNEL_DS(void)
 		pr_err("copy_to_user() to noncanonical address succeeded!?\n");
 	set_fs(old_fs);
 }
+#endif
 
 void __init lkdtm_usercopy_init(void)
 {
-- 
2.28.0

