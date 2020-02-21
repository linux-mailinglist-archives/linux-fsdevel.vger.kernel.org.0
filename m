Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 779A31685F7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2020 19:03:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729573AbgBUSDk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Feb 2020 13:03:40 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:21083 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726423AbgBUSDk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Feb 2020 13:03:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582308219;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qzVlxJr1DeWwvc3LXR9+diXp8JzAmVhguH2fVi1gt6g=;
        b=AMUzRDWA+Q6STW7SAzBGBe6apneeS8Gq8gXfc50HuL2CGlAvEJXoYK6VJfATmP4dPocCmh
        9tsQGiGiydxv1NW50mrpqWCgk0y1qseFfjQdsdvlXnjvS5o0eb8DQoOONESpW11hXbnhqP
        /uxLtrq/RcTu3azxxHdBo4gwpTsSpbw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-433-rkX6j7A_N0KVBm8_uXIWuQ-1; Fri, 21 Feb 2020 13:03:36 -0500
X-MC-Unique: rkX6j7A_N0KVBm8_uXIWuQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 17469800D5F;
        Fri, 21 Feb 2020 18:03:35 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-122-163.rdu2.redhat.com [10.10.122.163])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0E8FC2718F;
        Fri, 21 Feb 2020 18:03:32 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 13/17] fsinfo: Query superblock unique ID and notification
 counter [ver #17]
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, raven@themaw.net, mszeredi@redhat.com,
        christian@brauner.io, jannh@google.com, darrick.wong@oracle.com,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 21 Feb 2020 18:03:32 +0000
Message-ID: <158230821229.2185128.1448235461648568556.stgit@warthog.procyon.org.uk>
In-Reply-To: <158230810644.2185128.16726948836367716086.stgit@warthog.procyon.org.uk>
References: <158230810644.2185128.16726948836367716086.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.21
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Provide an fsinfo attribute to query the superblock unique ID and
notification counter.  The unique ID is placed in notification events and
the counted it provided so that the changed superblock can be determined in
the event of a notification buffer overrun.  This is accessed with:

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
 include/uapi/linux/fsinfo.h      |   12 ++++++++++++
 include/uapi/linux/watch_queue.h |    2 +-
 samples/vfs/test-fsinfo.c        |   10 ++++++++++
 4 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/fs/fsinfo.c b/fs/fsinfo.c
index e3377842a2c1..4334249339f9 100644
--- a/fs/fsinfo.c
+++ b/fs/fsinfo.c
@@ -217,6 +217,16 @@ static int fsinfo_generic_volume_id(struct path *path, struct fsinfo_context *ct
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
 static const struct fsinfo_attribute fsinfo_common_attributes[] = {
 	FSINFO_VSTRUCT	(FSINFO_ATTR_STATFS,		fsinfo_generic_statfs),
 	FSINFO_VSTRUCT	(FSINFO_ATTR_IDS,		fsinfo_generic_ids),
@@ -226,6 +236,7 @@ static const struct fsinfo_attribute fsinfo_common_attributes[] = {
 	FSINFO_STRING	(FSINFO_ATTR_VOLUME_ID,		fsinfo_generic_volume_id),
 	FSINFO_VSTRUCT	(FSINFO_ATTR_VOLUME_UUID,	fsinfo_generic_volume_uuid),
 	FSINFO_VSTRUCT	(FSINFO_ATTR_FEATURES,		fsinfo_generic_features),
+	FSINFO_VSTRUCT	(FSINFO_ATTR_SB_NOTIFICATIONS,	fsinfo_generic_sb_notifications),
 
 	FSINFO_LIST	(FSINFO_ATTR_FSINFO_ATTRIBUTES,	(void *)123UL),
 	FSINFO_VSTRUCT_N(FSINFO_ATTR_FSINFO_ATTRIBUTE_INFO, (void *)123UL),
diff --git a/include/uapi/linux/fsinfo.h b/include/uapi/linux/fsinfo.h
index 119c371697be..2f9280d16293 100644
--- a/include/uapi/linux/fsinfo.h
+++ b/include/uapi/linux/fsinfo.h
@@ -23,6 +23,7 @@
 #define FSINFO_ATTR_VOLUME_UUID		0x06	/* Volume UUID (LE uuid) */
 #define FSINFO_ATTR_VOLUME_NAME		0x07	/* Volume name (string) */
 #define FSINFO_ATTR_FEATURES		0x08	/* Filesystem features (bits) */
+#define FSINFO_ATTR_SB_NOTIFICATIONS	0x09	/* sb_notify() information */
 
 #define FSINFO_ATTR_FSINFO_ATTRIBUTE_INFO 0x100	/* Information about attr N (for path) */
 #define FSINFO_ATTR_FSINFO_ATTRIBUTES	0x101	/* List of supported attrs (for path) */
@@ -286,4 +287,15 @@ struct fsinfo_volume_uuid {
 
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
 #endif /* _UAPI_LINUX_FSINFO_H */
diff --git a/include/uapi/linux/watch_queue.h b/include/uapi/linux/watch_queue.h
index e9c37b1ae68d..9ac2ea6f4a75 100644
--- a/include/uapi/linux/watch_queue.h
+++ b/include/uapi/linux/watch_queue.h
@@ -151,7 +151,7 @@ enum superblock_notification_type {
  */
 struct superblock_notification {
 	struct watch_notification watch; /* WATCH_TYPE_SB_NOTIFY */
-	__u64	sb_id;			/* 64-bit superblock ID */
+	__u64	sb_id;			/* 64-bit superblock ID [FSINFO_ATTR_SB_NOTIFICATIONS] */
 };
 
 struct superblock_error_notification {
diff --git a/samples/vfs/test-fsinfo.c b/samples/vfs/test-fsinfo.c
index 6a61f3426982..247fae5bbb74 100644
--- a/samples/vfs/test-fsinfo.c
+++ b/samples/vfs/test-fsinfo.c
@@ -303,6 +303,15 @@ static void dump_fsinfo_generic_mount_child(void *reply, unsigned int size)
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
 static void dump_string(void *reply, unsigned int size)
 {
 	char *s = reply, *p;
@@ -367,6 +376,7 @@ static const struct fsinfo_attribute fsinfo_attributes[] = {
 	FSINFO_STRING	(FSINFO_ATTR_VOLUME_ID,		fsinfo_generic_volume_id),
 	FSINFO_VSTRUCT	(FSINFO_ATTR_VOLUME_UUID,	fsinfo_generic_volume_uuid),
 	FSINFO_STRING	(FSINFO_ATTR_VOLUME_NAME,	fsinfo_generic_volume_name),
+	FSINFO_VSTRUCT	(FSINFO_ATTR_SB_NOTIFICATIONS,	fsinfo_generic_sb_notifications),
 
 	FSINFO_VSTRUCT	(FSINFO_ATTR_MOUNT_INFO,	fsinfo_generic_mount_info),
 	FSINFO_STRING	(FSINFO_ATTR_MOUNT_DEVNAME,	fsinfo_generic_mount_devname),


