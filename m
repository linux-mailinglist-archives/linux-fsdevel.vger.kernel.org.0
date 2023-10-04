Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D4937B85CB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Oct 2023 18:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243491AbjJDQxf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Oct 2023 12:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243486AbjJDQxb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Oct 2023 12:53:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B490BE4;
        Wed,  4 Oct 2023 09:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=NoYAPE+UO7xNrTZ3UFo3zibiwdFupzttBoXxylMj4Qw=; b=m5I9BXtxa7U3y+DGVFJFvAMKxg
        hBD+0YDc+5glcTSqGwZdiU6CHF8GGs8Fwr1IB1Q2wLElzB2gxr6IE3VibFZ3rtjCAnHgyMSEkvmjU
        COtxOWuztoH0qghXux20Z9rq0nyzLVraO5yLavoMMcks/CORStaKbNRgugrAJSXdkEYWPPt4JRFyR
        ghB03Xdi8DyFDINsJpQsA0Bku5Pz6tB5JxfpIW8ML04CpMn1Q2Dtbi+zN2rpVwnpXrGBU4/x9CWYK
        8hBRdb6Pu+yl6r3m/UR7Sw1fVNiY+4PzLfApV1j+H0pPF0Rmvec00gSHlMcMfNnmhTfeRbn7642xQ
        NaBY1K5A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qo57g-004SFr-Gi; Wed, 04 Oct 2023 16:53:20 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, torvalds@linux-foundation.org,
        npiggin@gmail.com
Subject: [PATCH v2 13/17] s390: Implement arch_xor_unlock_is_negative_byte
Date:   Wed,  4 Oct 2023 17:53:13 +0100
Message-Id: <20231004165317.1061855-14-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231004165317.1061855-1-willy@infradead.org>
References: <20231004165317.1061855-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Inspired by the s390 arch_test_and_clear_bit(), this will surely be
more efficient than the generic one defined in filemap.c.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 arch/s390/include/asm/bitops.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/s390/include/asm/bitops.h b/arch/s390/include/asm/bitops.h
index 2de74fcd0578..c467dffa8c12 100644
--- a/arch/s390/include/asm/bitops.h
+++ b/arch/s390/include/asm/bitops.h
@@ -201,6 +201,16 @@ static inline void arch___clear_bit_unlock(unsigned long nr,
 	arch___clear_bit(nr, ptr);
 }
 
+static inline bool arch_xor_unlock_is_negative_byte(unsigned long mask,
+		volatile unsigned long *ptr)
+{
+	unsigned long old;
+
+	old = __atomic64_xor_barrier(mask, (long *)ptr);
+	return old & BIT(7);
+}
+#define arch_xor_unlock_is_negative_byte arch_xor_unlock_is_negative_byte
+
 #include <asm-generic/bitops/instrumented-atomic.h>
 #include <asm-generic/bitops/instrumented-non-atomic.h>
 #include <asm-generic/bitops/instrumented-lock.h>
-- 
2.40.1

