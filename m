Return-Path: <linux-fsdevel+bounces-37686-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF4A59F5C8A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 03:02:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7742A188A7F7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 02:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D0C6EB7C;
	Wed, 18 Dec 2024 02:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="1Cdajrxu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E11F3594C;
	Wed, 18 Dec 2024 02:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734487342; cv=none; b=AjbQehqlrIeyjMyTCdskLalABa51+RBtQsu89v5F4yf0/MYtd0Isd6OcbIf9kboSpxR3zRohTybWnVoPSoZC04eY7NvLKXs19WCrxusBRCpOcv1Z6u/NCi603SirLz64jrbLieoIiwmagDSP/Jzv9+/z6LEHcmSzfKWldqFIsB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734487342; c=relaxed/simple;
	bh=+5lOJ3dH1zv5sEosNg8Pkkq7VW4xRIRajnM7FwknUEw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c8J1s4lH88Dn/zz5BjD0d4HiwDS/9QTkU9uQnRXKwOVxi+MXTDXSmls2RE/c4YXurVj9dpJWJoOMK3A3RJmlrAvK3eibVAxZtIO9AENjz3PTsA8vWYZmjtNe9fTgeY/mSF8kOXELwikmuTfx5k9C3fcysPQGSiNcMfTITHcQGG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=1Cdajrxu; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=jhZCWpmhBitik/IbLKGzmJ1c/5BHTYghYQVmmbUuo2g=; b=1CdajrxuJNxyHpIMNzIBpre/8y
	QSUHrRIiKEh6adHNpYl+AxDESq0LFLW4ofR/bg6Xt+VDn2AiBExJjTX5tH1OlHs3nnZToCAm+Vyta
	w23OOl37keMa+LW8hBC1wrNVksggV/DAfhCGEQm10KDpCdBWVAzLABpsZJ8eeiVlZ+gDCKFk7zoJG
	PKHERu2/5Y3HBK/b2iC2284JbauKJvPPj4KgU7Udc37PckHm/UiMdkMJb7BmGuj204FhN1K/4rUQW
	wWHTGj0KN+RJ8PgDJtSy7BukbBXrPu0vg0SKOhKU+vhoV5x/SGdfv5JXJV3AdiFbyBrxi1XsK6zNh
	4g2xRPQQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tNjO9-0000000FLOJ-1Q9w;
	Wed, 18 Dec 2024 02:02:13 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: axboe@kernel.dk,
	hch@lst.de,
	hare@suse.de,
	kbusch@kernel.org,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org,
	willy@infradead.org,
	dave@stgolabs.net,
	david@fromorbit.com,
	djwong@kernel.org
Cc: john.g.garry@oracle.com,
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
Subject: [PATCH 2/2] nvme: use blk_validate_block_size() for max LBA check
Date: Tue, 17 Dec 2024 18:02:12 -0800
Message-ID: <20241218020212.3657139-3-mcgrof@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241218020212.3657139-1-mcgrof@kernel.org>
References: <20241218020212.3657139-1-mcgrof@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>

The block layer already has support to validates proper block sizes
with blk_validate_block_size(), we can leverage that as well.

No functional changes.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index d169a30eb935..a970168a3014 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2034,7 +2034,7 @@ static bool nvme_update_disk_info(struct nvme_ns *ns, struct nvme_id_ns *id,
 	 * or smaller than a sector size yet, so catch this early and don't
 	 * allow block I/O.
 	 */
-	if (head->lba_shift > PAGE_SHIFT || head->lba_shift < SECTOR_SHIFT) {
+	if (blk_validate_block_size(bs)) {
 		bs = (1 << 9);
 		valid = false;
 	}
-- 
2.43.0


