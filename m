Return-Path: <linux-fsdevel+bounces-62045-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 574FAB8249E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 01:28:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1962E2A79C2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 23:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2776313524;
	Wed, 17 Sep 2025 23:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="LjxMOfkG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE623312820;
	Wed, 17 Sep 2025 23:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758151664; cv=none; b=MhwpURDZs/bMEDcZ/mzxrwN2IpO1wl/RAyAZ1km7qxdTCZBlN0EBBgynil/37s/K0+EbXDHeHcxeSfFlnPVhJ50rInSQww3JA1K1cNUp2kCXujSgO7fWfnhbSisLaUonT97Wsuf5z/gbxzMSofiDyp9ixqlHFFz8rLKe/00Chx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758151664; c=relaxed/simple;
	bh=AHn6++T7gUH7Bdq0KaKpbDC8m3Fq/LeKAaid+fGOwoI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FleiwQv2UqEHYIE5K8XyOkq4OjNej34OozX+pOGwB8J/vtsRJWRzYrKklq3R35vn8VtlC390HJKt9jTqA7fmf/E9ZorN5b3/OPY8iB2UzRAuM1Z+dfmoUlfZmDbEyFAwSGZ5tipunq7+R32u2ChFOTakmL+iip6y81xVmZV/IA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=LjxMOfkG; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=KZf8+bE5FShbO38UGyeothmJdQWhNlYkjIkl7AC4ekI=; b=LjxMOfkGyMJzvPH/7LDg63XPz6
	+aPBX5Hx3NN8+3qfETkDt7xIpiRnfqVBh6oid1pVOb5xBKQiXQvDRXsC3IAjTBUhmxu6yKbY8B7W2
	2O/q/Wc0Ak9OdvDJP+kfCyjWqqih3OA0mZtHkLK6HEMN+c+Z/sCfRSdAgpVhPUR1pL2ih4T7vaIjq
	rCn7yBIcH65m+GS1XUeMuWLC5P4lbRBDIwJkYevCbJ8Cr8sm2wmphWqG0xTIg26QcoZ8/MmTZexGM
	/TKUCbFG171R0/LsNwbDe6LaluG5P5CeFWEr/p5wC+Bc/F/dg2JpJSSis7cONZezJRbsuKBc6OuGg
	zpnlDH0Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uz1Yn-0000000Aj5d-0ras;
	Wed, 17 Sep 2025 23:27:37 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: v9fs@lists.linux.dev,
	miklos@szeredi.hu,
	agruenba@redhat.com,
	linux-nfs@vger.kernel.org,
	hansg@kernel.org,
	linux-cifs@vger.kernel.org
Subject: [PATCH 3/9] 9p: simplify v9fs_vfs_atomic_open_dotl()
Date: Thu, 18 Sep 2025 00:27:30 +0100
Message-ID: <20250917232736.2556586-3-viro@zeniv.linux.org.uk>
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

again, preexisting aliases will always be positive

Reviewed-by: NeilBrown <neil@brown.name>
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
2.47.3


