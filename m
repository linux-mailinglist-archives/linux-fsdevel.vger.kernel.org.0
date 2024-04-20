Return-Path: <linux-fsdevel+bounces-17341-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED33C8AB8F8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Apr 2024 04:52:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB207280FDF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Apr 2024 02:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF6CB179AB;
	Sat, 20 Apr 2024 02:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EtAa4y1y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B431758C;
	Sat, 20 Apr 2024 02:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713581460; cv=none; b=qI04bhINv81VQYZ1n+mq5W0O0mq+hy2/2rW35G2eOnMg3gMEJ4DoAWgH9vYIfL1wYMExK0LMSHeOlQgYio+YalFkFilCCnM+ITeMT6ychb/llTpWSthXJ1mJrBG/s2SeXy83oWZrJlur4yB0Odpy0YB9il0FP95mIS/NHDgWmLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713581460; c=relaxed/simple;
	bh=MNGQdCHzW25/+wHhXwXH/NMqYp82RBGV7NnH0nnxDOs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p3ktFgMiQKwAb5RL9yG+kMsCqVbK+YFfOJr3s1EJ30YwHULbvBT4g/U3QgexoMJz9Ibv2QkW8vxfgLKRMWDtBhVAB194ccx6pBTc45pSzYp2KjNX/0Kpw7XMF4syKEle+LNHIvsP30EIHbLQyUIi/YNFpCwpRurpCbr9QLqr0oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=EtAa4y1y; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=sKwEaDMykkWblPGLhfvrNLPmAWo/K3PNSs0OffOfMK8=; b=EtAa4y1yR6TJYpH8imzwFAjDLY
	MJeab18QUoywR2LAOQ0hU5sraZ21/85GG3H0cyGiNFNzXgIhUtXeKheylmMWa0SZ3NuioxS0/ICn/
	kQfxrhBCSZ481qcZ00WQtW4JGTXCqz3qp+tmEi7DNfiQiS13lA/hIYlK7mJDOPI45lQlZn7g1d4qW
	OklBbpTCXBqGYqCNxtDWguw6usp6Ls18o3hkkexexZXxb0Oui9/iOZJXPZJ0ZBoKw/W86oylFaOQ/
	PoyJNmDrwuQ0JHAwkciyNtzi+s6cnFYSNzt0iJyAW6I8QAbUuIQkDxRqWxZEOZ1CSQp8Yqtf13rMQ
	ek51IygA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ry0oZ-000000095fy-3vKs;
	Sat, 20 Apr 2024 02:50:56 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	reiserfs-devel@vger.kernel.org
Subject: [PATCH 19/30] reiserfs: Remove call to folio_set_error()
Date: Sat, 20 Apr 2024 03:50:14 +0100
Message-ID: <20240420025029.2166544-20-willy@infradead.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240420025029.2166544-1-willy@infradead.org>
References: <20240420025029.2166544-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The error flag is never tested for reiserfs folios, so stop setting it.

Cc: reiserfs-devel@vger.kernel.org
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/reiserfs/inode.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/reiserfs/inode.c b/fs/reiserfs/inode.c
index c1daedc50f4c..9b43a81a6488 100644
--- a/fs/reiserfs/inode.c
+++ b/fs/reiserfs/inode.c
@@ -2699,7 +2699,6 @@ static int reiserfs_write_folio(struct folio *folio,
 		}
 		bh = bh->b_this_page;
 	} while (bh != head);
-	folio_set_error(folio);
 	BUG_ON(folio_test_writeback(folio));
 	folio_start_writeback(folio);
 	folio_unlock(folio);
-- 
2.43.0


