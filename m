Return-Path: <linux-fsdevel+bounces-40297-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F105A21F48
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2025 15:35:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EAC41884D7E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2025 14:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43FFE1DE3DC;
	Wed, 29 Jan 2025 14:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fyrx3eZz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1071DE2B1
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jan 2025 14:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738161253; cv=none; b=dqygO+MQmKKOd4CGwCv9AcBu3ZXk8VgOXALXjffecnDd1r/HBLYP4FVwpUTBB1MLS6YlDxzFhuwekzEil8bL8mUsYspJlrHHYiU7qYKsNv2vEqtIcFExrPwwBJkTEyhwsB3MTlpF3rZHZ40jNgaDJszrYL6JycuHSxoNN3ELi8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738161253; c=relaxed/simple;
	bh=sOo6x7YbfBKA3MhGRFMvMERvL+ZEBSKAsXyXGi1LNW0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UTyEOkEin1lqC2Fy+Axgko6l2FTv+rz8nOxNvPc6zwiY58vszpW0URuqwek1JBX9vEsQICJ63R9HqTuYn3IVWoQF465RiMC+qpbbQEpHLOF/FajhPeHZG1S8yA7nuUzde/WqgHxSN4GBoYcUcJD7qEJJr8rLQCu/uzDasMDpYNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fyrx3eZz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738161251;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+jemsFWFhJUh1ajdOLy+e9zf9cxIUtzcm24Z7l2CwCo=;
	b=Fyrx3eZz1A4ui4K12A03xl5oiTXEadMlvXFfMljh/IQ04ofKaNyDfx4rXHRGj8kWTv5C2g
	AC8RQmpYeVpc7wfcLRV+y8i0ODMw1af0fSTYCY3sqfVrdkzKpoYfmuNGV6j4XwhqMEDtoR
	DXVxwX11mscnjYTfHlYHFkkEEfKOw/4=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-677-xmmuzNfrO7qt3ymHQXy5ZQ-1; Wed,
 29 Jan 2025 09:34:07 -0500
X-MC-Unique: xmmuzNfrO7qt3ymHQXy5ZQ-1
X-Mimecast-MFC-AGG-ID: xmmuzNfrO7qt3ymHQXy5ZQ
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CD0581956048;
	Wed, 29 Jan 2025 14:34:05 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.234])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A460C1800951;
	Wed, 29 Jan 2025 14:34:03 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Andreas Gruenbacher <agruenba@redhat.com>,
	Christoph Hellwig <hch@lst.de>,
	gfs2@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] lockref: remove count argument of lockref_init
Date: Wed, 29 Jan 2025 15:33:52 +0100
Message-ID: <20250129143353.1892423-4-agruenba@redhat.com>
In-Reply-To: <20250129143353.1892423-1-agruenba@redhat.com>
References: <20250129143353.1892423-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

All users of lockref_init() now initialize the count to 1, so hardcode
that and remove the count argument.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/dcache.c             | 2 +-
 fs/erofs/zdata.c        | 2 +-
 fs/gfs2/glock.c         | 2 +-
 fs/gfs2/quota.c         | 2 +-
 include/linux/lockref.h | 5 ++---
 5 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 1a01d7a6a7a9..973a66dd3adf 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1682,7 +1682,7 @@ static struct dentry *__d_alloc(struct super_block *sb, const struct qstr *name)
 	smp_store_release(&dentry->d_name.name, dname); /* ^^^ */
 
 	dentry->d_flags = 0;
-	lockref_init(&dentry->d_lockref, 1);
+	lockref_init(&dentry->d_lockref);
 	seqcount_spinlock_init(&dentry->d_seq, &dentry->d_lock);
 	dentry->d_inode = NULL;
 	dentry->d_parent = dentry;
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 254f6ad2c336..85a08230d7c2 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -747,7 +747,7 @@ static int z_erofs_register_pcluster(struct z_erofs_decompress_frontend *fe)
 	if (IS_ERR(pcl))
 		return PTR_ERR(pcl);
 
-	lockref_init(&pcl->lockref, 1); /* one ref for this request */
+	lockref_init(&pcl->lockref); /* one ref for this request */
 	pcl->algorithmformat = map->m_algorithmformat;
 	pcl->length = 0;
 	pcl->partial = true;
diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index b29eb71e3e29..65c07aa95718 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -1201,7 +1201,7 @@ int gfs2_glock_get(struct gfs2_sbd *sdp, u64 number,
 	if (glops->go_instantiate)
 		gl->gl_flags |= BIT(GLF_INSTANTIATE_NEEDED);
 	gl->gl_name = name;
-	lockref_init(&gl->gl_lockref, 1);
+	lockref_init(&gl->gl_lockref);
 	lockdep_set_subclass(&gl->gl_lockref.lock, glops->go_subclass);
 	gl->gl_state = LM_ST_UNLOCKED;
 	gl->gl_target = LM_ST_UNLOCKED;
diff --git a/fs/gfs2/quota.c b/fs/gfs2/quota.c
index 6ae529a5388b..2298e06797ac 100644
--- a/fs/gfs2/quota.c
+++ b/fs/gfs2/quota.c
@@ -236,7 +236,7 @@ static struct gfs2_quota_data *qd_alloc(unsigned hash, struct gfs2_sbd *sdp, str
 		return NULL;
 
 	qd->qd_sbd = sdp;
-	lockref_init(&qd->qd_lockref, 1);
+	lockref_init(&qd->qd_lockref);
 	qd->qd_id = qid;
 	qd->qd_slot = -1;
 	INIT_LIST_HEAD(&qd->qd_lru);
diff --git a/include/linux/lockref.h b/include/linux/lockref.h
index c39f119659ba..30c68ad1859a 100644
--- a/include/linux/lockref.h
+++ b/include/linux/lockref.h
@@ -37,12 +37,11 @@ struct lockref {
 /**
  * lockref_init - Initialize a lockref
  * @lockref: pointer to lockref structure
- * @count: initial count
  */
-static inline void lockref_init(struct lockref *lockref, unsigned int count)
+static inline void lockref_init(struct lockref *lockref)
 {
 	spin_lock_init(&lockref->lock);
-	lockref->count = count;
+	lockref->count = 1;
 }
 
 void lockref_get(struct lockref *lockref);
-- 
2.48.1


