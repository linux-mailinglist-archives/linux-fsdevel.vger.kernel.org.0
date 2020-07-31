Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B360D2345B4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jul 2020 14:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733293AbgGaMWP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 Jul 2020 08:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733285AbgGaMWM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 Jul 2020 08:22:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F4F1C06174A;
        Fri, 31 Jul 2020 05:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=XJVkNSbm3rNjn+7yYFiPCzhlPnNgnxohOidDxm683oU=; b=V3I6U4u4zECJMCSr8grbvFcJW0
        aINEZxdcBI9e7BwM0h4uMMjXa+LOmh/up37cfjbD7lt7ha3RNhBay4PTAXSZqF/WqwnIIYuVr2L0l
        lOftc3sWjQ6xHTJkcF/BeJt6wZ+wA/CvquyoxxaTj5orCMU7NMeeHDWTuHQno0nTfy2jM9RaXrqHN
        PirBX1OuYkgji2N3NuMSPBK8w7MUuRSgZeuf5rnI+tYB1gmKIIlXTlimivbRY2Em67o1sOwbHumtw
        Shr3vd9WOEG4+5byb2wNJwqPzImknwD0aY8ZhRpmGXWt7g9Nt0oyE48qn2443p41PSH0+70Nn8THf
        b7gYCGlQ==;
Received: from 138.57.168.109.cust.ip.kpnqwest.it ([109.168.57.138] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k1U37-000269-7W; Fri, 31 Jul 2020 12:22:09 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     x86@kernel.org, Jan Kara <jack@suse.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH 2/3] compat: add a compat_need_64bit_alignment_fixup() helper
Date:   Fri, 31 Jul 2020 14:22:01 +0200
Message-Id: <20200731122202.213333-3-hch@lst.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200731122202.213333-1-hch@lst.de>
References: <20200731122202.213333-1-hch@lst.de>
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
index e90100c0de72e4..a195f90f156cf6 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -937,6 +937,15 @@ static inline bool in_compat_syscall(void) { return false; }
 
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

