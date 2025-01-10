Return-Path: <linux-fsdevel+bounces-38786-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A55A08590
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 03:44:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6E40168981
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 02:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4D3A207663;
	Fri, 10 Jan 2025 02:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="m1NrTMUC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9201E2614;
	Fri, 10 Jan 2025 02:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736476988; cv=none; b=nzSCYxc0x9ZNo0vdS4We4f8rTOp6n24sZnySWBCHue+BbDBjydfWiQF7LBuqwGiyWBcM+9kvHHm+uOcnZ2uDpeg+kad4/CRnitU488rj4S8xZewme2vkZkVvIMzKc6UxEad6dTy7OkAKe9hVYSsGR64/f2Xdl2ZMAhvbzTSksK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736476988; c=relaxed/simple;
	bh=L4CuPi5jJc1MGAvCcr4lIwWYxLvWgzHZ6Xiyc9X0t6k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ghGy7wYUsJodWTsBlM4vaa7Z7y79+TNvUDxKAmjOfffvaTI8A43ZS6OncxgOYE4d7bu4cKzDTb96Orp4owTJ5nCqJkr09NC0I45q1j1oZSsPpU0cAm+rh7bAjxPC5LQ083z/mb/6Z0UqcfC8lrmdXS0ONNh885Hg22/0trRMYEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=m1NrTMUC; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=nNa75NB+AlX0KHLw/H1Is4u5y+bHPU/WREt2toMBY8E=; b=m1NrTMUCYL9gGcOMMPzANhIjch
	9TAvogLfXqb7nsOEf4kW1qBZKiPXlDIge2ds8H9PC+lUSnMtuD+dS1AO0qxUuYw4rBK0O/zRz8ZDy
	XUeAUH/+54dfV/XLl9NgKzEKsx0zV8aN2xw79VlWlHsipBZYnZKAH3I6aCOP7Xg8ZFeybGUTuRv5m
	hiKcQ5Z7pkqbJjyi8easI08Xd2c4RMouqQOuYv4t8vf2GJN0OAnpEGaMVoxUdxe94xvwTIFfi0L+P
	5TV6fQX84K5u1XbtFjQ6WlPiKzaP2ZPL5u60yxSIphaeRJJ/iYKXZ5E5S3K4CSfY7JL4JHYcZoc19
	UAXwIE/w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tW4zJ-0000000HRce-0wPF;
	Fri, 10 Jan 2025 02:43:05 +0000
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
Subject: [PATCH 15/20] gfs2_drevalidate(): use stable parent inode and name passed by caller
Date: Fri, 10 Jan 2025 02:42:58 +0000
Message-ID: <20250110024303.4157645-15-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250110024303.4157645-1-viro@zeniv.linux.org.uk>
References: <20250110023854.GS1977892@ZenIV>
 <20250110024303.4157645-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

No need to mess with dget_parent() for the former; for the latter we really should
not rely upon ->d_name.name remaining stable.  Again, a UAF there.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/gfs2/dentry.c | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/fs/gfs2/dentry.c b/fs/gfs2/dentry.c
index 86c338901fab..95050e719233 100644
--- a/fs/gfs2/dentry.c
+++ b/fs/gfs2/dentry.c
@@ -35,48 +35,40 @@
 static int gfs2_drevalidate(struct inode *dir, const struct qstr *name,
 			    struct dentry *dentry, unsigned int flags)
 {
-	struct dentry *parent;
-	struct gfs2_sbd *sdp;
-	struct gfs2_inode *dip;
+	struct gfs2_sbd *sdp = GFS2_SB(dir);
+	struct gfs2_inode *dip = GFS2_I(dir);
 	struct inode *inode;
 	struct gfs2_holder d_gh;
 	struct gfs2_inode *ip = NULL;
-	int error, valid = 0;
+	int error, valid;
 	int had_lock = 0;
 
 	if (flags & LOOKUP_RCU)
 		return -ECHILD;
 
-	parent = dget_parent(dentry);
-	sdp = GFS2_SB(d_inode(parent));
-	dip = GFS2_I(d_inode(parent));
 	inode = d_inode(dentry);
 
 	if (inode) {
 		if (is_bad_inode(inode))
-			goto out;
+			return 0;
 		ip = GFS2_I(inode);
 	}
 
-	if (sdp->sd_lockstruct.ls_ops->lm_mount == NULL) {
-		valid = 1;
-		goto out;
-	}
+	if (sdp->sd_lockstruct.ls_ops->lm_mount == NULL)
+		return 1;
 
 	had_lock = (gfs2_glock_is_locked_by_me(dip->i_gl) != NULL);
 	if (!had_lock) {
 		error = gfs2_glock_nq_init(dip->i_gl, LM_ST_SHARED, 0, &d_gh);
 		if (error)
-			goto out;
+			return 0;
 	}
 
-	error = gfs2_dir_check(d_inode(parent), &dentry->d_name, ip);
+	error = gfs2_dir_check(dir, name, ip);
 	valid = inode ? !error : (error == -ENOENT);
 
 	if (!had_lock)
 		gfs2_glock_dq_uninit(&d_gh);
-out:
-	dput(parent);
 	return valid;
 }
 
-- 
2.39.5


