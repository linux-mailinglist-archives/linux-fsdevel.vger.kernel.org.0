Return-Path: <linux-fsdevel+bounces-40001-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32B86A1AA80
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 20:42:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 257D0188D419
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 19:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F41D61C3BEC;
	Thu, 23 Jan 2025 19:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BrLS0OBX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D461BD027
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jan 2025 19:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737661281; cv=none; b=VLsaUFaQO5/7+uW2rOQknXhV3WWOm7c6i1OgpV50XYGE6gMwmxix5TtInt6L2rO+/ZoZXi0grSwFhw0qjv09s85ScFtQ4EZFNVODN6+TO/sHvlyCrewLRjNGMrXTCLqLfSfEd0WigH40K7hJWDImWQbKQ98MPZ2UCQELn37DQZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737661281; c=relaxed/simple;
	bh=GIF+fk9IobFSfNhuFhApJTMzkrK12SVgNFfAKA+iy3w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jSuW4VovyDQHczz9PcuJgW0NTayMBn/Xwmtka5ExQlkpAoXNUs+7TVZ8jk1DPKjPYD2CyUQE2BDpFAx0ppyWa+cuFsuMi44SI0DiYRZTfWI/AAwDNJZhDFkNBjHrV42mvjFr2D2+xjHs+jq+TPB4cceDjNiSz7+mN0TsE1+UBKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BrLS0OBX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737661277;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+V+IxkaybUSMW2r1YO28wGSsGSHInaXvUKJ337QNsU4=;
	b=BrLS0OBXgbKjBsKzYrop8x5iGv4Y9vkaYqPmTvTcsGCETibU9hgBCfC0FGA9TSwZaWW3YH
	Dfk/np+RWBIU8qbMjnv7jFeXjFhSKyvhVyrcwDT7ZJECAWUxyZjYkuqvh45QRtXLhpRpC/
	1BYB9kKin8Dm4aN3vF1sehG2q7FVibE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-323-9QXuLbcHN5udicwX3IVZgA-1; Thu, 23 Jan 2025 14:41:16 -0500
X-MC-Unique: 9QXuLbcHN5udicwX3IVZgA-1
X-Mimecast-MFC-AGG-ID: 9QXuLbcHN5udicwX3IVZgA
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3862c67763dso480519f8f.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jan 2025 11:41:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737661275; x=1738266075;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+V+IxkaybUSMW2r1YO28wGSsGSHInaXvUKJ337QNsU4=;
        b=szty+bNBO7qAM1erU235SbseIgBwUMkLVNVAZJ9F1PYtpsU6bGfNLelWrEm90t8jKh
         eAskFaqcc5e5en3cbbqGugfix7VwCOfhwp2RqRQgUEQ0Mf+liR8U6XwqARbUVaM1Qq0S
         aJFKtb36WuzhkGapjEPiBG6YHxmkrE0ITiilomTgJ/mFW2XsVOaYI0H8qzyQ8ovhLu7o
         M1b3iOwUSIHClrtCkYlPAr/SJat4zhz8yfCvfTVrFjvLj1E2d9nJFx1drXSpYlv5ZERT
         lnV9vBrpNdQeYuhTUYU6/XQMXD/1SQlnUZGK6Z2T/tunRTYWJphJNy3ZAW9GuK2+qbjo
         PCxA==
X-Gm-Message-State: AOJu0YzkLl7t4TepTpO2XkzbHJZfVcO5LZmmSGIeCsFuj8psm7/DclaR
	uikY99X6VmDQGWn29ZX7OzORttiDvgU6LYwije3GYMHQTNu6aF1RrazJJ7Ut7XGr59FjRdflO3l
	JbmVVeExbUQ95M90fKkAYIcPAsCcU5BHdQnlxl17+xbAcS1j0N8Cb+me1zDgO6gNEv/Zhd/4EPO
	clEfnXj9daN5Nt4uy7dIjdKs9vuKMtKN/3j0ymTBqVskjYkTLTaw==
X-Gm-Gg: ASbGncs6jhCgTGvbR0pRXq9fgD1v4cPAPoUNF/bVPAJLzwMFZE3ZqXQAHGKveiR3H+1
	phCUvHKuYGRrcGg8mv0kxtyvyZUtIJNB9zAhG1lxlIryKCNYkKDx+MVchuCukVCwbtDKxKMRQOV
	MCTDa7ZtCc/EHaF91af520c3f5e3mY2dpkG71hk1tKqMfF5WUAq39z4xYi3QnAe48cCerdjyyJ7
	gK1GZsFT6PSu/OaDj4hFJo1P0DUMZoN2XbUGMFEDzOBevciLtb3lrYB+XbPMTCnXbaYCLrP/vV0
	OHI0xthyu8fy06VxQx0sFiHX8mTEoXbwJ1ix1tQ3d65+cg==
