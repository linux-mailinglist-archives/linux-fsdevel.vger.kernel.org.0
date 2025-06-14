Return-Path: <linux-fsdevel+bounces-51662-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 299F7AD9A5F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Jun 2025 08:23:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 581467ADA3E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Jun 2025 06:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39A831E5B7D;
	Sat, 14 Jun 2025 06:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="s9ryv4WW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13BE01DC07D;
	Sat, 14 Jun 2025 06:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749882180; cv=none; b=EltcouEIy2nI79osdWkNnwwqKIaar9LUVWykp8/baOEQ++KIbHSb9PZaEv/fyeWig1z/2pdasYN1D5Mp+tZf5qBwP42OKiBXlwDMdgTRaIxQDVZMZ7hrt4lfheJUjNlqAKpsgXv0HXvRe+DFIX36Ya2pO3PpRERle0xiGp5/kSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749882180; c=relaxed/simple;
	bh=s8ncKfbjoUuaFvFWw1MFGMiB1D/9Qfk0QPSyrvn+kUg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jm2uBcobn8T2vR+UkhKMqP/gd+WJANAf2wNw5NV/aZd0M9znjRC1GsiNx9HTeHfeSWh0RLjHrNvzqYgjsMRf1ENvHPCC/hJlMiLuO1TeQj0oqwGH2WoNtMwAPcaomd23RtVu5Q45qP2rF2NiZV0O2F21ll8bxcOygbMd8nqGz9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=s9ryv4WW; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=ZTfConObul4qVY0QSdQ7t8u8m7+yP1EN+rWNBepTobg=; b=s9ryv4WWeeeCNVc20SjsBha5/i
	cJNrg8Qtve64SrfFmowo9PWwiUvc2RyasTgn8L69BXec1doOAgdrDMfYVkPpPYDL25IbMwbnjGVfl
	hZeRTbR6LzaLts3hTFTQNGA4pKN6qpGY2hW9gC0WbnXMPIJfQjxALcE5g8G7/LonjF09eJqwJeE4V
	3kVDuf8NWkbhcYah+ffe0uCADp2jBxKeu9k8kjH0VVQe57LOYOt0CTZL0JRmx+tIoZJRAwGCm9Ulj
	ImQtTM24I+pe1Q4UzO9ZMWsmPk4MX7EYb4DGdDA1x5Lz/bY70qbiQ8+QurBtwxz9blDqTVnSCEoO7
	Hr3KCnSQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uQKI5-00000002FL6-2QzN;
	Sat, 14 Jun 2025 06:22:57 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Slava.Dubeyko@ibm.com,
	ceph-devel@vger.kernel.org
Subject: [PATCH 3/3] ceph: fix a race with rename() in ceph_mdsc_build_path()
Date: Sat, 14 Jun 2025 07:22:57 +0100
Message-ID: <20250614062257.535594-3-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250614062257.535594-1-viro@zeniv.linux.org.uk>
References: <20250614062051.GC1880847@ZenIV>
 <20250614062257.535594-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

Lift copying the name into callers of ceph_encode_encrypted_dname()
that do not have it already copied; ceph_encode_encrypted_fname()
disappears.

