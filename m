Return-Path: <linux-fsdevel+bounces-49419-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB482ABBFED
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 15:54:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94CF93AC983
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 13:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A04522820D7;
	Mon, 19 May 2025 13:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ReX0MZRL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D41828468E
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 May 2025 13:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747662559; cv=none; b=L6DMTWgNvSeTLcA6zCDOMjc9JU9+p8Ztfx3KkBJsq5DhUP3iXOv4T/DZdyJLWDCHlDdLt2VgfTTmr+XZDItNpACp193nR7NFUDIN4qo4fNvFvsJbOlp+Cocyyax8b9cCXwO3JM2sQZWbKqTBqhDMKZs4uSsFxidf9bqUWny2R50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747662559; c=relaxed/simple;
	bh=n/oQdNnyowSyYqQTh+SRmNWyXaRqlSnxzh5esURqDiU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ro+IXUGuBcBIljiTHDpka4S+6hTzJMlrMas64anZZCM4RNBCt5169qjXzlrfvcNj8lR9gYtWVaTxW1vvPQEMOHe8usQByOKMsncrQ8DjdqG2Sp4HHeTS9azwF0L67NDF/xvc2wnNTeePPSsrti3ORjGd62eHHtaKP2YNA15fqoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ReX0MZRL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747662556;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6P8aO9r1syzIUxDTslH0agbzpp9UaQhwLfixEEJwzYA=;
	b=ReX0MZRLTvRRrl2JA6HlSvO1BJrBzVLRWuGgwH7SpMpcofNM+bUWLn/c/0i9Ir0K4J5La2
	fkndnGLrzfGJMIWycGLspxxlTwxt/zX55G+6kQpx6+j4tks3fso18g15SruIhpMs8uP7qT
	LWbdQs5EUC29tXtccJszJng+gZeuJHI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-341-oj-KpwTePEu-Z7Ls7MuDlQ-1; Mon,
 19 May 2025 09:49:13 -0400
X-MC-Unique: oj-KpwTePEu-Z7Ls7MuDlQ-1
X-Mimecast-MFC-AGG-ID: oj-KpwTePEu-Z7Ls7MuDlQ_1747662551
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AC09B180045B;
	Mon, 19 May 2025 13:49:11 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.188])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 94C9E180047F;
	Mon, 19 May 2025 13:49:08 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Max Kellermann <max.kellermann@ionos.com>,
	netfs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 09/11] folio_queue: remove unused field `marks3`
Date: Mon, 19 May 2025 14:48:05 +0100
Message-ID: <20250519134813.2975312-10-dhowells@redhat.com>
In-Reply-To: <20250519134813.2975312-1-dhowells@redhat.com>
References: <20250519134813.2975312-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

From: Max Kellermann <max.kellermann@ionos.com>

The last user was removed by commit e2d46f2ec332 ("netfs: Change the
read result collector to only use one work item").

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Paulo Alcantara <pc@manguebit.com>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 Documentation/core-api/folio_queue.rst |  3 --
 include/linux/folio_queue.h            | 42 --------------------------
 2 files changed, 45 deletions(-)

diff --git a/Documentation/core-api/folio_queue.rst b/Documentation/core-api/folio_queue.rst
index 1fe7a9bc4b8d..83cfbc157e49 100644
--- a/Documentation/core-api/folio_queue.rst
+++ b/Documentation/core-api/folio_queue.rst
@@ -151,19 +151,16 @@ The marks can be set by::
 
 	void folioq_mark(struct folio_queue *folioq, unsigned int slot);
 	void folioq_mark2(struct folio_queue *folioq, unsigned int slot);
-	void folioq_mark3(struct folio_queue *folioq, unsigned int slot);
 
 Cleared by::
 
 	void folioq_unmark(struct folio_queue *folioq, unsigned int slot);
 	void folioq_unmark2(struct folio_queue *folioq, unsigned int slot);
-	void folioq_unmark3(struct folio_queue *folioq, unsigned int slot);
 
 And the marks can be queried by::
 
 	bool folioq_is_marked(const struct folio_queue *folioq, unsigned int slot);
 	bool folioq_is_marked2(const struct folio_queue *folioq, unsigned int slot);
-	bool folioq_is_marked3(const struct folio_queue *folioq, unsigned int slot);
 
 The marks can be used for any purpose and are not interpreted by this API.
 
diff --git a/include/linux/folio_queue.h b/include/linux/folio_queue.h
index 45ad2408a80c..adab609c972e 100644
--- a/include/linux/folio_queue.h
+++ b/include/linux/folio_queue.h
@@ -34,7 +34,6 @@ struct folio_queue {
 	struct folio_queue	*prev;		/* Previous queue segment of NULL */
 	unsigned long		marks;		/* 1-bit mark per folio */
 	unsigned long		marks2;		/* Second 1-bit mark per folio */
-	unsigned long		marks3;		/* Third 1-bit mark per folio */
 #if PAGEVEC_SIZE > BITS_PER_LONG
 #error marks is not big enough
 #endif
@@ -58,7 +57,6 @@ static inline void folioq_init(struct folio_queue *folioq, unsigned int rreq_id)
 	folioq->prev = NULL;
 	folioq->marks = 0;
 	folioq->marks2 = 0;
-	folioq->marks3 = 0;
 	folioq->rreq_id = rreq_id;
 	folioq->debug_id = 0;
 }
@@ -178,45 +176,6 @@ static inline void folioq_unmark2(struct folio_queue *folioq, unsigned int slot)
 	clear_bit(slot, &folioq->marks2);
 }
 
-/**
- * folioq_is_marked3: Check third folio mark in a folio queue segment
- * @folioq: The segment to query
- * @slot: The slot number of the folio to query
- *
- * Determine if the third mark is set for the folio in the specified slot in a
- * folio queue segment.
- */
-static inline bool folioq_is_marked3(const struct folio_queue *folioq, unsigned int slot)
-{
-	return test_bit(slot, &folioq->marks3);
-}
-
-/**
- * folioq_mark3: Set the third mark on a folio in a folio queue segment
- * @folioq: The segment to modify
- * @slot: The slot number of the folio to modify
- *
- * Set the third mark for the folio in the specified slot in a folio queue
- * segment.
- */
-static inline void folioq_mark3(struct folio_queue *folioq, unsigned int slot)
-{
-	set_bit(slot, &folioq->marks3);
-}
-
-/**
- * folioq_unmark3: Clear the third mark on a folio in a folio queue segment
- * @folioq: The segment to modify
- * @slot: The slot number of the folio to modify
- *
- * Clear the third mark for the folio in the specified slot in a folio queue
- * segment.
- */
-static inline void folioq_unmark3(struct folio_queue *folioq, unsigned int slot)
-{
-	clear_bit(slot, &folioq->marks3);
-}
-
 /**
  * folioq_append: Add a folio to a folio queue segment
  * @folioq: The segment to add to
@@ -318,7 +277,6 @@ static inline void folioq_clear(struct folio_queue *folioq, unsigned int slot)
 	folioq->vec.folios[slot] = NULL;
 	folioq_unmark(folioq, slot);
 	folioq_unmark2(folioq, slot);
-	folioq_unmark3(folioq, slot);
 }
 
 #endif /* _LINUX_FOLIO_QUEUE_H */


