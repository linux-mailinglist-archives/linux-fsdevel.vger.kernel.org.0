Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93F7B3AAEB4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jun 2021 10:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbhFQI0d (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Jun 2021 04:26:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:51692 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230452AbhFQI0c (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Jun 2021 04:26:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623918264;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=25oOoaWA7xjsIPrv9I6eD651KSb4K0TAEO1kqb19kmw=;
        b=jFGRTjYe5m9dzoQpL4YJNGxno6S+/TsIGxWGVuk+tLqlZNDS7RF3u0jw+uauxKdEq5sMWH
        gJp4CvmjnE8+w6AbzHyTf2lNOLfWEozJp6Hpi/fvU/B6Rbrz+xzNbzoTNnDfpHbSNoO59R
        ZbTR1isnmQbepXaqrHI4FK5t8Gef+RA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-204-hOUGTWFhOBWyj58VU9D-sw-1; Thu, 17 Jun 2021 04:24:23 -0400
X-MC-Unique: hOUGTWFhOBWyj58VU9D-sw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 550FF1084F5B;
        Thu, 17 Jun 2021 08:24:22 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-118-65.rdu2.redhat.com [10.10.118.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B275C60937;
        Thu, 17 Jun 2021 08:24:17 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v2 2/3] afs: Fix afs_write_end() to handle short writes
From:   David Howells <dhowells@redhat.com>
To:     linux-cachefs@redhat.com, linux-afs@lists.infradead.org
Cc:     Jeff Layton <jlayton@kernel.org>, Jeff Layton <jlayton@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>, dhowells@redhat.com,
        Jeff Layton <jlayton@kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 17 Jun 2021 09:24:16 +0100
Message-ID: <162391825688.1173366.3437507255136307904.stgit@warthog.procyon.org.uk>
In-Reply-To: <162391823192.1173366.9740514875196345746.stgit@warthog.procyon.org.uk>
References: <162391823192.1173366.9740514875196345746.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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
     up by netfs_write_begin() (this will be fixed in the next patch), so
     we need to set uptodate here in such a case.

Also remove the assertion that was checking that the page was set uptodate
since it's now set uptodate if it wasn't already a few lines above.  The
assertion was from when uptodate was set elsewhere.

Fixes: 3003bbd0697b ("afs: Use the netfs_write_begin() helper")
Reported-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: David Howells <dhowells@redhat.com>
Acked-by: Jeff Layton <jlayton@kernel.org>
cc: Al Viro <viro@zeniv.linux.org.uk>
cc: Matthew Wilcox <willy@infradead.org>
cc: linux-afs@lists.infradead.org
Link: https://lore.kernel.org/r/162367682522.460125.5652091227576721609.stgit@warthog.procyon.org.uk/ # v1
---

 fs/afs/write.c |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/fs/afs/write.c b/fs/afs/write.c
index 56e2cff2cb87..8a4053ae03dd 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -119,6 +119,16 @@ int afs_write_end(struct file *file, struct address_space *mapping,
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
 
@@ -133,8 +143,6 @@ int afs_write_end(struct file *file, struct address_space *mapping,
 		write_sequnlock(&vnode->cb_lock);
 	}
 
-	ASSERT(PageUptodate(page));
-
 	if (PagePrivate(page)) {
 		priv = page_private(page);
 		f = afs_page_dirty_from(page, priv);


