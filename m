Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9110A62DEBA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Nov 2022 15:56:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239442AbiKQO4B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Nov 2022 09:56:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239353AbiKQOzu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Nov 2022 09:55:50 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E171D45097
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Nov 2022 06:54:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668696895;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SByhc5VsJEeiVwJxzJfkOEqV7pDWaUCcZFv6lsxN4+w=;
        b=fnc2EyKFic2UcOe/T2dxqiWE5QpuTDQBlxSLLihPRWjVTE/KYXqw2oYkuqLJpWLRHJn3da
        5b4Tzvd+seURcnYvaDxUhFUsqT5x455vBnOAb5yyKJQMbQpL2JCg5a2irFhqNjXe4V7WXW
        fQq5NZN8I86g3FywuMnxylBqMuduXTA=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-529-xH_rhtuaNAqOtLjlZE7alQ-1; Thu, 17 Nov 2022 09:54:50 -0500
X-MC-Unique: xH_rhtuaNAqOtLjlZE7alQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 582EC1C0A110;
        Thu, 17 Nov 2022 14:54:49 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 346B8C1E890;
        Thu, 17 Nov 2022 14:54:48 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 1/4] mm: Move FOLL_* defs to mm_types.h
From:   David Howells <dhowells@redhat.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Matthew Wilcox <willy@infradead.org>,
        John Hubbard <jhubbard@nvidia.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, dhowells@redhat.com,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 17 Nov 2022 14:54:45 +0000
Message-ID: <166869688542.3723671.10243929000823258622.stgit@warthog.procyon.org.uk>
In-Reply-To: <166869687556.3723671.10061142538708346995.stgit@warthog.procyon.org.uk>
References: <166869687556.3723671.10061142538708346995.stgit@warthog.procyon.org.uk>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Move FOLL_* definitions to linux/mm_types.h to make them more accessible
without having to drag in all of linux/mm.h and everything that drags in
too[1].

Suggested-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: John Hubbard <jhubbard@nvidia.com>
cc: Al Viro <viro@zeniv.linux.org.uk>
cc: linux-mm@kvack.org
cc: linux-fsdevel@vger.kernel.org
Link: https://lore.kernel.org/linux-fsdevel/Y1%2FhSO+7kAJhGShG@casper.infradead.org/ [1]
---

 include/linux/mm.h       |   74 ----------------------------------------------
 include/linux/mm_types.h |   73 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 73 insertions(+), 74 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 8bbcccbc5565..7a7a287818ad 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2941,80 +2941,6 @@ static inline vm_fault_t vmf_error(int err)
 struct page *follow_page(struct vm_area_struct *vma, unsigned long address,
 			 unsigned int foll_flags);
 
