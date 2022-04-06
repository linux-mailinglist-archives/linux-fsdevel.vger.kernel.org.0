Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D6064F6AF7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Apr 2022 22:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232873AbiDFUOO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Apr 2022 16:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234327AbiDFUMn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Apr 2022 16:12:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBC73262431;
        Wed,  6 Apr 2022 11:09:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6F951B82004;
        Wed,  6 Apr 2022 18:09:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B6F7C385A9;
        Wed,  6 Apr 2022 18:09:27 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        Will Deacon <will@kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/3] mm: Add fault_in_subpage_writeable() to probe at sub-page granularity
Date:   Wed,  6 Apr 2022 19:09:20 +0100
Message-Id: <20220406180922.1522433-2-catalin.marinas@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220406180922.1522433-1-catalin.marinas@arm.com>
References: <20220406180922.1522433-1-catalin.marinas@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On hardware with features like arm64 MTE or SPARC ADI, an access fault
can be triggered at sub-page granularity. Depending on how the
fault_in_writeable() function is used, the caller can get into a
live-lock by continuously retrying the fault-in on an address different
from the one where the uaccess failed.

In the majority of cases progress is ensured by the following
conditions:

1. copy_to_user_nofault() guarantees at least one byte access if the
   user address is not faulting.

2. The fault_in_writeable() loop is resumed from the first address that
   could not be accessed by copy_to_user_nofault().

If the loop iteration is restarted from an earlier (initial) point, the
loop is repeated with the same conditions and it would live-lock.

Introduce an arch-specific probe_subpage_writeable() and call it from
the newly added fault_in_subpage_writeable() function. The arch code
with sub-page faults will have to implement the specific probing
functionality.

Note that no other fault_in_subpage_*() functions are added since they
have no callers currently susceptible to a live-lock.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 arch/Kconfig            |  7 +++++++
 include/linux/pagemap.h |  1 +
 include/linux/uaccess.h | 22 ++++++++++++++++++++++
 mm/gup.c                | 29 +++++++++++++++++++++++++++++
 4 files changed, 59 insertions(+)

diff --git a/arch/Kconfig b/arch/Kconfig
index 29b0167c088b..b34032279926 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -24,6 +24,13 @@ config KEXEC_ELF
 config HAVE_IMA_KEXEC
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
index 993994cd943a..6165283bdb6f 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -1046,6 +1046,7 @@ void folio_add_wait_queue(struct folio *folio, wait_queue_entry_t *waiter);
  * Fault in userspace address range.
  */
 size_t fault_in_writeable(char __user *uaddr, size_t size);
+size_t fault_in_subpage_writeable(char __user *uaddr, size_t size);
 size_t fault_in_safe_writeable(const char __user *uaddr, size_t size);
 size_t fault_in_readable(const char __user *uaddr, size_t size);
 
diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index 546179418ffa..8bbb2dabac19 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -231,6 +231,28 @@ static inline bool pagefault_disabled(void)
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
+#endif /* CONFIG_ARCH_HAS_SUBPAGE_FAULTS */
+
 #ifndef ARCH_HAS_NOCACHE_UACCESS
 
 static inline __must_check unsigned long
diff --git a/mm/gup.c b/mm/gup.c
index f598a037eb04..501bc150792c 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1648,6 +1648,35 @@ size_t fault_in_writeable(char __user *uaddr, size_t size)
 }
 EXPORT_SYMBOL(fault_in_writeable);
 
+/**
+ * fault_in_subpage_writeable - fault in an address range for writing
+ * @uaddr: start of address range
+ * @size: size of address range
+ *
+ * Fault in a user address range for writing while checking for permissions at
+ * sub-page granularity (e.g. arm64 MTE). This function should be used when
+ * the caller cannot guarantee forward progress of a copy_to_user() loop.
+ *
+ * Returns the number of bytes not faulted in (like copy_to_user() and
+ * copy_from_user()).
+ */
+size_t fault_in_subpage_writeable(char __user *uaddr, size_t size)
+{
+	size_t faulted_in;
+
+	/*
+	 * Attempt faulting in at page granularity first for page table
+	 * permission checking. The arch-specific probe_subpage_writeable()
+	 * functions may not check for this.
+	 */
+	faulted_in = size - fault_in_writeable(uaddr, size);
+	if (faulted_in)
+		faulted_in -= probe_subpage_writeable(uaddr, faulted_in);
+
+	return size - faulted_in;
+}
+EXPORT_SYMBOL(fault_in_subpage_writeable);
+
 /*
  * fault_in_safe_writeable - fault in an address range for writing
  * @uaddr: start of address range
