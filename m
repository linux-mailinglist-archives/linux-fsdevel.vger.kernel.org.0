Return-Path: <linux-fsdevel+bounces-29350-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9078978759
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 19:59:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90CD61F2667F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 17:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E8B12AAC6;
	Fri, 13 Sep 2024 17:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k3D4ZF0j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81BD643152;
	Fri, 13 Sep 2024 17:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726250356; cv=none; b=t8hvaTvq7ieqYV/SEBGdIe2sJtTxWoAL9AZ8N86o9n/+JFF9MaEQjAGNqpZzf+fo2p6cgHH0Foxdrd54GQVCraYOMg58j9Gk9K4/RNlJ02kA/Bx8NkCDs166XH5FtwypWEE03jPm3J5IeumLjWTrfeOBiK4nZJIYKzg7howUZD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726250356; c=relaxed/simple;
	bh=ReMu8uUce17SN9AEOfc2Sg0uemsEQKc6Yf3l3DFQMUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=da2IfnEgQQyALR6OymhegfJVGkR6Q8E+8VJnKc8Z85WbM5dfUaZQHvBLBzSzeJstK1FgscNLX8inynvPYxkuKtEhREn7wemaJS1LxODbWMBgflLWfbbcuToz1O/gB936aMtP9PmOMg0lnjU0NbXMBYxGbAAwlUulvJAgYCT1ySQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k3D4ZF0j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99B26C4CEC7;
	Fri, 13 Sep 2024 17:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726250356;
	bh=ReMu8uUce17SN9AEOfc2Sg0uemsEQKc6Yf3l3DFQMUQ=;
	h=From:To:Cc:Subject:Date:From;
	b=k3D4ZF0jmfUGfE2hzdxCegRqxR0rgg5/iHPCwpYfwlXnzz1GhFcrym9ogl9jM72ms
	 lt7ryJ88hmdxZ6VXVXdVa59RM5UpXbRvlE8Gr2f6eEFUgqtHjwixXt1G2ApKSa01fd
	 p6hs7QXkSy00KZqvaB3R+QrR4ZkSndz/DBvoTXpUrLjg2FHMNhj70FJ5wyN+Dmo0ov
	 CEgIF1oiU/0+dOWxAOQYQuOFItOSX3QeZLfjT3guaQeS5A+0xQZ3tyVKDAXy0O8qYs
	 jq/UBE5ulk04FFa+9XB9K8+2C9w05RxHt9ecznuvyTfHFL3x7oEgBhoJwWJMDBwDpA
	 D23vqJCFKmQsg==
From: trondmy@kernel.org
To: Matthew Wilcox <willy@infradead.org>
Cc: Mike Snitzer <snitzer@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org
Subject: [PATCH] filemap: Fix bounds checking in filemap_read()
Date: Fri, 13 Sep 2024 13:57:04 -0400
Message-ID: <c6f35a86fe9ae6aa33b2fd3983b4023c2f4f9c13.1726250071.git.trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

If the caller supplies an iocb->ki_pos value that is close to the
filesystem upper limit, and an iterator with a count that causes us to
overflow that limit, then filemap_read() enters an infinite loop.

This behaviour was discovered when testing xfstests generic/525 with the
"localio" optimisation for loopback NFS mounts.

Reported-by: Mike Snitzer <snitzer@kernel.org>
Fixes: c2a9737f45e2 ("vfs,mm: fix a dead loop in truncate_inode_pages_range()")
Tested-by: Mike Snitzer <snitzer@kernel.org>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 mm/filemap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index d62150418b91..c69227ccdabb 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2605,7 +2605,7 @@ ssize_t filemap_read(struct kiocb *iocb, struct iov_iter *iter,
 	if (unlikely(!iov_iter_count(iter)))
 		return 0;
 
-	iov_iter_truncate(iter, inode->i_sb->s_maxbytes);
+	iov_iter_truncate(iter, inode->i_sb->s_maxbytes - iocb->ki_pos);
 	folio_batch_init(&fbatch);
 
 	do {
-- 
2.46.0


