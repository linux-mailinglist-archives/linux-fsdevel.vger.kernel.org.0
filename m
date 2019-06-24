Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4DB50D6C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2019 16:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730091AbfFXOKQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jun 2019 10:10:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54500 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727736AbfFXOKP (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jun 2019 10:10:15 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DA2A58F91B;
        Mon, 24 Jun 2019 14:10:14 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-57.rdu2.redhat.com [10.10.120.57])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 637231001B07;
        Mon, 24 Jun 2019 14:10:11 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 09/25] vfs: Add mount notification count [ver #14]
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, raven@themaw.net, mszeredi@redhat.com,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 24 Jun 2019 15:10:06 +0100
Message-ID: <156138540611.25627.13279299200070977180.stgit@warthog.procyon.org.uk>
In-Reply-To: <156138532485.25627.7459410522109581052.stgit@warthog.procyon.org.uk>
References: <156138532485.25627.7459410522109581052.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Mon, 24 Jun 2019 14:10:14 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a notification count on mount objects so that the user can easily check
to see if a mount has changed its attributes or its children.

Future patches will:

 (1) Provide this value through fsinfo() attributes.

 (2) Hook into the notify_mount() function to provide a notification
     interface for userspace to monitor.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/mount.h     |   22 ++++++++++++++++++++++
 fs/namespace.c |   13 +++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/fs/mount.h b/fs/mount.h
index 6250de544760..47795802f78e 100644
--- a/fs/mount.h
+++ b/fs/mount.h
@@ -70,6 +70,7 @@ struct mount {
 	struct hlist_head mnt_pins;
 	struct fs_pin mnt_umount;
 	struct dentry *mnt_ex_mountpoint;
+	atomic_t mnt_notify_counter;	/* Number of notifications generated */
 } __randomize_layout;
 
 #define MNT_NS_INTERNAL ERR_PTR(-EINVAL) /* distinct from any mnt_namespace */
@@ -151,3 +152,24 @@ static inline bool is_anon_ns(struct mnt_namespace *ns)
 {
 	return ns->seq == 0;
 }
+
+/*
+ * Type of mount topology change notification.
+ */
+enum mount_notification_subtype {
+	NOTIFY_MOUNT_NEW_MOUNT	= 0, /* New mount added */
+	NOTIFY_MOUNT_UNMOUNT	= 1, /* Mount removed manually */
+	NOTIFY_MOUNT_EXPIRY	= 2, /* Automount expired */
+	NOTIFY_MOUNT_READONLY	= 3, /* Mount R/O state changed */
+	NOTIFY_MOUNT_SETATTR	= 4, /* Mount attributes changed */
+	NOTIFY_MOUNT_MOVE_FROM	= 5, /* Mount moved from here */
+	NOTIFY_MOUNT_MOVE_TO	= 6, /* Mount moved to here (compare op_id) */
+};
+
+static inline void notify_mount(struct mount *changed,
+				struct mount *aux,
+				enum mount_notification_subtype subtype,
+				u32 info_flags)
+{
+	atomic_inc(&changed->mnt_notify_counter);
+}
diff --git a/fs/namespace.c b/fs/namespace.c
index a49a7d9ed482..1450faab96b9 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -513,6 +513,8 @@ static int mnt_make_readonly(struct mount *mnt)
 	smp_wmb();
 	mnt->mnt.mnt_flags &= ~MNT_WRITE_HOLD;
 	unlock_mount_hash();
+	if (ret == 0)
+		notify_mount(mnt, NULL, NOTIFY_MOUNT_READONLY, 0x10000);
 	return ret;
 }
 
@@ -521,6 +523,7 @@ static int __mnt_unmake_readonly(struct mount *mnt)
 	lock_mount_hash();
 	mnt->mnt.mnt_flags &= ~MNT_READONLY;
 	unlock_mount_hash();
+	notify_mount(mnt, NULL, NOTIFY_MOUNT_READONLY, 0);
 	return 0;
 }
 
@@ -833,6 +836,7 @@ static void umount_mnt(struct mount *mnt)
 {
 	/* old mountpoint will be dropped when we can do that */
 	mnt->mnt_ex_mountpoint = mnt->mnt_mountpoint;
+	notify_mount(mnt->mnt_parent, mnt, NOTIFY_MOUNT_UNMOUNT, 0);
 	unhash_mnt(mnt);
 }
 
@@ -1472,6 +1476,7 @@ static void umount_tree(struct mount *mnt, enum umount_tree_flags how)
 		p = list_first_entry(&tmp_list, struct mount, mnt_list);
 		list_del_init(&p->mnt_expire);
 		list_del_init(&p->mnt_list);
+
 		ns = p->mnt_ns;
 		if (ns) {
 			ns->mounts--;
@@ -2095,7 +2100,10 @@ static int attach_recursive_mnt(struct mount *source_mnt,
 		lock_mount_hash();
 	}
 	if (parent_path) {
+		notify_mount(source_mnt->mnt_parent, source_mnt,
+			     NOTIFY_MOUNT_MOVE_FROM, 0);
 		detach_mnt(source_mnt, parent_path);
+		notify_mount(dest_mnt, source_mnt, NOTIFY_MOUNT_MOVE_TO, 0);
 		attach_mnt(source_mnt, dest_mnt, dest_mp);
 		touch_mnt_namespace(source_mnt->mnt_ns);
 	} else {
@@ -2104,6 +2112,9 @@ static int attach_recursive_mnt(struct mount *source_mnt,
 			list_del_init(&source_mnt->mnt_ns->list);
 		}
 		mnt_set_mountpoint(dest_mnt, dest_mp, source_mnt);
+		notify_mount(dest_mnt, source_mnt, NOTIFY_MOUNT_NEW_MOUNT,
+			     source_mnt->mnt.mnt_sb->s_flags & SB_SUBMOUNT ?
+			     0x10000 : 0);
 		commit_tree(source_mnt);
 	}
 
@@ -2480,6 +2491,7 @@ static void set_mount_attributes(struct mount *mnt, unsigned int mnt_flags)
 	mnt->mnt.mnt_flags = mnt_flags;
 	touch_mnt_namespace(mnt->mnt_ns);
 	unlock_mount_hash();
+	notify_mount(mnt, NULL, NOTIFY_MOUNT_SETATTR, 0);
 }
 
 /*
@@ -2880,6 +2892,7 @@ void mark_mounts_for_expiry(struct list_head *mounts)
 		if (!xchg(&mnt->mnt_expiry_mark, 1) ||
 			propagate_mount_busy(mnt, 1))
 			continue;
+		notify_mount(mnt, NULL, NOTIFY_MOUNT_EXPIRY, 0);
 		list_move(&mnt->mnt_expire, &graveyard);
 	}
 	while (!list_empty(&graveyard)) {

