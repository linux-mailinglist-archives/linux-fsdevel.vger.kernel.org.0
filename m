Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBE5433B22B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Mar 2021 13:09:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbhCOMIf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Mar 2021 08:08:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46817 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230442AbhCOMIJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Mar 2021 08:08:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615810089;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gp+7jAw9DBst1BkRwe0IRvUzSqM3k8jkvwLyhio5B5w=;
        b=fXsa/nrNZanWpdMPnkEZOeO0fgn9I3g1b0Z/yn9JAeM7rl04EOfC3QxFcmt3t7XZt2mBRt
        Y8p6fZNrPRRE05bMP5QT05xUgx8gq8gOUnJpjCtnx/Z+7s6NyVHA8+Z/7cDcSPy6xRUxz8
        WTiNFOt8knKLrfCEMoO7sADOEhHVTj0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-588-n3CUcFu9Mlm_KZFOd00Gww-1; Mon, 15 Mar 2021 08:08:07 -0400
X-MC-Unique: n3CUcFu9Mlm_KZFOd00Gww-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 41D5F93921;
        Mon, 15 Mar 2021 12:08:06 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-118-152.rdu2.redhat.com [10.10.118.152])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D3FF55C3E6;
        Mon, 15 Mar 2021 12:08:04 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 3/3] vfs: Remove mount list trawling cursor stuff
From:   David Howells <dhowells@redhat.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>
Cc:     Matthew Wilcox <willy@infradead.org>, dhowells@redhat.com,
        Matthew Wilcox <willy@infradead.org>,
        Ian Kent <raven@themaw.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 15 Mar 2021 12:08:03 +0000
Message-ID: <161581008391.2850696.2182919568148594136.stgit@warthog.procyon.org.uk>
In-Reply-To: <161581005972.2850696.12854461380574304411.stgit@warthog.procyon.org.uk>
References: <161581005972.2850696.12854461380574304411.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Remove the stuff for trawling a mount namespace's mount list using inserted
cursors as bookmarks as this has been replaced with an xarray-based
approach.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Alexander Viro <viro@zeniv.linux.org.uk>
cc: Miklos Szeredi <miklos@szeredi.hu>
cc: Matthew Wilcox <willy@infradead.org>
---

 fs/namespace.c        |   30 ------------------------------
 include/linux/mount.h |    4 +---
 2 files changed, 1 insertion(+), 33 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index d19fde0654f7..105a6d882cb4 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -673,11 +673,6 @@ static inline void unlock_ns_list(struct mnt_namespace *ns)
 	spin_unlock(&ns->ns_lock);
 }
 
-static inline bool mnt_is_cursor(struct mount *mnt)
-{
-	return mnt->mnt.mnt_flags & MNT_CURSOR;
-}
-
 /*
  * __is_local_mountpoint - Test to see if dentry is a mountpoint in the
  *                         current mount namespace.
@@ -702,8 +697,6 @@ bool __is_local_mountpoint(struct dentry *dentry)
 	down_read(&namespace_sem);
 	lock_ns_list(ns);
 	list_for_each_entry(mnt, &ns->list, mnt_list) {
-		if (mnt_is_cursor(mnt))
-			continue;
 		is_covered = (mnt->mnt_mountpoint == dentry);
 		if (is_covered)
 			break;
@@ -1334,26 +1327,6 @@ struct vfsmount *mnt_clone_internal(const struct path *path)
 }
 
 #ifdef CONFIG_PROC_FS
-#if 0
-static struct mount *mnt_list_next(struct mnt_namespace *ns,
-				   struct list_head *p)
-{
-	struct mount *mnt, *ret = NULL;
-
-	lock_ns_list(ns);
-	list_for_each_continue(p, &ns->list) {
-		mnt = list_entry(p, typeof(*mnt), mnt_list);
-		if (!mnt_is_cursor(mnt)) {
-			ret = mnt;
-			break;
-		}
-	}
-	unlock_ns_list(ns);
-
-	return ret;
-}
-#endif
-
 /* iterator; we want it to have access to namespace_sem, thus here... */
 static void *m_start(struct seq_file *m, loff_t *pos)
 {
@@ -4390,9 +4363,6 @@ static bool mnt_already_visible(struct mnt_namespace *ns,
 		struct mount *child;
 		int mnt_flags;
 
-		if (mnt_is_cursor(mnt))
-			continue;
-
 		if (mnt->mnt.mnt_sb->s_type != sb->s_type)
 			continue;
 
diff --git a/include/linux/mount.h b/include/linux/mount.h
index 5d92a7e1a742..88027d38833c 100644
--- a/include/linux/mount.h
+++ b/include/linux/mount.h
@@ -51,8 +51,7 @@ struct fs_context;
 #define MNT_ATIME_MASK (MNT_NOATIME | MNT_NODIRATIME | MNT_RELATIME )
 
 #define MNT_INTERNAL_FLAGS (MNT_SHARED | MNT_WRITE_HOLD | MNT_INTERNAL | \
-			    MNT_DOOMED | MNT_SYNC_UMOUNT | MNT_MARKED | \
-			    MNT_CURSOR)
+			    MNT_DOOMED | MNT_SYNC_UMOUNT | MNT_MARKED)
 
 #define MNT_INTERNAL	0x4000
 
@@ -66,7 +65,6 @@ struct fs_context;
 #define MNT_SYNC_UMOUNT		0x2000000
 #define MNT_MARKED		0x4000000
 #define MNT_UMOUNT		0x8000000
-#define MNT_CURSOR		0x10000000
 
 struct vfsmount {
 	struct dentry *mnt_root;	/* root of the mounted tree */


