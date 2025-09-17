Return-Path: <linux-fsdevel+bounces-62046-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB804B824A7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 01:28:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65B6F72075E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 23:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A56631355D;
	Wed, 17 Sep 2025 23:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="JzaocQRy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FF03128D9;
	Wed, 17 Sep 2025 23:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758151665; cv=none; b=ifFp9863f0Z7C32+cyhjVsGTxYZIPF6VnY4RVa4vFTP3YvY5SjJ8ep9+Ku4kW+SaQ5Eq65q0GeibnKVaYRThbO0qb6NSAshTH0z4qabQkO9jeySY7wQfmbDdMI8fmxzaQoEMVjbE+OMS7BpZLfdtSVdfwfcn1LmSIbh35QFS+Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758151665; c=relaxed/simple;
	bh=rztWMywL825HWHdOpJ63xo3Ayks7zB8clH8owFn+aIs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LU59+HXJQSZW0YsW02SiOJKkMxbFCDsWiblphqN6g85a8R+kRnFBkCmODdC9t+LIs5sHS9AJsDePgunRYxpSNJUtV63rBttF6AyADgWokyV6My4k8knXLz2HNUZIid3nrUiPP/144eE36FAp4FHsvi2dK3UgmYm94jRPNb+6Vtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=JzaocQRy; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=MoszIismAijo2NAtO2MU9hUVk7JdgRsycgGeQ/YFz/w=; b=JzaocQRyf40syLzpXV2nDPy5d5
	BhvSdUe6r9MuEy/slW7DcY5jV9tu4E0eI+vas0EVx9t7seCDQVqMRiWZ97pp/VrbUEYn/CH+sVJIC
	ZqMnIrYGyid4FHdYj/ZEbkn1XnqsaHZRYt8GwDCQeog3VqNCrrFfDrf26Elo6+HC7Z9BGmeVwXQLd
	ra3Snj0/5wtBv3xfp1zUk1HAIqVi5OucgKhgfIWDs+JpI3sGWHRSJBAHE1FCje9GKcI/UJy1cECD2
	K8/tplOz/UcxFKzxytWivq7tm08mFdfS68ar8FR4QVg+6NVeuEQ5tsZWHpRmvi6b3nr5hu1IY2fTe
	hFH6XRSg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uz1Yn-0000000Aj6N-2n1h;
	Wed, 17 Sep 2025 23:27:37 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: v9fs@lists.linux.dev,
	miklos@szeredi.hu,
	agruenba@redhat.com,
	linux-nfs@vger.kernel.org,
	hansg@kernel.org,
	linux-cifs@vger.kernel.org
Subject: [PATCH 7/9] simplify fuse_atomic_open()
Date: Thu, 18 Sep 2025 00:27:34 +0100
Message-ID: <20250917232736.2556586-7-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250917232736.2556586-1-viro@zeniv.linux.org.uk>
References: <20250917232416.GG39973@ZenIV>
 <20250917232736.2556586-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

Reviewed-by: NeilBrown <neil@brown.name>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/fuse/dir.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 2d817d7cab26..d3076bfddb89 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -739,22 +739,18 @@ static int fuse_atomic_open(struct inode *dir, struct dentry *entry,
 	int err;
 	struct mnt_idmap *idmap = file_mnt_idmap(file);
 	struct fuse_conn *fc = get_fuse_conn(dir);
-	struct dentry *res = NULL;
 
 	if (fuse_is_bad(dir))
 		return -EIO;
 
 	if (d_in_lookup(entry)) {
-		res = fuse_lookup(dir, entry, 0);
-		if (IS_ERR(res))
-			return PTR_ERR(res);
-
-		if (res)
-			entry = res;
+		struct dentry *res = fuse_lookup(dir, entry, 0);
+		if (res || d_really_is_positive(entry))
+			return finish_no_open(file, res);
 	}
 
-	if (!(flags & O_CREAT) || d_really_is_positive(entry))
-		goto no_open;
+	if (!(flags & O_CREAT))
+		return finish_no_open(file, NULL);
 
 	/* Only creates */
 	file->f_mode |= FMODE_CREATED;
@@ -768,16 +764,13 @@ static int fuse_atomic_open(struct inode *dir, struct dentry *entry,
 		goto mknod;
 	} else if (err == -EEXIST)
 		fuse_invalidate_entry(entry);
-out_dput:
-	dput(res);
 	return err;
 
 mknod:
 	err = fuse_mknod(idmap, dir, entry, mode, 0);
 	if (err)
-		goto out_dput;
-no_open:
-	return finish_no_open(file, res);
+		return err;
+	return finish_no_open(file, NULL);
 }
 
 /*
-- 
2.47.3


