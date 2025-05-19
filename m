Return-Path: <linux-fsdevel+bounces-49414-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80856ABBFCB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 15:51:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBB077A5349
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 13:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D75ED28369D;
	Mon, 19 May 2025 13:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EVNyWnDw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785192820B3
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 May 2025 13:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747662537; cv=none; b=QaMgO3QbjDldwAbsKDSQS8i+lsGoWBOftbU3lflf8UaZrH9IYjSLIrqfqSGRwaCfsevGrx816bnXRU9LFbOUL6czKWozCf7jyYatXAZQfNjUZnDu7AnYiparWi2h7Ue4RUv4WtODjy4ylh6aDY0TFFU1saGucO/RwQm9eS4kRTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747662537; c=relaxed/simple;
	bh=PqzRtgC4yLZW6u6+8UasqZdvTAZCYjwKRfgNaZVf4z0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y9/xWWCq2RLw5KGif7dtw0kIFiYKx0JaqfhJiFbuTY5z6Kfl5oY3CJP/uJbxnC7n0+GTurOItEDFfXcy1QhlZ7eVzCe/0OhrMdMDi2dKcE0F7E05MaNeTdI6P1sDZcfkuUqQSY0FFmCtpgJGeDl43bfNS27RWJO9HBm9T6utAhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EVNyWnDw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747662534;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p0S73aJAtnnKxC2CSvCyevWiHECBuIdU+O/XU9zgy84=;
	b=EVNyWnDwjeniYDQS6RMA3LqbVz55216Yk026khC7kUHt2XFmGCXVOHXP1pxpYzJVi2d+xG
	d4edZd7En9GIx61xgPRlfF3cGM+wXaoPqINBtyh46M/inABluja6ekCw+ey7Fd1lQYx27k
	XCETc9ZujYcZq4pX1HU71VQEqP6lf1E=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-224-S5qaN7_xNKqre078m54fag-1; Mon,
 19 May 2025 09:48:50 -0400
X-MC-Unique: S5qaN7_xNKqre078m54fag-1
X-Mimecast-MFC-AGG-ID: S5qaN7_xNKqre078m54fag_1747662528
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1A65D180034E;
	Mon, 19 May 2025 13:48:48 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.188])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0F54919560AB;
	Mon, 19 May 2025 13:48:44 +0000 (UTC)
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
Subject: [PATCH 04/11] fs/netfs: remove unused flag NETFS_ICTX_WRITETHROUGH
Date: Mon, 19 May 2025 14:48:00 +0100
Message-ID: <20250519134813.2975312-5-dhowells@redhat.com>
In-Reply-To: <20250519134813.2975312-1-dhowells@redhat.com>
References: <20250519134813.2975312-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

From: Max Kellermann <max.kellermann@ionos.com>

This flag was added by commit 41d8e7673a77 ("netfs: Implement a
write-through caching option") but it was never used.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Paulo Alcantara <pc@manguebit.com>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/buffered_write.c | 3 +--
 include/linux/netfs.h     | 1 -
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/netfs/buffered_write.c b/fs/netfs/buffered_write.c
index b4826360a411..26a789c8ce18 100644
--- a/fs/netfs/buffered_write.c
+++ b/fs/netfs/buffered_write.c
@@ -115,8 +115,7 @@ ssize_t netfs_perform_write(struct kiocb *iocb, struct iov_iter *iter,
 	size_t max_chunk = mapping_max_folio_size(mapping);
 	bool maybe_trouble = false;
 
-	if (unlikely(test_bit(NETFS_ICTX_WRITETHROUGH, &ctx->flags) ||
-		     iocb->ki_flags & (IOCB_DSYNC | IOCB_SYNC))
+	if (unlikely(iocb->ki_flags & (IOCB_DSYNC | IOCB_SYNC))
 	    ) {
 		wbc_attach_fdatawrite_inode(&wbc, mapping->host);
 
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 5a76bea51d24..242daec8c837 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -70,7 +70,6 @@ struct netfs_inode {
 	unsigned long		flags;
 #define NETFS_ICTX_ODIRECT	0		/* The file has DIO in progress */
 #define NETFS_ICTX_UNBUFFERED	1		/* I/O should not use the pagecache */
-#define NETFS_ICTX_WRITETHROUGH	2		/* Write-through caching */
 #define NETFS_ICTX_MODIFIED_ATTR 3		/* Indicate change in mtime/ctime */
 #define NETFS_ICTX_SINGLE_NO_UPLOAD 4		/* Monolithic payload, cache but no upload */
 };


