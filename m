Return-Path: <linux-fsdevel+bounces-15855-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94E51894E61
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Apr 2024 11:12:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B77911C20836
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Apr 2024 09:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1364557894;
	Tue,  2 Apr 2024 09:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KtKyRrDd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F3556763
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Apr 2024 09:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712049109; cv=none; b=hXxsPFhkpQKE8s+SYPzuV+Lxy72Z6xWGdn/IZGO3SWOG+7UQI+5q9GP+mjF/vk0NUXoaCV32PjvDJjc18A0UrxXSr41TYB67zSM4ePIgjF7nia1f8LPvx6/4QVkoL8a24Yh7tHdPEHqSFHD2eHsuVdxNcyiCT7GykkGdk65ywFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712049109; c=relaxed/simple;
	bh=Ufsf8Ys+y12vfFaxzhFUVQNvx9fbprXgZ9fhLlosrjA=;
	h=From:To:cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=llnydB0fmxNC9CmsA79fNYROsdxt8JNMl+G97NHHVhxnB9/3NA7s/FeUFWZKwT8z8kgS1pWwzIP7bkU/BekoGT8xFMdJoB7I29FGGa2W8bWDjD2Pm8NFJz1rs2Xu/TFWUdXxGUS8BRDQPR4x32xctahkzaXbDpm8F8CPZ8d8Ios=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KtKyRrDd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712049106;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=InWKpQOJVyYt3xjobxVfkuAKETKZj7013hZtbeHtbiw=;
	b=KtKyRrDdSiP+EG8hULa8lPFO+s0+2kRNCMT34mYCg8MpfbPVtafHqOoGRHKmJrzMr9FIhd
	y3n4aICvwoJ2uNWJhK16tsJ6sqo8zJ4bwpvJN6nJLycVHegMlw0FZYTbaV0w1OH6Z7PBlv
	8+A0VoPC9GT3CKXG+jpgs9ozYp8GLO4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-186-c7Su77-IMW6i8SCLCFF3dw-1; Tue, 02 Apr 2024 05:11:41 -0400
X-MC-Unique: c7Su77-IMW6i8SCLCFF3dw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2861E85A588;
	Tue,  2 Apr 2024 09:11:41 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.146])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C863A492BCD;
	Tue,  2 Apr 2024 09:11:39 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: Steve French <sfrench@samba.org>
cc: dhowells@redhat.com, Shyam Prasad N <nspmangalore@gmail.com>,
    Rohith Surabattula <rohiths.msft@gmail.com>,
    Jeff Layton <jlayton@kernel.org>,
    Naveen Mamindlapalli <naveenm@marvell.com>,
    linux-cifs@vger.kernel.org, netfs@lists.linux.dev,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] cifs: Fix caching to try to do open O_WRONLY as rdwr on server
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3059442.1712049095.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Apr 2024 10:11:35 +0100
Message-ID: <3059443.1712049095@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

When we're engaged in local caching of a cifs filesystem, we cannot perfor=
m
caching of a partially written cache granule unless we can read the rest o=
f
the granule.  This can result in unexpected access errors being reported t=
o
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
---
 fs/smb/client/dir.c     |   15 +++++++++++++++
 fs/smb/client/file.c    |   48 ++++++++++++++++++++++++++++++++++++++----=
------
 fs/smb/client/fscache.h |    6 ++++++
 3 files changed, 59 insertions(+), 10 deletions(-)

