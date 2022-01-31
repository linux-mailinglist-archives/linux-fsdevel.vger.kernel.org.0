Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DBB44A4A1A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jan 2022 16:15:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377474AbiAaPOp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jan 2022 10:14:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29625 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1378010AbiAaPOR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jan 2022 10:14:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643642048;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5gBtosB0UfmfYr5zZy3baE9jgYgCk/escq5rx8anoDY=;
        b=YAWLtUaEedxK2uVbMem5PFUFCBR2vWtddzUfecQO0rqNyFEHU7IZgY1H8NBwqJm54rzdV7
        cxhNoeW8x19pM+MjVvySwptDQpiGGVUeySK8wlNmCdxc0+Js3U1BTlhFqu1iyvo6zzZixZ
        rLepBct50CwCKOBvJCEjes7sGLd2Z+s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-428-spLipaAGOEWk4R9t29eT7g-1; Mon, 31 Jan 2022 10:14:04 -0500
X-MC-Unique: spLipaAGOEWk4R9t29eT7g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5993418C89C4;
        Mon, 31 Jan 2022 15:14:03 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 39D117243D;
        Mon, 31 Jan 2022 15:14:01 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 4/5] cachefiles: Use I_EXCL_INUSE instead of S_KERNEL_FILE
From:   David Howells <dhowells@redhat.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>, linux-cachefs@redhat.com,
        linux-unionfs@vger.kernel.org, dhowells@redhat.com,
        Christoph Hellwig <hch@infradead.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Jeff Layton <jlayton@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        torvalds@linux-foundation.org, linux-unionfs@vger.kernel.org,
        linux-cachefs@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 31 Jan 2022 15:14:00 +0000
Message-ID: <164364204024.1476539.3811417846576668364.stgit@warthog.procyon.org.uk>
In-Reply-To: <164364196407.1476539.8450117784231043601.stgit@warthog.procyon.org.uk>
References: <164364196407.1476539.8450117784231043601.stgit@warthog.procyon.org.uk>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Get rid of S_KERNEL_FILE and use I_EXCL_INUSE instead, thereby sharing that
flag with overlayfs.  This is used by cachefiles for two purposes: firstly,
to prevent simultaneous access to a backing file, which could cause data
corruption, and secondly, to allow cachefilesd to find out if it's allowed
to cull a backing file without having to have duplicate lookup
infrastructure (the VFS already has all the infrastructure that is
necessary to do the lookup; cachefiles just needs a single bit flag).

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Amir Goldstein <amir73il@gmail.com>
cc: Miklos Szeredi <miklos@szeredi.hu>
cc: linux-cachefs@redhat.com
cc: linux-unionfs@vger.kernel.org
Link: https://lore.kernel.org/r/CAOQ4uxhRS3MGEnCUDcsB1RL0d1Oy0g0Rzm75hVFAJw2dJ7uKSA@mail.gmail.com/ [1]
---

 fs/cachefiles/namei.c |   46 ++++++++++++++++++++--------------------------
 include/linux/fs.h    |    2 +-
 2 files changed, 21 insertions(+), 27 deletions(-)

diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
index 8930c767d93a..0c88c82c188f 100644
--- a/fs/cachefiles/namei.c
+++ b/fs/cachefiles/namei.c
@@ -18,22 +18,19 @@ static bool __cachefiles_mark_inode_in_use(struct cachefiles_object *object,
 					   struct dentry *dentry)
 {
 	struct inode *inode = d_backing_inode(dentry);
-	bool can_use = false;
+	bool locked;
 
-	spin_lock(&inode->i_lock);
-	if (!(inode->i_flags & S_KERNEL_FILE)) {
-		inode->i_flags |= S_KERNEL_FILE;
+	locked = inode_excl_inuse_trylock(dentry, object ? object->debug_id : 0,
+					  inode_excl_inuse_by_cachefiles);
+	if (locked) {
+		spin_lock(&inode->i_lock);
 		inode->i_state |= I_NO_REMOVE;
-		trace_cachefiles_mark_active(object, inode);
-		can_use = true;
+		spin_unlock(&inode->i_lock);
 	} else {
-		trace_cachefiles_mark_failed(object, inode);
 		pr_notice("cachefiles: Inode already in use: %pd (B=%lx)\n",
 			  dentry, inode->i_ino);
 	}
-	spin_unlock(&inode->i_lock);
-
-	return can_use;
+	return locked;
 }
 
 static bool cachefiles_mark_inode_in_use(struct cachefiles_object *object,
@@ -57,10 +54,9 @@ static void __cachefiles_unmark_inode_in_use(struct cachefiles_object *object,
 	struct inode *inode = d_backing_inode(dentry);
 
 	spin_lock(&inode->i_lock);
-	inode->i_flags &= ~S_KERNEL_FILE;
-	inode->i_state &= ~I_NO_REMOVE;
+	inode->i_state |= I_NO_REMOVE;
 	spin_unlock(&inode->i_lock);
-	trace_cachefiles_mark_inactive(object, inode);
+	inode_excl_inuse_unlock(dentry, object ? object->debug_id : 0);
 }
 
 /*
@@ -754,7 +750,7 @@ static struct dentry *cachefiles_lookup_for_cull(struct cachefiles_cache *cache,
 		goto lookup_error;
 	if (d_is_negative(victim))
 		goto lookup_put;
-	if (d_inode(victim)->i_flags & S_KERNEL_FILE)
+	if (inode_is_excl_inuse(victim))
 		goto lookup_busy;
 	return victim;
 
@@ -790,6 +786,7 @@ int cachefiles_cull(struct cachefiles_cache *cache, struct dentry *dir,
 {
 	struct dentry *victim;
 	struct inode *inode;
+	bool locked;
 	int ret;
 
 	_enter(",%pd/,%s", dir, filename);
@@ -798,19 +795,16 @@ int cachefiles_cull(struct cachefiles_cache *cache, struct dentry *dir,
 	if (IS_ERR(victim))
 		return PTR_ERR(victim);
 
-	/* check to see if someone is using this object */
+	/* Check to see if someone is using this object and, if not, stop the
+	 * cache from picking it back up.
+	 */
 	inode = d_inode(victim);
 	inode_lock(inode);
-	if (inode->i_flags & S_KERNEL_FILE) {
-		ret = -EBUSY;
-	} else {
-		/* Stop the cache from picking it back up */
-		inode->i_flags |= S_KERNEL_FILE;
-		ret = 0;
-	}
+	locked = inode_excl_inuse_trylock(victim, 0,
+					  inode_excl_inuse_by_cachefiles);
 	inode_unlock(inode);
-	if (ret < 0)
-		goto error_unlock;
+	if (!locked)
+		goto busy;
 
 	ret = cachefiles_bury_object(cache, NULL, dir, victim,
 				     FSCACHE_OBJECT_WAS_CULLED);
@@ -822,8 +816,8 @@ int cachefiles_cull(struct cachefiles_cache *cache, struct dentry *dir,
 	_leave(" = 0");
 	return 0;
 
-error_unlock:
-	inode_unlock(d_inode(dir));
+busy:
+	ret = -EBUSY;
 error:
 	dput(victim);
 	if (ret == -ENOENT)
diff --git a/include/linux/fs.h b/include/linux/fs.h
index a273d5cde731..009ca9f783bd 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2161,7 +2161,6 @@ struct super_operations {
 #define S_ENCRYPTED	(1 << 14) /* Encrypted file (using fs/crypto/) */
 #define S_CASEFOLD	(1 << 15) /* Casefolded file */
 #define S_VERITY	(1 << 16) /* Verity file (using fs/verity/) */
-#define S_KERNEL_FILE	(1 << 17) /* File is in use by the kernel (eg. fs/cachefiles) */
 
 /*
  * Note that nosuid etc flags are inode-specific: setting some file-system
@@ -2394,6 +2393,7 @@ static inline bool inode_is_dirtytime_only(struct inode *inode)
 }
 
 enum inode_excl_inuse_by {
+	inode_excl_inuse_by_cachefiles,
 	inode_excl_inuse_by_overlayfs,
 };
 


