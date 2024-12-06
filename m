Return-Path: <linux-fsdevel+bounces-36640-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B1B09E72D4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 16:13:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99CA71888613
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 15:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3C5F207E05;
	Fri,  6 Dec 2024 15:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LqoEVbBM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154E2207DF8
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Dec 2024 15:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733497926; cv=none; b=pE/XjYqKin4tOn6vjmRf/Kld2NFlGN4Av7vPIqWgcbLEbL3ZTx1Twa5yljYWNlOXM6eOcPQtE0q9IuZ7zqhdjwW7Vbw7rCfH3k5F/a62rqSWYmpspfm+7RfgGpMcfCjBj51LyCK+Pr4Mp93fP9j13U4iAt+kW0kmFSWl/GKVhzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733497926; c=relaxed/simple;
	bh=UiRqG5oILo1TTQdQkYwlkLerajh39n2ujmiQ9rzvOrs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=izlIibsvB14KgFGxeQ8MxOpSiadMcfzrdIsoJ70vNun3rMKaaEAmWPNoCrHlf78qbTXr/UYEJksb4YhfnMIDQL2q6d+8zy7CERMi6j7G7+hEivyzooAZ5ZJFoZM1wsHhUCPI4I/eqSGUw0q5Swo2qa/1ibKvmjSylQw25i1mXnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LqoEVbBM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733497922;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/jDy4MfFJgmZRiuVfZV4Jm53E7ahfV2/BaNcGaoD9wg=;
	b=LqoEVbBMx0pS/2OigA1Rn8Fdoppy15KScwC4TGWaGOf4FGhiXPt5EOY3FWbGgJlFw3puxi
	hX/Oe9MaFywIdrEB4alUpBx2zuPWjDGjBWT6O/kdjtQa4sV43IWCk1ctIANDuE6WXuiPm7
	Bmf6nziAoWC7iGaiUjYJ+av0GzcfFVw=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-O7bKBQ9iPdas0pOJn2QLaQ-1; Fri, 06 Dec 2024 10:12:00 -0500
X-MC-Unique: O7bKBQ9iPdas0pOJn2QLaQ-1
X-Mimecast-MFC-AGG-ID: O7bKBQ9iPdas0pOJn2QLaQ
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-aa638133084so160350466b.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Dec 2024 07:12:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733497919; x=1734102719;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/jDy4MfFJgmZRiuVfZV4Jm53E7ahfV2/BaNcGaoD9wg=;
        b=k4Y+hislRAekS9gcv4siZXgK+3IL44AEF8H6vv/+fauiAe9l3Sb/0bmaCwLP63yKw2
         /Nv1YglpLZUixs3WPN2y56kmOAXyImB7cH+7OC8UZwIsuxc5Wz4dCPEneQ/NqUu9TZa7
         R/HETNgxWvBdxOhZsRdumsK8IzNVga1OHsQwSm1Z5LLVtyFgqe8Yh9ZIrn2hPf4SFUcv
         LG7HMYnUpT87958AnhjNMpg5rRsOh0pwFGv3WGPb+qqexiCTuwX6+HUuE4INbi6td65+
         wIOdPPXflMlm2wssiaDH1hMZ38GckkTwkDjloFlND/fUeF8jKphm8etYG8oKXBb7xm0+
         78HQ==
X-Gm-Message-State: AOJu0YwqdIkHyrbXKE+EEkY0JX8YfyVqoBxxqXM86qfm3y7BI/PQMNts
	KARYsLshlAN6c2p4s3x707lpk0FgAy2dC/n48Aryz2nmbO7NgmCGPIs/UHxBXqeIbeHUPacgdH3
	4Z+lKhiip0zi4/8MvzDl2c/RdztB4pI8d6uzNdOIm+X0KO+b3e1CWzqeVRik8tQ9Dfa0wzHTStF
	IookHWYMhjFNL0DMlhat/FnLOIVaZoDNtX9NpL7oQqbRyqOxttSA==
X-Gm-Gg: ASbGncsKQYkwPhG/sRS9vp2vupM6AnrNY13PIbN8Kh+kAbKOn5KgH8m7mZGQcInU/2C
	c/TU/yl399DuAZkAOzvnEMsSI8wl7TAIEpUoKFLFGDpZJSQuOj2/DBs4p2N9mX0sUDvPtcGugcF
	y8I0RQ6gFs0F/gmKlDAPNIg2pW/ud55mWGNKoVNc4RF8FUshhX+FXJ9tbf8bLUPM/ItxIUKVx4P
	5Eyi3gdb9AQQDqY/aOnNT4/UWOQuqEL3+AXVyfcxivIsjWbadLhrQgjCf38vlSKFQ4gwRoYF3Qc
	0tG/YBsgGaq5aXArcyrZWCoYN+/d
X-Received: by 2002:a17:907:6ea2:b0:aa5:ec8a:bc with SMTP id a640c23a62f3a-aa621a8fd76mr682741766b.28.1733497918537;
        Fri, 06 Dec 2024 07:11:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF/a8O6s8WGgR1UwqgQ9Yl7hrzMY5BWnf/9/bdErmJu06K149x1zN7ycDobSXrVGJJQE3Jfxw==
X-Received: by 2002:a17:907:6ea2:b0:aa5:ec8a:bc with SMTP id a640c23a62f3a-aa621a8fd76mr682732266b.28.1733497917260;
        Fri, 06 Dec 2024 07:11:57 -0800 (PST)
Received: from maszat.piliscsaba.szeredi.hu (91-82-179-133.pool.digikabel.hu. [91.82.179.133])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa62601c216sm255204966b.101.2024.12.06.07.11.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 07:11:56 -0800 (PST)
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>,
	Amir Goldstein <amir73il@gmail.com>,
	Karel Zak <kzak@redhat.com>,
	Lennart Poettering <lennart@poettering.net>,
	Ian Kent <raven@themaw.net>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH v2] fanotify: notify on mount attach and detach
Date: Fri,  6 Dec 2024 16:11:52 +0100
Message-ID: <20241206151154.60538-1-mszeredi@redhat.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add notifications for attaching and detaching mounts.  The following new
event masks are added:

  FAN_MNT_ATTACH  - Mount was attached
  FAN_MNT_DETACH  - Mount was detached

If a mount is moved, then the event is reported with (FAN_MNT_ATTACH |
FAN_MNT_DETACH).

These events add an info record of type FAN_EVENT_INFO_TYPE_MNT containing
these fields identifying the affected mounts:

  __u64 mnt_id    - the ID of the mount (see statmount(2))

FAN_REPORT_MNT must be supplied to fanotify_init() to receive these events
and no other type of event can be received with this report type.

Marks are added with FAN_MARK_MNTNS, which records the mount namespace
belonging to the supplied path.

Prior to this patch mount namespace changes could be monitored by polling
/proc/self/mountinfo, which did not convey any information about what
changed.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/mount.h                         |  11 +++
 fs/namespace.c                     | 120 ++++++++++++++++++++++-------
 fs/notify/fanotify/fanotify.c      |  56 ++++++++++----
 fs/notify/fanotify/fanotify.h      |  18 +++++
 fs/notify/fanotify/fanotify_user.c |  70 ++++++++++++++++-
 fs/notify/fdinfo.c                 |   2 +
 fs/notify/fsnotify.c               |  44 +++++++++--
 fs/notify/fsnotify.h               |  11 +++
 fs/notify/mark.c                   |  14 +++-
 fs/pnode.c                         |   4 +-
 include/linux/fanotify.h           |  14 ++--
 include/linux/fsnotify.h           |  20 +++++
 include/linux/fsnotify_backend.h   |  40 +++++++++-
 include/linux/mnt_namespace.h      |   5 ++
 include/uapi/linux/fanotify.h      |  10 +++
 security/selinux/hooks.c           |   4 +
 16 files changed, 384 insertions(+), 59 deletions(-)

v2:
	- notify for whole namespace as this seems to be what people prefer
	- move fsnotify() calls outside of mount_lock
	- only report mnt_id, not parent_id

