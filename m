Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E492D1AD289
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Apr 2020 00:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728795AbgDPWBl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Apr 2020 18:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727998AbgDPWBe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Apr 2020 18:01:34 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 757E3C03C1A8;
        Thu, 16 Apr 2020 15:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=nmKYsVSv4smDodVL2/EUYaTguUsR/Ex0MPhnNYWkhvM=; b=aMME+MNYdms7Ih9rtacNDLcg/c
        WFRzYcOwp6t/SSdq/KA0wVFtLP3IyoRhE6iwEK+lGj+TxpxYIuPAiHfbUNQanCt02I9qWL+xTfdpZ
        tJLtw3JNY2dXNEWXprYuCMtR7XXmlsD+bniBwAAQWEVJnRTIP3cPVwrpf615XgUgoYqfJ3VAKNpCM
        waet0YP7fNXuENYU/V6DzMxy2r18OWZ7PQ8YPk/Tbtdaj48vrq6yo3Pbffv/+5jbOtuUsXnbOvP2+
        GuUPoEnESGqkhMAaa38qobACwzyx4Vl1OpQPZ8Tb8j5uVeGOaZ4b1Eu806h8Jjk+lD9Rc19JJOC6P
        5Rk36LuA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jPCZg-0003UF-Ee; Thu, 16 Apr 2020 22:01:32 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-ia64@vger.kernel.org
Subject: [PATCH v3 02/11] ia64: Add clear_bit_unlock_is_negative_byte implementation
Date:   Thu, 16 Apr 2020 15:01:21 -0700
Message-Id: <20200416220130.13343-3-willy@infradead.org>
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

Copy and paste the clear_bit_unlock() implementation, and test the old
variable to see if it has bit 7 set.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: linux-ia64@vger.kernel.org
---
 arch/ia64/include/asm/bitops.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/ia64/include/asm/bitops.h b/arch/ia64/include/asm/bitops.h
index 2f24ee6459d2..ba92ca44731b 100644
--- a/arch/ia64/include/asm/bitops.h
+++ b/arch/ia64/include/asm/bitops.h
@@ -117,6 +117,26 @@ clear_bit_unlock (int nr, volatile void *addr)
 	} while (cmpxchg_rel(m, old, new) != old);
 }
 
+static inline bool clear_bit_unlock_is_negative_byte(unsigned int nr,
+						volatile unsigned long *p)
+{
+	__u32 mask, old, new;
+	volatile __u32 *m;
+	CMPXCHG_BUGCHECK_DECL
+
+	m = (volatile __u32 *) addr + (nr >> 5);
+	mask = ~(1 << (nr & 31));
+	do {
+		CMPXCHG_BUGCHECK(m);
+		old = *m;
+		new = old & mask;
+	} while (cmpxchg_rel(m, old, new) != old);
+
+	return old & (1 << 7);
+}
+#define clear_bit_unlock_is_negative_byte \
+	clear_bit_unlock_is_negative_byte
+
 /**
  * __clear_bit_unlock - Non-atomically clears a bit in memory with release
  * @nr: Bit to clear
-- 
2.25.1

