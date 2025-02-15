Return-Path: <linux-fsdevel+bounces-41770-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C029BA36C0C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Feb 2025 05:48:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E7363B0F1E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Feb 2025 04:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57C6317A586;
	Sat, 15 Feb 2025 04:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="aiNgE/az"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8947C144304;
	Sat, 15 Feb 2025 04:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739594863; cv=none; b=Qtmw5W1BDwlB66OjlcMboLGRxpcfTdOk+yZbatfkVjmwexhRCysEQ6LSmwpAIjNc41sHdkN8d0J07ER8F5HxaQon++rSL5o9nUAVCtA2Yayq2hGuDtD2g7HNhT821GyRYjMm2hW22Sg1SsLOS7CUbPqWEsD3veYooiDEj9CPEDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739594863; c=relaxed/simple;
	bh=n3Q6rld6C2lFjnu09tcWqpv8A5ZalLViWJFE3UIYJeE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tnTiu+D2DygoP8USgRGdbzZq7G4JUX23A0oHog2SG4EPXnnKdFruSiPo4v6o8L9uLTqJdZ8F2OpKxlD3x7HW8ndLj4oF4xv0djssvFJH8YmvEELVvyBxQIBci+Kzc9aS4FiRT0BI8r8lic6gfsMtS5Imk+GDqcO/FJ5qTJmCKsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=aiNgE/az; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=hUWIlSCzRiTw5BSB9gVuV5/XXaY00kg/CcwMp1vjuGA=; b=aiNgE/az0Qr7LVcBXJSdE9sfWb
	lzNkelgDTYz/n3sz2SFdD2YmRdXrf1aff5fKtd72M4t2MXegTaCnA7ijzJjWR1nMgUzYBTT+huHtB
	iE4CoMGRSsD1/i2Cpv7t1THNplLfOENZnh4i7unvVbQp7T26BpTZEu3mXxjgfcz64fMyRp6lsk51T
	IIkaUrJgBRkSwUBOVLVLhaVFQJcVqghS1JrBOZ5Kg09bjKBJaIzjOx5tmWJVjEKYgnohLwGZRRDD5
	KKNbfo4sq1gbycin/LaoXSw9DtymGZJS1EkDqOg34kby2dnPW9/TvWcZ0LHTBOKJjyrGSKbtX3/x7
	dYjUTCdg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tjA5b-0000000ETqt-3mxD;
	Sat, 15 Feb 2025 04:47:39 +0000
Date: Sat, 15 Feb 2025 04:47:39 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Luis Henriques <luis@igalia.com>
Cc: Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 2/2] ceph: fix a race with rename() in ceph_mdsc_build_path()
Message-ID: <20250215044739.GB3451131@ZenIV>
References: <20250214024756.GY1977892@ZenIV>
 <20250214032820.GZ1977892@ZenIV>
 <bbc3361f9c241942f44298286ba09b087a10b78b.camel@kernel.org>
 <87frkg7bqh.fsf@igalia.com>
 <20250215044616.GF1977892@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250215044616.GF1977892@ZenIV>
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
 fs/ceph/crypto.c     | 20 +++-----------------
 fs/ceph/crypto.h     | 18 ++++--------------
 fs/ceph/dir.c        |  7 +++----
 fs/ceph/mds_client.c |  4 ++--
 5 files changed, 19 insertions(+), 48 deletions(-)

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
index 09346b91215a..76a4a7e60270 100644
--- a/fs/ceph/crypto.c
+++ b/fs/ceph/crypto.c
@@ -260,23 +260,17 @@ static struct inode *parse_longname(const struct inode *parent,
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
+	buf[elen] = '\0';
 	/* Handle the special case of snapshot names that start with '_' */
 	if (ceph_snap(dir) == CEPH_SNAPDIR && *p == '_') {
 		dir = parse_longname(parent, p, &name_len);
@@ -349,14 +343,6 @@ int ceph_encode_encrypted_dname(struct inode *parent, struct qstr *d_name,
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
index 62e99e65250d..539954e2ea38 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -422,17 +422,16 @@ static int ceph_readdir(struct file *file, struct dir_context *ctx)
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
index 54b3421501e9..7dc854631b55 100644
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


