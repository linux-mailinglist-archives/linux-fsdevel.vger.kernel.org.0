Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E18BD40FF27
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Sep 2021 20:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245344AbhIQSYV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Sep 2021 14:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344396AbhIQSYK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Sep 2021 14:24:10 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 066EBC061757;
        Fri, 17 Sep 2021 11:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=djQId+Hd358fYZPiVshZR/SjuQwiN+cHEqKXT2KVm8U=; b=JIZ1rDES3nl1mO2nbMpt4H+HCe
        iCpmSmDRJRtKo6/uUAuDLPxKtsCecRAtLY6EmfNS9JlvEttwF0bo+TsjlgizO7VRU03F0lBS9wW4e
        3O0dVsSsWVSDufjdQUj9aHIVrF6GZvllaBiGNBJx7tH6DmxyMkt0W5hzcjpiiEugsdV663UjAejgQ
        tBxJtXa23lPOf06paArXukcVp/aWhyQ1jIR34zvkKJLk58jTs9eAdwwZNYIoD/AJnFv9MXquUspRy
        snWvs1Y6kPl/NIYxcB9+mWURDsnJhn9R9+59Ol4pxTozModHZaHObzlnmhbkl6fUhSBcWwxs5dGXP
        iM+zbXYA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mRIVI-00Ep5k-HN; Fri, 17 Sep 2021 18:22:28 +0000
From:   "Luis R. Rodriguez" <mcgrof@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     bp@suse.de, akpm@linux-foundation.org, josh@joshtriplett.org,
        rishabhb@codeaurora.org, kubakici@wp.pl, maco@android.com,
        david.brown@linaro.org, bjorn.andersson@linaro.org,
        linux-wireless@vger.kernel.org, keescook@chromium.org,
        shuah@kernel.org, mfuzzey@parkeon.com, zohar@linux.vnet.ibm.com,
        dhowells@redhat.com, pali.rohar@gmail.com, tiwai@suse.de,
        arend.vanspriel@broadcom.com, zajec5@gmail.com, nbroeking@me.com,
        broonie@kernel.org, dmitry.torokhov@gmail.com, dwmw2@infradead.org,
        torvalds@linux-foundation.org, Abhay_Salunke@dell.com,
        jewalt@lgsinnovations.com, cantabile.desu@gmail.com, ast@fb.com,
        andresx7@gmail.com, dan.rue@linaro.org, brendanhiggins@google.com,
        yzaikin@google.com, sfr@canb.auug.org.au, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 09/14] vmlinux.lds.h: wrap built-in firmware support under its kconfig symbol
Date:   Fri, 17 Sep 2021 11:22:21 -0700
Message-Id: <20210917182226.3532898-10-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210917182226.3532898-1-mcgrof@kernel.org>
References: <20210917182226.3532898-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Luis Chamberlain <mcgrof@kernel.org>

The firmware loader built-in firmware support now has a kconfig
symbol representing support for it. Use that to tuck away the
sections for built-in firmware.

This ensures no oddball user tries to uses these sections without
first enabling FW_LOADER_BUILTIN.

Reviewed-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 include/asm-generic/vmlinux.lds.h | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index f2984af2b85b..322af3d552ae 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -470,13 +470,7 @@
 		__end_pci_fixups_suspend_late = .;			\
 	}								\
 									\
-	/* Built-in firmware blobs */					\
-	.builtin_fw : AT(ADDR(.builtin_fw) - LOAD_OFFSET) ALIGN(8) {	\
-		__start_builtin_fw = .;					\
-		KEEP(*(.builtin_fw))					\
-		__end_builtin_fw = .;					\
-	}								\
-									\
+	FW_LOADER_BUILT_IN_DATA						\
 	TRACEDATA							\
 									\
 	PRINTK_INDEX							\
@@ -880,6 +874,18 @@
 #define ORC_UNWIND_TABLE
 #endif
 
+/* Built-in firmware blobs */
+#ifdef CONFIG_FW_LOADER_BUILTIN
+#define FW_LOADER_BUILT_IN_DATA						\
+	.builtin_fw : AT(ADDR(.builtin_fw) - LOAD_OFFSET) ALIGN(8) {	\
+		__start_builtin_fw = .;					\
+		KEEP(*(.builtin_fw))					\
+		__end_builtin_fw = .;					\
+	}
+#else
+#define FW_LOADER_BUILT_IN_DATA
+#endif
+
 #ifdef CONFIG_PM_TRACE
 #define TRACEDATA							\
 	. = ALIGN(4);							\
-- 
2.30.2

