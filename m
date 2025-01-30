Return-Path: <linux-fsdevel+bounces-40384-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02E2AA22E44
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 14:56:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60EB13A4A7C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 13:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB0E41E7C2B;
	Thu, 30 Jan 2025 13:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hl2Of48+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAFE51E570B
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jan 2025 13:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738245399; cv=none; b=O6ZG81quVqVxzRK2o650hw2rUXylhup8h/RLmRpqZR8fnbp/zx2dgHTX9LU8n7djIAB4dMFL4nfLf7PZG7XBem/+dRnQT3pcCMFufpVjM5tY9LWi3fyqoxosJNMyshlePuZv1FNJ3nMWTKG8FQi6ZALXF5NSSdm+m08j6hM97t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738245399; c=relaxed/simple;
	bh=Wdhw6HF5Bf3A4ULzn7f0dRfkzsIPYePU+Jv+Smh2hPc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lsRI/D04Z1VpO8L2I5csmmTWx1vrA0/rkmXlF8WphE8Z81glymK0J0sOE6KsXO7Bb5N8jmCm1S1paBBLo87xOsJAFZoPkvOpmVPodbL7lhKjdRfQw2ffqy99jRQrhos8cE80gcx/ySWZqagp8XEEXsMoSUt5mJcSmCw4IvppEno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hl2Of48+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738245396;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zaWpCIPtJKfHymuKA+2Adh2EfAKZBxo7H0gIJyy6Tns=;
	b=hl2Of48+0JiFTludtPquqgxdtTf8frVT9VI5yOhu/oUmoeGcvcS2nOmRwNuJ5TRatKsbtA
	WWFjDXIYUjymZKZ30PWOMSIwKQ7uWfPdopjTMGrq6ZFMiWKckz2Oyo4rjn4w3euJnDdkrO
	g+l8lSkidwTeERQdX76YbO3PDUhcvqY=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-479-ko39CwQlOPC4tcd7Ov7L6g-1; Thu,
 30 Jan 2025 08:56:32 -0500
X-MC-Unique: ko39CwQlOPC4tcd7Ov7L6g-1
X-Mimecast-MFC-AGG-ID: ko39CwQlOPC4tcd7Ov7L6g
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 036031955F2D;
	Thu, 30 Jan 2025 13:56:31 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.234])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8C4FB1800268;
	Thu, 30 Jan 2025 13:56:28 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Andreas Gruenbacher <agruenba@redhat.com>,
	Christoph Hellwig <hch@lst.de>,
	gfs2@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] gfs2: use lockref_init for gl_lockref
Date: Thu, 30 Jan 2025 14:56:21 +0100
Message-ID: <20250130135624.1899988-2-agruenba@redhat.com>
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

Move the initialization of gl_lockref from gfs2_init_glock_once() to
gfs2_glock_get().  This allows to use lockref_init() there.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/glock.c | 2 +-
 fs/gfs2/main.c  | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index 8c4c1f871a88..b29eb71e3e29 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -1201,8 +1201,8 @@ int gfs2_glock_get(struct gfs2_sbd *sdp, u64 number,
 	if (glops->go_instantiate)
 		gl->gl_flags |= BIT(GLF_INSTANTIATE_NEEDED);
 	gl->gl_name = name;
+	lockref_init(&gl->gl_lockref, 1);
 	lockdep_set_subclass(&gl->gl_lockref.lock, glops->go_subclass);
-	gl->gl_lockref.count = 1;
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
-- 
2.48.1


