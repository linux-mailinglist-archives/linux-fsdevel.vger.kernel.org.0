Return-Path: <linux-fsdevel+bounces-40385-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC27FA22E46
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 14:56:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A91E168886
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 13:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 996451E9907;
	Thu, 30 Jan 2025 13:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XJqbrIlR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E5F1E573F
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jan 2025 13:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738245401; cv=none; b=bDOX3gtQLWS8atN1uZLF1Zbf7MPdk6bVP/UCqKBImwnnCUyJMnMraRPCT2WbKntL2kqvne/GdiuDLA/zAnmdHiRMBIsKbkS41nbRXB4bJsP60ERqq8Pn3VZvlC+bMzPVCrfOWolcMX8Gzj7F7i8bVJ1uUVq3M9oF0AbrqdrKT9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738245401; c=relaxed/simple;
	bh=g0d1WeXvq6Xn8ifYHVuYao7Y1sjKWiBoiqlf7KqX2RY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=msRxUU942k1SFYxdVusDc3nFOSsz0ETGj+2Gbl7hsyykrDka0fIi1Ef27PIfjZ8gvb6ImW/o0wHr0l3RCYmYnwyfqwIgZuuiPz882vd5ZPccBLgATqgsEGU2yIF2nBS0ow7QSht78zv580mKY6brRdKz0G4feM9gw5UpznGF/V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XJqbrIlR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738245398;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pW7fdJ0dDdWhu8G/+S1u5Fbt6vZEjXQe74WQ+27cozU=;
	b=XJqbrIlR3TPIx5+mWXNNratUyFqFKeANhQ5Qm4trqnF1XEXXiRlDaoavmz8Lczz7OlJ3aT
	t+3NjL1tFoK4KPml+lJl0Seo1d0LzkfXyPVHsj9DQHbiIrA+E2v8L9emRL0st+ViYHl44B
	bkcwYS8dTkkQ175NJxMUiAuIRBxTsqo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-88-86FrBdMHNrC3xcIxhASqEA-1; Thu,
 30 Jan 2025 08:56:35 -0500
X-MC-Unique: 86FrBdMHNrC3xcIxhASqEA-1
X-Mimecast-MFC-AGG-ID: 86FrBdMHNrC3xcIxhASqEA
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B2BCA1801330;
	Thu, 30 Jan 2025 13:56:33 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.234])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7D59C1800268;
	Thu, 30 Jan 2025 13:56:31 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Andreas Gruenbacher <agruenba@redhat.com>,
	Christoph Hellwig <hch@lst.de>,
	gfs2@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] gfs2: switch to lockref_init(..., 1)
Date: Thu, 30 Jan 2025 14:56:22 +0100
Message-ID: <20250130135624.1899988-3-agruenba@redhat.com>
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

In qd_alloc(), initialize the lockref count to 1 to cover the common
case.  Compensate for that in gfs2_quota_init() by adjusting the count
back down to 0; this only occurs when mounting the filesystem rw.

Reviewed-by: Christoph Hellwig <hch@lst.de>
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


