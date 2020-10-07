Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1E0A2855E3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Oct 2020 03:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727242AbgJGBHW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Oct 2020 21:07:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56415 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726754AbgJGBHT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Oct 2020 21:07:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602032838;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AEDNEi43Y2zFaHkXpyai8k44psKmQxmMhyysaLVCBuw=;
        b=YXJPcMTHk9slMN5KzcAgV/fIQW5R7e+FMwCFhM9QufRz80Jisc1nAwEHeChQPgnZdTZeCq
        7J88axk+LPEg3bKd+puhiHBMcgQ6+iOkttRuAQh7K88S9nnPIm7Xt4egVPXKqyGHzef62I
        cG3QViayDX7PTY3MczwRqYYCzetkNCg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-405-dSHIC1-_PceQL3n4lpcmtg-1; Tue, 06 Oct 2020 21:07:13 -0400
X-MC-Unique: dSHIC1-_PceQL3n4lpcmtg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3DB9B8015F6;
        Wed,  7 Oct 2020 01:07:12 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-119-161.rdu2.redhat.com [10.10.119.161])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 48FFF5D9D2;
        Wed,  7 Oct 2020 01:07:11 +0000 (UTC)
From:   jglisse@redhat.com
To:     linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Jan Kara <jack@suse.cz>, Josef Bacik <jbacik@fb.com>
Subject: [PATCH 01/14] mm/pxa: page exclusive access add header file for all helpers.
Date:   Tue,  6 Oct 2020 21:05:50 -0400
Message-Id: <20201007010603.3452458-2-jglisse@redhat.com>
In-Reply-To: <20201007010603.3452458-1-jglisse@redhat.com>
References: <20201007010603.3452458-1-jglisse@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Jérôme Glisse <jglisse@redhat.com>

Add include/linux/page-xa.h where all helpers related to Page eXclusive
Acces (PXA) will be added (in following patches).

Also introduce MAPPING_NULL as a temporary define use to simplify the
mass modifications to stop relying on struct page.mapping and instead
pass down mapping pointer from the context (either from inode when in
syscall operating on a file or from vma->vm_file when operating on some
virtual address.

This is temporary define, do not use !

Signed-off-by: Jérôme Glisse <jglisse@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>
Cc: Jan Kara <jack@suse.cz>
Cc: Josef Bacik <jbacik@fb.com>
---
 include/linux/mm.h      |  5 ++++
 include/linux/page-xa.h | 66 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 71 insertions(+)
 create mode 100644 include/linux/page-xa.h

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 16b799a0522cd..d165961c58c45 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3130,5 +3130,10 @@ unsigned long wp_shared_mapping_range(struct address_space *mapping,
 
 extern int sysctl_nr_trim_pages;
 
+
+/* Page exclusive access do depend on some helpers define in here. */
+#include <linux/page-xa.h>
+
+
 #endif /* __KERNEL__ */
 #endif /* _LINUX_MM_H */
diff --git a/include/linux/page-xa.h b/include/linux/page-xa.h
new file mode 100644
index 0000000000000..8ac9e6dc051e0
--- /dev/null
+++ b/include/linux/page-xa.h
@@ -0,0 +1,66 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Page eXclusive Acess (PXA) is a generic mechanism to allow exclusive access
+ * to a file back or an anonymous page. Exclusive access means that no one can
+ * write to page except the owner of the protection (but the page can still be
+ * read). The exclusive access can be _broken_ at anytime and this can not be
+ * block (so anyone using that feature must be ready to give away the exclusive
+ * access at _any_ time and must do so in a timely fashion).
+ *
+ * Using PXA allows to implement few different features:
+ *  - KSM (Kernel Shared Memory) where page with same content are deduplicated
+ *    using a unique page and all mapping are updated to read only. This allow
+ *    to save memory for workload with a lot of pages in different process that
+ *    end up with same content (multiple VM for instance).
+ *
+ *  - NUMA duplication (sort of the opposite of KSM) here a page is duplicated
+ *    into multiple read only copy with each copy using physical memory local a
+ *    NUMA node (or a device). This allow to improve performance by minimizing
+ *    cross node memory transaction and also help minimizing bus traffic. It
+ *    does however use more memory, so what you gain in performance you loose
+ *    in available resources.
+ *
+ *  - Exclusive write access to a page, for instance you can use regular write
+ *    instruction and still get atomic behavior (as you are the only being able
+ *    to write you the garantee that no one can race with you).
+ *
+ * And any other use cases you can think of ...
+ *
+ * See Documentation/vm/page-xa.rst for further informations.
+ *
+ * Authors:
+ *  Jérôme Glisse
+ */
+#ifndef LINUX_PAGE_XA_H
+#define LINUX_PAGE_XA_H
+
+#include <linux/page-flags.h>
+#include <linux/mm_types.h>
+
+
+/*
+ * MAPPING_NULL this is temporary define use to simplify the mass modificaitons
+ * to stop relying on struct page.mapping and instead pass down mapping pointer
+ * from the context (either from inode when in syscall operating on a file or
+ * from vma->vm_file when operating on some virtual address range).
+ *
+ * DO NOT USE ! THIS IS ONLY FOR SEMANTIC PATCHES SIMPLIFICATION !
+ */
+#define MAPPING_NULL NULL
+
+
+/**
+ * PageXA() - is page under exclusive acces ?
+ *
+ * This function checks if a page is under exclusive access.
+ *
+ * @page: Pointer to page to be queried.
+ * @Return: True, if it is under exclusive access, false otherwise.
+ */
+static inline bool PageXA(struct page *page)
+{
+	return false;
+}
+
+
+#endif /* LINUX_PAGE_XA_H */
-- 
2.26.2

