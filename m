Return-Path: <linux-fsdevel+bounces-42483-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EA50A42AA5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 19:06:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1498F175E28
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 18:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E1DB266193;
	Mon, 24 Feb 2025 18:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jdlvvFO1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B4E1A9B3E
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Feb 2025 18:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740420336; cv=none; b=uN+cZCCk6TPS8DaEYZYczNZUIU/H0KeZbUcbrsDauKRyUBJ/5zRZDAPTPr/km7Ab5QNmDzsoRvaeLZibr2pqfdmkyy9gAcZibjqnNyfIMrwEaqB4uqUNC8q7ssxsw6hlx/MfiYLEc0EoEz1Qb/IBb1qSODYOXNF9vlTVrePZ/TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740420336; c=relaxed/simple;
	bh=m/TXcZ1V9wYUyjZBf3CXJr6nC+rAS+lRsSc7xWKjBII=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=olppA3ud8eJnUCQHJk0KXJo47kMkiH/CEoHL0WK87eF0GxhV5UybivdQ1AEq9C6hjKdELSigWsEPfxLphb8OEWBhryYaGd/rJWkZj7YlBUnD43zRPZuOzNdn3EdJxC4NhbeSvQUek9UAa2nnLXOajaiRVAVzTKxyAQHWvMGPEEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jdlvvFO1; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=QymmzXHWBBhY2HLBjynD7lTm4KzCL4NRO6RJcLeQ2VU=; b=jdlvvFO1AhS6sIDuPlqgCJCv8G
	SYChc+fKVmV+1FroKqpIiSl5ZJVTARmPbrvDPCOp7WFlnKJZtQn0b7816okIXPcntPJruraboNd+k
	uOSYRYs7HXhkbqhaUz1BSd4xkExQi+bRkOAJI+ZgTOR7rCdos/wPtIYGdMRmZpZaJn5paDwJkHouC
	m6AeHYf8vLHZ6fosfKtuccBBNv1qeFJV5FdhNxoEs77x+Y9m+bGe9DAspnStILEaFo2g/gbpBAw0a
	n3eZHDaq+pFe1IWzBDuuaYyxJgkMsjuUztQSYtKtDZV5/zkQalvstHAOwxGMwhGNosk8fbyza/8Vw
	R+L3xkug==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tmcph-000000082gN-0MDY;
	Mon, 24 Feb 2025 18:05:33 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Mike Marshall <hubcap@omnibond.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Martin Brandenburg <martin@omnibond.com>,
	devel@lists.orangefs.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 8/9] orangefs: Simplify bvec setup in orangefs_writepages_work()
Date: Mon, 24 Feb 2025 18:05:26 +0000
Message-ID: <20250224180529.1916812-9-willy@infradead.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250224180529.1916812-1-willy@infradead.org>
References: <20250224180529.1916812-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This produces a bvec which is slightly different as the last page is added
in its entirety rather than only the portion which is being written back.
However we don't use this information anywhere; the iovec has its own
length parameter.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/orangefs/inode.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
index 927c2829976c..7b5272931e3b 100644
--- a/fs/orangefs/inode.c
+++ b/fs/orangefs/inode.c
@@ -83,18 +83,18 @@ static int orangefs_writepages_work(struct orangefs_writepages *ow,
 	struct orangefs_write_range *wrp, wr;
 	struct iov_iter iter;
 	ssize_t ret;
+	size_t start;
 	loff_t len, off;
 	int i;
 
 	len = i_size_read(inode);
 
+	start = offset_in_page(ow->off);
 	for (i = 0; i < ow->npages; i++) {
 		set_page_writeback(ow->pages[i]);
-		bvec_set_page(&ow->bv[i], ow->pages[i],
-			      min(page_offset(ow->pages[i]) + PAGE_SIZE,
-			          ow->off + ow->len) -
-			      max(ow->off, page_offset(ow->pages[i])),
-			      i == 0 ? ow->off - page_offset(ow->pages[i]) : 0);
+		bvec_set_page(&ow->bv[i], ow->pages[i], PAGE_SIZE - start,
+			      start);
+		start = 0;
 	}
 	iov_iter_bvec(&iter, ITER_SOURCE, ow->bv, ow->npages, ow->len);
 
-- 
2.47.2


