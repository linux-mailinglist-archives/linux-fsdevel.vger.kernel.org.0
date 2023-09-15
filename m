Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75E3E7A25E1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Sep 2023 20:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236508AbjIOShp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Sep 2023 14:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236584AbjIOShX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Sep 2023 14:37:23 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 989CE115;
        Fri, 15 Sep 2023 11:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=aiOK8Ht5TYsSZN2/F06YkBbUJBHTCETngx448aYGRJo=; b=lZMQHaT7hrHggJzlXzltWr+GSJ
        qxn67jKJoABNtVciXoBauvhbi6w3aXeLZ0ycZ3yb9R6L4faLx91CivKqEPdiry2EIJjszDL8doCjW
        1UfpDGS7b8//AUC/Wz3x0Xe2ldF0BmllLcpXTk3b8tv9FJoO4eqRjV5sm4mQKyejpk/kFrrJX8Lb8
        a0wwwl6e0Wh4jKeS43OdT65t/QTdLpmFX8WmtjN8ta2O6GwcTFPfaiyWj/f04D58AtSZ4/Xsvjs8/
        jK4zI1ygqWAio3mfxoew53STS7AXfgxZBwVMSeFUh39RWCIxD7DFd5zw9+ZLhR/jlNdpWm1gvozav
        dtKXH3oA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qhDgk-00BMIw-0T; Fri, 15 Sep 2023 18:37:10 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
        torvalds@linux-foundation.org, Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 12/17] riscv: Implement xor_unlock_is_negative_byte
Date:   Fri, 15 Sep 2023 19:37:02 +0100
Message-Id: <20230915183707.2707298-13-willy@infradead.org>
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

Inspired by the riscv clear_bit_unlock(), this will surely be
more efficient than the generic one defined in filemap.c.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 arch/riscv/include/asm/bitops.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/riscv/include/asm/bitops.h b/arch/riscv/include/asm/bitops.h
index 3540b690944b..15e3044298a2 100644
--- a/arch/riscv/include/asm/bitops.h
+++ b/arch/riscv/include/asm/bitops.h
@@ -191,6 +191,19 @@ static inline void __clear_bit_unlock(
 	clear_bit_unlock(nr, addr);
 }
 
+static inline bool xor_unlock_is_negative_byte(unsigned long mask,
+		volatile unsigned long *addr)
+{
+	unsigned long res;
+	__asm__ __volatile__ (
+		__AMO(xor) ".rl %0, %2, %1"
+		: "=r" (res), "+A" (*addr)
+		: "r" (__NOP(mask))
+		: "memory");
+	return (res & BIT(7)) != 0;
+}
+#define xor_unlock_is_negative_byte xor_unlock_is_negative_byte
+
 #undef __test_and_op_bit
 #undef __op_bit
 #undef __NOP
-- 
2.40.1

