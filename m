Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3C24467565
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Dec 2021 11:43:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380034AbhLCKq6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Dec 2021 05:46:58 -0500
Received: from foss.arm.com ([217.140.110.172]:47012 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1380053AbhLCKqj (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Dec 2021 05:46:39 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F19C61576;
        Fri,  3 Dec 2021 02:43:15 -0800 (PST)
Received: from a077416.arm.com (unknown [10.163.33.180])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 494573F5A1;
        Fri,  3 Dec 2021 02:43:11 -0800 (PST)
From:   Amit Daniel Kachhap <amit.kachhap@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>,
        Vincenzo Frascino <Vincenzo.Frascino@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        kexec <kexec@lists.infradead.org>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: [RFC PATCH 06/14] arm64/crash_dump: Use the new interface copy_oldmem_page_buf
Date:   Fri,  3 Dec 2021 16:12:23 +0530
Message-Id: <20211203104231.17597-7-amit.kachhap@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211203104231.17597-1-amit.kachhap@arm.com>
References: <20211203104231.17597-1-amit.kachhap@arm.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The current interface copy_oldmem_page() passes user pointer without
__user annotation and hence does unnecessary user/kernel pointer
conversions during its implementation.

Implement the interface copy_oldmem_page_buf() to avoid this issue.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Signed-off-by: Amit Daniel Kachhap <amit.kachhap@arm.com>
---
 arch/arm64/kernel/crash_dump.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/kernel/crash_dump.c b/arch/arm64/kernel/crash_dump.c
index 58303a9ec32c..ec9d5c80726c 100644
--- a/arch/arm64/kernel/crash_dump.c
+++ b/arch/arm64/kernel/crash_dump.c
@@ -14,20 +14,19 @@
 #include <asm/memory.h>
 
 /**
- * copy_oldmem_page() - copy one page from old kernel memory
+ * copy_oldmem_page_buf() - copy one page from old kernel memory
  * @pfn: page frame number to be copied
- * @buf: buffer where the copied page is placed
+ * @ubuf: user buffer where the copied page is placed
+ * @kbuf: kernel buffer where the copied page is placed
  * @csize: number of bytes to copy
  * @offset: offset in bytes into the page
- * @userbuf: if set, @buf is in a user address space
  *
  * This function copies one page from old kernel memory into buffer pointed by
- * @buf. If @buf is in userspace, set @userbuf to %1. Returns number of bytes
- * copied or negative error in case of failure.
+ * either @ubuf or @kbuf. Returns number of bytes copied or negative error in
+ * case of failure.
  */
-ssize_t copy_oldmem_page(unsigned long pfn, char *buf,
-			 size_t csize, unsigned long offset,
-			 int userbuf)
+ssize_t copy_oldmem_page_buf(unsigned long pfn, char __user *ubuf, char *kbuf,
+			     size_t csize, unsigned long offset)
 {
 	void *vaddr;
 
@@ -38,13 +37,13 @@ ssize_t copy_oldmem_page(unsigned long pfn, char *buf,
 	if (!vaddr)
 		return -ENOMEM;
 
-	if (userbuf) {
-		if (copy_to_user((char __user *)buf, vaddr + offset, csize)) {
+	if (ubuf) {
+		if (copy_to_user(ubuf, vaddr + offset, csize)) {
 			memunmap(vaddr);
 			return -EFAULT;
 		}
 	} else {
-		memcpy(buf, vaddr + offset, csize);
+		memcpy(kbuf, vaddr + offset, csize);
 	}
 
 	memunmap(vaddr);
-- 
2.17.1

