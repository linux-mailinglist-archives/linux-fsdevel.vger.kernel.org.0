Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC0F23A7B2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Aug 2020 15:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728190AbgHCNiA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Aug 2020 09:38:00 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:30756 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726785AbgHCNh7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Aug 2020 09:37:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596461877;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sBiydB0pL78+wQEnLlcK297j3UdalsVzHIY6kjejpL8=;
        b=KXrLiKQgdpQCEP7NwX476U1fZb4XAD91GsCWBP6FaXIKZSBAuyuhbgWynv0uDDDsf3txYi
        6Fcw8Bq3fvKimpClr1ixZlriOTIySTWysUEftqKAlthul+2tg9VH9ZjNYKnfztVZWqUSwX
        DSRwRBuAIdpa4Qv4PJJSbdiDhrvUiW4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-65-KKUP35FUMcSNgq8u-noaSQ-1; Mon, 03 Aug 2020 09:37:55 -0400
X-MC-Unique: KKUP35FUMcSNgq8u-noaSQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1C79E80046B;
        Mon,  3 Aug 2020 13:37:54 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-32.rdu2.redhat.com [10.10.112.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9F0FD1002388;
        Mon,  3 Aug 2020 13:37:51 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 10/18] fsinfo: Provide notification overrun handling support
 [ver #21]
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, torvalds@linux-foundation.org,
        raven@themaw.net, mszeredi@redhat.com, christian@brauner.io,
        jannh@google.com, darrick.wong@oracle.com, kzak@redhat.com,
        jlayton@redhat.com, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 03 Aug 2020 14:37:50 +0100
Message-ID: <159646187082.1784947.4293611877413578847.stgit@warthog.procyon.org.uk>
In-Reply-To: <159646178122.1784947.11705396571718464082.stgit@warthog.procyon.org.uk>
References: <159646178122.1784947.11705396571718464082.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
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
counters to struct mount.

To make them accessible, they can be retrieved using fsinfo() and the
FSINFO_ATTR_MOUNT_INFO attribute.

	struct fsinfo_mount_info {
		__u64	mnt_unique_id;
		__u64	mnt_attr_changes;
		__u64	mnt_topology_changes;
		__u64	mnt_subtree_notifications;
	...
	};

There's a uniquifier and some event counters:

 (1) mnt_unique_id - This is an effectively non-repeating ID given to each
     mount object on creation.  This allows the caller to check that the
     mount ID didn't get reused (the 32-bit mount ID is more efficient to
     look up).

 (2) mnt_attr_changes - Count of attribute changes on a mount object.

 (3) mnt_topology_changes - Count of alterations to the mount tree that
     affected this node.

 (4) mnt_subtree_notifications - Count of mount object event notifications
     that were generated in the subtree rooted at this node.  This excludes
     events generated on this node itself and does not include superblock
     events.

The counters are also accessible through the FSINFO_ATTR_MOUNT_CHILDREN
attribute, where a list of all the children of a mount can be scanned.  The
record returned for each child includes the sum of the counters for that
child.  An additional record is added at the end for the queried object and
that also includes the sum of its counters

The mnt_topology_changes counter is also included in
FSINFO_ATTR_MOUNT_TOPOLOGY.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/mount_notify.c           |    2 ++
 fs/namespace.c              |   21 +++++++++++++++++++++
 include/uapi/linux/fsinfo.h |    7 +++++++
 samples/vfs/test-fsinfo.c   |   10 ++++++++--
 4 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/fs/mount_notify.c b/fs/mount_notify.c
