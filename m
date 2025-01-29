Return-Path: <linux-fsdevel+bounces-40296-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FCAFA21F45
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2025 15:34:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 345A43A1D52
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2025 14:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB5841DE2A4;
	Wed, 29 Jan 2025 14:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LZnSD3Xv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129471D8A16
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jan 2025 14:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738161249; cv=none; b=hn7uyOAUoY+cCbStQf5W1+T0pBmiMRfKJpuefrRUfoXqTsAftdnrK1RatSKyEPqyeagF6FyCyNwF1g72GPNxkBx3NOIA7tBG0/DW1/x9ZQLyD/jPc4GIcCFeEigc3H5aU5ffar5UOBizyixbHds4oZStZFpN6SfjC9RgvEfD/pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738161249; c=relaxed/simple;
	bh=ygwAQBWML1tmKhXOycj3SmWBSx72h3X+STM8yQsxciw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fFWPVk4qHQQvlzyxHthZc0uyOR0pIK/qnQ5ZVAOdEe9MAyIubd6ivkKTVrgiSc0SGjiUBxDJKbFhm8s2vrJkgAi7P96cXMB0gBLJ8x8E791nII3eMtO7g/0LAqsAT+Z6jxfzdR6z8M/dtxfvD0D723qkfMoLipBbL+hK5W+UF38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LZnSD3Xv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738161246;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=74dydNQetms/bGYetTVmJaGxaCOgtJUS+5wTgNyYG0Y=;
	b=LZnSD3XvjxEWZGP+x1fOpcEkQxBARGJ68Qngy60FxfECFAj0P33IYrKPxq/B74ZDZVsylL
	Sl3Ks30MEFO5mhdkssMG9IbKMchfhkYWa2pz1EV6qx6bhayizX1LOT8fxdHLd2shd8srv3
	pKxgU4Lp2V7wVRS9BOu7Zr5RJHMxjqg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-198-kgxk55RYPnGOzbegLQNvdA-1; Wed,
 29 Jan 2025 09:34:04 -0500
X-MC-Unique: kgxk55RYPnGOzbegLQNvdA-1
X-Mimecast-MFC-AGG-ID: kgxk55RYPnGOzbegLQNvdA
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4D52E180034D;
	Wed, 29 Jan 2025 14:34:03 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.234])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F3B611800951;
	Wed, 29 Jan 2025 14:34:00 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Andreas Gruenbacher <agruenba@redhat.com>,
	Christoph Hellwig <hch@lst.de>,
	gfs2@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] gfs2: switch to lockref_init(..., 1)
Date: Wed, 29 Jan 2025 15:33:51 +0100
Message-ID: <20250129143353.1892423-3-agruenba@redhat.com>
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

In qd_alloc(), initialize the lockref count to 1 to cover the common
case.  Compensate for that in gfs2_quota_init() by adjusting the count
back down to 0; this only occurs when mounting the filesystem rw.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/quota.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/gfs2/quota.c b/fs/gfs2/quota.c
index 58bc5013ca49..6ae529a5388b 100644
--- a/fs/gfs2/quota.c
+++ b/fs/gfs2/quota.c
@@ -236,7 +236,7 @@ static struct gfs2_quota_data *qd_alloc(unsigned hash, struct gfs2_sbd *sdp, str
 		return NULL;
 
 	qd->qd_sbd = sdp;
-	lockref_init(&qd->qd_lockref, 0);
+	lockref_init(&qd->qd_lockref, 1);
 	qd->qd_id = qid;
 	qd->qd_slot = -1;
 	INIT_LIST_HEAD(&qd->qd_lru);
@@ -297,7 +297,6 @@ static int qd_get(struct gfs2_sbd *sdp, struct kqid qid,
 	spin_lock_bucket(hash);
 	*qdp = qd = gfs2_qd_search_bucket(hash, sdp, qid);
 	if (qd == NULL) {
-		new_qd->qd_lockref.count++;
 		*qdp = new_qd;
 		list_add(&new_qd->qd_list, &sdp->sd_quota_list);
 		hlist_bl_add_head_rcu(&new_qd->qd_hlist, &qd_hash_table[hash]);
@@ -1450,6 +1449,7 @@ int gfs2_quota_init(struct gfs2_sbd *sdp)
 			if (qd == NULL)
 				goto fail_brelse;
 
+			qd->qd_lockref.count = 0;
 			set_bit(QDF_CHANGE, &qd->qd_flags);
 			qd->qd_change = qc_change;
 			qd->qd_slot = slot;
-- 
2.48.1