diff --git a/fs/mount.h b/fs/mount.h
index 185fc56afc13..a79232a8c908 100644
--- a/fs/mount.h
+++ b/fs/mount.h
@@ -14,6 +14,10 @@ struct mnt_namespace {
 	u64			seq;	/* Sequence number to prevent loops */
 	wait_queue_head_t poll;
 	u64 event;
+#ifdef CONFIG_FSNOTIFY
+	__u32			n_fsnotify_mask;
+	struct fsnotify_mark_connector __rcu *n_fsnotify_marks;
+#endif
 	unsigned int		nr_mounts; /* # of mounts in the namespace */
 	unsigned int		pending_mounts;
 	struct rb_node		mnt_ns_tree_node; /* node in the mnt_ns_tree */
@@ -77,6 +81,13 @@ struct mount {
 	int mnt_expiry_mark;		/* true if marked for expiry */
 	struct hlist_head mnt_pins;
 	struct hlist_head mnt_stuck_children;
+
+	/*
+	 * for mount notification
+	 * FIXME: maybe move to a union with some other fields?
+	 */
+	struct list_head to_notify; /* singly linked list? */
+	struct mnt_namespace *prev_ns;
 } __randomize_layout;
 
 #define MNT_NS_INTERNAL ERR_PTR(-EINVAL) /* distinct from any mnt_namespace */
diff --git a/fs/namespace.c b/fs/namespace.c
index 23e81c2a1e3f..b376570544a7 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -139,12 +139,13 @@ static void mnt_ns_tree_add(struct mnt_namespace *ns)
 	rb_add(&ns->mnt_ns_tree_node, &mnt_ns_tree, mnt_ns_less);
 }
 
-static void mnt_ns_release(struct mnt_namespace *ns)
+void mnt_ns_release(struct mnt_namespace *ns)
 {
 	lockdep_assert_not_held(&mnt_ns_tree_lock);
 
 	/* keep alive for {list,stat}mount() */
 	if (refcount_dec_and_test(&ns->passive)) {
+		fsnotify_mntns_delete(ns);
 		put_user_ns(ns->user_ns);
 		kfree(ns);
 	}
@@ -1119,7 +1120,16 @@ static inline struct mount *node_to_mount(struct rb_node *node)
 	return node ? rb_entry(node, struct mount, mnt_node) : NULL;
 }
 
-static void mnt_add_to_ns(struct mnt_namespace *ns, struct mount *mnt)
+static void queue_notify(struct mnt_namespace *ns, struct mount *m, struct list_head *notif)
+{
+	/* Optimize the case where there are no watches */
+	if (ns->n_fsnotify_marks)
+		list_add_tail(&m->to_notify, notif);
+	else
+		m->prev_ns = m->mnt_ns;
+}
+
+static void __mnt_add_to_ns(struct mnt_namespace *ns, struct mount *mnt)
 {
 	struct rb_node **link = &ns->mounts.rb_node;
 	struct rb_node *parent = NULL;
@@ -1138,10 +1148,37 @@ static void mnt_add_to_ns(struct mnt_namespace *ns, struct mount *mnt)
 	mnt->mnt.mnt_flags |= MNT_ONRB;
 }
 
+static void mnt_add_to_ns(struct mnt_namespace *ns, struct mount *mnt, struct list_head *notif)
+{
+	__mnt_add_to_ns(ns, mnt);
+	queue_notify(ns, mnt, notif);
+}
+
+static void notify_mounts(struct list_head *head)
+{
+	struct mount *p;
+
+	while (!list_empty(head)) {
+		p = list_first_entry(head, struct mount, to_notify);
+		if (!p->prev_ns && p->mnt_ns) {
+			fsnotify_mnt_attach(p->mnt_ns, &p->mnt);
+		} else if (p->prev_ns && !p->mnt_ns) {
+			fsnotify_mnt_detach(p->prev_ns, &p->mnt);
+		} else if (p->prev_ns == p->mnt_ns) {
+			fsnotify_mnt_move(p->mnt_ns, &p->mnt);
+		} else	{
+			fsnotify_mnt_detach(p->prev_ns, &p->mnt);
+			fsnotify_mnt_attach(p->mnt_ns, &p->mnt);
+		}
+		p->prev_ns = p->mnt_ns;
+		list_del_init(&p->to_notify);
+	}
+}
+
 /*
  * vfsmount lock must be held for write
  */
-static void commit_tree(struct mount *mnt)
+static void commit_tree(struct mount *mnt, struct list_head *notif)
 {
 	struct mount *parent = mnt->mnt_parent;
 	struct mount *m;
@@ -1155,7 +1192,7 @@ static void commit_tree(struct mount *mnt)
 		m = list_first_entry(&head, typeof(*m), mnt_list);
 		list_del(&m->mnt_list);
 
-		mnt_add_to_ns(n, m);
+		mnt_add_to_ns(n, m, notif);
 	}
 	n->nr_mounts += n->pending_mounts;
 	n->pending_mounts = 0;
@@ -1752,7 +1789,7 @@ static bool disconnect_mount(struct mount *mnt, enum umount_tree_flags how)
  * mount_lock must be held
  * namespace_sem must be held for write
  */
-static void umount_tree(struct mount *mnt, enum umount_tree_flags how)
+static void umount_tree(struct mount *mnt, struct list_head *notif, enum umount_tree_flags how)
 {
 	LIST_HEAD(tmp_list);
 	struct mount *p;
@@ -1785,11 +1822,12 @@ static void umount_tree(struct mount *mnt, enum umount_tree_flags how)
 		list_del_init(&p->mnt_expire);
 		list_del_init(&p->mnt_list);
 		ns = p->mnt_ns;
+		p->mnt_ns = NULL;
 		if (ns) {
 			ns->nr_mounts--;
 			__touch_mnt_namespace(ns);
+			queue_notify(ns, p, notif);
 		}
-		p->mnt_ns = NULL;
 		if (how & UMOUNT_SYNC)
 			p->mnt.mnt_flags |= MNT_SYNC_UMOUNT;
 
@@ -1809,7 +1847,7 @@ static void umount_tree(struct mount *mnt, enum umount_tree_flags how)
 	}
 }
 
-static void shrink_submounts(struct mount *mnt);
+static void shrink_submounts(struct mount *mnt, struct list_head *notif);
 
 static int do_umount_root(struct super_block *sb)
 {
@@ -1837,6 +1875,7 @@ static int do_umount_root(struct super_block *sb)
 static int do_umount(struct mount *mnt, int flags)
 {
 	struct super_block *sb = mnt->mnt.mnt_sb;
+	LIST_HEAD(notif);
 	int retval;
 
 	retval = security_sb_umount(&mnt->mnt, flags);
@@ -1914,20 +1953,21 @@ static int do_umount(struct mount *mnt, int flags)
 	if (flags & MNT_DETACH) {
 		if (mnt->mnt.mnt_flags & MNT_ONRB ||
 		    !list_empty(&mnt->mnt_list))
-			umount_tree(mnt, UMOUNT_PROPAGATE);
+			umount_tree(mnt, &notif, UMOUNT_PROPAGATE);
 		retval = 0;
 	} else {
-		shrink_submounts(mnt);
+		shrink_submounts(mnt, &notif);
 		retval = -EBUSY;
 		if (!propagate_mount_busy(mnt, 2)) {
 			if (mnt->mnt.mnt_flags & MNT_ONRB ||
 			    !list_empty(&mnt->mnt_list))
-				umount_tree(mnt, UMOUNT_PROPAGATE|UMOUNT_SYNC);
+				umount_tree(mnt, &notif, UMOUNT_PROPAGATE|UMOUNT_SYNC);
 			retval = 0;
 		}
 	}
 out:
 	unlock_mount_hash();
+	notify_mounts(&notif);
 	namespace_unlock();
 	return retval;
 }
@@ -1946,6 +1986,7 @@ void __detach_mounts(struct dentry *dentry)
 {
 	struct mountpoint *mp;
 	struct mount *mnt;
+	LIST_HEAD(notif);
 
 	namespace_lock();
 	lock_mount_hash();
@@ -1960,11 +2001,12 @@ void __detach_mounts(struct dentry *dentry)
 			umount_mnt(mnt);
 			hlist_add_head(&mnt->mnt_umount, &unmounted);
 		}
-		else umount_tree(mnt, UMOUNT_CONNECTED);
+		else umount_tree(mnt, &notif, UMOUNT_CONNECTED);
 	}
 	put_mountpoint(mp);
 out_unlock:
 	unlock_mount_hash();
