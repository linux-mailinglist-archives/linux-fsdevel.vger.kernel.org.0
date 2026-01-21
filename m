Return-Path: <linux-fsdevel+bounces-74918-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sKQbMGo9cWnKfQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74918-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 21:56:10 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C3F05DACC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 21:56:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2E7E480C8D2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 20:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F23D53128B0;
	Wed, 21 Jan 2026 20:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="unknown key version" (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="PLWDF73e";
	dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b="mssaQIEp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from e2i340.smtp2go.com (e2i340.smtp2go.com [103.2.141.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10EFD3D525A
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jan 2026 20:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.2.141.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769026439; cv=none; b=o9fzN1872fhgV4r2RUnMPe9ZdbW6JhUpB+4Wmk5+wUBWYf81xIo+9Dz1vYJQjkmX5ykdfACyLcBhopyhbuUQ4C+hA+b4MC/Vw1uXuKOimcocXtMQK1/k7La38gXmfK0JGqVaqlh6p+oCZ12napcDxWIzXYH9aP0wkiRF4c3NVgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769026439; c=relaxed/simple;
	bh=oXRQ+OIvRVA8lOdQTnWadsO0WEXGTxyNaHE7RJnSbuI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p8OlGW5wRxgLTxviuIwIcld70lab/NQydV/EFzvY8mHUIUSVgTk8vr2Q9V7+d0VbWPbLHmk9d7ldwY1MGud92P6RSFYQmwfNS7s5Phkub/MKj0QTZPO990TzEMOOBdqs8A01aKR9IeB6Lwzrs0ZS0ROHy7VJmpZxYOLekKEXHVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt; spf=pass smtp.mailfrom=em510616.triplefau.lt; dkim=fail (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=PLWDF73e reason="unknown key version"; dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b=mssaQIEp; arc=none smtp.client-ip=103.2.141.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em510616.triplefau.lt
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpservice.net; s=maxzs0.a1-4.dyn; x=1769027337; h=Feedback-ID:
	X-Smtpcorp-Track:Message-ID:Date:Subject:To:From:Reply-To:Sender:
	List-Unsubscribe:List-Unsubscribe-Post;
	bh=1bBRb8rvUmXiBXLsNIGFcB0tqFd9sAVSXXO9H/xLowQ=; b=PLWDF73ergLKbe99AI2IInK3mz
	uKlPax8vuoWEvnVDeyQHcn7Kokb2eX+vjtUiP5o8rQsBVovRCGp8wqbr6O80pxI+BF0SQ7sTznuKC
	P1LaWXd3tZ1tgXtidIs/zsQr2OXH9k0Exct0+291At6hBKYM2CQheXPgu2LYlqMOn1JUPXr4TZRme
	FqFsPe45Eg2NJPGmI70L+haS6428dsd7v8fGu5ejR5SvSgCY48TcVJAcuk6KLd7WnsL3yUopPqN9u
	sVeEkO+aPuM8BOrhN+T1r7p6m71QjR45+mL3sNs+l4Lm8hzh593/3pwf98w/uRbgssBy/LKk7GLFM
	6FHHZNJA==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1769026437; h=from : subject
 : to : message-id : date;
 bh=1bBRb8rvUmXiBXLsNIGFcB0tqFd9sAVSXXO9H/xLowQ=;
 b=mssaQIEpG3dLtJ5JcTlynAR77FzDDvCseql9I5KeFa6y2VfpmkvJu4QMy3RY1Ql+Dv2/d
 kGVoz7KfHGYDN2LnR8WyQrqsvF9PbEGYLMIxFaVuvMXyvBXJj8Ivb50CO1OdT9EOeWmByQD
 pOS7X3sEzQJnLMs8bhi+8hZ3cLJvWmWY8lUYKSyg3zAjeA3yWNYeL9cZsUGOJDaq2W1WLw7
 d1gk5fQb6z3AuX7b7y7IwecszUOULaL05X5dOvGPWqMLY7sUmKIeUQe0lvK/rb16PL+GqCj
 ytvnEEb1abRtZQKk4jLfO0v4M+57pIOstEFuUUt520Do+0VnC1PG9OKm1+GA==
Received: from [10.172.233.45] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <repk@triplefau.lt>)
 id 1vieaM-TRk2I3-Ta; Wed, 21 Jan 2026 20:13:50 +0000
Received: from [10.12.239.196] (helo=localhost) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.98.1-S2G) (envelope-from <repk@triplefau.lt>)
 id 1vieaM-AIkwcC8tEoU-IKfM; Wed, 21 Jan 2026 20:13:50 +0000
From: Remi Pommarel <repk@triplefau.lt>
To: v9fs@lists.linux.dev
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 Eric Van Hensbergen <ericvh@kernel.org>,
 Latchesar Ionkov <lucho@ionkov.net>,
 Dominique Martinet <asmadeus@codewreck.org>,
 Christian Schoenebeck <linux_oss@crudebyte.com>,
 Remi Pommarel <repk@triplefau.lt>
