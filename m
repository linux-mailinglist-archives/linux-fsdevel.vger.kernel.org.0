Return-Path: <linux-fsdevel+bounces-34012-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 603F69C1D2C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2024 13:41:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62B71285E5D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2024 12:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 619821E9097;
	Fri,  8 Nov 2024 12:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GlF/kLE3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713511E884B
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Nov 2024 12:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731069678; cv=none; b=qz6SczQawx5n2u2h3DCyJJ5aDavJUocz1y7vPk0ig8/WvyLdjsZMkFxeWkMUjdLsJAK3W0Rye+7GBgrMBKpaalVHgOQcxu3rePOZVz4J0g9YAduOoYP1Rd+93RBUaBfYMZ+EYj5pEfj6FvF2ttpp5GvC598dHsuinUWxyBBjp3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731069678; c=relaxed/simple;
	bh=JyK04c7bAWyOwLJ7OpQ+2fEinm1tQGvmaDTDdmMoCOQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dOPD68pFWz2LXquJM4Yh15TAU/lLvJ3t4YESj/Ek/1tvJh8ClSpXIHln6xjpadNjfYFTkCnxPLDiQXjhdcXHeaDZvK0T9EepgMRSRoqAT+Ex7yMZsxXsRbHbOqbd1RgzThqHYIwUNL0b04bEDn4OQs1NziwGagbCAHUvrBRlgQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GlF/kLE3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731069675;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F2JK3RJR9W88PivNQjsAvbcErJwExntyQMVOS/w4R6A=;
	b=GlF/kLE3DlqNqch2kwZUCTMuGRTB/OKewOFNabHZpmIoRGK4g6g/Wru3G3AoJNHEAdS1wP
	gz3k8fOhIE153fOsz5a6TMIYxbMhDTDHckgBCYTvMSiqQytYrFVKRR+nbO134gnyVzS2o2
	cyoQ9lQykDVppDfRhfe8gISQjcRUswM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-288-oYcUdHVHP2y5lrfz-StV2w-1; Fri,
 08 Nov 2024 07:41:13 -0500
X-MC-Unique: oYcUdHVHP2y5lrfz-StV2w-1
X-Mimecast-MFC-AGG-ID: oYcUdHVHP2y5lrfz-StV2w
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1B571195608B
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Nov 2024 12:41:13 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.64.111])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9D91E1955F3E
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Nov 2024 12:41:12 +0000 (UTC)
From: Brian Foster <bfoster@redhat.com>
To: linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 1/4] iomap: reset per-iter state on non-error iter advances
Date: Fri,  8 Nov 2024 07:42:43 -0500
Message-ID: <20241108124246.198489-2-bfoster@redhat.com>
In-Reply-To: <20241108124246.198489-1-bfoster@redhat.com>
References: <20241108124246.198489-1-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

iomap_iter_advance() zeroes the processed and mapping fields on
every non-error iteration except for the last expected iteration
(i.e. return 0 expected to terminate the iteration loop). This
appears to be circumstantial as nothing currently relies on these
fields after the final iteration.

Therefore to better faciliate iomap_iter reuse in subsequent
patches, update iomap_iter_advance() to always reset per-iteration
state on successful completion.

Signed-off-by: Brian Foster <bfoster@redhat.com>
---
 fs/iomap/iter.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/fs/iomap/iter.c b/fs/iomap/iter.c
index 79a0614eaab7..3790918646af 100644
--- a/fs/iomap/iter.c
+++ b/fs/iomap/iter.c
@@ -22,26 +22,25 @@
 static inline int iomap_iter_advance(struct iomap_iter *iter)
 {
 	bool stale = iter->iomap.flags & IOMAP_F_STALE;
+	int ret = 1;
 
 	/* handle the previous iteration (if any) */
 	if (iter->iomap.length) {
 		if (iter->processed < 0)
 			return iter->processed;
-		if (!iter->processed && !stale)
-			return 0;
 		if (WARN_ON_ONCE(iter->processed > iomap_length(iter)))
 			return -EIO;
 		iter->pos += iter->processed;
 		iter->len -= iter->processed;
-		if (!iter->len)
-			return 0;
+		if (!iter->len || (!iter->processed && !stale))
+			ret = 0;
 	}
 
-	/* clear the state for the next iteration */
+	/* clear the per iteration state */
 	iter->processed = 0;
 	memset(&iter->iomap, 0, sizeof(iter->iomap));
 	memset(&iter->srcmap, 0, sizeof(iter->srcmap));
-	return 1;
+	return ret;
 }
 
 static inline void iomap_iter_done(struct iomap_iter *iter)
-- 
2.47.0


