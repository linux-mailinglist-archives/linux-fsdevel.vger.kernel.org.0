Return-Path: <linux-fsdevel+bounces-63920-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D096BD1C70
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 09:27:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4BFDE4EBDA5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 07:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BF872E8B68;
	Mon, 13 Oct 2025 07:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HieK/1Aj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF752E88BB;
	Mon, 13 Oct 2025 07:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760340466; cv=none; b=f5Wzi6ATFf7K4h1VqdaVAsGB97uFGi9oBKdFqOd4WiOZANLA2G9UAUGOKcXzpXTaapDpmQpV5M5tAj4hvHkr5lOFIRfrev27X2D3y8+WbpbvvtyjpT0Fbt00P0Nu84nSkKmOn2IVzCG7qPxzgmVr0D4qxefQCW/4XhXelXTNR9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760340466; c=relaxed/simple;
	bh=Vf13HKK9p1N07aqi+KX9NeOegWu03lKW1PaYvnN9AEg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rpPyKLnHZaz75vcTY5uNSomZgiqe82yzq5Qv8gq/XKtsIbhRfGHSxDaN826R7JQYzu6hz00iNmt/fhEmNubAU+nYyVWX+goNxztbPMtd7UEVswFCDdNjJfuZ0K3uM5eLQFZmmubk71348fyrVY0fNPvaQwfUgl/YrJ/9B45rr7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=HieK/1Aj; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=4/i6Yo0DlavHvIyOPm6rSuHPtcfvBwYubd7udQWUQmQ=; b=HieK/1AjETnFbyPypM9vJViuqg
	SRNPd77JSXoda8B1rp+WFEYqCrKqUmvraiWGmg4PcPq6ANQICDS/CD2hgEY1Pw6kkbOeBCb2axRAi
	69pZZOtzAMJaebM79s6ixL5K23P4JgeKkkKKpiq/UilH56UnMPOz/jC+t7zBCcb4Njf8EiZCnPZmh
	IbcVkFQBybIpirM19Sst24gUjjkw5agH61uB01fhnlPiTgLS+s2pQb3ldct1WkmJFtMgs8CNdj1ML
	VZcqaGdFE+oki6oPlsIkDvO0uyah5FiT01tAvdGgx3sdMaZr51G2ghi2XMx3+z7Z86C+guaJnpcSe
	3EIYJWyA==;
Received: from [220.85.59.196] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8Cy8-0000000CUF2-1DDD;
	Mon, 13 Oct 2025 07:27:45 +0000
From: Christoph Hellwig <hch@lst.de>
To: jack@suse.cz,
	willy@infradead.org
Cc: akpm@linux-foundation.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	dlemoal@kernel.org,
	linux-xfs@vger.kernel.org,
	hans.holmberg@wdc.com
Subject: [PATCH, RFC] limit per-inode writeback size considered harmful
Date: Mon, 13 Oct 2025 16:21:42 +0900
Message-ID: <20251013072738.4125498-1-hch@lst.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Hi all,

we have a customer workload where the current core writeback behavior
causes severe fragmentation on zoned XFS despite a friendly write pattern
from the application.  We tracked this down to writeback_chunk_size only
giving about 30-40MBs to each inode before switching to a new inode,
which will cause files that are aligned to the zone size (256MB on HDD)
to be fragmented into usually 5-7 extents spread over different zones.
Using the hack below makes this problem go away entirely by always
writing an inode fully up to the zone size.  Damien came up with a
heuristic here:

  https://lore.kernel.org/linux-xfs/20251013070945.GA2446@lst.de/T/#t

that also papers over this, but it falls apart on larger memory
systems where we can cache more of these files in the page cache
than we open zones.

Does anyone remember the reason for this limit writeback size?  I
looked at git history and the code touched comes from a refactoring in
2011, and before that it's really hard to figure out where the original
even worse behavior came from.   At least for zoned devices based
on a flag or something similar we'd love to avoid switching between
inodes during writeback, as that would drastically reduce the
potential for self-induced fragmentation.

---
 fs/fs-writeback.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 2b35e80037fe..9dd9c5f4d86b 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -1892,9 +1892,11 @@ static long writeback_chunk_size(struct bdi_writeback *wb,
 	 *                   (quickly) tag currently dirty pages
 	 *                   (maybe slowly) sync all tagged pages
 	 */
-	if (work->sync_mode == WB_SYNC_ALL || work->tagged_writepages)
+	if (1) { /* XXX: check flag */
+		pages = SZ_256M; /* Don't hard code? */
+	} else if (work->sync_mode == WB_SYNC_ALL || work->tagged_writepages) {
 		pages = LONG_MAX;
-	else {
+	} else {
 		pages = min(wb->avg_write_bandwidth / 2,
 			    global_wb_domain.dirty_limit / DIRTY_SCOPE);
 		pages = min(pages, work->nr_pages);
-- 
2.47.3


