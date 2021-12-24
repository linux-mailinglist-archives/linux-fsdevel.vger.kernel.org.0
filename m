Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB64E47EC0C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Dec 2021 07:23:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351564AbhLXGXT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Dec 2021 01:23:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351521AbhLXGXL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Dec 2021 01:23:11 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14778C061401;
        Thu, 23 Dec 2021 22:23:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=M+rMLN9/ESUQyF+dU/QyIxNWoktxuGpNXMdE3S1bzr8=; b=u2aCIEsShRRBipFbon/84kdy6b
        o51ou3OG2XQNs8ws15p2AbuWNOvSA7WuYlC4JR5lAeRwIQU8wTT2IbZ6LY99Mi2t+Jd1qK3IMdCLL
        CbjDLjgEiDhPPg3i/TgQEtut3jC6skioz6itpl7Gjr3zr3eHqa8Y9tAnEYCMiaUatlBunf7/Y/lL1
        0vtegYjYk2cI0OoWbvSgPQc6R/qyIFvdth2827PUUJcAr6LZmiR5gGdLlzP3S5C0fy/GysXUNI8Uc
        j7ezAJ1AfuTlAEQD5ZPAEXitfwJGeey9kHyzinj9/Rq9xbOO+qf5Gv+MzJGoB57/ipi2JbDqQAsuz
        5iicauAA==;
Received: from p4fdb0b85.dip0.t-ipconnect.de ([79.219.11.133] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n0dyn-00Dn0h-2n; Fri, 24 Dec 2021 06:23:01 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     Hugh Dickins <hughd@google.com>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH 04/13] frontswap: remove frontswap_shrink
Date:   Fri, 24 Dec 2021 07:22:37 +0100
Message-Id: <20211224062246.1258487-5-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211224062246.1258487-1-hch@lst.de>
References: <20211224062246.1258487-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

frontswap_shrink is never called, so remove it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 Documentation/vm/frontswap.rst | 13 ------
 include/linux/frontswap.h      |  1 -
 mm/frontswap.c                 | 83 ----------------------------------
 3 files changed, 97 deletions(-)

diff --git a/Documentation/vm/frontswap.rst b/Documentation/vm/frontswap.rst
index 2ab660651d04e..feecc5e244778 100644
--- a/Documentation/vm/frontswap.rst
+++ b/Documentation/vm/frontswap.rst
@@ -255,19 +255,6 @@ the old data and ensure that it is no longer accessible.  Since the
 swap subsystem then writes the new data to the read swap device,
 this is the correct course of action to ensure coherency.
 
-* What is frontswap_shrink for?
-
-When the (non-frontswap) swap subsystem swaps out a page to a real
-swap device, that page is only taking up low-value pre-allocated disk
-space.  But if frontswap has placed a page in transcendent memory, that
-page may be taking up valuable real estate.  The frontswap_shrink
-routine allows code outside of the swap subsystem to force pages out
-of the memory managed by frontswap and back into kernel-addressable memory.
-For example, in RAMster, a "suction driver" thread will attempt
-to "repatriate" pages sent to a remote machine back to the local machine;
-this is driven using the frontswap_shrink mechanism when memory pressure
-subsides.
-
 * Why does the frontswap patch create the new include file swapfile.h?
 
 The frontswap code depends on some swap-subsystem-internal data
diff --git a/include/linux/frontswap.h b/include/linux/frontswap.h
index 83a56392cc7f6..d268d7bb65134 100644
--- a/include/linux/frontswap.h
+++ b/include/linux/frontswap.h
@@ -24,7 +24,6 @@ struct frontswap_ops {
 };
 
 extern void frontswap_register_ops(struct frontswap_ops *ops);
-extern void frontswap_shrink(unsigned long);
 extern unsigned long frontswap_curr_pages(void);
 
 extern bool __frontswap_test(struct swap_info_struct *, pgoff_t);
diff --git a/mm/frontswap.c b/mm/frontswap.c
index dba7f087ee862..a77ebba6101bd 100644
--- a/mm/frontswap.c
+++ b/mm/frontswap.c
@@ -341,89 +341,6 @@ static unsigned long __frontswap_curr_pages(void)
 	return totalpages;
 }
 
-static int __frontswap_unuse_pages(unsigned long total, unsigned long *unused,
-					int *swapid)
-{
-	int ret = -EINVAL;
-	struct swap_info_struct *si = NULL;
-	int si_frontswap_pages;
-	unsigned long total_pages_to_unuse = total;
-	unsigned long pages = 0, pages_to_unuse = 0;
-
-	assert_spin_locked(&swap_lock);
-	plist_for_each_entry(si, &swap_active_head, list) {
-		si_frontswap_pages = atomic_read(&si->frontswap_pages);
-		if (total_pages_to_unuse < si_frontswap_pages) {
-			pages = pages_to_unuse = total_pages_to_unuse;
-		} else {
-			pages = si_frontswap_pages;
-			pages_to_unuse = 0; /* unuse all */
-		}
-		/* ensure there is enough RAM to fetch pages from frontswap */
-		if (security_vm_enough_memory_mm(current->mm, pages)) {
-			ret = -ENOMEM;
-			continue;
-		}
-		vm_unacct_memory(pages);
-		*unused = pages_to_unuse;
-		*swapid = si->type;
-		ret = 0;
-		break;
-	}
-
-	return ret;
-}
-
-/*
- * Used to check if it's necessary and feasible to unuse pages.
- * Return 1 when nothing to do, 0 when need to shrink pages,
- * error code when there is an error.
- */
-static int __frontswap_shrink(unsigned long target_pages,
-				unsigned long *pages_to_unuse,
-				int *type)
-{
-	unsigned long total_pages = 0, total_pages_to_unuse;
-
-	assert_spin_locked(&swap_lock);
-
-	total_pages = __frontswap_curr_pages();
-	if (total_pages <= target_pages) {
-		/* Nothing to do */
-		*pages_to_unuse = 0;
-		return 1;
-	}
-	total_pages_to_unuse = total_pages - target_pages;
-	return __frontswap_unuse_pages(total_pages_to_unuse, pages_to_unuse, type);
-}
-
-/*
- * Frontswap, like a true swap device, may unnecessarily retain pages
- * under certain circumstances; "shrink" frontswap is essentially a
- * "partial swapoff" and works by calling try_to_unuse to attempt to
- * unuse enough frontswap pages to attempt to -- subject to memory
- * constraints -- reduce the number of pages in frontswap to the
- * number given in the parameter target_pages.
- */
-void frontswap_shrink(unsigned long target_pages)
-{
-	unsigned long pages_to_unuse = 0;
-	int type, ret;
-
-	/*
-	 * we don't want to hold swap_lock while doing a very
-	 * lengthy try_to_unuse, but swap_list may change
-	 * so restart scan from swap_active_head each time
-	 */
-	spin_lock(&swap_lock);
-	ret = __frontswap_shrink(target_pages, &pages_to_unuse, &type);
-	spin_unlock(&swap_lock);
-	if (ret == 0)
-		try_to_unuse(type, true, pages_to_unuse);
-	return;
-}
-EXPORT_SYMBOL(frontswap_shrink);
-
 /*
  * Count and return the number of frontswap pages across all
  * swap devices.  This is exported so that backend drivers can
-- 
2.30.2

