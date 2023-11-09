Return-Path: <linux-fsdevel+bounces-2553-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5916F7E6D9A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 16:41:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B9F2280E5A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 15:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66E9E21A0C;
	Thu,  9 Nov 2023 15:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pu92fKtk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F4031210F1
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 15:40:42 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BA5535B0
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 07:40:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699544441;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pt0bsPvfi9FBCVF7W8V+gVx20AkrHVXBl3QRM0ev98I=;
	b=Pu92fKtkeA7S0xw1fgVcljI/NI7w3aENKIrbonkooIR7lKHmXtho64kt0Yun5gTFFYqPbr
	ydkEqTZc/yol9DpRR+TLJKRJO1Dg0AWjRZum/AgGPyNQOIDNt2D6EYRVYuRsNxstsMXnqZ
	XOL4hVtoRdIinfvqOrHS5jCqMocjjNM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-387-N4yfMwCOO0C0V_3rtPV5sA-1; Thu,
 09 Nov 2023 10:40:38 -0500
X-MC-Unique: N4yfMwCOO0C0V_3rtPV5sA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DFC6C38143D0;
	Thu,  9 Nov 2023 15:40:36 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.13])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 1DB4A492BFA;
	Thu,  9 Nov 2023 15:40:36 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Marc Dionne <marc.dionne@auristor.com>
Cc: David Howells <dhowells@redhat.com>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 14/41] afs: Use op->nr_iterations=-1 to indicate to begin fileserver iteration
Date: Thu,  9 Nov 2023 15:39:37 +0000
Message-ID: <20231109154004.3317227-15-dhowells@redhat.com>
In-Reply-To: <20231109154004.3317227-1-dhowells@redhat.com>
References: <20231109154004.3317227-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

Set op->nr_iterations to -1 to indicate that we need to begin fileserver
iteration rather than setting error to SHRT_MAX.  This makes it easier to
eliminate the address cursor.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
---
 fs/afs/fs_operation.c |  2 +-
 fs/afs/internal.h     |  2 +-
 fs/afs/rotate.c       | 11 ++++++-----
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/fs/afs/fs_operation.c b/fs/afs/fs_operation.c
index 7a3803ce3a22..3e31fae9a149 100644
--- a/fs/afs/fs_operation.c
+++ b/fs/afs/fs_operation.c
@@ -41,7 +41,7 @@ struct afs_operation *afs_alloc_operation(struct key *key, struct afs_volume *vo
 	op->cb_v_break	= volume->cb_v_break;
 	op->debug_id	= atomic_inc_return(&afs_operation_debug_counter);
 	op->error	= -EDESTADDRREQ;
-	op->ac.error	= SHRT_MAX;
+	op->nr_iterations = -1;
 
 	_leave(" = [op=%08x]", op->debug_id);
 	return op;
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 9182bd410bbd..3739110fc0b5 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -858,7 +858,7 @@ struct afs_operation {
 	struct afs_call		*call;
 	unsigned long		untried;	/* Bitmask of untried servers */
 	short			index;		/* Current server */
-	unsigned short		nr_iterations;	/* Number of server iterations */
+	short			nr_iterations;	/* Number of server iterations */
 
 	unsigned int		flags;
 #define AFS_OPERATION_STOP		0x0001	/* Set to cease iteration */
diff --git a/fs/afs/rotate.c b/fs/afs/rotate.c
index 342afc951fe4..beb9fd4e8f44 100644
--- a/fs/afs/rotate.c
+++ b/fs/afs/rotate.c
@@ -116,7 +116,10 @@ bool afs_select_fileserver(struct afs_operation *op)
 	unsigned int rtt;
 	int error = op->ac.error, i;
 
-	_enter("%lx[%d],%lx[%d],%d,%d",
+	op->nr_iterations++;
+
+	_enter("OP=%x+%x,%llx,%lx[%d],%lx[%d],%d,%d",
+	       op->debug_id, op->nr_iterations, op->volume->vid,
 	       op->untried, op->index,
 	       op->ac.tried, op->ac.index,
 	       error, op->ac.abort_code);
@@ -126,13 +129,11 @@ bool afs_select_fileserver(struct afs_operation *op)
 		return false;
 	}
 
-	op->nr_iterations++;
+	if (op->nr_iterations == 0)
+		goto start;
 
 	/* Evaluate the result of the previous operation, if there was one. */
 	switch (error) {
-	case SHRT_MAX:
-		goto start;
-
 	case 0:
 	default:
 		/* Success or local failure.  Stop. */


