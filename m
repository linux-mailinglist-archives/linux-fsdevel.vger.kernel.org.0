Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22579469875
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Dec 2021 15:17:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343832AbhLFOU5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Dec 2021 09:20:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238792AbhLFOU4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Dec 2021 09:20:56 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5A7AC061746;
        Mon,  6 Dec 2021 06:17:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1uHT4VIUmjhJFrc5mRNU6eaZQiahHGA41ulgJDMPd8I=; b=dCtnIe/9NOLCwpUPQaRMavfjtU
        JTDo/lI+G6kyC5qm25zdFhJ6yMeXWa6B+hbQr/nx2NZ0gpQkyr5d1mA8oHakgmWZZTAvSdlpk1pgw
        rC0JIB9KpUdEKPsw/JMWOi+pMcYsMjxEfVhSjBKOmqnzgP0bhIh5FOoIpf8M5dlk7gfq3U3AqY4DI
        eBQHnWgkcy9TFwtJVI6uC/YKd9bf0VwDKQZtihJ6grDYrlupzTW2G/6gpG2yiJ/0yqTezVqldc0+U
        6UmdWYu6khM7FCc9/5UUMInjr6JTjvIqMtoq7gKc/GCq6K15y+gcZoLmPHCbujKH3eNmtqzMRRVj7
        sB6GcD/Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1muEo0-004oVv-3E; Mon, 06 Dec 2021 14:17:24 +0000
Date:   Mon, 6 Dec 2021 14:17:24 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Amit Daniel Kachhap <amit.kachhap@arm.com>,
        linux-kernel@vger.kernel.org,
        Vincenzo Frascino <Vincenzo.Frascino@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        kexec <kexec@lists.infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>, x86 <x86@kernel.org>
Subject: Re: [RFC PATCH 01/14] fs/proc/vmcore: Update read_from_oldmem() for
 user pointer
Message-ID: <Ya4bdB0UBJCZhUSo@casper.infradead.org>
References: <20211203104231.17597-1-amit.kachhap@arm.com>
 <20211203104231.17597-2-amit.kachhap@arm.com>
 <20211206140451.GA4936@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211206140451.GA4936@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 06, 2021 at 03:04:51PM +0100, Christoph Hellwig wrote:
> This looks like a huge mess.  What speak against using an iov_iter
> here?

I coincidentally made a start on this last night.  Happy to stop.
What do you think to adding a generic copy_pfn_to_iter()?  Not sure
which APIs to use to implement it ... some architectures have weird
requirements about which APIs can be used for what kinds of PFNs.

diff --git a/arch/arm/kernel/crash_dump.c b/arch/arm/kernel/crash_dump.c
index 53cb92435392..ed0d806a4d14 100644
--- a/arch/arm/kernel/crash_dump.c
+++ b/arch/arm/kernel/crash_dump.c
@@ -16,39 +16,28 @@
 #include <linux/io.h>
 
 /**
- * copy_oldmem_page() - copy one page from old kernel memory
- * @pfn: page frame number to be copied
- * @buf: buffer where the copied page is placed
- * @csize: number of bytes to copy
- * @offset: offset in bytes into the page
- * @userbuf: if set, @buf is int he user address space
+ * copy_pfn_to_iter() - copy one page from old kernel memory.
+ * @iter: Where to copy the page to.
+ * @pfn: Page frame number to be copied.
+ * @offset: Offset in bytes into the page.
+ * @len: Number of bytes to copy.
  *
- * This function copies one page from old kernel memory into buffer pointed by
- * @buf. If @buf is in userspace, set @userbuf to %1. Returns number of bytes
- * copied or negative error in case of failure.
+ * This function copies (part of) one page from old kernel memory into
+ * memory described by @iter.
+ *
+ * Return: Number of bytes copied or negative error in case of failure.
  */
-ssize_t copy_oldmem_page(unsigned long pfn, char *buf,
-			 size_t csize, unsigned long offset,
-			 int userbuf)
+ssize_t copy_pfn_to_iter(struct iov_iter *iter, unsigned long pfn,
+			 size_t offset, size_t len)
 {
 	void *vaddr;
 
-	if (!csize)
-		return 0;
-
 	vaddr = ioremap(__pfn_to_phys(pfn), PAGE_SIZE);
 	if (!vaddr)
 		return -ENOMEM;
 
-	if (userbuf) {
-		if (copy_to_user(buf, vaddr + offset, csize)) {
-			iounmap(vaddr);
-			return -EFAULT;
-		}
-	} else {
-		memcpy(buf, vaddr + offset, csize);
-	}
+	len = copy_to_iter(vadd + offset, len, iter);
 
 	iounmap(vaddr);
-	return csize;
+	return len;
 }
diff --git a/include/linux/crash_dump.h b/include/linux/crash_dump.h
index 620821549b23..2dd3a692bcb7 100644
--- a/include/linux/crash_dump.h
+++ b/include/linux/crash_dump.h
@@ -24,8 +24,8 @@ extern int remap_oldmem_pfn_range(struct vm_area_struct *vma,
 				  unsigned long from, unsigned long pfn,
 				  unsigned long size, pgprot_t prot);
 
-extern ssize_t copy_oldmem_page(unsigned long, char *, size_t,
-						unsigned long, int);
+ssize_t copy_pfn_to_iter(struct iov_iter *i, unsigned long pfn, size_t offset,
+		size_t len);
 extern ssize_t copy_oldmem_page_encrypted(unsigned long pfn, char *buf,
 					  size_t csize, unsigned long offset,
 					  int userbuf);
