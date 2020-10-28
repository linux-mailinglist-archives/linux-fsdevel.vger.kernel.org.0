Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C85B29D64F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Oct 2020 23:14:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731119AbgJ1WNp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Oct 2020 18:13:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44916 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731101AbgJ1WNd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:13:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603923211;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=emVyRhclwMM5wrrh3ixL9pwMkf5m00soaaaEDfdHm+Q=;
        b=UxiSkFJ7ND128AFCRBKTo54ayC2l4dEYeNYTgh5xhcCMX+382p2SVbzk0KiIILAVvnKW9T
        Cpj4ft3TzJAmGFzqDJBYitHHgK0MORMsZdmWGMFD+EcBCZM6cvOjNV+Bc8Eo9ozNhQ1kdf
        iYpdJQv6vGLG4Cski55dZ+SaeBJSsfk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-515-UmUAvUSoObu-ECE3VKZ38A-1; Wed, 28 Oct 2020 10:10:55 -0400
X-MC-Unique: UmUAvUSoObu-ECE3VKZ38A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5F49E6D583;
        Wed, 28 Oct 2020 14:10:54 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-70.rdu2.redhat.com [10.10.120.70])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9F22560C04;
        Wed, 28 Oct 2020 14:10:53 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 09/11] afs: Alter dirty range encoding in page->private
From:   David Howells <dhowells@redhat.com>
To:     linux-afs@lists.infradead.org
Cc:     dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 28 Oct 2020 14:10:52 +0000
Message-ID: <160389425289.300137.8989389839598335591.stgit@warthog.procyon.org.uk>
In-Reply-To: <160389418807.300137.8222864749005731859.stgit@warthog.procyon.org.uk>
References: <160389418807.300137.8222864749005731859.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Currently, page->private on an afs page is used to store the range of
dirtied data within the page, where the range includes the lower bound, but
excludes the upper bound (e.g. 0-1 is a range covering a single byte).

This, however, requires a superfluous bit for the last-byte bound so that
on a 4KiB page, it can say 0-4096 to indicate the whole page, the idea
being that having both numbers the same would indicate an empty range.
This is unnecessary as the PG_private bit is clear if it's an empty range
(as is PG_dirty).

Alter the way the dirty range is encoded in page->private such that the
upper bound is reduced by 1 (e.g. 0-0 is then specified the same single
byte range mentioned above).

Applying this to both bounds frees up two bits, one of which can be used in
a future commit.

This allows the afs filesystem to be compiled on ppc32 with 64K pages;
without this, the following warnings are seen:

../fs/afs/internal.h: In function 'afs_page_dirty_to':
../fs/afs/internal.h:881:15: warning: right shift count >= width of type [-Wshift-count-overflow]
  881 |  return (priv >> __AFS_PAGE_PRIV_SHIFT) & __AFS_PAGE_PRIV_MASK;
      |               ^~
../fs/afs/internal.h: In function 'afs_page_dirty':
../fs/afs/internal.h:886:28: warning: left shift count >= width of type [-Wshift-count-overflow]
  886 |  return ((unsigned long)to << __AFS_PAGE_PRIV_SHIFT) | from;
      |                            ^~

Fixes: 4343d00872e1 ("afs: Get rid of the afs_writeback record")
Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/internal.h |    6 +++---
 fs/afs/write.c    |    2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 150a72036a37..59be9bf9ee2f 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -863,7 +863,7 @@ struct afs_vnode_cache_aux {
  * splitting the field into two parts.  However, we need to represent a range
  * 0...PAGE_SIZE inclusive, so we can't support 64K pages on a 32-bit system.
  */
-#if PAGE_SIZE > 32768
+#ifdef CONFIG_64BIT
 #define __AFS_PAGE_PRIV_MASK	0xffffffffUL
 #define __AFS_PAGE_PRIV_SHIFT	32
 #else
@@ -878,12 +878,12 @@ static inline unsigned int afs_page_dirty_from(unsigned long priv)
 
 static inline unsigned int afs_page_dirty_to(unsigned long priv)
 {
-	return (priv >> __AFS_PAGE_PRIV_SHIFT) & __AFS_PAGE_PRIV_MASK;
+	return ((priv >> __AFS_PAGE_PRIV_SHIFT) & __AFS_PAGE_PRIV_MASK) + 1;
 }
 
 static inline unsigned long afs_page_dirty(unsigned int from, unsigned int to)
 {
-	return ((unsigned long)to << __AFS_PAGE_PRIV_SHIFT) | from;
+	return ((unsigned long)(to - 1) << __AFS_PAGE_PRIV_SHIFT) | from;
 }
 
 #include <trace/events/afs.h>
diff --git a/fs/afs/write.c b/fs/afs/write.c
index 91bc2cb2cad1..f113eaae36f0 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -93,7 +93,7 @@ int afs_write_begin(struct file *file, struct address_space *mapping,
 	/* We want to store information about how much of a page is altered in
 	 * page->private.
 	 */
-	BUILD_BUG_ON(PAGE_SIZE > 32768 && sizeof(page->private) < 8);
+	BUILD_BUG_ON(PAGE_SIZE - 1 > __AFS_PAGE_PRIV_MASK && sizeof(page->private) < 8);
 
 	page = grab_cache_page_write_begin(mapping, index, flags);
 	if (!page)


