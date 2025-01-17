Return-Path: <linux-fsdevel+bounces-39499-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C741FA153A5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2025 17:05:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0EC4D7A464B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2025 16:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9277F19DF81;
	Fri, 17 Jan 2025 16:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dgGt/Ok2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6792815855E
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jan 2025 16:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737129847; cv=none; b=ZPf4Ng9ILsDi18eVPXxt2NKvozN452KnKAjsO43Iwop9wzauYZVkR7L/PP/Q1jLrdnlblslaviCeWfWY2mH/Xc9cWdwpcXCTHPc2WGwk/HbpjCiuu81V1bSDycj3VjXWFdmOfxMfnTocsVf540kqw8pXSBeYt9GrKaW6StuoCXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737129847; c=relaxed/simple;
	bh=4UUDGkU9Bq4tVMHfQuVdXbA4D8VDU2STKtVLjF5dgxY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aI/4MihKeZ0t8nqVbxpPpQaKpVat8eXDvL3W58nN7PnLIEVYxjL9Q8ZBbx++96zneRiar68+BXeKmMkIqzMSt0x2J8poUYYhMkObRtHe3r9Y3PCk+rtXAnV49aGCVtvNE9TliYtScO2+g3oDdt0TLNDEuBjrp2T3AXtqFf/8YUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dgGt/Ok2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737129844;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r2EtEcowqKmGPyqrfNyReJTwjmhin1zPXsa45Bk4XiA=;
	b=dgGt/Ok2xVdwe06nQdLxjaAdePv7HyWrhRtNeaKuArNOuLD74DBvCviBgC1uwnUm7D/bhD
	DEVUgXwwf06bApt+3ccjZ/59FGOVYHk6kdoAM8XKq1jyi8p7YWKpvhe5o5BArEQj835iCA
	9V59JGNis0qXRPU5r86Hu+czNy1jTqY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-302-2k6mZaraPHmhXiPqeWJe1A-1; Fri,
 17 Jan 2025 11:03:59 -0500
X-MC-Unique: 2k6mZaraPHmhXiPqeWJe1A-1
X-Mimecast-MFC-AGG-ID: 2k6mZaraPHmhXiPqeWJe1A
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B0C391955D61;
	Fri, 17 Jan 2025 16:03:57 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.39.192.60])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 887251955F10;
	Fri, 17 Jan 2025 16:03:53 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Andreas Gruenbacher <agruenba@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Gao Xiang <xiang@kernel.org>,
	Chao Yu <chao@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-erofs@lists.ozlabs.org,
	gfs2@lists.linux.dev
Subject: Re: [PATCH 8/8] gfs2: use lockref_init for qd_lockref
Date: Fri, 17 Jan 2025 17:03:51 +0100
Message-ID: <20250117160352.1881139-1-agruenba@redhat.com>
In-Reply-To: <20250116043226.GA23137@lst.de>
References: <20250116043226.GA23137@lst.de> <CAHc6FU58eBO0i8er5+gK--eAMVHULCzHPnJ9H5oN12fr=AAnbg@mail.gmail.com> <20250115094702.504610-1-hch@lst.de> <20250115094702.504610-9-hch@lst.de> <CAHc6FU58eBO0i8er5+gK--eAMVHULCzHPnJ9H5oN12fr=AAnbg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Thu, 16 Jan 2025 05:32:26 +0100, Christoph Hellwig <hch@lst.de> wrote:
> Well, if you can fix it to start with 1 we could start out with 1
> as the default.  FYI, I also didn't touch the other gfs2 lockref
> because it initialize the lock in the slab init_once callback and
> the count on every initialization.

Sure, can you add the below patch before the lockref_init conversion?

Thanks,
Andreas

--

gfs2: Prepare for converting to lockref_init

First, move initializing the glock lockref spin lock from
gfs2_init_glock_once() to gfs2_glock_get().

Second, in qd_alloc(), initialize the lockref count to 1 to cover the
common case.  Compensate for that in gfs2_quota_init() by adjusting the
count back down to 0; this case occurs only when mounting the filesystem
rw.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/glock.c | 3 ++-
 fs/gfs2/main.c  | 1 -
 fs/gfs2/quota.c | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index 8c4c1f871a88..22ff77cdd827 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -1201,8 +1201,9 @@ int gfs2_glock_get(struct gfs2_sbd *sdp, u64 number,
 	if (glops->go_instantiate)
 		gl->gl_flags |= BIT(GLF_INSTANTIATE_NEEDED);
 	gl->gl_name = name;
-	lockdep_set_subclass(&gl->gl_lockref.lock, glops->go_subclass);
 	gl->gl_lockref.count = 1;
+	spin_lock_init(&gl->gl_lockref.lock);
+	lockdep_set_subclass(&gl->gl_lockref.lock, glops->go_subclass);
 	gl->gl_state = LM_ST_UNLOCKED;
 	gl->gl_target = LM_ST_UNLOCKED;
 	gl->gl_demote_state = LM_ST_EXCLUSIVE;
diff --git a/fs/gfs2/main.c b/fs/gfs2/main.c
index 04cadc02e5a6..0727f60ad028 100644
--- a/fs/gfs2/main.c
+++ b/fs/gfs2/main.c
@@ -51,7 +51,6 @@ static void gfs2_init_glock_once(void *foo)
 {
 	struct gfs2_glock *gl = foo;
 
-	spin_lock_init(&gl->gl_lockref.lock);
 	INIT_LIST_HEAD(&gl->gl_holders);
 	INIT_LIST_HEAD(&gl->gl_lru);
 	INIT_LIST_HEAD(&gl->gl_ail_list);
diff --git a/fs/gfs2/quota.c b/fs/gfs2/quota.c
index 72b48f6f5561..df78eb8f35f9 100644
--- a/fs/gfs2/quota.c
+++ b/fs/gfs2/quota.c
@@ -236,7 +236,7 @@ static struct gfs2_quota_data *qd_alloc(unsigned hash, struct gfs2_sbd *sdp, str
 		return NULL;
 
 	qd->qd_sbd = sdp;
-	qd->qd_lockref.count = 0;
+	qd->qd_lockref.count = 1;
 	spin_lock_init(&qd->qd_lockref.lock);
 	qd->qd_id = qid;
 	qd->qd_slot = -1;
@@ -298,7 +298,6 @@ static int qd_get(struct gfs2_sbd *sdp, struct kqid qid,
 	spin_lock_bucket(hash);
 	*qdp = qd = gfs2_qd_search_bucket(hash, sdp, qid);
 	if (qd == NULL) {
-		new_qd->qd_lockref.count++;
 		*qdp = new_qd;
 		list_add(&new_qd->qd_list, &sdp->sd_quota_list);
 		hlist_bl_add_head_rcu(&new_qd->qd_hlist, &qd_hash_table[hash]);
@@ -1451,6 +1450,7 @@ int gfs2_quota_init(struct gfs2_sbd *sdp)
 			if (qd == NULL)
 				goto fail_brelse;
 
+			qd->qd_lockref.count = 0;
 			set_bit(QDF_CHANGE, &qd->qd_flags);
 			qd->qd_change = qc_change;
 			qd->qd_slot = slot;
-- 
2.47.1


