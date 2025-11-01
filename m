Return-Path: <linux-fsdevel+bounces-66658-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F35C27969
	for <lists+linux-fsdevel@lfdr.de>; Sat, 01 Nov 2025 09:09:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15BDE4029E5
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Nov 2025 08:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3532127FD4A;
	Sat,  1 Nov 2025 08:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bwNknLYi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D681427A103
	for <linux-fsdevel@vger.kernel.org>; Sat,  1 Nov 2025 08:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761984575; cv=none; b=Qr2NDiMDcQuMTDrqu8lcC1xi7c1un8uorwW8GjeqDyljjdr1AaLbEIf6PpfNkW3ry0Z+GEnvPkgfAQDX6BHMyHa1OLvtEmm7iVO1SyEPWuGihRvxNLb9k4/H7ReEmHBRGrbh0lgwXPtE4iD3qKxqB1Zf0STPlm2BVMmMe/6R4Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761984575; c=relaxed/simple;
	bh=zBAu7Y6+Vxhbs7Ps2vaUEPoFRPJeaCi1NQmfJ+3B+Sw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qeZnVjxiAl+Mi6FdiyjOS+l/AWfL1sX6A2XfGMrWHXgX6kgFD5shX5SGNawjrg57NdwUitUmBvQyN0CnDBrH9GNnoKXn1VNFHPdguSKTKMb7Ze+MBDLwIXgbDszPWbZvLXXrum0quQY9lOcaejxKwPQnK9R5trXVkv7TYHBvIyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bwNknLYi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761984571;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kdx8dWRxvEHULFwXXO9eTssRukQvbf1o5+88kOaAUoI=;
	b=bwNknLYiR33vfvEg4Q2Gl0ihqu1LfdfFDItdUE6sC3p/a/VUUmm0IeKGWpecY8M0utRWW7
	I/i8GyKbkcftK0odNvz/RExl1A24Y9GhFJC/ZEzqZLLhIU9pMHaCf6bPyNDuuOu0tgDaoj
	q73CwHoko4699fTtLhlLgNs7rid8zrI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-8-mMKJXJBPO1qhTQPo4E3BoA-1; Sat,
 01 Nov 2025 04:09:30 -0400
X-MC-Unique: mMKJXJBPO1qhTQPo4E3BoA-1
X-Mimecast-MFC-AGG-ID: mMKJXJBPO1qhTQPo4E3BoA_1761984569
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 16E8F19560B7;
	Sat,  1 Nov 2025 08:09:29 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.12])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0914B19560A2;
	Sat,  1 Nov 2025 08:09:26 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev,
	Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Miklos Szeredi <mszeredi@redhat.com>
Subject: [PATCH 3/5] gfs2: Use unique tokens for gfs2_revalidate
Date: Sat,  1 Nov 2025 08:09:17 +0000
Message-ID: <20251101080919.1290117-4-agruenba@redhat.com>
In-Reply-To: <20251101080919.1290117-1-agruenba@redhat.com>
References: <20251101080919.1290117-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

GFS2 doesn't have persistent inode versions which we could use to avoid
repeated lookups in gfs2_revalidate().  We can achieve a similar effect
by introducing "fake" inode versions that only change when an inode is
invalidated, though:

 - When a directory is instantiated in inode_go_instantiate(), we set
   dir->i_version to a unique non-zero token.

 - When a dentry is instantiated by d_instantiate() or d_splice_alias(),
   we set dentry->d_time to dir->i_version.

 - In gfs2_drevalidate(), when dir->i_version == dentry->d_time, we know
   that the dentry is still up to date.  Otherwise, once we have fully
   revalidated dentry, we update dentry->d_time to match dir->i_version
   again.

 - When a directory is invalidated in inode_go_inval(), we zero out
   dir->i_version.  The directory will be assigned a new unique token
   the next time it is instantiated, so d_instantiate() will fully
   revalidate all cached dentries.

The checks in gfs2_drevalidate() needed for this mechanism can be
carried out under LOOKUP_RCU.

The "fake" inode version remains unchanged as long as its directory
remains cached, independent of any local directory changes.  All cached
dentries will remain valid during that time.  With a "real", persistent
inode version that changes whenever the directory changes, dentries
would be revalidated whenever the directory changes, but they would
remain valid across glock invalidation / re-instantiation.

