Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ED1D33B22A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Mar 2021 13:09:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbhCOMIe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Mar 2021 08:08:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32399 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230438AbhCOMIE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Mar 2021 08:08:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615810083;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WV8Qo1wCC5wakuqg7LiPHipA4SNifOTUXpzARroenTg=;
        b=DZgT1SusWwr2XKnCfOxIX1sw7L2XdqxYhDRdN/Qi15MIMgWWO0yLLrnNCV9MsQtTWe0HZ6
        rK5qz7MlQ/FCC7bmrJMBrDbdx8dF4t2Cawdn6VkxIXe0S5C1kezI5TTGAXJu276J954VDQ
        wls4u5EVozC4ndzRhH+R3BPo6RvQxu0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-429-KJheqZhaMduAdwSih0IuAA-1; Mon, 15 Mar 2021 08:08:00 -0400
X-MC-Unique: KJheqZhaMduAdwSih0IuAA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A95F2100C660;
        Mon, 15 Mar 2021 12:07:58 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-118-152.rdu2.redhat.com [10.10.118.152])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1E7E919701;
        Mon, 15 Mar 2021 12:07:56 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 2/3] vfs: Use the mounts_to_id array to do /proc/mounts and
 co.
From:   David Howells <dhowells@redhat.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>
Cc:     Matthew Wilcox <willy@infradead.org>, dhowells@redhat.com,
        Matthew Wilcox <willy@infradead.org>,
        Ian Kent <raven@themaw.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 15 Mar 2021 12:07:56 +0000
Message-ID: <161581007628.2850696.11692651942358302102.stgit@warthog.procyon.org.uk>
In-Reply-To: <161581005972.2850696.12854461380574304411.stgit@warthog.procyon.org.uk>
References: <161581005972.2850696.12854461380574304411.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use the mounts_to_id xarray added to the mount namespace to perform
iteration over the mounts in a namespace on behalf of /proc/mounts and
similar.

Since it doesn't trawl a standard list_head, but rather uses xarray, this
could be done under the RCU read lock only.  To do this, we would need to
hide mounts that are in the process of being inserted into the tree by
marking them in the xarray itself or using a mount flag.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Alexander Viro <viro@zeniv.linux.org.uk>
cc: Miklos Szeredi <miklos@szeredi.hu>
cc: Matthew Wilcox <willy@infradead.org>
---

 fs/mount.h          |    2 +-
 fs/namespace.c      |   40 +++++++++++++++++-----------------------
 fs/proc_namespace.c |    3 ---
 3 files changed, 18 insertions(+), 27 deletions(-)

diff --git a/fs/mount.h b/fs/mount.h
index 455f4d293a65..114e7d603995 100644
--- a/fs/mount.h
+++ b/fs/mount.h
@@ -130,7 +130,7 @@ struct proc_mounts {
 	struct mnt_namespace *ns;
 	struct path root;
 	int (*show)(struct seq_file *, struct vfsmount *);
-	struct mount cursor;
+	struct xa_state xas;
 };
 
 extern const struct seq_operations mounts_op;
diff --git a/fs/namespace.c b/fs/namespace.c
index 5c9bcaeac4de..d19fde0654f7 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1334,6 +1334,7 @@ struct vfsmount *mnt_clone_internal(const struct path *path)
 }
 
 #ifdef CONFIG_PROC_FS
+#if 0
 static struct mount *mnt_list_next(struct mnt_namespace *ns,
 				   struct list_head *p)
 {
@@ -1351,47 +1352,40 @@ static struct mount *mnt_list_next(struct mnt_namespace *ns,
 
 	return ret;
 }
+#endif
 
 /* iterator; we want it to have access to namespace_sem, thus here... */
 static void *m_start(struct seq_file *m, loff_t *pos)
 {
-	struct proc_mounts *p = m->private;
-	struct list_head *prev;
+	struct proc_mounts *state = m->private;
+	void *entry;
 
 	down_read(&namespace_sem);
-	if (!*pos) {
-		prev = &p->ns->list;
-	} else {
-		prev = &p->cursor.mnt_list;
+	state->xas = (struct xa_state) __XA_STATE(&state->ns->mounts_by_id, *pos, 0, 0);
 
-		/* Read after we'd reached the end? */
-		if (list_empty(prev))
-			return NULL;
-	}
+	entry = xas_find(&state->xas, ULONG_MAX);
+	while (entry && xas_invalid(entry))
+		entry = xas_next_entry(&state->xas, ULONG_MAX);
 
-	return mnt_list_next(p->ns, prev);
+	return entry;
 }
 
 static void *m_next(struct seq_file *m, void *v, loff_t *pos)
 {
-	struct proc_mounts *p = m->private;
+	struct proc_mounts *state = m->private;
 	struct mount *mnt = v;
+	void *entry;
+
+	*pos = mnt->mnt_id + 1;
+	entry = xas_next_entry(&state->xas, ULONG_MAX);
+	while (entry && xas_invalid(entry))
+		entry = xas_next_entry(&state->xas, ULONG_MAX);
 
-	++*pos;
-	return mnt_list_next(p->ns, &mnt->mnt_list);
+	return entry;
 }
 
 static void m_stop(struct seq_file *m, void *v)
 {
-	struct proc_mounts *p = m->private;
-	struct mount *mnt = v;
-
-	lock_ns_list(p->ns);
-	if (mnt)
-		list_move_tail(&p->cursor.mnt_list, &mnt->mnt_list);
-	else
-		list_del_init(&p->cursor.mnt_list);
-	unlock_ns_list(p->ns);
 	up_read(&namespace_sem);
 }
 
diff --git a/fs/proc_namespace.c b/fs/proc_namespace.c
index 392ef5162655..9ae07f1904e6 100644
--- a/fs/proc_namespace.c
+++ b/fs/proc_namespace.c
@@ -283,8 +283,6 @@ static int mounts_open_common(struct inode *inode, struct file *file,
 	p->ns = ns;
 	p->root = root;
 	p->show = show;
-	INIT_LIST_HEAD(&p->cursor.mnt_list);
-	p->cursor.mnt.mnt_flags = MNT_CURSOR;
 
 	return 0;
 
@@ -301,7 +299,6 @@ static int mounts_release(struct inode *inode, struct file *file)
 	struct seq_file *m = file->private_data;
 	struct proc_mounts *p = m->private;
 	path_put(&p->root);
-	mnt_cursor_del(p->ns, &p->cursor);
 	put_mnt_ns(p->ns);
 	return seq_release_private(inode, file);
 }


