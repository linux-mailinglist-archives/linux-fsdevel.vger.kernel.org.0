Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF0F022C6AD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jul 2020 15:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbgGXNgV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jul 2020 09:36:21 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:23011 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727833AbgGXNgU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jul 2020 09:36:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595597778;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iE9s0Rn/ZhIcbvQH5QZkvEz5I/8NM87wlTGJ2liGwjY=;
        b=NTx/fm/a+ObPsf8BmL8koms4P3zbraDkEYJ6ah4JdBkep9m2pVivPLTke4bwGH3+bmBnn1
        MSIsW99b3X8HBA9J46AdZymLZg2NlGx21DrTx/CDq2BY5NRZqW8mKpjysO4vlXRacAzvAY
        0tfIpOE6V3oqH3LqDh35NSMgX4OgdQw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-39-kEG6ecD1NvW75RST51U43w-1; Fri, 24 Jul 2020 09:36:16 -0400
X-MC-Unique: kEG6ecD1NvW75RST51U43w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3E154E91A;
        Fri, 24 Jul 2020 13:36:14 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-32.rdu2.redhat.com [10.10.112.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1BD5B2DE72;
        Fri, 24 Jul 2020 13:36:06 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 09/17] fsinfo: Provide notification overrun handling support
 [ver #20]
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org, viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, raven@themaw.net, mszeredi@redhat.com,
        christian@brauner.io, jannh@google.com, darrick.wong@oracle.com,
        kzak@redhat.com, jlayton@redhat.com, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 24 Jul 2020 14:36:06 +0100
Message-ID: <159559776630.2144584.271766219461698701.stgit@warthog.procyon.org.uk>
In-Reply-To: <159559768062.2144584.13583793543173131929.stgit@warthog.procyon.org.uk>
References: <159559768062.2144584.13583793543173131929.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
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
		__u32	mnt_attr_changes;
		__u32	mnt_topology_changes;
		__u32	mnt_subtree_notifications;
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
 include/uapi/linux/fsinfo.h |    8 ++++++++
 samples/vfs/test-fsinfo.c   |    8 ++++++--
 4 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/fs/mount_notify.c b/fs/mount_notify.c
index 365aac5fa746..8fcd8b5b8b56 100644
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
index b5c2a3b4f96d..2205b1e52a41 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -4282,6 +4282,17 @@ int fsinfo_generic_mount_info(struct path *path, struct fsinfo_context *ctx)
 	p->mnt_unique_id	= m->mnt_unique_id;
 	p->mnt_id		= m->mnt_id;
 
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
@@ -4319,6 +4330,9 @@ int fsinfo_generic_mount_topology(struct path *path, struct fsinfo_context *ctx)
 
 	m = real_mount(path->mnt);
 
+#ifdef CONFIG_MOUNT_NOTIFICATIONS
+	p->mnt_topology_changes	= atomic_read(&m->mnt_topology_changes);
+#endif
 	p->parent_id = m->mnt_parent->mnt_id;
 
 	if (path->mnt == root.mnt) {
@@ -4445,6 +4459,13 @@ static void fsinfo_store_mount(struct fsinfo_context *ctx, const struct mount *p
 	record.mnt_unique_id	= p->mnt_unique_id;
 	record.mnt_id		= p->mnt_id;
 	record.parent_id	= is_root ? p->mnt_id : p->mnt_parent->mnt_id;
+
+#ifdef CONFIG_MOUNT_NOTIFICATIONS
+	record.mnt_notify_sum	= (atomic_read(&p->mnt_attr_changes) +
+				   atomic_read(&p->mnt_topology_changes) +
+				   atomic_read(&p->mnt_subtree_notifications));
+#endif
+
 	memcpy(ctx->buffer + usage, &record, sizeof(record));
 }
 
diff --git a/include/uapi/linux/fsinfo.h b/include/uapi/linux/fsinfo.h
index f0a352b7028e..5cf1dad3c6c9 100644
--- a/include/uapi/linux/fsinfo.h
+++ b/include/uapi/linux/fsinfo.h
@@ -100,6 +100,10 @@ struct fsinfo_mount_info {
 	__u64	mnt_unique_id;		/* Kernel-lifetime unique mount ID */
 	__u32	mnt_id;			/* Mount identifier (use with AT_FSINFO_MOUNTID_PATH) */
 	__u32	attr;			/* MOUNT_ATTR_* flags */
+	__u32	mnt_attr_changes;	/* Number of attribute changes to this mount. */
+	__u32	mnt_topology_changes;	/* Number of topology changes to this mount. */
+	__u32	mnt_subtree_notifications; /* Number of notifications in mount subtree */
+	__u32	padding[1];
 };
 
 #define FSINFO_ATTR_MOUNT_INFO__STRUCT struct fsinfo_mount_info
@@ -113,6 +117,7 @@ struct fsinfo_mount_topology {
 	__u32	dependent_source_id;	/* Dependent: source mount group ID */
 	__u32	dependent_clone_of_id;	/* Dependent: ID of mount this was cloned from */
 	__u32	propagation_type;	/* MOUNT_PROPAGATION_* type */
+	__u32	mnt_topology_changes;	/* Number of topology changes to this mount. */
 };
 
 #define FSINFO_ATTR_MOUNT_TOPOLOGY__STRUCT struct fsinfo_mount_topology
@@ -125,6 +130,9 @@ struct fsinfo_mount_child {
 	__u64	mnt_unique_id;		/* Kernel-lifetime unique mount ID */
 	__u32	mnt_id;			/* Mount identifier (use with AT_FSINFO_MOUNTID_PATH) */
 	__u32	parent_id;		/* Parent mount identifier */
+	__u32	mnt_notify_sum;		/* Sum of mnt_attr_changes, mnt_topology_changes and
+					 * mnt_subtree_notifications.
+					 */
 };
 
 #define FSINFO_ATTR_MOUNT_CHILDREN__STRUCT struct fsinfo_mount_child
diff --git a/samples/vfs/test-fsinfo.c b/samples/vfs/test-fsinfo.c
index b7290ea8eb55..667a99b82486 100644
--- a/samples/vfs/test-fsinfo.c
+++ b/samples/vfs/test-fsinfo.c
@@ -304,6 +304,8 @@ static void dump_fsinfo_generic_mount_info(void *reply, unsigned int size)
 	printf("\tmnt_uniq: %llx\n", (unsigned long long)r->mnt_unique_id);
 	printf("\tmnt_id  : %x\n", r->mnt_id);
 	printf("\tattr    : %x\n", r->attr);
+	printf("\tmnt_nfy : attr=%u topology=%u subtree=%u\n",
+	       r->mnt_attr_changes, r->mnt_topology_changes, r->mnt_subtree_notifications);
 }
 
 static void dump_fsinfo_generic_mount_topology(void *reply, unsigned int size)
@@ -332,6 +334,7 @@ static void dump_fsinfo_generic_mount_topology(void *reply, unsigned int size)
 		break;
 	}
 
+	printf("\tmnt_nfy : topology=%u\n", r->mnt_topology_changes);
 }
 
 static void dump_fsinfo_generic_mount_children(void *reply, unsigned int size)
@@ -354,8 +357,9 @@ static void dump_fsinfo_generic_mount_children(void *reply, unsigned int size)
 		mp = "<this>";
 	}
 
-	printf("%8x %16llx %s\n",
-	       r->mnt_id, (unsigned long long)r->mnt_unique_id, mp);
+	printf("%8x %16llx %10u %s\n",
+	       r->mnt_id, (unsigned long long)r->mnt_unique_id,
+	       r->mnt_notify_sum, mp);
 }
 
 static void dump_string(void *reply, unsigned int size)


