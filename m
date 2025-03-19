Return-Path: <linux-fsdevel+bounces-44428-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2245AA68744
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 09:52:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DAC2F7AA217
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 08:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD5D32528E1;
	Wed, 19 Mar 2025 08:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Yvd/l7GV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807501DDC16;
	Wed, 19 Mar 2025 08:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742374305; cv=none; b=mijT6j2b6L9CbvhItqswdnHEI7nhZzZGDpRFJN9MRRa0RTIPd61S4BZZikrITrM9gL2e8KJAhqcc9eRsSK8pB6XwzjbQ6tqmGoQd53wHtjon9yuSlDenfaNEfVuUCfjrUP5Oo8FiwUnhnKSTXbOqiLa38kd3SD8BAxjZSBw5K0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742374305; c=relaxed/simple;
	bh=dMtN5sUtYYEnsqN58qACo5iVsrZBwnnUBmSNIOzS75w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V+fdd+4aw3Fuwmqwfr/XJGwxqvYOuDk3s97ZUpAgC+urn1Q/m/ccAaQR07jHZFDMNCMt/icplo6E7TDbaDlYvXKdip3DaAwrbiAEBRiUCalxCe9eUk6HptHN0OQ8gGoupiaB8A1Mv44g54SCqzUncTxCtynu3vmhsilWUoWrMVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Yvd/l7GV; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1742374293; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=kDgPRHGhOjEJ2nJvu5o/zZXNhwOUwu+3KFzmJNBgHPw=;
	b=Yvd/l7GV8InDN8Shw7n4cgfHUXnwie5rrgR0HFZfmoY8FLfrP2BEajLP3B4/QAjUmwxnCzf72baSBaS1CbB4kbMEGkZCoObn98IPQP5gWGWxmlrDruvn1da1hqYUo7E8Iq7lRCgSEIXkyDaJ86y23/HQufOHEFxvM4Lq02wCjm4=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WS1h3h7_1742374287 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 19 Mar 2025 16:51:32 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Brian Foster <bfoster@redhat.com>
Cc: linux-erofs@lists.ozlabs.org,
	linux-xfs@vger.kernel.org,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Bo Liu <liubo03@inspur.com>,
	Christoph Hellwig <hch@lst.de>,
	"Darrick J. Wong" <djwong@kernel.org>
Subject: [PATCH v2] iomap: fix inline data on buffered read
Date: Wed, 19 Mar 2025 16:51:25 +0800
Message-ID: <20250319085125.4039368-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previously, iomap_readpage_iter() returning 0 would break out of the
loops of iomap_readahead_iter(), which is what iomap_read_inline_data()
relies on.

However, commit d9dc477ff6a2 ("iomap: advance the iter directly on
buffered read") changes this behavior without calling
iomap_iter_advance(), which causes EROFS to get stuck in
iomap_readpage_iter().

It seems iomap_iter_advance() cannot be called in
iomap_read_inline_data() because of the iomap_write_begin() path, so
handle this in iomap_readpage_iter() instead.

Reported-and-tested-by: Bo Liu <liubo03@inspur.com>
Fixes: d9dc477ff6a2 ("iomap: advance the iter directly on buffered read")
Cc: Brian Foster <bfoster@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
v1: https://lore.kernel.org/r/20250319025953.3559299-1-hsiangkao@linux.alibaba.com
change since v1:
 - iomap_iter_advance() directly instead of `goto done`
   as suggested by Christoph.

 fs/iomap/buffered-io.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index d52cfdc299c4..814b7f679486 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -372,9 +372,14 @@ static int iomap_readpage_iter(struct iomap_iter *iter,
 	struct iomap_folio_state *ifs;
 	size_t poff, plen;
 	sector_t sector;
+	int ret;
 
-	if (iomap->type == IOMAP_INLINE)
-		return iomap_read_inline_data(iter, folio);
+	if (iomap->type == IOMAP_INLINE) {
+		ret = iomap_read_inline_data(iter, folio);
+		if (ret)
+			return ret;
+		return iomap_iter_advance(iter, &length);
+	}
 
 	/* zero post-eof blocks as the page may be mapped */
 	ifs = ifs_alloc(iter->inode, folio, iter->flags);
-- 
2.43.5


