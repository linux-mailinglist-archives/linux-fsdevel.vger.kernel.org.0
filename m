Return-Path: <linux-fsdevel+bounces-61131-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 475BAB556B9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 20:59:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 059EC17FE39
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 18:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09B723375AA;
	Fri, 12 Sep 2025 18:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="I897SJ6g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C08131A04D
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Sep 2025 18:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757703562; cv=none; b=JG5y/VBO2wmQbfNG5ATCFOUftmEPyt0xDqK3oKRRY8xJpI5Wo9maBg1bvfOrs/CYvpwg0CyNwjNKbLOjSjaubHpFN5vKoZBw1vEF380cPhrCLq8bn7xY8Q62pXzXGj37JvbLQ8FCTDJUD/eUjf0GqoYlyrz3OBHJ9zOG2lSTv5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757703562; c=relaxed/simple;
	bh=V1GGXjTyKNpAj0gFM3LdPhzaWapa1w52LoH5NbxVcRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jIC+ant4FdhyP/9Y1S+3C6JHTu23Tr/czQAOEW7aTyPYYEV4rBHuQ24mMZ9+kCau2bc6V694QvZ5eVYBqDCSdkVyj1hT1Q2I52k69n932GVwbKbmQInQHA+Qgrgd1DpwY98NbAqap2bggGI2w7fjCi/zHaWDUcItaTRcFYh5sHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=I897SJ6g; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=7QAacZ/cL00TA1sQPnmtM9saJJsejBwYav8IqtPSh/I=; b=I897SJ6gWdln0CqOToy987irYf
	wzTb8TKpmpvyzMpgrAJD/MK6lV83zWqXpz3WrREwnwRchYNkeBVd+EzmO5FR7/2F30KcdWoz+ZbRI
	MqkHRGguUfTK/TLkixgdd1kwrxMtg5JoBg9rMY8Uzn0UAiio0NJcO2YTBXpyCjdPFFoTbDRTHpRcB
	AfT3AYOOa2mVjAgi1JTsr4x9e5zEFvln2fO8DTM0V9+s+6972CaF5gEZrRauMCA8ge58OpcejtlBk
	KBbU3gPBuFR+hy1kCo5FPHteyzwkc25KCJjsrJr16Wxxzmoehq+SbUp/0w64BLKCeMARQMnJnSVvy
	KnY7QGkw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ux8zM-00000001g5m-3jpd;
	Fri, 12 Sep 2025 18:59:16 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: neil@brown.name
Cc: torvalds@linux-foundation.org,
	linux-fsdevel@vger.kernel.org,
	brauner@kernel.org,
	jack@suse.cz,
	miklos@szeredi.hu
Subject: [PATCH 3/9] 9p: simplify v9fs_vfs_atomic_open_dotl()
Date: Fri, 12 Sep 2025 19:59:10 +0100
Message-ID: <20250912185916.400113-3-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250912185916.400113-1-viro@zeniv.linux.org.uk>
References: <20250912185530.GZ39973@ZenIV>
 <20250912185916.400113-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

again, preexisting aliases will always be positive

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/9p/vfs_inode_dotl.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
index 5b5fda617b80..be297e335468 100644
--- a/fs/9p/vfs_inode_dotl.c
+++ b/fs/9p/vfs_inode_dotl.c
@@ -238,20 +238,16 @@ v9fs_vfs_atomic_open_dotl(struct inode *dir, struct dentry *dentry,
 	struct p9_fid *dfid = NULL, *ofid = NULL;
 	struct v9fs_session_info *v9ses;
 	struct posix_acl *pacl = NULL, *dacl = NULL;
-	struct dentry *res = NULL;
 
 	if (d_in_lookup(dentry)) {
-		res = v9fs_vfs_lookup(dir, dentry, 0);
-		if (IS_ERR(res))
-			return PTR_ERR(res);
-
-		if (res)
-			dentry = res;
+		struct dentry *res = v9fs_vfs_lookup(dir, dentry, 0);
+		if (res || d_really_is_positive(dentry))
+			return	finish_no_open(file, res);
 	}
 
 	/* Only creates */
-	if (!(flags & O_CREAT) || d_really_is_positive(dentry))
-		return	finish_no_open(file, res);
+	if (!(flags & O_CREAT))
+		return	finish_no_open(file, NULL);
 
 	v9ses = v9fs_inode2v9ses(dir);
 
@@ -337,7 +333,6 @@ v9fs_vfs_atomic_open_dotl(struct inode *dir, struct dentry *dentry,
 	p9_fid_put(ofid);
 	p9_fid_put(fid);
 	v9fs_put_acl(dacl, pacl);
-	dput(res);
 	return err;
 }
 
-- 
2.47.2


