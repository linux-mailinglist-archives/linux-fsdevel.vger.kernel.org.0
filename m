Return-Path: <linux-fsdevel+bounces-42319-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 650E0A402DC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 23:39:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BA873B42AA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 22:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D7DC2566CF;
	Fri, 21 Feb 2025 22:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fNM7nLrE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38F320766D;
	Fri, 21 Feb 2025 22:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740177512; cv=none; b=M3CTHvDMNBoIZH0Zaj9xzfAOHR10IggwEj4Z41bZGqmXKLmm+cav+/irxPj74UqbXLAhFEuGao3VOzFQFDx9AlPIoL4I8VaZsxOFYAaDkdSRUFgf3ysAP5wz8IRPSQ8yEeyWaPXZht58o16TjFSgYmBNuH5FkwBFRrVPFwEq6KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740177512; c=relaxed/simple;
	bh=wWfr49DKRm/B+SXkMQ63cMJsOmEaf6hhkzN7xVPhKwA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iHsfkV+3TyOQStoZ4OTcpgmMeS0gicrbPn0jZTabH+eiIlLKjSLPNLoIMiX3NsUV9EbxikvGoEqodJ8QeLfs+JdQLrrvYA2GdFmdPxGM/HhOvxmBW6PvjgV3xW0SidI+2S5VgvHdaK+ZKQFFZvHtiQHXTbS2c4AVd0vv9yyoN/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fNM7nLrE; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=rJT3XHCnmeFYD6/zws/j5/iie6UCiOo1LUIbVleTx0A=; b=fNM7nLrEP3BEk0dY3WSxjlab7o
	6lNb3AIH3BFvSoLugZ4WNdP7IG8Cg8W2ch0jq0AhMywPJKPaiogqFwSJZ0ECdy04X3UTKESBvU3PK
	JLx5CfzV5CaKjs818jt1jtN+H1FfwqHJX8EgMqHeh9vUT2+WlVUy1uNkgTfJ1gfYl0+3CcDLUxUUM
	qurRxxCwJtcyZ6hdL9364M+WTQuluLk41RQbAQkWKGiYdDig5Ixpr43QFsEpKnObdxnu1YrnaG8US
	RCV/7DPIvZHWOrh2rN57C9HA5SQCON7LK59aMOl8vXC4bqPmhEug6c9iaai5HcqdDKE0ssxa0/RZY
	ckh02Tog==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tlbf7-000000073DB-3iIF;
	Fri, 21 Feb 2025 22:38:25 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: brauner@kernel.org,
	akpm@linux-foundation.org,
	hare@suse.de,
	willy@infradead.org,
	dave@stgolabs.net,
	david@fromorbit.com,
	djwong@kernel.org,
	kbusch@kernel.org
Cc: john.g.garry@oracle.com,
	hch@lst.de,
	ritesh.list@gmail.com,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-mm@kvack.org,
	linux-block@vger.kernel.org,
	gost.dev@samsung.com,
	p.raghav@samsung.com,
	da.gomez@samsung.com,
	kernel@pankajraghav.com,
	mcgrof@kernel.org
Subject: [PATCH v3 5/8] fs/buffer fs/mpage: remove large folio restriction
Date: Fri, 21 Feb 2025 14:38:20 -0800
Message-ID: <20250221223823.1680616-6-mcgrof@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250221223823.1680616-1-mcgrof@kernel.org>
References: <20250221223823.1680616-1-mcgrof@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>

Now that buffer-heads has been converted over to support large folios
we can remove the built-in VM_BUG_ON_FOLIO() checks which prevents
their use.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 fs/buffer.c | 2 --
 fs/mpage.c  | 3 ---
 2 files changed, 5 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 167fa3e33566..194eacbefc95 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2371,8 +2371,6 @@ int block_read_full_folio(struct folio *folio, get_block_t *get_block)
 	if (IS_ENABLED(CONFIG_FS_VERITY) && IS_VERITY(inode))
 		limit = inode->i_sb->s_maxbytes;
 
-	VM_BUG_ON_FOLIO(folio_test_large(folio), folio);
-
 	head = folio_create_buffers(folio, inode, 0);
 	blocksize = head->b_size;
 
diff --git a/fs/mpage.c b/fs/mpage.c
index 9c8cf4015238..ad7844de87c3 100644
--- a/fs/mpage.c
+++ b/fs/mpage.c
@@ -170,9 +170,6 @@ static struct bio *do_mpage_readpage(struct mpage_readpage_args *args)
 	unsigned relative_block;
 	gfp_t gfp = mapping_gfp_constraint(folio->mapping, GFP_KERNEL);
 
-	/* MAX_BUF_PER_PAGE, for example */
-	VM_BUG_ON_FOLIO(folio_test_large(folio), folio);
-
 	if (args->is_readahead) {
 		opf |= REQ_RAHEAD;
 		gfp |= __GFP_NORETRY | __GFP_NOWARN;
-- 
2.47.2


