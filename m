Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC4D67A2601
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Sep 2023 20:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236656AbjIOSh6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Sep 2023 14:37:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236503AbjIOShl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Sep 2023 14:37:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 848F7115;
        Fri, 15 Sep 2023 11:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=97eXyyMqb/hrrtcwsA0mCTzMLmtahF6NIf6z9CRLAho=; b=o0ZS3c1w/qdRz22hiED4PYe5tH
        miH5vzoyL9HJMWsg73IzM2sQlI9eRgqxlhle23BnFEWfuUvVKxVfb0juP2UbHFtU3lsXCF32GZiqy
        U075r64rz/3yomqiObJyF7Q/kNyEc8ElTmfdYe4hPTNIuG0B9KaT2nqblIOGdEdd03nY0QTzNCYnO
        gCDiQmlntbQH3bdHuIKfGPTjxuiYZoJ40KIoWEePsK+yRkAaclF2alCfkSKQJ4ZrSOzSAMwo1B+lm
        yqjMxnAAH0YnL2QLrEeCqDEbQnq46m14kA/+lwymyAd9aX/hRu69HWQAQMPoqo0SWQJMdqFFWzS2M
        epROG8Hw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qhDgj-00BMIl-PE; Fri, 15 Sep 2023 18:37:09 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
        torvalds@linux-foundation.org, Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 09/17] m68k: Implement xor_unlock_is_negative_byte
Date:   Fri, 15 Sep 2023 19:36:59 +0100
Message-Id: <20230915183707.2707298-10-willy@infradead.org>
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

Using EOR to clear the guaranteed-to-be-set lock bit will test the
negative flag just like the x86 implementation.  This should be
more efficient than the generic implementation in filemap.c.  It
would be better if m68k had __GCC_ASM_FLAG_OUTPUTS__.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 arch/m68k/include/asm/bitops.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/m68k/include/asm/bitops.h b/arch/m68k/include/asm/bitops.h
index e984af71df6b..909ebe7cab5d 100644
--- a/arch/m68k/include/asm/bitops.h
+++ b/arch/m68k/include/asm/bitops.h
@@ -319,6 +319,20 @@ arch___test_and_change_bit(unsigned long nr, volatile unsigned long *addr)
 	return test_and_change_bit(nr, addr);
 }
 
+static inline bool xor_unlock_is_negative_byte(unsigned long mask,
+		volatile unsigned long *p)
+{
+	char result;
+	char *cp = (char *)p + 3;	/* m68k is big-endian */
+
+	__asm__ __volatile__ ("eor.b %1, %2; smi %0"
+		: "=d" (result)
+		: "di" (mask), "o" (*cp)
+		: "memory");
+	return result;
+}
+#define xor_unlock_is_negative_byte xor_unlock_is_negative_byte
+
 /*
  *	The true 68020 and more advanced processors support the "bfffo"
  *	instruction for finding bits. ColdFire and simple 68000 parts
-- 
2.40.1

