Return-Path: <linux-fsdevel+bounces-5695-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B3680EF2F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 15:46:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57C031F215C6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 14:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88718745EA;
	Tue, 12 Dec 2023 14:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ds/NpD9c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 915001BD7
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Dec 2023 06:46:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702392382;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8Hgc4VpHrij9wpXpDIXTA7F+eZGvk3a4sFe7hddHELc=;
	b=ds/NpD9cpzHd34xPVrltpe9l4hWJH/bCvT6indenH4Kwjm940lV7XA23WJXsGrt9cIwWkt
	Cww87uH8mY89ZxE2BhAz/rFD+CwV+Mwiuzh32dAq42C+gc7yBmU8GZOCislS1tHbjxndAu
	NeGRFbl6ZbFnVGMrAAAAT7O72qu6K6c=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-171-NdCldNcMPbqpk2HVg85BjA-1; Tue, 12 Dec 2023 09:46:17 -0500
X-MC-Unique: NdCldNcMPbqpk2HVg85BjA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2738A88F2EB;
	Tue, 12 Dec 2023 14:46:17 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.2])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2506C492BE6;
	Tue, 12 Dec 2023 14:46:16 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Markus Suvanto <markus.suvanto@gmail.com>,
	Marc Dionne <marc.dionne@auristor.com>
Cc: David Howells <dhowells@redhat.com>,
	linux-afs@lists.infradead.org,
	keyrings@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/3] afs: Fix the dynamic root's d_delete to always delete unused dentries
Date: Tue, 12 Dec 2023 14:46:09 +0000
Message-ID: <20231212144611.3100234-2-dhowells@redhat.com>
In-Reply-To: <20231212144611.3100234-1-dhowells@redhat.com>
References: <20231212144611.3100234-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

Fix the afs dynamic root's d_delete function to always delete unused
dentries rather than only deleting them if they're positive.  With things
as they stand upstream, negative dentries stemming from failed DNS lookups
stick around preventing retries.

Fixes: 66c7e1d319a5 ("afs: Split the dynroot stuff out and give it its own ops tables")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
---
 fs/afs/dynroot.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/fs/afs/dynroot.c b/fs/afs/dynroot.c
index 1fa8cf23bd36..34474a061654 100644
--- a/fs/afs/dynroot.c
+++ b/fs/afs/dynroot.c
@@ -252,20 +252,9 @@ static int afs_dynroot_d_revalidate(struct dentry *dentry, unsigned int flags)
 	return 1;
 }
 
-/*
- * Allow the VFS to enquire as to whether a dentry should be unhashed (mustn't
- * sleep)
- * - called from dput() when d_count is going to 0.
- * - return 1 to request dentry be unhashed, 0 otherwise
- */
-static int afs_dynroot_d_delete(const struct dentry *dentry)
-{
-	return d_really_is_positive(dentry);
-}
-
 const struct dentry_operations afs_dynroot_dentry_operations = {
 	.d_revalidate	= afs_dynroot_d_revalidate,
-	.d_delete	= afs_dynroot_d_delete,
+	.d_delete	= always_delete_dentry,
 	.d_release	= afs_d_release,
 	.d_automount	= afs_d_automount,
 };