That fixes a UAF in ceph_mdsc_build_path() - while the initial copy
of plaintext into buf is done under ->d_lock, we access the
original name again in ceph_encode_encrypted_fname() and that is
done without any locking.  With ceph_encode_encrypted_dname() using
the stable copy the problem goes away.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/ceph/caps.c       | 18 +++++++-----------
 fs/ceph/crypto.c     | 19 ++-----------------
 fs/ceph/crypto.h     | 18 ++++--------------
 fs/ceph/dir.c        |  7 +++----
 fs/ceph/mds_client.c |  4 ++--
 5 files changed, 18 insertions(+), 48 deletions(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index a8d8b56cf9d2..b1a8ff612c41 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -4957,24 +4957,20 @@ int ceph_encode_dentry_release(void **p, struct dentry *dentry,
 	cl = ceph_inode_to_client(dir);
 	spin_lock(&dentry->d_lock);
 	if (ret && di->lease_session && di->lease_session->s_mds == mds) {
+		int len = dentry->d_name.len;
 		doutc(cl, "%p mds%d seq %d\n",  dentry, mds,
 		      (int)di->lease_seq);
 		rel->dname_seq = cpu_to_le32(di->lease_seq);
 		__ceph_mdsc_drop_dentry_lease(dentry);
+		memcpy(*p, dentry->d_name.name, len);
 		spin_unlock(&dentry->d_lock);
 		if (IS_ENCRYPTED(dir) && fscrypt_has_encryption_key(dir)) {
-			int ret2 = ceph_encode_encrypted_fname(dir, dentry, *p);
-
-			if (ret2 < 0)
-				return ret2;
-
-			rel->dname_len = cpu_to_le32(ret2);
-			*p += ret2;
-		} else {
-			rel->dname_len = cpu_to_le32(dentry->d_name.len);
-			memcpy(*p, dentry->d_name.name, dentry->d_name.len);
-			*p += dentry->d_name.len;
+			len = ceph_encode_encrypted_dname(dir, *p, len);
+			if (len < 0)
+				return len;
 		}
+		rel->dname_len = cpu_to_le32(len);
+		*p += len;
 	} else {
 		spin_unlock(&dentry->d_lock);
 	}
diff --git a/fs/ceph/crypto.c b/fs/ceph/crypto.c
index 2aef56fc6275..e312f52f48e4 100644
--- a/fs/ceph/crypto.c
+++ b/fs/ceph/crypto.c
@@ -253,23 +253,16 @@ static struct inode *parse_longname(const struct inode *parent,
 	return dir;
 }
 
-int ceph_encode_encrypted_dname(struct inode *parent, struct qstr *d_name,
-				char *buf)
+int ceph_encode_encrypted_dname(struct inode *parent, char *buf, int elen)
 {
 	struct ceph_client *cl = ceph_inode_to_client(parent);
 	struct inode *dir = parent;
 	char *p = buf;
 	u32 len;
-	int name_len;
-	int elen;
+	int name_len = elen;
 	int ret;
 	u8 *cryptbuf = NULL;
 
-	memcpy(buf, d_name->name, d_name->len);
-	elen = d_name->len;
-
-	name_len = elen;
-
 	/* Handle the special case of snapshot names that start with '_' */
 	if (ceph_snap(dir) == CEPH_SNAPDIR && *p == '_') {
 		dir = parse_longname(parent, p, &name_len);
@@ -342,14 +335,6 @@ int ceph_encode_encrypted_dname(struct inode *parent, struct qstr *d_name,
 	return elen;
 }
 
-int ceph_encode_encrypted_fname(struct inode *parent, struct dentry *dentry,
-				char *buf)
-{
-	WARN_ON_ONCE(!fscrypt_has_encryption_key(parent));
-
-	return ceph_encode_encrypted_dname(parent, &dentry->d_name, buf);
-}
-
 /**
  * ceph_fname_to_usr - convert a filename for userland presentation
  * @fname: ceph_fname to be converted
diff --git a/fs/ceph/crypto.h b/fs/ceph/crypto.h
index d0768239a1c9..f752bbb2eb06 100644
--- a/fs/ceph/crypto.h
+++ b/fs/ceph/crypto.h
@@ -102,10 +102,7 @@ int ceph_fscrypt_prepare_context(struct inode *dir, struct inode *inode,
 				 struct ceph_acl_sec_ctx *as);
 void ceph_fscrypt_as_ctx_to_req(struct ceph_mds_request *req,
 				struct ceph_acl_sec_ctx *as);
-int ceph_encode_encrypted_dname(struct inode *parent, struct qstr *d_name,
-				char *buf);
-int ceph_encode_encrypted_fname(struct inode *parent, struct dentry *dentry,
-				char *buf);
+int ceph_encode_encrypted_dname(struct inode *parent, char *buf, int len);
 
 static inline int ceph_fname_alloc_buffer(struct inode *parent,
 					  struct fscrypt_str *fname)
@@ -194,17 +191,10 @@ static inline void ceph_fscrypt_as_ctx_to_req(struct ceph_mds_request *req,
 {
 }
 
-static inline int ceph_encode_encrypted_dname(struct inode *parent,
-					      struct qstr *d_name, char *buf)
+static inline int ceph_encode_encrypted_dname(struct inode *parent, char *buf,
+					      int len)
 {
-	memcpy(buf, d_name->name, d_name->len);
-	return d_name->len;
-}
-
-static inline int ceph_encode_encrypted_fname(struct inode *parent,
-					      struct dentry *dentry, char *buf)
-{
-	return -EOPNOTSUPP;
+	return len;
 }
 
 static inline int ceph_fname_alloc_buffer(struct inode *parent,
diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index a321aa6d0ed2..8478e7e75df6 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -423,17 +423,16 @@ static int ceph_readdir(struct file *file, struct dir_context *ctx)
 			req->r_inode_drop = CEPH_CAP_FILE_EXCL;
 		}
 		if (dfi->last_name) {
-			struct qstr d_name = { .name = dfi->last_name,
-					       .len = strlen(dfi->last_name) };
+			int len = strlen(dfi->last_name);
 
 			req->r_path2 = kzalloc(NAME_MAX + 1, GFP_KERNEL);
 			if (!req->r_path2) {
 				ceph_mdsc_put_request(req);
 				return -ENOMEM;
 			}
+			memcpy(req->r_path2, dfi->last_name, len);
 
-			err = ceph_encode_encrypted_dname(inode, &d_name,
-							  req->r_path2);
+			err = ceph_encode_encrypted_dname(inode, req->r_path2, len);
 			if (err < 0) {
 				ceph_mdsc_put_request(req);
 				return err;
diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 230e0c3f341f..0f497c39ff82 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -2766,8 +2766,8 @@ char *ceph_mdsc_build_path(struct ceph_mds_client *mdsc, struct dentry *dentry,
 			}
 
 			if (fscrypt_has_encryption_key(d_inode(parent))) {
-				len = ceph_encode_encrypted_fname(d_inode(parent),
-								  cur, buf);
+				len = ceph_encode_encrypted_dname(d_inode(parent),
+								  buf, len);
 				if (len < 0) {
 					dput(parent);
 					dput(cur);
-- 
2.39.5