X-Received: by 2002:a5d:5f54:0:b0:38a:4184:151a with SMTP id ffacd0b85a97d-38bf57a662bmr23000429f8f.37.1737661274840;
        Thu, 23 Jan 2025 11:41:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF6bvb2a3XGHOGcH/RcOdmYEOAisg6ahNrkQ9wKfU4H2gSMzXslaNmQdhwD6k+hdMTBdlXNDw==
X-Received: by 2002:a5d:5f54:0:b0:38a:4184:151a with SMTP id ffacd0b85a97d-38bf57a662bmr23000397f8f.37.1737661274407;
        Thu, 23 Jan 2025 11:41:14 -0800 (PST)
Received: from maszat.piliscsaba.szeredi.hu (91-82-183-41.pool.digikabel.hu. [91.82.183.41])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438bd507e46sm1687245e9.21.2025.01.23.11.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 11:41:14 -0800 (PST)
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Amir Goldstein <amir73il@gmail.com>,
	Karel Zak <kzak@redhat.com>,
	Lennart Poettering <lennart@poettering.net>,
	Ian Kent <raven@themaw.net>,
	Al Viro <viro@zeniv.linux.org.uk>,
	linux-security-module@vger.kernel.org,
	Paul Moore <paul@paul-moore.com>
Subject: [PATCH v4 3/4] vfs: add notifications for mount attach and detach
Date: Thu, 23 Jan 2025 20:41:06 +0100
Message-ID: <20250123194108.1025273-4-mszeredi@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250123194108.1025273-1-mszeredi@redhat.com>
References: <20250123194108.1025273-1-mszeredi@redhat.com>
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
index 9689e7bf4501..7dd22a226a6e 100644
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
@@ -72,6 +74,8 @@ struct mount {
 #ifdef CONFIG_FSNOTIFY
 	struct fsnotify_mark_connector __rcu *mnt_fsnotify_marks;
 	__u32 mnt_fsnotify_mask;
+	struct list_head to_notify;	/* need to queue notification */
+	struct mnt_namespace *prev_ns;	/* previous namespace (NULL if none) */
 #endif
 	int mnt_id;			/* mount identifier, reused */
 	u64 mnt_id_unique;		/* mount ID unique until reboot */
@@ -175,4 +179,20 @@ static inline struct mnt_namespace *to_mnt_ns(struct ns_common *ns)
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
index 4d9072fd1263..948348a37f6c 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -79,6 +79,9 @@ static struct kmem_cache *mnt_cache __ro_after_init;
 static DECLARE_RWSEM(namespace_sem);
 static HLIST_HEAD(unmounted);	/* protected by namespace_sem */
 static LIST_HEAD(ex_mountpoints); /* protected by namespace_sem */
+#ifdef CONFIG_FSNOTIFY
+LIST_HEAD(notify_list); /* protected by namespace_sem */
+#endif
 static DEFINE_RWLOCK(mnt_ns_tree_lock);
 static struct rb_root mnt_ns_tree = RB_ROOT; /* protected by mnt_ns_tree_lock */
 
@@ -145,6 +148,7 @@ static void mnt_ns_release(struct mnt_namespace *ns)
 
 	/* keep alive for {list,stat}mount() */
 	if (refcount_dec_and_test(&ns->passive)) {
+		fsnotify_mntns_delete(ns);
 		put_user_ns(ns->user_ns);
 		kfree(ns);
 	}
@@ -1136,6 +1140,8 @@ static void mnt_add_to_ns(struct mnt_namespace *ns, struct mount *mnt)
 	}
 	rb_link_node(&mnt->mnt_node, parent, link);
 	rb_insert_color(&mnt->mnt_node, &ns->mounts);
+
+	mnt_notify_add(mnt);
 }
 
 /*
@@ -1683,6 +1689,50 @@ int may_umount(struct vfsmount *mnt)
 
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
@@ -1693,7 +1743,18 @@ static void namespace_unlock(void)
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
 
@@ -1806,6 +1867,19 @@ static void umount_tree(struct mount *mnt, enum umount_tree_flags how)
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
 
@@ -2511,6 +2585,7 @@ static int attach_recursive_mnt(struct mount *source_mnt,
 			dest_mp = smp;
 		unhash_mnt(source_mnt);
 		attach_mnt(source_mnt, top_mnt, dest_mp, beneath);
+		mnt_notify_add(source_mnt);
 		touch_mnt_namespace(source_mnt->mnt_ns);
 	} else {
 		if (source_mnt->mnt_ns) {
@@ -4426,6 +4501,8 @@ SYSCALL_DEFINE2(pivot_root, const char __user *, new_root,
 	list_del_init(&new_mnt->mnt_expire);
 	put_mountpoint(root_mp);
 	unlock_mount_hash();
+	mnt_notify_add(root_mnt);
+	mnt_notify_add(new_mnt);
 	chroot_fs_refs(&root, &new);
 	error = 0;
 out4:
diff --git a/fs/pnode.c b/fs/pnode.c
index a799e0315cc9..d42b71c3567a 100644
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
2.47.1


