Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A837122E108
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Jul 2020 18:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727871AbgGZQEQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Jul 2020 12:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727852AbgGZQEO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Jul 2020 12:04:14 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51AC9C0619D2;
        Sun, 26 Jul 2020 09:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Qgxj/loCE+O6wxKk/eqjrsxG348MHNKY89kEnscKvrM=; b=kohjCkwvuA7bxnRm6vGl5H2oKA
        GzAu5e2DedmqSrCUCxMa2wVzikiqeFhOAl7DopN5IIIPZlxSBnMNN1s+aIJdy4r4w128g5qlQktZ5
        YtdAxg07ilyloUoEIvwAATlsMwEJ2nW7RmE7UbmspjS0dD6kmdr2r9RVAXNyFcrA+yeLf7HHn7MeA
        oabw8e8mNooy7RXCnSFXymIHpGIym1zjyeQwgy9bn5uUfiWozo8sO8UGDSnNOxX8JYvlai4HlPcaf
        0UXci6cy2qYk0tiaI2aLMi1nEhYIefNc0mTYxWPPIcsAX+lmWN71eVWE26/hBWamIXrO4SA/W1fnc
        8i9ErYBw==;
Received: from [2001:4bb8:18c:2acc:2375:88ff:9f84:118d] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jzj8E-0000Zf-1n; Sun, 26 Jul 2020 16:04:10 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     x86@kernel.org, Jan Kara <jack@suse.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH 3/4] compat: add a compat_need_64bit_alignment_fixup() helper
Date:   Sun, 26 Jul 2020 18:04:00 +0200
Message-Id: <20200726160401.311569-4-hch@lst.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200726160401.311569-1-hch@lst.de>
References: <20200726160401.311569-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a helper to check if the calling syscall needs a fixup for
non-natural 64-bit type alignment in the compat ABI.  This will only
return true for i386 syscalls on x86_64.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/x86/include/asm/compat.h | 1 +
 include/linux/compat.h        | 9 +++++++++
 2 files changed, 10 insertions(+)

diff --git a/arch/x86/include/asm/compat.h b/arch/x86/include/asm/compat.h
index bf547701f41f87..0e327a01f50fbb 100644
--- a/arch/x86/include/asm/compat.h
+++ b/arch/x86/include/asm/compat.h
@@ -209,6 +209,7 @@ static inline bool in_compat_syscall(void)
 	return in_32bit_syscall();
 }
 #define in_compat_syscall in_compat_syscall	/* override the generic impl */
+#define compat_need_64bit_alignment_fixup in_ia32_syscall
 #endif
 
 struct compat_siginfo;
diff --git a/include/linux/compat.h b/include/linux/compat.h
index c22a7f1d253b87..afdd44ba3a8869 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -945,6 +945,15 @@ static inline bool in_compat_syscall(void) { return false; }
 
 #endif /* CONFIG_COMPAT */
 
+/*
+ * Some legacy ABIs like the i386 one use less than natural alignment for 64-bit
+ * types, and will need special compat treatment for that.  Most architectures
+ * don't need that special handling even for compat syscalls.
+ */
+#ifndef compat_need_64bit_alignment_fixup
+#define compat_need_64bit_alignment_fixup()		false
+#endif
+
 /*
  * A pointer passed in from user mode. This should not
  * be used for syscall parameters, just declare them
-- 
2.27.0

