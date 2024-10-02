Return-Path: <linux-fsdevel+bounces-30715-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2AD098DE30
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 17:01:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83EBF2831F2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 15:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 393211D0B8B;
	Wed,  2 Oct 2024 15:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZOASrtwt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96AC28F5E;
	Wed,  2 Oct 2024 15:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727881247; cv=none; b=FWUdTskTuQCyAYDA6fFqvz7HhX+xI+DdSEwQOq/SugDQTTAsIwcPJtnJxmdyHwDhc0pTn+CypE8tDtb24MmbINDzKfHXs1j/F1kKeTH1FPto5SrV2+UaDO5pBX5vWS/OtHGeIb78Uu3npISOeVeM2S2EMDcWFO8VGDE5noflHIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727881247; c=relaxed/simple;
	bh=pdGFX7klhO6pZ6Pp8cg70pW+01wCrUJSm/kcUObNjJY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=flEWysuw5/99Vsv6GKCUTxW36/yVF7bMUd2qjmn+M7KAICVsTBGiVIDckgsD39lfG/qKzlulom7vviFGdDlYYPkA5cEJwYWI2cb5/Pb4gErjWyD0NV/2CFpNOGcKPSAXb204u6KfUpriTHWtfhDssv8SaxS3kp4Biy+ZFU0I6A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZOASrtwt; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=Yu4ZieGNRf3kn0Qj1BS/LcZ6auKmIKvgYP3Q70tjnNg=; b=ZOASrtwtKKGUwbREoP5xx8OG7g
	KTGyhMGoi86nk4ldQ0njlCfTjeOMJEEcrmatkC/5o4zYlTgS3q8bfjN8iVgUAv99kwvg/xmrwgLbY
	6jr0ErUtFWuv6lbUpxum6m54QVbo0H0cobK8pL4YXopBoX0bvh/J8Y9GAZGU74csa+aqj5oc4OuTa
	pu3wx3Nodh4rFWcA0FDQcEWdSCEfPEicecDaaXquaZXQBHZAGldp5nIAUP/WSAbIuqOd1Se2t855E
	x6K19un6FxXt1OHje4H0TqEOs1v1a77hKVnCXajZXPyGwTsy4QZsjZXTCBi4iGu/Kw0hYh5kqL8yM
	K0mzYAuw==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sw0qD-00000005cSm-2jHe;
	Wed, 02 Oct 2024 15:00:37 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org,
	linux-nilfs@vger.kernel.org
Subject: [PATCH 3/4] nilfs2: Convert nilfs_recovery_copy_block() to take a folio
Date: Wed,  2 Oct 2024 16:00:33 +0100
Message-ID: <20241002150036.1339475-4-willy@infradead.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241002150036.1339475-1-willy@infradead.org>
References: <20241002150036.1339475-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use memcpy_to_folio() instead of open-coding it, and use offset_in_folio()
in case anybody wants to use nilfs2 on a device with large blocks.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/nilfs2/recovery.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/fs/nilfs2/recovery.c b/fs/nilfs2/recovery.c
index 21d81097a89f..1c665a32f002 100644
--- a/fs/nilfs2/recovery.c
+++ b/fs/nilfs2/recovery.c
@@ -481,19 +481,16 @@ static int nilfs_prepare_segment_for_recovery(struct the_nilfs *nilfs,
 
 static int nilfs_recovery_copy_block(struct the_nilfs *nilfs,
 				     struct nilfs_recovery_block *rb,
-				     loff_t pos, struct page *page)
+				     loff_t pos, struct folio *folio)
 {
 	struct buffer_head *bh_org;
-	size_t from = pos & ~PAGE_MASK;
-	void *kaddr;
+	size_t from = offset_in_folio(folio, pos);
 
 	bh_org = __bread(nilfs->ns_bdev, rb->blocknr, nilfs->ns_blocksize);
 	if (unlikely(!bh_org))
 		return -EIO;
 
-	kaddr = kmap_local_page(page);
-	memcpy(kaddr + from, bh_org->b_data, bh_org->b_size);
-	kunmap_local(kaddr);
+	memcpy_to_folio(folio, from, bh_org->b_data, bh_org->b_size);
 	brelse(bh_org);
 	return 0;
 }
@@ -531,7 +528,7 @@ static int nilfs_recover_dsync_blocks(struct the_nilfs *nilfs,
 			goto failed_inode;
 		}
 
-		err = nilfs_recovery_copy_block(nilfs, rb, pos, &folio->page);
+		err = nilfs_recovery_copy_block(nilfs, rb, pos, folio);
 		if (unlikely(err))
 			goto failed_page;
 
-- 
2.43.0