diff --git a/fs/smb/client/dir.c b/fs/smb/client/dir.c
index d11dc3aa458b..864b194dbaa0 100644
--- a/fs/smb/client/dir.c
+++ b/fs/smb/client/dir.c
@@ -189,6 +189,7 @@ static int cifs_do_create(struct inode *inode, struct =
dentry *direntry, unsigned
 	int disposition;
 	struct TCP_Server_Info *server =3D tcon->ses->server;
 	struct cifs_open_parms oparms;
+	int rdwr_for_fscache =3D 0;
 =

 	*oplock =3D 0;
 	if (tcon->ses->server->oplocks)
@@ -200,6 +201,10 @@ static int cifs_do_create(struct inode *inode, struct=
 dentry *direntry, unsigned
 		return PTR_ERR(full_path);
 	}
 =

+	/* If we're caching, we need to be able to fill in around partial writes=
. */
+	if (cifs_fscache_enabled(inode) && (oflags & O_ACCMODE) =3D=3D O_WRONLY)
+		rdwr_for_fscache =3D 1;
+
 #ifdef CONFIG_CIFS_ALLOW_INSECURE_LEGACY
 	if (tcon->unix_ext && cap_unix(tcon->ses) && !tcon->broken_posix_open &&
 	    (CIFS_UNIX_POSIX_PATH_OPS_CAP &
@@ -276,6 +281,8 @@ static int cifs_do_create(struct inode *inode, struct =
dentry *direntry, unsigned
 		desired_access |=3D GENERIC_READ; /* is this too little? */
 	if (OPEN_FMODE(oflags) & FMODE_WRITE)
 		desired_access |=3D GENERIC_WRITE;
+	if (rdwr_for_fscache =3D=3D 1)
+		desired_access |=3D GENERIC_READ;
 =

 	disposition =3D FILE_OVERWRITE_IF;
 	if ((oflags & (O_CREAT | O_EXCL)) =3D=3D (O_CREAT | O_EXCL))
@@ -304,6 +311,7 @@ static int cifs_do_create(struct inode *inode, struct =
dentry *direntry, unsigned
 	if (!tcon->unix_ext && (mode & S_IWUGO) =3D=3D 0)
 		create_options |=3D CREATE_OPTION_READONLY;
 =

+retry_open:
 	oparms =3D (struct cifs_open_parms) {
 		.tcon =3D tcon,
 		.cifs_sb =3D cifs_sb,
@@ -317,8 +325,15 @@ static int cifs_do_create(struct inode *inode, struct=
 dentry *direntry, unsigned
 	rc =3D server->ops->open(xid, &oparms, oplock, buf);
 	if (rc) {
 		cifs_dbg(FYI, "cifs_create returned 0x%x\n", rc);
+		if (rc =3D=3D -EACCES && rdwr_for_fscache =3D=3D 1) {
+			desired_access &=3D ~GENERIC_READ;
+			rdwr_for_fscache =3D 2;
+			goto retry_open;
+		}
 		goto out;
 	}
+	if (rdwr_for_fscache =3D=3D 2)
+		cifs_invalidate_cache(inode, FSCACHE_INVAL_DIO_WRITE);
 =

 #ifdef CONFIG_CIFS_ALLOW_INSECURE_LEGACY
 	/*
diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index 59da572d3384..1541a4f6045d 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -206,12 +206,12 @@ cifs_mark_open_files_invalid(struct cifs_tcon *tcon)
 	 */
 }
 =

-static inline int cifs_convert_flags(unsigned int flags)
+static inline int cifs_convert_flags(unsigned int flags, int rdwr_for_fsc=
ache)
 {
 	if ((flags & O_ACCMODE) =3D=3D O_RDONLY)
 		return GENERIC_READ;
 	else if ((flags & O_ACCMODE) =3D=3D O_WRONLY)
-		return GENERIC_WRITE;
+		return rdwr_for_fscache =3D=3D 1 ? (GENERIC_READ | GENERIC_WRITE) : GEN=
ERIC_WRITE;
 	else if ((flags & O_ACCMODE) =3D=3D O_RDWR) {
 		/* GENERIC_ALL is too much permission to request
 		   can cause unnecessary access denied on create */
@@ -348,11 +348,16 @@ static int cifs_nt_open(const char *full_path, struc=
t inode *inode, struct cifs_
 	int create_options =3D CREATE_NOT_DIR;
 	struct TCP_Server_Info *server =3D tcon->ses->server;
 	struct cifs_open_parms oparms;
+	int rdwr_for_fscache =3D 0;
 =

 	if (!server->ops->open)
 		return -ENOSYS;
 =

-	desired_access =3D cifs_convert_flags(f_flags);
+	/* If we're caching, we need to be able to fill in around partial writes=
. */
+	if (cifs_fscache_enabled(inode) && (f_flags & O_ACCMODE) =3D=3D O_WRONLY=
)
+		rdwr_for_fscache =3D 1;
+
+	desired_access =3D cifs_convert_flags(f_flags, rdwr_for_fscache);
 =

 /*********************************************************************
  *  open flag mapping table:
@@ -389,6 +394,7 @@ static int cifs_nt_open(const char *full_path, struct =
inode *inode, struct cifs_
 	if (f_flags & O_DIRECT)
 		create_options |=3D CREATE_NO_BUFFER;
 =

+retry_open:
 	oparms =3D (struct cifs_open_parms) {
 		.tcon =3D tcon,
 		.cifs_sb =3D cifs_sb,
@@ -400,8 +406,16 @@ static int cifs_nt_open(const char *full_path, struct=
 inode *inode, struct cifs_
 	};
 =

 	rc =3D server->ops->open(xid, &oparms, oplock, buf);
-	if (rc)
+	if (rc) {
+		if (rc =3D=3D -EACCES && rdwr_for_fscache =3D=3D 1) {
+			desired_access =3D cifs_convert_flags(f_flags, 0);
+			rdwr_for_fscache =3D 2;
+			goto retry_open;
+		}
 		return rc;
+	}
+	if (rdwr_for_fscache =3D=3D 2)
+		cifs_invalidate_cache(inode, FSCACHE_INVAL_DIO_WRITE);
 =

 	/* TODO: Add support for calling posix query info but with passing in fi=
d */
 	if (tcon->unix_ext)
@@ -834,11 +848,11 @@ int cifs_open(struct inode *inode, struct file *file=
)
 use_cache:
 	fscache_use_cookie(cifs_inode_cookie(file_inode(file)),
 			   file->f_mode & FMODE_WRITE);
-	if (file->f_flags & O_DIRECT &&
-	    (!((file->f_flags & O_ACCMODE) !=3D O_RDONLY) ||
-	     file->f_flags & O_APPEND))
-		cifs_invalidate_cache(file_inode(file),
-				      FSCACHE_INVAL_DIO_WRITE);
+	if (!(file->f_flags & O_DIRECT))
+		goto out;
+	if ((file->f_flags & (O_ACCMODE | O_APPEND)) =3D=3D O_RDONLY)
+		goto out;
+	cifs_invalidate_cache(file_inode(file), FSCACHE_INVAL_DIO_WRITE);
 =

 out:
 	free_dentry_path(page);
@@ -903,6 +917,7 @@ cifs_reopen_file(struct cifsFileInfo *cfile, bool can_=
flush)
 	int disposition =3D FILE_OPEN;
 	int create_options =3D CREATE_NOT_DIR;
 	struct cifs_open_parms oparms;
+	int rdwr_for_fscache =3D 0;
 =

 	xid =3D get_xid();
 	mutex_lock(&cfile->fh_mutex);
@@ -966,7 +981,11 @@ cifs_reopen_file(struct cifsFileInfo *cfile, bool can=
_flush)
 	}
 #endif /* CONFIG_CIFS_ALLOW_INSECURE_LEGACY */
 =

-	desired_access =3D cifs_convert_flags(cfile->f_flags);
+	/* If we're caching, we need to be able to fill in around partial writes=
. */
+	if (cifs_fscache_enabled(inode) && (cfile->f_flags & O_ACCMODE) =3D=3D O=
_WRONLY)
+		rdwr_for_fscache =3D 1;
+
+	desired_access =3D cifs_convert_flags(cfile->f_flags, rdwr_for_fscache);
 =

 	/* O_SYNC also has bit for O_DSYNC so following check picks up either */
 	if (cfile->f_flags & O_SYNC)
@@ -978,6 +997,7 @@ cifs_reopen_file(struct cifsFileInfo *cfile, bool can_=
flush)
 	if (server->ops->get_lease_key)
 		server->ops->get_lease_key(inode, &cfile->fid);
 =

+retry_open:
 	oparms =3D (struct cifs_open_parms) {
 		.tcon =3D tcon,
 		.cifs_sb =3D cifs_sb,
@@ -1003,6 +1023,11 @@ cifs_reopen_file(struct cifsFileInfo *cfile, bool c=
an_flush)
 		/* indicate that we need to relock the file */
 		oparms.reconnect =3D true;
 	}
+	if (rc =3D=3D -EACCES && rdwr_for_fscache =3D=3D 1) {
+		desired_access =3D cifs_convert_flags(cfile->f_flags, 0);
+		rdwr_for_fscache =3D 2;
+		goto retry_open;
+	}
 =

 	if (rc) {
 		mutex_unlock(&cfile->fh_mutex);
@@ -1011,6 +1036,9 @@ cifs_reopen_file(struct cifsFileInfo *cfile, bool ca=
n_flush)
 		goto reopen_error_exit;
 	}
 =

+	if (rdwr_for_fscache =3D=3D 2)
+		cifs_invalidate_cache(inode, FSCACHE_INVAL_DIO_WRITE);
+
 #ifdef CONFIG_CIFS_ALLOW_INSECURE_LEGACY
 reopen_success:
 #endif /* CONFIG_CIFS_ALLOW_INSECURE_LEGACY */
diff --git a/fs/smb/client/fscache.h b/fs/smb/client/fscache.h
index a3d73720914f..1f2ea9f5cc9a 100644
--- a/fs/smb/client/fscache.h
+++ b/fs/smb/client/fscache.h
@@ -109,6 +109,11 @@ static inline void cifs_readahead_to_fscache(struct i=
node *inode,
 		__cifs_readahead_to_fscache(inode, pos, len);
 }
 =

+static inline bool cifs_fscache_enabled(struct inode *inode)
+{
+	return fscache_cookie_enabled(cifs_inode_cookie(inode));
+}
+
 #else /* CONFIG_CIFS_FSCACHE */
 static inline
 void cifs_fscache_fill_coherency(struct inode *inode,
@@ -124,6 +129,7 @@ static inline void cifs_fscache_release_inode_cookie(s=
truct inode *inode) {}
 static inline void cifs_fscache_unuse_inode_cookie(struct inode *inode, b=
ool update) {}
 static inline struct fscache_cookie *cifs_inode_cookie(struct inode *inod=
e) { return NULL; }
 static inline void cifs_invalidate_cache(struct inode *inode, unsigned in=
t flags) {}
+static inline bool cifs_fscache_enabled(struct inode *inode) { return fal=
se; }
 =

 static inline int cifs_fscache_query_occupancy(struct inode *inode,
 					       pgoff_t first, unsigned int nr_pages,


