Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 088897A25F4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Sep 2023 20:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236604AbjIOShv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Sep 2023 14:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236603AbjIOSh0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Sep 2023 14:37:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 924161A5;
        Fri, 15 Sep 2023 11:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=1WZX9lC/NFReBBEGgdt7ENtP8Fsb2zBQZdLGumoTT54=; b=fajBqc/PVmpLWssoMHeJr28vDZ
        ilkXDBbt56Rb0ualgExvyRQqSpVYXiMZZHCeDXpikIfzxBLmEIzlDYNLfXAZ1Cn/lojNZCh2Wrexh
        yqIjb+XAVcAH5C3+JpeakQ9TG52GjgtRYiCRD43iBzgHvEj450no85QLc/jqO9Mj7jluQT+wNuylE
        PIM6rNYr1NdwNDhRENIxbeRz5E6r62lwMe8gNo0dLbIMTIIU62YKKqGRW+VOAL9eY28yseH3ZtoWa
        vOUnKWwDJStVsL5+9mH1Pc8jGNkzmd4IPnjll/EekaNgUC4o3hB8j4zXSCQ9/Xgey9HuMmuysh7Dm
        xG1N10FA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qhDgj-00BMIq-U5; Fri, 15 Sep 2023 18:37:09 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
        torvalds@linux-foundation.org, Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 11/17] powerpc: Implement arch_xor_unlock_is_negative_byte on 32-bit
Date:   Fri, 15 Sep 2023 19:37:01 +0100
Message-Id: <20230915183707.2707298-12-willy@infradead.org>
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

