Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B2403A67A5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jun 2021 15:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233851AbhFNNWc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Jun 2021 09:22:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53255 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233793AbhFNNWc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Jun 2021 09:22:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623676829;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=5xj7L/EwGhvToopXR0OONDmVKcDoSh/SbGg3r7noEik=;
        b=X9NfWIgf9BL2ITrou0xwcqjAGJPcb7pHcfHGiBfjfvO6tb6AGlN8Ijrdk+VR/xmRV7MNEy
        FXylhURfBT9QGyBK2Cf1AXRTAl8Ah478NUEANLnhFzzZz+XLzNNC84tOpB9c3DAgrJvlY2
        fEuPB4XzxVSAtX7ndH7g1F2uTeFAb18=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-103-1A-oh0Z1P4qcVXxowJTRmg-1; Mon, 14 Jun 2021 09:20:24 -0400
X-MC-Unique: 1A-oh0Z1P4qcVXxowJTRmg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0603C100CFB9;
        Mon, 14 Jun 2021 13:20:20 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-118-65.rdu2.redhat.com [10.10.118.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CA16D19C46;
        Mon, 14 Jun 2021 13:20:18 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 1/3] afs: Handle len being extending over page end in
 write_begin/write_end
From:   David Howells <dhowells@redhat.com>
To:     jlayton@kernel.org, willy@infradead.org
Cc:     linux-afs@lists.infradead.org, dhowells@redhat.com,
        linux-afs@lists.infradead.org, ceph-devel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 14 Jun 2021 14:20:17 +0100
Message-ID: <162367681795.460125.11729955608839747375.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

With transparent huge pages, in the future, write_begin() and write_end()
may be passed a length parameter that, in combination with the offset into
the page, exceeds the length of that page.  This allows
grab_cache_page_write_begin() to better choose the size of THP to allocate.

Fix afs's functions to handle this by trimming the length as needed after
the page has been allocated.

Fixes: e1b1240c1ff5 ("netfs: Add write_begin helper")
Reported-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-afs@lists.infradead.org
---

 fs/afs/write.c |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/fs/afs/write.c b/fs/afs/write.c
index a523bb86915d..f68274c39f47 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -25,7 +25,8 @@ int afs_set_page_dirty(struct page *page)
 }
 
 /*
- * prepare to perform part of a write to a page
+ * Prepare to perform part of a write to a page.  Note that len may extend
+ * beyond the end of the page.
  */
 int afs_write_begin(struct file *file, struct address_space *mapping,
 		    loff_t pos, unsigned len, unsigned flags,
@@ -52,7 +53,8 @@ int afs_write_begin(struct file *file, struct address_space *mapping,
 		return ret;
 
 	index = page->index;
-	from = pos - index * PAGE_SIZE;
+	from = offset_in_thp(page, pos);
+	len = min_t(size_t, len, thp_size(page) - from);
 	to = from + len;
 
 try_again:
@@ -103,7 +105,8 @@ int afs_write_begin(struct file *file, struct address_space *mapping,
 }
 
 /*
- * finalise part of a write to a page
+ * Finalise part of a write to a page.  Note that len may extend beyond the end
+ * of the page.
  */
 int afs_write_end(struct file *file, struct address_space *mapping,
 		  loff_t pos, unsigned len, unsigned copied,
@@ -111,7 +114,7 @@ int afs_write_end(struct file *file, struct address_space *mapping,
 {
 	struct afs_vnode *vnode = AFS_FS_I(file_inode(file));
 	unsigned long priv;
-	unsigned int f, from = pos & (thp_size(page) - 1);
+	unsigned int f, from = offset_in_thp(page, pos);
 	unsigned int t, to = from + copied;
 	loff_t i_size, maybe_i_size;
 


