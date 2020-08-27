Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3ED254842
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Aug 2020 17:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728241AbgH0PBI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Aug 2020 11:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727906AbgH0PAs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Aug 2020 11:00:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 874A2C06121B;
        Thu, 27 Aug 2020 08:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=TXXlSSf7SfiIdDcWgXqZJ7xhYsZWGzhY0xh4QhcsR6E=; b=gJrlue9puIQuWS8bmp4ZtASi2j
        3LGvMuBRiMLFUVyXhQx/yHPZSTM2kHWsQrdZm28crL5cL6VIKpnkAoe9L5MC2K9SLCMWngpzvncOl
        CSVBeJxQX6sFrmICRF0z9EaHv3dW+ajbkYm+rQdlWkQm3oFa8ZZiTJzoZPWYZbRVmCWaK8bcd1bg9
        QgpfYRi34/lVJ2lvmWE6RRYe4MW3yoPxj1Ql3PneBZ5Wt6xKu0sFb9VDOU+/jz0KkInclSiuLaMZg
        nWOc+9LRLEU6Swjpo2JvFBbTrvU1+zA8Ah64T/CB9nnbOOoLUrZ8Tr6e9T1LCFLNScRcp+JoP8HmY
        ttQnJxaA==;
Received: from [2001:4bb8:18c:45ba:9892:9e86:5202:32f0] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kBJOL-00045g-Rb; Thu, 27 Aug 2020 15:00:42 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 07/10] x86: make TASK_SIZE_MAX usable from assembly code
Date:   Thu, 27 Aug 2020 17:00:27 +0200
Message-Id: <20200827150030.282762-8-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200827150030.282762-1-hch@lst.de>
References: <20200827150030.282762-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

For 64-bit the only thing missing was a strategic _AC, and for 32-bit we
need to use __PAGE_OFFSET instead of PAGE_OFFSET in the TASK_SIZE
definition to escape the explicit unsigned long cast.  This just works
because __PAGE_OFFSET is defined using _AC itself and thus never needs
the cast anyway.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
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

