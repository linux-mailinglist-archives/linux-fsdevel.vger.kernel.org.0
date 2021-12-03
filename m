Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3FE8467571
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Dec 2021 11:44:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380173AbhLCKrS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Dec 2021 05:47:18 -0500
Received: from foss.arm.com ([217.140.110.172]:47116 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1380187AbhLCKrJ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Dec 2021 05:47:09 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 365D315BF;
        Fri,  3 Dec 2021 02:43:45 -0800 (PST)
Received: from a077416.arm.com (unknown [10.163.33.180])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 187413F5A1;
        Fri,  3 Dec 2021 02:43:40 -0800 (PST)
From:   Amit Daniel Kachhap <amit.kachhap@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>,
        Vincenzo Frascino <Vincenzo.Frascino@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        kexec <kexec@lists.infradead.org>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>
Subject: [RFC PATCH 13/14] s390/crash_dump: Use the new interface copy_oldmem_page_buf
Date:   Fri,  3 Dec 2021 16:12:30 +0530
Message-Id: <20211203104231.17597-14-amit.kachhap@arm.com>
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

Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
CC: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: linux-s390 <linux-s390@vger.kernel.org>
Signed-off-by: Amit Daniel Kachhap <amit.kachhap@arm.com>
---
 arch/s390/kernel/crash_dump.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/s390/kernel/crash_dump.c b/arch/s390/kernel/crash_dump.c
index 785d54c9350c..b1f8a908e8ca 100644
--- a/arch/s390/kernel/crash_dump.c
+++ b/arch/s390/kernel/crash_dump.c
@@ -214,8 +214,8 @@ static int copy_oldmem_user(void __user *dst, void *src, size_t count)
 /*
  * Copy one page from "oldmem"
  */
-ssize_t copy_oldmem_page(unsigned long pfn, char *buf, size_t csize,
-			 unsigned long offset, int userbuf)
+ssize_t copy_oldmem_page_buf(unsigned long pfn, char __user *ubuf, char *kbuf,
+			     size_t csize, unsigned long offset)
 {
 	void *src;
 	int rc;
@@ -223,10 +223,10 @@ ssize_t copy_oldmem_page(unsigned long pfn, char *buf, size_t csize,
 	if (!csize)
 		return 0;
 	src = (void *) (pfn << PAGE_SHIFT) + offset;
-	if (userbuf)
-		rc = copy_oldmem_user((void __force __user *) buf, src, csize);
+	if (ubuf)
+		rc = copy_oldmem_user((void __user *) ubuf, src, csize);
 	else
-		rc = copy_oldmem_kernel((void *) buf, src, csize);
+		rc = copy_oldmem_kernel((void *) kbuf, src, csize);
 	return rc;
 }
 
@@ -261,7 +261,7 @@ static int remap_oldmem_pfn_range_kdump(struct vm_area_struct *vma,
  * Remap "oldmem" for zfcp/nvme dump
  *
  * We only map available memory above HSA size. Memory below HSA size
- * is read on demand using the copy_oldmem_page() function.
+ * is read on demand using the copy_oldmem_page_buf() function.
  */
 static int remap_oldmem_pfn_range_zfcpdump(struct vm_area_struct *vma,
 					   unsigned long from,
-- 
2.17.1

