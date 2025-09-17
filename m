Return-Path: <linux-fsdevel+bounces-62042-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E85E0B82492
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 01:28:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39D817AD9C1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 23:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D6283128B1;
	Wed, 17 Sep 2025 23:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="pocXeTWn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E35312803;
	Wed, 17 Sep 2025 23:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758151662; cv=none; b=n09WDZD3IyZCd8vjTs1WJJDpE+n+J/ccsn1zmDZD0BrS01CIeboafkF3QFLnzsVdgYtlt8QBXu+L+iFw87+ZRajW5RNokyQPCbUl8drwI8Vk0f46GRYnT25bnsTjG5GnIMBcDl80lyNvr5WldIAnrQt8X3sLB4VCUNPtMVgI4/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758151662; c=relaxed/simple;
	bh=OzaokaQr7jn1+gZvxIaCEFUYQYNRsFtBjipihfegmj8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MgRIGkneXTRm8E2xyRddlVkYqCnXl9/hSmEXZGrFNJKSfQEtvY6oHlyhjK3gyt+3bIh1z/tY+eGmjoxDhHRk9XA7nOVwRExJoj+DFjiuLJ6ehpn/D2VbQrgi2NplIQTNFzkfEXqoGsNd1Tau6s3/gHdAOGhxWneN+G4NktqLLsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=pocXeTWn; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=jPwu/KdpP5eXWXrzKuO6ODI0oWhZFngZTtwhZ1mY9o0=; b=pocXeTWnBh64qcJ+aC1vwXhowB
	Tsg1ktmHLha7/pwU/u/o6R/fjMzSSeqcCJWqfqKNaMdHFVp5rvnex6LpmuZmJuZ7hRZonrVdN1309
	rR32ubQDUh38LoMYneQ3YqOI8d/nzVvio70UW3qSoOlp1XVUu7+G77fmlA3Ioa68eGj94mfA0VXe8
	AT5Q5hZRXVzEPy5Y+3bu5stwfy8hNJxsHu6w6q6tE5LqAr02UtZo3jap0QSVVn6yY78Kj5mUeC2tL
	e40D3YX6/R1FD9AUvWrfv77prkpadGB/2ckQubzQVFSzjCA6FsTtZgdu9qBhyivr1tg5EOaL7bqwr
	qhnaWlTQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uz1Yn-0000000Aj6F-2Zqj;
	Wed, 17 Sep 2025 23:27:37 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: v9fs@lists.linux.dev,
	miklos@szeredi.hu,
	agruenba@redhat.com,
	linux-nfs@vger.kernel.org,
	hansg@kernel.org,
	linux-cifs@vger.kernel.org
Subject: [PATCH 6/9] simplify nfs_atomic_open_v23()
Date: Thu, 18 Sep 2025 00:27:33 +0100
Message-ID: <20250917232736.2556586-6-viro@zeniv.linux.org.uk>
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

1) finish_no_open() takes ERR_PTR() as dentry now.
2) caller of ->atomic_open() will call d_lookup_done() itself, no
need to do it here.

Reviewed-by: NeilBrown <neil@brown.name>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/nfs/dir.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index d81217923936..c8dd1d0b8d85 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -2260,7 +2260,7 @@ int nfs_atomic_open_v23(struct inode *dir, struct dentry *dentry,
 			struct file *file, unsigned int open_flags,
 			umode_t mode)
 {
-
+	struct dentry *res = NULL;
 	/* Same as look+open from lookup_open(), but with different O_TRUNC
 	 * handling.
 	 */
@@ -2275,21 +2275,15 @@ int nfs_atomic_open_v23(struct inode *dir, struct dentry *dentry,
 		if (error)
 			return error;
 		return finish_open(file, dentry, NULL);
-	} else if (d_in_lookup(dentry)) {
+	}
+	if (d_in_lookup(dentry)) {
 		/* The only flags nfs_lookup considers are
 		 * LOOKUP_EXCL and LOOKUP_RENAME_TARGET, and
 		 * we want those to be zero so the lookup isn't skipped.
 		 */
-		struct dentry *res = nfs_lookup(dir, dentry, 0);
-
-		d_lookup_done(dentry);
-		if (unlikely(res)) {
-			if (IS_ERR(res))
-				return PTR_ERR(res);
-			return finish_no_open(file, res);
-		}
+		res = nfs_lookup(dir, dentry, 0);
 	}
-	return finish_no_open(file, NULL);
+	return finish_no_open(file, res);
 
 }
 EXPORT_SYMBOL_GPL(nfs_atomic_open_v23);
-- 
2.47.3


