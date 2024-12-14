Return-Path: <linux-fsdevel+bounces-37411-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BEBE89F1C52
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Dec 2024 04:12:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D948116AB14
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Dec 2024 03:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E771115C13A;
	Sat, 14 Dec 2024 03:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="1EBbiPVm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63E926AC3;
	Sat, 14 Dec 2024 03:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734145861; cv=none; b=EWjeYDP+JmO7eKyMU7O4nUtMqQlGyjImFJY0vaG81Cb+RZAEp30sX3aKd7E4iAC0ddQ1BmPOXfNoXaeh0WgY18QlP0SDOqFmEKGNPY80k0VjpGcCiOFDxROsTLlqvjB8R7Mrt4FspkaNtLoxG7oE8yZj0YKtiCsjf0LCB6NuK7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734145861; c=relaxed/simple;
	bh=mH4uJDHRT/XfJAI6xVPmuifowd7/VbSotp3ctbAhHE0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YW+YDrSbIi/5zg+grp7FyA+tKT75c0G0Qz7jll0rJgy1WrBimxiA/faIAyn2Ynxer/wevSSJGOXYSLg233e3P835df8xRgVRWLIOHlgl0CdUV6k/YSLuMvk+ormXzx3owpPniVMJ/WNivjyWIu53Z8BkQ0Z+eTUsdJaTaAuwRwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=1EBbiPVm; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=SC13mhGE1TKS2Lk87NYZVfEBxxs49zvhyYsSfa79OZk=; b=1EBbiPVmmO/i62EdqjkG8nBcyi
	k/algK3tiiXr1Br1Uk9Qt9p/uY5q0O43rcQZuE5e6kuBKV2SWOEt/KqsMaIQY8aN1wO/D2NHKMlEJ
	2+BNxHzVQUme6o6AFjNh5P1B87JL3yLWk9CzE9EYwujJ7MO+6hQx0giICBsCV8eymOQsYUKIy/d8m
	NYsfTm4ZQ1Hs/vrfv18SZK9QPKW+R5YpL1pEDfUKo1BRlZUL1vdwtlvgETaVFB4OUYozDByc6viYJ
	Q+1N9a4ZD2iUqPcfZdrG2s1dHK9WAdLBpCkOVJcGl4BLCn+tts5iT/ZXrC6R+O9AOQrOKZ7DuAaKS
	rE/RqCUw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tMIYO-00000005c3r-0E3S;
	Sat, 14 Dec 2024 03:10:52 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: willy@infradead.org,
	hch@lst.de,
	hare@suse.de,
	dave@stgolabs.net,
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
Subject: [RFC v2 10/11] nvme: remove superfluous block size check
Date: Fri, 13 Dec 2024 19:10:48 -0800
Message-ID: <20241214031050.1337920-11-mcgrof@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241214031050.1337920-1-mcgrof@kernel.org>
References: <20241214031050.1337920-1-mcgrof@kernel.org>
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

Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 drivers/nvme/host/core.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index d169a30eb935..bbb5e9d2415c 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2029,16 +2029,6 @@ static bool nvme_update_disk_info(struct nvme_ns *ns, struct nvme_id_ns *id,
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


