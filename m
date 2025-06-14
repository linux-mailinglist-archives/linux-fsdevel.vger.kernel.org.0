Return-Path: <linux-fsdevel+bounces-51660-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC774AD9A5B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Jun 2025 08:23:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1E5417E6BD
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Jun 2025 06:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E0E1E00A0;
	Sat, 14 Jun 2025 06:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="j6r7dwwt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ACC978F2B;
	Sat, 14 Jun 2025 06:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749882180; cv=none; b=Q6VRBpGBwLRrUvD3kG0jFYkm+hcX7eX/HwCAHiEIxwENMD7Ng2zi1CpkGaJq7agKdnI6FtjaD6GfT05Q3fm8duDRZPxe8mPIgDWCcTtBgX+//E2eFRDOhj3aH0qajgKJBjuxlIyt+9tH7V0wmfRaiophf7ZDqZUbLxq6RSxDTiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749882180; c=relaxed/simple;
	bh=TlqCu8ZALoTMv7iWjN2/IMRy6xM7GvGO7H+Bge2KpL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CdTHeoQt6o/037eK+3YDlWpmQBHGZ0LOKLA5SxYDcGoCkzFGBgPctI35yBYFmzg1QUpY5vjfyv4qf+CvbIvGcvD97ipsry2vH6pZGjMUT1afTopmYSDSoxahM4/4+0kYCkrwGbx1zU6CHq1OTU/mxIuH3IUoQUGLhs0Ocgh2i68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=j6r7dwwt; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=MAqQZxaNhoGE5HadZ98DDShwilRD6aaG5fQfUxqb9Co=; b=j6r7dwwt4NLoxcq6e3bfp+iDZj
	TIVXFTCt5vorBSBi3zxTNhuVpo6oxBcRRZiKSPcfRLNnOLBaYFHjEzz+w8rLph01L29rfjw6If4xY
	vUGjkbmsHxoLIFWPUnVq5atyW0+tUV4YIAWqUotsav+4Sl8a4gmdWNBjAdGia8G6NNNovtzEJ2j6q
	3NvRosD48XlXiVIvHRHPhWviJi3iqgTEeRdXDylhjjSrLCRxmWbZdo8/n4qNpxz0v3xiVHD/pK8gG
	1fQfh79yG4e5LrTArgmXHNbjbRPRP9yb4yc+UJ34hhKM4++e71NQlQCbw++fRzDgv3zNJuFngsxZq
	3hwqGRaw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uQKI5-00000002FKn-0v1t;
	Sat, 14 Jun 2025 06:22:57 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Slava.Dubeyko@ibm.com,
	ceph-devel@vger.kernel.org
Subject: [PATCH 1/3] [ceph] parse_longname(): strrchr() expects NUL-terminated string
Date: Sat, 14 Jun 2025 07:22:55 +0100
Message-ID: <20250614062257.535594-1-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250614062051.GC1880847@ZenIV>
References: <20250614062051.GC1880847@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

... and parse_longname() is not guaranteed that.  That's the reason
why it uses kmemdup_nul() to build the argument for kstrtou64();
the problem is, kstrtou64() is not the only thing that need it.

Just get a NUL-terminated copy of the entire thing and be done
with that...

Fixes: dd66df0053ef "ceph: add support for encrypted snapshot names"
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/ceph/crypto.c | 31 ++++++++++++-------------------
 1 file changed, 12 insertions(+), 19 deletions(-)

diff --git a/fs/ceph/crypto.c b/fs/ceph/crypto.c
index 3b3c4d8d401e..9c7062245880 100644
--- a/fs/ceph/crypto.c
+++ b/fs/ceph/crypto.c
@@ -215,35 +215,31 @@ static struct inode *parse_longname(const struct inode *parent,
 	struct ceph_client *cl = ceph_inode_to_client(parent);
 	struct inode *dir = NULL;
 	struct ceph_vino vino = { .snap = CEPH_NOSNAP };
-	char *inode_number;
-	char *name_end;
-	int orig_len = *name_len;
+	char *name_end, *inode_number;
 	int ret = -EIO;
-
+	/* NUL-terminate */
+	char *str __free(kfree) = kmemdup_nul(name, *name_len, GFP_KERNEL);
+	if (!str)
+		return ERR_PTR(-ENOMEM);
 	/* Skip initial '_' */
-	name++;
-	name_end = strrchr(name, '_');
+	str++;
+	name_end = strrchr(str, '_');
 	if (!name_end) {
-		doutc(cl, "failed to parse long snapshot name: %s\n", name);
+		doutc(cl, "failed to parse long snapshot name: %s\n", str);
 		return ERR_PTR(-EIO);
 	}
-	*name_len = (name_end - name);
+	*name_len = (name_end - str);
 	if (*name_len <= 0) {
 		pr_err_client(cl, "failed to parse long snapshot name\n");
 		return ERR_PTR(-EIO);
 	}
 
 	/* Get the inode number */
-	inode_number = kmemdup_nul(name_end + 1,
-				   orig_len - *name_len - 2,
-				   GFP_KERNEL);
-	if (!inode_number)
-		return ERR_PTR(-ENOMEM);
+	inode_number = name_end + 1;
 	ret = kstrtou64(inode_number, 10, &vino.ino);
 	if (ret) {
-		doutc(cl, "failed to parse inode number: %s\n", name);
-		dir = ERR_PTR(ret);
-		goto out;
+		doutc(cl, "failed to parse inode number: %s\n", str);
+		return ERR_PTR(ret);
 	}
 
 	/* And finally the inode */
@@ -254,9 +250,6 @@ static struct inode *parse_longname(const struct inode *parent,
 		if (IS_ERR(dir))
 			doutc(cl, "can't find inode %s (%s)\n", inode_number, name);
 	}
-
-out:
-	kfree(inode_number);
 	return dir;
 }
 
-- 
2.39.5


