Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB7F11E8ACC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 May 2020 00:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728693AbgE2WCj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 May 2020 18:02:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59307 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728710AbgE2WCh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 May 2020 18:02:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590789756;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Fuuv3sz/GSmrMmZb6ByPJWoMyMT1uK7FLllTftkdgck=;
        b=e+5WSqfiMYiyFav5l5DqoSJ2U2Oe4abgRzoX8Yz3uBOxiSkfUz02rb6Ynr84ZJYy9m1Fg5
        uCXVeKclrYu6eW4zMJixLdBOlBWI5a59PtwP11g5SgS5Qjm67cKlXjuV5SNtnmybjsveeM
        A/gxUhv+vCKoII0bQ89kB7WFdVjLYBc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-402-wwG90mg_OYy0l5mMoSxtJQ-1; Fri, 29 May 2020 18:02:32 -0400
X-MC-Unique: wwG90mg_OYy0l5mMoSxtJQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1259F18A8228;
        Fri, 29 May 2020 22:02:31 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-138.rdu2.redhat.com [10.10.112.138])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 42E26100164C;
        Fri, 29 May 2020 22:02:30 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 20/27] afs: Detect cell aliases 3 - YFS Cells with a canonical
 cell name op
From:   David Howells <dhowells@redhat.com>
To:     linux-afs@lists.infradead.org
Cc:     dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 29 May 2020 23:02:29 +0100
Message-ID: <159078974944.679399.18369764508535302163.stgit@warthog.procyon.org.uk>
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

YFS Volume Location servers have an operation by which the cell name may be
queried.  Use this to find out what a YFS server thinks the canonical cell
name should be.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/vl_alias.c  |   60 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/afs/vl_rotate.c |    4 +++
 2 files changed, 64 insertions(+)

diff --git a/fs/afs/vl_alias.c b/fs/afs/vl_alias.c
index 76bfa4dde4a4..1fcb63c65ba9 100644
--- a/fs/afs/vl_alias.c
+++ b/fs/afs/vl_alias.c
@@ -268,12 +268,72 @@ static int afs_query_for_alias(struct afs_cell *cell, struct key *key)
 	return 1;
 }
 
+/*
+ * Look up a VLDB record for a volume.
+ */
+static char *afs_vl_get_cell_name(struct afs_cell *cell, struct key *key)
+{
+	struct afs_vl_cursor vc;
+	char *cell_name = ERR_PTR(-EDESTADDRREQ);
+	bool skipped = false, not_skipped = false;
+	int ret;
+
+	if (!afs_begin_vlserver_operation(&vc, cell, key))
+		return ERR_PTR(-ERESTARTSYS);
+
+	while (afs_select_vlserver(&vc)) {
+		if (!test_bit(AFS_VLSERVER_FL_IS_YFS, &vc.server->flags)) {
+			vc.ac.error = -EOPNOTSUPP;
+			skipped = true;
+			continue;
+		}
+		not_skipped = true;
+		cell_name = afs_yfsvl_get_cell_name(&vc);
+	}
+
+	ret = afs_end_vlserver_operation(&vc);
+	if (skipped && !not_skipped)
+		ret = -EOPNOTSUPP;
+	return ret < 0 ? ERR_PTR(ret) : cell_name;
+}
+
+static int yfs_check_canonical_cell_name(struct afs_cell *cell, struct key *key)
+{
+	struct afs_cell *master;
+	char *cell_name;
+
+	cell_name = afs_vl_get_cell_name(cell, key);
+	if (IS_ERR(cell_name))
+		return PTR_ERR(cell_name);
+
+	if (strcmp(cell_name, cell->name) == 0) {
+		kfree(cell_name);
+		return 0;
+	}
+
+	master = afs_lookup_cell(cell->net, cell_name, strlen(cell_name),
+				 NULL, false);
+	kfree(cell_name);
+	if (IS_ERR(master)) {
+		kfree(cell_name);
+		return PTR_ERR(master);
+	}
+
+	cell->alias_of = master; /* Transfer our ref */
+	return 1;
+}
+
 static int afs_do_cell_detect_alias(struct afs_cell *cell, struct key *key)
 {
 	struct afs_volume *root_volume;
+	int ret;
 
 	_enter("%s", cell->name);
 
+	ret = yfs_check_canonical_cell_name(cell, key);
+	if (ret != -EOPNOTSUPP)
+		return ret;
+
 	/* Try and get the root.cell volume for comparison with other cells */
 	root_volume = afs_sample_volume(cell, key, "root.cell", 9);
 	if (!IS_ERR(root_volume)) {
diff --git a/fs/afs/vl_rotate.c b/fs/afs/vl_rotate.c
index 72eacc14e6e1..f405ca8b240a 100644
--- a/fs/afs/vl_rotate.c
+++ b/fs/afs/vl_rotate.c
@@ -151,6 +151,10 @@ bool afs_select_vlserver(struct afs_vl_cursor *vc)
 		vc->error = error;
 		vc->flags |= AFS_VL_CURSOR_RETRY;
 		goto next_server;
+
+	case -EOPNOTSUPP:
+		_debug("notsupp");
+		goto next_server;
 	}
 
 restart_from_beginning:


