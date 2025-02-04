Return-Path: <linux-fsdevel+bounces-40858-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA9CA27F67
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 00:13:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19A2D3A535C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 23:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE7E2206B1;
	Tue,  4 Feb 2025 23:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dwYwqC0B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4082521C17E;
	Tue,  4 Feb 2025 23:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738710738; cv=none; b=AbPfvXqyfT9qMKW1tH8/JFocBGGbfW5/q7HhgxkXkVz8b4z/drV3Wv+t3OMpfdiA+4FMLDGB+MqkEMTDAwvjaLWgQX28wkUZO5kn7npjWwgKRaECh025TSgqOWaZO+WKpyl8YMhA2wcNAla3DBSxy8m6B9kSKEhfGzQxN+BSeoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738710738; c=relaxed/simple;
	bh=o4HWFKGhOfRqQZejNjFvDKTVduD7VxcCSTYrB59N0Yg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lRYQA6sz0eUAzOej2DEolEDPWDzTYJpTpLZryxjRM2QC3bmkV71O6ocQ0OuDUf43MZsdq9CEhQXMg12LLvEvgm6iEAbeFlzQLiLo9SXhvL7EMyADGPCsViANUl/02IJjguhoMYtMpP8RfCsCzqXzd0/ZARGG4T1XakrDzKj2QOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dwYwqC0B; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=Z9eItY4c7G0s+c+amJ06bcyD3TNKrS6Yw3t1FzanFdU=; b=dwYwqC0BnaxfmaHsYRpSVX1szZ
	y51ea1k/HUWuGbfBMjZT8cR+F3m8SputDuamldmdZf26OFtaPx0ElsPayezYJxgw5K2dqiPUuWrgS
	UJwLbSyAoStA48qFVkBvCVCtSVR4ODs+VlzjWMsE33dibGXHO0jLRbZyVe4qM4di5obEtKYv3Rg+0
	nBqbJHk/Lou9nFRSKHo1AS/uxHZASXTQ7zj3S1vbwUFgoeF0JCya92/amtnBc5LMYrhRoNzQlEpIs
	Qx+Mz+ZbBjWgGnIVp7mVUFaVm60IxAVsd/bddgwX6rQogTzV7PwUcb8tsSLx/dxLiQO8+lkMBa9dO
	8hsBmURw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tfS5T-00000001nhM-14jK;
	Tue, 04 Feb 2025 23:12:11 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: hare@suse.de,
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
Subject: [PATCH v2 1/8] fs/buffer: simplify block_read_full_folio() with bh_offset()
Date: Tue,  4 Feb 2025 15:12:02 -0800
Message-ID: <20250204231209.429356-2-mcgrof@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250204231209.429356-1-mcgrof@kernel.org>
References: <20250204231209.429356-1-mcgrof@kernel.org>
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
2.45.2


