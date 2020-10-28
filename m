Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0A0329D627
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Oct 2020 23:12:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730784AbgJ1WMK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Oct 2020 18:12:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46280 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730748AbgJ1WMJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:12:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603923127;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u97YpgkYwOflA5DyVOMrwMI90QOOsJn8Gu3ZLDUNc0g=;
        b=KYu2GvjWLX77n3tucX8QjGCm9d9pYlJuay6xXwwATenGbTT43jrNdVTrlA/znHTlih5V0h
        bU8+9RsusnA/wG8CgzWvaniOSRR5j4975UqrMCDj8kkh3LWK9tSVm/KyOfdm9Vk1H1PuHC
        lkH5wAH0djb1x+IdY7mR9ThArv3i2LE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-9-tTjdaj_wOOK5S2v_nX2EMw-1; Wed, 28 Oct 2020 10:10:20 -0400
X-MC-Unique: tTjdaj_wOOK5S2v_nX2EMw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AEB8F6D589;
        Wed, 28 Oct 2020 14:10:19 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-70.rdu2.redhat.com [10.10.120.70])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ED23B6EF54;
        Wed, 28 Oct 2020 14:10:18 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 04/11] afs: Fix afs_launder_page to not clear PG_writeback
From:   David Howells <dhowells@redhat.com>
To:     linux-afs@lists.infradead.org
Cc:     dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 28 Oct 2020 14:10:18 +0000
Message-ID: <160389421818.300137.4578809393170315066.stgit@warthog.procyon.org.uk>
In-Reply-To: <160389418807.300137.8222864749005731859.stgit@warthog.procyon.org.uk>
References: <160389418807.300137.8222864749005731859.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix afs_launder_page() to not clear PG_writeback on the page it is
laundering as the flag isn't set in this case.

Fixes: 4343d00872e1 ("afs: Get rid of the afs_writeback record")
Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/internal.h |    1 +
 fs/afs/write.c    |   10 ++++++----
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 81b0485fd22a..289f5dffa46f 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -812,6 +812,7 @@ struct afs_operation {
 			pgoff_t		last;		/* last page in mapping to deal with */
 			unsigned	first_offset;	/* offset into mapping[first] */
 			unsigned	last_to;	/* amount of mapping[last] */
+			bool		laundering;	/* Laundering page, PG_writeback not set */
 		} store;
 		struct {
 			struct iattr	*attr;
diff --git a/fs/afs/write.c b/fs/afs/write.c
index da12abd6db21..b937ec047ec9 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -396,7 +396,8 @@ static void afs_store_data_success(struct afs_operation *op)
 	op->ctime = op->file[0].scb.status.mtime_client;
 	afs_vnode_commit_status(op, &op->file[0]);
 	if (op->error == 0) {
-		afs_pages_written_back(vnode, op->store.first, op->store.last);
+		if (!op->store.laundering)
+			afs_pages_written_back(vnode, op->store.first, op->store.last);
 		afs_stat_v(vnode, n_stores);
 		atomic_long_add((op->store.last * PAGE_SIZE + op->store.last_to) -
 				(op->store.first * PAGE_SIZE + op->store.first_offset),
@@ -415,7 +416,7 @@ static const struct afs_operation_ops afs_store_data_operation = {
  */
 static int afs_store_data(struct address_space *mapping,
 			  pgoff_t first, pgoff_t last,
-			  unsigned offset, unsigned to)
+			  unsigned offset, unsigned to, bool laundering)
 {
 	struct afs_vnode *vnode = AFS_FS_I(mapping->host);
 	struct afs_operation *op;
@@ -448,6 +449,7 @@ static int afs_store_data(struct address_space *mapping,
 	op->store.last = last;
 	op->store.first_offset = offset;
 	op->store.last_to = to;
+	op->store.laundering = laundering;
 	op->mtime = vnode->vfs_inode.i_mtime;
 	op->flags |= AFS_OPERATION_UNINTR;
 	op->ops = &afs_store_data_operation;
@@ -601,7 +603,7 @@ static int afs_write_back_from_locked_page(struct address_space *mapping,
 	if (end > i_size)
 		to = i_size & ~PAGE_MASK;
 
-	ret = afs_store_data(mapping, first, last, offset, to);
+	ret = afs_store_data(mapping, first, last, offset, to, false);
 	switch (ret) {
 	case 0:
 		ret = count;
@@ -921,7 +923,7 @@ int afs_launder_page(struct page *page)
 
 		trace_afs_page_dirty(vnode, tracepoint_string("launder"),
 				     page->index, priv);
-		ret = afs_store_data(mapping, page->index, page->index, t, f);
+		ret = afs_store_data(mapping, page->index, page->index, t, f, true);
 	}
 
 	trace_afs_page_dirty(vnode, tracepoint_string("laundered"),


