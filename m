Return-Path: <linux-fsdevel+bounces-5866-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5FA8811370
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 14:50:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82B7928250C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 13:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A83F62E836;
	Wed, 13 Dec 2023 13:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GDKZcq/A"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAEFD121
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Dec 2023 05:50:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702475426;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mwRJi2sCnG34wTz+6X85LZ5bO1xW/kuUkUV8gU/er0M=;
	b=GDKZcq/Ab4e3r6Bon3L+1dcaDDxJOKrj9c3FgI9WgIFapDGFJFIBIXX/zy3pKDBHd6dyF3
	qwhzNlMSDPSeKFTxpT4acu0lvJ0leMem7o55t+G5JtHzgjYLxn/lzIoueabwFq40RtW8vx
	UFClue8rvMAcs7DxIggiiHe9ZsT8LSg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-325-cfUhRadEPFaaBvS2RUXciA-1; Wed, 13 Dec 2023 08:50:23 -0500
X-MC-Unique: cfUhRadEPFaaBvS2RUXciA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E4C068C46C2;
	Wed, 13 Dec 2023 13:50:22 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.2])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 278D72166B32;
	Wed, 13 Dec 2023 13:50:22 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Marc Dionne <marc.dionne@auristor.com>
Cc: David Howells <dhowells@redhat.com>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 10/40] afs: Don't skip server addresses for which we didn't get an RTT reading
Date: Wed, 13 Dec 2023 13:49:32 +0000
Message-ID: <20231213135003.367397-11-dhowells@redhat.com>
In-Reply-To: <20231213135003.367397-1-dhowells@redhat.com>
References: <20231213135003.367397-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

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
index 59aed7a6dd11..d420f073300b 100644
--- a/fs/afs/rotate.c
+++ b/fs/afs/rotate.c
@@ -427,7 +427,7 @@ bool afs_select_fileserver(struct afs_operation *op)
 		if (!test_bit(i, &op->untried) ||
 		    !test_bit(AFS_SERVER_FL_RESPONDING, &s->flags))
 			continue;
-		if (s->probe.rtt < rtt) {
+		if (s->probe.rtt <= rtt) {
 			op->index = i;
 			rtt = s->probe.rtt;
 		}
diff --git a/fs/afs/vl_rotate.c b/fs/afs/vl_rotate.c
index f8f255c966ae..6aaa2e4733ec 100644
--- a/fs/afs/vl_rotate.c
+++ b/fs/afs/vl_rotate.c
@@ -201,7 +201,7 @@ bool afs_select_vlserver(struct afs_vl_cursor *vc)
 		if (!test_bit(i, &vc->untried) ||
 		    !test_bit(AFS_VLSERVER_FL_RESPONDING, &s->flags))
 			continue;
-		if (s->probe.rtt < rtt) {
+		if (s->probe.rtt <= rtt) {
 			vc->index = i;
 			rtt = s->probe.rtt;
 		}


