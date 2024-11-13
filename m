Return-Path: <linux-fsdevel+bounces-34603-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B16B89C6BCB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 10:48:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 754B9285B2F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 09:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72ACD1F8927;
	Wed, 13 Nov 2024 09:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YSX0EDzr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4477F1C8FBA;
	Wed, 13 Nov 2024 09:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731491254; cv=none; b=AD4y7gDK/VDmnlo/Sf8G1aAYO0+i1Pb8fkDqu+/bL5VlALeWsNoymO9/vfSErLrRH0IYuHN1ltsdUVsetLHZs7ryZ+2xmTw58RO7QZ6QhN2mq8qVB8xzgXEQLdQYbRW7dFCQQI/nSB7Uc4jBrQkl4ZwoLgvF6LP0Qy0VgQVfR1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731491254; c=relaxed/simple;
	bh=wS+/cGLI44mDGdqsudEsCfMaSQKgxAkLCT0FDr27JuU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pBH52RRkA662UoUaf5XUIowR6LF7l4vVnTR0kIAsk4ooOOvasquPNutrn+KRXdFgksD/aO/U/Rtne7ffDkDYyecQIhhVrGcN6XdiSqKnUOCQB1srrOpV61F238JZSO2ZhcZKcbeLjscp1QAEjQ1AN66vwpF5fiZI5XdaxWIbwdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YSX0EDzr; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=v1hn7jTllJt027wi2EuYKy1M6kMpA7RumaYFxoUC1HI=; b=YSX0EDzrzBi3K2/pJrtGXF24rp
	j5lTJasVr/P+LgtwWwKhkLU3mFJWGb5hV/WXVdYOUwsLgkXNwyLSdVgvVO4wqyBeloxb+0bvEsNCb
	Eu77MWXLhodY7x6GMPFW/SWXeg7lLivHqER9vaEW3oxTzjyTCp6H+QjoFBttZ2DQQkRARJAc3YN4s
	5HCgwoq3AzrQSx3auSaBCAY87O/ctCESb9Cyc3bpqH5LFKPlJ9qVhk4ct8rPZ2+w+YYoknajjiQLW
	5zroffNYSZLnWg5waH9jvnppvowXI7VxdoQPuEHaRLHJKDdKNtJUXvgQ3OjTm3owb639om+aPIJCv
	Zg+yBSZw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tB9yD-00000006Hd9-0Sue;
	Wed, 13 Nov 2024 09:47:29 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: willy@infradead.org,
	hch@lst.de,
	hare@suse.de,
	david@fromorbit.com,
	djwong@kernel.org
Cc: john.g.garry@oracle.com,
	ritesh.list@gmail.com,
	kbusch@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-mm@kvack.org,
	linux-block@vger.kernel.org,
	gost.dev@samsung.com,
	p.raghav@samsung.com,
	da.gomez@samsung.com,
	kernel@pankajraghav.com,
	mcgrof@kernel.org
Subject: [RFC 4/8] fs/buffer fs/mpage: remove large folio restriction
Date: Wed, 13 Nov 2024 01:47:23 -0800
Message-ID: <20241113094727.1497722-5-mcgrof@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241113094727.1497722-1-mcgrof@kernel.org>
References: <20241113094727.1497722-1-mcgrof@kernel.org>
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

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 fs/buffer.c | 2 --
 fs/mpage.c  | 3 ---
 2 files changed, 5 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 818c9c5840fe..85471d2c0df9 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2377,8 +2377,6 @@ int block_read_full_folio(struct folio *folio, get_block_t *get_block)
 	if (IS_ENABLED(CONFIG_FS_VERITY) && IS_VERITY(inode))
 		limit = inode->i_sb->s_maxbytes;
 
-	VM_BUG_ON_FOLIO(folio_test_large(folio), folio);
-
 	head = folio_create_buffers(folio, inode, 0);
 	blocksize = head->b_size;
 
diff --git a/fs/mpage.c b/fs/mpage.c
index ff76600380ca..a71a4a0b34f4 100644
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
2.43.0


