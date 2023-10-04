Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 754657B85E2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Oct 2023 18:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243638AbjJDQy2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Oct 2023 12:54:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243591AbjJDQyL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Oct 2023 12:54:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06B76180;
        Wed,  4 Oct 2023 09:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=GcBru3fPdpYKCu6uB4MY5f4K8PaG3ucCqPSqDGXRe9s=; b=RPsCKy9Rm26TskJl3Eur107F7S
        57OHLJxeUuwkSmlr5qVXZQNjmq1fs6H47cGDYcmjzJxyEwDsj8u0jKLys/oRopqDf28XCm639dRkF
        9yBzlYSdR7vgpEP7jHoxcf6LR3/zR9PCM+Ttcw7pDWHC2Fb1C3BcOcK5DulZT8hp7ezhCo/yCky9S
        pkxMgSich07C8uTk28HlWqZ3lcIgGVe23a/iYvjX/OrOn/BuvAeYNMag8CYx0+Xxssf72G8/uGqXV
        AY5Kndoit3mw7LA3XgJfj3g5Ben6dO64o9z+tqXsl9Vk8Z6UXSNiqQBLfYajlHYtcokZxJlu28Tdu
        owaSdX3Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qo57f-004SFA-Pp; Wed, 04 Oct 2023 16:53:19 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, torvalds@linux-foundation.org,
        npiggin@gmail.com
Subject: [PATCH v2 08/17] alpha: Implement xor_unlock_is_negative_byte
Date:   Wed,  4 Oct 2023 17:53:08 +0100
Message-Id: <20231004165317.1061855-9-willy@infradead.org>
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

Inspired by the alpha clear_bit() and arch_atomic_add_return(), this
will surely be more efficient than the generic one defined in filemap.c.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 arch/alpha/include/asm/bitops.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/alpha/include/asm/bitops.h b/arch/alpha/include/asm/bitops.h
index bafb1c1f0fdc..b50ad6b83e85 100644
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
+	"	mov %0,%2\n"
+	"	xor %0,%3,%0\n"
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

