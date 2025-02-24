Return-Path: <linux-fsdevel+bounces-42479-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB212A42AA1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 19:06:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCAAA17534C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 18:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69546265CBD;
	Mon, 24 Feb 2025 18:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DOsV9C8I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06609264FAA
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Feb 2025 18:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740420335; cv=none; b=WXdiYA11iIN75rvy0pTobK1caN+bjfFkgEG5MVABh+yeVna51iuCwkLzppPFlxBYlcm4jG38DtgF/xHIgFi8dLBCvywS4cO6cYR6FEhWnM8APz2IoiwWQM/nyv9HpiACUhU8tWG9Fqo/ZCYBxSJ06DNz0VCrHY8ICKRRq/VqM1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740420335; c=relaxed/simple;
	bh=R0dFX8aGvD8lTsbxLG7DSgk52hOFwTkt2d4BM+KmYUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c+dXZNXTTJKtKIG1rVS9mWAtPNxekcnIGQcvmhysqZsz+DSWz59v6i/VunEpCMKR4QerfXIum2wRKjkNiAuqiO3QXbmS5TWmwGQ20ngWry1HF026VCYk3mEzW6CY/ar+SH9RXsJCvrVMRxbfL0IEt59NcT9w1xjgf9pWkfeBOaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DOsV9C8I; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=fGdlyVYDMumMq+9YIKbJRDyOw8g/4g49JLP3XmkSAaw=; b=DOsV9C8Iy/c4iIhe2XyAUytMLv
	vPy4Y57Rj2BYkPguXaMAb2hIwnyqLCtkjFwtalk4yRr87ff1A9JDBYcHnq2heb4wi3/Io5jFUxju+
	ERW8DDgYdPeWP9nSJgj/DNjngWlNos/hrSQ1FX+osREQrLLViheSF4sRmvHFX/anYkLbeOBhhIczW
	i6H6Dx/Wr52cINjogZlArooeuChzzrkQIni9Tv5O1kUQgjbBn6PN5yUnWFoslWeKVcqmsYkU4ctsw
	vWDo4zlVtAMK7YN0xInRXzvzSmi6EyGJu7eZmoR/gq8iSF61tOKwszBCnQKDVwPtw0gG89X63gG5B
	t7UTfeZw==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tmcpg-000000082fi-0R53;
	Mon, 24 Feb 2025 18:05:32 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Mike Marshall <hubcap@omnibond.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Martin Brandenburg <martin@omnibond.com>,
	devel@lists.orangefs.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/9] orangefs: Do not truncate file size
Date: Mon, 24 Feb 2025 18:05:19 +0000
Message-ID: <20250224180529.1916812-2-willy@infradead.org>
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

'len' is used to store the result of i_size_read(), so making 'len'
a size_t results in truncation to 4GiB on 32-bit systems.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/orangefs/inode.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
index aae6d2b8767d..63d7c1ca0dfd 100644
--- a/fs/orangefs/inode.c
+++ b/fs/orangefs/inode.c
@@ -23,9 +23,9 @@ static int orangefs_writepage_locked(struct page *page,
 	struct orangefs_write_range *wr = NULL;
 	struct iov_iter iter;
 	struct bio_vec bv;
-	size_t len, wlen;
+	size_t wlen;
 	ssize_t ret;
-	loff_t off;
+	loff_t len, off;
 
 	set_page_writeback(page);
 
@@ -91,8 +91,7 @@ static int orangefs_writepages_work(struct orangefs_writepages *ow,
 	struct orangefs_write_range *wrp, wr;
 	struct iov_iter iter;
 	ssize_t ret;
-	size_t len;
-	loff_t off;
+	loff_t len, off;
 	int i;
 
 	len = i_size_read(inode);
-- 
2.47.2


