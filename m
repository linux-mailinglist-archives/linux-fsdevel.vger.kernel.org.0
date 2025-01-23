Return-Path: <linux-fsdevel+bounces-39916-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1F9FA19C83
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 02:49:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD385188E38D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 01:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5249B170A1A;
	Thu, 23 Jan 2025 01:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Wsivcfnt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD371E871;
	Thu, 23 Jan 2025 01:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737596809; cv=none; b=LxiSQm0tF5O0REO96MOReKq4uoNM2uvC8SB3Fw7Vima4JdfEVPQdMT4KHkr9EINlNV7eLxgs5stnq0CfmNobKQXaXUgQe8uC4mb1XOSqDYuK+bNI+5dDIsq3gmSeA7TWtgeTny6eMpDPENUu8gw3fHDKCPNgrlIweBrpag7QHR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737596809; c=relaxed/simple;
	bh=OvsCYac6VREQ9DwhL1y7feV26RFKLeShf5vlrlSidkk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Luj8RCo+zov5x6CIg3cjyGkDipbSLI1F8hE0TTPaDo3P7Jh2GQebg6yGlUHZAL/S/mgMsiTvULXp6X6S5Jt0DpbFStRxUi1DR2eio/GED+jHaC86eX3BFqaIThZG8c7GeLD2lqfvS3Ci0Z2vNAxy3qGJfQ9jjJmeT8CJBZxiCBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Wsivcfnt; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=ct/u613PzDWPcdGjSLq5vJ5UW9GDE+E/FU7hcfHVMnI=; b=WsivcfntNw5OS0CZEs0d7U0aJn
	SqZJ1INki+mnIFjGRm8wsxFPy9F4Rj3YIxO6HwpF51/tNTUJaRRZkeX0SrnmICW+PpwxKUWmptvAg
	MYXkj8sSZhwIUN2ufBeySQpS0mN+oF+e4eIXJG3W1b0l5eMOfGDo9euLO69V/63BLBKmHp9xgodc/
	OUzBtLcEykvRO61haPWGmDhU0W8BSCtfJnmrmzJ4qHgLJpZst3N/UTDFo2QVFJqRKWa5ZtYw45LbS
	Pa58aajZuor+GnBJaRKbeIGieuU9wiLuXJd2FMMrX4GzKfvwkINk4Ypi8YwRtEF4uxyceUKMwvuo3
	LY68910A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tamIu-00000008F2Y-3DI4;
	Thu, 23 Jan 2025 01:46:44 +0000
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
Subject: [PATCH v3 10/20] ceph_d_revalidate(): propagate stable name down into request encoding
Date: Thu, 23 Jan 2025 01:46:33 +0000
Message-ID: <20250123014643.1964371-10-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250123014643.1964371-1-viro@zeniv.linux.org.uk>
References: <20250123014511.GA1962481@ZenIV>
 <20250123014643.1964371-1-viro@zeniv.linux.org.uk>
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

Reviewed-by: Jeff Layton <jlayton@kernel.org>
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


