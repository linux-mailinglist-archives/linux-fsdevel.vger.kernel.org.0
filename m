Return-Path: <linux-fsdevel+bounces-15593-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1405D8906A8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Mar 2024 18:04:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD2AB291922
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Mar 2024 17:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C680E80639;
	Thu, 28 Mar 2024 17:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NNbBe+7+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937D053E01
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Mar 2024 17:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711645244; cv=none; b=eV4VgTMXwagX2LCWxIlUgB+1EGNMfcH7UMgSIN2Lym4jNRITeLhrkEIie4yKyMKARUwpl9G44w1he539YPTL50Zo5mUO7WQDYiAtEbEfx2KMOADm7UXzMZCGnondDyT7cMEs3vht9GwXI0pPzgzoiKCzRy9F4lPkAKH+Ij8ZPDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711645244; c=relaxed/simple;
	bh=g4yynKT3J8Yz+2sacntBdvwuRHXdJWY2oSFL0jWSOKY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=el93Mhq/qp++9orj/t7AT4t3FhymcsI536KLHAZnh385FbtaIUKHBW70O1TGqc62j0arOVoLSXiXpySkQiNlKQJnplMwAREWf2ja89YB0xEjWZH3W7uNFssLpeNcqst8wazASMb05HNopKLjdNFNr+MBxL+ATDLzRb47LcsfXtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NNbBe+7+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711645241;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OTSLBmDT3ajEjbQN8Mhbrt3qwYOXMWxKvZgVJwWAFPE=;
	b=NNbBe+7+2Z4d4nJfS6Lc2oMvzWRdF0mVefMhLWj3/HGg7A7ONOUpOhn5uHc0ItTAJDG0sn
	JqXT37t/U4ayTzTFHMXgo9Fj0mGh+Pbe4fZNjcUW/7Z7oGHRWJLxiq/cd3UTkeAcL+lfZl
	xUiZmSyQvTdQsqI9tgUEw4FDKgsIYoE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-393-8zEC4T1bPh2F6CVGOhvMiQ-1; Thu, 28 Mar 2024 13:00:36 -0400
X-MC-Unique: 8zEC4T1bPh2F6CVGOhvMiQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E275E18F34A0;
	Thu, 28 Mar 2024 17:00:34 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.146])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A927040C6CB1;
	Thu, 28 Mar 2024 17:00:32 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Steve French <smfrench@gmail.com>
Cc: David Howells <dhowells@redhat.com>,
	Jeff Layton <jlayton@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Christian Brauner <christian@brauner.io>,
	netfs@lists.linux.dev,
	linux-cifs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Steve French <sfrench@samba.org>,
	Shyam Prasad N <nspmangalore@gmail.com>,
	Rohith Surabattula <rohiths.msft@gmail.com>
Subject: [PATCH v6 11/15] cifs: When caching, try to open O_WRONLY file rdwr on server
Date: Thu, 28 Mar 2024 16:58:02 +0000
Message-ID: <20240328165845.2782259-12-dhowells@redhat.com>
In-Reply-To: <20240328165845.2782259-1-dhowells@redhat.com>
References: <20240328165845.2782259-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

When we're engaged in local caching of a cifs filesystem, we cannot perform
caching of a partially written cache granule unless we can read the rest of
the granule.  To deal with this, if a file is opened O_WRONLY locally, but
the mount was given the "-o fsc" flag, try first opening the remote file
with GENERIC_READ|GENERIC_WRITE and if that returns -EACCES, try dropping
the GENERIC_READ and doing the open again.  If that last succeeds,
invalidate the cache for that file as for O_DIRECT.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Shyam Prasad N <nspmangalore@gmail.com>
cc: Rohith Surabattula <rohiths.msft@gmail.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
cc: linux-mm@kvack.org
---
 fs/smb/client/dir.c     | 15 ++++++++++++
 fs/smb/client/file.c    | 51 +++++++++++++++++++++++++++++++++--------
 fs/smb/client/fscache.h |  6 +++++
 3 files changed, 62 insertions(+), 10 deletions(-)

