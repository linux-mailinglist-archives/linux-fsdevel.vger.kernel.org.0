Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1C74162B5C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2020 18:06:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbgBRRFu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Feb 2020 12:05:50 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38680 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726840AbgBRRFs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Feb 2020 12:05:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582045547;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fGZxSELfqrHJPKRn840iFp6Yuj5hlSA7GNsiSFEGbXE=;
        b=TfQvv/VVM0DKFxbsI19z7HnqjVHiCeb7vaqEVwgmcSitr5iAC2tFpc3E6e+sAuhfMpwCXq
        mLVUYziY1XmdAHebV+oHGG3GBAVVqFXNXHmw3Pu1hlN3QuHMGFMICajwgfPGosW8yPLFPC
        nU26S+SA2S96ULvRP+t4t0tpWZXVuOs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-157-rlE6BNOMNo2MgjOGR0BXcg-1; Tue, 18 Feb 2020 12:05:41 -0500
X-MC-Unique: rlE6BNOMNo2MgjOGR0BXcg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1CD58800D5E;
        Tue, 18 Feb 2020 17:05:38 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-122-163.rdu2.redhat.com [10.10.122.163])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 68F2319757;
        Tue, 18 Feb 2020 17:05:36 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 05/19] vfs: Introduce a non-repeating system-unique superblock
 ID [ver #16]
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, raven@themaw.net, mszeredi@redhat.com,
        christian@brauner.io, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 18 Feb 2020 17:05:35 +0000
Message-ID: <158204553565.3299825.3864357054582488949.stgit@warthog.procyon.org.uk>
In-Reply-To: <158204549488.3299825.3783690177353088425.stgit@warthog.procyon.org.uk>
References: <158204549488.3299825.3783690177353088425.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.21
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Introduce an (effectively) non-repeating system-unique superblock ID that
can be used to determine that two object are in the same superblock without
risking reuse of the ID in the meantime (as is possible with device IDs).

The ID is time-based to make it harder to use it as a covert communications
channel.

Also make it so that this ID can be fetched by the fsinfo() system call.
The ID added so that superblock notification messages will also be able to
be tagged with it.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/fsinfo.c               |    1 +
 fs/super.c                |   24 ++++++++++++++++++++++++
 include/linux/fs.h        |    3 +++
 samples/vfs/test-fsinfo.c |    1 +
 4 files changed, 29 insertions(+)

diff --git a/fs/fsinfo.c b/fs/fsinfo.c
index 55710d6da327..f8e85762fc47 100644
--- a/fs/fsinfo.c
+++ b/fs/fsinfo.c
@@ -92,6 +92,7 @@ static int fsinfo_generic_ids(struct path *path, struct fsinfo_context *ctx)
 	p->f_fstype	= sb->s_magic;
 	p->f_dev_major	= MAJOR(sb->s_dev);
 	p->f_dev_minor	= MINOR(sb->s_dev);
+	p->f_sb_id	= sb->s_unique_id;
 
 	memcpy(&p->f_fsid, &buf.f_fsid, sizeof(p->f_fsid));
 	strlcpy(p->f_fs_name, path->dentry->d_sb->s_type->name,
diff --git a/fs/super.c b/fs/super.c
index cd352530eca9..a63073e6127e 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -44,6 +44,8 @@ static int thaw_super_locked(struct super_block *sb);
 
 static LIST_HEAD(super_blocks);
 static DEFINE_SPINLOCK(sb_lock);
+static u64 sb_last_identifier;
+static u64 sb_identifier_offset;
 
 static char *sb_writers_name[SB_FREEZE_LEVELS] = {
 	"sb_writers",
@@ -188,6 +190,27 @@ static void destroy_unused_super(struct super_block *s)
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
@@ -273,6 +296,7 @@ static struct super_block *alloc_super(struct file_system_type *type, int flags,
 		goto fail;
 	if (list_lru_init_memcg(&s->s_inode_lru, &s->s_shrink))
 		goto fail;
+	generate_super_id(s);
 	return s;
 
 fail:
diff --git a/include/linux/fs.h b/include/linux/fs.h
index f74a4ee36eb3..e5db22d536a3 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1550,6 +1550,9 @@ struct super_block {
 
 	spinlock_t		s_inode_wblist_lock;
 	struct list_head	s_inodes_wb;	/* writeback inodes */
+
+	/* Superblock event notifications */
+	u64			s_unique_id;
 } __randomize_layout;
 
 /* Helper functions so that in most cases filesystems will
diff --git a/samples/vfs/test-fsinfo.c b/samples/vfs/test-fsinfo.c
index 6fbf0ce099b2..d6ec5713364f 100644
--- a/samples/vfs/test-fsinfo.c
+++ b/samples/vfs/test-fsinfo.c
@@ -140,6 +140,7 @@ static void dump_fsinfo_generic_ids(void *reply, unsigned int size)
 	printf("\tdev          : %02x:%02x\n", f->f_dev_major, f->f_dev_minor);
 	printf("\tfs           : type=%x name=%s\n", f->f_fstype, f->f_fs_name);
 	printf("\tfsid         : %llx\n", (unsigned long long)f->f_fsid);
+	printf("\tsbid         : %llx\n", (unsigned long long)f->f_sb_id);
 }
 
 static void dump_fsinfo_generic_limits(void *reply, unsigned int size)


