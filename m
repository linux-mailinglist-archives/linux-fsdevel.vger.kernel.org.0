Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ACAB22C689
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jul 2020 15:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbgGXNfF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jul 2020 09:35:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45377 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726488AbgGXNfC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jul 2020 09:35:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595597700;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7+vzuxe/5XjGwe/GuFGIwy7OmInPd2x4YKWYHE8bR2E=;
        b=hGoIBtEA7onExzKOsyHWQ8GBHnVhdxBTh5OzJ5V//An2OdAz0hLoHmdvHkRlVjLQqiB5JK
        SLrT+MsmCF2R/zQZn46aSaCmAk8SQ6BTzL+2540aTDW9H89JDE40Ze3cWcU3mYWnrWXAoH
        /ipOIZOsaYvWEw4llH0kA1I+N9lXbN0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-265-y_O4XA88OzKoLjxEhbe1rA-1; Fri, 24 Jul 2020 09:34:59 -0400
X-MC-Unique: y_O4XA88OzKoLjxEhbe1rA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6E0E6193F560;
        Fri, 24 Jul 2020 13:34:57 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-32.rdu2.redhat.com [10.10.112.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EC04670105;
        Fri, 24 Jul 2020 13:34:54 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 01/17] fsinfo: Introduce a non-repeating system-unique
 superblock ID [ver #20]
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org, viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, raven@themaw.net, mszeredi@redhat.com,
        christian@brauner.io, jannh@google.com, darrick.wong@oracle.com,
        kzak@redhat.com, jlayton@redhat.com, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 24 Jul 2020 14:34:54 +0100
Message-ID: <159559769412.2144584.15273582964130112705.stgit@warthog.procyon.org.uk>
In-Reply-To: <159559768062.2144584.13583793543173131929.stgit@warthog.procyon.org.uk>
References: <159559768062.2144584.13583793543173131929.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Introduce an (effectively) non-repeating system-unique superblock ID that
can be used to determine that two objects are in the same superblock
without needing to worry about the ID changing in the meantime (as is
possible with device IDs).

The counter could also be used to tag other features, such as mount
objects.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/internal.h      |    1 +
 fs/super.c         |    2 ++
 include/linux/fs.h |    3 +++
 3 files changed, 6 insertions(+)

diff --git a/fs/internal.h b/fs/internal.h
index 9b863a7bd708..ea60d864a8cb 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -103,6 +103,7 @@ extern struct file *alloc_empty_file_noaccount(int, const struct cred *);
 /*
  * super.c
  */
+extern atomic64_t vfs_unique_counter;
 extern int reconfigure_super(struct fs_context *);
 extern bool trylock_super(struct super_block *sb);
 extern struct super_block *user_get_super(dev_t);
diff --git a/fs/super.c b/fs/super.c
index 904459b35119..21ae8afeba3a 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -44,6 +44,7 @@ static int thaw_super_locked(struct super_block *sb);
 
 static LIST_HEAD(super_blocks);
 static DEFINE_SPINLOCK(sb_lock);
+atomic64_t vfs_unique_counter; /* Unique identifier counter */
 
 static char *sb_writers_name[SB_FREEZE_LEVELS] = {
 	"sb_writers",
@@ -273,6 +274,7 @@ static struct super_block *alloc_super(struct file_system_type *type, int flags,
 		goto fail;
 	if (list_lru_init_memcg(&s->s_inode_lru, &s->s_shrink))
 		goto fail;
+	s->s_unique_id = atomic64_inc_return(&vfs_unique_counter);
 	return s;
 
 fail:
diff --git a/include/linux/fs.h b/include/linux/fs.h
index f5abba86107d..28a29356eace 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1564,6 +1564,9 @@ struct super_block {
 
 	spinlock_t		s_inode_wblist_lock;
 	struct list_head	s_inodes_wb;	/* writeback inodes */
+
+	/* Superblock information */
+	u64			s_unique_id;
 } __randomize_layout;
 
 /* Helper functions so that in most cases filesystems will


