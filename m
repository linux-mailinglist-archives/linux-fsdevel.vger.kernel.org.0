Return-Path: <linux-fsdevel+bounces-44398-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A81A5A68364
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 04:00:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3BB817F7FF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 03:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88C6F24E4C3;
	Wed, 19 Mar 2025 03:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="L7cnJjrH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04F324EA92;
	Wed, 19 Mar 2025 03:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742353215; cv=none; b=njrH13OjnkMmeqCxgWTyrd61FDZmzGomdlRQ0PbRdu07Oxe0PXPSG7/Ov8blV3t2Yn7j1+4a6NA74erRXb7VbFwoXpiJgRvmrxh1KeP0dMPUB9/lOw7L2ak6k8Ejo2wyg64Qqv4p+7/trLDmZRNMdubAC1qO72+APTreEuZcK5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742353215; c=relaxed/simple;
	bh=2LAHDm5a9kiQId0Ehu1siqrV+XlXNO/nld7/RHZmQ0U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Hjb0nA759cjzK+c/cKiZV1jYO6oae6JFe3Ww1LMgAO9BJAyLBu3NEQbZqhv3SioKjuZW/dCXsIhTgd5hWIYkX9ux7mLja64unDHk5uOg0pLgmz8LRlqmVehR4KnkKbRLwNDpvf2AzvxWph/joT9MNEDbyX47sS+/9QEmlBpUUwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=L7cnJjrH; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1742353200; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=VUPAqvDxo94oQ2Yp5DEmT3wiJN+0p+J2Q0KkA4Qbhbg=;
	b=L7cnJjrHc0YiF9gAEncFI7S/2h8W/bs3hSuDzAMTQ4WPqi3qB9FHjH4UsHIIA7Enqy7gDq7iHQGlearmxzeJiSk3DCW1sSn7fA6EY7HN6Zqejx1JfVyY9CMWGWLRU+XQ5RZx/6siYGtf07VFT75fycqciSgjdBmLzCOg+J5r9WE=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WS-6Nzc_1742353195 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 19 Mar 2025 11:00:00 +0800
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
Subject: [PATCH -next] iomap: fix inline data on buffered read
Date: Wed, 19 Mar 2025 10:59:53 +0800
Message-ID: <20250319025953.3559299-1-hsiangkao@linux.alibaba.com>
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

Reported-by: Bo Liu <liubo03@inspur.com>
Fixes: d9dc477ff6a2 ("iomap: advance the iter directly on buffered read")
Cc: Brian Foster <bfoster@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/iomap/buffered-io.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index d52cfdc299c4..2d6e1e3be747 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -372,9 +372,15 @@ static int iomap_readpage_iter(struct iomap_iter *iter,
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
+		plen = length;
+		goto done;
+	}
 
 	/* zero post-eof blocks as the page may be mapped */
 	ifs = ifs_alloc(iter->inode, folio, iter->flags);
-- 
2.43.5


