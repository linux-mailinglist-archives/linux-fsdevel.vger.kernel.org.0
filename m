Return-Path: <linux-fsdevel+bounces-39360-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A13EA1325B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 06:23:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6ECCC166871
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 05:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5557D189F43;
	Thu, 16 Jan 2025 05:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Tmr8eV7K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF531155389;
	Thu, 16 Jan 2025 05:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737005002; cv=none; b=p1HbiYMqrsJE8vHSEToHgPnrWtjatt1gejjFH/ftxFdMlDLRRaXw3E9kUfSP5Yu7g2xFQZ9DDECl8LQVlRDq6zOuJWEZgCrHsKPoVi4WxzuM4c3BoYE1mBhkb2DXkMT4/Sd23/4GCv7pxyrqZSuq8MJNoEU2L2ME7xVVUYcjeE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737005002; c=relaxed/simple;
	bh=UrR3Uh8Nmn6NWz9/s08gPYZE8GdEloRNSQIw8XsNKaU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I982kO9WGJMo1pNI0783lDnRBKs3ZC/Alw+jeUDceRrAVaBb9X/W6oVGGalpPkIUI6ckWuC82LB3yJ20tW3bF6OMxcAaziMoYT+a0mKNjjrPoaGEgWG/240rM+s6uNsZatw/DlmR8QzdHQI/mXV/KOWFQq09uH+NYnKjURg63kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Tmr8eV7K; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=grwWsV8lYHmPv8Iqnd51IioXh/bl+nOKonb/mlxQbMU=; b=Tmr8eV7KrwdMicg4/ZJeQp0EmR
	8dNSmfQzSZQGsZMllbHqpJMt2xqbxFcwSVszbzHtYDTJyJRgHSeWdD1hcBEZ2x9in/xyNl4aMEb9I
	kkmA/umMn0bqCcJr+/jgJNdxXhzji40dYhzQWd2+y03pmOXDWG66Q55D3qffFTrBvsLpKO9Zm6jzS
	9HIjLHsRUTY1rC2NR1Shd1dKUmWJGK8qgW1IUIC1EX7tZ6MzD8kuoDHkC8hHi2A8pgglld/brvwPP
	QtK4TomA8azBzp0H+lXPl8wTXe++n0aMM6/W4k7DDL9zWNO0k1dXtHEBqLxuV+qkB22ooXvsaLZWA
	m3HyinWw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tYILf-000000022HL-0Ftj;
	Thu, 16 Jan 2025 05:23:19 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: agruenba@redhat.com,
	amir73il@gmail.com,
	brauner@kernel.org,
	ceph-devel@vger.kernel.org,
	dhowells@redhat.com,
	hubcap@omnibond.com,
	jack@suse.cz,
	krisman@kernel.org,
	linux-nfs@vger.kernel.org,
	miklos@szeredi.hu,
	torvalds@linux-foundation.org
Subject: [PATCH v2 10/20] ceph_d_revalidate(): propagate stable name down into request enconding
Date: Thu, 16 Jan 2025 05:23:07 +0000
Message-ID: <20250116052317.485356-10-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250116052317.485356-1-viro@zeniv.linux.org.uk>
References: <20250116052103.GF1977892@ZenIV>
 <20250116052317.485356-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

Currently get_fscrypt_altname() requires ->r_dentry->d_name to be stable
and it gets that in almost all cases.  The only exception is ->d_revalidate(),
where we have a stable name, but it's passed separately - dentry->d_name
is not stable there.

Propagate it down to get_fscrypt_altname() as a new field of struct
ceph_mds_request - ->r_dname, to be used instead ->r_dentry->d_name
when non-NULL.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/ceph/dir.c        | 2 ++
 fs/ceph/mds_client.c | 9 ++++++---
 fs/ceph/mds_client.h | 2 ++
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index dc5f55bebad7..62e99e65250d 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -1998,6 +1998,8 @@ static int ceph_d_revalidate(struct inode *dir, const struct qstr *name,
 			req->r_parent = dir;
 			ihold(dir);
 
+			req->r_dname = name;
+
 			mask = CEPH_STAT_CAP_INODE | CEPH_CAP_AUTH_SHARED;
 			if (ceph_security_xattr_wanted(dir))
 				mask |= CEPH_CAP_XATTR_SHARED;
diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 219a2cc2bf3c..3b766b984713 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -2621,6 +2621,7 @@ static u8 *get_fscrypt_altname(const struct ceph_mds_request *req, u32 *plen)
 {
 	struct inode *dir = req->r_parent;
 	struct dentry *dentry = req->r_dentry;
+	const struct qstr *name = req->r_dname;
 	u8 *cryptbuf = NULL;
 	u32 len = 0;
 	int ret = 0;
@@ -2641,8 +2642,10 @@ static u8 *get_fscrypt_altname(const struct ceph_mds_request *req, u32 *plen)
 	if (!fscrypt_has_encryption_key(dir))
 		goto success;
 
-	if (!fscrypt_fname_encrypted_size(dir, dentry->d_name.len, NAME_MAX,
-					  &len)) {
+	if (!name)
+		name = &dentry->d_name;
+
+	if (!fscrypt_fname_encrypted_size(dir, name->len, NAME_MAX, &len)) {
 		WARN_ON_ONCE(1);
 		return ERR_PTR(-ENAMETOOLONG);
 	}
@@ -2657,7 +2660,7 @@ static u8 *get_fscrypt_altname(const struct ceph_mds_request *req, u32 *plen)
 	if (!cryptbuf)
 		return ERR_PTR(-ENOMEM);
 
-	ret = fscrypt_fname_encrypt(dir, &dentry->d_name, cryptbuf, len);
+	ret = fscrypt_fname_encrypt(dir, name, cryptbuf, len);
 	if (ret) {
 		kfree(cryptbuf);
 		return ERR_PTR(ret);
diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
index 38bb7e0d2d79..7c9fee9e80d4 100644
--- a/fs/ceph/mds_client.h
+++ b/fs/ceph/mds_client.h
@@ -299,6 +299,8 @@ struct ceph_mds_request {
 	struct inode *r_target_inode;       /* resulting inode */
 	struct inode *r_new_inode;	    /* new inode (for creates) */
 
+	const struct qstr *r_dname;	    /* stable name (for ->d_revalidate) */
+
 #define CEPH_MDS_R_DIRECT_IS_HASH	(1) /* r_direct_hash is valid */
 #define CEPH_MDS_R_ABORTED		(2) /* call was aborted */
 #define CEPH_MDS_R_GOT_UNSAFE		(3) /* got an unsafe reply */
-- 
2.39.5


