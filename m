Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9367C189F2C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Mar 2020 16:09:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727303AbgCRPJa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Mar 2020 11:09:30 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:46905 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727430AbgCRPJ3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Mar 2020 11:09:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584544168;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JVAaWskswUefhWUydGIche55WUn3HE0LbvF5GBc4fh4=;
        b=M/wQgpYAHJBe85CVY4/kxPWkrv2tlvAJCVdqTfbjwSNgT73Mji74crMoxtxOGUssd90/4F
        jyNUJTey+buo4w9B3mh0/oxHr2UOFw/EHNdI0eZoCPB0YzwhoBYsZy7BfoZZKrTF/VQR6B
        sI9kwv9J14yiZUDqjsyCL153V6FQ66g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-383-26KgVn4eN42z1hnOD7B59g-1; Wed, 18 Mar 2020 11:09:24 -0400
X-MC-Unique: 26KgVn4eN42z1hnOD7B59g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D48A6477;
        Wed, 18 Mar 2020 15:09:22 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-113-126.rdu2.redhat.com [10.10.113.126])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 55E331001B07;
        Wed, 18 Mar 2020 15:09:20 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 08/13] fsinfo: Provide notification overrun handling support
 [ver #19]
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org, viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, raven@themaw.net, mszeredi@redhat.com,
        christian@brauner.io, jannh@google.com, darrick.wong@oracle.com,
        kzak@redhat.com, jlayton@redhat.com, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 18 Mar 2020 15:09:19 +0000
Message-ID: <158454415956.2864823.18006954558666607736.stgit@warthog.procyon.org.uk>
In-Reply-To: <158454408854.2864823.5910520544515668590.stgit@warthog.procyon.org.uk>
References: <158454408854.2864823.5910520544515668590.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.21
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Provide support for the handling of an overrun in a watch queue.  In the
event that an overrun occurs, the watcher needs to be able to find out what
it was that they missed.  To this end, previous patches added event
counters to the superblock and mount object structures.

To make them accessible, they can be accessed using fsinfo() and the
FSINFO_ATTR_MOUNT_INFO attribute.

	struct fsinfo_mount_info {
		__u64	mnt_unique_id;
		__u32	sb_changes;
		__u32	sb_notifications;
		__u32	mnt_attr_changes;
		__u32	mnt_topology_changes;
		__u32	mnt_subtree_notifications;
	...
	};

There's a uniquifier and five event counters:

 (1) mnt_unique_id - This is an effectively non-repeating ID given to each
     mount object on creation.  This allows the caller to check that the
     mount ID didn't get reused (the 32-bit mount ID is more efficient to
     look up).

 (2) sb_changes - Count of superblock configuration changes.

 (3) sb_notifications - Count of other superblock notifications (errors,
     quota overruns, etc.).

 (4) mnt_attr_changes - Count of attribute changes on a mount object.

 (5) mnt_topology_changes - Count of alterations to the mount tree that
     affected this node.

 (6) mnt_subtree_notifications - Count of mount object event notifications
     that were generated in the subtree rooted at this node.  This excludes
     events generated on this node itself and does not include superblock
     events.

The counters are also accessible through the FSINFO_ATTR_MOUNT_CHILDREN
attribute, where a list of all the children of a mount can be scanned.  The
record returned for each child includes the sum of the above five counters
for that child.  An additional record is added at the end for the queried
object and that also includes the sum of its five counters

The mnt_topology_changes counter is also included in
FSINFO_ATTR_MOUNT_TOPOLOGY.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/mount_notify.c           |    2 ++
 fs/namespace.c              |   38 +++++++++++++++++++++++++++++++++-----
 include/uapi/linux/fsinfo.h |   11 ++++++++++-
 samples/vfs/test-fsinfo.c   |    8 ++++++--
 4 files changed, 51 insertions(+), 8 deletions(-)

