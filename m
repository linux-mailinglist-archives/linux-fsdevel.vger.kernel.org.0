Return-Path: <linux-fsdevel+bounces-40315-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E23A22268
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2025 17:58:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D48E1188911D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2025 16:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A13D1DFE0B;
	Wed, 29 Jan 2025 16:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GfnzMtB2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3901DF250
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jan 2025 16:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738169896; cv=none; b=dRYoAr9NWlLneEzW9h8qLarKwNwPRvwNdXIs0q2srmVeFlI2xyUD80Jr3hqj0XWoyR5MD4HeRDRmP0gqbJ1Mfzftl+3tdeH51erMntSnUNbY+FcDyzq7J5MD4okfKgM09+2VCk+QyskoqyUB80DZRN4r69C9Jsg0QSZkSsN8wtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738169896; c=relaxed/simple;
	bh=8e2TjtANaHTeoe8sl6kPmDjkwKIWob2Bs6CtDcqCCoA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EsPnxRc3NoaMvbEGulBoQQCOQi94pznksyIFt43KAi4uP+Jj0okpgZA6AHRLeSbiHT18Kvkvlcg6boY+E0WPMkubuDL+OtQmBLehFgS2ASjjGpaC1DasWplXlSMPtg9pGC6n+uurtF+8ecop0dyqpT3FiQ4PB6yN6yXFOw5nhpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GfnzMtB2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738169893;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3Fdn0qVB2hlx40tb+VqKQl/vuZgZHZvo8cVflZosk3s=;
	b=GfnzMtB2MRlLYntJlS8LVlTNBL5O3V20gDv7HoMj6XJnOrh7troo2sP6YPZbdBED+MzYiE
	h9r2ELuUnc1ZltteMCpccY+g+/5vH1sXEW0Mj+BD/L2iZzCcklr7Q8HAE2HnHvFq+9t/WA
	pDanBZHYI9zheyaY0byEpBmo9GjUDi4=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-9ftvngi9NUGoz2vxEiCz5g-1; Wed, 29 Jan 2025 11:58:11 -0500
X-MC-Unique: 9ftvngi9NUGoz2vxEiCz5g-1
X-Mimecast-MFC-AGG-ID: 9ftvngi9NUGoz2vxEiCz5g
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5d3bf8874dbso8901658a12.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jan 2025 08:58:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738169890; x=1738774690;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Fdn0qVB2hlx40tb+VqKQl/vuZgZHZvo8cVflZosk3s=;
        b=tYbC8Q18FhnNugvt4bbfiYtY5b6TK1rutKCW7x+W9/PlTfbtGHQHwYePtV5okB7iPc
         FMDW7pO6SFzQlqBfW1DYSKk6Abpzsl+juxHvTPYT9ueGuXVg6ye6gQSTS5nH8yM2y0ET
         eGv7JXC+EITyfdu0j7SGSFSiH1Y5aRgSH+5nBgh6kulHqTjjBNmhTboZhzoo5RPxwTnr
         B+sXtLRAuTugiQ0Qg+TCDstlR7P7YkCBwuKZoJA+hsoxlzml9gblVai4HjeSUK173Hu+
         HCSPSVG7Rt4JwMC6+372JifsvSgOtT71hImpamIzcbD9+2a/M4WbsggN2yAC+7zgsuFa
         vH7Q==
X-Gm-Message-State: AOJu0YwoyPP/OVA7JyFUK+cJ3shxIN24IdCrGzuCQ4wzMb2UVLlLyx1Q
	NZnIwRKtXI4g0BphN+v52aWQlEyD+KO6P5I0/qMvzl4moVdsF3XF9VvcbTgYsGyogn7TkS99FkD
	ulcP3Z+NSIAIupYKkzM7u0mNocXrxcpnGLkfW1jbmtaXTBGpmOZp1OxHrAkcVwAg31W1zn9yBXT
	vfcMbaGLiiI1CP5oX9Z3uVq2sM5v8khVGpOsHz6XZofVPCtiTcdg==
X-Gm-Gg: ASbGncu4ugV5NMHfSWLQTqFVtGyM+hHNCWqlE1xVYSrVqkBRX9BJJEOrYkzeKZvanWJ
	WL0jrMhR6DlZYaWSa7BaK6Zt7VonkHauvUbt6oiNJMnefsQyx94dSrHSu+8v/sd1H2lvO4xpvUe
	GUqb4dsFB9bp4ypk8NLi+KdXfspBHruMIDYlgNTEOmdE05Vy9T5rkp4SysfxrEk1DTnduigFZaf
	n82+GUqMleFHzoaou4xnL46fYfS7dPQAYPfVhp+lgqk8SFmcEzTDz/X+h8vPtMnIzt2ej0S69t9
	bMuUKfYpsjwOLhMSUKJn5s9HZXZzme+s23/daLiCe8FRrjzszgeEr5e5
