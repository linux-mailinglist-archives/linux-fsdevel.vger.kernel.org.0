Return-Path: <linux-fsdevel+bounces-21251-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C23C900843
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 17:07:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24D6228FE20
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 15:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F75519AA53;
	Fri,  7 Jun 2024 15:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="NolyD4e3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA4719A284;
	Fri,  7 Jun 2024 15:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717772786; cv=none; b=nQuJMY/5kqASHXXWRzd3cKl1hSnRDqV34jG4hSyR7+uNw9B1BX28o40oK4AliYjHtA0cT7wq/2jjhhCdgfV1eaptX2fUJm2SbsPCKGDVtAboSKHMvonXY8tzp9d6+9sVI0HH7YKiSIpsmXSVCT8Y9XipAWpGThkMH94x6aqXOMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717772786; c=relaxed/simple;
	bh=Sv9E3U1vrEuoSMMHMwfb5YdKHNu1CJKxciCkR7PpDe4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q2hthaJICfCorQikOUXnay7Vo3LzVLuLgEZZMChCTIWaWrIjjI5VlyDwMNTD/Yzdjt1uGkFoYttS3BqL4gp0UmNJWjs24fswt9fsWX6cjkagxxXDm5lODXrnuLi3P6IXJf2wqu+ZDvVwavy1Nvls0FkVAHCAk2iazNjDW0WGyiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=NolyD4e3; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4VwkrF2Pd1z9sng;
	Fri,  7 Jun 2024 16:59:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1717772381;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kZG/lL31K25//iaIAV7jBbt1MNjj987Sk8ll7Dxjdts=;
	b=NolyD4e3omUCcx8jYDPY5ZsDQIHnS6RImuHNHeschPG7wr1uaeUR7qeU92o88kizWNRrAr
	SPhn3Cqkx/nm6ynGmBxDMlx2bkrNAdRZYpqYRswXXrTZ4S9FOqoHy95aPpCwC7eWGKAhgV
	UYRW6njfy8HdZueqtcGalhYbUfZUliyN9Dpi69gv2Rf3twKEUV51yeGEhqz47K6Gfi/vUp
	WvGe3GyAxkVYhSTpOGarHrkIJRYmf6bgft57mVFmQofyk/wz89uXsAMB/OeiiET5V3FeLw
	+IKc3x61zFHlTj9qpPNiPwyTtnKkR+k3siGQMDaR8gHW6pfH/5JO6whYg9+Jqg==
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: david@fromorbit.com,
	djwong@kernel.org,
	chandan.babu@oracle.com,
	brauner@kernel.org,
	akpm@linux-foundation.org,
	willy@infradead.org
Cc: mcgrof@kernel.org,
	linux-mm@kvack.org,
	hare@suse.de,
	linux-kernel@vger.kernel.org,
	yang@os.amperecomputing.com,
	Zi Yan <zi.yan@sent.com>,
	linux-xfs@vger.kernel.org,
	p.raghav@samsung.com,
	linux-fsdevel@vger.kernel.org,
	kernel@pankajraghav.com,
	hch@lst.de,
	gost.dev@samsung.com,
	cl@os.amperecomputing.com,
	john.g.garry@oracle.com,
	Dave Chinner <dchinner@redhat.com>
Subject: [PATCH v7 08/11] xfs: use kvmalloc for xattr buffers
Date: Fri,  7 Jun 2024 14:58:59 +0000
Message-ID: <20240607145902.1137853-9-kernel@pankajraghav.com>
In-Reply-To: <20240607145902.1137853-1-kernel@pankajraghav.com>
References: <20240607145902.1137853-1-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dave Chinner <dchinner@redhat.com>

Pankaj Raghav reported that when filesystem block size is larger
than page size, the xattr code can use kmalloc() for high order
allocations. This triggers a useless warning in the allocator as it
is a __GFP_NOFAIL allocation here:

