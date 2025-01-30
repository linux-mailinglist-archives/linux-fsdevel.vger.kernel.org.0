Return-Path: <linux-fsdevel+bounces-40386-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D756CA22E49
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 14:57:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A7F53A98F1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 13:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1B8E1E5732;
	Thu, 30 Jan 2025 13:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F5kuYCv/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A2E1E9B02
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jan 2025 13:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738245404; cv=none; b=CpI0NNgsFhuVTHJbkvheYQtcCe4mMRlDeyAGN4eHztCEuFnsEDf/YRK2/aVg3BK7TVzKzOkurD2DUv8OO41jsNbqSRjAhQIsIMIfbFIvRqBUDw40SjQ62hUJoIdokotGRuaOa0MK8FeBrh6D39iUnqgZfIRwglboCLlDjvnFZjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738245404; c=relaxed/simple;
	bh=ABeeGijHKMXjIrnt6RCeYxaj4h1KX0LYF/z/4aC5cww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YMqjB2DUXrZpBO9FRJgf5bqW3crZdINWqubK1aYmzPqQtEjLOJZdBO8iVmSTb6GV2NveMOYM29e8A3Hvg0SToyps1rb9Lu8wLCZj0J791Tu6JFtGuGi784PV+kWCNYRNRnt7BQzLnjkz6/azZA03YDXnarxXpewI9xDs3qQ4wxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F5kuYCv/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738245401;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=brc+2qpv6u8MpYg1/dCpf83rKYH1pTRJqq8pdAOzE2k=;
	b=F5kuYCv/z16CH21TZuKoE1ELqkZLbVjXBE0JIu85p5vd0wFpDChEgrhprZeWQfsJgmihM7
	6k0lugSkH4epIm8/I1d6KH7IV0/sKb4vr68wF/m+gYl7QZqe255m4vx+WVY7wCI1dI2RDK
	iVIvD9JdZv8JJP8p58iAbGhjYSAxxXA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-356-4rzd7El_Nniw8Fw7qr9X5g-1; Thu,
 30 Jan 2025 08:56:38 -0500
X-MC-Unique: 4rzd7El_Nniw8Fw7qr9X5g-1
X-Mimecast-MFC-AGG-ID: 4rzd7El_Nniw8Fw7qr9X5g
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ADD8419560B7;
	Thu, 30 Jan 2025 13:56:36 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.234])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 374D318008D8;
	Thu, 30 Jan 2025 13:56:33 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Andreas Gruenbacher <agruenba@redhat.com>,
	Christoph Hellwig <hch@lst.de>,
	gfs2@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] lockref: remove count argument of lockref_init
Date: Thu, 30 Jan 2025 14:56:23 +0100
Message-ID: <20250130135624.1899988-4-agruenba@redhat.com>
In-Reply-To: <20250130135624.1899988-1-agruenba@redhat.com>
References: <20250130135624.1899988-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

All users of lockref_init() now initialize the count to 1, so hardcode
that and remove the count argument.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/dcache.c             | 2 +-
 fs/erofs/zdata.c        | 2 +-
 fs/gfs2/glock.c         | 2 +-
 fs/gfs2/quota.c         | 2 +-
 include/linux/lockref.h | 7 ++++---
 5 files changed, 8 insertions(+), 7 deletions(-)

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
index c39f119659ba..676721ee878d 100644
--- a/include/linux/lockref.h
+++ b/include/linux/lockref.h
@@ -37,12 +37,13 @@ struct lockref {
 /**
  * lockref_init - Initialize a lockref
  * @lockref: pointer to lockref structure
- * @count: initial count
+ *
+ * Initializes @lockref->count to 1.
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