Subject: [PATCH v2 3/3] 9p: Enable symlink caching in page cache
Date: Wed, 21 Jan 2026 20:56:10 +0100
Message-ID: <dfc736a3b22d1a799ec0eb30c038d75120745610.1769013622.git.repk@triplefau.lt>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1769013622.git.repk@triplefau.lt>
References: <cover.1769013622.git.repk@triplefau.lt>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Smtpcorp-Track: UMfLu2Pc_xVd._uadojf__kY7.joe_5Ak8DIS
Feedback-ID: 510616m:510616apGKSTK:510616sgw8awW5O5
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[triplefau.lt:s=s510616];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-74918-lists,linux-fsdevel=lfdr.de];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[triplefau.lt,quarantine];
	DKIM_TRACE(0.00)[triplefau.lt:+];
	FROM_NEQ_ENVFROM(0.00)[repk@triplefau.lt,linux-fsdevel@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[triplefau.lt:email,triplefau.lt:dkim,triplefau.lt:mid,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 6C3F05DACC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Currently, when cache=loose is enabled, file reads are cached in the
page cache, but symlink reads are not. This patch allows the results
of p9_client_readlink() to be stored in the page cache, eliminating
the need for repeated 9P transactions on subsequent symlink accesses.

This change improves performance for workloads that involve frequent
symlink resolution.

Signed-off-by: Remi Pommarel <repk@triplefau.lt>
---
 fs/9p/vfs_addr.c       | 24 ++++++++++++--
 fs/9p/vfs_inode.c      |  6 ++--
 fs/9p/vfs_inode_dotl.c | 73 +++++++++++++++++++++++++++++++++++++-----
 3 files changed, 90 insertions(+), 13 deletions(-)

diff --git a/fs/9p/vfs_addr.c b/fs/9p/vfs_addr.c
index 862164181bac..ee672abbb02c 100644
--- a/fs/9p/vfs_addr.c
+++ b/fs/9p/vfs_addr.c
@@ -70,10 +70,19 @@ static void v9fs_issue_read(struct netfs_io_subrequest *subreq)
 {
 	struct netfs_io_request *rreq = subreq->rreq;
 	struct p9_fid *fid = rreq->netfs_priv;
+	char *target;
 	unsigned long long pos = subreq->start + subreq->transferred;
-	int total, err;
-
-	total = p9_client_read(fid, pos, &subreq->io_iter, &err);
+	int total, err, len, n;
+
+	if (S_ISLNK(rreq->inode->i_mode)) {
+		err = p9_client_readlink(fid, &target);
+		len = strnlen(target, PAGE_SIZE - 1);
+		n = copy_to_iter(target, len, &subreq->io_iter);
+		if (n != len)
+			err = -EFAULT;
+		total = i_size_read(rreq->inode);
+	} else
+		total = p9_client_read(fid, pos, &subreq->io_iter, &err);
 
 	/* if we just extended the file size, any portion not in
 	 * cache won't be on server and is zeroes */
@@ -99,6 +108,7 @@ static void v9fs_issue_read(struct netfs_io_subrequest *subreq)
 static int v9fs_init_request(struct netfs_io_request *rreq, struct file *file)
 {
 	struct p9_fid *fid;
+	struct dentry *dentry;
 	bool writing = (rreq->origin == NETFS_READ_FOR_WRITE ||
 			rreq->origin == NETFS_WRITETHROUGH ||
 			rreq->origin == NETFS_UNBUFFERED_WRITE ||
@@ -115,6 +125,14 @@ static int v9fs_init_request(struct netfs_io_request *rreq, struct file *file)
 		if (!fid)
 			goto no_fid;
 		p9_fid_get(fid);
+	} else if (S_ISLNK(rreq->inode->i_mode)) {
+		dentry = d_find_alias(rreq->inode);
+		if (!dentry)
+			goto no_fid;
+		fid = v9fs_fid_lookup(dentry);
+		dput(dentry);
+		if (IS_ERR(fid))
+			goto no_fid;
 	} else {
 		fid = v9fs_fid_find_inode(rreq->inode, writing, INVALID_UID, true);
 		if (!fid)
diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index a82a71be309b..e1b762f3e081 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -302,10 +302,12 @@ int v9fs_init_inode(struct v9fs_session_info *v9ses,
 			goto error;
 		}
 
-		if (v9fs_proto_dotl(v9ses))
+		if (v9fs_proto_dotl(v9ses)) {
 			inode->i_op = &v9fs_symlink_inode_operations_dotl;
-		else
+			inode_nohighmem(inode);
+		} else {
 			inode->i_op = &v9fs_symlink_inode_operations;
+		}
 
 		break;
 	case S_IFDIR:
diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
index 6312b3590f74..486b11dbada3 100644
--- a/fs/9p/vfs_inode_dotl.c
+++ b/fs/9p/vfs_inode_dotl.c
@@ -686,9 +686,13 @@ v9fs_vfs_symlink_dotl(struct mnt_idmap *idmap, struct inode *dir,
 	int err;
 	kgid_t gid;
 	const unsigned char *name;
+	umode_t mode;
+	struct v9fs_session_info *v9ses;
 	struct p9_qid qid;
 	struct p9_fid *dfid;
 	struct p9_fid *fid = NULL;
+	struct inode *inode;
+	struct posix_acl *dacl = NULL, *pacl = NULL;
 
 	name = dentry->d_name.name;
 	p9_debug(P9_DEBUG_VFS, "%lu,%s,%s\n", dir->i_ino, name, symname);
@@ -702,6 +706,15 @@ v9fs_vfs_symlink_dotl(struct mnt_idmap *idmap, struct inode *dir,
 
 	gid = v9fs_get_fsgid_for_create(dir);
 
+	/* Update mode based on ACL value */
+	err = v9fs_acl_mode(dir, &mode, &dacl, &pacl);
+	if (err) {
+		p9_debug(P9_DEBUG_VFS,
+			 "Failed to get acl values in symlink %d\n",
+			 err);
+		goto error;
+	}
+
 	/* Server doesn't alter fid on TSYMLINK. Hence no need to clone it. */
 	err = p9_client_symlink(dfid, name, symname, gid, &qid);
 
@@ -712,8 +725,30 @@ v9fs_vfs_symlink_dotl(struct mnt_idmap *idmap, struct inode *dir,
 
 	v9fs_invalidate_inode_attr(dir);
 
+	/* instantiate inode and assign the unopened fid to the dentry */
+	fid = p9_client_walk(dfid, 1, &name, 1);
+	if (IS_ERR(fid)) {
+		err = PTR_ERR(fid);
+		p9_debug(P9_DEBUG_VFS, "p9_client_walk failed %d\n",
+			 err);
+		goto error;
+	}
+
+	v9ses = v9fs_inode2v9ses(dir);
+	inode = v9fs_get_new_inode_from_fid(v9ses, fid, dir->i_sb);
+	if (IS_ERR(inode)) {
+		err = PTR_ERR(inode);
+		p9_debug(P9_DEBUG_VFS, "inode creation failed %d\n",
+			 err);
+		goto error;
+	}
+	v9fs_set_create_acl(inode, fid, dacl, pacl);
+	v9fs_fid_add(dentry, &fid);
+	d_instantiate(dentry, inode);
+	err = 0;
 error:
 	p9_fid_put(fid);
+	v9fs_put_acl(dacl, pacl);
 	p9_fid_put(dfid);
 	return err;
 }
@@ -853,24 +888,23 @@ v9fs_vfs_mknod_dotl(struct mnt_idmap *idmap, struct inode *dir,
 }
 
 /**
- * v9fs_vfs_get_link_dotl - follow a symlink path
+ * v9fs_vfs_get_link_nocache_dotl - Resolve a symlink directly.
+ *
+ * To be used when symlink caching is not enabled.
+ *
  * @dentry: dentry for symlink
  * @inode: inode for symlink
  * @done: destructor for return value
  */
-
 static const char *
-v9fs_vfs_get_link_dotl(struct dentry *dentry,
-		       struct inode *inode,
-		       struct delayed_call *done)
+v9fs_vfs_get_link_nocache_dotl(struct dentry *dentry,
+			       struct inode *inode,
+			       struct delayed_call *done)
 {
 	struct p9_fid *fid;
 	char *target;
 	int retval;
 
-	if (!dentry)
-		return ERR_PTR(-ECHILD);
-
 	p9_debug(P9_DEBUG_VFS, "%pd\n", dentry);
 
 	fid = v9fs_fid_lookup(dentry);
@@ -884,6 +918,29 @@ v9fs_vfs_get_link_dotl(struct dentry *dentry,
 	return target;
 }
 
+/**
+ * v9fs_vfs_get_link_dotl - follow a symlink path
+ * @dentry: dentry for symlink
+ * @inode: inode for symlink
+ * @done: destructor for return value
+ */
+static const char *
+v9fs_vfs_get_link_dotl(struct dentry *dentry,
+		       struct inode *inode,
+		       struct delayed_call *done)
+{
+	struct v9fs_session_info *v9ses;
+
+	if (!dentry)
+		return ERR_PTR(-ECHILD);
+
+	v9ses = v9fs_inode2v9ses(inode);
+	if (v9ses->cache & (CACHE_META|CACHE_LOOSE))
+		return page_get_link(dentry, inode, done);
+
+	return v9fs_vfs_get_link_nocache_dotl(dentry, inode, done);
+}
+
 int v9fs_refresh_inode_dotl(struct p9_fid *fid, struct inode *inode)
 {
 	struct p9_stat_dotl *st;
-- 
2.50.1


