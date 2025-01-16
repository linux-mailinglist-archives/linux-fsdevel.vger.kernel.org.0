Return-Path: <linux-fsdevel+bounces-39367-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2640A13275
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 06:24:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 918561888680
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 05:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C92C7DA7F;
	Thu, 16 Jan 2025 05:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="O1CWobkw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7ED156F3C;
	Thu, 16 Jan 2025 05:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737005003; cv=none; b=JMFyAKSPDwl/pf17E16rnKwHKztChM8eEPT7oQMAsaDShIkLLEGoCxbIYKTUDo6Adzvq+jfe8e6p7CIf0CxA7waMU6+ErVNStOwjY8rTfgJ7lGloOIeBkgzXz06BXsF5CRNzh33A2dkpmMiQK7LrCE+mfr5N0MFcOluEKUF9vWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737005003; c=relaxed/simple;
	bh=7GOuq5TBwi2YnJylO4jjAKPDlBh3SzN5LK5elhPSkPE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p5/+5KxWbb8PiKOwq3DB+VvlILzpsxFGy2H94PlutEFPf0S9sdfYS+v8u7/LVZMnjWd/HCAFxhxQppT4NmjEW50pmO+O2CLJCQuwz+Bdee+jCmUsFykNPwp426CmyqRHUeNySahgynZV8aw250jt0suh3N7gx12onYmZwZHKLlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=O1CWobkw; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=/1Eley4l5qG4/I/feyZqZ395nNqz7ND1A6aomzIKqMI=; b=O1CWobkw4bRl3au9GD3dinsBix
	wwvFCX2OoKGvPOIq2UpGM8WoPNOF3jfsQ7lJhjIqnCHLr67IxZkYcWCuThaIC4Rhvr41dDfis3TcP
	Ty367eJVl25glS26GEHeeCg8/JPJI8XwcHBk0Qa82kt5HoH/chrE2F3Cmv2xfpdQ/ARbtR+47bccN
	dHrDz/luk3ZkcS9hzWz5BuvZr8FYcP310dIiaIBquxNyIhG5RmCS1uBbGQSxXrLs1jLGe/BAGMD3s
	H4HqrcupX0jZWa63dTPNYmmVr7X4tKAlcQtwAw1Eoj0qeFw908VtvATv/c6DKhdrl/dxA7Cco+TTE
	XERnBUqw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tYILf-000000022Hs-1dFi;
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
Subject: [PATCH v2 13/20] vfat_revalidate{,_ci}(): use stable parent inode passed by caller
Date: Thu, 16 Jan 2025 05:23:10 +0000
Message-ID: <20250116052317.485356-13-viro@zeniv.linux.org.uk>
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

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/fat/namei_vfat.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/fs/fat/namei_vfat.c b/fs/fat/namei_vfat.c
index f9cbd5c6f932..926c26e90ef8 100644
--- a/fs/fat/namei_vfat.c
+++ b/fs/fat/namei_vfat.c
@@ -43,14 +43,9 @@ static inline void vfat_d_version_set(struct dentry *dentry,
  * If it happened, the negative dentry isn't actually negative
  * anymore.  So, drop it.
  */
-static int vfat_revalidate_shortname(struct dentry *dentry)
+static bool vfat_revalidate_shortname(struct dentry *dentry, struct inode *dir)
 {
-	int ret = 1;
-	spin_lock(&dentry->d_lock);
-	if (!inode_eq_iversion(d_inode(dentry->d_parent), vfat_d_version(dentry)))
-		ret = 0;
-	spin_unlock(&dentry->d_lock);
-	return ret;
+	return inode_eq_iversion(dir, vfat_d_version(dentry));
 }
 
 static int vfat_revalidate(struct inode *dir, const struct qstr *name,
@@ -62,7 +57,7 @@ static int vfat_revalidate(struct inode *dir, const struct qstr *name,
 	/* This is not negative dentry. Always valid. */
 	if (d_really_is_positive(dentry))
 		return 1;
-	return vfat_revalidate_shortname(dentry);
+	return vfat_revalidate_shortname(dentry, dir);
 }
 
 static int vfat_revalidate_ci(struct inode *dir, const struct qstr *name,
@@ -99,7 +94,7 @@ static int vfat_revalidate_ci(struct inode *dir, const struct qstr *name,
 	if (flags & (LOOKUP_CREATE | LOOKUP_RENAME_TARGET))
 		return 0;
 
-	return vfat_revalidate_shortname(dentry);
+	return vfat_revalidate_shortname(dentry, dir);
 }
 
 /* returns the length of a struct qstr, ignoring trailing dots */
-- 
2.39.5


