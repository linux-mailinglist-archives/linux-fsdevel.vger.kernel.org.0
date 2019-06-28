Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F1E959FF2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2019 17:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727520AbfF1PvH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jun 2019 11:51:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58182 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726750AbfF1PvG (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jun 2019 11:51:06 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E70F82F8BD5;
        Fri, 28 Jun 2019 15:51:05 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-219.rdu2.redhat.com [10.10.120.219])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2823E5C22C;
        Fri, 28 Jun 2019 15:51:03 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 5/6] fsinfo: Export superblock notification counter [ver #5]
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        nicolas.dichtel@6wind.com, raven@themaw.net,
        Christian Brauner <christian@brauner.io>, dhowells@redhat.com,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-block@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 28 Jun 2019 16:51:02 +0100
Message-ID: <156173706239.15650.12470185124940061354.stgit@warthog.procyon.org.uk>
In-Reply-To: <156173701358.15650.8735203424342507015.stgit@warthog.procyon.org.uk>
References: <156173701358.15650.8735203424342507015.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Fri, 28 Jun 2019 15:51:06 +0000 (UTC)
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
index 758d1cbf8eba..a328f659ecb3 100644
--- a/fs/fsinfo.c
+++ b/fs/fsinfo.c
@@ -321,6 +321,16 @@ void fsinfo_note_sb_params(struct fsinfo_kparams *params, unsigned int s_flags)
 }
 EXPORT_SYMBOL(fsinfo_note_sb_params);
 
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
 static int fsinfo_generic_parameters(struct path *path,
 				     struct fsinfo_kparams *params)
 {
@@ -357,6 +367,7 @@ int generic_fsinfo(struct path *path, struct fsinfo_kparams *params)
 	case _genp(MOUNT_DEVNAME,	mount_devname);
 	case _genp(MOUNT_CHILDREN,	mount_children);
 	case _genp(MOUNT_SUBMOUNT,	mount_submount);
+	case _gen(SB_NOTIFICATIONS,	sb_notifications);
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -645,6 +656,7 @@ static const struct fsinfo_attr_info fsinfo_buffer_info[FSINFO_ATTR__NR] = {
 	FSINFO_STRING		(MOUNT_DEVNAME),
 	FSINFO_STRUCT_ARRAY	(MOUNT_CHILDREN,	mount_child),
 	FSINFO_STRING_N		(MOUNT_SUBMOUNT),
+	FSINFO_STRUCT		(SB_NOTIFICATIONS,	sb_notifications),
 };
 
 /**
diff --git a/fs/super.c b/fs/super.c
index 9f631cd4f93b..b338d2c6aca4 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1840,6 +1840,7 @@ EXPORT_SYMBOL(thaw_super);
  */
 void post_sb_notification(struct super_block *s, struct superblock_notification *n)
 {
+	atomic_inc(&s->s_notify_counter);
 	post_watch_notification(s->s_watchers, &n->watch, current_cred(),
 				s->s_unique_id);
 }
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 42adb7a391a9..25586732b127 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1535,6 +1535,7 @@ struct super_block {
 #ifdef CONFIG_SB_NOTIFICATIONS
 	struct watch_list	*s_watchers;
 #endif
+	atomic_t		s_notify_counter;
 } __randomize_layout;
 
 /* Helper functions so that in most cases filesystems will
diff --git a/include/uapi/linux/fsinfo.h b/include/uapi/linux/fsinfo.h
index 401ad9625c11..b9b3026a40a1 100644
--- a/include/uapi/linux/fsinfo.h
+++ b/include/uapi/linux/fsinfo.h
@@ -39,6 +39,7 @@ enum fsinfo_attribute {
 	FSINFO_ATTR_MOUNT_DEVNAME	= 21,	/* Mount object device name (string) */
 	FSINFO_ATTR_MOUNT_CHILDREN	= 22,	/* Submount list (array) */
 	FSINFO_ATTR_MOUNT_SUBMOUNT	= 23,	/* Relative path of Nth submount (string) */
+	FSINFO_ATTR_SB_NOTIFICATIONS	= 24,	/* sb_notify() information */
 	FSINFO_ATTR__NR
 };
 
@@ -316,4 +317,13 @@ struct fsinfo_mount_child {
 	__u32		change_counter;	/* Number of changes applied to mount. */
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
index c8f0adefd8de..11d1d24b83cb 100644
--- a/include/uapi/linux/watch_queue.h
+++ b/include/uapi/linux/watch_queue.h
@@ -217,7 +217,7 @@ enum superblock_notification_type {
  */
 struct superblock_notification {
 	struct watch_notification watch; /* WATCH_TYPE_SB_NOTIFY */
-	__u64	sb_id;			/* 64-bit superblock ID [fsinfo_ids::f_sb_id] */
+	__u64	sb_id;		/* 64-bit superblock ID [fsinfo_sb_notifications::watch_id] */
 };
 
 struct superblock_error_notification {
diff --git a/samples/vfs/test-fsinfo.c b/samples/vfs/test-fsinfo.c
index 28c9f3cd2c8c..6cac56bbfe4f 100644
--- a/samples/vfs/test-fsinfo.c
+++ b/samples/vfs/test-fsinfo.c
@@ -90,6 +90,7 @@ static const struct fsinfo_attr_info fsinfo_buffer_info[FSINFO_ATTR__NR] = {
 	FSINFO_STRING		(MOUNT_DEVNAME,		mount_devname),
 	FSINFO_STRUCT_ARRAY	(MOUNT_CHILDREN,	mount_child),
 	FSINFO_STRING_N		(MOUNT_SUBMOUNT,	mount_submount),
+	FSINFO_STRUCT		(SB_NOTIFICATIONS,	sb_notifications),
 };
 
 #define FSINFO_NAME(X,Y) [FSINFO_ATTR_##X] = #Y
@@ -118,6 +119,7 @@ static const char *fsinfo_attr_names[FSINFO_ATTR__NR] = {
 	FSINFO_NAME		(MOUNT_DEVNAME,		mount_devname),
 	FSINFO_NAME		(MOUNT_CHILDREN,	mount_children),
 	FSINFO_NAME		(MOUNT_SUBMOUNT,	mount_submount),
+	FSINFO_NAME		(SB_NOTIFICATIONS,	sb_notifications),
 };
 
 union reply {
@@ -133,6 +135,7 @@ union reply {
 	struct fsinfo_server_address srv_addr;
 	struct fsinfo_mount_info mount_info;
 	struct fsinfo_mount_child mount_children[1];
+	struct fsinfo_sb_notifications sb_notifications;
 };
 
 static void dump_hex(unsigned int *data, int from, int to)
@@ -384,6 +387,15 @@ static void dump_attr_MOUNT_CHILDREN(union reply *r, int size)
 		printf("\t[%u] %8x %8x\n", i++, f->mnt_id, f->change_counter);
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
@@ -402,6 +414,7 @@ static const dumper_t fsinfo_attr_dumper[FSINFO_ATTR__NR] = {
 	FSINFO_DUMPER(SERVER_ADDRESS),
 	FSINFO_DUMPER(MOUNT_INFO),
 	FSINFO_DUMPER(MOUNT_CHILDREN),
+	FSINFO_DUMPER(SB_NOTIFICATIONS),
 };
 
 static void dump_fsinfo(enum fsinfo_attribute attr,

