Return-Path: <linux-fsdevel+bounces-2554-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 345D37E6DA1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 16:41:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 263A3B2143B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 15:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1668E2231C;
	Thu,  9 Nov 2023 15:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CkFnirHl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD51A2136B
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 15:40:44 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C769A35B5
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 07:40:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699544443;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vmvyNEq0mjAiqaSKGBoHUs1cA03yuKyhB0WO0XE/N4w=;
	b=CkFnirHlyEb4K8M2tuBHQgzZbbcpXNjinpQan+0alsUDzE2nS2e6/ehdLKChsuQhTEYySc
	W2FKAL9KhkxRsUNvwA3dDIqbQIKRb1k/P0bKnpfMEa454m36fsLfADZUDgewRKhvfSSGTa
	c70jZ0FEQ3ZzNMJEN5F2FGyxP38pEcY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-220-4nh_J7PWP_WADuUUKjtDNA-1; Thu, 09 Nov 2023 10:40:32 -0500
X-MC-Unique: 4nh_J7PWP_WADuUUKjtDNA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5C04C101B049;
	Thu,  9 Nov 2023 15:40:27 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.13])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 969C62026D68;
	Thu,  9 Nov 2023 15:40:26 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Marc Dionne <marc.dionne@auristor.com>
Cc: David Howells <dhowells@redhat.com>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 11/41] afs: Don't skip server addresses for which we didn't get an RTT reading
Date: Thu,  9 Nov 2023 15:39:34 +0000
Message-ID: <20231109154004.3317227-12-dhowells@redhat.com>
In-Reply-To: <20231109154004.3317227-1-dhowells@redhat.com>
References: <20231109154004.3317227-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

In the rotation algorithms for iterating over volume location servers and
file servers, don't skip servers from which we got a valid response to a
probe (either a reply DATA packet or an ABORT) even if we didn't manage to
get an RTT reading.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
---
 fs/afs/rotate.c    | 2 +-
 fs/afs/vl_rotate.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/afs/rotate.c b/fs/afs/rotate.c
index 1c8f26a7f128..689acb0ad64b 100644
--- a/fs/afs/rotate.c
+++ b/fs/afs/rotate.c
@@ -426,7 +426,7 @@ bool afs_select_fileserver(struct afs_operation *op)
 		if (!test_bit(i, &op->untried) ||
 		    !test_bit(AFS_SERVER_FL_RESPONDING, &s->flags))
 			continue;
-		if (s->probe.rtt < rtt) {
+		if (s->probe.rtt <= rtt) {
 			op->index = i;
 			rtt = s->probe.rtt;
 		}
diff --git a/fs/afs/vl_rotate.c b/fs/afs/vl_rotate.c
index af445e7d3a12..6e29272ffa8e 100644
--- a/fs/afs/vl_rotate.c
+++ b/fs/afs/vl_rotate.c
@@ -195,7 +195,7 @@ bool afs_select_vlserver(struct afs_vl_cursor *vc)
 		if (!test_bit(i, &vc->untried) ||
 		    !test_bit(AFS_VLSERVER_FL_RESPONDING, &s->flags))
 			continue;
-		if (s->probe.rtt < rtt) {
+		if (s->probe.rtt <= rtt) {
 			vc->index = i;
 			rtt = s->probe.rtt;
 		}


