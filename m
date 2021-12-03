Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFDA4467562
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Dec 2021 11:43:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380137AbhLCKqx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Dec 2021 05:46:53 -0500
Received: from foss.arm.com ([217.140.110.172]:47044 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1380122AbhLCKqw (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Dec 2021 05:46:52 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F0B571596;
        Fri,  3 Dec 2021 02:43:27 -0800 (PST)
Received: from a077416.arm.com (unknown [10.163.33.180])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5D81C3F5A1;
        Fri,  3 Dec 2021 02:43:24 -0800 (PST)
From:   Amit Daniel Kachhap <amit.kachhap@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>,
        Vincenzo Frascino <Vincenzo.Frascino@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        kexec <kexec@lists.infradead.org>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        linux-sh <linux-sh@vger.kernel.org>
Subject: [RFC PATCH 09/14] sh/crash_dump: Use the new interface copy_oldmem_page_buf
Date:   Fri,  3 Dec 2021 16:12:26 +0530
Message-Id: <20211203104231.17597-10-amit.kachhap@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211203104231.17597-1-amit.kachhap@arm.com>
References: <20211203104231.17597-1-amit.kachhap@arm.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The current interface copy_oldmem_page() passes user pointer without
__user annotation and hence does unnecessary user/kernel pointer
conversions during its implementation.

Use the interface copy_oldmem_page_buf() to avoid this issue.

Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
CC: linux-sh <linux-sh@vger.kernel.org>
Signed-off-by: Amit Daniel Kachhap <amit.kachhap@arm.com>
---
 arch/sh/kernel/crash_dump.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/arch/sh/kernel/crash_dump.c b/arch/sh/kernel/crash_dump.c
index 5b41b59698c1..a80dedf1ace5 100644
--- a/arch/sh/kernel/crash_dump.c
+++ b/arch/sh/kernel/crash_dump.c
@@ -11,20 +11,21 @@
 #include <linux/uaccess.h>
 
 /**
- * copy_oldmem_page - copy one page from "oldmem"
+ * copy_oldmem_page_buf - copy one page from "oldmem"
  * @pfn: page frame number to be copied
- * @buf: target memory address for the copy; this can be in kernel address
- *	space or user address space (see @userbuf)
+ * @ubuf: target user memory pointer for the copy; use copy_to_user() if this
+ * pointer is not NULL
+ * @kbuf: target kernel memory pointer for the copy; use memcpy() if this
+ * pointer is not NULL
  * @csize: number of bytes to copy
  * @offset: offset in bytes into the page (based on pfn) to begin the copy
- * @userbuf: if set, @buf is in user address space, use copy_to_user(),
- *	otherwise @buf is in kernel address space, use memcpy().
  *
- * Copy a page from "oldmem". For this page, there is no pte mapped
- * in the current kernel. We stitch up a pte, similar to kmap_atomic.
+ * Copy a page from "oldmem" into the buffer pointed by either @ubuf or @kbuf.
+ * For this page, there is no pte mapped in the current kernel. We stitch up a
+ * pte, similar to kmap_atomic.
  */
-ssize_t copy_oldmem_page(unsigned long pfn, char *buf,
-                               size_t csize, unsigned long offset, int userbuf)
+ssize_t copy_oldmem_page_buf(unsigned long pfn, char __user *ubuf, char *kbuf,
+			     size_t csize, unsigned long offset)
 {
 	void  __iomem *vaddr;
 
@@ -33,13 +34,13 @@ ssize_t copy_oldmem_page(unsigned long pfn, char *buf,
 
 	vaddr = ioremap(pfn << PAGE_SHIFT, PAGE_SIZE);
 
-	if (userbuf) {
-		if (copy_to_user((void __user *)buf, (vaddr + offset), csize)) {
+	if (ubuf) {
+		if (copy_to_user(ubuf, (vaddr + offset), csize)) {
 			iounmap(vaddr);
 			return -EFAULT;
 		}
 	} else
-	memcpy(buf, (vaddr + offset), csize);
+		memcpy(kbuf, (vaddr + offset), csize);
 
 	iounmap(vaddr);
 	return csize;
-- 
2.17.1

