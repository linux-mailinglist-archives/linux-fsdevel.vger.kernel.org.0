Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2F573A67AA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jun 2021 15:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233924AbhFNNXD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Jun 2021 09:23:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34696 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233922AbhFNNWs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Jun 2021 09:22:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623676845;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hHKlTZYrE3qayq9WgDP8elW69NUaJIZRckah9/2ZzdE=;
        b=L5VtUG8ZfbuTSQT9n4vTAcDwm0E+6NJm5lx+Lw4punCXvh+3YBhL4ydEEc4Pj2UmY6cLkf
        a6wyzD3g0214ZKBzhwLZp/aOZjxPzltaeA63JjYZcz0GZ1GCfS9BxfTF/COx66x6P2Q2zE
        bglq98JapPXESDmMVCU68JLfr3G3bJ8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-540-5ZrqStiTM_WeGQlQadA7jQ-1; Mon, 14 Jun 2021 09:20:35 -0400
X-MC-Unique: 5ZrqStiTM_WeGQlQadA7jQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 690AD100CFC6;
        Mon, 14 Jun 2021 13:20:28 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-118-65.rdu2.redhat.com [10.10.118.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 05DEA5C238;
        Mon, 14 Jun 2021 13:20:25 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 2/3] afs: Fix afs_write_end() to handle short writes
From:   David Howells <dhowells@redhat.com>
To:     jlayton@kernel.org, willy@infradead.org
Cc:     linux-afs@lists.infradead.org, dhowells@redhat.com,
        linux-afs@lists.infradead.org, ceph-devel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 14 Jun 2021 14:20:25 +0100
Message-ID: <162367682522.460125.5652091227576721609.stgit@warthog.procyon.org.uk>
In-Reply-To: <162367681795.460125.11729955608839747375.stgit@warthog.procyon.org.uk>
References: <162367681795.460125.11729955608839747375.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix afs_write_end() to correctly handle a short copy into the intended
write region of the page.  Two things are necessary:

 (1) If the page is not up to date, then we should just return 0
     (ie. indicating a zero-length copy).  The loop in
     generic_perform_write() will go around again, possibly breaking up the
     iterator into discrete chunks.

     This is analogous to commit b9de313cf05fe08fa59efaf19756ec5283af672a
     for ceph.

 (2) The page should not have been set uptodate if it wasn't completely set
     up by netfs_write_begin() (this will be fixed in the next page), so we
     need to set PG_uptodate here in such a case.

Fixes: 3003bbd0697b ("afs: Use the netfs_write_begin() helper")
Reported-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-afs@lists.infradead.org
---

 fs/afs/write.c |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/fs/afs/write.c b/fs/afs/write.c
index f68274c39f47..4b3f16ca2810 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -121,6 +121,16 @@ int afs_write_end(struct file *file, struct address_space *mapping,
 	_enter("{%llx:%llu},{%lx}",
 	       vnode->fid.vid, vnode->fid.vnode, page->index);
 
+	len = min_t(size_t, len, thp_size(page) - from);
+	if (!PageUptodate(page)) {
+		if (copied < len) {
+			copied = 0;
+			goto out;
+		}
+
+		SetPageUptodate(page);
+	}
+
 	if (copied == 0)
 		goto out;
 
@@ -135,8 +145,6 @@ int afs_write_end(struct file *file, struct address_space *mapping,
 		write_sequnlock(&vnode->cb_lock);
 	}
 
-	ASSERT(PageUptodate(page));
-
 	if (PagePrivate(page)) {
 		priv = page_private(page);
 		f = afs_page_dirty_from(page, priv);


