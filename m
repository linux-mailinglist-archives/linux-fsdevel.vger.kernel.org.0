Return-Path: <linux-fsdevel+bounces-43576-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48946A58FF3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 10:43:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC7AD188EC58
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 09:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FC8922617F;
	Mon, 10 Mar 2025 09:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZlCqvYLf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725C2225A36
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Mar 2025 09:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741599752; cv=none; b=ea0GQlYhQMOLXP5VfYE23ZKg+zdUnPdXf5g3oXWdcZb/M6odIcV1eHul1Au5QLBuBwtdyFrZy0n1teolszACGh3zYXbIXyCzSJ3jS6q5XsPysMyfJo+DgLaQF151tlefhULX4LDsApV+d3YWSyuRutB1ajkCjTkVBo5F2g6ChEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741599752; c=relaxed/simple;
	bh=6vtwEs+rHM1jWLym/vaXSW2BCT8cpdWZuotX4+2I2Vc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CzOyPC8mxCD1jRk7GPVRh8GNMeuac0g3scnI7YZe4oGSCBWBPC2Wu1BqkYoOsIGnRPSNjtFSygRkLJY1UWuYQPt0R6dvTRkVLdoIcZ8qmj9xYJkEOfSIPhh4pLoMOiArv3DhCw7yYQh4q3Px5/CQh3V8kUAwIty4k06i7tHsq+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZlCqvYLf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741599749;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cRYHIcDjLcg4Vn95ha4RWQZUMP+5IMAoLBX9IqR4Ab4=;
	b=ZlCqvYLf5yHU8RAqeIKXoe8sI1rmd5m90ULsvXXeZ4zVakIqDyPxP5LYs9Ud9RT1fTnSXJ
	Lk9Dl4rWvdvOZDNuWbbBv1n/Hoy6SRuHeHl+kaodfq/WHqRE7vwRHmiBSL1rjwptuUBxPW
	IoFrr246SqYPpFkzQYNNZHj/dHH1mVg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-295-eS1fX2frNM2QQtn-R6jD8Q-1; Mon,
 10 Mar 2025 05:42:24 -0400
X-MC-Unique: eS1fX2frNM2QQtn-R6jD8Q-1
X-Mimecast-MFC-AGG-ID: eS1fX2frNM2QQtn-R6jD8Q_1741599743
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1987E19560B2;
	Mon, 10 Mar 2025 09:42:22 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.61])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 633A91800944;
	Mon, 10 Mar 2025 09:42:19 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Marc Dionne <marc.dionne@auristor.com>
Cc: David Howells <dhowells@redhat.com>,
	Christian Brauner <christian@brauner.io>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH v4 01/11] afs: Fix afs_atcell_get_link() to handle RCU pathwalk
Date: Mon, 10 Mar 2025 09:41:54 +0000
Message-ID: <20250310094206.801057-2-dhowells@redhat.com>
In-Reply-To: <20250310094206.801057-1-dhowells@redhat.com>
References: <20250310094206.801057-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

The ->get_link() method may be entered under RCU pathwalk conditions (in
which case, the dentry pointer is NULL).  This is not taken account of by
afs_atcell_get_link() and lockdep will complain when it tries to lock an
rwsem.

Fix this by marking net->ws_cell as __rcu and using RCU access macros on it
and by making afs_atcell_get_link() just return a pointer to the name in
RCU pathwalk without taking net->cells_lock or a ref on the cell as RCU
will protect the name storage (the cell is already freed via call_rcu()).

Fixes: 30bca65bbbae ("afs: Make /afs/@cell and /afs/.@cell symlinks")
Reported-by: Alexander Viro <viro@zeniv.linux.org.uk>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
cc: linux-fsdevel@vger.kernel.org
---
 fs/afs/cell.c     | 11 ++++++-----
 fs/afs/dynroot.c  | 15 +++++++++++++--
 fs/afs/internal.h |  2 +-
 fs/afs/proc.c     |  4 ++--
 4 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/fs/afs/cell.c b/fs/afs/cell.c
