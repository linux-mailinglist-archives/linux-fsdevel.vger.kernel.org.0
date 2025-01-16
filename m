Return-Path: <linux-fsdevel+bounces-39376-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94534A1328A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 06:26:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7060167E10
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 05:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCE02157E99;
	Thu, 16 Jan 2025 05:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="oOiRKK6m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44678156F44;
	Thu, 16 Jan 2025 05:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737005005; cv=none; b=sfvZ8TURABscVANK4Q9Wz/d+gcR6+MZwYWJpLdrwHZn2oIl3YBUbiTE38zvaHEJB5xdWu4dhHeXfrpG74VSTGPs/mc4SvXSwYGjJvSawcexc6Lm2Ikeqw5QuekVjHh5IdrLjQbAnSUIBg2dKRDlRO6c8qDG25cOCmniZsa2D5cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737005005; c=relaxed/simple;
	bh=mN1ARoq1f4Pv7f5uyEDrCvAERdU1StwB/DhX8MRYBk0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TMYUzKsOtixozGqf+W0YASTmzQY551fgUhDReMw5MZ8SJ0n74Xrex4VknXCPxZEqKA+ytqhvYChBvklnRfUgMdLZaz9KdVmSFpnK3FjQNpcrle2mUwA4W0vC8SM6fuhKxbi4KFv7cT+ujaMICyN3wK/po34W+EjueRFIlKd6T/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=oOiRKK6m; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=W81aLSHvlHqtZpPumgCnbPpxKkahRlDX4GLKT51Q/AA=; b=oOiRKK6mdfQgWFnQxPbLB0L3/H
	8P87+KmZZCEnX/SkPIk7DrPC7cz9csu8Bq3xKKU/RhVvCdfRWqCtcc6rJUz2zbWX0NUrJE21q6rkR
	cV3B/yJlHZHJPkbG7UbQQl86Z/VgwTPJ7XPjKS+e54UQkYd7nAhxEq+5EU4+xjGLTuo4CCwO6P1d8
	IgV0pygOGQKDXynmCg4CCqwYlnNAtI+qZuKxhp4Bkymf1FwqsGdCZDQs1p5xumtwnR18py7ilDRQv
	yhW7vXsio7tllfA39yxBDRXAK/XXmU87RP4ugc9aOGxYMAZfaDNr9zkbT4PaGw8o45eIcvKBhIa2U
	xXbXY2Bg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tYILf-000000022I9-2YhE;
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
Subject: [PATCH v2 15/20] gfs2_drevalidate(): use stable parent inode and name passed by caller
Date: Thu, 16 Jan 2025 05:23:12 +0000
Message-ID: <20250116052317.485356-15-viro@zeniv.linux.org.uk>
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

No need to mess with dget_parent() for the former; for the latter we really should
not rely upon ->d_name.name remaining stable.  Theoretically a UAF, but it's
hard to exfiltrate the information...

Reviewed-by: Andreas Gruenbacher <agruenba@redhat.com>
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


