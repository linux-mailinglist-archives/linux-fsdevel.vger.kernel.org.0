Return-Path: <linux-fsdevel+bounces-62292-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B1E1B8C287
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Sep 2025 09:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D8151895607
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Sep 2025 07:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C24512EB84C;
	Sat, 20 Sep 2025 07:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="nE9xTD2O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222AB2773CC;
	Sat, 20 Sep 2025 07:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758354487; cv=none; b=uyAYirqhobIA/hvUN+M9rPus6rh5Q6H1cuGqiY5crDbVT8bpdXro98iqL27887TglPrJwhOgE7G5SoN9joBR7irP5FxjUD2nzcrkqA6FzRbkGcXbaa2JPEtZB9aUmpJNw6PgrdY2i1I3Y2qguySG0PgtDzs+qX2yQ2sVscnxkNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758354487; c=relaxed/simple;
	bh=Ie71DIWCi0Ah3EGLybzoifplxs3Ww8PvHoojot63j6I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GZsdxZmFF+9RK6eGx2PerQwvO27dTzuqNdvYEPd661c+7ftKyTu3/MGYPeeiklBGzMuohz2mZN68458x6DM6SS19tn9KdztODjrB6If4S3QUOskVpMYojoPOYFfS7fPCsX4iiuluU/Y8ljPAn6VgTVt+aaIg9nHdAq2ZTQuJ91k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=nE9xTD2O; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=cZQ+/o3tr5dpemhKGUjYS6VsiGOwzb8RklREPcRpDvg=; b=nE9xTD2O4CN6wpP4Ngft7mDdEL
	TuZcXGmk/7d3wdqCXaaVxrTXc2OSHAbf15SV7sa5HU6UiK2gZpavjRj9N/aM6/PamsDBqcxAg4fXm
	OL7LPJpsFT9Jl7xe0XrmWdWBiFpFHZhhH/JfesOcQStv2NO2kG0XrRzVAr5lhdazpsjPHAOuItv2C
	S+yo4rTy7pFfdpmUCBoKURVolp6v7OcIvRfTEnu/FPhKU0okt9N0AcAnFJKVTrkky6Vb87jl6b6wj
	aBs7nHDF0M7wtjRq/0toFn10gpnC2nogDPVajqxejcGgVd/KFjsC9q6b5xdmDwzw3ajlyOkSCo2U2
	SQIPPJtw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uzsKB-0000000ExF6-022R;
	Sat, 20 Sep 2025 07:48:03 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: torvalds@linux-foundation.org,
	brauner@kernel.org,
	jack@suse.cz,
	raven@themaw.net,
	miklos@szeredi.hu,
	a.hindborg@kernel.org,
	linux-mm@kvack.org,
	linux-efi@vger.kernel.org,
	ocfs2-devel@lists.linux.dev,
	kees@kernel.org,
	rostedt@goodmis.org,
	gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org,
	paul@paul-moore.com,
	casey@schaufler-ca.com,
	linuxppc-dev@lists.ozlabs.org,
	borntraeger@linux.ibm.com
Subject: [PATCH 19/39] debugfs: remove duplicate checks in callers of start_creating()
Date: Sat, 20 Sep 2025 08:47:38 +0100
Message-ID: <20250920074759.3564072-19-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250920074759.3564072-1-viro@zeniv.linux.org.uk>
References: <20250920074156.GK39973@ZenIV>
 <20250920074759.3564072-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

we'd already verified that DEBUGFS_ALLOW_API was there in
start_creating() - it would've failed otherwise

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/debugfs/inode.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index 1302995d6816..95eb57566d26 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -432,11 +432,6 @@ static struct dentry *__debugfs_create_file(const char *name, umode_t mode,
 	if (IS_ERR(dentry))
 		return dentry;
 
-	if (!(debugfs_allow & DEBUGFS_ALLOW_API)) {
-		failed_creating(dentry);
-		return ERR_PTR(-EPERM);
-	}
-
 	inode = debugfs_get_inode(dentry->d_sb);
 	if (unlikely(!inode)) {
 		pr_err("out of free dentries, can not create file '%s'\n",
@@ -582,11 +577,6 @@ struct dentry *debugfs_create_dir(const char *name, struct dentry *parent)
 	if (IS_ERR(dentry))
 		return dentry;
 
-	if (!(debugfs_allow & DEBUGFS_ALLOW_API)) {
-		failed_creating(dentry);
-		return ERR_PTR(-EPERM);
-	}
-
 	inode = debugfs_get_inode(dentry->d_sb);
 	if (unlikely(!inode)) {
 		pr_err("out of free dentries, can not create directory '%s'\n",
@@ -629,11 +619,6 @@ struct dentry *debugfs_create_automount(const char *name,
 	if (IS_ERR(dentry))
 		return dentry;
 
-	if (!(debugfs_allow & DEBUGFS_ALLOW_API)) {
-		failed_creating(dentry);
-		return ERR_PTR(-EPERM);
-	}
-
 	inode = debugfs_get_inode(dentry->d_sb);
 	if (unlikely(!inode)) {
 		pr_err("out of free dentries, can not create automount '%s'\n",
-- 
2.47.3


