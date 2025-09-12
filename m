Return-Path: <linux-fsdevel+bounces-61128-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DDBFB556B6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 20:59:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BA441D624EE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 18:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62100337693;
	Fri, 12 Sep 2025 18:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="rPca0gmT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666B433436A
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Sep 2025 18:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757703560; cv=none; b=sQppSZPZxfQEo8H0srWHs2AYHd1PaceLtLKFsnANOzgQDA2AsdoGBNnAlZXgzqtpSaB6hMysf/wBRaRM0BLIzl8r55gasCYDzRFE/MJGgL3gGAaeiZjCxAASyr5hoheqiEcaM/NN16EA5Oc/9KnNjlv48IAbYrfiOnLA9dR6kI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757703560; c=relaxed/simple;
	bh=moI7bc2t5jE2dSkWckMnzUIloVDTApJdDSBD9REm64A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DwEuONS17+zlgAFVfvWw70ZplAdrVFB86x5vsVQInggYEQAWcNaVxXcrA/m6vPb3ycKbWJBgPuExoleqwhlFZS+3/x2fZyU57fuCnWFnbeRNaF3x5qnZK9pdST4xHXvJw0WuTlkqXk3s4s8ToHqYXBsij2MCaVu4wE+4X/cLw0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=rPca0gmT; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=aaq5OUbZEPqOpimEzRhGzYnM4v5jaslFnWRj8ElDChQ=; b=rPca0gmTe1En4RaPiCCxUczdIF
	AiQcf6EDLgqkRmfGscGVTzS8FbjKt1oAczJsGLKgDRWN4nZHixCz9YR4obuIs4N9Q8873p6aP0eKj
	bkMDn4a5cAhgYYiRzdJGZFOZ2SXK0waKSBNvgWZemBKG2FLF3wiJNEAb5Ps1RgnxzW4lCS0mOml8/
	R2f1KpKFhHrYFtgbjfrRXvrUNcg9EffcAAMTBewxXWvfNWz+w5RBbQJ2VflWLIvSX53n48i4kD7AA
	jk3jbolRfKyypsNYWnAZpdjfDkQiJGT2umSIKmNDLe/JUn/MROuNkpYm/g13oGeT/hyIsvjVps2dR
	SNQiS3MQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ux8zN-00000001g6N-1onX;
	Fri, 12 Sep 2025 18:59:17 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: neil@brown.name
Cc: torvalds@linux-foundation.org,
	linux-fsdevel@vger.kernel.org,
	brauner@kernel.org,
	jack@suse.cz,
	miklos@szeredi.hu
Subject: [PATCH 7/9] simplify fuse_atomic_open()
Date: Fri, 12 Sep 2025 19:59:14 +0100
Message-ID: <20250912185916.400113-7-viro@zeniv.linux.org.uk>
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
2.47.2


