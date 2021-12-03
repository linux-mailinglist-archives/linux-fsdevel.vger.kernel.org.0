Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50934467575
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Dec 2021 11:44:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380241AbhLCKr1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Dec 2021 05:47:27 -0500
Received: from foss.arm.com ([217.140.110.172]:47132 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1380205AbhLCKrN (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Dec 2021 05:47:13 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 76C7D1576;
        Fri,  3 Dec 2021 02:43:49 -0800 (PST)
Received: from a077416.arm.com (unknown [10.163.33.180])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BF8903F5A1;
        Fri,  3 Dec 2021 02:43:45 -0800 (PST)
From:   Amit Daniel Kachhap <amit.kachhap@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>,
        Vincenzo Frascino <Vincenzo.Frascino@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        kexec <kexec@lists.infradead.org>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>
Subject: [RFC PATCH 14/14] fs/proc/vmcore: Remove the unused old interface copy_oldmem_page
Date:   Fri,  3 Dec 2021 16:12:31 +0530
Message-Id: <20211203104231.17597-15-amit.kachhap@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211203104231.17597-1-amit.kachhap@arm.com>
References: <20211203104231.17597-1-amit.kachhap@arm.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

As all archs have upgraded to use the new interface copy_oldmem_page_buf()
so remove the unused copy_oldmem_page. Also remove the weak definitions.

Cc: Dave Young <dyoung@redhat.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: kexec <kexec@lists.infradead.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>
Signed-off-by: Amit Daniel Kachhap <amit.kachhap@arm.com>
---
 fs/proc/vmcore.c           | 14 --------------
 include/linux/crash_dump.h |  2 --
 2 files changed, 16 deletions(-)

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index d01b85c043dd..1edababe4bde 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -244,20 +244,6 @@ copy_oldmem_page_encrypted(unsigned long pfn, char __user *ubuf, char *kbuf,
 	return copy_oldmem_page_buf(pfn, ubuf, kbuf, csize, offset);
 }
 
-ssize_t __weak
-copy_oldmem_page_buf(unsigned long pfn, char __user *ubuf, char *kbuf,
-		     size_t csize, unsigned long offset)
-{
-	return -EOPNOTSUPP;
-}
-
-ssize_t __weak
-copy_oldmem_page(unsigned long pfn, char *ubuf, size_t csize,
-		 unsigned long offset, int userbuf)
-{
-	return -EOPNOTSUPP;
-}
-
 /*
  * Copy to either kernel or user space buffer
  */
diff --git a/include/linux/crash_dump.h b/include/linux/crash_dump.h
index 725c4e053ecf..e897bdc0b7bf 100644
--- a/include/linux/crash_dump.h
+++ b/include/linux/crash_dump.h
@@ -24,8 +24,6 @@ extern int remap_oldmem_pfn_range(struct vm_area_struct *vma,
 				  unsigned long from, unsigned long pfn,
 				  unsigned long size, pgprot_t prot);
 
-extern ssize_t copy_oldmem_page(unsigned long, char *, size_t,
-						unsigned long, int);
 extern ssize_t copy_oldmem_page_buf(unsigned long pfn, char __user *ubuf,
 				    char *kbuf, size_t csize,
 				    unsigned long offset);
-- 
2.17.1

