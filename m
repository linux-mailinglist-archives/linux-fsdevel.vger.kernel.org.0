Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ECAE432043
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Oct 2021 16:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232519AbhJROxl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Oct 2021 10:53:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:48064 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232395AbhJROxc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Oct 2021 10:53:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634568678;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2sONkJBvmJgTAHpzc86BA8e42PAvAoDrxKKcAcC4xT4=;
        b=PaSg29MqowhoDp1bJo33ekLQ2mcsFt0Q/ijSVwzJYVJYjYm7LcXOFZyllXlegt4lN6NxsX
        XzZNKqAEGhzxkVGYB1I8S4n98oLvrfaWmdddS7AY3z9l/XUltoERscOtm/9IpLApaA+ZLh
        dxPfowNWam+kf+kaxA1m683IBZN3yr0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-504-BQPyF-z-POWSD8t89bprvw-1; Mon, 18 Oct 2021 10:51:15 -0400
X-MC-Unique: BQPyF-z-POWSD8t89bprvw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C6450100CCC6;
        Mon, 18 Oct 2021 14:51:12 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 27CFF68700;
        Mon, 18 Oct 2021 14:51:06 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 03/67] vfs,
 fscache: Force ->write_inode() to occur if cookie pinned for writeback
From:   David Howells <dhowells@redhat.com>
To:     linux-cachefs@redhat.com
Cc:     dhowells@redhat.com, Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jeff Layton <jlayton@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Omar Sandoval <osandov@osandov.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 18 Oct 2021 15:51:05 +0100
Message-ID: <163456866523.2614702.2234665737111683988.stgit@warthog.procyon.org.uk>
In-Reply-To: <163456861570.2614702.14754548462706508617.stgit@warthog.procyon.org.uk>
References: <163456861570.2614702.14754548462706508617.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use an inode flag, I_PINNING_FSCACHE_WB, to indicate that a cookie is
pinned in use by that inode for the purposes of writeback.

Pinning is necessary because the in-use pin from the open file is released
before the writeback takes place, but if the resources aren't pinned, the
dirty data can't be written to the cache.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/fs-writeback.c         |    8 ++++++++
 include/linux/fs.h        |    3 +++
 include/linux/fscache.h   |    1 +
 include/linux/writeback.h |    1 +
 4 files changed, 13 insertions(+)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 81ec192ce067..f3122831c4fe 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -1666,6 +1666,13 @@ __writeback_single_inode(struct inode *inode, struct writeback_control *wbc)
 
 	if (mapping_tagged(mapping, PAGECACHE_TAG_DIRTY))
 		inode->i_state |= I_DIRTY_PAGES;
+	else if (unlikely(inode->i_state & I_PINNING_FSCACHE_WB)) {
+		if (!(inode->i_state & I_DIRTY_PAGES)) {
+			inode->i_state &= ~I_PINNING_FSCACHE_WB;
+			wbc->unpinned_fscache_wb = true;
+			dirty |= I_PINNING_FSCACHE_WB; /* Cause write_inode */
+		}
+	}
 
 	spin_unlock(&inode->i_lock);
 
@@ -1675,6 +1682,7 @@ __writeback_single_inode(struct inode *inode, struct writeback_control *wbc)
 		if (ret == 0)
 			ret = err;
 	}
+	wbc->unpinned_fscache_wb = false;
 	trace_writeback_single_inode(inode, wbc, nr_to_write);
 	return ret;
 }
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 197493507744..336739fed3e9 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2420,6 +2420,8 @@ static inline void kiocb_clone(struct kiocb *kiocb, struct kiocb *kiocb_src,
  *			Used to detect that mark_inode_dirty() should not move
  * 			inode between dirty lists.
  *
+ * I_PINNING_FSCACHE_WB	Inode is pinning an fscache object for writeback.
+ *
  * Q: What is the difference between I_WILL_FREE and I_FREEING?
  */
 #define I_DIRTY_SYNC		(1 << 0)
@@ -2442,6 +2444,7 @@ static inline void kiocb_clone(struct kiocb *kiocb, struct kiocb *kiocb_src,
 #define I_CREATING		(1 << 15)
 #define I_DONTCACHE		(1 << 16)
 #define I_SYNC_QUEUED		(1 << 17)
+#define I_PINNING_FSCACHE_WB	(1 << 18)
 
 #define I_DIRTY_INODE (I_DIRTY_SYNC | I_DIRTY_DATASYNC)
 #define I_DIRTY (I_DIRTY_INODE | I_DIRTY_PAGES)
diff --git a/include/linux/fscache.h b/include/linux/fscache.h
index 01558d155799..ba4878b56717 100644
--- a/include/linux/fscache.h
+++ b/include/linux/fscache.h
@@ -19,6 +19,7 @@
 #include <linux/pagemap.h>
 #include <linux/pagevec.h>
 #include <linux/list_bl.h>
+#include <linux/writeback.h>
 #include <linux/netfs.h>
 
 #if defined(CONFIG_FSCACHE) || defined(CONFIG_FSCACHE_MODULE)
diff --git a/include/linux/writeback.h b/include/linux/writeback.h
index d1f65adf6a26..2fda288600d3 100644
--- a/include/linux/writeback.h
+++ b/include/linux/writeback.h
@@ -69,6 +69,7 @@ struct writeback_control {
 	unsigned for_reclaim:1;		/* Invoked from the page allocator */
 	unsigned range_cyclic:1;	/* range_start is cyclic */
 	unsigned for_sync:1;		/* sync(2) WB_SYNC_ALL writeback */
+	unsigned unpinned_fscache_wb:1;	/* Cleared I_PINNING_FSCACHE_WB */
 
 	/*
 	 * When writeback IOs are bounced through async layers, only the


