Return-Path: <linux-fsdevel+bounces-43304-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9247AA50CCC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 21:48:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 825EA189321B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 20:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E8C257AF5;
	Wed,  5 Mar 2025 20:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="shuKo/cN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4EBE2571B3
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Mar 2025 20:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741207663; cv=none; b=i4n6m8/KwwZjwDOJ1+9VtJ7WzrDdgiRg8/TmHaSAB5k1EgWPOf+r8wyNLEbS09IhREpNNqFAnabL7hL5cPUoty0p5e/k7tdAJB/nmbux9bu69UVBt32y1AU9AaGGU5sgYn7+d50/nVlO2xjXMTlC8JQ1TP1jSZtnZYmWi2uCqDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741207663; c=relaxed/simple;
	bh=H7Z7ritYcj8LHqWqd2JE1MWZodI9cbZE/VlDkNbNAQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PlGYiShTRmhis/IoUvcdM7n1EKIhOqWuX/fES4MAZYq5/JxkLHdTUUL1Sbpi1uX+2KZS9V1ZdQrzjJFhJXptluP8fo5Pn3co2Dz1pxcXBlc0o8n0yCcgLjQa62N1oINxAIcbm5qmHwosg0g56f/YFKshfolO72ZHdJdSCZ/3Yuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=shuKo/cN; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=47d4BYLDfR0fIjbv5YFWD63SrofnqHiMYToK5cQd6ss=; b=shuKo/cNlKLLdhkZqljT8g33Ie
	Zllm6a6zmegMieh6WoFHXinPJyi1icC6LULoPpqq0AT4sleu8+NegwDgsq2v1uvMPeWVyDSW6CnKk
	qkYU1KWmolvnPFxZr4768CDbE/4hglQP86DbQEyb/OnYq7IYfv5l+zTT2y7Y4H8DZNyPpOuiDhT0c
	AEWqCUqbIe3y0vB8F8A0uMom5Eg7ppSkaeiveO8aISnDEkwY74Z/gDwL3h/zX/1moW6uaZtzmICEZ
	C0qHY1PRPePip+AcW35srsAy425BAyBREyQOg53836jLo/HefhoIblgAXa8e2DBkstJzdvlbKbzjN
	Zg+KYrNw==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tpveS-00000006Bmu-3zus;
	Wed, 05 Mar 2025 20:47:36 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	devel@lists.orangefs.org,
	linux-fsdevel@vger.kernel.org,
	Mike Marshall <hubcap@omnibond.com>
Subject: [PATCH v2 1/9] orangefs: Do not truncate file size
Date: Wed,  5 Mar 2025 20:47:25 +0000
Message-ID: <20250305204734.1475264-2-willy@infradead.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305204734.1475264-1-willy@infradead.org>
References: <20250305204734.1475264-1-willy@infradead.org>
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
Tested-by: Mike Marshall <hubcap@omnibond.com>
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