-#define FOLL_WRITE	0x01	/* check pte is writable */
-#define FOLL_TOUCH	0x02	/* mark page accessed */
-#define FOLL_GET	0x04	/* do get_page on page */
-#define FOLL_DUMP	0x08	/* give error on hole if it would be zero */
-#define FOLL_FORCE	0x10	/* get_user_pages read/write w/o permission */
-#define FOLL_NOWAIT	0x20	/* if a disk transfer is needed, start the IO
-				 * and return without waiting upon it */
-#define FOLL_NOFAULT	0x80	/* do not fault in pages */
-#define FOLL_HWPOISON	0x100	/* check page is hwpoisoned */
-#define FOLL_MIGRATION	0x400	/* wait for page to replace migration entry */
-#define FOLL_TRIED	0x800	/* a retry, previous pass started an IO */
-#define FOLL_REMOTE	0x2000	/* we are working on non-current tsk/mm */
-#define FOLL_ANON	0x8000	/* don't do file mappings */
-#define FOLL_LONGTERM	0x10000	/* mapping lifetime is indefinite: see below */
-#define FOLL_SPLIT_PMD	0x20000	/* split huge pmd before returning */
-#define FOLL_PIN	0x40000	/* pages must be released via unpin_user_page */
-#define FOLL_FAST_ONLY	0x80000	/* gup_fast: prevent fall-back to slow gup */
-
-/*
- * FOLL_PIN and FOLL_LONGTERM may be used in various combinations with each
- * other. Here is what they mean, and how to use them:
- *
- * FOLL_LONGTERM indicates that the page will be held for an indefinite time
- * period _often_ under userspace control.  This is in contrast to
- * iov_iter_get_pages(), whose usages are transient.
- *
- * FIXME: For pages which are part of a filesystem, mappings are subject to the
- * lifetime enforced by the filesystem and we need guarantees that longterm
- * users like RDMA and V4L2 only establish mappings which coordinate usage with
- * the filesystem.  Ideas for this coordination include revoking the longterm
- * pin, delaying writeback, bounce buffer page writeback, etc.  As FS DAX was
- * added after the problem with filesystems was found FS DAX VMAs are
- * specifically failed.  Filesystem pages are still subject to bugs and use of
- * FOLL_LONGTERM should be avoided on those pages.
- *
- * FIXME: Also NOTE that FOLL_LONGTERM is not supported in every GUP call.
- * Currently only get_user_pages() and get_user_pages_fast() support this flag
- * and calls to get_user_pages_[un]locked are specifically not allowed.  This
- * is due to an incompatibility with the FS DAX check and
- * FAULT_FLAG_ALLOW_RETRY.
- *
- * In the CMA case: long term pins in a CMA region would unnecessarily fragment
- * that region.  And so, CMA attempts to migrate the page before pinning, when
- * FOLL_LONGTERM is specified.
- *
- * FOLL_PIN indicates that a special kind of tracking (not just page->_refcount,
- * but an additional pin counting system) will be invoked. This is intended for
- * anything that gets a page reference and then touches page data (for example,
- * Direct IO). This lets the filesystem know that some non-file-system entity is
- * potentially changing the pages' data. In contrast to FOLL_GET (whose pages
- * are released via put_page()), FOLL_PIN pages must be released, ultimately, by
- * a call to unpin_user_page().
- *
- * FOLL_PIN is similar to FOLL_GET: both of these pin pages. They use different
- * and separate refcounting mechanisms, however, and that means that each has
- * its own acquire and release mechanisms:
- *
- *     FOLL_GET: get_user_pages*() to acquire, and put_page() to release.
- *
- *     FOLL_PIN: pin_user_pages*() to acquire, and unpin_user_pages to release.
- *
- * FOLL_PIN and FOLL_GET are mutually exclusive for a given function call.
- * (The underlying pages may experience both FOLL_GET-based and FOLL_PIN-based
- * calls applied to them, and that's perfectly OK. This is a constraint on the
- * callers, not on the pages.)
- *
- * FOLL_PIN should be set internally by the pin_user_pages*() APIs, never
- * directly by the caller. That's in order to help avoid mismatches when
- * releasing pages: get_user_pages*() pages must be released via put_page(),
- * while pin_user_pages*() pages must be released via unpin_user_page().
- *
- * Please see Documentation/core-api/pin_user_pages.rst for more information.
- */
-
 static inline int vm_fault_to_errno(vm_fault_t vm_fault, int foll_flags)
 {
 	if (vm_fault & VM_FAULT_OOM)
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 500e536796ca..0c80a5ad6e6a 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -1003,4 +1003,77 @@ enum fault_flag {
 
 typedef unsigned int __bitwise zap_flags_t;
 
+/*
+ * FOLL_PIN and FOLL_LONGTERM may be used in various combinations with each
+ * other. Here is what they mean, and how to use them:
+ *
+ * FOLL_LONGTERM indicates that the page will be held for an indefinite time
+ * period _often_ under userspace control.  This is in contrast to
+ * iov_iter_get_pages(), whose usages are transient.
+ *
+ * FIXME: For pages which are part of a filesystem, mappings are subject to the
+ * lifetime enforced by the filesystem and we need guarantees that longterm
+ * users like RDMA and V4L2 only establish mappings which coordinate usage with
+ * the filesystem.  Ideas for this coordination include revoking the longterm
+ * pin, delaying writeback, bounce buffer page writeback, etc.  As FS DAX was
+ * added after the problem with filesystems was found FS DAX VMAs are
+ * specifically failed.  Filesystem pages are still subject to bugs and use of
+ * FOLL_LONGTERM should be avoided on those pages.
+ *
+ * FIXME: Also NOTE that FOLL_LONGTERM is not supported in every GUP call.
+ * Currently only get_user_pages() and get_user_pages_fast() support this flag
+ * and calls to get_user_pages_[un]locked are specifically not allowed.  This
+ * is due to an incompatibility with the FS DAX check and
+ * FAULT_FLAG_ALLOW_RETRY.
+ *
+ * In the CMA case: long term pins in a CMA region would unnecessarily fragment
+ * that region.  And so, CMA attempts to migrate the page before pinning, when
+ * FOLL_LONGTERM is specified.
+ *
+ * FOLL_PIN indicates that a special kind of tracking (not just page->_refcount,
+ * but an additional pin counting system) will be invoked. This is intended for
+ * anything that gets a page reference and then touches page data (for example,
+ * Direct IO). This lets the filesystem know that some non-file-system entity is
+ * potentially changing the pages' data. In contrast to FOLL_GET (whose pages
+ * are released via put_page()), FOLL_PIN pages must be released, ultimately, by
+ * a call to unpin_user_page().
+ *
+ * FOLL_PIN is similar to FOLL_GET: both of these pin pages. They use different
+ * and separate refcounting mechanisms, however, and that means that each has
+ * its own acquire and release mechanisms:
+ *
+ *     FOLL_GET: get_user_pages*() to acquire, and put_page() to release.
+ *
+ *     FOLL_PIN: pin_user_pages*() to acquire, and unpin_user_pages to release.
+ *
+ * FOLL_PIN and FOLL_GET are mutually exclusive for a given function call.
+ * (The underlying pages may experience both FOLL_GET-based and FOLL_PIN-based
+ * calls applied to them, and that's perfectly OK. This is a constraint on the
+ * callers, not on the pages.)
+ *
+ * FOLL_PIN should be set internally by the pin_user_pages*() APIs, never
+ * directly by the caller. That's in order to help avoid mismatches when
+ * releasing pages: get_user_pages*() pages must be released via put_page(),
+ * while pin_user_pages*() pages must be released via unpin_user_page().
+ *
+ * Please see Documentation/core-api/pin_user_pages.rst for more information.
+ */
+#define FOLL_WRITE	0x01	/* check pte is writable */
+#define FOLL_TOUCH	0x02	/* mark page accessed */
+#define FOLL_GET	0x04	/* do get_page on page */
+#define FOLL_DUMP	0x08	/* give error on hole if it would be zero */
+#define FOLL_FORCE	0x10	/* get_user_pages read/write w/o permission */
+#define FOLL_NOWAIT	0x20	/* if a disk transfer is needed, start the IO
+				 * and return without waiting upon it */
+#define FOLL_NOFAULT	0x80	/* do not fault in pages */
+#define FOLL_HWPOISON	0x100	/* check page is hwpoisoned */
+#define FOLL_MIGRATION	0x400	/* wait for page to replace migration entry */
+#define FOLL_TRIED	0x800	/* a retry, previous pass started an IO */
+#define FOLL_REMOTE	0x2000	/* we are working on non-current tsk/mm */
+#define FOLL_ANON	0x8000	/* don't do file mappings */
+#define FOLL_LONGTERM	0x10000	/* mapping lifetime is indefinite: see below */
+#define FOLL_SPLIT_PMD	0x20000	/* split huge pmd before returning */
+#define FOLL_PIN	0x40000	/* pages must be released via unpin_user_page */
+#define FOLL_FAST_ONLY	0x80000	/* gup_fast: prevent fall-back to slow gup */
+
 #endif /* _LINUX_MM_TYPES_H */


