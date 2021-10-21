Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7346D4366FA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Oct 2021 17:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231915AbhJUQBQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Oct 2021 12:01:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbhJUQBP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Oct 2021 12:01:15 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0409AC0613B9;
        Thu, 21 Oct 2021 08:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=cmX5bRyrsH1lBCT6z2hfhCgYvWjFVdqyIKA0Mhmk8aQ=; b=GNOZneOKC2clRX+AHd67cp1eje
        ktyybOMUfYmIboYWJ8mLQPVjnLLX7n4bp3ih/A2pqPDDCZjuCDCGZBC36TfWvjtp21YYE3DrVGIUt
        9mr4AHp8qEq49RkljVbKtkjRXgQd9P+Dfpa0o1eoGdUEcGUp29eHvLWf9qEGmlU5Lug0RBAurx+L1
        toGJVV9sfsa7TWwK4ZJpD4EgZMxa5h+VPGTP/5VMQ8oCufrEIpkuBwd+mQtDKAajJBPhWhnGNIe4x
        jWLE5wdYylgzgwwnPY6WXFFmWILfIfbvW0gt37Z7tKMNpJGoCdVGhW69r4eGQ4a8kIl/lxm79gXqh
        zJxpF9lA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mdaSq-008GM6-Hv; Thu, 21 Oct 2021 15:58:44 +0000
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
Subject: [PATCH v2 05/10] vmlinux.lds.h: wrap built-in firmware support under FW_LOADER
Date:   Thu, 21 Oct 2021 08:58:38 -0700
Message-Id: <20211021155843.1969401-6-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211021155843.1969401-1-mcgrof@kernel.org>
References: <20211021155843.1969401-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Luis Chamberlain <mcgrof@kernel.org>

The firmware loader built-in firmware is only available when FW_LOADER
is built-in, so tuck away the sections for built-in firmware under it.

This ensures no oddball user tries to uses these sections without
first enabling FW_LOADER=y.

Reviewed-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 include/asm-generic/vmlinux.lds.h | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 8771c435f34b..62351669add4 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -476,13 +476,7 @@
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
@@ -886,6 +880,18 @@
 #define ORC_UNWIND_TABLE
 #endif
 
+/* Built-in firmware blobs */
+#ifdef CONFIG_FW_LOADER
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

