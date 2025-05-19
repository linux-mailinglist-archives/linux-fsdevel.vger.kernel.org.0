Return-Path: <linux-fsdevel+bounces-49421-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08919ABBFEE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 15:54:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C99111889A7B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 13:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E2B72874E0;
	Mon, 19 May 2025 13:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MeHFRSp7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624B228689F
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 May 2025 13:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747662569; cv=none; b=J7jQxiXUB2hC0g1G9YM6hUoedX+A2Yi0mEWUD14Gqg1ZU32wy8CE1yFugeFcSFNcns9lXp5tz9c0iheQyeH1s2yjxKto1wa0RLNT8V4inKZoLkBRs7bR4z8LFP5ldsS00SYdt82KhkHUhnbiDzGUyiDtPPS5C6O+jy79WSHzBbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747662569; c=relaxed/simple;
	bh=iv8jfhSY2pjUHanj+AjE29zg4dE6ieuCmxfmSPfpSmc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sCsjK41KgWSYFIy+tbdAJ3pnNFEu0jaMVQM8dklH0m7WK3xhA4lpSLG1PBR1J2PkGThqenDkeStVEyJCI7/yPKSIr8iYwH2XsTHnAMOKt7GELaVGlQb8+eY8UYEvPDBnErVVurlydR4fGxOKyQFMSvd4YuMvmzpFM+BBK8ByBY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MeHFRSp7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747662566;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kg+gPJ9yl1JR7feLLpWZNLDRMWZLNWwVqA9/nsyErrQ=;
	b=MeHFRSp7QjF/9zBbsc2n+VX72qg8ioY7X51oGXnVUeB1yPu0VZdyV0B9w7DdAbQxcY3iwk
	vmn2lYYV8Pyo8vyMLmPV5x4TEfH/4NNm4sRTT3l/tH5v5DME64qQ7JIgHcigSa1AJtOaOV
	Kfa/FqZ9zozdc4RJrjqzsNIXV1M0/yc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-668-6HSQlFW9Nx2ZvVOhQWKZGQ-1; Mon,
 19 May 2025 09:49:23 -0400
X-MC-Unique: 6HSQlFW9Nx2ZvVOhQWKZGQ-1
X-Mimecast-MFC-AGG-ID: 6HSQlFW9Nx2ZvVOhQWKZGQ_1747662561
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7E8F51956046;
	Mon, 19 May 2025 13:49:21 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.188])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A8C2219560A3;
	Mon, 19 May 2025 13:49:17 +0000 (UTC)
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
Subject: [PATCH 11/11] fs/netfs: remove unused flag NETFS_RREQ_BLOCKED
Date: Mon, 19 May 2025 14:48:07 +0100
Message-ID: <20250519134813.2975312-12-dhowells@redhat.com>
In-Reply-To: <20250519134813.2975312-1-dhowells@redhat.com>
References: <20250519134813.2975312-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

From: Max Kellermann <max.kellermann@ionos.com>

NETFS_RREQ_BLOCKED was added by commit 016dc8516aec ("netfs: Implement
unbuffered/DIO read support") but has never been used either.  Without
NETFS_RREQ_BLOCKED, NETFS_RREQ_NONBLOCK makes no sense, and thus can
be removed as well.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Paulo Alcantara <pc@manguebit.com>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/direct_read.c | 3 ---
 fs/netfs/objects.c     | 2 --
 include/linux/netfs.h  | 2 --
 3 files changed, 7 deletions(-)

diff --git a/fs/netfs/direct_read.c b/fs/netfs/direct_read.c
index 5e3f0aeb51f3..f11a89f2fdd9 100644
--- a/fs/netfs/direct_read.c
+++ b/fs/netfs/direct_read.c
@@ -106,9 +106,6 @@ static int netfs_dispatch_unbuffered_reads(struct netfs_io_request *rreq)
 			netfs_wait_for_pause(rreq);
 		if (test_bit(NETFS_RREQ_FAILED, &rreq->flags))
 			break;
-		if (test_bit(NETFS_RREQ_BLOCKED, &rreq->flags) &&
-		    test_bit(NETFS_RREQ_NONBLOCK, &rreq->flags))
-			break;
 		cond_resched();
 	} while (size > 0);
 
diff --git a/fs/netfs/objects.c b/fs/netfs/objects.c
index dc6b41ef18b0..d6f8984f9f5b 100644
--- a/fs/netfs/objects.c
+++ b/fs/netfs/objects.c
@@ -64,8 +64,6 @@ struct netfs_io_request *netfs_alloc_request(struct address_space *mapping,
 	}
 
 	__set_bit(NETFS_RREQ_IN_PROGRESS, &rreq->flags);
-	if (file && file->f_flags & O_NONBLOCK)
-		__set_bit(NETFS_RREQ_NONBLOCK, &rreq->flags);
 	if (rreq->netfs_ops->init_request) {
 		ret = rreq->netfs_ops->init_request(rreq, file);
 		if (ret < 0) {
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 5f60d8e3a7ef..cf634c28522d 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -270,8 +270,6 @@ struct netfs_io_request {
 #define NETFS_RREQ_IN_PROGRESS		5	/* Unlocked when the request completes */
 #define NETFS_RREQ_FOLIO_COPY_TO_CACHE	6	/* Copy current folio to cache from read */
 #define NETFS_RREQ_UPLOAD_TO_SERVER	8	/* Need to write to the server */
-#define NETFS_RREQ_NONBLOCK		9	/* Don't block if possible (O_NONBLOCK) */
-#define NETFS_RREQ_BLOCKED		10	/* We blocked */
 #define NETFS_RREQ_PAUSE		11	/* Pause subrequest generation */
 #define NETFS_RREQ_USE_IO_ITER		12	/* Use ->io_iter rather than ->i_pages */
 #define NETFS_RREQ_ALL_QUEUED		13	/* All subreqs are now queued */


