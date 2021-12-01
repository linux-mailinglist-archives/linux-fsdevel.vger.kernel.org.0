Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57A6C4656A0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Dec 2021 20:38:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352760AbhLATlm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Dec 2021 14:41:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352758AbhLATlZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Dec 2021 14:41:25 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 929FAC061748;
        Wed,  1 Dec 2021 11:38:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id E0035CE20D7;
        Wed,  1 Dec 2021 19:38:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B35D4C53FAD;
        Wed,  1 Dec 2021 19:37:57 +0000 (UTC)
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
Subject: [PATCH v2 2/4] mm: Probe for sub-page faults in fault_in_*()
Date:   Wed,  1 Dec 2021 19:37:48 +0000
Message-Id: <20211201193750.2097885-3-catalin.marinas@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211201193750.2097885-1-catalin.marinas@arm.com>
References: <20211201193750.2097885-1-catalin.marinas@arm.com>
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

1. copy_{to,from}_user_nofault() guarantees at least one byte access if
   the user address is not faulting.

2. The fault_in_*() loop is resumed from the next address that could not
   be accessed by copy_{to,from}_user_nofault().

If the loop iteration is restarted from an earlier point, the loop is
repeated with the same conditions and it would live-lock. The same
problem exists if the fault_in_*() is attempted on the fault address
reported by copy_*_user_nofault() since the latter does not guarantee
the maximum possible bytes are written and fault_in_*() will succeed in
probing a single byte.

Introduce probe_subpage_*() and call them from the corresponding
fault_in_*() functions on the requested 'min_size' range. The arch code
with sub-page faults will have to implement the specific probing
functionality.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/Kconfig            |  7 ++++++
 include/linux/uaccess.h | 53 +++++++++++++++++++++++++++++++++++++++++
 mm/gup.c                |  9 ++++---
 3 files changed, 66 insertions(+), 3 deletions(-)

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
 
diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index ac0394087f7d..04ad214c98cd 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -271,6 +271,59 @@ static inline bool pagefault_disabled(void)
  */
 #define faulthandler_disabled() (pagefault_disabled() || in_atomic())
 
+#ifndef CONFIG_ARCH_HAS_SUBPAGE_FAULTS
+
+/**
+ * probe_subpage_writeable: probe the user range for write faults at sub-page
+ *			    granularity (e.g. arm64 MTE)
+ * @uaddr: start of address range
+ * @size: size of address range
+ *
+ * Returns 0 on success, the number of bytes not probed on fault.
+ *
+ * It is expected that the caller checked for the write permission of each
+ * page in the range either by put_user() or GUP. The architecture port can
+ * implement a more efficient get_user() probing if the same sub-page faults
+ * are triggered by either a read or a write.
+ */
+static inline size_t probe_subpage_writeable(void __user *uaddr, size_t size)
+{
+	return 0;
+}
+
+/**
+ * probe_subpage_safe_writeable: probe the user range for write faults at
+ *				 sub-page granularity without corrupting the
+ *				 existing data
+ * @uaddr: start of address range
+ * @size: size of address range
+ *
+ * Returns 0 on success, the number of bytes not probed on fault.
+ *
+ * It is expected that the caller checked for the write permission of each
+ * page in the range either by put_user() or GUP.
+ */
+static inline size_t probe_subpage_safe_writeable(void __user *uaddr,
+						  size_t size)
+{
+	return 0;
+}
+
+/**
+ * probe_subpage_readable: probe the user range for read faults at sub-page
+ *			   granularity
+ * @uaddr: start of address range
+ * @size: size of address range
+ *
+ * Returns 0 on success, the number of bytes not probed on fault.
+ */
+static inline size_t probe_subpage_readable(void __user *uaddr, size_t size)
+{
+	return 0;
+}
+
+#endif
+
 #ifndef ARCH_HAS_NOCACHE_UACCESS
 
 static inline __must_check unsigned long
diff --git a/mm/gup.c b/mm/gup.c
index baa8240615a4..7fa69b0fb859 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1691,7 +1691,8 @@ size_t fault_in_writeable(char __user *uaddr, size_t size, size_t min_size)
 out:
 	if (size > uaddr - start)
 		faulted_in = uaddr - start;
-	if (faulted_in < min_size)
+	if (faulted_in < min_size ||
+	    (min_size && probe_subpage_writeable(start, min_size)))
 		return size;
 	return size - faulted_in;
 }
@@ -1759,7 +1760,8 @@ size_t fault_in_safe_writeable(const char __user *uaddr, size_t size,
 		mmap_read_unlock(mm);
 	if (nstart != end)
 		faulted_in = min_t(size_t, nstart - start, size);
-	if (faulted_in < min_size)
+	if (faulted_in < min_size ||
+	    (min_size && probe_subpage_safe_writeable(uaddr, min_size)))
 		return size;
 	return size - faulted_in;
 }
@@ -1801,7 +1803,8 @@ size_t fault_in_readable(const char __user *uaddr, size_t size,
 	(void)c;
 	if (size > uaddr - start)
 		faulted_in = uaddr - start;
-	if (faulted_in < min_size)
+	if (faulted_in < min_size ||
+	    (min_size && probe_subpage_readable(start, min_size)))
 		return size;
 	return size - faulted_in;
 }
