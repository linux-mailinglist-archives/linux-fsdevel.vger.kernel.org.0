Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B42D37063
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2019 11:43:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728155AbfFFJnB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jun 2019 05:43:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40136 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727891AbfFFJnB (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jun 2019 05:43:01 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BB3663087BA9;
        Thu,  6 Jun 2019 09:43:00 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-173.rdu2.redhat.com [10.10.120.173])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E6F1A60BC3;
        Thu,  6 Jun 2019 09:42:57 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 06/10] fsinfo: Export superblock notification counter [ver
 #3]
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, raven@themaw.net,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-block@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 06 Jun 2019 10:42:57 +0100
Message-ID: <155981417717.17513.456246833950321215.stgit@warthog.procyon.org.uk>
In-Reply-To: <155981411940.17513.7137844619951358374.stgit@warthog.procyon.org.uk>
References: <155981411940.17513.7137844619951358374.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Thu, 06 Jun 2019 09:43:00 +0000 (UTC)
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

 fs/fsinfo.c                      |   12 ++++++++++++
 fs/super.c                       |    1 +
 include/linux/fs.h               |    1 +
 include/uapi/linux/fsinfo.h      |   10 ++++++++++
 include/uapi/linux/watch_queue.h |    2 +-
 samples/vfs/test-fsinfo.c        |   13 +++++++++++++
 6 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/fs/fsinfo.c b/fs/fsinfo.c
index 3ec64d3cba08..1456e26d2f7c 100644
--- a/fs/fsinfo.c
+++ b/fs/fsinfo.c
@@ -284,6 +284,16 @@ static int fsinfo_generic_param_enum(struct file_system_type *f,
 	return sizeof(*p);
 }
 
+static int fsinfo_generic_sb_notifications(struct path *path,
+					   struct fsinfo_sb_notifications *p)
+{
+	struct super_block *sb = path->dentry->d_sb;
+
+	p->watch_id		= sb->s_unique_id;
+	p->notify_counter	= atomic_read(&sb->s_notify_counter);
+	return sizeof(*p);
+}
+
 static void fsinfo_insert_sb_flag_parameters(struct path *path,
 					     struct fsinfo_kparams *params)
 {
@@ -331,6 +341,7 @@ int generic_fsinfo(struct path *path, struct fsinfo_kparams *params)
 	case _genp(MOUNT_DEVNAME,	mount_devname);
 	case _genp(MOUNT_CHILDREN,	mount_children);
 	case _genp(MOUNT_SUBMOUNT,	mount_submount);
+	case _gen(SB_NOTIFICATIONS,	sb_notifications);
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -606,6 +617,7 @@ static const struct fsinfo_attr_info fsinfo_buffer_info[FSINFO_ATTR__NR] = {
 	FSINFO_STRING_N		(SERVER_NAME,		server_name),
 	FSINFO_STRUCT_NM	(SERVER_ADDRESS,	server_address),
 	FSINFO_STRING		(CELL_NAME,		cell_name),
+	FSINFO_STRUCT		(SB_NOTIFICATIONS,	sb_notifications),
 };
 
 /**
diff --git a/fs/super.c b/fs/super.c
index cddf23f1d648..da428702e725 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1823,6 +1823,7 @@ EXPORT_SYMBOL(thaw_super);
  */
 void post_sb_notification(struct super_block *s, struct superblock_notification *n)
 {
+	atomic_inc(&s->s_notify_counter);
 	post_watch_notification(s->s_watchers, &n->watch, current_cred(),
 				s->s_unique_id);
 }
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 02ba4bfb9cc3..06e272a25ed7 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1536,6 +1536,7 @@ struct super_block {
 #ifdef CONFIG_SB_NOTIFICATIONS
 	struct watch_list	*s_watchers;
 #endif
+	atomic_t		s_notify_counter;
 } __randomize_layout;
 
 /* Helper functions so that in most cases filesystems will
diff --git a/include/uapi/linux/fsinfo.h b/include/uapi/linux/fsinfo.h
index 7247088332c2..b4c9446305bb 100644
--- a/include/uapi/linux/fsinfo.h
+++ b/include/uapi/linux/fsinfo.h
@@ -39,6 +39,7 @@ enum fsinfo_attribute {
 	FSINFO_ATTR_SERVER_NAME		= 21,	/* Name of the Nth server (string) */
 	FSINFO_ATTR_SERVER_ADDRESS	= 22,	/* Mth address of the Nth server */
 	FSINFO_ATTR_CELL_NAME		= 23,	/* Cell name (string) */
+	FSINFO_ATTR_SB_NOTIFICATIONS	= 24,	/* sb_notify() information */
 	FSINFO_ATTR__NR
 };
 
@@ -308,4 +309,13 @@ struct fsinfo_server_address {
 	struct __kernel_sockaddr_storage address;
 };
 
+/*
+ * Information struct for fsinfo(FSINFO_ATTR_SB_NOTIFICATIONS).
+ */
+struct fsinfo_sb_notifications {
+	__u64		watch_id;	/* Watch ID for superblock. */
+	__u32		notify_counter;	/* Number of notifications. */
+	__u32		__reserved[1];
+};
+
 #endif /* _UAPI_LINUX_FSINFO_H */
diff --git a/include/uapi/linux/watch_queue.h b/include/uapi/linux/watch_queue.h
index 66b0da7cf888..aeffcfd7a742 100644
--- a/include/uapi/linux/watch_queue.h
+++ b/include/uapi/linux/watch_queue.h
@@ -146,7 +146,7 @@ enum superblock_notification_type {
  */
 struct superblock_notification {
 	struct watch_notification watch; /* WATCH_TYPE_SB_NOTIFY */
-	__u64	sb_id;			/* 64-bit superblock ID [fsinfo_ids::f_sb_id] */
+	__u64	sb_id;		/* 64-bit superblock ID [fsinfo_sb_notifications::watch_id] */
 };
 
 struct superblock_error_notification {
diff --git a/samples/vfs/test-fsinfo.c b/samples/vfs/test-fsinfo.c
index af29da74559e..0f8f9ded0925 100644
--- a/samples/vfs/test-fsinfo.c
+++ b/samples/vfs/test-fsinfo.c
@@ -90,6 +90,7 @@ static const struct fsinfo_attr_info fsinfo_buffer_info[FSINFO_ATTR__NR] = {
 	FSINFO_STRING_N		(SERVER_NAME,		server_name),
 	FSINFO_STRUCT_NM	(SERVER_ADDRESS,	server_address),
 	FSINFO_STRING		(CELL_NAME,		cell_name),
+	FSINFO_STRUCT		(SB_NOTIFICATIONS,	sb_notifications),
 };
 
 #define FSINFO_NAME(X,Y) [FSINFO_ATTR_##X] = #Y
@@ -118,6 +119,7 @@ static const char *fsinfo_attr_names[FSINFO_ATTR__NR] = {
 	FSINFO_NAME		(SERVER_NAME,		server_name),
 	FSINFO_NAME		(SERVER_ADDRESS,	server_address),
 	FSINFO_NAME		(CELL_NAME,		cell_name),
+	FSINFO_NAME		(SB_NOTIFICATIONS,	sb_notifications),
 };
 
 union reply {
@@ -133,6 +135,7 @@ union reply {
 	struct fsinfo_mount_info mount_info;
 	struct fsinfo_mount_child mount_children[1];
 	struct fsinfo_server_address srv_addr;
+	struct fsinfo_sb_notifications sb_notifications;
 };
 
 static void dump_hex(unsigned int *data, int from, int to)
@@ -377,6 +380,15 @@ static void dump_attr_MOUNT_CHILDREN(union reply *r, int size)
 		printf("\t[%u] %8x %8x\n", i++, f->mnt_id, f->notify_counter);
 }
 
+static void dump_attr_SB_NOTIFICATIONS(union reply *r, int size)
+{
+	struct fsinfo_sb_notifications *f = &r->sb_notifications;
+
+	printf("\n");
+	printf("\twatch_id: %llx\n", (unsigned long long)f->watch_id);
+	printf("\tnotifs  : %llx\n", (unsigned long long)f->notify_counter);
+}
+
 /*
  *
  */
@@ -395,6 +407,7 @@ static const dumper_t fsinfo_attr_dumper[FSINFO_ATTR__NR] = {
 	FSINFO_DUMPER(MOUNT_INFO),
 	FSINFO_DUMPER(MOUNT_CHILDREN),
 	FSINFO_DUMPER(SERVER_ADDRESS),
+	FSINFO_DUMPER(SB_NOTIFICATIONS),
 };
 
 static void dump_fsinfo(enum fsinfo_attribute attr,

