Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E805D23A78E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Aug 2020 15:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbgHCNgu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Aug 2020 09:36:50 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43133 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727091AbgHCNgm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Aug 2020 09:36:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596461801;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7+vzuxe/5XjGwe/GuFGIwy7OmInPd2x4YKWYHE8bR2E=;
        b=EnpESboyU4lNEwEET6FpjZ3DkY+PIskWTzSoDiSqpUSoP5+8Xjdc+YSXvaj8nTr5gVkJna
        OlifoIkhuTvy71zvhNw/eCmnyxsJoFteiaYfAMrohQuH89erWbi7m5BwFNeH7aiLkb+GjQ
        dQCFfwpxRqbkn+ldJdTDPPJrgV2+vmM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-11--NZquvIRNb6g8gRSpMhrHA-1; Mon, 03 Aug 2020 09:36:39 -0400
X-MC-Unique: -NZquvIRNb6g8gRSpMhrHA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 59EE8106B261;
        Mon,  3 Aug 2020 13:36:37 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-32.rdu2.redhat.com [10.10.112.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DC9A81002391;
        Mon,  3 Aug 2020 13:36:34 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 01/18] fsinfo: Introduce a non-repeating system-unique
 superblock ID [ver #21]
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, torvalds@linux-foundation.org,
        raven@themaw.net, mszeredi@redhat.com, christian@brauner.io,
        jannh@google.com, darrick.wong@oracle.com, kzak@redhat.com,
        jlayton@redhat.com, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 03 Aug 2020 14:36:34 +0100
Message-ID: <159646179405.1784947.10794350637774567265.stgit@warthog.procyon.org.uk>
In-Reply-To: <159646178122.1784947.11705396571718464082.stgit@warthog.procyon.org.uk>
References: <159646178122.1784947.11705396571718464082.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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


