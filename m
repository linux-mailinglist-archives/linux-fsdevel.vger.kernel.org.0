Return-Path: <linux-fsdevel+bounces-66656-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BB379C27963
	for <lists+linux-fsdevel@lfdr.de>; Sat, 01 Nov 2025 09:09:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 42C2E34AFEE
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Nov 2025 08:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD743266B67;
	Sat,  1 Nov 2025 08:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CjvLiTQH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5B12749C5
	for <linux-fsdevel@vger.kernel.org>; Sat,  1 Nov 2025 08:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761984573; cv=none; b=SbWm619z1iiYPukWwYDnBkOI+b+qPsFfTbbyF7PZ6XdBmLDhLvVr9/N7DDOvADT9E0jYa+JCOxx3kfWzmN7o3y5UcsMjM/vsk4pvsYvdYA7mMyO7JbiTudBmNZ8+qvKYhvPQ4Yiah0YwmVvJXZAitFRAXB2xEk4TplyvHFiD/yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761984573; c=relaxed/simple;
	bh=3HkqoZq5wWcmDF/NW35pr75y3puz+wVxzx1w0QysgnE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uzaoh4+kWGZPOlbaLoLBsDp1xyYmMHW22DkXgPZ27Q7X2nHYXDIxM1x6ucDoyJGjNvA/WPZFmRKPyzq0SzVBrvTLBLKdROTKJ4QBC9dOXW4mb5IUc2cWjH1US3dMYi5NHk+P9hYYJuQBkVQjbHKYFQcxm4PbVC+gUhf+GZ+aazg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CjvLiTQH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761984570;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n9TkwWMerIfAPlqtEmjyx4a2XotKEvNKj4eJMZM5Ggs=;
	b=CjvLiTQH/w5ibZooERcuuq5q9u9ncLuQc+o9ZmwKLyiYsk+QgDxCe9wP+zMjrgXo3/4aqT
	uMsDHJnFi6uyFB0bc+mub/nujWxmmeSmRnA6jx/T30Z6RfoEA7GBNZX1UEz+WOvuJoJQEG
	55cwUM09d2bzgA5cZr9X2lLUzNP0Wr4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-100-A2TNDa8kP8up2GQ3euccBg-1; Sat,
 01 Nov 2025 04:09:27 -0400
X-MC-Unique: A2TNDa8kP8up2GQ3euccBg-1
X-Mimecast-MFC-AGG-ID: A2TNDa8kP8up2GQ3euccBg_1761984566
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 902A51956080;
	Sat,  1 Nov 2025 08:09:26 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.12])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2964319560A2;
	Sat,  1 Nov 2025 08:09:24 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev,
	Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org,
	Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 2/5] gfs2: Get rid of had_lock in gfs2_drevalidate
Date: Sat,  1 Nov 2025 08:09:16 +0000
Message-ID: <20251101080919.1290117-3-agruenba@redhat.com>
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

Get rid of variable had_lock in gfs2_drevalidate().

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/dentry.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/gfs2/dentry.c b/fs/gfs2/dentry.c
index fc2be386d3f0..ca470d4c4f9e 100644
--- a/fs/gfs2/dentry.c
+++ b/fs/gfs2/dentry.c
@@ -40,11 +40,11 @@ static int gfs2_drevalidate(struct inode *dir, const struct qstr *name,
 	struct gfs2_holder d_gh;
 	struct gfs2_inode *ip = NULL;
 	int error, valid;
-	int had_lock = 0;
 
 	if (flags & LOOKUP_RCU)
 		return -ECHILD;
 
+	gfs2_holder_mark_uninitialized(&d_gh);
 	inode = d_inode(dentry);
 
 	if (inode) {
@@ -53,8 +53,7 @@ static int gfs2_drevalidate(struct inode *dir, const struct qstr *name,
 		ip = GFS2_I(inode);
 	}
 
-	had_lock = (gfs2_glock_is_locked_by_me(dip->i_gl) != NULL);
-	if (!had_lock) {
+	if (gfs2_glock_is_locked_by_me(dip->i_gl) == NULL) {
 		error = gfs2_glock_nq_init(dip->i_gl, LM_ST_SHARED, 0, &d_gh);
 		if (error)
 			return 0;
@@ -62,9 +61,9 @@ static int gfs2_drevalidate(struct inode *dir, const struct qstr *name,
 
 	error = gfs2_dir_check(dir, name, ip);
 	valid = inode ? !error : (error == -ENOENT);
-
-	if (!had_lock)
+	if (gfs2_holder_initialized(&d_gh))
 		gfs2_glock_dq_uninit(&d_gh);
+
 	return valid;
 }
 
-- 
2.51.0