X-Received: by 2002:a17:907:9691:b0:ab6:dbd2:df78 with SMTP id a640c23a62f3a-ab6dbd2e39dmr153464866b.35.1738169889753;
        Wed, 29 Jan 2025 08:58:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGyc1gmLR/6x+vkL+zqwJDDj0W/YmQwy5Gp0kD+BKGvnFwC6jvJ1Vephop+nOzwGW0bGm75ZQ==
X-Received: by 2002:a17:907:9691:b0:ab6:dbd2:df78 with SMTP id a640c23a62f3a-ab6dbd2e39dmr153460966b.35.1738169889230;
        Wed, 29 Jan 2025 08:58:09 -0800 (PST)
Received: from maszat.piliscsaba.szeredi.hu (91-82-183-41.pool.digikabel.hu. [91.82.183.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab675e653c6sm1002813366b.64.2025.01.29.08.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 08:58:08 -0800 (PST)
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Amir Goldstein <amir73il@gmail.com>,
	Karel Zak <kzak@redhat.com>,
	Lennart Poettering <lennart@poettering.net>,
	Ian Kent <raven@themaw.net>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Paul Moore <paul@paul-moore.com>,
	selinux@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	selinux-refpolicy@vger.kernel.org
Subject: [PATCH v5 3/3] vfs: add notifications for mount attach and detach
Date: Wed, 29 Jan 2025 17:58:01 +0100
Message-ID: <20250129165803.72138-4-mszeredi@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250129165803.72138-1-mszeredi@redhat.com>
References: <20250129165803.72138-1-mszeredi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add notifications for attaching and detaching mounts to fs/namespace.c

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/mount.h     | 20 +++++++++++++
 fs/namespace.c | 79 +++++++++++++++++++++++++++++++++++++++++++++++++-
 fs/pnode.c     |  4 ++-
 3 files changed, 101 insertions(+), 2 deletions(-)

diff --git a/fs/mount.h b/fs/mount.h
index 5324a931b403..946dc8b792d7 100644
--- a/fs/mount.h
+++ b/fs/mount.h
@@ -5,6 +5,8 @@
 #include <linux/ns_common.h>
 #include <linux/fs_pin.h>
 
+extern struct list_head notify_list;
+
 struct mnt_namespace {
 	struct ns_common	ns;
 	struct mount *	root;
@@ -80,6 +82,8 @@ struct mount {
 #ifdef CONFIG_FSNOTIFY
 	struct fsnotify_mark_connector __rcu *mnt_fsnotify_marks;
 	__u32 mnt_fsnotify_mask;
+	struct list_head to_notify;	/* need to queue notification */
+	struct mnt_namespace *prev_ns;	/* previous namespace (NULL if none) */
 #endif
 	int mnt_id;			/* mount identifier, reused */
 	u64 mnt_id_unique;		/* mount ID unique until reboot */
@@ -182,4 +186,20 @@ static inline struct mnt_namespace *to_mnt_ns(struct ns_common *ns)
 	return container_of(ns, struct mnt_namespace, ns);
 }
 
+#ifdef CONFIG_FSNOTIFY
+static inline void mnt_notify_add(struct mount *m)
+{
+	/* Optimize the case where there are no watches */
+	if ((m->mnt_ns && m->mnt_ns->n_fsnotify_marks) ||
+	    (m->prev_ns && m->prev_ns->n_fsnotify_marks))
+		list_add_tail(&m->to_notify, &notify_list);
+	else
+		m->prev_ns = m->mnt_ns;
+}
+#else
+static inline void mnt_notify_add(struct mount *m)
+{
+}
+#endif
+
 struct mnt_namespace *mnt_ns_from_dentry(struct dentry *dentry);
diff --git a/fs/namespace.c b/fs/namespace.c
index d8d70da56e7b..1e964b646509 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -81,6 +81,9 @@ static HLIST_HEAD(unmounted);	/* protected by namespace_sem */
 static LIST_HEAD(ex_mountpoints); /* protected by namespace_sem */
 static DEFINE_SEQLOCK(mnt_ns_tree_lock);
 
+#ifdef CONFIG_FSNOTIFY
+LIST_HEAD(notify_list); /* protected by namespace_sem */
+#endif
 static struct rb_root mnt_ns_tree = RB_ROOT; /* protected by mnt_ns_tree_lock */
 static LIST_HEAD(mnt_ns_list); /* protected by mnt_ns_tree_lock */
 
@@ -163,6 +166,7 @@ static void mnt_ns_release(struct mnt_namespace *ns)
 {
 	/* keep alive for {list,stat}mount() */
 	if (refcount_dec_and_test(&ns->passive)) {
+		fsnotify_mntns_delete(ns);
 		put_user_ns(ns->user_ns);
 		kfree(ns);
 	}
@@ -1176,6 +1180,8 @@ static void mnt_add_to_ns(struct mnt_namespace *ns, struct mount *mnt)
 		ns->mnt_first_node = &mnt->mnt_node;
 	rb_link_node(&mnt->mnt_node, parent, link);
 	rb_insert_color(&mnt->mnt_node, &ns->mounts);
+
+	mnt_notify_add(mnt);
 }
 
 /*
@@ -1723,6 +1729,50 @@ int may_umount(struct vfsmount *mnt)
 
 EXPORT_SYMBOL(may_umount);
 
+#ifdef CONFIG_FSNOTIFY
+static void mnt_notify(struct mount *p)
+{
+	if (!p->prev_ns && p->mnt_ns) {
+		fsnotify_mnt_attach(p->mnt_ns, &p->mnt);
+	} else if (p->prev_ns && !p->mnt_ns) {
+		fsnotify_mnt_detach(p->prev_ns, &p->mnt);
+	} else if (p->prev_ns == p->mnt_ns) {
+		fsnotify_mnt_move(p->mnt_ns, &p->mnt);
+	} else {
+		fsnotify_mnt_detach(p->prev_ns, &p->mnt);
+		fsnotify_mnt_attach(p->mnt_ns, &p->mnt);
+	}
+	p->prev_ns = p->mnt_ns;
+}
+
+static void notify_mnt_list(void)
+{
+	struct mount *m, *tmp;
+	/*
+	 * Notify about mounts that were added/reparented/detached/remain
+	 * connected after unmount.
+	 */
+	list_for_each_entry_safe(m, tmp, &notify_list, to_notify) {
+		mnt_notify(m);
+		list_del_init(&m->to_notify);
+	}
+}
+
+static bool need_notify_mnt_list(void)
+{
+	return !list_empty(&notify_list);
+}
+#else
+static void notify_mnt_list(void)
+{
+}
+
+static bool need_notify_mnt_list(void)
+{
+	return false;
+}
+#endif
+
 static void namespace_unlock(void)
 {
 	struct hlist_head head;
@@ -1733,7 +1783,18 @@ static void namespace_unlock(void)
 	hlist_move_list(&unmounted, &head);
 	list_splice_init(&ex_mountpoints, &list);
 
-	up_write(&namespace_sem);
+	if (need_notify_mnt_list()) {
+		/*
+		 * No point blocking out concurrent readers while notifications
+		 * are sent. This will also allow statmount()/listmount() to run
+		 * concurrently.
+		 */
+		downgrade_write(&namespace_sem);
+		notify_mnt_list();
+		up_read(&namespace_sem);
+	} else {
+		up_write(&namespace_sem);
+	}
 
 	shrink_dentry_list(&list);
 
@@ -1846,6 +1907,19 @@ static void umount_tree(struct mount *mnt, enum umount_tree_flags how)
 		change_mnt_propagation(p, MS_PRIVATE);
 		if (disconnect)
 			hlist_add_head(&p->mnt_umount, &unmounted);
+
+		/*
+		 * At this point p->mnt_ns is NULL, notification will be queued
+		 * only if
+		 *
+		 *  - p->prev_ns is non-NULL *and*
+		 *  - p->prev_ns->n_fsnotify_marks is non-NULL
+		 *
+		 * This will preclude queuing the mount if this is a cleanup
+		 * after a failed copy_tree() or destruction of an anonymous
+		 * namespace, etc.
+		 */
+		mnt_notify_add(p);
 	}
 }
 
@@ -2555,6 +2629,7 @@ static int attach_recursive_mnt(struct mount *source_mnt,
 			dest_mp = smp;
 		unhash_mnt(source_mnt);
 		attach_mnt(source_mnt, top_mnt, dest_mp, beneath);
+		mnt_notify_add(source_mnt);
 		touch_mnt_namespace(source_mnt->mnt_ns);
 	} else {
 		if (source_mnt->mnt_ns) {
@@ -4476,6 +4551,8 @@ SYSCALL_DEFINE2(pivot_root, const char __user *, new_root,
 	list_del_init(&new_mnt->mnt_expire);
 	put_mountpoint(root_mp);
 	unlock_mount_hash();
+	mnt_notify_add(root_mnt);
+	mnt_notify_add(new_mnt);
 	chroot_fs_refs(&root, &new);
 	error = 0;
 out4:
diff --git a/fs/pnode.c b/fs/pnode.c
index ef048f008bdd..82d809c785ec 100644
--- a/fs/pnode.c
+++ b/fs/pnode.c
@@ -549,8 +549,10 @@ static void restore_mounts(struct list_head *to_restore)
 			mp = parent->mnt_mp;
 			parent = parent->mnt_parent;
 		}
-		if (parent != mnt->mnt_parent)
+		if (parent != mnt->mnt_parent) {
 			mnt_change_mountpoint(parent, mp, mnt);
+			mnt_notify_add(mnt);
+		}
 	}
 }
 
-- 
2.48.1


