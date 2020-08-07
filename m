Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB90723F361
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Aug 2020 21:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727911AbgHGT5D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Aug 2020 15:57:03 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24445 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726787AbgHGTzx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Aug 2020 15:55:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596830151;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pgkOnz/Nh4hs0X65lv8g5f4dpwzNg0wdBojiwGPKzAM=;
        b=AZ7IKqP8KVXQaAvPvZK4BKSN+zsdYlF1JfAJKj6wfUjiXsxI/cFOpyhmkFGEH9jmTpdhPB
        98uw7YIh9ucA8lDyvqRP10OpMjZ4AR/9ugb3tQGsXladGaAwu/pasetcpGubbN0DxQ9ULC
        HmbtsU4I9Ilf5NPH9GAnUNCzE3cV0nM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-188-mJR_p_AyOBW82OwzD5hBOQ-1; Fri, 07 Aug 2020 15:55:49 -0400
X-MC-Unique: mJR_p_AyOBW82OwzD5hBOQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1F9F2800475;
        Fri,  7 Aug 2020 19:55:48 +0000 (UTC)
Received: from horse.redhat.com (ovpn-113-142.rdu2.redhat.com [10.10.113.142])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 881D770107;
        Fri,  7 Aug 2020 19:55:45 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id C3922222E4B; Fri,  7 Aug 2020 15:55:38 -0400 (EDT)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtio-fs@redhat.com
Cc:     vgoyal@redhat.com, miklos@szeredi.hu, stefanha@redhat.com,
        dgilbert@redhat.com
Subject: [PATCH v2 07/20] fuse: Get rid of no_mount_options
Date:   Fri,  7 Aug 2020 15:55:13 -0400
Message-Id: <20200807195526.426056-8-vgoyal@redhat.com>
In-Reply-To: <20200807195526.426056-1-vgoyal@redhat.com>
References: <20200807195526.426056-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This option was introduced so that for virtio_fs we don't show any mounts
options fuse_show_options(). Because we don't offer any of these options
to be controlled by mounter.

Very soon we are planning to introduce option "dax" which mounter should
be able to specify. And no_mount_options does not work anymore. What
we need is a per mount option specific flag so that fileystem can
specify which options to show.

Add few such flags to control the behavior in more fine grained manner
and get rid of no_mount_options.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 fs/fuse/fuse_i.h    | 14 ++++++++++----
 fs/fuse/inode.c     | 22 ++++++++++++++--------
 fs/fuse/virtio_fs.c |  1 -
 3 files changed, 24 insertions(+), 13 deletions(-)

diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 740a8a7d7ae6..cf5e675100ec 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -471,18 +471,21 @@ struct fuse_fs_context {
 	int fd;
 	unsigned int rootmode;
 	kuid_t user_id;
+	bool user_id_show;
 	kgid_t group_id;
+	bool group_id_show;
 	bool is_bdev:1;
 	bool fd_present:1;
 	bool rootmode_present:1;
 	bool user_id_present:1;
 	bool group_id_present:1;
 	bool default_permissions:1;
+	bool default_permissions_show:1;
 	bool allow_other:1;
+	bool allow_other_show:1;
 	bool destroy:1;
 	bool no_control:1;
 	bool no_force_umount:1;
-	bool no_mount_options:1;
 	unsigned int max_read;
 	unsigned int blksize;
 	const char *subtype;
@@ -512,9 +515,11 @@ struct fuse_conn {
 
 	/** The user id for this mount */
 	kuid_t user_id;
+	bool user_id_show:1;
 
 	/** The group id for this mount */
 	kgid_t group_id;
+	bool group_id_show:1;
 
 	/** The pid namespace for this mount */
 	struct pid_namespace *pid_ns;
@@ -698,10 +703,14 @@ struct fuse_conn {
 
 	/** Check permissions based on the file mode or not? */
 	unsigned default_permissions:1;
+	bool default_permissions_show:1;
 
 	/** Allow other than the mounter user to access the filesystem ? */
 	unsigned allow_other:1;
 
+	/** Show allow_other in mount options */
+	bool allow_other_show:1;
+
 	/** Does the filesystem support copy_file_range? */
 	unsigned no_copy_file_range:1;
 
@@ -717,9 +726,6 @@ struct fuse_conn {
 	/** Do not allow MNT_FORCE umount */
 	unsigned int no_force_umount:1;
 
-	/* Do not show mount options */
-	unsigned int no_mount_options:1;
-
 	/** The number of requests waiting for completion */
 	atomic_t num_waiting;
 
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index bba747520e9b..2ac5713c4c32 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -535,10 +535,12 @@ static int fuse_parse_param(struct fs_context *fc, struct fs_parameter *param)
 
 	case OPT_DEFAULT_PERMISSIONS:
 		ctx->default_permissions = true;
+		ctx->default_permissions_show = true;
 		break;
 
 	case OPT_ALLOW_OTHER:
 		ctx->allow_other = true;
+		ctx->allow_other_show = true;
 		break;
 
 	case OPT_MAX_READ:
@@ -573,14 +575,15 @@ static int fuse_show_options(struct seq_file *m, struct dentry *root)
 	struct super_block *sb = root->d_sb;
 	struct fuse_conn *fc = get_fuse_conn_super(sb);
 
-	if (fc->no_mount_options)
-		return 0;
-
-	seq_printf(m, ",user_id=%u", from_kuid_munged(fc->user_ns, fc->user_id));
-	seq_printf(m, ",group_id=%u", from_kgid_munged(fc->user_ns, fc->group_id));
-	if (fc->default_permissions)
+	if (fc->user_id_show)
+		seq_printf(m, ",user_id=%u",
+			   from_kuid_munged(fc->user_ns, fc->user_id));
+	if (fc->group_id_show)
+		seq_printf(m, ",group_id=%u",
+			   from_kgid_munged(fc->user_ns, fc->group_id));
+	if (fc->default_permissions && fc->default_permissions_show)
 		seq_puts(m, ",default_permissions");
-	if (fc->allow_other)
+	if (fc->allow_other && fc->allow_other_show)
 		seq_puts(m, ",allow_other");
 	if (fc->max_read != ~0)
 		seq_printf(m, ",max_read=%u", fc->max_read);
@@ -1193,14 +1196,17 @@ int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
 	sb->s_flags |= SB_POSIXACL;
 
 	fc->default_permissions = ctx->default_permissions;
+	fc->default_permissions_show = ctx->default_permissions_show;
 	fc->allow_other = ctx->allow_other;
+	fc->allow_other_show = ctx->allow_other_show;
 	fc->user_id = ctx->user_id;
+	fc->user_id_show = ctx->user_id_show;
 	fc->group_id = ctx->group_id;
+	fc->group_id_show = ctx->group_id_show;
 	fc->max_read = max_t(unsigned, 4096, ctx->max_read);
 	fc->destroy = ctx->destroy;
 	fc->no_control = ctx->no_control;
 	fc->no_force_umount = ctx->no_force_umount;
-	fc->no_mount_options = ctx->no_mount_options;
 
 	err = -ENOMEM;
 	root = fuse_get_root_inode(sb, ctx->rootmode);
diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index e615edfbd09c..afddae8ee2ec 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -1096,7 +1096,6 @@ static int virtio_fs_fill_super(struct super_block *sb)
 		.destroy = true,
 		.no_control = true,
 		.no_force_umount = true,
-		.no_mount_options = true,
 	};
 
 	mutex_lock(&virtio_fs_mutex);
-- 
2.25.4

