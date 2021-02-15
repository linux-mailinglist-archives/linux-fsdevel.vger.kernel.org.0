Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9DA331BDBC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Feb 2021 16:56:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbhBOPxw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Feb 2021 10:53:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28421 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231424AbhBOPu2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Feb 2021 10:50:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613404141;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+Ma1jifx8c9sln++i63HLx2QkPzzZKsDVw7/yoiDNY0=;
        b=HkaFAmiil/ZS3lUs0Spb7yjiWYfu//9m4hYw6djGeQiAogQG0ie6yDMU0zyIKfq0JCmSDL
        f2ov7RDlLfCMdo88FyGboejBE5zSNo611KOy9idk9J2iLTM3URJ9tlA898BywXLxeZEYdf
        F1hDkAW6l8jRuhteUJZZpJhigTixRP0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-269-y1a_94veNferUpBG-rne-Q-1; Mon, 15 Feb 2021 10:48:57 -0500
X-MC-Unique: y1a_94veNferUpBG-rne-Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C45D7100A690;
        Mon, 15 Feb 2021 15:48:55 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-119-68.rdu2.redhat.com [10.10.119.68])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E7E1E5B697;
        Mon, 15 Feb 2021 15:48:49 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 23/33] afs: Wait on PG_fscache before modifying/releasing a
 page
From:   David Howells <dhowells@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>
Cc:     linux-afs@lists.infradead.org, linux-cachefs@redhat.com,
        linux-fsdevel@vger.kernel.org, dhowells@redhat.com,
        Jeff Layton <jlayton@redhat.com>,
        David Wysochanski <dwysocha@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 15 Feb 2021 15:48:49 +0000
Message-ID: <161340412903.1303470.6424701655031380012.stgit@warthog.procyon.org.uk>
In-Reply-To: <161340385320.1303470.2392622971006879777.stgit@warthog.procyon.org.uk>
References: <161340385320.1303470.2392622971006879777.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

PG_fscache is going to be used to indicate that a page is being written to
the cache, and that the page should not be modified or released until it's
finished.

Make afs_invalidatepage() and afs_releasepage() wait for it.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-afs@lists.infradead.org
cc: linux-cachefs@redhat.com
cc: linux-fsdevel@vger.kernel.org
---

 fs/afs/file.c  |    9 +++++++++
 fs/afs/write.c |   10 ++++++++++
 2 files changed, 19 insertions(+)

diff --git a/fs/afs/file.c b/fs/afs/file.c
index f1bab69e99d4..acbc21a8c80e 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -594,6 +594,7 @@ static void afs_invalidatepage(struct page *page, unsigned int offset,
 	if (PagePrivate(page))
 		afs_invalidate_dirty(page, offset, length);
 
+	wait_on_page_fscache(page);
 	_leave("");
 }
 
@@ -611,6 +612,14 @@ static int afs_releasepage(struct page *page, gfp_t gfp_flags)
 
 	/* deny if page is being written to the cache and the caller hasn't
 	 * elected to wait */
+#ifdef CONFIG_AFS_FSCACHE
+	if (PageFsCache(page)) {
+		if (!(gfp_flags & __GFP_DIRECT_RECLAIM) || !(gfp_flags & __GFP_FS))
+			return false;
+		wait_on_page_fscache(page);
+	}
+#endif
+
 	if (PagePrivate(page)) {
 		detach_page_private(page);
 		trace_afs_page_dirty(vnode, tracepoint_string("rel"), page);
diff --git a/fs/afs/write.c b/fs/afs/write.c
index dd4dc1c868b5..e1791de90478 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -117,6 +117,10 @@ int afs_write_begin(struct file *file, struct address_space *mapping,
 		SetPageUptodate(page);
 	}
 
+#ifdef CONFIG_AFS_FSCACHE
+	wait_on_page_fscache(page);
+#endif
+
 try_again:
 	/* See if this page is already partially written in a way that we can
 	 * merge the new write with.
@@ -857,6 +861,11 @@ vm_fault_t afs_page_mkwrite(struct vm_fault *vmf)
 	/* Wait for the page to be written to the cache before we allow it to
 	 * be modified.  We then assume the entire page will need writing back.
 	 */
+#ifdef CONFIG_AFS_FSCACHE
+	if (PageFsCache(vmf->page) &&
+	    wait_on_page_bit_killable(vmf->page, PG_fscache) < 0)
+		return VM_FAULT_RETRY;
+#endif
 
 	if (PageWriteback(vmf->page) &&
 	    wait_on_page_bit_killable(vmf->page, PG_writeback) < 0)
@@ -948,5 +957,6 @@ int afs_launder_page(struct page *page)
 
 	detach_page_private(page);
 	trace_afs_page_dirty(vnode, tracepoint_string("laundered"), page);
+	wait_on_page_fscache(page);
 	return ret;
 }


