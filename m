Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 733194F6E4C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Apr 2022 01:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237677AbiDFXGg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Apr 2022 19:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237566AbiDFXG2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Apr 2022 19:06:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E386C13F07
        for <linux-fsdevel@vger.kernel.org>; Wed,  6 Apr 2022 16:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649286270;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8gGGx4j17Pm6hFmcJTfM5+MTyF6+SQ6U0EyOzVOx73M=;
        b=b2wbPgbtCTsHRsIw/zGllmHMFeurURNnM4ohEPfd7A7Ez+DGi3IrBKDLLchnrL7XK/3Xv/
        9cvcBk3G8VaVqcdL84W9/LG+q0k7WXvOsT/1N9NjsN4LkDtOptj9SHcP+8+uNuIY0dHpsB
        ta1z9GeFGr7fFA7Dn7zWus4JvysedKE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-569-XOse0Vh5PfCL4aMrkWNkvg-1; Wed, 06 Apr 2022 19:04:24 -0400
X-MC-Unique: XOse0Vh5PfCL4aMrkWNkvg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8068A811E90;
        Wed,  6 Apr 2022 23:04:18 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.37.45])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 31FB640D1B98;
        Wed,  6 Apr 2022 23:04:06 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 07/14] cifs: Share server EOF pos with netfslib
From:   David Howells <dhowells@redhat.com>
To:     linux-cachefs@redhat.com
Cc:     Steve French <sfrench@samba.org>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        linux-cifs@vger.kernel.org, dhowells@redhat.com,
        Steve French <sfrench@samba.org>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        Jeff Layton <jlayton@redhat.com>, linux-cifs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Date:   Thu, 07 Apr 2022 00:04:05 +0100
Message-ID: <164928624528.457102.12296775035063756098.stgit@warthog.procyon.org.uk>
In-Reply-To: <164928615045.457102.10607899252434268982.stgit@warthog.procyon.org.uk>
References: <164928615045.457102.10607899252434268982.stgit@warthog.procyon.org.uk>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use cifsi->netfs_ctx.remote_i_size instead of cifsi->server_eof so that
netfslib can refer to it to.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Shyam Prasad N <nspmangalore@gmail.com>
cc: Rohith Surabattula <rohiths.msft@gmail.com>
cc: linux-cifs@vger.kernel.org
---

 fs/cifs/cifsfs.c   |    2 +-
 fs/cifs/cifsglob.h |    1 -
 fs/cifs/file.c     |    8 ++++----
 fs/cifs/inode.c    |    6 +++---
 fs/cifs/smb2ops.c  |   10 ++++------
 5 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/fs/cifs/cifsfs.c b/fs/cifs/cifsfs.c
index b33f5eb3233c..d07cb28652f2 100644
--- a/fs/cifs/cifsfs.c
+++ b/fs/cifs/cifsfs.c
@@ -376,7 +376,7 @@ cifs_alloc_inode(struct super_block *sb)
 	spin_lock_init(&cifs_inode->writers_lock);
 	cifs_inode->writers = 0;
 	cifs_inode->vfs_inode.i_blkbits = 14;  /* 2**14 = CIFS_MAX_MSGSIZE */
-	cifs_inode->server_eof = 0;
+	cifs_inode->netfs_ctx.remote_i_size = 0;
 	cifs_inode->uniqueid = 0;
 	cifs_inode->createtime = 0;
 	cifs_inode->epoch = 0;
