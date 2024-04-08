Return-Path: <linux-fsdevel+bounces-16362-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 334E289C1B3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Apr 2024 15:23:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 584BB1C21439
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Apr 2024 13:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 267EE8060C;
	Mon,  8 Apr 2024 13:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nPpSVLEP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0A670CCB;
	Mon,  8 Apr 2024 13:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712582375; cv=none; b=LrCskWMf3VIfi4dOM+eM2wOIvvcDxz7BQZKvaS1oulCCcHZKnhKLDjSuugPyGt7mvYc/HC7ohfiJrdOZ6ksUrpDDajprCpi78mdENH71FoIb4G4nlmSDq773yTd5Hl5v2UQe6A3bfADkPuEd3A7usQdsDKibOBoowm9lZs5uq/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712582375; c=relaxed/simple;
	bh=NhvtdevDHN9Wq8sUJv73XolrMHEq35fQ58EhfySQfIA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jZEgtd0K7FDvhnqoKRYo+7T/8fVSmTqn7je9ZmZfMFcbVw686l5v+90vKkjUDY3Dley4c62UzS4sZM5yxebfP7O8xk1vcGUzy3crCKJ3rZuCrTzC+Zgj0PWQGpgtsLGyFU06JltnbZRvRPyDGKJgJx4RdhU13vjYsoU0ZzDGF4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nPpSVLEP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEDBEC433F1;
	Mon,  8 Apr 2024 13:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712582375;
	bh=NhvtdevDHN9Wq8sUJv73XolrMHEq35fQ58EhfySQfIA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nPpSVLEPuDw2wkkHy76jPryzOg/pfd+pRfNNZO2363jLEG+SqB15qlIHCW52Lv2g5
	 jchiAtEAcxGA0ToPrVDAZWEj5s5lz7ppfCuOV+XdjWj3gOL3/ijgeSH8Htz/VAb5LU
	 VNn5akQ7ZRHXGGaLQYS0lRLqRCOnz3pVIoyC2C44=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Howells <dhowells@redhat.com>,
	Steve French <sfrench@samba.org>,
	Shyam Prasad N <nspmangalore@gmail.com>,
	Rohith Surabattula <rohiths.msft@gmail.com>,
	Jeff Layton <jlayton@kernel.org>,
	linux-cifs@vger.kernel.org,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 100/138] cifs: Fix caching to try to do open O_WRONLY as rdwr on server
Date: Mon,  8 Apr 2024 14:58:34 +0200
Message-ID: <20240408125259.342475642@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240408125256.218368873@linuxfoundation.org>
References: <20240408125256.218368873@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Howells <dhowells@redhat.com>

[ Upstream commit e9e62243a3e2322cf639f653a0b0a88a76446ce7 ]

When we're engaged in local caching of a cifs filesystem, we cannot perform
caching of a partially written cache granule unless we can read the rest of
the granule.  This can result in unexpected access errors being reported to
the user.

Fix this by the following: if a file is opened O_WRONLY locally, but the
mount was given the "-o fsc" flag, try first opening the remote file with
GENERIC_READ|GENERIC_WRITE and if that returns -EACCES, try dropping the
GENERIC_READ and doing the open again.  If that last succeeds, invalidate
the cache for that file as for O_DIRECT.

Fixes: 70431bfd825d ("cifs: Support fscache indexing rewrite")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Shyam Prasad N <nspmangalore@gmail.com>
cc: Rohith Surabattula <rohiths.msft@gmail.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/dir.c     | 15 +++++++++++++
 fs/smb/client/file.c    | 48 ++++++++++++++++++++++++++++++++---------
 fs/smb/client/fscache.h |  6 ++++++
 3 files changed, 59 insertions(+), 10 deletions(-)

