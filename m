Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C91DF17E205
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Mar 2020 15:02:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbgCIOCV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Mar 2020 10:02:21 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:22496 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726643AbgCIOCU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Mar 2020 10:02:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583762539;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I3eXk17JjXBz0TXrAgFd7/9dhrjX+vN/TsDaEuaMlDA=;
        b=cfxRAMYJDVlCnYwH783l+Wv/BZtpF1U7k22mebU0kdoVtRJ2OFfdNxS/5es9hbXhlEwpHX
        771gf2WqggFR+k1tJKcUfR9hbArDkyJqFr1phwGPeq+gznBZJ97VcavAcfPD4zy+51AeUY
        f/5g/DHhUVHKZXlHXrTSsziuQ7cfmQE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-416-ZrGgGfMTNsOMb8uqnTpB9w-1; Mon, 09 Mar 2020 10:02:15 -0400
X-MC-Unique: ZrGgGfMTNsOMb8uqnTpB9w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B9F328010C7;
        Mon,  9 Mar 2020 14:02:13 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-182.rdu2.redhat.com [10.10.120.182])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 36AB18B773;
        Mon,  9 Mar 2020 14:02:11 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 09/14] fsinfo: Provide notification overrun handling support
 [ver #18]
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org, viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, raven@themaw.net, mszeredi@redhat.com,
        christian@brauner.io, jannh@google.com, darrick.wong@oracle.com,
        kzak@redhat.com, jlayton@redhat.com, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 09 Mar 2020 14:02:10 +0000
Message-ID: <158376253048.344135.5312529212248513321.stgit@warthog.procyon.org.uk>
In-Reply-To: <158376244589.344135.12925590041630631412.stgit@warthog.procyon.org.uk>
References: <158376244589.344135.12925590041630631412.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.21
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/namespace.c              |   31 ++++++++++++++++++++++++++-----
 include/uapi/linux/fsinfo.h |    9 ++++++++-
 samples/vfs/test-fsinfo.c   |    7 +++++--
 3 files changed, 39 insertions(+), 8 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 88aef45bcfa8..2b651003e6af 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -4167,6 +4167,15 @@ int fsinfo_generic_mount_info(struct path *path, struct fsinfo_context *ctx)
 	p->mnt_unique_id	= m->mnt_unique_id;
 	p->mnt_id		= m->mnt_id;
 	p->parent_id		= m->mnt_parent->mnt_id;
+#ifdef CONFIG_SB_NOTIFICATIONS
+	p->sb_changes		= atomic_read(&sb->s_change_counter);
+	p->sb_notifications	= atomic_read(&sb->s_notify_counter);
+#endif
+#ifdef CONFIG_MOUNT_NOTIFICATIONS
+	p->mnt_attr_changes	= atomic_read(&m->mnt_attr_changes);
+	p->mnt_topology_changes	= atomic_read(&m->mnt_topology_changes);
+	p->mnt_subtree_notifications = atomic_read(&m->mnt_subtree_notifications);
+#endif
 
 	get_fs_root(current->fs, &root);
 	if (path->mnt == root.mnt) {
@@ -4293,17 +4302,29 @@ int fsinfo_generic_mount_point_full(struct path *path, struct fsinfo_context *ct
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
index 909d6104933b..826b788b0795 100644
--- a/include/uapi/linux/fsinfo.h
+++ b/include/uapi/linux/fsinfo.h
@@ -104,6 +104,11 @@ struct fsinfo_mount_info {
 	__u32	from_id;		/* Slave propagated from ID */
 	__u32	attr;			/* MOUNT_ATTR_* flags */
 	__u32	propagation;		/* MOUNT_PROPAGATION_* flags */
+	__u32	sb_changes;		/* Number of sb configuration changes */
+	__u32	sb_notifications;	/* Number of other sb notifications */
+	__u32	mnt_attr_changes;	/* Number of attribute changes to this mount. */
+	__u32	mnt_topology_changes;	/* Number of topology changes to this mount. */
+	__u32	mnt_subtree_notifications; /* Number of notifications in mount subtree */
 };
 
 #define FSINFO_ATTR_MOUNT_INFO__STRUCT struct fsinfo_mount_info
@@ -115,7 +120,9 @@ struct fsinfo_mount_info {
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
index bdc7ea952630..91434f459ba5 100644
--- a/samples/vfs/test-fsinfo.c
+++ b/samples/vfs/test-fsinfo.c
@@ -300,6 +300,9 @@ static void dump_fsinfo_generic_mount_info(void *reply, unsigned int size)
 	printf("\tgroup   : %x\n", r->group_id);
 	printf("\tattr    : %x\n", r->attr);
 	printf("\tpropag  : %x\n", r->propagation);
+	printf("\tsb_nfy  : changes=%u other=%u\n", r->sb_changes, r->sb_notifications);
+	printf("\tmnt_nfy : attr=%u topology=%u subtree=%u\n",
+	       r->mnt_attr_changes, r->mnt_topology_changes, r->mnt_subtree_notifications);
 }
 
 static void dump_fsinfo_generic_mount_child(void *reply, unsigned int size)
@@ -322,8 +325,8 @@ static void dump_fsinfo_generic_mount_child(void *reply, unsigned int size)
 		mp = "<this>";
 	}
 
-	printf("%8x %16llx %s\n",
-	       r->mnt_id, (unsigned long long)r->mnt_unique_id, mp);
+	printf("%8x %16llx %10u %s\n",
+	       r->mnt_id, (unsigned long long)r->mnt_unique_id, r->notify_sum, mp);
 }
 
 static void dump_string(void *reply, unsigned int size)


