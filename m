Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7025162C1A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2020 18:15:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727636AbgBRROG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Feb 2020 12:14:06 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:54151 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727099AbgBRROF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Feb 2020 12:14:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582046043;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6V7zDpOQY9QcI4zPVvzGV9kIfcQ6hip+cWutIuPFGeo=;
        b=AA9tOudRsUYe3b92BlsnUkiHvr1L2Sn/kJf4msklHXd2Gzv62gy5XVS1TmQ624CFRZpcJd
        vgLIQ9t8f4mobnq7fcbKh3yk10eSeUl7pEeMoY45rspCRfdvqrz3N4uUAa/95jS/5D+EI1
        GB7NuZXgO6aFrD+03UndNm2jpdBxaW4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-234-YNV1lRqkMy2rc36AMLl3rA-1; Tue, 18 Feb 2020 12:07:03 -0500
X-MC-Unique: YNV1lRqkMy2rc36AMLl3rA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D9740800D5B;
        Tue, 18 Feb 2020 17:07:01 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-122-163.rdu2.redhat.com [10.10.122.163])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6683A8B554;
        Tue, 18 Feb 2020 17:07:00 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 16/19] fsinfo: Provide superblock notification counter [ver
 #16]
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, raven@themaw.net, mszeredi@redhat.com,
        christian@brauner.io, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 18 Feb 2020 17:06:58 +0000
Message-ID: <158204561872.3299825.4717297716890589985.stgit@warthog.procyon.org.uk>
In-Reply-To: <158204549488.3299825.3783690177353088425.stgit@warthog.procyon.org.uk>
References: <158204549488.3299825.3783690177353088425.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.21
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Provide an fsinfo attribute to export the superblock notification counter
so that it can be polled in the case of a notification buffer overrun.
This is accessed with:

	struct fsinfo_params params = {
		.request = FSINFO_ATTR_SB_NOTIFICATIONS,
	};

and returns a structure that looks like:

	struct fsinfo_sb_notifications {
		__u64	watch_id;
		__u32	notify_counter;
		__u32	__reserved[1];
	};

Where watch_id is a number uniquely identifying the superblock in
notification records and notify_counter is incremented for each
superblock notification posted.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/fsinfo.c                      |   11 +++++++++++
 include/linux/fs.h               |    4 ++++
 include/uapi/linux/fsinfo.h      |   12 ++++++++++++
 include/uapi/linux/watch_queue.h |    2 +-
 samples/vfs/test-fsinfo.c        |   12 ++++++++++--
 5 files changed, 38 insertions(+), 3 deletions(-)

diff --git a/fs/fsinfo.c b/fs/fsinfo.c
index b57fbcd3a7a5..72fc4f790a5a 100644
--- a/fs/fsinfo.c
+++ b/fs/fsinfo.c
@@ -226,6 +226,16 @@ static int fsinfo_generic_volume_id(struct path *path, struct fsinfo_context *ct
 	return fsinfo_string(path->dentry->d_sb->s_id, ctx);
 }
 
+static int fsinfo_generic_sb_notifications(struct path *path, struct fsinfo_context *ctx)
+{
+	struct fsinfo_sb_notifications *p = ctx->buffer;
+	struct super_block *sb = path->dentry->d_sb;
+
+	p->watch_id		= sb->s_unique_id;
+	p->notify_counter	= atomic_read(&sb->s_notify_counter);
+	return sizeof(*p);
+}
+
 static int fsinfo_attribute_info(struct path *path, struct fsinfo_context *ctx)
 {
 	const struct fsinfo_attribute *attr;
@@ -292,6 +302,7 @@ static const struct fsinfo_attribute fsinfo_common_attributes[] = {
 	FSINFO_STRING 	(FSINFO_ATTR_VOLUME_ID,		fsinfo_generic_volume_id),
 	FSINFO_VSTRUCT	(FSINFO_ATTR_VOLUME_UUID,	fsinfo_generic_volume_uuid),
 	FSINFO_VSTRUCT	(FSINFO_ATTR_FEATURES,		fsinfo_generic_features),
+	FSINFO_VSTRUCT	(FSINFO_ATTR_SB_NOTIFICATIONS,	fsinfo_generic_sb_notifications),
 
 	FSINFO_VSTRUCT	(FSINFO_ATTR_FSINFO,		fsinfo_generic_fsinfo),
 	FSINFO_VSTRUCT_N(FSINFO_ATTR_FSINFO_ATTRIBUTE_INFO, fsinfo_attribute_info),
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 423a6f03cdf8..30b910d591db 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1558,6 +1558,7 @@ struct super_block {
 #ifdef CONFIG_SB_NOTIFICATIONS
 	struct watch_list	*s_watchers;
 #endif
+	atomic_t		s_notify_counter;
 } __randomize_layout;
 
 /* Helper functions so that in most cases filesystems will
@@ -3677,6 +3678,7 @@ static inline void notify_sb(struct super_block *s,
 			     u32 info)
 {
 #ifdef CONFIG_SB_NOTIFICATIONS
+	atomic_inc(&s->s_notify_counter);
 	if (unlikely(s->s_watchers)) {
 		struct superblock_notification n = {
 			.watch.type	= WATCH_TYPE_SB_NOTIFY,
@@ -3699,6 +3701,7 @@ static inline void notify_sb(struct super_block *s,
 static inline int notify_sb_error(struct super_block *s, int error)
 {
 #ifdef CONFIG_SB_NOTIFICATIONS
+	atomic_inc(&s->s_notify_counter);
 	if (unlikely(s->s_watchers)) {
 		struct superblock_error_notification n = {
 			.s.watch.type	= WATCH_TYPE_SB_NOTIFY,
@@ -3722,6 +3725,7 @@ static inline int notify_sb_error(struct super_block *s, int error)
 static inline int notify_sb_EQDUOT(struct super_block *s)
 {
 #ifdef CONFIG_SB_NOTIFICATIONS
+	atomic_inc(&s->s_notify_counter);
 	if (unlikely(s->s_watchers)) {
 		struct superblock_notification n = {
 			.watch.type	= WATCH_TYPE_SB_NOTIFY,
diff --git a/include/uapi/linux/fsinfo.h b/include/uapi/linux/fsinfo.h
index 5926b16aac4e..5467f88ca9b0 100644
--- a/include/uapi/linux/fsinfo.h
+++ b/include/uapi/linux/fsinfo.h
@@ -23,6 +23,7 @@
 #define FSINFO_ATTR_VOLUME_UUID		0x06	/* Volume UUID (LE uuid) */
 #define FSINFO_ATTR_VOLUME_NAME		0x07	/* Volume name (string) */
 #define FSINFO_ATTR_FEATURES		0x08	/* Filesystem features (bits) */
+#define FSINFO_ATTR_SB_NOTIFICATIONS	0x09	/* sb_notify() information */
 
 #define FSINFO_ATTR_FSINFO_ATTRIBUTE_INFO 0x100	/* Information about attr N (for path) */
 #define FSINFO_ATTR_FSINFO_ATTRIBUTES	0x101	/* List of supported attrs (for path) */
@@ -300,6 +301,17 @@ struct fsinfo_volume_uuid {
 
 #define FSINFO_ATTR_VOLUME_UUID__STRUCT struct fsinfo_volume_uuid
 
+/*
+ * Information struct for fsinfo(FSINFO_ATTR_SB_NOTIFICATIONS).
+ */
+struct fsinfo_sb_notifications {
+	__u64		watch_id;	/* Watch ID for superblock. */
+	__u32		notify_counter;	/* Number of notifications. */
+	__u32		__reserved[1];
+};
+
+#define FSINFO_ATTR_SB_NOTIFICATIONS__STRUCT struct fsinfo_sb_notifications
+
 /*
  * Information struct for fsinfo(FSINFO_ATTR_AFS_SERVER_ADDRESSES).
  *
diff --git a/include/uapi/linux/watch_queue.h b/include/uapi/linux/watch_queue.h
index 190d27073302..586f4af965ac 100644
--- a/include/uapi/linux/watch_queue.h
+++ b/include/uapi/linux/watch_queue.h
@@ -151,7 +151,7 @@ enum superblock_notification_type {
  */
 struct superblock_notification {
 	struct watch_notification watch; /* WATCH_TYPE_SB_NOTIFY */
-	__u64	sb_id;			/* 64-bit superblock ID [fsinfo_ids::f_sb_id] */
+	__u64	sb_id;		/* 64-bit superblock ID [fsinfo_sb_notifications::watch_id] */
 };
 
 struct superblock_error_notification {
diff --git a/samples/vfs/test-fsinfo.c b/samples/vfs/test-fsinfo.c
index 6ad0f84c4327..fd425c08b00b 100644
--- a/samples/vfs/test-fsinfo.c
+++ b/samples/vfs/test-fsinfo.c
@@ -306,6 +306,15 @@ static void dump_fsinfo_generic_mount_child(void *reply, unsigned int size)
 	printf("%8x %8x\n", f->mnt_id, f->change_counter);
 }
 
+static void dump_fsinfo_generic_sb_notifications(void *reply, unsigned int size)
+{
+	struct fsinfo_sb_notifications *f = reply;
+
+	printf("\n");
+	printf("\twatch_id: %llx\n", (unsigned long long)f->watch_id);
+	printf("\tnotifs  : %llx\n", (unsigned long long)f->notify_counter);
+}
+
 static void dump_afs_fsinfo_server_address(void *reply, unsigned int size)
 {
 	struct fsinfo_afs_server_address *f = reply;
@@ -416,12 +425,11 @@ static const struct fsinfo_attribute fsinfo_attributes[] = {
 	FSINFO_STRING	(FSINFO_ATTR_VOLUME_ID,		fsinfo_generic_volume_id),
 	FSINFO_VSTRUCT	(FSINFO_ATTR_VOLUME_UUID,	fsinfo_generic_volume_uuid),
 	FSINFO_STRING	(FSINFO_ATTR_VOLUME_NAME,	fsinfo_generic_volume_name),
-
+	FSINFO_VSTRUCT	(FSINFO_ATTR_SB_NOTIFICATIONS,	fsinfo_generic_sb_notifications),
 	FSINFO_VSTRUCT	(FSINFO_ATTR_MOUNT_INFO,	fsinfo_generic_mount_info),
 	FSINFO_STRING	(FSINFO_ATTR_MOUNT_DEVNAME,	fsinfo_generic_mount_devname),
 	FSINFO_LIST	(FSINFO_ATTR_MOUNT_CHILDREN,	fsinfo_generic_mount_child),
 	FSINFO_STRING_N	(FSINFO_ATTR_MOUNT_POINT,	fsinfo_generic_mount_point),
-
 	FSINFO_STRING	(FSINFO_ATTR_AFS_CELL_NAME,	afs_cell_name),
 	FSINFO_STRING	(FSINFO_ATTR_AFS_SERVER_NAME,	afs_server_name),
 	FSINFO_LIST_N	(FSINFO_ATTR_AFS_SERVER_ADDRESSES, afs_fsinfo_server_address),


