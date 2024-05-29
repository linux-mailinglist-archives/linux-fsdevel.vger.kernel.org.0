Return-Path: <linux-fsdevel+bounces-20444-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A8788D384B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 15:48:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F61CB26AC8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 13:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D65524C4;
	Wed, 29 May 2024 13:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="XtmSRYj1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B211CAB9;
	Wed, 29 May 2024 13:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716990357; cv=none; b=nc2eoJ3CqJbKWlsTZD1hl4PjyBzaSarHDH6V6GQRNfaSICUkapQU/EA7rGcSXcUpwDWHxMUCYIxfCyTMMoEuL6yTniL0GgBKPliCfHEGES1xRDKvYgT8voDYy1ZcBXHJwmflwxZw/OLvDvSknFd+JZvXoFcyxay9Xxrg3hZV7DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716990357; c=relaxed/simple;
	bh=IHNS2vBVtCoLav5/XzYompHddU+6dBvnI/6xE7w7hTw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bkIbW+7IxFJfNx0AlfumtwKM0HliJaYfuI78VI2WZnVK6lrjEDGvHyPdiYmcEWc92XOOmP96Q35cVFBkLp03Cc0Cgycr7bkA5J4dKl6yC6oVgqDnL33Yx7xwzf7kb/tKtLxw7PExjnwkWbGlISDqFOoLpYAoTEp8hoCGHdSI9E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=XtmSRYj1; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4Vq9dD5WLlz9srg;
	Wed, 29 May 2024 15:45:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1716990352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1QtcK2fxbZ+x1HZw3p1m35+0G7d81xL3TX3Jwuj1ZS8=;
	b=XtmSRYj18h9+1ShKisqhJuhbvmFNCkHXkrsU/DwgyRVYGbZx8dom0yMEQL7U9ngd+ACH4q
	cxANxsQsXNqDYf8t3VO+RKQajOU6g5SL1w1u7KAPSRb/8t+qJDmTlMMY5mgfCtJmjGkyar
	bdQ9ZZcUFfZKkPiJLjPDGura3CWpql6cfv3N9B0ri29HyUB6pM3I8nI/LJyKIPoAZ3mzUS
	Mfp5TcBEP7f0p6iI0cliKqVakwYXw15t2f0GrFMq7FtHYWmgIjbsMbjDuueEkNec3nLCXO
	UdBFXpbh1KzrRFqCrVS6KA2ZvQiIe8nHUUkiYFbT3YhJndAYblsnR1RihCReEA==
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: david@fromorbit.com,
	chandan.babu@oracle.com,
	akpm@linux-foundation.org,
	brauner@kernel.org,
	willy@infradead.org,
	djwong@kernel.org
Cc: linux-kernel@vger.kernel.org,
	hare@suse.de,
	john.g.garry@oracle.com,
	gost.dev@samsung.com,
	yang@os.amperecomputing.com,
	p.raghav@samsung.com,
	cl@os.amperecomputing.com,
	linux-xfs@vger.kernel.org,
	hch@lst.de,
	mcgrof@kernel.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	Dave Chinner <dchinner@redhat.com>,
	Pankaj Raghav <kernel@pankajraghav.com>
Subject: [PATCH v6 08/11] xfs: use kvmalloc for xattr buffers
Date: Wed, 29 May 2024 15:45:06 +0200
Message-Id: <20240529134509.120826-9-kernel@pankajraghav.com>
In-Reply-To: <20240529134509.120826-1-kernel@pankajraghav.com>
References: <20240529134509.120826-1-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4Vq9dD5WLlz9srg

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
2.34.1


