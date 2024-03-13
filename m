Return-Path: <linux-fsdevel+bounces-14269-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9BA187A3F9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 09:15:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2794B1C21843
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 08:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398D5208A2;
	Wed, 13 Mar 2024 08:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UdTlpb3v"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A8F1B967
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Mar 2024 08:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710317717; cv=none; b=mavNDZezIyMEpCr7MZtxbfXjtpJIV4K7qOKDCCESFNf1yNCuLnn//tSo/wHdl1Z1cBBfhuQAvm4a4+PlKbt3NzJ4AgnAf1RyV4eFEnjyamVlBWVilDgLJoYmnFrEPSJBhNEupBFNvCWZB/Od9spCD51sTXknD9s+zpcgp9dvw54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710317717; c=relaxed/simple;
	bh=nEffeaEkUXeL9ZZoT5q8k9bvL4SIKdrRskLsclcByxU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EdUf/1ZzrEDZRTSgaKTNECMH1da3zwDe7KIjqUrAAde77X7jMkTLfjYbF5iEjjvn+a/3VCW8PoxqVkbcYRguMfFa7iAZOkpUChO3pLqxII8i79lpprW7k7vogKpKDf/Wm5XBnNwrMJ8JCxU46d0vQVrbW6uEVyFbyxgLrW5nX0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UdTlpb3v; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710317714;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WGiwFYhlQwAkAcK9KSYTrO5XDHNnn5GT+CKnu+I/Sm8=;
	b=UdTlpb3vdiu/wiW+IfSx3O8rSBFYP3DRvHPON9jhzqW3vU6CXZ4WhFi/9wf+HCewW5/cHP
	eOXt8PMDclNii2vFIqIoW/gPwdubLzy/hHstuXoPYeS6kesqS3lU2X2I5h3FI+q94Leup/
	7arwDBS9wxKeRblEU2yIGcux2a3Udnc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-583-iPBGcg6VMCGu5FCxtsf5cQ-1; Wed,
 13 Mar 2024 04:15:10 -0400
X-MC-Unique: iPBGcg6VMCGu5FCxtsf5cQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 06070380390D;
	Wed, 13 Mar 2024 08:15:10 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.10])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 310F53C23;
	Wed, 13 Mar 2024 08:15:09 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Marc Dionne <marc.dionne@auristor.com>
Cc: David Howells <dhowells@redhat.com>,
	Christian Brauner <christian@brauner.io>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] afs: Don't cache preferred address
Date: Wed, 13 Mar 2024 08:15:02 +0000
Message-ID: <20240313081505.3060173-2-dhowells@redhat.com>
In-Reply-To: <20240313081505.3060173-1-dhowells@redhat.com>
References: <20240313081505.3060173-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

In the AFS fileserver rotation algorithm, don't cache the preferred address
for the server as that will override the explicit preference if a
non-preferred address responds first.

Fixes: 495f2ae9e355 ("afs: Fix fileserver rotation")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
---
 fs/afs/rotate.c | 21 ++++-----------------
 1 file changed, 4 insertions(+), 17 deletions(-)

diff --git a/fs/afs/rotate.c b/fs/afs/rotate.c
index 700a27bc8c25..ed04bd1eeae8 100644
--- a/fs/afs/rotate.c
+++ b/fs/afs/rotate.c
@@ -602,6 +602,8 @@ bool afs_select_fileserver(struct afs_operation *op)
 		goto wait_for_more_probe_results;
 
 	alist = op->estate->addresses;
+	best_prio = -1;
+	addr_index = 0;
 	for (i = 0; i < alist->nr_addrs; i++) {
 		if (alist->addrs[i].prio > best_prio) {
 			addr_index = i;
@@ -609,9 +611,7 @@ bool afs_select_fileserver(struct afs_operation *op)
 		}
 	}
 
-	addr_index = READ_ONCE(alist->preferred);
-	if (!test_bit(addr_index, &set))
-		addr_index = __ffs(set);
+	alist->preferred = addr_index;
 
 	op->addr_index = addr_index;
 	set_bit(addr_index, &op->addr_tried);
@@ -656,12 +656,6 @@ bool afs_select_fileserver(struct afs_operation *op)
 next_server:
 	trace_afs_rotate(op, afs_rotate_trace_next_server, 0);
 	_debug("next");
-	ASSERT(op->estate);
-	alist = op->estate->addresses;
-	if (op->call_responded &&
-	    op->addr_index != READ_ONCE(alist->preferred) &&
-	    test_bit(alist->preferred, &op->addr_tried))
-		WRITE_ONCE(alist->preferred, op->addr_index);
 	op->estate = NULL;
 	goto pick_server;
 
@@ -690,14 +684,7 @@ bool afs_select_fileserver(struct afs_operation *op)
 failed:
 	trace_afs_rotate(op, afs_rotate_trace_failed, 0);
 	op->flags |= AFS_OPERATION_STOP;
-	if (op->estate) {
-		alist = op->estate->addresses;
-		if (op->call_responded &&
-		    op->addr_index != READ_ONCE(alist->preferred) &&
-		    test_bit(alist->preferred, &op->addr_tried))
-			WRITE_ONCE(alist->preferred, op->addr_index);
-		op->estate = NULL;
-	}
+	op->estate = NULL;
 	_leave(" = f [failed %d]", afs_op_error(op));
 	return false;
 }