diff --git a/fs/cifs/cifsglob.h b/fs/cifs/cifsglob.h
index e7db00396391..49eb86ebbdfb 100644
--- a/fs/cifs/cifsglob.h
+++ b/fs/cifs/cifsglob.h
@@ -1416,7 +1416,6 @@ struct cifsInodeInfo {
 	spinlock_t writers_lock;
 	unsigned int writers;		/* Number of writers on this inode */
 	unsigned long time;		/* jiffies of last update of inode */
-	u64  server_eof;		/* current file size on server -- protected by i_lock */
 	u64  uniqueid;			/* server inode number */
 	u64  createtime;		/* creation time on server */
 	__u8 lease_key[SMB2_LEASE_KEY_SIZE];	/* lease key for this inode */
diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index 200280be064d..fcf92c25bc8f 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -1913,8 +1913,8 @@ cifs_update_eof(struct cifsInodeInfo *cifsi, loff_t offset,
 {
 	loff_t end_of_write = offset + bytes_written;
 
-	if (end_of_write > cifsi->server_eof)
-		cifsi->server_eof = end_of_write;
+	if (end_of_write > cifsi->netfs_ctx.remote_i_size)
+		cifsi->netfs_ctx.remote_i_size = end_of_write;
 }
 
 static ssize_t
@@ -2862,8 +2862,8 @@ cifs_uncached_writev_complete(struct work_struct *work)
 
 	spin_lock(&inode->i_lock);
 	cifs_update_eof(cifsi, wdata->offset, wdata->bytes);
-	if (cifsi->server_eof > inode->i_size)
-		i_size_write(inode, cifsi->server_eof);
+	if (cifsi->netfs_ctx.remote_i_size > inode->i_size)
+		i_size_write(inode, cifsi->netfs_ctx.remote_i_size);
 	spin_unlock(&inode->i_lock);
 
 	complete(&wdata->done);
diff --git a/fs/cifs/inode.c b/fs/cifs/inode.c
index 40c6f04f7521..9ebb806c63d5 100644
--- a/fs/cifs/inode.c
+++ b/fs/cifs/inode.c
@@ -117,7 +117,7 @@ cifs_revalidate_cache(struct inode *inode, struct cifs_fattr *fattr)
 	 /* revalidate if mtime or size have changed */
 	fattr->cf_mtime = timestamp_truncate(fattr->cf_mtime, inode);
 	if (timespec64_equal(&inode->i_mtime, &fattr->cf_mtime) &&
-	    cifs_i->server_eof == fattr->cf_eof) {
+	    cifs_i->netfs_ctx.remote_i_size == fattr->cf_eof) {
 		cifs_dbg(FYI, "%s: inode %llu is unchanged\n",
 			 __func__, cifs_i->uniqueid);
 		return;
@@ -206,7 +206,7 @@ cifs_fattr_to_inode(struct inode *inode, struct cifs_fattr *fattr)
 	else
 		clear_bit(CIFS_INO_DELETE_PENDING, &cifs_i->flags);
 
-	cifs_i->server_eof = fattr->cf_eof;
+	cifs_i->netfs_ctx.remote_i_size = fattr->cf_eof;
 	/*
 	 * Can't safely change the file size here if the client is writing to
 	 * it due to potential races.
@@ -2642,7 +2642,7 @@ cifs_set_file_size(struct inode *inode, struct iattr *attrs,
 
 set_size_out:
 	if (rc == 0) {
-		cifsInode->server_eof = attrs->ia_size;
+		cifsInode->netfs_ctx.remote_i_size = attrs->ia_size;
 		cifs_setsize(inode, attrs->ia_size);
 		/*
 		 * i_blocks is not related to (i_size / i_blksize), but instead
diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
index b0485706e07c..2caac8696100 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -3833,7 +3833,7 @@ static long smb3_simple_falloc(struct file *file, struct cifs_tcon *tcon,
 		rc = SMB2_set_eof(xid, tcon, cfile->fid.persistent_fid,
 				  cfile->fid.volatile_fid, cfile->pid, &eof);
 		if (rc == 0) {
-			cifsi->server_eof = off + len;
+			cifsi->netfs_ctx.remote_i_size = off + len;
 			cifs_setsize(inode, off + len);
 			cifs_truncate_page(inode->i_mapping, inode->i_size);
 			truncate_setsize(inode, off + len);
@@ -3926,13 +3926,11 @@ static long smb3_collapse_range(struct file *file, struct cifs_tcon *tcon,
 	unsigned int xid;
 	struct inode *inode;
 	struct cifsFileInfo *cfile = file->private_data;
-	struct cifsInodeInfo *cifsi;
 	__le64 eof;
 
 	xid = get_xid();
 
 	inode = d_inode(cfile->dentry);
-	cifsi = CIFS_I(inode);
 
 	if (off >= i_size_read(inode) ||
 	    off + len >= i_size_read(inode)) {
@@ -3953,9 +3951,9 @@ static long smb3_collapse_range(struct file *file, struct cifs_tcon *tcon,
 
 	rc = 0;
 
-	cifsi->server_eof = i_size_read(inode) - len;
-	truncate_setsize(inode, cifsi->server_eof);
-	fscache_resize_cookie(cifs_inode_cookie(inode), cifsi->server_eof);
+	netfs_resize_file(inode, eof);
+	truncate_setsize(inode, eof);
+	fscache_resize_cookie(cifs_inode_cookie(inode), eof);
  out:
 	free_xid(xid);
 	return rc;


