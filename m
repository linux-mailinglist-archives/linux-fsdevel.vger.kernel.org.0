Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 104D51685D7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2020 19:02:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729451AbgBUSC3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Feb 2020 13:02:29 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26523 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726066AbgBUSC2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Feb 2020 13:02:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582308145;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lIl029QxOv3lUsZSV0uRKyqp9AfjU/t4KKE3QbkzNGc=;
        b=XWTC97dhT65xeiszuJO9FVQJBq692TfLOeAlgZMHrmqT+gMFFf+VbCX3mFL5ZCAssY6kaB
        ysFdKr+sJJ6/2knCT4nNeOQQt+LEGNyIOE37v858M81Hd2HN/6iH9Hm54068pZiLiTZhEs
        eFgXLUBwxUZQn6HHGysKBUX4/6q1A8E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-308-alKxphWwM2y0ny3l0mGNuA-1; Fri, 21 Feb 2020 13:02:22 -0500
X-MC-Unique: alKxphWwM2y0ny3l0mGNuA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8D2608017DF;
        Fri, 21 Feb 2020 18:02:20 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-122-163.rdu2.redhat.com [10.10.122.163])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E0FFD2708E;
        Fri, 21 Feb 2020 18:02:18 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 04/17] watch_queue: Introduce a non-repeating system-unique
 superblock ID [ver #17]
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, raven@themaw.net, mszeredi@redhat.com,
        christian@brauner.io, jannh@google.com, darrick.wong@oracle.com,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 21 Feb 2020 18:02:18 +0000
Message-ID: <158230813823.2185128.2640121651515347574.stgit@warthog.procyon.org.uk>
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

Introduce an (effectively) non-repeating system-unique superblock ID that
can be used to determine that two object are in the same superblock without
risking reuse of the ID in the meantime (as is possible with device IDs).

The ID is time-based to make it harder to use it as a covert communications
channel.

In future patches, this ID will be used to tag superblock notification
messages.  It will also be made queryable.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/super.c         |   24 ++++++++++++++++++++++++
 include/linux/fs.h |    3 +++
 2 files changed, 27 insertions(+)

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
index 3cd4fe6b845e..9de6bfe41016 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1548,6 +1548,9 @@ struct super_block {
 
 	spinlock_t		s_inode_wblist_lock;
 	struct list_head	s_inodes_wb;	/* writeback inodes */
+
+	/* Superblock event notifications */
+	u64			s_unique_id;
 } __randomize_layout;
 
 /* Helper functions so that in most cases filesystems will


