Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F46F46755E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Dec 2021 11:43:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380124AbhLCKqv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Dec 2021 05:46:51 -0500
Received: from foss.arm.com ([217.140.110.172]:47032 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1380100AbhLCKqr (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Dec 2021 05:46:47 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B6CDE1597;
        Fri,  3 Dec 2021 02:43:23 -0800 (PST)
Received: from a077416.arm.com (unknown [10.163.33.180])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6E1283F5A1;
        Fri,  3 Dec 2021 02:43:20 -0800 (PST)
From:   Amit Daniel Kachhap <amit.kachhap@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>,
        Vincenzo Frascino <Vincenzo.Frascino@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        kexec <kexec@lists.infradead.org>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips <linux-mips@vger.kernel.org>
Subject: [RFC PATCH 08/14] mips/crash_dump: Use the new interface copy_oldmem_page_buf
Date:   Fri,  3 Dec 2021 16:12:25 +0530
Message-Id: <20211203104231.17597-9-amit.kachhap@arm.com>
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

Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-mips <linux-mips@vger.kernel.org>
Signed-off-by: Amit Daniel Kachhap <amit.kachhap@arm.com>
---
 arch/mips/kernel/crash_dump.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/mips/kernel/crash_dump.c b/arch/mips/kernel/crash_dump.c
index 2e50f55185a6..f2406b868a27 100644
--- a/arch/mips/kernel/crash_dump.c
+++ b/arch/mips/kernel/crash_dump.c
@@ -3,20 +3,20 @@
 #include <linux/crash_dump.h>
 
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
- * in the current kernel.
+ * Copy a page from "oldmem" into buffer pointed by either @ubuf or @kbuf. For
+ * this page, there is no pte mapped in the current kernel.
  */
-ssize_t copy_oldmem_page(unsigned long pfn, char *buf,
-			 size_t csize, unsigned long offset, int userbuf)
+ssize_t copy_oldmem_page_buf(unsigned long pfn, char __user *ubuf, char *kbuf,
+			     size_t csize, unsigned long offset)
 {
 	void  *vaddr;
 
@@ -25,10 +25,10 @@ ssize_t copy_oldmem_page(unsigned long pfn, char *buf,
 
 	vaddr = kmap_local_pfn(pfn);
 
-	if (!userbuf) {
-		memcpy(buf, vaddr + offset, csize);
+	if (kbuf) {
+		memcpy(kbuf, vaddr + offset, csize);
 	} else {
-		if (copy_to_user(buf, vaddr + offset, csize))
+		if (copy_to_user(ubuf, vaddr + offset, csize))
 			csize = -EFAULT;
 	}
 
-- 
2.17.1

