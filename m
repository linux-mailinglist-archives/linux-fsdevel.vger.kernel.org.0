Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F48C7A25E7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Sep 2023 20:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236562AbjIOSht (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Sep 2023 14:37:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236511AbjIOSho (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Sep 2023 14:37:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83E7D196;
        Fri, 15 Sep 2023 11:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=6EBV41RIEaRQJ/bvvEj83J2s787qIb+bZO0o/tTL46o=; b=PGQxstVhyCK0bbn5NHcYRNn1ww
        TxkyLFF82AJXaUuPCP6DmEIuZbEa0EI2ja1MyNLl3TdgTTfLGsIjYXP4J5tsPhGSDcF4Lowtd/gxr
        WmuuHVRLsydmaX8bgQiQF/TghtX7r/DGahRcDs+Z8x33x9u9jN+r0263r9IdacDiIbu5vI+zvQue/
        CUN2QU8Lx2GRWbdVVFYgK0NfRCOq1DP4DgN1U15kTUtq3xrZm+drFqyseUENixVGv3Jf5rprOB25c
        1fBweM05s0kmBDCS73000UmQyQJG9ZJmwSibr6lcT6hX4gnU+xO7zy4dEck0fA2C6m5EnJs/hCw5q
        ZJpNOApA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qhDgj-00BMIj-Ml; Fri, 15 Sep 2023 18:37:09 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
        torvalds@linux-foundation.org, Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 08/17] alpha: Implement xor_unlock_is_negative_byte
Date:   Fri, 15 Sep 2023 19:36:58 +0100
Message-Id: <20230915183707.2707298-9-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230915183707.2707298-1-willy@infradead.org>
References: <20230915183707.2707298-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Inspired by the alpha clear_bit() and arch_atomic_add_return(), this
will surely be more efficient than the generic one defined in filemap.c.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 arch/alpha/include/asm/bitops.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/alpha/include/asm/bitops.h b/arch/alpha/include/asm/bitops.h
index bafb1c1f0fdc..138930e8a504 100644
--- a/arch/alpha/include/asm/bitops.h
+++ b/arch/alpha/include/asm/bitops.h
@@ -286,6 +286,27 @@ arch___test_and_change_bit(unsigned long nr, volatile unsigned long *addr)
 #define arch_test_bit generic_test_bit
 #define arch_test_bit_acquire generic_test_bit_acquire
 
+static inline bool xor_unlock_is_negative_byte(unsigned long mask,
+		volatile unsigned long *p)
+{
+	unsigned long temp, old;
+
+	__asm__ __volatile__(
+	"1:	ldl_l %0,%4\n"
+	"	xor %0,%3,%0\n"
+	"	xor %0,%3,%2\n"
+	"	stl_c %0,%1\n"
+	"	beq %0,2f\n"
+	".subsection 2\n"
+	"2:	br 1b\n"
+	".previous"
+	:"=&r" (temp), "=m" (*p), "=&r" (old)
+	:"Ir" (mask), "m" (*p));
+
+	return (old & BIT(7)) != 0;
+}
+#define xor_unlock_is_negative_byte xor_unlock_is_negative_byte
+
 /*
  * ffz = Find First Zero in word. Undefined if no zero exists,
  * so code should check against ~0UL first..
-- 
2.40.1