+	notify_mounts(&notif);
 	namespace_unlock();
 }
 
@@ -2172,7 +2214,7 @@ struct mount *copy_tree(struct mount *src_root, struct dentry *dentry,
 out:
 	if (res) {
 		lock_mount_hash();
-		umount_tree(res, UMOUNT_SYNC);
+		umount_tree(res, NULL, UMOUNT_SYNC);
 		unlock_mount_hash();
 	}
 	return dst_mnt;
@@ -2201,16 +2243,19 @@ static struct mnt_namespace *alloc_mnt_ns(struct user_namespace *, bool);
 void dissolve_on_fput(struct vfsmount *mnt)
 {
 	struct mnt_namespace *ns;
+	LIST_HEAD(notif);
+
 	namespace_lock();
 	lock_mount_hash();
 	ns = real_mount(mnt)->mnt_ns;
 	if (ns) {
 		if (is_anon_ns(ns))
-			umount_tree(real_mount(mnt), UMOUNT_CONNECTED);
+			umount_tree(real_mount(mnt), &notif, UMOUNT_CONNECTED);
 		else
 			ns = NULL;
 	}
 	unlock_mount_hash();
+	notify_mounts(&notif);
 	namespace_unlock();
 	if (ns)
 		free_mnt_ns(ns);
@@ -2218,10 +2263,13 @@ void dissolve_on_fput(struct vfsmount *mnt)
 
 void drop_collected_mounts(struct vfsmount *mnt)
 {
+	LIST_HEAD(notif);
+
 	namespace_lock();
 	lock_mount_hash();
-	umount_tree(real_mount(mnt), 0);
+	umount_tree(real_mount(mnt), &notif,  0);
 	unlock_mount_hash();
+	notify_mounts(&notif);
 	namespace_unlock();
 }
 
@@ -2452,6 +2500,7 @@ static int attach_recursive_mnt(struct mount *source_mnt,
 {
 	struct user_namespace *user_ns = current->nsproxy->mnt_ns->user_ns;
 	HLIST_HEAD(tree_list);
+	LIST_HEAD(notif);
 	struct mnt_namespace *ns = top_mnt->mnt_ns;
 	struct mountpoint *smp;
 	struct mount *child, *dest_mnt, *p;
@@ -2499,6 +2548,7 @@ static int attach_recursive_mnt(struct mount *source_mnt,
 			dest_mp = smp;
 		unhash_mnt(source_mnt);
 		attach_mnt(source_mnt, top_mnt, dest_mp, beneath);
+		queue_notify(source_mnt->mnt_ns, source_mnt, &notif);
 		touch_mnt_namespace(source_mnt->mnt_ns);
 	} else {
 		if (source_mnt->mnt_ns) {
@@ -2513,7 +2563,7 @@ static int attach_recursive_mnt(struct mount *source_mnt,
 			mnt_set_mountpoint_beneath(source_mnt, top_mnt, smp);
 		else
 			mnt_set_mountpoint(dest_mnt, dest_mp, source_mnt);
-		commit_tree(source_mnt);
+		commit_tree(source_mnt, &notif);
 	}
 
 	hlist_for_each_entry_safe(child, n, &tree_list, mnt_hash) {
@@ -2527,10 +2577,11 @@ static int attach_recursive_mnt(struct mount *source_mnt,
 		if (child->mnt_parent->mnt_ns->user_ns != user_ns)
 			lock_mnt_tree(child);
 		child->mnt.mnt_flags &= ~MNT_LOCKED;
-		commit_tree(child);
+		commit_tree(child, &notif);
 	}
 	put_mountpoint(smp);
 	unlock_mount_hash();
+	notify_mounts(&notif);
 
 	return 0;
 
@@ -2538,7 +2589,7 @@ static int attach_recursive_mnt(struct mount *source_mnt,
 	while (!hlist_empty(&tree_list)) {
 		child = hlist_entry(tree_list.first, struct mount, mnt_hash);
 		child->mnt_parent->mnt_ns->pending_mounts = 0;
-		umount_tree(child, UMOUNT_SYNC);
+		umount_tree(child, NULL, UMOUNT_SYNC);
 	}
 	unlock_mount_hash();
 	cleanup_group_ids(source_mnt, NULL);
@@ -2788,7 +2839,7 @@ static int do_loopback(struct path *path, const char *old_name,
 	err = graft_tree(mnt, parent, mp);
 	if (err) {
 		lock_mount_hash();
-		umount_tree(mnt, UMOUNT_SYNC);
+		umount_tree(mnt, NULL, UMOUNT_SYNC);
 		unlock_mount_hash();
 	}
 out2:
@@ -2818,7 +2869,7 @@ static struct file *open_detached_copy(struct path *path, bool recursive)
 
 	lock_mount_hash();
 	for (p = mnt; p; p = next_mnt(p, mnt)) {
-		mnt_add_to_ns(ns, p);
+		mnt_add_to_ns(ns, p, NULL);
 		ns->nr_mounts++;
 	}
 	ns->root = mnt;
@@ -3603,6 +3654,7 @@ void mark_mounts_for_expiry(struct list_head *mounts)
 {
 	struct mount *mnt, *next;
 	LIST_HEAD(graveyard);
+	LIST_HEAD(notif);
 
 	if (list_empty(mounts))
 		return;
@@ -3625,9 +3677,10 @@ void mark_mounts_for_expiry(struct list_head *mounts)
 	while (!list_empty(&graveyard)) {
 		mnt = list_first_entry(&graveyard, struct mount, mnt_expire);
 		touch_mnt_namespace(mnt->mnt_ns);
-		umount_tree(mnt, UMOUNT_PROPAGATE|UMOUNT_SYNC);
+		umount_tree(mnt, &notif, UMOUNT_PROPAGATE|UMOUNT_SYNC);
 	}
 	unlock_mount_hash();
+	notify_mounts(&notif);
 	namespace_unlock();
 }
 
@@ -3685,7 +3738,7 @@ static int select_submounts(struct mount *parent, struct list_head *graveyard)
  *
  * mount_lock must be held for write
  */
-static void shrink_submounts(struct mount *mnt)
+static void shrink_submounts(struct mount *mnt, struct list_head *notif)
 {
 	LIST_HEAD(graveyard);
 	struct mount *m;
@@ -3696,7 +3749,7 @@ static void shrink_submounts(struct mount *mnt)
 			m = list_first_entry(&graveyard, struct mount,
 						mnt_expire);
 			touch_mnt_namespace(m->mnt_ns);
-			umount_tree(m, UMOUNT_PROPAGATE|UMOUNT_SYNC);
+			umount_tree(m, notif, UMOUNT_PROPAGATE|UMOUNT_SYNC);
 		}
 	}
 }
@@ -3964,7 +4017,7 @@ struct mnt_namespace *copy_mnt_ns(unsigned long flags, struct mnt_namespace *ns,
 	p = old;
 	q = new;
 	while (p) {
-		mnt_add_to_ns(new_ns, q);
+		mnt_add_to_ns(new_ns, q, NULL);
 		new_ns->nr_mounts++;
 		if (new_fs) {
 			if (&p->mnt == new_fs->root.mnt) {
@@ -4010,7 +4063,7 @@ struct dentry *mount_subtree(struct vfsmount *m, const char *name)
 	}
 	ns->root = mnt;
 	ns->nr_mounts++;
-	mnt_add_to_ns(ns, mnt);
+	mnt_add_to_ns(ns, mnt, NULL);
 
 	err = vfs_path_lookup(m->mnt_root, m,
 			name, LOOKUP_FOLLOW|LOOKUP_AUTOMOUNT, &path);
@@ -4188,7 +4241,7 @@ SYSCALL_DEFINE3(fsmount, int, fs_fd, unsigned int, flags,
 	mnt = real_mount(newmount.mnt);
 	ns->root = mnt;
 	ns->nr_mounts = 1;
-	mnt_add_to_ns(ns, mnt);
+	mnt_add_to_ns(ns, mnt, NULL);
 	mntget(newmount.mnt);
 
 	/* Attach to an apparent O_PATH fd with a note that we need to unmount
@@ -4414,6 +4467,8 @@ SYSCALL_DEFINE2(pivot_root, const char __user *, new_root,
 	list_del_init(&new_mnt->mnt_expire);
 	put_mountpoint(root_mp);
 	unlock_mount_hash();
+	fsnotify_mnt_move(root_mnt->mnt_ns, &root_mnt->mnt);
+	fsnotify_mnt_move(new_mnt->mnt_ns, &new_mnt->mnt);
 	chroot_fs_refs(&root, &new);
 	error = 0;
 out4:
@@ -5623,7 +5678,7 @@ static void __init init_mount_tree(void)
 	m = real_mount(mnt);
 	ns->root = m;
 	ns->nr_mounts = 1;
-	mnt_add_to_ns(ns, m);
+	mnt_add_to_ns(ns, m, NULL);
 	init_task.nsproxy->mnt_ns = ns;
 	get_mnt_ns(ns);
 
@@ -5863,6 +5918,19 @@ static struct ns_common *mntns_get(struct task_struct *task)
 	return ns;
 }
 
+struct mnt_namespace *get_ns_from_mnt(struct vfsmount *mnt)
+{
+	struct mnt_namespace *ns;
+
+	read_seqlock_excl(&mount_lock);
+	ns = real_mount(mnt)->mnt_ns;
+	if (ns)
+		refcount_inc(&ns->passive);
+	read_sequnlock_excl(&mount_lock);
+
+	return ns;
+}
+
 static void mntns_put(struct ns_common *ns)
 {
 	put_mnt_ns(to_mnt_ns(ns));
diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 24c7c5df4998..39ebc4da1f00 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -166,6 +166,8 @@ static bool fanotify_should_merge(struct fanotify_event *old,
 	case FANOTIFY_EVENT_TYPE_FS_ERROR:
 		return fanotify_error_event_equal(FANOTIFY_EE(old),
 						  FANOTIFY_EE(new));
+	case FANOTIFY_EVENT_TYPE_MNT:
+		return false;
 	default:
 		WARN_ON_ONCE(1);
 	}
@@ -303,17 +305,19 @@ static u32 fanotify_group_event_mask(struct fsnotify_group *group,
 	pr_debug("%s: report_mask=%x mask=%x data=%p data_type=%d\n",
 		 __func__, iter_info->report_mask, event_mask, data, data_type);
 
-	if (!fid_mode) {
-		/* Do we have path to open a file descriptor? */
-		if (!path)
-			return 0;
-		/* Path type events are only relevant for files and dirs */
-		if (!d_is_reg(path->dentry) && !d_can_lookup(path->dentry))
-			return 0;
-	} else if (!(fid_mode & FAN_REPORT_FID)) {
-		/* Do we have a directory inode to report? */
-		if (!dir && !ondir)
-			return 0;
+	if (data_type != FSNOTIFY_EVENT_MNT) {
+		if (!fid_mode) {
+			/* Do we have path to open a file descriptor? */
+			if (!path)
+				return 0;
+			/* Path type events are only relevant for files and dirs */
+			if (!d_is_reg(path->dentry) && !d_can_lookup(path->dentry))
+				return 0;
+		} else if (!(fid_mode & FAN_REPORT_FID)) {
+			/* Do we have a directory inode to report? */
+			if (!dir && !ondir)
+				return 0;
+		}
 	}
 
 	fsnotify_foreach_iter_mark_type(iter_info, mark, type) {
@@ -548,6 +552,20 @@ static struct fanotify_event *fanotify_alloc_path_event(const struct path *path,
 	return &pevent->fae;
 }
 
+static struct fanotify_event *fanotify_alloc_mnt_event(u64 mnt_id, gfp_t gfp)
+{
+	struct fanotify_mnt_event *pevent;
+
+	pevent = kmem_cache_alloc(fanotify_mnt_event_cachep, gfp);
+	if (!pevent)
+		return NULL;
+
+	pevent->fae.type = FANOTIFY_EVENT_TYPE_MNT;
+	pevent->mnt_id = mnt_id;
+
+	return &pevent->fae;
+}
+
 static struct fanotify_event *fanotify_alloc_perm_event(const struct path *path,
 							gfp_t gfp)
 {
@@ -715,6 +733,7 @@ static struct fanotify_event *fanotify_alloc_event(
 					      fid_mode);
 	struct inode *dirid = fanotify_dfid_inode(mask, data, data_type, dir);
 	const struct path *path = fsnotify_data_path(data, data_type);
+	u64 mnt_id = fsnotify_data_mnt_id(data, data_type);
 	struct mem_cgroup *old_memcg;
 	struct dentry *moved = NULL;
 	struct inode *child = NULL;
@@ -810,10 +829,13 @@ static struct fanotify_event *fanotify_alloc_event(
 						  moved, &hash, gfp);
 	} else if (fid_mode) {
 		event = fanotify_alloc_fid_event(id, fsid, &hash, gfp);
-	} else {
+	} else if (path) {
 		event = fanotify_alloc_path_event(path, &hash, gfp);
+	} else /* if (mnt_id) */ {
+		event = fanotify_alloc_mnt_event(mnt_id, gfp);
 	}
 
+
 	if (!event)
 		goto out;
 
@@ -910,7 +932,7 @@ static int fanotify_handle_event(struct fsnotify_group *group, u32 mask,
 	BUILD_BUG_ON(FAN_FS_ERROR != FS_ERROR);
 	BUILD_BUG_ON(FAN_RENAME != FS_RENAME);
 
-	BUILD_BUG_ON(HWEIGHT32(ALL_FANOTIFY_EVENT_BITS) != 21);
+	BUILD_BUG_ON(HWEIGHT32(ALL_FANOTIFY_EVENT_BITS) != 23);
 
 	mask = fanotify_group_event_mask(group, iter_info, &match_mask,
 					 mask, data, data_type, dir);
@@ -1011,6 +1033,11 @@ static void fanotify_free_error_event(struct fsnotify_group *group,
 	mempool_free(fee, &group->fanotify_data.error_events_pool);
 }
 
+static void fanotify_free_mnt_event(struct fanotify_event *event)
+{
+	kmem_cache_free(fanotify_mnt_event_cachep, FANOTIFY_ME(event));
+}
+
 static void fanotify_free_event(struct fsnotify_group *group,
 				struct fsnotify_event *fsn_event)
 {
@@ -1037,6 +1064,9 @@ static void fanotify_free_event(struct fsnotify_group *group,
 	case FANOTIFY_EVENT_TYPE_FS_ERROR:
 		fanotify_free_error_event(group, event);
 		break;
+	case FANOTIFY_EVENT_TYPE_MNT:
+		fanotify_free_mnt_event(event);
+		break;
 	default:
 		WARN_ON_ONCE(1);
 	}
diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
index e5ab33cae6a7..f1a7cbedc9e3 100644
--- a/fs/notify/fanotify/fanotify.h
+++ b/fs/notify/fanotify/fanotify.h
@@ -9,6 +9,7 @@ extern struct kmem_cache *fanotify_mark_cache;
 extern struct kmem_cache *fanotify_fid_event_cachep;
 extern struct kmem_cache *fanotify_path_event_cachep;
 extern struct kmem_cache *fanotify_perm_event_cachep;
+extern struct kmem_cache *fanotify_mnt_event_cachep;
 
 /* Possible states of the permission event */
 enum {
@@ -244,6 +245,7 @@ enum fanotify_event_type {
 	FANOTIFY_EVENT_TYPE_PATH_PERM,
 	FANOTIFY_EVENT_TYPE_OVERFLOW, /* struct fanotify_event */
 	FANOTIFY_EVENT_TYPE_FS_ERROR, /* struct fanotify_error_event */
+	FANOTIFY_EVENT_TYPE_MNT,
 	__FANOTIFY_EVENT_TYPE_NUM
 };
 
@@ -409,12 +411,23 @@ struct fanotify_path_event {
 	struct path path;
 };
 
+struct fanotify_mnt_event {
+	struct fanotify_event fae;
+	u64 mnt_id;
+};
+
 static inline struct fanotify_path_event *
 FANOTIFY_PE(struct fanotify_event *event)
 {
 	return container_of(event, struct fanotify_path_event, fae);
 }
 
+static inline struct fanotify_mnt_event *
+FANOTIFY_ME(struct fanotify_event *event)
+{
+	return container_of(event, struct fanotify_mnt_event, fae);
+}
+
 /*
  * Structure for permission fanotify events. It gets allocated and freed in
  * fanotify_handle_event() since we wait there for user response. When the
@@ -456,6 +469,11 @@ static inline bool fanotify_is_error_event(u32 mask)
 	return mask & FAN_FS_ERROR;
 }
 
+static inline bool fanotify_is_mnt_event(u32 mask)
+{
+	return mask & (FAN_MNT_ATTACH | FAN_MNT_DETACH);
+}
+
 static inline const struct path *fanotify_event_path(struct fanotify_event *event)
 {
 	if (event->type == FANOTIFY_EVENT_TYPE_PATH)
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 2d85c71717d6..83ca8766b791 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -19,6 +19,7 @@
 #include <linux/memcontrol.h>
 #include <linux/statfs.h>
 #include <linux/exportfs.h>
+#include <linux/mnt_namespace.h>
 
 #include <asm/ioctls.h>
 
@@ -114,6 +115,7 @@ struct kmem_cache *fanotify_mark_cache __ro_after_init;
 struct kmem_cache *fanotify_fid_event_cachep __ro_after_init;
 struct kmem_cache *fanotify_path_event_cachep __ro_after_init;
 struct kmem_cache *fanotify_perm_event_cachep __ro_after_init;
+struct kmem_cache *fanotify_mnt_event_cachep __ro_after_init;
 
 #define FANOTIFY_EVENT_ALIGN 4
 #define FANOTIFY_FID_INFO_HDR_LEN \
@@ -122,6 +124,8 @@ struct kmem_cache *fanotify_perm_event_cachep __ro_after_init;
 	sizeof(struct fanotify_event_info_pidfd)
 #define FANOTIFY_ERROR_INFO_LEN \
 	(sizeof(struct fanotify_event_info_error))
+#define FANOTIFY_MNT_INFO_LEN \
+	(sizeof(struct fanotify_event_info_mnt))
 
 static int fanotify_fid_info_len(int fh_len, int name_len)
 {
@@ -183,6 +187,8 @@ static size_t fanotify_event_len(unsigned int info_mode,
 		fh_len = fanotify_event_object_fh_len(event);
 		event_len += fanotify_fid_info_len(fh_len, dot_len);
 	}
+	if (fanotify_is_mnt_event(event->mask))
+		event_len += FANOTIFY_MNT_INFO_LEN;
 
 	return event_len;
 }
@@ -380,6 +386,25 @@ static int process_access_response(struct fsnotify_group *group,
 	return -ENOENT;
 }
 
+static size_t copy_mnt_info_to_user(struct fanotify_event *event,
+				    char __user *buf, int count)
+{
+	struct fanotify_event_info_mnt info = { };
+
+	info.hdr.info_type = FAN_EVENT_INFO_TYPE_MNT;
+	info.hdr.len = FANOTIFY_MNT_INFO_LEN;
+
+	if (WARN_ON(count < info.hdr.len))
+		return -EFAULT;
+
+	info.mnt_id = FANOTIFY_ME(event)->mnt_id;
+
+	if (copy_to_user(buf, &info, sizeof(info)))
+		return -EFAULT;
+
+	return info.hdr.len;
+}
+
 static size_t copy_error_info_to_user(struct fanotify_event *event,
 				      char __user *buf, int count)
 {
@@ -642,6 +667,14 @@ static int copy_info_records_to_user(struct fanotify_event *event,
 		total_bytes += ret;
 	}
 
+	if (fanotify_is_mnt_event(event->mask)) {
+		ret = copy_mnt_info_to_user(event, buf, count);
+		if (ret < 0)
+			return ret;
+		buf += ret;
+		count -= ret;
+		total_bytes += ret;
+	}
 	return total_bytes;
 }
 
@@ -1449,6 +1482,8 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
 	if (event_f_flags & ~FANOTIFY_INIT_ALL_EVENT_F_BITS)
 		return -EINVAL;
 
+	/* FIXME: check FAN_REPORT_MNT compatibility with other flags */
+
 	switch (event_f_flags & O_ACCMODE) {
 	case O_RDONLY:
 	case O_RDWR:
@@ -1688,6 +1723,7 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 	struct vfsmount *mnt = NULL;
 	struct fsnotify_group *group;
 	struct path path;
+	struct mnt_namespace *mntns = NULL;
 	struct fan_fsid __fsid, *fsid = NULL;
 	u32 valid_mask = FANOTIFY_EVENTS | FANOTIFY_EVENT_FLAGS;
 	unsigned int mark_type = flags & FANOTIFY_MARK_TYPE_BITS;
@@ -1718,6 +1754,9 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 	case FAN_MARK_FILESYSTEM:
 		obj_type = FSNOTIFY_OBJ_TYPE_SB;
 		break;
+	case FAN_MARK_MNTNS:
+		obj_type = FSNOTIFY_OBJ_TYPE_MNTNS;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -1742,7 +1781,6 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 	if (mask & ~valid_mask)
 		return -EINVAL;
 
-
 	/* We don't allow FAN_MARK_IGNORE & FAN_MARK_IGNORED_MASK together */
 	if (ignore == (FAN_MARK_IGNORE | FAN_MARK_IGNORED_MASK))
 		return -EINVAL;
@@ -1765,6 +1803,19 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 		return -EINVAL;
 	group = fd_file(f)->private_data;
 
+	/* Only report mount events on mnt namespace */
+	if (FAN_GROUP_FLAG(group, FAN_REPORT_MNT)) {
+		if (mask & ~FANOTIFY_MOUNT_EVENTS)
+			return -EINVAL;
+		if (mark_type != FAN_MARK_MNTNS)
+			return -EINVAL;
+	} else {
+		if (mask & FANOTIFY_MOUNT_EVENTS)
+			return -EINVAL;
+		if (mark_type == FAN_MARK_MNTNS)
+			return -EINVAL;
+	}
+
 	/*
 	 * An unprivileged user is not allowed to setup mount nor filesystem
 	 * marks.  This also includes setting up such marks by a group that
@@ -1855,8 +1906,18 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 		mnt = path.mnt;
 		if (mark_type == FAN_MARK_MOUNT)
 			obj = mnt;
-		else
+		else if (mark_type == FAN_MARK_FILESYSTEM)
 			obj = mnt->mnt_sb;
+		else /* if (mark_type == FAN_MARK_MNTNS) */ {
+			mntns = get_ns_from_mnt(mnt);
+			ret = -EINVAL;
+			if (!mntns)
+				goto path_put_and_out;
+			/* don't allow anon ns yet */
+			if (is_anon_ns(mntns))
+				goto path_put_and_out;
+			obj = mntns;
+		}
 	}
 
 	/*
@@ -1905,6 +1966,8 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 	}
 
 path_put_and_out:
+	if (mntns)
+		mnt_ns_release(mntns);
 	path_put(&path);
 	return ret;
 }
@@ -1952,7 +2015,7 @@ static int __init fanotify_user_setup(void)
 				     FANOTIFY_DEFAULT_MAX_USER_MARKS);
 
 	BUILD_BUG_ON(FANOTIFY_INIT_FLAGS & FANOTIFY_INTERNAL_GROUP_FLAGS);
-	BUILD_BUG_ON(HWEIGHT32(FANOTIFY_INIT_FLAGS) != 13);
+	BUILD_BUG_ON(HWEIGHT32(FANOTIFY_INIT_FLAGS) != 14);
 	BUILD_BUG_ON(HWEIGHT32(FANOTIFY_MARK_FLAGS) != 11);
 
 	fanotify_mark_cache = KMEM_CACHE(fanotify_mark,
@@ -1965,6 +2028,7 @@ static int __init fanotify_user_setup(void)
 		fanotify_perm_event_cachep =
 			KMEM_CACHE(fanotify_perm_event, SLAB_PANIC);
 	}
+	fanotify_mnt_event_cachep = KMEM_CACHE(fanotify_mnt_event, SLAB_PANIC);
 
 	fanotify_max_queued_events = FANOTIFY_DEFAULT_MAX_EVENTS;
 	init_user_ns.ucount_max[UCOUNT_FANOTIFY_GROUPS] =
diff --git a/fs/notify/fdinfo.c b/fs/notify/fdinfo.c
index dec553034027..505aabd62abb 100644
--- a/fs/notify/fdinfo.c
+++ b/fs/notify/fdinfo.c
@@ -123,6 +123,8 @@ static void fanotify_fdinfo(struct seq_file *m, struct fsnotify_mark *mark)
 
 		seq_printf(m, "fanotify sdev:%x mflags:%x mask:%x ignored_mask:%x\n",
 			   sb->s_dev, mflags, mark->mask, mark->ignore_mask);
+	} else if (mark->connector->type == FSNOTIFY_OBJ_TYPE_MNTNS) {
+		/* FIXME: print info for mntns */
 	}
 }
 
diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index f976949d2634..61159c623df5 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -28,6 +28,11 @@ void __fsnotify_vfsmount_delete(struct vfsmount *mnt)
 	fsnotify_clear_marks_by_mount(mnt);
 }
 
+void __fsnotify_mntns_delete(struct mnt_namespace *mntns)
+{
+	fsnotify_clear_marks_by_mntns(mntns);
+}
+
 /**
  * fsnotify_unmount_inodes - an sb is unmounting.  handle any watched inodes.
  * @sb: superblock being unmounted.
@@ -402,7 +407,7 @@ static int send_to_group(__u32 mask, const void *data, int data_type,
 				     file_name, cookie, iter_info);
 }
 
-static struct fsnotify_mark *fsnotify_first_mark(struct fsnotify_mark_connector **connp)
+static struct fsnotify_mark *fsnotify_first_mark(struct fsnotify_mark_connector *const *connp)
 {
 	struct fsnotify_mark_connector *conn;
 	struct hlist_node *node = NULL;
@@ -520,14 +525,15 @@ int fsnotify(__u32 mask, const void *data, int data_type, struct inode *dir,
 {
 	const struct path *path = fsnotify_data_path(data, data_type);
 	struct super_block *sb = fsnotify_data_sb(data, data_type);
-	struct fsnotify_sb_info *sbinfo = fsnotify_sb_info(sb);
+	const struct fsnotify_mnt *mnt_data = fsnotify_data_mnt(data, data_type);
+	struct fsnotify_sb_info *sbinfo = sb ? fsnotify_sb_info(sb) : NULL;
 	struct fsnotify_iter_info iter_info = {};
 	struct mount *mnt = NULL;
 	struct inode *inode2 = NULL;
 	struct dentry *moved;
 	int inode2_type;
 	int ret = 0;
-	__u32 test_mask, marks_mask;
+	__u32 test_mask, marks_mask = 0;
 
 	if (path)
 		mnt = real_mount(path->mnt);
@@ -560,17 +566,20 @@ int fsnotify(__u32 mask, const void *data, int data_type, struct inode *dir,
 	if ((!sbinfo || !sbinfo->sb_marks) &&
 	    (!mnt || !mnt->mnt_fsnotify_marks) &&
 	    (!inode || !inode->i_fsnotify_marks) &&
-	    (!inode2 || !inode2->i_fsnotify_marks))
+	    (!inode2 || !inode2->i_fsnotify_marks) &&
+	    (!mnt_data || !mnt_data->ns->n_fsnotify_marks))
 		return 0;
 
-	marks_mask = READ_ONCE(sb->s_fsnotify_mask);
+	if (sb)
+		marks_mask |= READ_ONCE(sb->s_fsnotify_mask);
 	if (mnt)
 		marks_mask |= READ_ONCE(mnt->mnt_fsnotify_mask);
 	if (inode)
 		marks_mask |= READ_ONCE(inode->i_fsnotify_mask);
 	if (inode2)
 		marks_mask |= READ_ONCE(inode2->i_fsnotify_mask);
-
+	if (mnt_data)
+		marks_mask |= READ_ONCE(mnt_data->ns->n_fsnotify_mask);
 
 	/*
 	 * If this is a modify event we may need to clear some ignore masks.
@@ -600,6 +609,10 @@ int fsnotify(__u32 mask, const void *data, int data_type, struct inode *dir,
 		iter_info.marks[inode2_type] =
 			fsnotify_first_mark(&inode2->i_fsnotify_marks);
 	}
+	if (mnt_data) {
+		iter_info.marks[FSNOTIFY_ITER_TYPE_MNTNS] =
+			fsnotify_first_mark(&mnt_data->ns->n_fsnotify_marks);
+	}
 
 	/*
 	 * We need to merge inode/vfsmount/sb mark lists so that e.g. inode mark
@@ -623,11 +636,28 @@ int fsnotify(__u32 mask, const void *data, int data_type, struct inode *dir,
 }
 EXPORT_SYMBOL_GPL(fsnotify);
 
+void fsnotify_mnt(__u32 mask, struct mnt_namespace *ns, struct vfsmount *mnt)
+{
+	struct fsnotify_mnt data = {
+		.ns = ns,
+		.mnt_id = real_mount(mnt)->mnt_id_unique,
+	};
+
+	if (WARN_ON_ONCE(!ns))
+		return;
+
+	/* FIXME: is this the proper way to check if fsnotify_init() ran? */
+	if (!fsnotify_mark_connector_cachep)
+		return;
+
+	fsnotify(mask, &data, FSNOTIFY_EVENT_MNT, NULL, NULL, NULL, 0);
+}
+
 static __init int fsnotify_init(void)
 {
 	int ret;
 
-	BUILD_BUG_ON(HWEIGHT32(ALL_FSNOTIFY_BITS) != 23);
+	BUILD_BUG_ON(HWEIGHT32(ALL_FSNOTIFY_BITS) != 25);
 
 	ret = init_srcu_struct(&fsnotify_mark_srcu);
 	if (ret)
diff --git a/fs/notify/fsnotify.h b/fs/notify/fsnotify.h
index 663759ed6fbc..5950c7a67f41 100644
--- a/fs/notify/fsnotify.h
+++ b/fs/notify/fsnotify.h
@@ -33,6 +33,12 @@ static inline struct super_block *fsnotify_conn_sb(
 	return conn->obj;
 }
 
+static inline struct mnt_namespace *fsnotify_conn_mntns(
+				struct fsnotify_mark_connector *conn)
+{
+	return conn->obj;
+}
+
 static inline struct super_block *fsnotify_object_sb(void *obj,
 			enum fsnotify_obj_type obj_type)
 {
@@ -89,6 +95,11 @@ static inline void fsnotify_clear_marks_by_sb(struct super_block *sb)
 	fsnotify_destroy_marks(fsnotify_sb_marks(sb));
 }
 
+static inline void fsnotify_clear_marks_by_mntns(struct mnt_namespace *mntns)
+{
+	fsnotify_destroy_marks(&mntns->n_fsnotify_marks);
+}
+
 /*
  * update the dentry->d_flags of all of inode's children to indicate if inode cares
  * about events that happen to its children.
diff --git a/fs/notify/mark.c b/fs/notify/mark.c
index 4981439e6209..798340db69d7 100644
--- a/fs/notify/mark.c
+++ b/fs/notify/mark.c
@@ -107,6 +107,8 @@ static fsnotify_connp_t *fsnotify_object_connp(void *obj,
 		return &real_mount(obj)->mnt_fsnotify_marks;
 	case FSNOTIFY_OBJ_TYPE_SB:
 		return fsnotify_sb_marks(obj);
+	case FSNOTIFY_OBJ_TYPE_MNTNS:
+		return &((struct mnt_namespace *)obj)->n_fsnotify_marks;
 	default:
 		return NULL;
 	}
@@ -120,6 +122,8 @@ static __u32 *fsnotify_conn_mask_p(struct fsnotify_mark_connector *conn)
 		return &fsnotify_conn_mount(conn)->mnt_fsnotify_mask;
 	else if (conn->type == FSNOTIFY_OBJ_TYPE_SB)
 		return &fsnotify_conn_sb(conn)->s_fsnotify_mask;
+	else if (conn->type == FSNOTIFY_OBJ_TYPE_MNTNS)
+		return &fsnotify_conn_mntns(conn)->n_fsnotify_mask;
 	return NULL;
 }
 
@@ -346,12 +350,15 @@ static void *fsnotify_detach_connector_from_object(
 		fsnotify_conn_mount(conn)->mnt_fsnotify_mask = 0;
 	} else if (conn->type == FSNOTIFY_OBJ_TYPE_SB) {
 		fsnotify_conn_sb(conn)->s_fsnotify_mask = 0;
+	} else if (conn->type == FSNOTIFY_OBJ_TYPE_MNTNS) {
+		fsnotify_conn_mntns(conn)->n_fsnotify_mask = 0;
 	}
 
 	rcu_assign_pointer(*connp, NULL);
 	conn->obj = NULL;
 	conn->type = FSNOTIFY_OBJ_TYPE_DETACHED;
-	fsnotify_update_sb_watchers(sb, conn);
+	if (sb)
+		fsnotify_update_sb_watchers(sb, conn);
 
 	return inode;
 }
@@ -724,7 +731,7 @@ static int fsnotify_add_mark_list(struct fsnotify_mark *mark, void *obj,
 	 * Attach the sb info before attaching a connector to any object on sb.
 	 * The sb info will remain attached as long as sb lives.
 	 */
-	if (!fsnotify_sb_info(sb)) {
+	if (sb && !fsnotify_sb_info(sb)) {
 		err = fsnotify_attach_info_to_sb(sb);
 		if (err)
 			return err;
@@ -770,7 +777,8 @@ static int fsnotify_add_mark_list(struct fsnotify_mark *mark, void *obj,
 	/* mark should be the last entry.  last is the current last entry */
 	hlist_add_behind_rcu(&mark->obj_list, &last->obj_list);
 added:
-	fsnotify_update_sb_watchers(sb, conn);
+	if (sb)
+		fsnotify_update_sb_watchers(sb, conn);
 	/*
 	 * Since connector is attached to object using cmpxchg() we are
 	 * guaranteed that connector initialization is fully visible by anyone
diff --git a/fs/pnode.c b/fs/pnode.c
index a799e0315cc9..203276b1e23f 100644
--- a/fs/pnode.c
+++ b/fs/pnode.c
@@ -549,8 +549,10 @@ static void restore_mounts(struct list_head *to_restore)
 			mp = parent->mnt_mp;
 			parent = parent->mnt_parent;
 		}
-		if (parent != mnt->mnt_parent)
+		if (parent != mnt->mnt_parent) {
+			/* FIXME: does this need to trigger a MOVE fsnotify event */
 			mnt_change_mountpoint(parent, mp, mnt);
+		}
 	}
 }
 
diff --git a/include/linux/fanotify.h b/include/linux/fanotify.h
index 89ff45bd6f01..801af8012730 100644
--- a/include/linux/fanotify.h
+++ b/include/linux/fanotify.h
@@ -25,7 +25,7 @@
 
 #define FANOTIFY_FID_BITS	(FAN_REPORT_DFID_NAME_TARGET)
 
-#define FANOTIFY_INFO_MODES	(FANOTIFY_FID_BITS | FAN_REPORT_PIDFD)
+#define FANOTIFY_INFO_MODES	(FANOTIFY_FID_BITS | FAN_REPORT_PIDFD | FAN_REPORT_MNT)
 
 /*
  * fanotify_init() flags that require CAP_SYS_ADMIN.
@@ -38,7 +38,8 @@
 					 FAN_REPORT_PIDFD | \
 					 FAN_REPORT_FD_ERROR | \
 					 FAN_UNLIMITED_QUEUE | \
-					 FAN_UNLIMITED_MARKS)
+					 FAN_UNLIMITED_MARKS | \
+					 FAN_REPORT_MNT)
 
 /*
  * fanotify_init() flags that are allowed for user without CAP_SYS_ADMIN.
@@ -58,7 +59,7 @@
 #define FANOTIFY_INTERNAL_GROUP_FLAGS	(FANOTIFY_UNPRIV)
 
 #define FANOTIFY_MARK_TYPE_BITS	(FAN_MARK_INODE | FAN_MARK_MOUNT | \
-				 FAN_MARK_FILESYSTEM)
+				 FAN_MARK_FILESYSTEM | FAN_MARK_MNTNS)
 
 #define FANOTIFY_MARK_CMD_BITS	(FAN_MARK_ADD | FAN_MARK_REMOVE | \
 				 FAN_MARK_FLUSH)
@@ -90,7 +91,7 @@
 				 FAN_RENAME)
 
 /* Events that can be reported with event->fd */
-#define FANOTIFY_FD_EVENTS (FANOTIFY_PATH_EVENTS | FANOTIFY_PERM_EVENTS)
+#define FANOTIFY_FD_EVENTS (FANOTIFY_PATH_EVENTS | FANOTIFY_PERM_EVENTS | FANOTIFY_MOUNT_EVENTS)
 
 /* Events that can only be reported with data type FSNOTIFY_EVENT_INODE */
 #define FANOTIFY_INODE_EVENTS	(FANOTIFY_DIRENT_EVENTS | \
@@ -99,10 +100,13 @@
 /* Events that can only be reported with data type FSNOTIFY_EVENT_ERROR */
 #define FANOTIFY_ERROR_EVENTS	(FAN_FS_ERROR)
 
+#define FANOTIFY_MOUNT_EVENTS	(FAN_MNT_ATTACH | FAN_MNT_DETACH)
+
 /* Events that user can request to be notified on */
 #define FANOTIFY_EVENTS		(FANOTIFY_PATH_EVENTS | \
 				 FANOTIFY_INODE_EVENTS | \
-				 FANOTIFY_ERROR_EVENTS)
+				 FANOTIFY_ERROR_EVENTS | \
+				 FANOTIFY_MOUNT_EVENTS )
 
 /* Events that require a permission response from user */
 #define FANOTIFY_PERM_EVENTS	(FAN_OPEN_PERM | FAN_ACCESS_PERM | \
diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
index 278620e063ab..ea998551dd0d 100644
--- a/include/linux/fsnotify.h
+++ b/include/linux/fsnotify.h
@@ -255,6 +255,11 @@ static inline void fsnotify_vfsmount_delete(struct vfsmount *mnt)
 	__fsnotify_vfsmount_delete(mnt);
 }
 
+static inline void fsnotify_mntns_delete(struct mnt_namespace *mntns)
+{
+	__fsnotify_mntns_delete(mntns);
+}
+
 /*
  * fsnotify_inoderemove - an inode is going away
  */
@@ -463,4 +468,19 @@ static inline int fsnotify_sb_error(struct super_block *sb, struct inode *inode,
 			NULL, NULL, NULL, 0);
 }
 
+static inline void fsnotify_mnt_attach(struct mnt_namespace *ns, struct vfsmount *mnt)
+{
+	fsnotify_mnt(FS_MNT_ATTACH, ns, mnt);
+}
+
+static inline void fsnotify_mnt_detach(struct mnt_namespace *ns, struct vfsmount *mnt)
+{
+	fsnotify_mnt(FS_MNT_DETACH, ns, mnt);
+}
+
+static inline void fsnotify_mnt_move(struct mnt_namespace *ns, struct vfsmount *mnt)
+{
+	fsnotify_mnt(FS_MNT_MOVE, ns, mnt);
+}
+
 #endif	/* _LINUX_FS_NOTIFY_H */
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index 3ecf7768e577..11e33498a315 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -56,6 +56,10 @@
 #define FS_ACCESS_PERM		0x00020000	/* access event in a permissions hook */
 #define FS_OPEN_EXEC_PERM	0x00040000	/* open/exec event in a permission hook */
 
+#define FS_MNT_ATTACH		0x00100000	/* Mount was attached */
+#define FS_MNT_DETACH		0x00200000	/* Mount was detached */
+#define FS_MNT_MOVE		(FS_MNT_ATTACH | FS_MNT_DETACH)
+
 /*
  * Set on inode mark that cares about things that happen to its children.
  * Always set for dnotify and inotify.
@@ -102,7 +106,7 @@
 			     FS_EVENTS_POSS_ON_CHILD | \
 			     FS_DELETE_SELF | FS_MOVE_SELF | \
 			     FS_UNMOUNT | FS_Q_OVERFLOW | FS_IN_IGNORED | \
-			     FS_ERROR)
+			     FS_ERROR | FS_MNT_ATTACH | FS_MNT_DETACH)
 
 /* Extra flags that may be reported with event or control handling of events */
 #define ALL_FSNOTIFY_FLAGS  (FS_ISDIR | FS_EVENT_ON_CHILD | FS_DN_MULTISHOT)
@@ -288,6 +292,7 @@ enum fsnotify_data_type {
 	FSNOTIFY_EVENT_PATH,
 	FSNOTIFY_EVENT_INODE,
 	FSNOTIFY_EVENT_DENTRY,
+	FSNOTIFY_EVENT_MNT,
 	FSNOTIFY_EVENT_ERROR,
 };
 
@@ -297,6 +302,11 @@ struct fs_error_report {
 	struct super_block *sb;
 };
 
+struct fsnotify_mnt {
+	const struct mnt_namespace *ns;
+	u64 mnt_id;
+};
+
 static inline struct inode *fsnotify_data_inode(const void *data, int data_type)
 {
 	switch (data_type) {
@@ -354,6 +364,24 @@ static inline struct super_block *fsnotify_data_sb(const void *data,
 	}
 }
 
+static inline const struct fsnotify_mnt *fsnotify_data_mnt(const void *data,
+							   int data_type)
+{
+	switch (data_type) {
+	case FSNOTIFY_EVENT_MNT:
+		return data;
+	default:
+		return NULL;
+	}
+}
+
+static inline u64 fsnotify_data_mnt_id(const void *data, int data_type)
+{
+	const struct fsnotify_mnt *mnt_data = fsnotify_data_mnt(data, data_type);
+
+	return mnt_data ? mnt_data->mnt_id : 0;
+}
+
 static inline struct fs_error_report *fsnotify_data_error_report(
 							const void *data,
 							int data_type)
@@ -379,6 +407,7 @@ enum fsnotify_iter_type {
 	FSNOTIFY_ITER_TYPE_SB,
 	FSNOTIFY_ITER_TYPE_PARENT,
 	FSNOTIFY_ITER_TYPE_INODE2,
+	FSNOTIFY_ITER_TYPE_MNTNS,
 	FSNOTIFY_ITER_TYPE_COUNT
 };
 
@@ -388,6 +417,7 @@ enum fsnotify_obj_type {
 	FSNOTIFY_OBJ_TYPE_INODE,
 	FSNOTIFY_OBJ_TYPE_VFSMOUNT,
 	FSNOTIFY_OBJ_TYPE_SB,
+	FSNOTIFY_OBJ_TYPE_MNTNS,
 	FSNOTIFY_OBJ_TYPE_COUNT,
 	FSNOTIFY_OBJ_TYPE_DETACHED = FSNOTIFY_OBJ_TYPE_COUNT
 };
@@ -572,8 +602,10 @@ extern int __fsnotify_parent(struct dentry *dentry, __u32 mask, const void *data
 extern void __fsnotify_inode_delete(struct inode *inode);
 extern void __fsnotify_vfsmount_delete(struct vfsmount *mnt);
 extern void fsnotify_sb_delete(struct super_block *sb);
+extern void __fsnotify_mntns_delete(struct mnt_namespace *mntns);
 extern void fsnotify_sb_free(struct super_block *sb);
 extern u32 fsnotify_get_cookie(void);
+extern void fsnotify_mnt(__u32 mask, struct mnt_namespace *ns, struct vfsmount *mnt);
 
 static inline __u32 fsnotify_parent_needed_mask(__u32 mask)
 {
@@ -879,6 +911,9 @@ static inline void __fsnotify_vfsmount_delete(struct vfsmount *mnt)
 static inline void fsnotify_sb_delete(struct super_block *sb)
 {}
 
+static inline void fsnotify_mntns_delete(struct mnt_namespace *mntns)
+{}
+
 static inline void fsnotify_sb_free(struct super_block *sb)
 {}
 
@@ -893,6 +928,9 @@ static inline u32 fsnotify_get_cookie(void)
 static inline void fsnotify_unmount_inodes(struct super_block *sb)
 {}
 
+static inline void fsnotify_mnt(__u32 mask, struct mnt_namespace *ns, struct vfsmount *mnt)
+{}
+
 #endif	/* CONFIG_FSNOTIFY */
 
 #endif	/* __KERNEL __ */
diff --git a/include/linux/mnt_namespace.h b/include/linux/mnt_namespace.h
index 70b366b64816..e182f569464c 100644
--- a/include/linux/mnt_namespace.h
+++ b/include/linux/mnt_namespace.h
@@ -10,6 +10,7 @@ struct mnt_namespace;
 struct fs_struct;
 struct user_namespace;
 struct ns_common;
+struct vfsmount;
 
 extern struct mnt_namespace *copy_mnt_ns(unsigned long, struct mnt_namespace *,
 		struct user_namespace *, struct fs_struct *);
@@ -17,6 +18,10 @@ extern void put_mnt_ns(struct mnt_namespace *ns);
 DEFINE_FREE(put_mnt_ns, struct mnt_namespace *, if (!IS_ERR_OR_NULL(_T)) put_mnt_ns(_T))
 extern struct ns_common *from_mnt_ns(struct mnt_namespace *);
 
+/* Gets namespace from mount.  Release with mnt_ns_release(). */
+extern struct mnt_namespace *get_ns_from_mnt(struct vfsmount *mnt);
+extern void mnt_ns_release(struct mnt_namespace *ns);
+
 extern const struct file_operations proc_mounts_operations;
 extern const struct file_operations proc_mountinfo_operations;
 extern const struct file_operations proc_mountstats_operations;
diff --git a/include/uapi/linux/fanotify.h b/include/uapi/linux/fanotify.h
index 34f221d3a1b9..332ef8532390 100644
--- a/include/uapi/linux/fanotify.h
+++ b/include/uapi/linux/fanotify.h
@@ -25,6 +25,8 @@
 #define FAN_OPEN_PERM		0x00010000	/* File open in perm check */
 #define FAN_ACCESS_PERM		0x00020000	/* File accessed in perm check */
 #define FAN_OPEN_EXEC_PERM	0x00040000	/* File open/exec in perm check */
+#define FAN_MNT_ATTACH		0x00100000	/* Mount was attached */
+#define FAN_MNT_DETACH		0x00200000	/* Mount was detached */
 
 #define FAN_EVENT_ON_CHILD	0x08000000	/* Interested in child events */
 
@@ -61,6 +63,7 @@
 #define FAN_REPORT_NAME		0x00000800	/* Report events with name */
 #define FAN_REPORT_TARGET_FID	0x00001000	/* Report dirent target id  */
 #define FAN_REPORT_FD_ERROR	0x00002000	/* event->fd can report error */
+#define FAN_REPORT_MNT		0x00004000	/* Report mount events */
 
 /* Convenience macro - FAN_REPORT_NAME requires FAN_REPORT_DIR_FID */
 #define FAN_REPORT_DFID_NAME	(FAN_REPORT_DIR_FID | FAN_REPORT_NAME)
@@ -91,6 +94,7 @@
 #define FAN_MARK_INODE		0x00000000
 #define FAN_MARK_MOUNT		0x00000010
 #define FAN_MARK_FILESYSTEM	0x00000100
+#define FAN_MARK_MNTNS		0x00000110
 
 /*
  * Convenience macro - FAN_MARK_IGNORE requires FAN_MARK_IGNORED_SURV_MODIFY
@@ -143,6 +147,7 @@ struct fanotify_event_metadata {
 #define FAN_EVENT_INFO_TYPE_DFID	3
 #define FAN_EVENT_INFO_TYPE_PIDFD	4
 #define FAN_EVENT_INFO_TYPE_ERROR	5
+#define FAN_EVENT_INFO_TYPE_MNT		6
 
 /* Special info types for FAN_RENAME */
 #define FAN_EVENT_INFO_TYPE_OLD_DFID_NAME	10
@@ -189,6 +194,11 @@ struct fanotify_event_info_error {
 	__u32 error_count;
 };
 
+struct fanotify_event_info_mnt {
+	struct fanotify_event_info_header hdr;
+	__u64 mnt_id;
+};
+
 /*
  * User space may need to record additional information about its decision.
  * The extra information type records what kind of information is included.
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index f5a08f94e094..76cf040d8d96 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3395,6 +3395,10 @@ static int selinux_path_notify(const struct path *path, u64 mask,
 	case FSNOTIFY_OBJ_TYPE_INODE:
 		perm = FILE__WATCH;
 		break;
+	case FSNOTIFY_OBJ_TYPE_MNTNS:
+		/* FIXME: Is this correct??? */
+		perm = FILE__WATCH_MOUNT;
+		break;
 	default:
 		return -EINVAL;
 	}
-- 
2.47.0


