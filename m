Return-Path: <linux-fsdevel+bounces-66660-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B858BC2796F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 01 Nov 2025 09:09:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6C41834B0D6
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Nov 2025 08:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F8728000A;
	Sat,  1 Nov 2025 08:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="guNWYZsV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C6C27A103
	for <linux-fsdevel@vger.kernel.org>; Sat,  1 Nov 2025 08:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761984579; cv=none; b=qk44ciIa12GjVraZv79je48NaZDXLYu+T6cQchNA7PKyHbsAjN7jijRBfsT02fmRdogGfmER55QZ1LlvnIkrkdfcfaqxik+fz3z8SLItq9hQbJAM9AdwEi48nqHX6DatU3VbBX7hXAfQgPnsOY0KbcKe6P1l6tfVkBpcx0PyXI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761984579; c=relaxed/simple;
	bh=IsUmjEQiLT094vw98vIiWk6vpZHwDgE2dSeSvVcpPhE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EN57oLg1oWWxtx6UTiZCMyTNdrQxpE8S8MSmW/iuM7X8h/tXbOeGPI5RZ1XXBD7ZIoz28OAotnBXv+7Dhwq/1MdjmDm9wzo27ZbOScNLQrNuIb0rmwL8xHL9IAuKC3j7DgYi1HuCcfVkzzl5if9sDjPFQoNG+65RSa0o7k6NeMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=guNWYZsV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761984576;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vY3Jv3j39Sh4GNcYHsvQL9hDYFMUzlGms1YOIshtZ5o=;
	b=guNWYZsVkLJy4EB5PBnNpXFyK+KXSTV4FplPugr6j48mDRdIDLoLzkQyV303ME0Eu496gt
	Hzg3jznAZSicsZG3nxcu6MlulZqi8zcs8XMEg/jCNAppv+TK6Hi/Q+9TDRtlXFEOY6AEmE
	8DlzqMDXDqUbnkeR7J6vyXv/ksT9NqA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-632-hf9xD_75PhWx9RGwb8u_vw-1; Sat,
 01 Nov 2025 04:09:34 -0400
X-MC-Unique: hf9xD_75PhWx9RGwb8u_vw-1
X-Mimecast-MFC-AGG-ID: hf9xD_75PhWx9RGwb8u_vw_1761984574
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EAE9E1956080;
	Sat,  1 Nov 2025 08:09:33 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.12])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8404D19560A2;
	Sat,  1 Nov 2025 08:09:32 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev,
	Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org,
	Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 5/5] Revert "gfs2: Add GL_NOBLOCK flag"
Date: Sat,  1 Nov 2025 08:09:19 +0000
Message-ID: <20251101080919.1290117-6-agruenba@redhat.com>
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

This reverts commit f9f229c1f75df2f1fe63b16615d184da4e90bb10.

It turns out that for non-blocking lookup, taking glocks without
blocking isn't actually needed, so remove that feature again.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/glock.c | 39 +--------------------------------------
 fs/gfs2/glock.h |  1 -
 2 files changed, 1 insertion(+), 39 deletions(-)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index bc6f236b899c..e6f436241637 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -501,23 +501,6 @@ static inline struct gfs2_holder *find_first_waiter(const struct gfs2_glock *gl)
 	return NULL;
 }
 
-/**
- * find_last_waiter - find the last gh that's waiting for the glock
- * @gl: the glock
- *
- * This also is a fast way of finding out if there are any waiters.
- */
-
-static inline struct gfs2_holder *find_last_waiter(const struct gfs2_glock *gl)
-{
-	struct gfs2_holder *gh;
-
-	if (list_empty(&gl->gl_holders))
-		return NULL;
-	gh = list_last_entry(&gl->gl_holders, struct gfs2_holder, gh_list);
-	return test_bit(HIF_HOLDER, &gh->gh_iflags) ? NULL : gh;
-}
-
 /**
  * state_change - record that the glock is now in a different state
  * @gl: the glock
@@ -1462,30 +1445,11 @@ int gfs2_glock_nq(struct gfs2_holder *gh)
 {
 	struct gfs2_glock *gl = gh->gh_gl;
 	struct gfs2_sbd *sdp = gl->gl_name.ln_sbd;
-	int error;
+	int error = 0;
 
 	if (gfs2_withdrawn(sdp))
 		return -EIO;
 
-	if (gh->gh_flags & GL_NOBLOCK) {
-		struct gfs2_holder *current_gh;
-
-		error = -ECHILD;
-		spin_lock(&gl->gl_lockref.lock);
-		if (find_last_waiter(gl))
-			goto unlock;
-		current_gh = find_first_holder(gl);
-		if (!may_grant(gl, current_gh, gh))
-			goto unlock;
-		set_bit(HIF_HOLDER, &gh->gh_iflags);
-		list_add_tail(&gh->gh_list, &gl->gl_holders);
-		trace_gfs2_promote(gh);
-		error = 0;
-unlock:
-		spin_unlock(&gl->gl_lockref.lock);
-		return error;
-	}
-
 	gh->gh_error = 0;
 	spin_lock(&gl->gl_lockref.lock);
 	add_to_queue(gh);
@@ -1498,7 +1462,6 @@ int gfs2_glock_nq(struct gfs2_holder *gh)
 	run_queue(gl, 1);
 	spin_unlock(&gl->gl_lockref.lock);
 
-	error = 0;
 	if (!(gh->gh_flags & GL_ASYNC))
 		error = gfs2_glock_wait(gh);
 
diff --git a/fs/gfs2/glock.h b/fs/gfs2/glock.h
index 55d5985f32a0..885a749209f8 100644
--- a/fs/gfs2/glock.h
+++ b/fs/gfs2/glock.h
@@ -88,7 +88,6 @@ enum {
 #define GL_SKIP			0x0100
 #define GL_NOPID		0x0200
 #define GL_NOCACHE		0x0400
-#define GL_NOBLOCK		0x0800
   
 /*
  * lm_async_cb return flags
-- 
2.51.0