diff --git a/fs/smb/client/dir.c b/fs/smb/client/dir.c
index e382b794acbed..863c7bc3db86f 100644
--- a/fs/smb/client/dir.c
+++ b/fs/smb/client/dir.c
@@ -180,6 +180,7 @@ static int cifs_do_create(struct inode *inode, struct dentry *direntry, unsigned
 	int disposition;
 	struct TCP_Server_Info *server = tcon->ses->server;
 	struct cifs_open_parms oparms;
+	int rdwr_for_fscache = 0;
 
 	*oplock = 0;
 	if (tcon->ses->server->oplocks)
@@ -191,6 +192,10 @@ static int cifs_do_create(struct inode *inode, struct dentry *direntry, unsigned
 		return PTR_ERR(full_path);
 	}
 
+	/* If we're caching, we need to be able to fill in around partial writes. */
+	if (cifs_fscache_enabled(inode) && (oflags & O_ACCMODE) == O_WRONLY)
+		rdwr_for_fscache = 1;
+
 #ifdef CONFIG_CIFS_ALLOW_INSECURE_LEGACY
 	if (tcon->unix_ext && cap_unix(tcon->ses) && !tcon->broken_posix_open &&
 	    (CIFS_UNIX_POSIX_PATH_OPS_CAP &
@@ -267,6 +272,8 @@ static int cifs_do_create(struct inode *inode, struct dentry *direntry, unsigned
 		desired_access |= GENERIC_READ; /* is this too little? */
 	if (OPEN_FMODE(oflags) & FMODE_WRITE)
 		desired_access |= GENERIC_WRITE;
+	if (rdwr_for_fscache == 1)
+		desired_access |= GENERIC_READ;
 
 	disposition = FILE_OVERWRITE_IF;
 	if ((oflags & (O_CREAT | O_EXCL)) == (O_CREAT | O_EXCL))
@@ -295,6 +302,7 @@ static int cifs_do_create(struct inode *inode, struct dentry *direntry, unsigned
 	if (!tcon->unix_ext && (mode & S_IWUGO) == 0)
 		create_options |= CREATE_OPTION_READONLY;
 
+retry_open:
 	oparms = (struct cifs_open_parms) {
 		.tcon = tcon,
 		.cifs_sb = cifs_sb,
@@ -308,8 +316,15 @@ static int cifs_do_create(struct inode *inode, struct dentry *direntry, unsigned
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
index 0f3405e0f2e48..c240cea7ca349 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -77,12 +77,12 @@ cifs_mark_open_files_invalid(struct cifs_tcon *tcon)
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
@@ -219,11 +219,16 @@ static int cifs_nt_open(const char *full_path, struct inode *inode, struct cifs_
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
@@ -260,6 +265,7 @@ static int cifs_nt_open(const char *full_path, struct inode *inode, struct cifs_
 	if (f_flags & O_DIRECT)
 		create_options |= CREATE_NO_BUFFER;
 
+retry_open:
 	oparms = (struct cifs_open_parms) {
 		.tcon = tcon,
 		.cifs_sb = cifs_sb,
@@ -271,8 +277,16 @@ static int cifs_nt_open(const char *full_path, struct inode *inode, struct cifs_
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
@@ -705,11 +719,11 @@ int cifs_open(struct inode *inode, struct file *file)
 use_cache:
 	fscache_use_cookie(cifs_inode_cookie(file_inode(file)),
 			   file->f_mode & FMODE_WRITE);
-	if (file->f_flags & O_DIRECT &&
-	    (!((file->f_flags & O_ACCMODE) != O_RDONLY) ||
-	     file->f_flags & O_APPEND))
-		cifs_invalidate_cache(file_inode(file),
-				      FSCACHE_INVAL_DIO_WRITE);
+	if (!(file->f_flags & O_DIRECT))
+		goto out;
+	if ((file->f_flags & (O_ACCMODE | O_APPEND)) == O_RDONLY)
+		goto out;
+	cifs_invalidate_cache(file_inode(file), FSCACHE_INVAL_DIO_WRITE);
 
 out:
 	free_dentry_path(page);
@@ -774,6 +788,7 @@ cifs_reopen_file(struct cifsFileInfo *cfile, bool can_flush)
 	int disposition = FILE_OPEN;
 	int create_options = CREATE_NOT_DIR;
 	struct cifs_open_parms oparms;
+	int rdwr_for_fscache = 0;
 
 	xid = get_xid();
 	mutex_lock(&cfile->fh_mutex);
@@ -837,7 +852,11 @@ cifs_reopen_file(struct cifsFileInfo *cfile, bool can_flush)
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
@@ -849,6 +868,7 @@ cifs_reopen_file(struct cifsFileInfo *cfile, bool can_flush)
 	if (server->ops->get_lease_key)
 		server->ops->get_lease_key(inode, &cfile->fid);
 
+retry_open:
 	oparms = (struct cifs_open_parms) {
 		.tcon = tcon,
 		.cifs_sb = cifs_sb,
@@ -874,6 +894,11 @@ cifs_reopen_file(struct cifsFileInfo *cfile, bool can_flush)
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
@@ -882,6 +907,9 @@ cifs_reopen_file(struct cifsFileInfo *cfile, bool can_flush)
 		goto reopen_error_exit;
 	}
 
+	if (rdwr_for_fscache == 2)
+		cifs_invalidate_cache(inode, FSCACHE_INVAL_DIO_WRITE);
+
 #ifdef CONFIG_CIFS_ALLOW_INSECURE_LEGACY
 reopen_success:
 #endif /* CONFIG_CIFS_ALLOW_INSECURE_LEGACY */
diff --git a/fs/smb/client/fscache.h b/fs/smb/client/fscache.h
index 67b601041f0a3..c691b98b442a6 100644
--- a/fs/smb/client/fscache.h
+++ b/fs/smb/client/fscache.h
@@ -108,6 +108,11 @@ static inline void cifs_readpage_to_fscache(struct inode *inode,
 		__cifs_readpage_to_fscache(inode, page);
 }
 
+static inline bool cifs_fscache_enabled(struct inode *inode)
+{
+	return fscache_cookie_enabled(cifs_inode_cookie(inode));
+}
+
 #else /* CONFIG_CIFS_FSCACHE */
 static inline
 void cifs_fscache_fill_coherency(struct inode *inode,
@@ -123,6 +128,7 @@ static inline void cifs_fscache_release_inode_cookie(struct inode *inode) {}
 static inline void cifs_fscache_unuse_inode_cookie(struct inode *inode, bool update) {}
 static inline struct fscache_cookie *cifs_inode_cookie(struct inode *inode) { return NULL; }
 static inline void cifs_invalidate_cache(struct inode *inode, unsigned int flags) {}
+static inline bool cifs_fscache_enabled(struct inode *inode) { return false; }
 
 static inline int cifs_fscache_query_occupancy(struct inode *inode,
 					       pgoff_t first, unsigned int nr_pages,
-- 
2.43.0




