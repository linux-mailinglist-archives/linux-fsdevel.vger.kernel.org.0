Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4321A29D76B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Oct 2020 23:24:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732818AbgJ1WYC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Oct 2020 18:24:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:27035 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732778AbgJ1WYA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:24:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603923839;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pa/qCyeFjEWsSEi5vJhUVmxOcMNabU+dLIjQMHNEdtA=;
        b=MbdeAT9K31ESMJMPPuQpQ+4i0AMf3QF/aTJi/JnvicLvbMAQy5qtZSdDCNSEdVAiEjlwtl
        DGTWEE+4rW42qoAjdlPgvSKSav7H+HVtNihzPj48YcQRy9t3lJBJPxW4nRTMgmrEZiHWaG
        sgNvYW/xhGJJhHnT1jYVb8k8OSvaaO0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-514-02gb3r8rM3OU1yA0xuZ8OA-1; Wed, 28 Oct 2020 18:23:56 -0400
X-MC-Unique: 02gb3r8rM3OU1yA0xuZ8OA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EB932107AFA5;
        Wed, 28 Oct 2020 22:23:54 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-70.rdu2.redhat.com [10.10.120.70])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C4F4D6EF46;
        Wed, 28 Oct 2020 22:23:53 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 11/11] afs: Fix dirty-region encoding on ppc32 with 64K pages
From:   David Howells <dhowells@redhat.com>
To:     linux-afs@lists.infradead.org
Cc:     kernel test robot <lkp@intel.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 28 Oct 2020 22:23:53 +0000
Message-ID: <160392383297.592578.14698271215668067643.stgit@warthog.procyon.org.uk>
In-Reply-To: <160392375589.592578.13383738325695138512.stgit@warthog.procyon.org.uk>
References: <160392375589.592578.13383738325695138512.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The dirty region bounds stored in page->private on an afs page are 15 bits
on a 32-bit box and can, at most, represent a range of up to 32K within a
32K page with a resolution of 1 byte.  This is a problem for powerpc32 with
64K pages enabled.

Further, transparent huge pages may get up to 2M, which will be a problem
for the afs filesystem on all 32-bit arches in the future.

Fix this by decreasing the resolution.  For the moment, a 64K page will
have a resolution determined from PAGE_SIZE.  In the future, the page will
need to be passed in to the helper functions so that the page size can be
assessed and the resolution determined dynamically.

Note that this might not be the ideal way to handle this, since it may
allow some leakage of undirtied zero bytes to the server's copy in the case
of a 3rd-party conflict.  Fixing that would require a separately allocated
record and is a more complicated fix.

Fixes: 4343d00872e1 ("afs: Get rid of the afs_writeback record")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Matthew Wilcox (Oracle) <willy@infradead.org>
---

 fs/afs/internal.h |   24 ++++++++++++++++++++----
 fs/afs/write.c    |    5 -----
 2 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index b0fce1f75397..6e7e11a21326 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -861,7 +861,8 @@ struct afs_vnode_cache_aux {
 /*
  * We use page->private to hold the amount of the page that we've written to,
  * splitting the field into two parts.  However, we need to represent a range
- * 0...PAGE_SIZE inclusive, so we can't support 64K pages on a 32-bit system.
+ * 0...PAGE_SIZE, so we reduce the resolution if the size of the page
+ * exceeds what we can encode.
  */
 #ifdef CONFIG_64BIT
 #define __AFS_PAGE_PRIV_MASK	0x7fffffffUL
@@ -873,19 +874,34 @@ struct afs_vnode_cache_aux {
 #define __AFS_PAGE_PRIV_MMAPPED	0x8000UL
 #endif
 
+static inline unsigned int afs_page_dirty_resolution(void)
+{
+	long shift = PAGE_SHIFT - (__AFS_PAGE_PRIV_SHIFT - 1);
+	return (shift > 0) ? shift : 0;
+}
+
 static inline size_t afs_page_dirty_from(unsigned long priv)
 {
-	return priv & __AFS_PAGE_PRIV_MASK;
+	unsigned long x = priv & __AFS_PAGE_PRIV_MASK;
+
+	/* The lower bound is inclusive */
+	return x << afs_page_dirty_resolution();
 }
 
 static inline size_t afs_page_dirty_to(unsigned long priv)
 {
-	return ((priv >> __AFS_PAGE_PRIV_SHIFT) & __AFS_PAGE_PRIV_MASK) + 1;
+	unsigned long x = (priv >> __AFS_PAGE_PRIV_SHIFT) & __AFS_PAGE_PRIV_MASK;
+
+	/* The upper bound is immediately beyond the region */
+	return (x + 1) << afs_page_dirty_resolution();
 }
 
 static inline unsigned long afs_page_dirty(size_t from, size_t to)
 {
-	return ((unsigned long)(to - 1) << __AFS_PAGE_PRIV_SHIFT) | from;
+	unsigned int res = afs_page_dirty_resolution();
+	from >>= res; /* Round down */
+	to = (to - 1) >> res; /* Round up */
+	return (to << __AFS_PAGE_PRIV_SHIFT) | from;
 }
 
 static inline unsigned long afs_page_dirty_mmapped(unsigned long priv)
diff --git a/fs/afs/write.c b/fs/afs/write.c
index 0bc895d4f491..a0faab1963a8 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -90,11 +90,6 @@ int afs_write_begin(struct file *file, struct address_space *mapping,
 	_enter("{%llx:%llu},{%lx},%u,%u",
 	       vnode->fid.vid, vnode->fid.vnode, index, from, to);
 
-	/* We want to store information about how much of a page is altered in
-	 * page->private.
-	 */
-	BUILD_BUG_ON(PAGE_SIZE - 1 > __AFS_PAGE_PRIV_MASK && sizeof(page->private) < 8);
-
 	page = grab_cache_page_write_begin(mapping, index, flags);
 	if (!page)
 		return -ENOMEM;


