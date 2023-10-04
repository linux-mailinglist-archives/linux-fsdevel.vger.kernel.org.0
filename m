Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDCFA7B85C4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Oct 2023 18:53:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243539AbjJDQxd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Oct 2023 12:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233446AbjJDQx0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Oct 2023 12:53:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8304D9;
        Wed,  4 Oct 2023 09:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=vWwsy+BgXOEcfKuqkIEkXjDw+riS2szWYiR2hDnP9b4=; b=LRSyEDwtmAXo0SM67p0C/noFmS
        iQRqwWT0ozrzzklRbep0Y8uPDstZQyqeEmgSEyRLFrVaMAAHGAi6KuiXuL7rxIpp9Wy70RMINXlAc
        zMlCgxVoBipZVAADPqwuURev5kaILMLePvWQRxlX0JOeMyGqz51FeD55M+cMEekRpNkbU5OhH5Pj9
        W3/ibRKkViqP8KeDxEoR6lj+8CrmlJY/CGvO4/2DwLzgk33nshJZZ5xFeCpgyIFC7cP6whN+rIPCb
        32UOsNltjlEo+FKhHJ3Ip0qXuHp6b+Nf9dJ3ITrnJDIiNYspgFlpByG8RcOATrn60yzanbbajMwd9
        9shECiMw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qo57g-004SFV-1h; Wed, 04 Oct 2023 16:53:20 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, torvalds@linux-foundation.org,
        npiggin@gmail.com
Subject: [PATCH v2 10/17] mips: Implement xor_unlock_is_negative_byte
Date:   Wed,  4 Oct 2023 17:53:10 +0100
Message-Id: <20231004165317.1061855-11-willy@infradead.org>
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

Inspired by the mips test_and_change_bit(), this will surely be more
efficient than the generic one defined in filemap.c

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 arch/mips/include/asm/bitops.h | 26 +++++++++++++++++++++++++-
 arch/mips/lib/bitops.c         | 14 ++++++++++++++
 2 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/bitops.h b/arch/mips/include/asm/bitops.h
index b4bf754f7db3..d98a05c478f4 100644
--- a/arch/mips/include/asm/bitops.h
+++ b/arch/mips/include/asm/bitops.h
@@ -73,7 +73,8 @@ int __mips_test_and_clear_bit(unsigned long nr,
 			      volatile unsigned long *addr);
 int __mips_test_and_change_bit(unsigned long nr,
 			       volatile unsigned long *addr);
-
+bool __mips_xor_is_negative_byte(unsigned long mask,
+		volatile unsigned long *addr);
 
 /*
  * set_bit - Atomically set a bit in memory
@@ -279,6 +280,29 @@ static inline int test_and_change_bit(unsigned long nr,
 	return res;
 }
 
+static inline bool xor_unlock_is_negative_byte(unsigned long mask,
+		volatile unsigned long *p)
+{
+	unsigned long orig;
+	bool res;
+
+	smp_mb__before_atomic();
+
+	if (!kernel_uses_llsc) {
+		res = __mips_xor_is_negative_byte(mask, p);
+	} else {
+		orig = __test_bit_op(*p, "%0",
+				     "xor\t%1, %0, %3",
+				     "ir"(mask));
+		res = (orig & BIT(7)) != 0;
+	}
+
+	smp_llsc_mb();
+
+	return res;
+}
+#define xor_unlock_is_negative_byte xor_unlock_is_negative_byte
+
 #undef __bit_op
 #undef __test_bit_op
 
diff --git a/arch/mips/lib/bitops.c b/arch/mips/lib/bitops.c
index 116d0bd8b2ae..00aee98e9d54 100644
--- a/arch/mips/lib/bitops.c
+++ b/arch/mips/lib/bitops.c
@@ -146,3 +146,17 @@ int __mips_test_and_change_bit(unsigned long nr, volatile unsigned long *addr)
 	return res;
 }
 EXPORT_SYMBOL(__mips_test_and_change_bit);
+
+bool __mips_xor_is_negative_byte(unsigned long mask,
+		volatile unsigned long *addr)
+{
+	unsigned long flags;
+	unsigned long data;
+
+	raw_local_irq_save(flags);
+	data = *addr;
+	*addr = data ^ mask;
+	raw_local_irq_restore(flags);
+
+	return (data & BIT(7)) != 0;
+}
-- 
2.40.1

