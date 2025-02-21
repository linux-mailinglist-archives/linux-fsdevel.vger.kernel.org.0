Return-Path: <linux-fsdevel+bounces-42313-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D4FDA402CF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 23:38:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E6EB3B5472
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 22:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DED7E253F1B;
	Fri, 21 Feb 2025 22:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QjrfoaCI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA69D1FF612;
	Fri, 21 Feb 2025 22:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740177511; cv=none; b=kABLXl0pFKC3s9TZi7dNZ7dNQ8pn4ohjLLDti7G8Jl1sV5bOw3bZsxr65t+3XA/qcvU7upJroB7eSw1EJ03ySv46qSRMPv4FRj83WOFE0/Ph/odtfxp1Df41H877N28B0jMmbo70JXTYkGNc2amxb5ACbinCDuUprVJogFkq9uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740177511; c=relaxed/simple;
	bh=SUSEWwwPXKlY38GdAKi9a07ZmDy4DSycjiy6IDA8QGw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KsDd2CLxODm/8pg8EHGG3dTt6SZpdz7inyeRMXbGZhstTF+b8/TcYwsGnsUWGHeU+j5Niamyxh4SW62LmIv5izoWWtWYjOBJtk0aLMQLjq/STvNqUG6DEEwijp30tX31IM4fq93v76W3uPj+aSFeFO3cos72R2UF8ciBH3L49Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QjrfoaCI; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=9SL9dFZnxTYWHIK0ELgxGzaHF/BgeRzk+6m5RMpyXOQ=; b=QjrfoaCIfvDWXPGcUb8l9WbJQ1
	ILfiLiecFwoGMbekJ5E0Q7wwhRpMhxjYb5SKNf2xsEiUlNCS7n9rJ4tOlO07A3uRPG7Vz7geVOVdD
	sWwDNoOweGQt0ze4/euWidilzry8UydBfqH5T2mvoRkCIz2VF9w5HUbvQoZ3ZB9/Uj40SlikgLFbX
	lkc8xCuyU6zLVLVjuArqQ+JpTriOEsDSpL4SWQLMX/p9ONXK0qYirstmus9XW5ZKfDl2PvGkdB7m4
	l1I+Wzs0gY4t8f0ujfCjIcGUz7s0mBQAN+5zV5BAgWH81wGS7jKZzjClWHNEJ2UWran++CHIpmSfC
	ZlW1ekFw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tlbf7-000000073D0-36QQ;
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
Subject: [PATCH v3 1/8] fs/buffer: simplify block_read_full_folio() with bh_offset()
Date: Fri, 21 Feb 2025 14:38:16 -0800
Message-ID: <20250221223823.1680616-2-mcgrof@kernel.org>
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

When we read over all buffers in a folio we currently use the
buffer index on the folio and blocksize to get the offset. Simplify
this with bh_offset(). This simplifies the loop while making no
functional changes.

Suggested-by: Matthew Wilcox <willy@infradead.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 fs/buffer.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index cc8452f60251..b99560e8a142 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2381,7 +2381,6 @@ int block_read_full_folio(struct folio *folio, get_block_t *get_block)
 	lblock = div_u64(limit + blocksize - 1, blocksize);
 	bh = head;
 	nr = 0;
-	i = 0;
 
 	do {
 		if (buffer_uptodate(bh))
@@ -2398,7 +2397,7 @@ int block_read_full_folio(struct folio *folio, get_block_t *get_block)
 					page_error = true;
 			}
 			if (!buffer_mapped(bh)) {
-				folio_zero_range(folio, i * blocksize,
+				folio_zero_range(folio, bh_offset(bh),
 						blocksize);
 				if (!err)
 					set_buffer_uptodate(bh);
@@ -2412,7 +2411,7 @@ int block_read_full_folio(struct folio *folio, get_block_t *get_block)
 				continue;
 		}
 		arr[nr++] = bh;
-	} while (i++, iblock++, (bh = bh->b_this_page) != head);
+	} while (iblock++, (bh = bh->b_this_page) != head);
 
 	if (fully_mapped)
 		folio_set_mappedtodisk(folio);
-- 
2.47.2


