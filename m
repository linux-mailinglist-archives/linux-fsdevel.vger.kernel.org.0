Return-Path: <linux-fsdevel+bounces-34606-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF73D9C6BCE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 10:48:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94E83285B17
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 09:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4FE31F8932;
	Wed, 13 Nov 2024 09:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Gu2MfyO+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447201BDA8D;
	Wed, 13 Nov 2024 09:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731491254; cv=none; b=Txo5juIPJZkB1PJJgjoeThwkrtpjCWOCP3WQDwLHm7G4S3pgU0mgNbDmXKTq09AcoBmutF21nY3DhvCL3hPrKRNA9GvjHIY/c13un8F2apnUOp3caf3ohxCLNx1eD3lp/6TK8mDXIlE7IZ96stQmhVB5bTKQWzhDwzU23wTBMNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731491254; c=relaxed/simple;
	bh=wcHoBPeIwO9R+T4Bz/4wZhek++J1yG/sWOECQhZCXI4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j0ic6xQzHIz+MMFAMgcSDl/wogEzkwWkXFd2Kwzb2qJxJO8K24VsCoXl1jOf22FFvC+DR2lZWpjiVLPEv7FnlIcDWKo+wulLPn7VVMwHqJxYfT16Hswt9qk6aMUqMUvaij/zN6D6XU59RVVyQ35dWJM1aV/TCwOIKj8Mfom1gKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Gu2MfyO+; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=EeFsYhvb/Fdit2R4hCFUp0b7VKyDdbX2dUmYXd00mGc=; b=Gu2MfyO+KOMeF2SXnrD9P/+Yok
	ZDkackaAAZcM922Q2kci3CL8PuXVDU3ipL5W/i0JARN0Ecf4AMl+R9WYIZ4MjG6rBTVsRiX2s23jf
	Y1SGKls98aedAJVN5zJ9MrapGIkNeCebbvf00Jc772ox6gByfWwqFTITY4Ol/QR08T4fH18Dpz4X9
	xMSuviowVOdca3AC9xrghQxbXYXHK+HOc/fBo+zng9q/nKrY9zyh0E/Vs1XrHK+p4z0yxx9Z7ClTP
	P6umpagaAJMQvQ7chWp66JmdoBso0jnn0hL2GBNLLFILfTKQ0UK0jD+5ZjDQZOzqPD00xXj/1t9TZ
	h6oYqmxg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tB9yD-00000006Hd6-0Cj0;
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
Subject: [RFC 3/8] fs/buffer: restart block_read_full_folio() to avoid array overflow
Date: Wed, 13 Nov 2024 01:47:22 -0800
Message-ID: <20241113094727.1497722-4-mcgrof@kernel.org>
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

From: Hannes Reinecke <hare@suse.de>

block_read_full_folio() uses an on-stack array to hold any buffer_heads
which should be updated. The array is sized for the number of buffer_heads
per PAGE_SIZE, which of course will overflow for large folios.
So instead of increasing the size of the array (and thereby incurring
a possible stack overflow for really large folios) stop the iteration
when the array is filled up, submit these buffer_heads, and restart
the iteration with the remaining buffer_heads.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 fs/buffer.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 1fc9a50def0b..818c9c5840fe 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2366,7 +2366,7 @@ int block_read_full_folio(struct folio *folio, get_block_t *get_block)
 {
 	struct inode *inode = folio->mapping->host;
 	sector_t iblock, lblock;
-	struct buffer_head *bh, *head, *arr[MAX_BUF_PER_PAGE];
+	struct buffer_head *bh, *head, *restart_bh = NULL, *arr[MAX_BUF_PER_PAGE];
 	size_t blocksize;
 	int nr, i;
 	int fully_mapped = 1;
@@ -2385,6 +2385,7 @@ int block_read_full_folio(struct folio *folio, get_block_t *get_block)
 	iblock = div_u64(folio_pos(folio), blocksize);
 	lblock = div_u64(limit + blocksize - 1, blocksize);
 	bh = head;
+restart:
 	nr = 0;
 	i = 0;
 
@@ -2417,7 +2418,12 @@ int block_read_full_folio(struct folio *folio, get_block_t *get_block)
 				continue;
 		}
 		arr[nr++] = bh;
-	} while (i++, iblock++, (bh = bh->b_this_page) != head);
+	} while (i++, iblock++, (bh = bh->b_this_page) != head && nr < MAX_BUF_PER_PAGE);
+
+	if (nr == MAX_BUF_PER_PAGE && bh != head)
+		restart_bh = bh;
+	else
+		restart_bh = NULL;
 
 	if (fully_mapped)
 		folio_set_mappedtodisk(folio);
@@ -2450,6 +2456,15 @@ int block_read_full_folio(struct folio *folio, get_block_t *get_block)
 		else
 			submit_bh(REQ_OP_READ, bh);
 	}
+
+	/*
+	 * Found more buffers than 'arr' could hold,
+	 * restart to submit the remaining ones.
+	 */
+	if (restart_bh) {
+		bh = restart_bh;
+		goto restart;
+	}
 	return 0;
 }
 EXPORT_SYMBOL(block_read_full_folio);
-- 
2.43.0