index cee42646736c..96a6781f3653 100644
--- a/fs/afs/cell.c
+++ b/fs/afs/cell.c
@@ -64,7 +64,8 @@ static struct afs_cell *afs_find_cell_locked(struct afs_net *net,
 		return ERR_PTR(-ENAMETOOLONG);
 
 	if (!name) {
-		cell = net->ws_cell;
+		cell = rcu_dereference_protected(net->ws_cell,
+						 lockdep_is_held(&net->cells_lock));
 		if (!cell)
 			return ERR_PTR(-EDESTADDRREQ);
 		goto found;
@@ -388,8 +389,8 @@ int afs_cell_init(struct afs_net *net, const char *rootcell)
 	/* install the new cell */
 	down_write(&net->cells_lock);
 	afs_see_cell(new_root, afs_cell_trace_see_ws);
-	old_root = net->ws_cell;
-	net->ws_cell = new_root;
+	old_root = rcu_replace_pointer(net->ws_cell, new_root,
+				       lockdep_is_held(&net->cells_lock));
 	up_write(&net->cells_lock);
 
 	afs_unuse_cell(net, old_root, afs_cell_trace_unuse_ws);
@@ -945,8 +946,8 @@ void afs_cell_purge(struct afs_net *net)
 	_enter("");
 
 	down_write(&net->cells_lock);
-	ws = net->ws_cell;
-	net->ws_cell = NULL;
+	ws = rcu_replace_pointer(net->ws_cell, NULL,
+				 lockdep_is_held(&net->cells_lock));
 	up_write(&net->cells_lock);
 	afs_unuse_cell(net, ws, afs_cell_trace_unuse_ws);
 
diff --git a/fs/afs/dynroot.c b/fs/afs/dynroot.c
index d8bf52f77d93..008698d706ca 100644
--- a/fs/afs/dynroot.c
+++ b/fs/afs/dynroot.c
@@ -314,12 +314,23 @@ static const char *afs_atcell_get_link(struct dentry *dentry, struct inode *inod
 	const char *name;
 	bool dotted = vnode->fid.vnode == 3;
 
-	if (!net->ws_cell)
+	if (!dentry) {
+		/* We're in RCU-pathwalk. */
+		cell = rcu_dereference(net->ws_cell);
+		if (dotted)
+			name = cell->name - 1;
+		else
+			name = cell->name;
+		/* Shouldn't need to set a delayed call. */
+		return name;
+	}
+
+	if (!rcu_access_pointer(net->ws_cell))
 		return ERR_PTR(-ENOENT);
 
 	down_read(&net->cells_lock);
 
-	cell = net->ws_cell;
+	cell = rcu_dereference_protected(net->ws_cell, lockdep_is_held(&net->cells_lock));
 	if (dotted)
 		name = cell->name - 1;
 	else
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 90f407774a9a..df30bd62da79 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -287,7 +287,7 @@ struct afs_net {
 
 	/* Cell database */
 	struct rb_root		cells;
-	struct afs_cell		*ws_cell;
+	struct afs_cell __rcu	*ws_cell;
 	struct work_struct	cells_manager;
 	struct timer_list	cells_timer;
 	atomic_t		cells_outstanding;
diff --git a/fs/afs/proc.c b/fs/afs/proc.c
index e7614f4f30c2..12c88d8be3fe 100644
--- a/fs/afs/proc.c
+++ b/fs/afs/proc.c
@@ -206,7 +206,7 @@ static int afs_proc_rootcell_show(struct seq_file *m, void *v)
 
 	net = afs_seq2net_single(m);
 	down_read(&net->cells_lock);
-	cell = net->ws_cell;
+	cell = rcu_dereference_protected(net->ws_cell, lockdep_is_held(&net->cells_lock));
 	if (cell)
 		seq_printf(m, "%s\n", cell->name);
 	up_read(&net->cells_lock);
@@ -242,7 +242,7 @@ static int afs_proc_rootcell_write(struct file *file, char *buf, size_t size)
 
 	ret = -EEXIST;
 	inode_lock(file_inode(file));
-	if (!net->ws_cell)
+	if (!rcu_access_pointer(net->ws_cell))
 		ret = afs_cell_init(net, buf);
 	else
 		printk("busy\n");


