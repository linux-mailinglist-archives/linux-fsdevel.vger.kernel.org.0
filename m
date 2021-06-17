Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C08A3AAEB0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jun 2021 10:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbhFQI02 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Jun 2021 04:26:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40186 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230422AbhFQI0Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Jun 2021 04:26:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623918254;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P9o+Zrd4Z7cHld0VaXSFCfPfXhtnOSSf79Uln+Xnubk=;
        b=VvIqerR61WhyKp8y8rzdAhWWanGL/PL92vZDsROKJA1PYHbmZjjf6fwhmSiiNTHuHFpOR6
        BL0+dULc2Me9S1TnaOLlYvkDyQOW5NzKjF9C4ofwG3QzFym5Z+V+Zj/EWXM5lJrJ/msLS/
        2XSRP+JAs3g+9W5zeR7KFOkt6S2gSy8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-437-wCRWtc8vMCCAwYhG6iq0EA-1; Thu, 17 Jun 2021 04:24:12 -0400
X-MC-Unique: wCRWtc8vMCCAwYhG6iq0EA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A1681100C618;
        Thu, 17 Jun 2021 08:24:11 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-118-65.rdu2.redhat.com [10.10.118.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BF36A5D9CC;
        Thu, 17 Jun 2021 08:24:03 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v2 1/3] afs: Handle len being extending over page end in
 write_begin/write_end
From:   David Howells <dhowells@redhat.com>
To:     linux-cachefs@redhat.com, linux-afs@lists.infradead.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>, dhowells@redhat.com,
        Jeff Layton <jlayton@kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 17 Jun 2021 09:24:02 +0100
Message-ID: <162391824293.1173366.15452474691364794223.stgit@warthog.procyon.org.uk>
In-Reply-To: <162391823192.1173366.9740514875196345746.stgit@warthog.procyon.org.uk>
References: <162391823192.1173366.9740514875196345746.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

With transparent huge pages, in the future, write_begin() and write_end()
may be passed a length parameter that, in combination with the offset into
the page, exceeds the length of that page.  This allows
grab_cache_page_write_begin() to better choose the size of THP to allocate.

Fix afs's functions to handle this by trimming the length as needed after
the page has been allocated.

[Removed the now-unnecessary index var; spotted by kernel test robot]

Fixes: e1b1240c1ff5 ("netfs: Add write_begin helper")
Reported-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: David Howells <dhowells@redhat.com>
Acked-by: Jeff Layton <jlayton@kernel.org>
cc: linux-afs@lists.infradead.org
Link: https://lore.kernel.org/r/162367681795.460125.11729955608839747375.stgit@warthog.procyon.org.uk/ # v1
---

 fs/afs/write.c |   13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/fs/afs/write.c b/fs/afs/write.c
index a523bb86915d..56e2cff2cb87 100644
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
@@ -36,7 +37,6 @@ int afs_write_begin(struct file *file, struct address_space *mapping,
 	unsigned long priv;
 	unsigned f, from;
 	unsigned t, to;
-	pgoff_t index;
 	int ret;
 
 	_enter("{%llx:%llu},%llx,%x",
@@ -51,8 +51,8 @@ int afs_write_begin(struct file *file, struct address_space *mapping,
 	if (ret < 0)
 		return ret;
 
-	index = page->index;
-	from = pos - index * PAGE_SIZE;
+	from = offset_in_thp(page, pos);
+	len = min_t(size_t, len, thp_size(page) - from);
 	to = from + len;
 
 try_again:
@@ -103,7 +103,8 @@ int afs_write_begin(struct file *file, struct address_space *mapping,
 }
 
 /*
- * finalise part of a write to a page
+ * Finalise part of a write to a page.  Note that len may extend beyond the end
+ * of the page.
  */
 int afs_write_end(struct file *file, struct address_space *mapping,
 		  loff_t pos, unsigned len, unsigned copied,
@@ -111,7 +112,7 @@ int afs_write_end(struct file *file, struct address_space *mapping,
 {
 	struct afs_vnode *vnode = AFS_FS_I(file_inode(file));
 	unsigned long priv;
-	unsigned int f, from = pos & (thp_size(page) - 1);
+	unsigned int f, from = offset_in_thp(page, pos);
 	unsigned int t, to = from + copied;
 	loff_t i_size, maybe_i_size;
 


