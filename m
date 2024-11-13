Return-Path: <linux-fsdevel+bounces-34608-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ADE79C6BDA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 10:48:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60B8A285B38
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 09:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94ADB1F8F1B;
	Wed, 13 Nov 2024 09:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="z+/DD2ks"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637FE1F80CF;
	Wed, 13 Nov 2024 09:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731491255; cv=none; b=D7EXTtVRTsIhsdR3u/00rN41isKTdF40/hZjOm7SYw4DOrH38etMvw5gu597FS+yVeb9aIOGjcyZ8Hmd+y0E+k2slaDqNEeJi7pvIS8+5SsYL25zrVqXBidYpG4yd+zME0W+Njb/lUM7v+vZN0vHjultyOL8WYYlJszzKNlWwy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731491255; c=relaxed/simple;
	bh=LuoRYrsA1zw/6T9PAg+pZUF80hnr641Lz7m1ROM3Co4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nWUtqS8m5iRI9QzY5RlaGaFMF8YczZyTwfOP2SpgreFzJ4Y1d9tCk5ebJtQgkbdT5UsLjPOHdVgXvz8I3mkKHjMxUAYeVQY4ASUr48d1wmIVPsR7syU99sCoZxk02yoBsUa3IX1ymB6TPorIy1As4/K8dz/csfDZRHaVdnxPQ38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=z+/DD2ks; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=mZYiYHdxBbyR/19PnV0dX82l4+th0pXaG9WcUHT6G/o=; b=z+/DD2ksIIMD99dpwbTEHn8k4O
	pHg7uHS7eT094skjM9TFMiJ1EniWkjT9HGAw2UunxTT+sN5NEc0TVmCFons1UrnsgzgUrFtgdMgAA
	zpf3glrmYXKcRmnb6yD71kaZaua4QRrNfvPkOWhj9eWg8lFK/pcT+kIGHV5CWnC6rY4K05AxlyQGQ
	MNVmgP7cOXDVgnvxewh+FESw9UIPM4X8JwlqSq1KDpZfJCJvo87OGEDT+Mg+bP2H8xuptX9LBOIk/
	/hFwEUAGV3O/VZjpRAj6p50xbFOpUl2RhdqH8S/bLLJ6RBn47IsUnnziFAeqODl4eodR/DLjxEOJc
	juHAjElA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tB9yD-00000006HdQ-3YUj;
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
Subject: [RFC 7/8] nvme: remove superfluous block size check
Date: Wed, 13 Nov 2024 01:47:26 -0800
Message-ID: <20241113094727.1497722-8-mcgrof@kernel.org>
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

The block layer already validates proper block sizes with
blk_validate_block_size() for us so we can remove this now
superfluous check.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 drivers/nvme/host/core.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 855b42c92284..86ff872cf6bd 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2022,16 +2022,6 @@ static bool nvme_update_disk_info(struct nvme_ns *ns, struct nvme_id_ns *id,
 	u32 atomic_bs, phys_bs, io_opt = 0;
 	bool valid = true;
 
-	/*
-	 * The block layer can't support LBA sizes larger than the page size
-	 * or smaller than a sector size yet, so catch this early and don't
-	 * allow block I/O.
-	 */
-	if (head->lba_shift > PAGE_SHIFT || head->lba_shift < SECTOR_SHIFT) {
-		bs = (1 << 9);
-		valid = false;
-	}
-
 	atomic_bs = phys_bs = bs;
 	if (id->nabo == 0) {
 		/*
-- 
2.43.0


