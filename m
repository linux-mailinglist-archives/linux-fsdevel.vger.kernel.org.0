Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94A2A4656A1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Dec 2021 20:38:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352800AbhLATlo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Dec 2021 14:41:44 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:34528 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352753AbhLATl0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Dec 2021 14:41:26 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CA059B8211F;
        Wed,  1 Dec 2021 19:38:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F10CC53FCC;
        Wed,  1 Dec 2021 19:38:00 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-btrfs@vger.kernel.org
Subject: [PATCH v2 3/4] arm64: Add support for user sub-page fault probing
Date:   Wed,  1 Dec 2021 19:37:49 +0000
Message-Id: <20211201193750.2097885-4-catalin.marinas@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211201193750.2097885-1-catalin.marinas@arm.com>
References: <20211201193750.2097885-1-catalin.marinas@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

With MTE, even if the pte allows an access, a mismatched tag somewhere
within a page can still cause a fault. Select ARCH_HAS_SUBPAGE_FAULTS if
MTE is enabled and implement the probe_subpage_*() functions. Note that
get_user() is sufficient for the writeable checks since the same tag
mismatch fault would be triggered by a read.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/Kconfig               |  1 +
 arch/arm64/include/asm/uaccess.h | 59 ++++++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+)

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
index 6e2e0b7031ab..bcbd24b97917 100644
--- a/arch/arm64/include/asm/uaccess.h
+++ b/arch/arm64/include/asm/uaccess.h
@@ -445,4 +445,63 @@ static inline int __copy_from_user_flushcache(void *dst, const void __user *src,
 }
 #endif
 
+#ifdef CONFIG_ARCH_HAS_SUBPAGE_FAULTS
+
+/*
+ * Return 0 on success, the number of bytes not accessed otherwise.
+ */
+static inline size_t __mte_probe_user_range(const char __user *uaddr,
+					    size_t size, bool skip_first)
+{
+	const char __user *end = uaddr + size;
+	int err = 0;
+	char val;
+
+	uaddr = PTR_ALIGN_DOWN(uaddr, MTE_GRANULE_SIZE);
+	if (skip_first)
+		uaddr += MTE_GRANULE_SIZE;
+	while (uaddr < end) {
+		/*
+		 * A read is sufficient for MTE, the caller should have probed
+		 * for the pte write permission if required.
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
+static inline size_t probe_subpage_writeable(const void __user *uaddr,
+					     size_t size)
+{
+	if (!system_supports_mte())
+		return 0;
+	/* first put_user() done in the caller */
+	return __mte_probe_user_range(uaddr, size, true);
+}
+
+static inline size_t probe_subpage_safe_writeable(const void __user *uaddr,
+						  size_t size)
+{
+	if (!system_supports_mte())
+		return 0;
+	/* the caller used GUP, don't skip the first granule */
+	return __mte_probe_user_range(uaddr, size, false);
+}
+
+static inline size_t probe_subpage_readable(const void __user *uaddr,
+					    size_t size)
+{
+	if (!system_supports_mte())
+		return 0;
+	/* first get_user() done in the caller */
+	return __mte_probe_user_range(uaddr, size, true);
+}
+
+#endif /* CONFIG_ARCH_HAS_SUBPAGE_FAULTS */
+
 #endif /* __ASM_UACCESS_H */
