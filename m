Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B60E17DFFC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Mar 2020 13:19:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbgCIMTg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Mar 2020 08:19:36 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:23611 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726960AbgCIMTg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Mar 2020 08:19:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583756375;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mNe5FXIJgaTTxcZUzoNqigtglNmi1s6RXMo3hSpyIPo=;
        b=TJIvAmPF2O68MKOawhJzEseP3TVm4T26YjphOzMxs74wLFbQDTp1cYWx//Ki1uJIzGmSgD
        tTN5kkYIR7ctmqhz3sXDXR52Mlt/CgdNaSc6gQ5fYpXkjhmhuhXJ/yDLgb9hfZeAl+8G4z
        RPXpQ+650FqKFqJSgV2D0dNh6wktgYU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-111-5i7DOMWZOwGdfT3p9YRR7w-1; Mon, 09 Mar 2020 08:19:34 -0400
X-MC-Unique: 5i7DOMWZOwGdfT3p9YRR7w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F29A1107ACCD;
        Mon,  9 Mar 2020 12:19:31 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-182.rdu2.redhat.com [10.10.120.182])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2E2105C1C3;
        Mon,  9 Mar 2020 12:19:29 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 15/17] watch_queue: Introduce a non-repeating
 system-unique superblock ID [ver #4]
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org, viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, dhowells@redhat.com, casey@schaufler-ca.com,
        sds@tycho.nsa.gov, nicolas.dichtel@6wind.com, raven@themaw.net,
        christian@brauner.io, andres@anarazel.de, jlayton@redhat.com,
        dray@redhat.com, kzak@redhat.com, keyrings@vger.kernel.org,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 09 Mar 2020 12:19:28 +0000
Message-ID: <158375636846.334846.3569223596340231054.stgit@warthog.procyon.org.uk>
In-Reply-To: <158375623086.334846.16121725232323108842.stgit@warthog.procyon.org.uk>
References: <158375623086.334846.16121725232323108842.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.21
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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

 fs/internal.h      |    1 +
 fs/super.c         |   24 ++++++++++++++++++++++++
 include/linux/fs.h |    3 +++
 3 files changed, 28 insertions(+)

diff --git a/fs/internal.h b/fs/internal.h
index f3f280b952a3..a0d90f23593c 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -109,6 +109,7 @@ extern int reconfigure_super(struct fs_context *);
 extern bool trylock_super(struct super_block *sb);
 extern struct super_block *user_get_super(dev_t);
 extern bool mount_capable(struct fs_context *);
+extern void vfs_generate_unique_id(u64 *);
 
 /*
  * open.c
diff --git a/fs/super.c b/fs/super.c
index cd352530eca9..ececa5695fd1 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -44,6 +44,8 @@ static int thaw_super_locked(struct super_block *sb);
 
 static LIST_HEAD(super_blocks);
 static DEFINE_SPINLOCK(sb_lock);
+static u64 vfs_last_identifier;
+static u64 vfs_identifier_offset;
 
 static char *sb_writers_name[SB_FREEZE_LEVELS] = {
 	"sb_writers",
@@ -273,6 +275,7 @@ static struct super_block *alloc_super(struct file_system_type *type, int flags,
 		goto fail;
 	if (list_lru_init_memcg(&s->s_inode_lru, &s->s_shrink))
 		goto fail;
+	vfs_generate_unique_id(&s->s_unique_id);
 	return s;
 
 fail:
@@ -1867,3 +1870,24 @@ int thaw_super(struct super_block *sb)
 	return thaw_super_locked(sb);
 }
 EXPORT_SYMBOL(thaw_super);
+
+/*
+ * Generate a unique identifier for a superblock or mount object.
+ */
+void vfs_generate_unique_id(u64 *_id)
+{
+	u64 id = ktime_to_ns(ktime_get());
+
+	spin_lock(&sb_lock);
+
+	id += vfs_identifier_offset;
+	if (id <= vfs_last_identifier) {
+		id = vfs_last_identifier + 1;
+		vfs_identifier_offset = vfs_last_identifier - id;
+	}
+
+	vfs_last_identifier = id;
+	spin_unlock(&sb_lock);
+
+	*_id = id;
+}
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


