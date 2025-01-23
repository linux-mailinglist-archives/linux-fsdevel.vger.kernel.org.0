Return-Path: <linux-fsdevel+bounces-39913-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49826A19C7A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 02:48:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 863B416C999
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 01:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC8861547DC;
	Thu, 23 Jan 2025 01:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="N6+ycBiT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C033E1EF01;
	Thu, 23 Jan 2025 01:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737596809; cv=none; b=tGOfh+DBHkVFzF54Lpah0u4Zas2LKoYWSS5Ol2Zecw6CyNGeYjvukxjbp/de/6e+d/0YAIBGJlqcw/La49861D8AWHx1+oyTauUZcDQCADf+9QoVxhDJ/ei3zdf+DdmltAONyu93UB5j1nx5FRpNVQpVq3jQbsa7HpQBE/HKwjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737596809; c=relaxed/simple;
	bh=mN1ARoq1f4Pv7f5uyEDrCvAERdU1StwB/DhX8MRYBk0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WeGCMymZUWB95VirFa0Kv82wRfLtA8zh/mkmlRAI7gaJHnbSIfAzpYG4iET/fQA85UcgU3WAYyHYNp8zWSgqPMSF1aiJ2AuOyJPnuK1VTCDZ3/PuH2xQzywCh6VO2ZcdFsT51h2LvS0nAhkYZSJ+46uUacpo9imaT40YONRwnPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=N6+ycBiT; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=W81aLSHvlHqtZpPumgCnbPpxKkahRlDX4GLKT51Q/AA=; b=N6+ycBiTyn86feONWaAcCNfhh8
	kxf1yoP4zW2r2JT0HBFIl+RnfRw9wqWyh3Lv2iNT2NBw9VMwZpnbdx34bOd7fZFGQ5PrpS9uBki20
	Eeu+g48ZAxWLU3+6AOhzRKpqRadcJmdlBhVbL1wQNCvUc7klyHCwv5ecSwDZqzo3WKVFnUCC+29La
	sxFRaNhxCwvTsDulEbabTYOPF2vQTQuMa+X1fHDVjNVHYgKUEgPMrMeS2Ezv63U4yAVz4xmkhOx0z
	yGgetYtWKLpZZiDK/aKH/lmd0pbCOIPmYrcZD+hUbNGALw5S4ZTDqnKo6MlsOWAO2frP+vamXPS2y
	L9+/OoAQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tamIv-00000008F3J-19SD;
	Thu, 23 Jan 2025 01:46:45 +0000
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
Subject: [PATCH v3 15/20] gfs2_drevalidate(): use stable parent inode and name passed by caller
Date: Thu, 23 Jan 2025 01:46:38 +0000
Message-ID: <20250123014643.1964371-15-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250123014643.1964371-1-viro@zeniv.linux.org.uk>
References: <20250123014511.GA1962481@ZenIV>
 <20250123014643.1964371-1-viro@zeniv.linux.org.uk>
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


