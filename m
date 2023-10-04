Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26F167B85C7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Oct 2023 18:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243544AbjJDQxd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Oct 2023 12:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243496AbjJDQxb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Oct 2023 12:53:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE348DD;
        Wed,  4 Oct 2023 09:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=1WZX9lC/NFReBBEGgdt7ENtP8Fsb2zBQZdLGumoTT54=; b=SF1xzTiw/J25Aeb62yc9uOpB4+
        CSgdaLxXlaa78DG9BEdY53INaBkJUqAr+2EtrSVjWQpYPaKNYd5iaGUJ4ztSk+WCuoWbTjGvaPy/p
        N7dbKRJGnb44SYp3gdAumx6FN//w89YofZHrNMytiUcrDvEmkfGGnt2lNFsQ5ouYJN/uhULOLJY5+
        twshe/tfAlP+OBacdpWeOaATD0uQsnN80U9hR2Gf+p9mUBOlYQ6irsl+Rc8oDL9XpiW65OQs1h7Ag
        I6tYGX10O0v74mMxVQlkiamubgo3ld8LB2Pcr09LrBiLQTUQZqYJqYfcak4+b/sd7iGmKELvQGaY+
        OERNzE5Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qo57g-004SFb-7X; Wed, 04 Oct 2023 16:53:20 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, torvalds@linux-foundation.org,
        npiggin@gmail.com
Subject: [PATCH v2 11/17] powerpc: Implement arch_xor_unlock_is_negative_byte on 32-bit
Date:   Wed,  4 Oct 2023 17:53:11 +0100
Message-Id: <20231004165317.1061855-12-willy@infradead.org>
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

Simply remove the ifdef.  The assembly is identical to that in the
non-optimised case of test_and_clear_bits() on PPC32, and it's not clear
to me how the PPC32 optimisation works, nor whether it would work for
arch_xor_unlock_is_negative_byte().  If that optimisation would work,
someone can implement it later, but this is more efficient than the
implementation in filemap.c.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 arch/powerpc/include/asm/bitops.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/powerpc/include/asm/bitops.h b/arch/powerpc/include/asm/bitops.h
index 40cc3ded60cb..671ecc6711e3 100644
--- a/arch/powerpc/include/asm/bitops.h
+++ b/arch/powerpc/include/asm/bitops.h
@@ -233,7 +233,6 @@ static inline int arch_test_and_change_bit(unsigned long nr,
 	return test_and_change_bits(BIT_MASK(nr), addr + BIT_WORD(nr)) != 0;
 }
 
-#ifdef CONFIG_PPC64
 static inline bool arch_xor_unlock_is_negative_byte(unsigned long mask,
 		volatile unsigned long *p)
 {
@@ -251,11 +250,8 @@ static inline bool arch_xor_unlock_is_negative_byte(unsigned long mask,
 
 	return (old & BIT_MASK(7)) != 0;
 }
-
 #define arch_xor_unlock_is_negative_byte arch_xor_unlock_is_negative_byte
 
-#endif /* CONFIG_PPC64 */
-
 #include <asm-generic/bitops/non-atomic.h>
 
 static inline void arch___clear_bit_unlock(int nr, volatile unsigned long *addr)
-- 
2.40.1

