Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E31551AD27C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Apr 2020 00:01:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728764AbgDPWBg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Apr 2020 18:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728685AbgDPWBd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Apr 2020 18:01:33 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AC3FC061BD3;
        Thu, 16 Apr 2020 15:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=ArfZIurbM8JaXJmqZohQOWK/UMIw9ILuX6tVrh6icrg=; b=kIGmesSpryM9Gupd0//31sgp58
        xHNdfkDMxkgqONOTxWh2P+v5JIoVRDNx44bUsAicRFOYnk2lYnSnHOjkgbemjUDJpP+1VwQMzAg4x
        hM8eld2sskFHHvkWaJ0tlA5pr8LadjifG8E7YiyLTbvSr5WpwmKFYBzDXS9pCZHECEJMxSmBhvoew
        2IaIqffSaA8JcejH3goaoQuox36ldy+wXHBvjgFwBFcvbw+BqFAIkm7MFN21NVopR6AR10Yu8KYW6
        bWJGCucPg/bNE0poFt2IUNvzJl9ehTUWLM3rA8kbrhhdM7gBo7sszsr6HgbbwrJ9EUVDd8g4HO3x1
        aWzHs7uA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jPCZg-0003UN-Gg; Thu, 16 Apr 2020 22:01:32 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org
Subject: [PATCH v3 04/11] mips: Add clear_bit_unlock_is_negative_byte implementation
Date:   Thu, 16 Apr 2020 15:01:23 -0700
Message-Id: <20200416220130.13343-5-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200416220130.13343-1-willy@infradead.org>
References: <20200416220130.13343-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

This is the generic implementation.  I can't figure out an optimised
implementation for mips.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-mips@vger.kernel.org
---
 arch/mips/include/asm/bitops.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/mips/include/asm/bitops.h b/arch/mips/include/asm/bitops.h
index a74769940fbd..23e9d36c2ffc 100644
--- a/arch/mips/include/asm/bitops.h
+++ b/arch/mips/include/asm/bitops.h
@@ -147,6 +147,13 @@ static inline void clear_bit_unlock(unsigned long nr, volatile unsigned long *ad
 	clear_bit(nr, addr);
 }
 
+static inline bool clear_bit_unlock_is_negative_byte(unsigned int nr,
+						volatile unsigned long *p)
+{
+	clear_bit_unlock(nr, p);
+	return test_bit(7, p);
+}
+
 /*
  * change_bit - Toggle a bit in memory
  * @nr: Bit to change
-- 
2.25.1