static inline
struct page *rmqueue(struct zone *preferred_zone,
                        struct zone *zone, unsigned int order,
                        gfp_t gfp_flags, unsigned int alloc_flags,
                        int migratetype)
{
        struct page *page;

        /*
         * We most definitely don't want callers attempting to
         * allocate greater than order-1 page units with __GFP_NOFAIL.
         */
>>>>    WARN_ON_ONCE((gfp_flags & __GFP_NOFAIL) && (order > 1));
...

Fix this by changing all these call sites to use kvmalloc(), which
will strip the NOFAIL from the kmalloc attempt and if that fails
will do a __GFP_NOFAIL vmalloc().

This is not an issue that productions systems will see as
filesystems with block size > page size cannot be mounted by the
kernel; Pankaj is developing this functionality right now.

Reported-by: Pankaj Raghav <kernel@pankajraghav.com>
Fixes: f078d4ea8276 ("xfs: convert kmem_alloc() to kmalloc()")
Signed-off-by: Dave Chinner <dchinner@redhat.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Pankaj Raghav <p.raghav@samsung.com>
---
 fs/xfs/libxfs/xfs_attr_leaf.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_attr_leaf.c b/fs/xfs/libxfs/xfs_attr_leaf.c
index b9e98950eb3d..09f4cb061a6e 100644
--- a/fs/xfs/libxfs/xfs_attr_leaf.c
+++ b/fs/xfs/libxfs/xfs_attr_leaf.c
@@ -1138,10 +1138,7 @@ xfs_attr3_leaf_to_shortform(
 
 	trace_xfs_attr_leaf_to_sf(args);
 
-	tmpbuffer = kmalloc(args->geo->blksize, GFP_KERNEL | __GFP_NOFAIL);
-	if (!tmpbuffer)
-		return -ENOMEM;
-
+	tmpbuffer = kvmalloc(args->geo->blksize, GFP_KERNEL | __GFP_NOFAIL);
 	memcpy(tmpbuffer, bp->b_addr, args->geo->blksize);
 
 	leaf = (xfs_attr_leafblock_t *)tmpbuffer;
@@ -1205,7 +1202,7 @@ xfs_attr3_leaf_to_shortform(
 	error = 0;
 
 out:
-	kfree(tmpbuffer);
+	kvfree(tmpbuffer);
 	return error;
 }
 
@@ -1613,7 +1610,7 @@ xfs_attr3_leaf_compact(
 
 	trace_xfs_attr_leaf_compact(args);
 
-	tmpbuffer = kmalloc(args->geo->blksize, GFP_KERNEL | __GFP_NOFAIL);
+	tmpbuffer = kvmalloc(args->geo->blksize, GFP_KERNEL | __GFP_NOFAIL);
 	memcpy(tmpbuffer, bp->b_addr, args->geo->blksize);
 	memset(bp->b_addr, 0, args->geo->blksize);
 	leaf_src = (xfs_attr_leafblock_t *)tmpbuffer;
@@ -1651,7 +1648,7 @@ xfs_attr3_leaf_compact(
 	 */
 	xfs_trans_log_buf(trans, bp, 0, args->geo->blksize - 1);
 
-	kfree(tmpbuffer);
+	kvfree(tmpbuffer);
 }
 
 /*
@@ -2330,7 +2327,7 @@ xfs_attr3_leaf_unbalance(
 		struct xfs_attr_leafblock *tmp_leaf;
 		struct xfs_attr3_icleaf_hdr tmphdr;
 
-		tmp_leaf = kzalloc(state->args->geo->blksize,
+		tmp_leaf = kvzalloc(state->args->geo->blksize,
 				GFP_KERNEL | __GFP_NOFAIL);
 
 		/*
@@ -2371,7 +2368,7 @@ xfs_attr3_leaf_unbalance(
 		}
 		memcpy(save_leaf, tmp_leaf, state->args->geo->blksize);
 		savehdr = tmphdr; /* struct copy */
-		kfree(tmp_leaf);
+		kvfree(tmp_leaf);
 	}
 
 	xfs_attr3_leaf_hdr_to_disk(state->args->geo, save_leaf, &savehdr);
-- 
2.44.1


