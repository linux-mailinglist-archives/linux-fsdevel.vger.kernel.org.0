Return-Path: <linux-fsdevel+bounces-41683-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CEEAA34DCF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2025 19:37:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45C7B188F12D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2025 18:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81DA124503A;
	Thu, 13 Feb 2025 18:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fkvN5jxq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC56E241691;
	Thu, 13 Feb 2025 18:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739471863; cv=none; b=NByIe1v67lrB/OZTa3zMeyqqKBF78F/B82ySDMBeVENfIETqzh5fEmRma9G//JWkUmPX4layWXou4w0hX6z8nJRdWZHDE0RMk8qfZ7IvGzGRUDD6DQTlTf2caO+pFXqfreYGxEIlYXHSgAJ04Jg45NH43x7bsg1yUCH5nODBEfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739471863; c=relaxed/simple;
	bh=yBr5n64/ykMjm6l699ntGDgQuyR6cT5PkvcbbqbzmQo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vC0lbsUbaHyMeI2E7XxgzK6xQJvDAM9mr0oxsQ3vSpXxG33psnjbAYGrUUgtqEg2RvN7kWWOYn83SgqkU9FXhUYnLmS3jEC5ktfzwHT82BPWdptt4RHnHi7CRsjHE4Kfse4p2JiOTKvZXrdDrbu7zkgX4aql9J30DNJHsq/UIpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fkvN5jxq; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=p9WBGnIqtnFeSuvIK0AsG0uMMrdub4bF1vsPcqX4HAQ=; b=fkvN5jxq5sMCEWgTFylh/NIM5m
	nN31gfLpAzX2HoHocMzez1CE9No45SC0wV5z7A2uq3wzylvtMxGteB9/cnmUfU34R1hXTF457jpWT
	bXNaDvnOnzxpg1etS0Eyp/HO9e7IEIO24PCjD6L5PRItwnUmsonpUUO8qB2fq4o9VzGV2tURCre+Y
	nYsPV4lYgCcvWjG8i5MIomrviU8ux+nHhJGVsyUgSo85yMKKBW06MHMEKWK7OjL1uolFCNtnxYZU7
	3yoenr5ZW7YSfAkZPs0A3OOKkf/jdT2d1igXBBPDWlw9Wbq8qIiY740lIPKIgO+bKy0UxOkHea+EI
	D6Y4K2IQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tie5f-00000008z7m-0MWa;
	Thu, 13 Feb 2025 18:37:35 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Mark Tinguely <mark.tinguely@oracle.com>,
	ocfs2-devel@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/2] ocfs2: Remove reference to bh->b_page
Date: Thu, 13 Feb 2025 18:37:28 +0000
Message-ID: <20250213183730.2141556-2-willy@infradead.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250213183730.2141556-1-willy@infradead.org>
References: <20250213183730.2141556-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Buffer heads are attached to folios, not to pages.  Also
flush_dcache_page() is now deprecated in favour of flush_dcache_folio().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ocfs2/quota_global.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ocfs2/quota_global.c b/fs/ocfs2/quota_global.c
index 15d9acd456ec..e85b1ccf81be 100644
--- a/fs/ocfs2/quota_global.c
+++ b/fs/ocfs2/quota_global.c
@@ -273,7 +273,7 @@ ssize_t ocfs2_quota_write(struct super_block *sb, int type,
 	if (new)
 		memset(bh->b_data, 0, sb->s_blocksize);
 	memcpy(bh->b_data + offset, data, len);
-	flush_dcache_page(bh->b_page);
+	flush_dcache_folio(bh->b_folio);
 	set_buffer_uptodate(bh);
 	unlock_buffer(bh);
 	ocfs2_set_buffer_uptodate(INODE_CACHE(gqinode), bh);
-- 
2.47.2