diff --git a/fs/mount_notify.c b/fs/mount_notify.c
index 403d79785807..9ca6888e53c2 100644
--- a/fs/mount_notify.c
+++ b/fs/mount_notify.c
@@ -93,6 +93,8 @@ void notify_mount(struct mount *trigger,
 	n.watch.info	= info_flags | watch_sizeof(n);
 	n.triggered_on	= trigger->mnt_id;
 
+	smp_wmb(); /* See fsinfo_generic_mount_info(). */
+
 	switch (subtype) {
 	case NOTIFY_MOUNT_EXPIRY:
 	case NOTIFY_MOUNT_READONLY:
diff --git a/fs/namespace.c b/fs/namespace.c
index 61b110149fc5..5427e732c1bf 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -4166,6 +4166,21 @@ int fsinfo_generic_mount_info(struct path *path, struct fsinfo_context *ctx)
 	p->mnt_unique_id	= m->mnt_unique_id;
 	p->mnt_id		= m->mnt_id;
 
+#ifdef CONFIG_SB_NOTIFICATIONS
+	p->sb_changes		= atomic_read(&sb->s_change_counter);
+	p->sb_notifications	= atomic_read(&sb->s_notify_counter);
+#endif
+#ifdef CONFIG_MOUNT_NOTIFICATIONS
+	p->mnt_subtree_notifications = atomic_read(&m->mnt_subtree_notifications);
+	p->mnt_topology_changes	= atomic_read(&m->mnt_topology_changes);
+	p->mnt_attr_changes	= atomic_read(&m->mnt_attr_changes);
+#endif
+
+	/* Record the counters before reading the attributes as we're not
+	 * holding a lock.  Paired with a write barrier in notify_mount().
+	 */
+	smp_rmb();
+
 	flags = READ_ONCE(m->mnt.mnt_flags);
 	if (flags & MNT_READONLY)
 		p->attr |= MOUNT_ATTR_RDONLY;
@@ -4203,6 +4218,7 @@ int fsinfo_generic_mount_topology(struct path *path, struct fsinfo_context *ctx)
 
 	m = real_mount(path->mnt);
 
+	p->mnt_topology_changes	= atomic_read(&m->mnt_topology_changes);
 	p->parent_id = m->mnt_parent->mnt_id;
 
 	if (path->mnt == root.mnt) {
@@ -4313,17 +4329,29 @@ int fsinfo_generic_mount_point_full(struct path *path, struct fsinfo_context *ct
 static void fsinfo_store_mount(struct fsinfo_context *ctx, const struct mount *p)
 {
 	struct fsinfo_mount_child record = {};
+	const struct super_block *sb = p->mnt.mnt_sb;
 	unsigned int usage = ctx->usage;
 
 	if (ctx->usage >= INT_MAX)
 		return;
 	ctx->usage = usage + sizeof(record);
+	if (!ctx->buffer || ctx->usage > ctx->buf_size)
+		return;
 
-	if (ctx->buffer && ctx->usage <= ctx->buf_size) {
-		record.mnt_unique_id	= p->mnt_unique_id;
-		record.mnt_id		= p->mnt_id;
-		memcpy(ctx->buffer + usage, &record, sizeof(record));
-	}
+	record.mnt_unique_id	= p->mnt_unique_id;
+	record.mnt_id		= p->mnt_id;
+	record.notify_sum	= 0;
+#ifdef CONFIG_SB_NOTIFICATIONS
+	record.notify_sum	+= (atomic_read(&sb->s_change_counter) +
+				    atomic_read(&sb->s_notify_counter));
+#endif
+#ifdef CONFIG_MOUNT_NOTIFICATIONS
+	record.notify_sum	+= (atomic_read(&p->mnt_attr_changes) +
+				    atomic_read(&p->mnt_topology_changes) +
+				    atomic_read(&p->mnt_subtree_notifications));
+#endif
+
+	memcpy(ctx->buffer + usage, &record, sizeof(record));
 }
 
 /*
diff --git a/include/uapi/linux/fsinfo.h b/include/uapi/linux/fsinfo.h
index 9410e320d824..85edc3ef2e51 100644
--- a/include/uapi/linux/fsinfo.h
+++ b/include/uapi/linux/fsinfo.h
@@ -100,6 +100,12 @@ struct fsinfo_mount_info {
 	__u64	mnt_unique_id;		/* Kernel-lifetime unique mount ID */
 	__u32	mnt_id;			/* Mount identifier (use with AT_FSINFO_MOUNTID_PATH) */
 	__u32	attr;			/* MOUNT_ATTR_* flags */
+	__u32	sb_changes;		/* Number of sb configuration changes */
+	__u32	sb_notifications;	/* Number of other sb notifications */
+	__u32	mnt_attr_changes;	/* Number of attribute changes to this mount. */
+	__u32	mnt_topology_changes;	/* Number of topology changes to this mount. */
+	__u32	mnt_subtree_notifications; /* Number of notifications in mount subtree */
+	__u32	padding[1];
 };
 
 #define FSINFO_ATTR_MOUNT_INFO__STRUCT struct fsinfo_mount_info
@@ -113,6 +119,7 @@ struct fsinfo_mount_topology {
 	__u32	master_id;		/* Slave master group ID */
 	__u32	from_id;		/* Slave propagated from ID */
 	__u32	propagation;		/* MOUNT_PROPAGATION_* flags */
+	__u32	mnt_topology_changes;	/* Number of topology changes to this mount. */
 };
 
 #define FSINFO_ATTR_MOUNT_TOPOLOGY__STRUCT struct fsinfo_mount_topology
@@ -124,7 +131,9 @@ struct fsinfo_mount_topology {
 struct fsinfo_mount_child {
 	__u64	mnt_unique_id;		/* Kernel-lifetime unique mount ID */
 	__u32	mnt_id;			/* Mount identifier (use with AT_FSINFO_MOUNTID_PATH) */
-	__u32	__padding[1];
+	__u32	notify_sum;		/* Sum of sb_changes, sb_notifications, mnt_attr_changes,
+					 * mnt_topology_changes and mnt_subtree_notifications.
+					 */
 };
 
 #define FSINFO_ATTR_MOUNT_CHILDREN__STRUCT struct fsinfo_mount_child
diff --git a/samples/vfs/test-fsinfo.c b/samples/vfs/test-fsinfo.c
index 762ab4517cd9..7b2676e1b7b0 100644
--- a/samples/vfs/test-fsinfo.c
+++ b/samples/vfs/test-fsinfo.c
@@ -297,6 +297,9 @@ static void dump_fsinfo_generic_mount_info(void *reply, unsigned int size)
 	printf("\tmnt_uniq: %llx\n", (unsigned long long)r->mnt_unique_id);
 	printf("\tmnt_id  : %x\n", r->mnt_id);
 	printf("\tattr    : %x\n", r->attr);
+	printf("\tsb_nfy  : changes=%u other=%u\n", r->sb_changes, r->sb_notifications);
+	printf("\tmnt_nfy : attr=%u topology=%u subtree=%u\n",
+	       r->mnt_attr_changes, r->mnt_topology_changes, r->mnt_subtree_notifications);
 }
 
 static void dump_fsinfo_generic_mount_topology(void *reply, unsigned int size)
@@ -309,6 +312,7 @@ static void dump_fsinfo_generic_mount_topology(void *reply, unsigned int size)
 	printf("\tmaster  : %x\n", r->master_id);
 	printf("\tfrom    : %x\n", r->from_id);
 	printf("\tpropag  : %x\n", r->propagation);
+	printf("\tmnt_nfy : topology=%u\n", r->mnt_topology_changes);
 }
 
 static void dump_fsinfo_generic_mount_children(void *reply, unsigned int size)
@@ -331,8 +335,8 @@ static void dump_fsinfo_generic_mount_children(void *reply, unsigned int size)
 		mp = "<this>";
 	}
 
-	printf("%8x %16llx %s\n",
-	       r->mnt_id, (unsigned long long)r->mnt_unique_id, mp);
+	printf("%8x %16llx %10u %s\n",
+	       r->mnt_id, (unsigned long long)r->mnt_unique_id, r->notify_sum, mp);
 }
 
 static void dump_string(void *reply, unsigned int size)


