Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD711E8AC6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 May 2020 00:02:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728694AbgE2WCa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 May 2020 18:02:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37987 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728693AbgE2WC2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 May 2020 18:02:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590789747;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S6iq26DTUp2Z1AJJIG5b7C5kCeJcVWYfJVluYMMNUBA=;
        b=ZPVxjEnZYUcFloNozcZYua3uSyzPDPGlk1P6qSZRAV0HGbS9hKG07qqQzxhCWJjQdX73ZO
        7aog6IiwWUYUQ3HdNnFfYH1jWB7ARGnNCuOL2SzGaHFAI23cQrUiOE1ZK31NOez0lkGSgc
        aJ4hpw+j5YsBfVKLny1c/UZISkOsfUo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-34-DYmdLWXcNgSk9QadL8mm5A-1; Fri, 29 May 2020 18:02:25 -0400
X-MC-Unique: DYmdLWXcNgSk9QadL8mm5A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 352E780B712;
        Fri, 29 May 2020 22:02:24 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-138.rdu2.redhat.com [10.10.112.138])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 31E4510013D4;
        Fri, 29 May 2020 22:02:23 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 19/27] afs: Detect cell aliases 2 - Cells with no root volumes
From:   David Howells <dhowells@redhat.com>
To:     linux-afs@lists.infradead.org
Cc:     dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 29 May 2020 23:02:22 +0100
Message-ID: <159078974233.679399.3000438365720326961.stgit@warthog.procyon.org.uk>
In-Reply-To: <159078959973.679399.15496997680826127470.stgit@warthog.procyon.org.uk>
References: <159078959973.679399.15496997680826127470.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.22
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Implement the second phase of cell alias detection.  This part handles
alias detection for cells that don't have root.cell volumes and so we have
to find some other volume or fileserver to query.

We take the first volume from each such cell and attempt to look it up in
the new cell.  If found, we compare the records, if they are the same, we
judge the cell names to be aliases.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/vl_alias.c |   90 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 89 insertions(+), 1 deletion(-)

diff --git a/fs/afs/vl_alias.c b/fs/afs/vl_alias.c
index d1d91a25fbe0..76bfa4dde4a4 100644
--- a/fs/afs/vl_alias.c
+++ b/fs/afs/vl_alias.c
@@ -180,6 +180,94 @@ static int afs_compare_cell_roots(struct afs_cell *cell)
 	return 1;
 }
 
+/*
+ * Query the new cell for a volume from a cell we're already using.
+ */
+static int afs_query_for_alias_one(struct afs_cell *cell, struct key *key,
+				   struct afs_cell *p)
+{
+	struct afs_volume *volume, *pvol = NULL;
+	int ret;
+
+	/* Arbitrarily pick the first volume in the list. */
+	read_lock(&p->proc_lock);
+	if (!list_empty(&p->proc_volumes))
+		pvol = afs_get_volume(list_first_entry(&p->proc_volumes,
+						       struct afs_volume, proc_link));
+	read_unlock(&p->proc_lock);
+	if (!pvol)
+		return 0;
+
+	_enter("%s:%s", cell->name, pvol->name);
+
+	/* And see if it's in the new cell. */
+	volume = afs_sample_volume(cell, key, pvol->name, pvol->name_len);
+	if (IS_ERR(volume)) {
+		afs_put_volume(cell->net, pvol);
+		if (PTR_ERR(volume) != -ENOMEDIUM)
+			return PTR_ERR(volume);
+		/* That volume is not in the new cell, so not an alias */
+		return 0;
+	}
+
+	/* The new cell has a like-named volume also - compare volume ID,
+	 * server and address lists.
+	 */
+	ret = 0;
+	if (pvol->vid == volume->vid) {
+		rcu_read_lock();
+		if (afs_compare_volume_slists(volume, pvol))
+			ret = 1;
+		rcu_read_unlock();
+	}
+
+	afs_put_volume(cell->net, volume);
+	afs_put_volume(cell->net, pvol);
+	return ret;
+}
+
+/*
+ * Query the new cell for volumes we know exist in cells we're already using.
+ */
+static int afs_query_for_alias(struct afs_cell *cell, struct key *key)
+{
+	struct afs_cell *p;
+
+	_enter("%s", cell->name);
+
+	if (mutex_lock_interruptible(&cell->net->proc_cells_lock) < 0)
+		return -ERESTARTSYS;
+
+	hlist_for_each_entry(p, &cell->net->proc_cells, proc_link) {
+		if (p == cell || p->alias_of)
+			continue;
+		if (list_empty(&p->proc_volumes))
+			continue;
+		if (p->root_volume)
+			continue; /* Ignore cells that have a root.cell volume. */
+		afs_get_cell(p);
+		mutex_unlock(&cell->net->proc_cells_lock);
+
+		if (afs_query_for_alias_one(cell, key, p) != 0)
+			goto is_alias;
+
+		if (mutex_lock_interruptible(&cell->net->proc_cells_lock) < 0) {
+			afs_put_cell(cell->net, p);
+			return -ERESTARTSYS;
+		}
+
+		afs_put_cell(cell->net, p);
+	}
+
+	mutex_unlock(&cell->net->proc_cells_lock);
+	_leave(" = 0");
+	return 0;
+
+is_alias:
+	cell->alias_of = p; /* Transfer our ref */
+	return 1;
+}
+
 static int afs_do_cell_detect_alias(struct afs_cell *cell, struct key *key)
 {
 	struct afs_volume *root_volume;
@@ -199,7 +287,7 @@ static int afs_do_cell_detect_alias(struct afs_cell *cell, struct key *key)
 	/* Okay, this cell doesn't have an root.cell volume.  We need to
 	 * locate some other random volume and use that to check.
 	 */
-	return -ENOMEDIUM;
+	return afs_query_for_alias(cell, key);
 }
 
 /*


