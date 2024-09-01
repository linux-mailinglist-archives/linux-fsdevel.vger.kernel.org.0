Return-Path: <linux-fsdevel+bounces-28177-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6561D967891
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Sep 2024 18:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CDDBEB21AFB
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Sep 2024 16:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C87FE184554;
	Sun,  1 Sep 2024 16:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="c5Ijillm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6CB183CA7;
	Sun,  1 Sep 2024 16:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725208389; cv=none; b=YVGLhEiCOM6HtQcxqIpBFx+RjZHDo7Fn9Rn0JebhWn2Qo0Ou0oKs7TMnSRn+25wl5ZAdTAtoA63F7fWyaO9iRgmZF0EBUQfPAVe7nP23X5+olEvXq3HO6lgbcPfem2Z5TufblkXmxpOPbkYubKRyoW40c3OsO+UMK0pDmJ+jILQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725208389; c=relaxed/simple;
	bh=gQwvkLOGUYQCnKHMNODQw/TU80tKioex5elMQ2uHBk8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r2MGmEjVCDe3AwLcKyoI5Y7HcCx8a/iGO8k2+vwmUA74YXcs4L6+hzRJXNaT86vsBvSiHKWBnD4stnVO+NXlsHAtQoWvyEiTlEynQTnXCyzCN5BilUpxTNKSw0M+DyGCaWJ8EOmWprfUpX6qiQDfNOwyJcaKxaIu16kDywf23Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=c5Ijillm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53329C4CEC4;
	Sun,  1 Sep 2024 16:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725208389;
	bh=gQwvkLOGUYQCnKHMNODQw/TU80tKioex5elMQ2uHBk8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c5IjillmxmcJHedTQA0h+atYXCW3k+p0AH8e95jtmbHnTq2RSoZVx7DJ04jk/MBOu
	 alBse+nnC13Pj2WgcgbM842Oe131vTxsCB/vNH8hBDQKfJ1LaQHBXK1rR+3iHfD7p2
	 xwqK9Kc0MJjeKBLJVNc5qmy0q7pLOntxkGrcynhE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Howells <dhowells@redhat.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Pankaj Raghav <p.raghav@samsung.com>,
	Jeff Layton <jlayton@kernel.org>,
	Marc Dionne <marc.dionne@auristor.com>,
	linux-afs@lists.infradead.org,
	netfs@lists.linux.dev,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 068/149] netfs: Fix trimming of streaming-write folios in netfs_inval_folio()
Date: Sun,  1 Sep 2024 18:16:19 +0200
Message-ID: <20240901160820.023814450@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240901160817.461957599@linuxfoundation.org>
References: <20240901160817.461957599@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Howells <dhowells@redhat.com>

[ Upstream commit cce6bfa6ca0e30af9927b0074c97fe6a92f28092 ]

When netfslib writes to a folio that it doesn't have data for, but that
data exists on the server, it will make a 'streaming write' whereby it
stores data in a folio that is marked dirty, but not uptodate.  When it
does this, it attaches a record to folio->private to track the dirty
region.

When truncate() or fallocate() wants to invalidate part of such a folio, it
will call into ->invalidate_folio(), specifying the part of the folio that
is to be invalidated.  netfs_invalidate_folio(), on behalf of the
filesystem, must then determine how to trim the streaming write record.  In
a couple of cases, however, it does this incorrectly (the reduce-length and
move-start cases are switched over and don't, in any case, calculate the
value correctly).

Fix this by making the logic tree more obvious and fixing the cases.

Fixes: 9ebff83e6481 ("netfs: Prep to use folio->private for write grouping and streaming write")
Signed-off-by: David Howells <dhowells@redhat.com>
Link: https://lore.kernel.org/r/20240823200819.532106-5-dhowells@redhat.com
cc: Matthew Wilcox (Oracle) <willy@infradead.org>
cc: Pankaj Raghav <p.raghav@samsung.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
cc: netfs@lists.linux.dev
cc: linux-mm@kvack.org
cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/netfs/misc.c | 50 ++++++++++++++++++++++++++++++++++---------------
 1 file changed, 35 insertions(+), 15 deletions(-)

diff --git a/fs/netfs/misc.c b/fs/netfs/misc.c
index 21acf4b092a46..a46bf569303fc 100644
--- a/fs/netfs/misc.c
+++ b/fs/netfs/misc.c
@@ -97,10 +97,20 @@ EXPORT_SYMBOL(netfs_clear_inode_writeback);
 void netfs_invalidate_folio(struct folio *folio, size_t offset, size_t length)
 {
 	struct netfs_folio *finfo;
+	struct netfs_inode *ctx = netfs_inode(folio_inode(folio));
 	size_t flen = folio_size(folio);
 
 	kenter("{%lx},%zx,%zx", folio->index, offset, length);
 
+	if (offset == 0 && length == flen) {
+		unsigned long long i_size = i_size_read(&ctx->inode);
+		unsigned long long fpos = folio_pos(folio), end;
+
+		end = umin(fpos + flen, i_size);
+		if (fpos < i_size && end > ctx->zero_point)
+			ctx->zero_point = end;
+	}
+
 	folio_wait_private_2(folio); /* [DEPRECATED] */
 
 	if (!folio_test_private(folio))
@@ -115,18 +125,34 @@ void netfs_invalidate_folio(struct folio *folio, size_t offset, size_t length)
 		/* We have a partially uptodate page from a streaming write. */
 		unsigned int fstart = finfo->dirty_offset;
 		unsigned int fend = fstart + finfo->dirty_len;
-		unsigned int end = offset + length;
+		unsigned int iend = offset + length;
 
 		if (offset >= fend)
 			return;
-		if (end <= fstart)
+		if (iend <= fstart)
+			return;
+
+		/* The invalidation region overlaps the data.  If the region
+		 * covers the start of the data, we either move along the start
+		 * or just erase the data entirely.
+		 */
+		if (offset <= fstart) {
+			if (iend >= fend)
+				goto erase_completely;
+			/* Move the start of the data. */
+			finfo->dirty_len = fend - iend;
+			finfo->dirty_offset = offset;
+			return;
+		}
+
+		/* Reduce the length of the data if the invalidation region
+		 * covers the tail part.
+		 */
+		if (iend >= fend) {
+			finfo->dirty_len = offset - fstart;
 			return;
-		if (offset <= fstart && end >= fend)
-			goto erase_completely;
-		if (offset <= fstart && end > fstart)
-			goto reduce_len;
-		if (offset > fstart && end >= fend)
-			goto move_start;
+		}
+
 		/* A partial write was split.  The caller has already zeroed
 		 * it, so just absorb the hole.
 		 */
@@ -139,12 +165,6 @@ void netfs_invalidate_folio(struct folio *folio, size_t offset, size_t length)
 	folio_clear_uptodate(folio);
 	kfree(finfo);
 	return;
-reduce_len:
-	finfo->dirty_len = offset + length - finfo->dirty_offset;
-	return;
-move_start:
-	finfo->dirty_len -= offset - finfo->dirty_offset;
-	finfo->dirty_offset = offset;
 }
 EXPORT_SYMBOL(netfs_invalidate_folio);
 
@@ -164,7 +184,7 @@ bool netfs_release_folio(struct folio *folio, gfp_t gfp)
 	if (folio_test_dirty(folio))
 		return false;
 
-	end = folio_pos(folio) + folio_size(folio);
+	end = umin(folio_pos(folio) + folio_size(folio), i_size_read(&ctx->inode));
 	if (end > ctx->zero_point)
 		ctx->zero_point = end;
 
-- 
2.43.0




