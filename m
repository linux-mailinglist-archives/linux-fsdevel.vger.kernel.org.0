Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEFD67A25FD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Sep 2023 20:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236638AbjIOShz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Sep 2023 14:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236587AbjIOShX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Sep 2023 14:37:23 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B165210E6;
        Fri, 15 Sep 2023 11:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=NoYAPE+UO7xNrTZ3UFo3zibiwdFupzttBoXxylMj4Qw=; b=H9LvAtogpvwX8ITigBgif20y3d
        Ksa3CrrVI3uaFqgH46vcGpzQGIbqqcgmmazDLvlAPd3WywSfgjryFPPXaF/5s/4Ksm1o5DXsq6PHT
        d118mcjKIzIS1RtLFAt/4I2kRM0niTEAbsc1MW/RuESCl87qFg73uDcHMTGKkeUONBGbDyBj5jrsx
        b7tUYeKMv4Ax9ha9W5IXgD9GUjlHlk+FnXw2zD9DZkL6avroCIGOqicNVMtEulxTb6/tsGEDX+11x
        OQIhNrD9uxgZFfv2F5U8xcBzdADdQizHw/96XJotDdOexdkjT2PlWFuT773ZhaL83QnsJwAtKgnsI
        hEgaBaCw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qhDgk-00BMIy-3W; Fri, 15 Sep 2023 18:37:10 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
        torvalds@linux-foundation.org, Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 13/17] s390: Implement arch_xor_unlock_is_negative_byte
Date:   Fri, 15 Sep 2023 19:37:03 +0100
Message-Id: <20230915183707.2707298-14-willy@infradead.org>
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