Reviewed-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/dentry.c | 49 ++++++++++++++++++++++++++++++++++--------------
 fs/gfs2/glops.c  | 15 +++++++++++++--
 fs/gfs2/incore.h |  1 +
 fs/gfs2/inode.c  |  6 ++++++
 4 files changed, 55 insertions(+), 16 deletions(-)

diff --git a/fs/gfs2/dentry.c b/fs/gfs2/dentry.c
index ca470d4c4f9e..8eac9feef22e 100644
--- a/fs/gfs2/dentry.c
+++ b/fs/gfs2/dentry.c
@@ -38,29 +38,50 @@ static int gfs2_drevalidate(struct inode *dir, const struct qstr *name,
 	struct gfs2_inode *dip = GFS2_I(dir);
 	struct inode *inode;
 	struct gfs2_holder d_gh;
-	struct gfs2_inode *ip = NULL;
+	struct gfs2_inode *ip;
 	int error, valid;
-
-	if (flags & LOOKUP_RCU)
-		return -ECHILD;
+	unsigned long ver;
 
 	gfs2_holder_mark_uninitialized(&d_gh);
-	inode = d_inode(dentry);
-
-	if (inode) {
-		if (is_bad_inode(inode))
+	if (flags & LOOKUP_RCU) {
+		inode = d_inode_rcu(dentry);
+		if (!inode)
+			return -ECHILD;
+	} else {
+		inode = d_inode(dentry);
+		if (inode && is_bad_inode(inode))
 			return 0;
-		ip = GFS2_I(inode);
-	}
 
-	if (gfs2_glock_is_locked_by_me(dip->i_gl) == NULL) {
-		error = gfs2_glock_nq_init(dip->i_gl, LM_ST_SHARED, 0, &d_gh);
-		if (error)
-			return 0;
+		if (gfs2_glock_is_locked_by_me(dip->i_gl) == NULL) {
+			error = gfs2_glock_nq_init(dip->i_gl, LM_ST_SHARED, 0,
+						   &d_gh);
+			if (error)
+				return 0;
+		}
 	}
 
+	/*
+	 * GFS2 doesn't have persistent inode versions.  Instead, when a
+	 * directory is instantiated (which implies that we are holding the
+	 * corresponding glock), we set i_version to a unique token based on
+	 * sdp->sd_unique.  Later, when the directory is invalidated, we set
+	 * i_version to 0.  The next time the directory is instantiated, a new
+	 * unique token will be assigned to i_version and all cached dentries
+	 * will be fully revalidated.
+	 */
+
+	ver = atomic64_read(&dir->i_version);
+	if (ver && READ_ONCE(dentry->d_time) == ver)
+		return 1;
+
+	if (flags & LOOKUP_RCU)
+		return -ECHILD;
+
+	ip = inode ? GFS2_I(inode) : NULL;
 	error = gfs2_dir_check(dir, name, ip);
 	valid = inode ? !error : (error == -ENOENT);
+	if (valid)
+		WRITE_ONCE(dentry->d_time, ver);
 	if (gfs2_holder_initialized(&d_gh))
 		gfs2_glock_dq_uninit(&d_gh);
 
diff --git a/fs/gfs2/glops.c b/fs/gfs2/glops.c
index 549b59157ed4..b1061dd885c2 100644
--- a/fs/gfs2/glops.c
+++ b/fs/gfs2/glops.c
@@ -358,6 +358,7 @@ static int inode_go_sync(struct gfs2_glock *gl)
 static void inode_go_inval(struct gfs2_glock *gl, int flags)
 {
 	struct gfs2_inode *ip = gfs2_glock2inode(gl);
+	struct inode *inode = &ip->i_inode;
 
 	gfs2_assert_withdraw(gl->gl_name.ln_sbd, !atomic_read(&gl->gl_ail_count));
 
@@ -378,8 +379,12 @@ static void inode_go_inval(struct gfs2_glock *gl, int flags)
 			       GFS2_LFC_INODE_GO_INVAL);
 		gl->gl_name.ln_sbd->sd_rindex_uptodate = 0;
 	}
-	if (ip && S_ISREG(ip->i_inode.i_mode))
-		truncate_inode_pages(ip->i_inode.i_mapping, 0);
+	if (ip) {
+		if (S_ISREG(ip->i_inode.i_mode))
+			truncate_inode_pages(ip->i_inode.i_mapping, 0);
+		else if (S_ISDIR(inode->i_mode))
+			atomic64_set(&inode->i_version, 0);
+	}
 
 	gfs2_clear_glop_pending(ip);
 }
