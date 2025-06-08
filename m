Return-Path: <linux-fsdevel+bounces-50951-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64CC5AD160E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 01:49:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A5E1168885
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Jun 2025 23:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C268E268684;
	Sun,  8 Jun 2025 23:48:50 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D7C2A1BA;
	Sun,  8 Jun 2025 23:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749426530; cv=none; b=nHX+dOe1ZPpIxwACVHJ+ct9NqonHyh9tbq8/lbLwL1akwsg4pmEW4ab2RtZqsF64d2B80PmTllrcmv/vmf9nM0W5tqFntJrIZW3xTCfn0gSqfVCer6LeBMM0s5BWuf5DqLMPHAP2tkVYs/4Drlz0XhIEFCNLXDk8dH0Lis5G6r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749426530; c=relaxed/simple;
	bh=9B5X/oD76eTEj8z5rzhkKWFf5mfs3ETmR8474txVlXc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eajcyJ+rVbxtWaOWb8R3cj0tvwnJBUVeiFHYV/r1gQPXXQQiEtxtJgzj84YUqMXM1X5fdfWZrAjk4kjgD7vxr6qDWZ4GjpUyOeERFJMhZaGoxi54K7Yz4kl9Jpk1bEe46pKz6bgUpZo2+XNQ+fZxi9z3tCskuyv5MzhbLhtyo3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uOPkp-005xqs-Ip;
	Sun, 08 Jun 2025 23:48:43 +0000
From: NeilBrown <neil@brown.name>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <smfrench@gmail.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Tom Talpey <tom@talpey.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] smb/server: simplify ksmbd_vfs_kern_path_locked()
Date: Mon,  9 Jun 2025 09:35:08 +1000
Message-ID: <20250608234108.30250-3-neil@brown.name>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250608234108.30250-1-neil@brown.name>
References: <20250608234108.30250-1-neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ksmbd_vfs_kern_path_locked() first tries to look up the path with the
given case.  When this fails, if caseless is set, it loops over the
components in the path, opening the relevant directory and searching
for a name which matches.  This name is copied over the original and the
the process repeats.  Each time a lookup with the newly updated path is
repeated from the top (vfs_path_lookup()).

When the last component has been case-corrected the simplest next step
is to repeat the original lookup with ksmbd_vfs_path_lookup_locked().
If this works it gives exactly what we want, if it fails it gives the
correct failure.

This observation allows the code to be simplified, in particular
removing the ksmbd_vfs_lock_parent() call.

This patch also removes the duplication of "name" and "filepath" (two
names for the one thing) and calls path_put(parent_path) sooner so
parent_path can be passed directly to vfs_path_lookup avoiding the need
to store it temporarily in "path" and then copying into parent_path.

This patch removes one user of ksmbd_vfs_lock_parent() which will
simplify a future patch.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/smb/server/vfs.c | 101 ++++++++++++++++++--------------------------
 1 file changed, 40 insertions(+), 61 deletions(-)

diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
index ba45e809555a..654c2f14a9e6 100644
--- a/fs/smb/server/vfs.c
+++ b/fs/smb/server/vfs.c
@@ -1208,83 +1208,62 @@ static int ksmbd_vfs_lookup_in_dir(const struct path *dir, char *name,
  *
  * Return:	0 on success, otherwise error
  */
-int ksmbd_vfs_kern_path_locked(struct ksmbd_work *work, char *name,
+int ksmbd_vfs_kern_path_locked(struct ksmbd_work *work, char *filepath,
 			       unsigned int flags, struct path *parent_path,
 			       struct path *path, bool caseless)
 {
 	struct ksmbd_share_config *share_conf = work->tcon->share_conf;
+	size_t path_len, remain_len;
 	int err;
 
-	err = ksmbd_vfs_path_lookup_locked(share_conf, name, flags, parent_path,
+retry:
+	err = ksmbd_vfs_path_lookup_locked(share_conf, filepath, flags, parent_path,
 					   path);
-	if (!err)
-		return 0;
-
-	if (caseless) {
-		char *filepath;
-		size_t path_len, remain_len;
-
-		filepath = name;
-		path_len = strlen(filepath);
-		remain_len = path_len;
-
-		*parent_path = share_conf->vfs_path;
-		path_get(parent_path);
-
-		while (d_can_lookup(parent_path->dentry)) {
-			char *filename = filepath + path_len - remain_len;
-			char *next = strchrnul(filename, '/');
-			size_t filename_len = next - filename;
-			bool is_last = !next[0];
-
-			if (filename_len == 0)
-				break;
+	if (!err || !caseless)
+		return err;
 
-			err = ksmbd_vfs_lookup_in_dir(parent_path, filename,
-						      filename_len,
-						      work->conn->um);
-			if (err)
-				goto out2;
+	path_len = strlen(filepath);
+	remain_len = path_len;
 
-			next[0] = '\0';
+	*parent_path = share_conf->vfs_path;
+	path_get(parent_path);
 
-			err = vfs_path_lookup(share_conf->vfs_path.dentry,
-					      share_conf->vfs_path.mnt,
-					      filepath,
-					      flags,
-					      path);
-			if (!is_last)
-				next[0] = '/';
-			if (err)
-				goto out2;
-			else if (is_last)
-				goto out1;
-			path_put(parent_path);
-			*parent_path = *path;
+	while (d_can_lookup(parent_path->dentry)) {
+		char *filename = filepath + path_len - remain_len;
+		char *next = strchrnul(filename, '/');
+		size_t filename_len = next - filename;
+		bool is_last = !next[0];
 
-			remain_len -= filename_len + 1;
-		}
+		if (filename_len == 0)
+			break;
 
-		err = -EINVAL;
-out2:
+		err = ksmbd_vfs_lookup_in_dir(parent_path, filename,
+					      filename_len,
+					      work->conn->um);
 		path_put(parent_path);
-	}
-
-out1:
-	if (!err) {
-		err = mnt_want_write(parent_path->mnt);
-		if (err) {
-			path_put(path);
-			path_put(parent_path);
-			return err;
+		if (err)
+			goto out;
+		if (is_last) {
+			caseless = false;
+			goto retry;
 		}
+		next[0] = '\0';
+
+		err = vfs_path_lookup(share_conf->vfs_path.dentry,
+				      share_conf->vfs_path.mnt,
+				      filepath,
+				      flags,
+				      parent_path);
+		next[0] = '/';
+		if (err)
+			goto out;
 
-		err = ksmbd_vfs_lock_parent(parent_path->dentry, path->dentry);
-		if (err) {
-			path_put(path);
-			path_put(parent_path);
-		}
+		remain_len -= filename_len + 1;
 	}
+
+	err = -EINVAL;
+	path_put(parent_path);
+out:
 	return err;
 }
 
-- 
2.49.0


