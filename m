Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8289045CD1A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Nov 2021 20:20:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244383AbhKXTXr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Nov 2021 14:23:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:56660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243912AbhKXTXn (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Nov 2021 14:23:43 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CAA2460E05;
        Wed, 24 Nov 2021 19:20:31 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-btrfs@vger.kernel.org
Subject: [PATCH 2/3] arm64: Add support for sub-page faults user probing
Date:   Wed, 24 Nov 2021 19:20:23 +0000
Message-Id: <20211124192024.2408218-3-catalin.marinas@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211124192024.2408218-1-catalin.marinas@arm.com>
References: <20211124192024.2408218-1-catalin.marinas@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

With MTE, even if the pte allows an access, a mismatched tag somewhere
within a page can still cause a fault. Select ARCH_HAS_SUBPAGE_FAULTS if
MTE is enabled and implement probe_user_writeable().

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/Kconfig               |  1 +
 arch/arm64/include/asm/uaccess.h | 33 ++++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index c4207cf9bb17..dff89fd0d817 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1777,6 +1777,7 @@ config ARM64_MTE
 	depends on AS_HAS_LSE_ATOMICS
 	# Required for tag checking in the uaccess routines
 	depends on ARM64_PAN
+	select ARCH_HAS_SUBPAGE_FAULTS
 	select ARCH_USES_HIGH_VMA_FLAGS
 	help
 	  Memory Tagging (part of the ARMv8.5 Extensions) provides
diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
index 6e2e0b7031ab..4bf947e9f9bf 100644
--- a/arch/arm64/include/asm/uaccess.h
+++ b/arch/arm64/include/asm/uaccess.h
@@ -445,4 +445,37 @@ static inline int __copy_from_user_flushcache(void *dst, const void __user *src,
 }
 #endif
 
+#ifdef CONFIG_ARCH_HAS_SUBPAGE_FAULTS
+static inline size_t __mte_probe_user_range(const char __user *uaddr,
+					    size_t size)
+{
+	const char __user *end = uaddr + size;
+	int err = 0;
+	char val;
+
+	uaddr = PTR_ALIGN_DOWN(uaddr, MTE_GRANULE_SIZE);
+	while (uaddr < end) {
+		/*
+		 * A read is sufficient for MTE, the caller should have probed
+		 * for the pte write permission.
+		 */
+		__raw_get_user(val, uaddr, err);
+		if (err)
+			return end - uaddr;
+		uaddr += MTE_GRANULE_SIZE;
+	}
+	(void)val;
+
+	return 0;
+}
+
+static inline size_t probe_user_writable(const void __user *uaddr,
+					 size_t size)
+{
+	if (!system_supports_mte())
+		return 0;
+	return __mte_probe_user_range(uaddr, size);
+}
+#endif /* CONFIG_ARCH_HAS_SUBPAGE_FAULTS */
+
 #endif /* __ASM_UACCESS_H */
