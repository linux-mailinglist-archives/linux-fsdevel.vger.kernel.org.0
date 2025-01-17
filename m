Return-Path: <linux-fsdevel+bounces-39564-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 630B5A159D1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jan 2025 00:09:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4A9C3A1EFF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2025 23:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9045C1DD879;
	Fri, 17 Jan 2025 23:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="iMjPw57Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C981DED4A
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jan 2025 23:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737155358; cv=none; b=djA8Ow9secO8KIyvkYHuEDxmsco4nCxIGl+7bz/8NkVhI1XZWs/ZLxx1+pLMuMyjelxWe5TXOU+NwQjXlfwIuF70H2xtpjYrr3DFEMve5cwno/dYBQAT974gNCGmcga0Nm4HQwpfeYuz4z6JLXImH4rpM8lKPVHE2C4wy6bDzG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737155358; c=relaxed/simple;
	bh=+HypI7P1kCU51C3kiGuz68ziek5mIfXwCkiWnKr6UKk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=NBcNYR1ELaqaEk7uyDuGWI12nkpBH4J7w2MBME2dR14CySxf5TF2BibCLuK6lhCLn8DKvdCW/ITVLyzRAA/HzVyerTaP2NfydaojsbvktHGrivfStSE6oYcqU2N647ybT+iuN/4OmuHgXCGTpQCLwv1wBPlZ+OxMH9bB0feiZdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=iMjPw57Z; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=yIXkGQwnzX2BgXcnaBAeuJr3Wo+ssX64cIPy7lGG0mc=; b=iMjPw57ZPCfvaqvzLQExDjnVzG
	/CWi/Zu1ZkJJx/xwctbWIoDaD4xSFav+klKYGzwi1mp/rRzcT0Ib0JqxB3r8grxD96r0fKetgSE05
	YOfJwHSupgKjnvnokSBK7lIE3OZC/EKZf8m+GHEcT4/o0iUPpciuAcOV/O/uothYzcA0eVEv1utUl
	GvhZYCa5BDZg/GJCPrkPjWuoGscTFYZ4qRzet0ll/SYjvtJ1cDbwe6hYDHwR9SWVU6OVMPe3GdYKd
	bsVtPpP5YGYBUsu+XHH102neqE8bYSMWEYMMUuz0TnSdwz3M9RS0cICRnVp4mKQXY38g9G4LRnWRI
	3BiTEmww==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tYvSj-00000003egY-1fGT;
	Fri, 17 Jan 2025 23:09:13 +0000
Date: Fri, 17 Jan 2025 23:09:13 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Richard Weinberger <richard@nod.at>
Cc: linux-um@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH] hostfs: fix string handling in __dentry_name()
Message-ID: <20250117230913.GS1977892@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

[in viro/vfs.git#fixes, going to Linus unless anyone objects]

strcpy() should not be used with destination potentially overlapping
the source; what's more, strscpy() in there is pointless - we already
know the amount we want to copy; might as well use memcpy().

Fixes: c278e81b8a02 "hostfs: Remove open coded strcpy()"
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
index 7e51d2cec64b..bd6503b73142 100644
--- a/fs/hostfs/hostfs_kern.c
+++ b/fs/hostfs/hostfs_kern.c
@@ -95,32 +95,17 @@ __uml_setup("hostfs=", hostfs_args,
 static char *__dentry_name(struct dentry *dentry, char *name)
 {
 	char *p = dentry_path_raw(dentry, name, PATH_MAX);
-	char *root;
-	size_t len;
-	struct hostfs_fs_info *fsi;
-
-	fsi = dentry->d_sb->s_fs_info;
-	root = fsi->host_root_path;
-	len = strlen(root);
-	if (IS_ERR(p)) {
-		__putname(name);
-		return NULL;
-	}
-
-	/*
-	 * This function relies on the fact that dentry_path_raw() will place
-	 * the path name at the end of the provided buffer.
-	 */
-	BUG_ON(p + strlen(p) + 1 != name + PATH_MAX);
+	struct hostfs_fs_info *fsi = dentry->d_sb->s_fs_info;
+	char *root = fsi->host_root_path;
+	size_t len = strlen(root);
 
-	strscpy(name, root, PATH_MAX);
-	if (len > p - name) {
+	if (IS_ERR(p) || len > p - name) {
 		__putname(name);
 		return NULL;
 	}
 
-	if (p > name + len)
-		strcpy(name + len, p);
+	memcpy(name, root, len);
+	memmove(name + len, p, name + PATH_MAX - p);
 
 	return name;
 }

