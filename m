Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9698E7B85C0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Oct 2023 18:53:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243483AbjJDQx0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Oct 2023 12:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233446AbjJDQxZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Oct 2023 12:53:25 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED3AA7;
        Wed,  4 Oct 2023 09:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=bfs2p6og8MVmu/PmsnwWj8Grt12H9inYLMhPvOjgtD4=; b=NWC6d6ZFQxlxn/oWJ2tJnU0gwB
        ZelMR2zlgkLzaavxoF29vyK9rUKk3wZoVjQYF4K0JVoHtYF3lYdM3bogFOO8lFAEDNgqsWBU/VXZr
        YHo3HmIrljWo2RkuVx1+vSIVD0DPaQJalBikdceY0434SmUBzRY1jyCXk/mJwjly9XRiLKBwBwU0m
        2HpWLNh91z6H8q4wUtSN7qp3N6J7evJn15lOl5L3vi8PtH4ySsZtI3e7CYoaeQaMTanTOJmyLMy2C
        6wLxIkOasNlqbdxCUl5F6HQe+SYdShEeFYIl91MG5vji2Y56KV2H2hSVVyLjqcZCmQMVLsqOrDh6m
        rKkojOcg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qo57f-004SFN-Sx; Wed, 04 Oct 2023 16:53:19 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, torvalds@linux-foundation.org,
        npiggin@gmail.com
Subject: [PATCH v2 09/17] m68k: Implement xor_unlock_is_negative_byte
Date:   Wed,  4 Oct 2023 17:53:09 +0100
Message-Id: <20231004165317.1061855-10-willy@infradead.org>
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

Using EOR to clear the guaranteed-to-be-set lock bit will test the
negative flag just like the x86 implementation.  This should be
more efficient than the generic implementation in filemap.c.  It
would be better if m68k had __GCC_ASM_FLAG_OUTPUTS__.

Coldfire doesn't have a byte-sized EOR, so we test bit 7 after the
EOR, which is a second memory access, but it's slightly better than
the current C code.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 arch/m68k/include/asm/bitops.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/m68k/include/asm/bitops.h b/arch/m68k/include/asm/bitops.h
index e984af71df6b..80ee36095905 100644
--- a/arch/m68k/include/asm/bitops.h
+++ b/arch/m68k/include/asm/bitops.h
@@ -319,6 +319,28 @@ arch___test_and_change_bit(unsigned long nr, volatile unsigned long *addr)
 	return test_and_change_bit(nr, addr);
 }
 
+static inline bool xor_unlock_is_negative_byte(unsigned long mask,
+		volatile unsigned long *p)
+{
+#ifdef CONFIG_COLDFIRE
+	__asm__ __volatile__ ("eorl %1, %0"
+		: "+m" (*p)
+		: "d" (mask)
+		: "memory");
+	return *p & (1 << 7);
+#else
+	char result;
+	char *cp = (char *)p + 3;	/* m68k is big-endian */
+
+	__asm__ __volatile__ ("eor.b %1, %2; smi %0"
+		: "=d" (result)
+		: "di" (mask), "o" (*cp)
+		: "memory");
+	return result;
+#endif
+}
+#define xor_unlock_is_negative_byte xor_unlock_is_negative_byte
+
 /*
  *	The true 68020 and more advanced processors support the "bfffo"
  *	instruction for finding bits. ColdFire and simple 68000 parts
-- 
2.40.1

