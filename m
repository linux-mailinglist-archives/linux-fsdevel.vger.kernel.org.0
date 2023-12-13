Return-Path: <linux-fsdevel+bounces-5868-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E4E0811372
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 14:50:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFCA51C20F85
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 13:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F0FE2DF62;
	Wed, 13 Dec 2023 13:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U4zQCPkt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3543101
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Dec 2023 05:50:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702475429;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=At55AdxI0EVqvLoVtG7qh0zVypL7yPQ0gJ4RwZozN0o=;
	b=U4zQCPkt28QhZRMEuqGa/v2fSUrMCTg/SbQYtE4h6PEWzxEZiEIkSKvVI1XGJQi4rWD8N1
	sxgSclpoFtWkH7/fBXK5sj3BFMZQjEZC4Y3HF0tJN9nLVq1kCkqPUx3dWtLs+5y5MbG03U
	i4rOevdp1A53MVe1V4hyXED/2Cet//4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-194-iTfH0SaSNVqQa9XMdNQ_yg-1; Wed,
 13 Dec 2023 08:50:27 -0500
X-MC-Unique: iTfH0SaSNVqQa9XMdNQ_yg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5862F3C2A1C3;
	Wed, 13 Dec 2023 13:50:27 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.2])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8D38C1121306;
	Wed, 13 Dec 2023 13:50:26 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Marc Dionne <marc.dionne@auristor.com>
Cc: David Howells <dhowells@redhat.com>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 13/40] afs: Use op->nr_iterations=-1 to indicate to begin fileserver iteration
Date: Wed, 13 Dec 2023 13:49:35 +0000
Message-ID: <20231213135003.367397-14-dhowells@redhat.com>
In-Reply-To: <20231213135003.367397-1-dhowells@redhat.com>
References: <20231213135003.367397-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

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
index 95bb37253cad..e43aef74c241 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -859,7 +859,7 @@ struct afs_operation {
 	struct afs_call		*call;
 	unsigned long		untried;	/* Bitmask of untried servers */
 	short			index;		/* Current server */
-	unsigned short		nr_iterations;	/* Number of server iterations */
+	short			nr_iterations;	/* Number of server iterations */
 
 	unsigned int		flags;
 #define AFS_OPERATION_STOP		0x0001	/* Set to cease iteration */
diff --git a/fs/afs/rotate.c b/fs/afs/rotate.c
index 0829933f4d9a..4d2317a66385 100644
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


