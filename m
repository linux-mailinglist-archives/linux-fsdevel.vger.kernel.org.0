Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45E35245DF2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Aug 2020 09:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbgHQHcl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Aug 2020 03:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726862AbgHQHcb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Aug 2020 03:32:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AB69C061342;
        Mon, 17 Aug 2020 00:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=kbVpg/Cl7hMfUpOgrf+/Vgol2i5kqu+MYLE479vmK28=; b=DRbSf1xdtM0Veg0yrNRpLZXRjf
        q1WKVkrp3BJUpkB5kIhmQHz8q3FUV4DkBN8Bhd9c8EQ39b7lazN0kSQNsXRZ7fek8lKmaiw9R/s6u
        +BJfkllHYNyp7/lAJsZ1E0sSklSUEBXdy+uK0bGT9BfOWwtDZsBG0qXjw8ibhyq9HyigEXAmuOwWv
        LRycTnwzhscQ2ZHZOiZ3r9A1VxorQ+ObkBQ7Ri+QNRIJ9OqXobvG6vDtibaUpmBthcfYuZpeQ0J4h
        lqELAh9ElaLekMU1L72SC6fsd3gT40ZLwJxZb5HRzrUr3lplbGivjU5XL+NKeEH/nAoygyPCdvk7s
        WxdH8Geg==;
Received: from [2001:4bb8:188:3918:4550:cdf7:3d45:afb9] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k7Zd4-0000wg-E8; Mon, 17 Aug 2020 07:32:27 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 08/11] x86: make TASK_SIZE_MAX usable from assembly code
Date:   Mon, 17 Aug 2020 09:32:09 +0200
Message-Id: <20200817073212.830069-9-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817073212.830069-1-hch@lst.de>
References: <20200817073212.830069-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

For 64-bit the only hing missing was a strategic _AC, and for 32-bit we
need to use __PAGE_OFFSET instead of PAGE_OFFSET in the TASK_SIZE
definition to escape the explicit unsigned long cast.  This just works
because __PAGE_OFFSET is defined using _AC itself and thus never needs
the cast anyway.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/x86/include/asm/page_32_types.h | 4 ++--
 arch/x86/include/asm/page_64_types.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/page_32_types.h b/arch/x86/include/asm/page_32_types.h
index 26236925fb2c36..f462895a33e452 100644
--- a/arch/x86/include/asm/page_32_types.h
+++ b/arch/x86/include/asm/page_32_types.h
@@ -44,8 +44,8 @@
 /*
  * User space process size: 3GB (default).
  */
-#define IA32_PAGE_OFFSET	PAGE_OFFSET
-#define TASK_SIZE		PAGE_OFFSET
+#define IA32_PAGE_OFFSET	__PAGE_OFFSET
+#define TASK_SIZE		__PAGE_OFFSET
 #define TASK_SIZE_LOW		TASK_SIZE
 #define TASK_SIZE_MAX		TASK_SIZE
 #define DEFAULT_MAP_WINDOW	TASK_SIZE
diff --git a/arch/x86/include/asm/page_64_types.h b/arch/x86/include/asm/page_64_types.h
index 996595c9897e0a..838515daf87b36 100644
--- a/arch/x86/include/asm/page_64_types.h
+++ b/arch/x86/include/asm/page_64_types.h
@@ -76,7 +76,7 @@
  *
  * With page table isolation enabled, we map the LDT in ... [stay tuned]
  */
-#define TASK_SIZE_MAX	((1UL << __VIRTUAL_MASK_SHIFT) - PAGE_SIZE)
+#define TASK_SIZE_MAX	((_AC(1,UL) << __VIRTUAL_MASK_SHIFT) - PAGE_SIZE)
 
 #define DEFAULT_MAP_WINDOW	((1UL << 47) - PAGE_SIZE)
 
-- 
2.28.0

