Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B86AE162B55
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2020 18:05:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbgBRRFg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Feb 2020 12:05:36 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26359 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726691AbgBRRFg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Feb 2020 12:05:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582045535;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rUJs8Zj28w93DvfIGBtggizGKKh0nmCWJIHhWfYwyVU=;
        b=MvS9C3NldVyEJXTbpr4gpv43YGXxH0Il4JwuV5PWxVzBEX+Aj7455gjXl/76n7lc4MPzMD
        K/75KbAGFJNkysIJqVtp/2aly57yob26F53lZAsQBP3IC/hmmrUEtTJaDLueB3VgBS/8pS
        /0nGGE9ZxOADW054wg2moYPvzLNIQEw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-357-BRZu2SaqPRSrYRN2-4mp-g-1; Tue, 18 Feb 2020 12:05:32 -0500
X-MC-Unique: BRZu2SaqPRSrYRN2-4mp-g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6DE41800D54;
        Tue, 18 Feb 2020 17:05:30 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-122-163.rdu2.redhat.com [10.10.122.163])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D1F0B196AE;
        Tue, 18 Feb 2020 17:05:28 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 04/19] vfs: Add mount change counter [ver #16]
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, raven@themaw.net, mszeredi@redhat.com,
        christian@brauner.io, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 18 Feb 2020 17:05:28 +0000
Message-ID: <158204552812.3299825.2343288163181726758.stgit@warthog.procyon.org.uk>
In-Reply-To: <158204549488.3299825.3783690177353088425.stgit@warthog.procyon.org.uk>
References: <158204549488.3299825.3783690177353088425.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.21
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a change counter on each mount object so that the user can easily check
to see if a mount has changed its attributes or its children.

Future patches will:

 (1) Provide this value through fsinfo() attributes.

 (2) Implement a watch_mount() system call to provide a notification
     interface for userspace monitoring.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/mount.h     |   22 ++++++++++++++++++++++
 fs/namespace.c |   11 +++++++++++
 2 files changed, 33 insertions(+)

diff --git a/fs/mount.h b/fs/mount.h
index 711a4093e475..a1625924fe81 100644
--- a/fs/mount.h
+++ b/fs/mount.h
@@ -72,6 +72,7 @@ struct mount {
 	int mnt_expiry_mark;		/* true if marked for expiry */
 	struct hlist_head mnt_pins;
 	struct hlist_head mnt_stuck_children;
+	atomic_t mnt_change_counter;	/* Number of changed applied */
 } __randomize_layout;
 
 #define MNT_NS_INTERNAL ERR_PTR(-EINVAL) /* distinct from any mnt_namespace */
@@ -153,3 +154,24 @@ static inline bool is_anon_ns(struct mnt_namespace *ns)
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
+	atomic_inc(&changed->mnt_change_counter);
+}
diff --git a/fs/namespace.c b/fs/namespace.c
index 85b5f7bea82e..5c84aadb6aa1 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -498,6 +498,8 @@ static int mnt_make_readonly(struct mount *mnt)
 	smp_wmb();
 	mnt->mnt.mnt_flags &= ~MNT_WRITE_HOLD;
 	unlock_mount_hash();
+	if (ret == 0)
+		notify_mount(mnt, NULL, NOTIFY_MOUNT_READONLY, 0x10000);
 	return ret;
 }
 
@@ -506,6 +508,7 @@ static int __mnt_unmake_readonly(struct mount *mnt)
 	lock_mount_hash();
 	mnt->mnt.mnt_flags &= ~MNT_READONLY;
 	unlock_mount_hash();
+	notify_mount(mnt, NULL, NOTIFY_MOUNT_READONLY, 0);
 	return 0;
 }
 
@@ -819,6 +822,7 @@ static struct mountpoint *unhash_mnt(struct mount *mnt)
  */
 static void umount_mnt(struct mount *mnt)
 {
+	notify_mount(mnt->mnt_parent, mnt, NOTIFY_MOUNT_UNMOUNT, 0);
 	put_mountpoint(unhash_mnt(mnt));
 }
 
@@ -1453,6 +1457,7 @@ static void umount_tree(struct mount *mnt, enum umount_tree_flags how)
 		p = list_first_entry(&tmp_list, struct mount, mnt_list);
 		list_del_init(&p->mnt_expire);
 		list_del_init(&p->mnt_list);
+
 		ns = p->mnt_ns;
 		if (ns) {
 			ns->mounts--;
@@ -2078,7 +2083,10 @@ static int attach_recursive_mnt(struct mount *source_mnt,
 		lock_mount_hash();
 	}
 	if (moving) {
+		notify_mount(source_mnt->mnt_parent, source_mnt,
+			     NOTIFY_MOUNT_MOVE_FROM, 0);
 		unhash_mnt(source_mnt);
+		notify_mount(dest_mnt, source_mnt, NOTIFY_MOUNT_MOVE_TO, 0);
 		attach_mnt(source_mnt, dest_mnt, dest_mp);
 		touch_mnt_namespace(source_mnt->mnt_ns);
 	} else {
@@ -2087,6 +2095,7 @@ static int attach_recursive_mnt(struct mount *source_mnt,
 			list_del_init(&source_mnt->mnt_ns->list);
 		}
 		mnt_set_mountpoint(dest_mnt, dest_mp, source_mnt);
+		notify_mount(dest_mnt, source_mnt, NOTIFY_MOUNT_NEW_MOUNT, 0);
 		commit_tree(source_mnt);
 	}
 
@@ -2464,6 +2473,7 @@ static void set_mount_attributes(struct mount *mnt, unsigned int mnt_flags)
 	mnt->mnt.mnt_flags = mnt_flags;
 	touch_mnt_namespace(mnt->mnt_ns);
 	unlock_mount_hash();
+	notify_mount(mnt, NULL, NOTIFY_MOUNT_SETATTR, 0);
 }
 
 static void mnt_warn_timestamp_expiry(struct path *mountpoint, struct vfsmount *mnt)
@@ -2898,6 +2908,7 @@ void mark_mounts_for_expiry(struct list_head *mounts)
 		if (!xchg(&mnt->mnt_expiry_mark, 1) ||
 			propagate_mount_busy(mnt, 1))
 			continue;
+		notify_mount(mnt, NULL, NOTIFY_MOUNT_EXPIRY, 0);
 		list_move(&mnt->mnt_expire, &graveyard);
 	}
 	while (!list_empty(&graveyard)) {


