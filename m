Return-Path: <linux-fsdevel+bounces-16363-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E6BA89C399
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Apr 2024 15:42:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8474283CDF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Apr 2024 13:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 771D212AAED;
	Mon,  8 Apr 2024 13:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MU4xNdzI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD587F7DB;
	Mon,  8 Apr 2024 13:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712583439; cv=none; b=JAc0xYy2yfUz5EGeZ8HT4OcJKNKj+he4JDstwbMjh013UCAycS0D6/qzlWEorctgGtsjEnfTF+JvZ+pYm+doogYPagv/9JlpIEdqUs0rezneE4j8THs49qckACDPAq+aMACgr7b2/kg2KEC1t1nPc1CiymdCYR8oKWh97HiS6eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712583439; c=relaxed/simple;
	bh=aUpnEhLZkHEK7BjO2NlX1kxJnUSh9ZWUKOZfSqk9s+U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VSzTrHKG/zRpS1mDkXJ2VFriFdwp68TGISl4ue5gDVTKdvT01+cWGFJ7RR8S0QeYac5MOWNhAsegsiS7EBbLBE6hijot/+yz+3blsu4N/tPxVjMFuCZ2WsPYLHhgTeQ4kHlrwKOeYce3pQIRbLpc2+xFO6w19JhJhYuoxlNrJKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MU4xNdzI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E708C433C7;
	Mon,  8 Apr 2024 13:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712583439;
	bh=aUpnEhLZkHEK7BjO2NlX1kxJnUSh9ZWUKOZfSqk9s+U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MU4xNdzIoABKZOqc/HII/r7gWKST3sdZ2nRAPkX/V1a1wFNn/ieMRZZiMpcU39yHR
	 xguGwS+Yt8iEu3aVzN1GOfX+slNDkQ0MykWe//MSkPC8T9zzUBO02rg3Dm9AZapLA5
	 utBUkWfKK2h+MpGWxSsLtOBwfo7tH8cmkG6ZT3fA=
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
Subject: [PATCH 6.8 179/273] cifs: Fix caching to try to do open O_WRONLY as rdwr on server
Date: Mon,  8 Apr 2024 14:57:34 +0200
Message-ID: <20240408125314.831583040@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240408125309.280181634@linuxfoundation.org>
References: <20240408125309.280181634@linuxfoundation.org>
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

6.8-stable review patch.  If anyone has any objections, please let me know.

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
index 89333d9bce36e..37897b919dd5a 100644
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
index 9d42a39009076..9ec835320f8a7 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -206,12 +206,12 @@ cifs_mark_open_files_invalid(struct cifs_tcon *tcon)
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
@@ -348,11 +348,16 @@ static int cifs_nt_open(const char *full_path, struct inode *inode, struct cifs_
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
@@ -389,6 +394,7 @@ static int cifs_nt_open(const char *full_path, struct inode *inode, struct cifs_
 	if (f_flags & O_DIRECT)
 		create_options |= CREATE_NO_BUFFER;
 
+retry_open:
 	oparms = (struct cifs_open_parms) {
 		.tcon = tcon,
 		.cifs_sb = cifs_sb,
@@ -400,8 +406,16 @@ static int cifs_nt_open(const char *full_path, struct inode *inode, struct cifs_
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
@@ -834,11 +848,11 @@ int cifs_open(struct inode *inode, struct file *file)
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
@@ -903,6 +917,7 @@ cifs_reopen_file(struct cifsFileInfo *cfile, bool can_flush)
 	int disposition = FILE_OPEN;
 	int create_options = CREATE_NOT_DIR;
 	struct cifs_open_parms oparms;
+	int rdwr_for_fscache = 0;
 
 	xid = get_xid();
 	mutex_lock(&cfile->fh_mutex);
@@ -966,7 +981,11 @@ cifs_reopen_file(struct cifsFileInfo *cfile, bool can_flush)
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
@@ -978,6 +997,7 @@ cifs_reopen_file(struct cifsFileInfo *cfile, bool can_flush)
 	if (server->ops->get_lease_key)
 		server->ops->get_lease_key(inode, &cfile->fid);
 
+retry_open:
 	oparms = (struct cifs_open_parms) {
 		.tcon = tcon,
 		.cifs_sb = cifs_sb,
@@ -1003,6 +1023,11 @@ cifs_reopen_file(struct cifsFileInfo *cfile, bool can_flush)
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
@@ -1011,6 +1036,9 @@ cifs_reopen_file(struct cifsFileInfo *cfile, bool can_flush)
 		goto reopen_error_exit;
 	}
 
+	if (rdwr_for_fscache == 2)
+		cifs_invalidate_cache(inode, FSCACHE_INVAL_DIO_WRITE);
+
 #ifdef CONFIG_CIFS_ALLOW_INSECURE_LEGACY
 reopen_success:
 #endif /* CONFIG_CIFS_ALLOW_INSECURE_LEGACY */
diff --git a/fs/smb/client/fscache.h b/fs/smb/client/fscache.h
index a3d73720914f8..1f2ea9f5cc9a8 100644
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
-- 
2.43.0