index 57eebae51cb1..57995c27ca88 100644
--- a/fs/mount_notify.c
+++ b/fs/mount_notify.c
@@ -93,6 +93,8 @@ void notify_mount(struct mount *trigger,
 	n.watch.info	= info_flags | watch_sizeof(n);
 	n.triggered_on	= trigger->mnt_unique_id;
 
+	smp_wmb(); /* See fsinfo_generic_mount_info(). */
+
 	switch (subtype) {
 	case NOTIFY_MOUNT_EXPIRY:
 	case NOTIFY_MOUNT_READONLY:
diff --git a/fs/namespace.c b/fs/namespace.c
index b5c2a3b4f96d..122c12f9512b 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -4282,6 +4282,17 @@ int fsinfo_generic_mount_info(struct path *path, struct fsinfo_context *ctx)
 	p->mnt_unique_id	= m->mnt_unique_id;
 	p->mnt_id		= m->mnt_id;
 
+#ifdef CONFIG_MOUNT_NOTIFICATIONS
+	p->mnt_subtree_notifications = atomic_long_read(&m->mnt_subtree_notifications);
+	p->mnt_topology_changes	= atomic_long_read(&m->mnt_topology_changes);
+	p->mnt_attr_changes	= atomic_long_read(&m->mnt_attr_changes);
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
@@ -4319,6 +4330,9 @@ int fsinfo_generic_mount_topology(struct path *path, struct fsinfo_context *ctx)
 
 	m = real_mount(path->mnt);
 
+#ifdef CONFIG_MOUNT_NOTIFICATIONS
+	p->mnt_topology_changes	= atomic_long_read(&m->mnt_topology_changes);
+#endif
 	p->parent_id = m->mnt_parent->mnt_id;
 
 	if (path->mnt == root.mnt) {
@@ -4445,6 +4459,13 @@ static void fsinfo_store_mount(struct fsinfo_context *ctx, const struct mount *p
 	record.mnt_unique_id	= p->mnt_unique_id;
 	record.mnt_id		= p->mnt_id;
 	record.parent_id	= is_root ? p->mnt_id : p->mnt_parent->mnt_id;
+
+#ifdef CONFIG_MOUNT_NOTIFICATIONS
+	record.mnt_notify_sum	= (atomic_long_read(&p->mnt_attr_changes) +
+				   atomic_long_read(&p->mnt_topology_changes) +
+				   atomic_long_read(&p->mnt_subtree_notifications));
+#endif
+
 	memcpy(ctx->buffer + usage, &record, sizeof(record));
 }
 
diff --git a/include/uapi/linux/fsinfo.h b/include/uapi/linux/fsinfo.h
index f0a352b7028e..b021466dee0f 100644
--- a/include/uapi/linux/fsinfo.h
+++ b/include/uapi/linux/fsinfo.h
@@ -100,6 +100,9 @@ struct fsinfo_mount_info {
 	__u64	mnt_unique_id;		/* Kernel-lifetime unique mount ID */
 	__u32	mnt_id;			/* Mount identifier (use with AT_FSINFO_MOUNTID_PATH) */
 	__u32	attr;			/* MOUNT_ATTR_* flags */
+	__u64	mnt_attr_changes;	/* Number of attribute changes to this mount. */
+	__u64	mnt_topology_changes;	/* Number of topology changes to this mount. */
+	__u64	mnt_subtree_notifications; /* Number of notifications in mount subtree */
 };
 
 #define FSINFO_ATTR_MOUNT_INFO__STRUCT struct fsinfo_mount_info
@@ -113,6 +116,7 @@ struct fsinfo_mount_topology {
 	__u32	dependent_source_id;	/* Dependent: source mount group ID */
 	__u32	dependent_clone_of_id;	/* Dependent: ID of mount this was cloned from */
 	__u32	propagation_type;	/* MOUNT_PROPAGATION_* type */
+	__u64	mnt_topology_changes;	/* Number of topology changes to this mount. */
 };
 
 #define FSINFO_ATTR_MOUNT_TOPOLOGY__STRUCT struct fsinfo_mount_topology
@@ -125,6 +129,9 @@ struct fsinfo_mount_child {
 	__u64	mnt_unique_id;		/* Kernel-lifetime unique mount ID */
 	__u32	mnt_id;			/* Mount identifier (use with AT_FSINFO_MOUNTID_PATH) */
 	__u32	parent_id;		/* Parent mount identifier */
+	__u64	mnt_notify_sum;		/* Sum of mnt_attr_changes, mnt_topology_changes and
+					 * mnt_subtree_notifications.
+					 */
 };
 
 #define FSINFO_ATTR_MOUNT_CHILDREN__STRUCT struct fsinfo_mount_child
diff --git a/samples/vfs/test-fsinfo.c b/samples/vfs/test-fsinfo.c
index b7290ea8eb55..620a02477aa8 100644
--- a/samples/vfs/test-fsinfo.c
+++ b/samples/vfs/test-fsinfo.c
@@ -304,6 +304,10 @@ static void dump_fsinfo_generic_mount_info(void *reply, unsigned int size)
 	printf("\tmnt_uniq: %llx\n", (unsigned long long)r->mnt_unique_id);
 	printf("\tmnt_id  : %x\n", r->mnt_id);
 	printf("\tattr    : %x\n", r->attr);
+	printf("\tevents  : attr=%llu topology=%llu subtree=%llu\n",
+	       (unsigned long long)r->mnt_attr_changes,
+	       (unsigned long long)r->mnt_topology_changes,
+	       (unsigned long long)r->mnt_subtree_notifications);
 }
 
 static void dump_fsinfo_generic_mount_topology(void *reply, unsigned int size)
@@ -332,6 +336,7 @@ static void dump_fsinfo_generic_mount_topology(void *reply, unsigned int size)
 		break;
 	}
 
+	printf("\tevents  : topology=%llu\n", (unsigned long long)r->mnt_topology_changes);
 }
 
 static void dump_fsinfo_generic_mount_children(void *reply, unsigned int size)
@@ -354,8 +359,9 @@ static void dump_fsinfo_generic_mount_children(void *reply, unsigned int size)
 		mp = "<this>";
 	}
 
-	printf("%8x %16llx %s\n",
-	       r->mnt_id, (unsigned long long)r->mnt_unique_id, mp);
+	printf("%8x %16llx %10llu %s\n",
+	       r->mnt_id, (unsigned long long)r->mnt_unique_id,
+	       (unsigned long long)r->mnt_notify_sum, mp);
 }
 
 static void dump_string(void *reply, unsigned int size)