@@ -498,6 +503,7 @@ static int gfs2_inode_refresh(struct gfs2_inode *ip)
 static int inode_go_instantiate(struct gfs2_glock *gl)
 {
 	struct gfs2_inode *ip = gl->gl_object;
+	struct inode *inode = &ip->i_inode;
 	struct gfs2_glock *io_gl;
 	int error;
 
@@ -509,6 +515,11 @@ static int inode_go_instantiate(struct gfs2_glock *gl)
 		return error;
 	io_gl = ip->i_iopen_gh.gh_gl;
 	io_gl->gl_no_formal_ino = ip->i_no_formal_ino;
+	if (S_ISDIR(inode->i_mode)) {
+		struct gfs2_sbd *sdp = gl->gl_name.ln_sbd;
+		atomic64_set(&inode->i_version,
+			     atomic64_inc_return(&sdp->sd_unique));
+	}
 	return 0;
 }
 
diff --git a/fs/gfs2/incore.h b/fs/gfs2/incore.h
index d05d8fe4e456..d3a1cfcc62ec 100644
--- a/fs/gfs2/incore.h
+++ b/fs/gfs2/incore.h
@@ -698,6 +698,7 @@ struct gfs2_sbd {
 
 	struct gfs2_args sd_args;	/* Mount arguments */
 	struct gfs2_tune sd_tune;	/* Filesystem tuning structure */
+	atomic64_t sd_unique;
 
 	/* Lock Stuff */
 
diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
index 8a7ed80d9f2d..3d87ecd277a1 100644
--- a/fs/gfs2/inode.c
+++ b/fs/gfs2/inode.c
@@ -731,6 +731,7 @@ static int gfs2_create_inode(struct inode *dir, struct dentry *dentry,
 			goto fail_gunlock;
 		}
 		d_instantiate(dentry, inode);
+		dentry->d_time = atomic64_read(&dir->i_version);
 		error = 0;
 		if (file) {
 			if (S_ISREG(inode->i_mode))
@@ -785,6 +786,8 @@ static int gfs2_create_inode(struct inode *dir, struct dentry *dentry,
 		gfs2_set_aops(inode);
 		break;
 	case S_IFDIR:
+		atomic64_set(&inode->i_version,
+			     atomic64_inc_return(&sdp->sd_unique));
 		ip->i_diskflags |= (dip->i_diskflags & GFS2_DIF_INHERIT_JDATA);
 		ip->i_diskflags |= GFS2_DIF_JDATA;
 		ip->i_entries = 2;
@@ -878,6 +881,7 @@ static int gfs2_create_inode(struct inode *dir, struct dentry *dentry,
 
 	mark_inode_dirty(inode);
 	d_instantiate(dentry, inode);
+	dentry->d_time = atomic64_read(&dir->i_version);
 	/* After instantiate, errors should result in evict which will destroy
 	 * both inode and iopen glocks properly. */
 	if (file) {
@@ -988,6 +992,7 @@ static struct dentry *__gfs2_lookup(struct inode *dir, struct dentry *dentry,
 	}
 
 	d = d_splice_alias(inode, dentry);
+	dentry->d_time = atomic64_read(&dir->i_version);
 	if (IS_ERR(d)) {
 		gfs2_glock_dq_uninit(&gh);
 		return d;
@@ -1119,6 +1124,7 @@ static int gfs2_link(struct dentry *old_dentry, struct inode *dir,
 	inode_set_ctime_current(&ip->i_inode);
 	ihold(inode);
 	d_instantiate(dentry, inode);
+	dentry->d_time = atomic64_read(&dir->i_version);
 	mark_inode_dirty(inode);
 
 out_brelse:
-- 
2.51.0