diff --git a/fs/smb/client/dir.c b/fs/smb/client/dir.c
index 89333d9bce36..37897b919dd5 100644
--- a/fs/smb/client/dir.c
+++ b/fs/smb/client/dir.c
@@ -189,6 +189,7 @@ static int cifs_do_create(struct inode *inode, struct dentry *direntry, unsigned
 	int disposition;
 	struct TCP_Server_Info *server = tcon->ses->server;
 	struct cifs_open_parms oparms;
+	int rdwr_for_fscache = 0;
 
 	*oplock = 0;
 	if (tcon->ses->server->oplocks)
@@ -200,6 +201,10 @@ static int cifs_do_create(struct inode *inode, struct dentry *direntry, unsigned
 		return PTR_ERR(full_path);
 	}
 
+	/* If we're caching, we need to be able to fill in around partial writes. */
+	if (cifs_fscache_enabled(inode) && (oflags & O_ACCMODE) == O_WRONLY)
+		rdwr_for_fscache = 1;
+
 #ifdef CONFIG_CIFS_ALLOW_INSECURE_LEGACY
 	if (tcon->unix_ext && cap_unix(tcon->ses) && !tcon->broken_posix_open &&
 	    (CIFS_UNIX_POSIX_PATH_OPS_CAP &
@@ -276,6 +281,8 @@ static int cifs_do_create(struct inode *inode, struct dentry *direntry, unsigned
 		desired_access |= GENERIC_READ; /* is this too little? */
 	if (OPEN_FMODE(oflags) & FMODE_WRITE)
 		desired_access |= GENERIC_WRITE;
+	if (rdwr_for_fscache == 1)
+		desired_access |= GENERIC_READ;
 
 	disposition = FILE_OVERWRITE_IF;
 	if ((oflags & (O_CREAT | O_EXCL)) == (O_CREAT | O_EXCL))
@@ -304,6 +311,7 @@ static int cifs_do_create(struct inode *inode, struct dentry *direntry, unsigned
 	if (!tcon->unix_ext && (mode & S_IWUGO) == 0)
 		create_options |= CREATE_OPTION_READONLY;
 
+retry_open:
 	oparms = (struct cifs_open_parms) {
 		.tcon = tcon,
 		.cifs_sb = cifs_sb,
@@ -317,8 +325,15 @@ static int cifs_do_create(struct inode *inode, struct dentry *direntry, unsigned
 	rc = server->ops->open(xid, &oparms, oplock, buf);
 	if (rc) {
 		cifs_dbg(FYI, "cifs_create returned 0x%x\n", rc);
+		if (rc == -EACCES && rdwr_for_fscache == 1) {
+			desired_access &= ~GENERIC_READ;
+			rdwr_for_fscache = 2;
+			goto retry_open;
+		}
 		goto out;
 	}
+	if (rdwr_for_fscache == 2)
+		cifs_invalidate_cache(inode, FSCACHE_INVAL_DIO_WRITE);
 
 #ifdef CONFIG_CIFS_ALLOW_INSECURE_LEGACY
 	/*
diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index 73573dadf90e..761a80963f76 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -521,12 +521,12 @@ cifs_mark_open_files_invalid(struct cifs_tcon *tcon)
 	 */
 }
 
-static inline int cifs_convert_flags(unsigned int flags)
+static inline int cifs_convert_flags(unsigned int flags, int rdwr_for_fscache)
 {
 	if ((flags & O_ACCMODE) == O_RDONLY)
 		return GENERIC_READ;
 	else if ((flags & O_ACCMODE) == O_WRONLY)
-		return GENERIC_WRITE;
+		return rdwr_for_fscache == 1 ? (GENERIC_READ | GENERIC_WRITE) : GENERIC_WRITE;
 	else if ((flags & O_ACCMODE) == O_RDWR) {
 		/* GENERIC_ALL is too much permission to request
 		   can cause unnecessary access denied on create */
@@ -663,11 +663,16 @@ static int cifs_nt_open(const char *full_path, struct inode *inode, struct cifs_
 	int create_options = CREATE_NOT_DIR;
 	struct TCP_Server_Info *server = tcon->ses->server;
 	struct cifs_open_parms oparms;
+	int rdwr_for_fscache = 0;
 
 	if (!server->ops->open)
 		return -ENOSYS;
 
-	desired_access = cifs_convert_flags(f_flags);
+	/* If we're caching, we need to be able to fill in around partial writes. */
+	if (cifs_fscache_enabled(inode) && (f_flags & O_ACCMODE) == O_WRONLY)
+		rdwr_for_fscache = 1;
+
+	desired_access = cifs_convert_flags(f_flags, rdwr_for_fscache);
 
 /*********************************************************************
  *  open flag mapping table:
@@ -704,6 +709,7 @@ static int cifs_nt_open(const char *full_path, struct inode *inode, struct cifs_
 	if (f_flags & O_DIRECT)
 		create_options |= CREATE_NO_BUFFER;
 
+retry_open:
 	oparms = (struct cifs_open_parms) {
 		.tcon = tcon,
 		.cifs_sb = cifs_sb,
@@ -715,8 +721,16 @@ static int cifs_nt_open(const char *full_path, struct inode *inode, struct cifs_
 	};
 
 	rc = server->ops->open(xid, &oparms, oplock, buf);
-	if (rc)
+	if (rc) {
+		if (rc == -EACCES && rdwr_for_fscache == 1) {
+			desired_access = cifs_convert_flags(f_flags, 0);
+			rdwr_for_fscache = 2;
+			goto retry_open;
+		}
 		return rc;
+	}
+	if (rdwr_for_fscache == 2)
+		cifs_invalidate_cache(inode, FSCACHE_INVAL_DIO_WRITE);
 
 	/* TODO: Add support for calling posix query info but with passing in fid */
 	if (tcon->unix_ext)
@@ -1149,11 +1163,14 @@ int cifs_open(struct inode *inode, struct file *file)
 use_cache:
 	fscache_use_cookie(cifs_inode_cookie(file_inode(file)),
 			   file->f_mode & FMODE_WRITE);
-	if (file->f_flags & O_DIRECT &&
-	    (!((file->f_flags & O_ACCMODE) != O_RDONLY) ||
-	     file->f_flags & O_APPEND))
-		cifs_invalidate_cache(file_inode(file),
-				      FSCACHE_INVAL_DIO_WRITE);
+	//if ((file->f_flags & O_ACCMODE) == O_WRONLY)
+	//	goto inval;
+	if (!(file->f_flags & O_DIRECT))
+		goto out;
+	if ((file->f_flags & (O_ACCMODE | O_APPEND)) == O_RDONLY)
+		goto out;
+//inval:
+	cifs_invalidate_cache(file_inode(file), FSCACHE_INVAL_DIO_WRITE);
 
 out:
 	free_dentry_path(page);
@@ -1218,6 +1235,7 @@ cifs_reopen_file(struct cifsFileInfo *cfile, bool can_flush)
 	int disposition = FILE_OPEN;
 	int create_options = CREATE_NOT_DIR;
 	struct cifs_open_parms oparms;
+	int rdwr_for_fscache = 0;
 
 	xid = get_xid();
 	mutex_lock(&cfile->fh_mutex);
@@ -1281,7 +1299,11 @@ cifs_reopen_file(struct cifsFileInfo *cfile, bool can_flush)
 	}
 #endif /* CONFIG_CIFS_ALLOW_INSECURE_LEGACY */
 
-	desired_access = cifs_convert_flags(cfile->f_flags);
+	/* If we're caching, we need to be able to fill in around partial writes. */
+	if (cifs_fscache_enabled(inode) && (cfile->f_flags & O_ACCMODE) == O_WRONLY)
+		rdwr_for_fscache = 1;
+
+	desired_access = cifs_convert_flags(cfile->f_flags, rdwr_for_fscache);
 
 	/* O_SYNC also has bit for O_DSYNC so following check picks up either */
 	if (cfile->f_flags & O_SYNC)
@@ -1293,6 +1315,7 @@ cifs_reopen_file(struct cifsFileInfo *cfile, bool can_flush)
 	if (server->ops->get_lease_key)
 		server->ops->get_lease_key(inode, &cfile->fid);
 
+retry_open:
 	oparms = (struct cifs_open_parms) {
 		.tcon = tcon,
 		.cifs_sb = cifs_sb,
@@ -1318,6 +1341,11 @@ cifs_reopen_file(struct cifsFileInfo *cfile, bool can_flush)
 		/* indicate that we need to relock the file */
 		oparms.reconnect = true;
 	}
+	if (rc == -EACCES && rdwr_for_fscache == 1) {
+		desired_access = cifs_convert_flags(cfile->f_flags, 0);
+		rdwr_for_fscache = 2;
+		goto retry_open;
+	}
 
 	if (rc) {
 		mutex_unlock(&cfile->fh_mutex);
@@ -1326,6 +1354,9 @@ cifs_reopen_file(struct cifsFileInfo *cfile, bool can_flush)
 		goto reopen_error_exit;
 	}
 
+	if (rdwr_for_fscache == 2)
+		cifs_invalidate_cache(inode, FSCACHE_INVAL_DIO_WRITE);
+
 #ifdef CONFIG_CIFS_ALLOW_INSECURE_LEGACY
 reopen_success:
 #endif /* CONFIG_CIFS_ALLOW_INSECURE_LEGACY */
diff --git a/fs/smb/client/fscache.h b/fs/smb/client/fscache.h
index a3d73720914f..1f2ea9f5cc9a 100644
--- a/fs/smb/client/fscache.h
+++ b/fs/smb/client/fscache.h
@@ -109,6 +109,11 @@ static inline void cifs_readahead_to_fscache(struct inode *inode,
 		__cifs_readahead_to_fscache(inode, pos, len);
 }
 
+static inline bool cifs_fscache_enabled(struct inode *inode)
+{
+	return fscache_cookie_enabled(cifs_inode_cookie(inode));
+}
+
 #else /* CONFIG_CIFS_FSCACHE */
 static inline
 void cifs_fscache_fill_coherency(struct inode *inode,
@@ -124,6 +129,7 @@ static inline void cifs_fscache_release_inode_cookie(struct inode *inode) {}
 static inline void cifs_fscache_unuse_inode_cookie(struct inode *inode, bool update) {}
 static inline struct fscache_cookie *cifs_inode_cookie(struct inode *inode) { return NULL; }
 static inline void cifs_invalidate_cache(struct inode *inode, unsigned int flags) {}
+static inline bool cifs_fscache_enabled(struct inode *inode) { return false; }
 
 static inline int cifs_fscache_query_occupancy(struct inode *inode,
 					       pgoff_t first, unsigned int nr_pages,


