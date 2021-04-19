Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE8AC364B01
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Apr 2021 22:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242053AbhDSUNc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Apr 2021 16:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbhDSUNb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Apr 2021 16:13:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 298B9C06174A
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Apr 2021 13:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=Dd1c3uK8kth0OnBCzDa3d1msVVAdjqxyfJR/pdty588=; b=MQb+beHchsYlIiEfqEstSYp1Tf
        5cS5Rcqte0C4+r5AyoiEEPPs7a785wmrsZi1IBLpz3WphJFGAs88dkxSwcrmgpbnzqObQ//mYxKFt
        KvIuzqzZ5Qib4KLtaKlpBH+MkjNC3CZ5WflpvNMm4JyySNvpsMRs62Ms3ua4KfkKj/AS/w1eD7N8h
        7CpX/6Jno0QrP8v9byxagb6RNEL758dTaNrkLRLObH3DLaGOqS/cjU6RsRLkg6fN+vL9etyz6I2cs
        nWY1za+rSRXxTHoVgf2uISebn4r2fB/aX2cVsoN++Bz7HVZYqMMswEa5ujnqtPRpyRBRrG67yJ9Um
        o8491sfg==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lYaGJ-00EEDp-Il; Mon, 19 Apr 2021 20:12:53 +0000
Date:   Mon, 19 Apr 2021 21:12:51 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH] smp_rmb_cond
Message-ID: <20210419201251.GE2531743@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

i see worse inlining decisions from gcc with this.  maybe you see
an improvement that would justify it?

[ref: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=99998]

diff --git a/arch/x86/include/asm/barrier.h b/arch/x86/include/asm/barrier.h
index 4819d5e5a335..4cbc5bd5bcdd 100644
--- a/arch/x86/include/asm/barrier.h
+++ b/arch/x86/include/asm/barrier.h
@@ -60,6 +60,7 @@ static inline unsigned long array_index_mask_nospec(unsigned long index,
 #define __smp_mb()	asm volatile("lock; addl $0,-4(%%rsp)" ::: "memory", "cc")
 #endif
 #define __smp_rmb()	dma_rmb()
+#define smp_rmb_cond(x)	barrier()
 #define __smp_wmb()	barrier()
 #define __smp_store_mb(var, value) do { (void)xchg(&var, value); } while (0)
 
diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
index 640f09479bdf..cc0c864f90dc 100644
--- a/include/asm-generic/barrier.h
+++ b/include/asm-generic/barrier.h
@@ -89,6 +89,10 @@
 
 #endif	/* CONFIG_SMP */
 
+#ifndef smp_rmb_cond
+#define smp_rmb_cond(x) do { if (x) smp_rmb(); } while (0)
+#endif
+
 #ifndef __smp_store_mb
 #define __smp_store_mb(var, value)  do { WRITE_ONCE(var, value); __smp_mb(); } while (0)
 #endif
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 04a34c08e0a6..c45d491e9245 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -522,8 +522,7 @@ static inline int PageUptodate(struct page *page)
 	 *
 	 * See SetPageUptodate() for the other side of the story.
 	 */
-	if (ret)
-		smp_rmb();
+	smp_rmb_cond(ret);
 
 	return ret;
 }
diff --git a/kernel/printk/printk_safe.c b/kernel/printk/printk_safe.c
index 7a1414622051..260ef2474ff2 100644
--- a/kernel/printk/printk_safe.c
+++ b/kernel/printk/printk_safe.c
@@ -89,8 +89,7 @@ static __printf(2, 0) int printk_safe_log_store(struct printk_safe_seq_buf *s,
 	 * Make sure that all old data have been read before the buffer
 	 * was reset. This is not needed when we just append data.
 	 */
-	if (!len)
-		smp_rmb();
+	smp_rmb_cond(!len);
 
 	va_copy(ap, args);
 	add = vscnprintf(s->buffer + len, sizeof(s->buffer) - len, fmt, ap);
