Return-Path: <linux-fsdevel+bounces-39359-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A19A5A1325A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 06:23:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99D9D7A3115
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 05:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26207188583;
	Thu, 16 Jan 2025 05:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Z3G1ROm0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF6614D428;
	Thu, 16 Jan 2025 05:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737005002; cv=none; b=r/EjPGZId44cTGCIUawnV3mCxRclNgfbm/zSmy/jE6pe7skKVdBMzIF1hCINE2kgaxScgJM0snKmiRB3ZrCTI/XW6E5NOpVoT+o+5z5IsBwXErYmtp+fW0UFoIKndFy3J0AqQqXFQYEqS6GneMCinp1W5cWfWEaS9HKo1571NYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737005002; c=relaxed/simple;
	bh=uG5X8+jczopsvykrPB6xench4ua1MmO7EExaE3lHOcQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ch9/vUBNt2cPfx478P9yYJsaJ5mXdDtPDE4FYrQRZm1VuQIn0sE/IfpVnTbEresswELmyTGcc7M+afL0XtfAuDIz+2WHfPmMOQemwQA1cfdaXbSpbmQnD0cVUNraUY3n73CL7paohA6n2ALvk9s24gsSfwIirEgp1vc4dZw7fHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Z3G1ROm0; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=sYKSRrwY+Cm35cFir8V1URMctS20XWh4l9lLNI10SiI=; b=Z3G1ROm0D3wqJEnqjw6TUMQiUU
	9ZVTNDQ8wZaFtl2HQEdZj86KIaPUzZFTvKjWIu06Q8F3SymQ76H2oARFu9KSUIwd9+yO19kGc9UII
	a/TJ1znvaolXUXwJzqMiX2ack/qMobTdhU1wHnAVspcWdLKapAn6dnHKdn4yoxReGvoXz8oO0iDE7
	hQekdwgiT8L9Nt+2UPp1odUVz/9U95Psu233+VidOj/iScVkSfKz+KR3kt4RLYEVfxbn6OZGm6V5L
	ZXN8na6Dcw8/7C9L1eq/M+EVy+lVsw5aD0p3nmleSfmO1NuorLQwrcBi3iyCdEs6d2mIwhFXZE/3B
	RJdb621g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tYILe-000000022HF-3zph;
	Thu, 16 Jan 2025 05:23:18 +0000
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
Subject: [PATCH v2 09/20] ceph_d_revalidate(): use stable parent inode passed by caller
Date: Thu, 16 Jan 2025 05:23:06 +0000
Message-ID: <20250116052317.485356-9-viro@zeniv.linux.org.uk>
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

No need to mess with the boilerplate for obtaining what we already
have.  Note that ceph is one of the "will want a path from filesystem
root if we want to talk to server" cases, so the name of the last
component is of little use - it is passed to fscrypt_d_revalidate()
and it's used to deal with (also crypt-related) case in request
marshalling, when encrypted name turns out to be too long.  The former
is not a problem, but the latter is racy; that part will be handled
in the next commit.

Reviewed-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/ceph/dir.c | 22 ++++------------------
 1 file changed, 4 insertions(+), 18 deletions(-)

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index c4c71c24221b..dc5f55bebad7 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -1940,30 +1940,19 @@ static int dir_lease_is_valid(struct inode *dir, struct dentry *dentry,
 /*
  * Check if cached dentry can be trusted.
  */
-static int ceph_d_revalidate(struct inode *parent_dir, const struct qstr *name,
+static int ceph_d_revalidate(struct inode *dir, const struct qstr *name,
 			     struct dentry *dentry, unsigned int flags)
 {
 	struct ceph_mds_client *mdsc = ceph_sb_to_fs_client(dentry->d_sb)->mdsc;
 	struct ceph_client *cl = mdsc->fsc->client;
 	int valid = 0;
-	struct dentry *parent;
-	struct inode *dir, *inode;
+	struct inode *inode;
 
-	valid = fscrypt_d_revalidate(parent_dir, name, dentry, flags);
+	valid = fscrypt_d_revalidate(dir, name, dentry, flags);
 	if (valid <= 0)
 		return valid;
 
-	if (flags & LOOKUP_RCU) {
-		parent = READ_ONCE(dentry->d_parent);
-		dir = d_inode_rcu(parent);
-		if (!dir)
-			return -ECHILD;
-		inode = d_inode_rcu(dentry);
-	} else {
-		parent = dget_parent(dentry);
-		dir = d_inode(parent);
-		inode = d_inode(dentry);
-	}
+	inode = d_inode_rcu(dentry);
 
 	doutc(cl, "%p '%pd' inode %p offset 0x%llx nokey %d\n",
 	      dentry, dentry, inode, ceph_dentry(dentry)->offset,
@@ -2039,9 +2028,6 @@ static int ceph_d_revalidate(struct inode *parent_dir, const struct qstr *name,
 	doutc(cl, "%p '%pd' %s\n", dentry, dentry, valid ? "valid" : "invalid");
 	if (!valid)
 		ceph_dir_clear_complete(dir);
-
-	if (!(flags & LOOKUP_RCU))
-		dput(parent);
 	return valid;
 }
 
-- 
2.39.5


