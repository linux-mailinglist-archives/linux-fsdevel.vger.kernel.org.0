Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64E9850D6E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2019 16:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731873AbfFXOKA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jun 2019 10:10:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:64877 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731909AbfFXOJx (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jun 2019 10:09:53 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C757818DF6C;
        Mon, 24 Jun 2019 14:09:52 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-57.rdu2.redhat.com [10.10.120.57])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 396A619C6A;
        Mon, 24 Jun 2019 14:09:51 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 07/25] vfs: Introduce a non-repeating system-unique
 superblock ID [ver #14]
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, raven@themaw.net, mszeredi@redhat.com,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 24 Jun 2019 15:09:50 +0100
Message-ID: <156138539043.25627.235369193681671359.stgit@warthog.procyon.org.uk>
In-Reply-To: <156138532485.25627.7459410522109581052.stgit@warthog.procyon.org.uk>
References: <156138532485.25627.7459410522109581052.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Mon, 24 Jun 2019 14:09:52 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Introduce a non-repeating system-unique superblock ID that can be used to
tag superblock notification messages.  The ID is time-based to make it
harder to use it as a covert communications channel.

Make it so that this ID can be fetched by the fsinfo() system call.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/fsinfo.c               |    1 +
 fs/super.c                |   24 ++++++++++++++++++++++++
 include/linux/fs.h        |    3 +++
 samples/vfs/test-fsinfo.c |    1 +
 4 files changed, 29 insertions(+)

diff --git a/fs/fsinfo.c b/fs/fsinfo.c
index b3d517654c98..127538193b77 100644
--- a/fs/fsinfo.c
+++ b/fs/fsinfo.c
@@ -82,6 +82,7 @@ static int fsinfo_generic_ids(struct path *path, struct fsinfo_ids *p)
 	p->f_fstype	= sb->s_magic;
 	p->f_dev_major	= MAJOR(sb->s_dev);
 	p->f_dev_minor	= MINOR(sb->s_dev);
+	p->f_sb_id	= sb->s_unique_id;
 
 	memcpy(&p->f_fsid, &buf.f_fsid, sizeof(p->f_fsid));
 	strlcpy(p->f_fs_name, path->dentry->d_sb->s_type->name,
diff --git a/fs/super.c b/fs/super.c
index 27b3e41394c8..61819e8e5469 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -43,6 +43,8 @@ static int thaw_super_locked(struct super_block *sb);
 
 static LIST_HEAD(super_blocks);
 static DEFINE_SPINLOCK(sb_lock);
+static u64 sb_last_identifier;
+static u64 sb_identifier_offset;
 
 static char *sb_writers_name[SB_FREEZE_LEVELS] = {
 	"sb_writers",
@@ -187,6 +189,27 @@ static void destroy_unused_super(struct super_block *s)
 	destroy_super_work(&s->destroy_work);
 }
 
+/*
+ * Generate a unique identifier for a superblock.
+ */
+static void generate_super_id(struct super_block *s)
+{
+	u64 id = ktime_to_ns(ktime_get());
+
+	spin_lock(&sb_lock);
+
+	id += sb_identifier_offset;
+	if (id <= sb_last_identifier) {
+		id = sb_last_identifier + 1;
+		sb_identifier_offset = sb_last_identifier - id;
+	}
+
+	sb_last_identifier = id;
+	spin_unlock(&sb_lock);
+
+	s->s_unique_id = id;
+}
+
 /**
  *	alloc_super	-	create new superblock
  *	@type:	filesystem type superblock should belong to
@@ -270,6 +293,7 @@ static struct super_block *alloc_super(struct file_system_type *type, int flags,
 		goto fail;
 	if (list_lru_init_memcg(&s->s_inode_lru, &s->s_shrink))
 		goto fail;
+	generate_super_id(s);
 	return s;
 
 fail:
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 71ce3b054c42..f1c74596cd77 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1527,6 +1527,9 @@ struct super_block {
 
 	spinlock_t		s_inode_wblist_lock;
 	struct list_head	s_inodes_wb;	/* writeback inodes */
+
+	/* Superblock event notifications */
+	u64			s_unique_id;
 } __randomize_layout;
 
 /* Helper functions so that in most cases filesystems will
diff --git a/samples/vfs/test-fsinfo.c b/samples/vfs/test-fsinfo.c
index f865bc1af16f..fadc5e1384fc 100644
--- a/samples/vfs/test-fsinfo.c
+++ b/samples/vfs/test-fsinfo.c
@@ -178,6 +178,7 @@ static void dump_attr_IDS(union reply *r, int size)
 	printf("\tdev   : %02x:%02x\n", f->f_dev_major, f->f_dev_minor);
 	printf("\tfs    : type=%x name=%s\n", f->f_fstype, f->f_fs_name);
 	printf("\tfsid  : %llx\n", (unsigned long long)f->f_fsid);
+	printf("\tsbid  : %llx\n", (unsigned long long)f->f_sb_id);
 }
 
 static void dump_attr_LIMITS(union reply *r, int size)

