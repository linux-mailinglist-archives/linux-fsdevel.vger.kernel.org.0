Return-Path: <linux-fsdevel+bounces-32882-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9DBB9B028B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 14:37:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 959531F21375
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 12:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED6291632FE;
	Fri, 25 Oct 2024 12:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iss3mZpg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AAF61632EB;
	Fri, 25 Oct 2024 12:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729859791; cv=none; b=K3g/d5N0I0q9ZVQBve6FnC7ixankBV4cGCGjPQoeVR2/L9x4t7E6h/B+Gq1Nu+tw2FLkZCHa79u7EAEyal8GHRYgGnIJ83AUXhgyt3EoOXZ361K7muEiHMf5jrg67MvesF9YymQeJdAy8W4Rt8Eh8CbzmeMxBRT4Yt/Pznup95U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729859791; c=relaxed/simple;
	bh=sn61wLRI7aLXcHRryi1e44WKfyUTasibTfq0nIDlyvA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Cl0UDZt0xXUtOktvehJGW/7qVe5joxsT6WpECYvG0c6mlW1LEeq2g77cqVjf7qMp0/0/UjLjv3+8eNi8hqGqKrDcrV/z1ILJOKy1tvRYshwW+LW/Ur1anNwyd/qTcGwg2zWLh33u/wcnFNSsGT2RjTl0ZmRWthYLcug9i1UNNqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iss3mZpg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34228C4CEC3;
	Fri, 25 Oct 2024 12:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729859790;
	bh=sn61wLRI7aLXcHRryi1e44WKfyUTasibTfq0nIDlyvA=;
	h=From:To:Cc:Subject:Date:From;
	b=iss3mZpgyC3519tGwaL4l1QjFvzDXUNW044392mgVHm9Re5N+kePakhXcyVYBzpix
	 MsUOuDOQ1A7i0CPtDM/jHS57uLa+gvf2t6srbFROmSWyPJTUCp4ORDT2Wuk1llWhvT
	 2MrH7/X4wjZoTIvzc9cX+zRWRcEhw2Jbz1PigRCzctsMEJ9Vd3534BaeLTcdDOymDk
	 T7M4K6arsmS0BudDJ3zCjtk9Dl5fink9CbER/GYa1AbUud6OIWY0zrc6DZ6O63Ze9q
	 +nMzWZP6NMr0JHOOb194I7znJPwHQQ12aNrpLYCungMWNpSYBhoZJQGTRR6xnvPFPZ
	 kM/qzGO8M/UoQ==
From: trondmy@kernel.org
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org
Subject: [PATCH RESEND] filemap: Fix bounds checking in filemap_read()
Date: Fri, 25 Oct 2024 08:32:57 -0400
Message-ID: <f875d790e335792eca5b925d0c2c559c4e7fa299.1729859474.git.trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.47.0
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
index 36d22968be9a..56fa431c52af 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2625,7 +2625,7 @@ ssize_t filemap_read(struct kiocb *iocb, struct iov_iter *iter,
 	if (unlikely(!iov_iter_count(iter)))
 		return 0;
 
-	iov_iter_truncate(iter, inode->i_sb->s_maxbytes);
+	iov_iter_truncate(iter, inode->i_sb->s_maxbytes - iocb->ki_pos);
 	folio_batch_init(&fbatch);
 
 	do {
-- 
2.47.0


