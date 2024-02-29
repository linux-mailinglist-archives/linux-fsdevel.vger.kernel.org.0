Return-Path: <linux-fsdevel+bounces-13216-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 917EF86D552
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 22:00:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 209A62867AA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 21:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65F90169E26;
	Thu, 29 Feb 2024 20:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FASUMyUI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB1916A366
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Feb 2024 20:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709239300; cv=none; b=C1wB1VqiWkxbqYOjZE29VEus1+9fq43gANbRNDPY7r4CCNBiXlF7ahN4gtEo72OZAMQgYNcOgbFKzTHIZvxawxtOkvvgX6fiycaIWPR9Q0kVRXSpsSXHAROPGZsDWS5wC7Y6c98S/7xLgLwtA761i3etNJKj6EHs7dU2Hc27wEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709239300; c=relaxed/simple;
	bh=l0Oq7AxbSJ3lXobf7o9ZXRUD7DUDozdY4OL4raAyp+U=;
	h=From:To:cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=fTVCGZVs8/djFp/bbSRUt+fyC1MQj1oassSABmziiPuYccfk5kpbJV0CJoO1niJ3eD3bTbk1KvtVhdD9a/c+XpVyDe0LcAOWmZ8+eX2yhpF9Wt9XoFiGX8OmQWyKbgd2KnCy83ezdKGq82rJQU90Ekr7CIVKQR9VqHmHxqRu/4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FASUMyUI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709239297;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=CGBj0np1q/By//l0SwNKja6NHqrIAS9mqiRvEzZjjl8=;
	b=FASUMyUIxIHjcqMjdj/uy9LsuqxFHtf1wb9lm2ThhKASrzIdNoX9SXkqNSu/JA9JitVzU9
	fSLYam99cC8mGNkbvPekSfx74Q2K6heH39kEiyzKi37fKMsHHJKH6E04uFCfrDyxgsQ2XY
	VK8GD8WUuvS2IeHTDxBr9wcksCn+SJA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-115-LPrxkonAMx-LIKP55RDsAQ-1; Thu,
 29 Feb 2024 15:41:34 -0500
X-MC-Unique: LPrxkonAMx-LIKP55RDsAQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2CDDA1C0690F;
	Thu, 29 Feb 2024 20:41:33 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.114])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7AC2D1BDB1;
	Thu, 29 Feb 2024 20:41:32 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: Marc Dionne <marc.dionne@auristor.com>
cc: dhowells@redhat.com, linux-afs@lists.infradead.org,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] afs: Don't cache preferred address
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <159568.1709239291.1@warthog.procyon.org.uk>
Date: Thu, 29 Feb 2024 20:41:31 +0000
Message-ID: <159569.1709239291@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

In the AFS fileserver rotation algorithm, don't cache the preferred address
for the server as that will override the explicit preference if a
non-preferred address responds first.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
---
 fs/afs/rotate.c |   21 ++++-----------------
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


