Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE7BB45CD14
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Nov 2021 20:20:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243829AbhKXTXn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Nov 2021 14:23:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:56634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243722AbhKXTXm (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Nov 2021 14:23:42 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 62DD960F45;
        Wed, 24 Nov 2021 19:20:29 +0000 (UTC)
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
Subject: [PATCH 1/3] mm: Introduce fault_in_exact_writeable() to probe for sub-page faults
Date:   Wed, 24 Nov 2021 19:20:22 +0000
Message-Id: <20211124192024.2408218-2-catalin.marinas@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211124192024.2408218-1-catalin.marinas@arm.com>
References: <20211124192024.2408218-1-catalin.marinas@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On hardware with features like arm64 MTE or SPARC ADI, an access fault
can be triggered at sub-page granularity. Depending on how the
fault_in_*() functions are used, the caller can get into a live-lock by
continuously retrying the fault-in on an address different from the one
where the uaccess failed.

In the majority of cases progress is ensured by the following
conditions:

1. copy_{to,from}_user() guarantees at least one byte access if the user
   address is not faulting;

2. The fault_in_*() is attempted on the next address that could not be
   accessed by copy_*_user().

In the places where the above conditions are not met or the
fault-in/uaccess loop does not have a mechanism to bail out, the
fault_in_exact_writeable() ensures that the arch code will probe the
range in question at a sub-page fault granularity (e.g. 16 bytes for
arm64 MTE). For large ranges, this is significantly more expensive than
the non-exact versions which probe a single byte in each page or use
GUP.

The architecture code has to select ARCH_HAS_SUBPAGE_FAULTS and
implement probe_user_writeable().

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/Kconfig            |  7 +++++++
 include/linux/pagemap.h |  1 +
 include/linux/uaccess.h | 21 +++++++++++++++++++++
 mm/gup.c                | 19 +++++++++++++++++++
 4 files changed, 48 insertions(+)

diff --git a/arch/Kconfig b/arch/Kconfig
index 26b8ed11639d..02502b3362aa 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -27,6 +27,13 @@ config HAVE_IMA_KEXEC
 config SET_FS
 	bool
 
+config ARCH_HAS_SUBPAGE_FAULTS
+	bool
+	help
+	  Select if the architecture can check permissions at sub-page
+	  granularity (e.g. arm64 MTE). The probe_user_*() functions
+	  must be implemented.
+
 config HOTPLUG_SMT
 	bool
 
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 1a0c646eb6ff..4bae32d6b2e3 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -910,6 +910,7 @@ void folio_add_wait_queue(struct folio *folio, wait_queue_entry_t *waiter);
  * Fault in userspace address range.
  */
 size_t fault_in_writeable(char __user *uaddr, size_t size);
+size_t fault_in_exact_writeable(char __user *uaddr, size_t size);
 size_t fault_in_safe_writeable(const char __user *uaddr, size_t size);
 size_t fault_in_readable(const char __user *uaddr, size_t size);
 
diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index ac0394087f7d..08169fb38905 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -271,6 +271,27 @@ static inline bool pagefault_disabled(void)
  */
 #define faulthandler_disabled() (pagefault_disabled() || in_atomic())
 
+#ifndef CONFIG_ARCH_HAS_SUBPAGE_FAULTS
+/**
+ * probe_user_writable: probe for sub-page faults in the user range
+ * @uaddr: start of address range
+ * @size: size of address range
+ *
+ * Returns the number of bytes not accessible (like copy_to_user() and
+ * copy_from_user()).
+ *
+ * Architectures that can generate sub-page faults (e.g. arm64 MTE) should
+ * implement this function. It is expected that the caller checked for the
+ * write permission of each page in the range either by put_user() or GUP.
+ * The architecture port can implement a more efficient get_user() probing of
+ * the range if sub-page faults are triggered by either a load or store.
+ */
+static inline size_t probe_user_writable(void __user *uaddr, size_t size)
+{
+	return 0;
+}
+#endif
+
 #ifndef ARCH_HAS_NOCACHE_UACCESS
 
 static inline __must_check unsigned long
diff --git a/mm/gup.c b/mm/gup.c
index 2c51e9748a6a..1c360d9fdc8e 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1693,6 +1693,25 @@ size_t fault_in_writeable(char __user *uaddr, size_t size)
 }
 EXPORT_SYMBOL(fault_in_writeable);
 
+/**
+ * fault_in_exact_writeable - fault in userspace address range for writing,
+ *			      potentially checking for sub-page faults
+ * @uaddr: start of address range
+ * @size: size of address range
+ *
+ * Returns the number of bytes not faulted in (like copy_to_user() and
+ * copy_from_user()).
+ */
+size_t fault_in_exact_writeable(char __user *uaddr, size_t size)
+{
+	size_t accessible = size - fault_in_writeable(uaddr, size);
+
+	if (accessible)
+		accessible -= probe_user_writable(uaddr, accessible);
+	return size - accessible;
+}
+EXPORT_SYMBOL(fault_in_exact_writeable);
+
 /*
  * fault_in_safe_writeable - fault in an address range for writing
  * @uaddr: start of address range
