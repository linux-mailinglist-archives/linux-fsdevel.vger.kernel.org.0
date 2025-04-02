Return-Path: <linux-fsdevel+bounces-45525-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74696A791B6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 17:01:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F97C3B2477
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 15:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 976E623C8AD;
	Wed,  2 Apr 2025 15:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UnwirFlG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B7A23C8B7
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Apr 2025 15:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743606017; cv=none; b=LTs/Quj5pg2qp+s876A0zdZsT6yygZBxUsXkYB9IAoZTqHwn+NXBn8Jw49EQXry0dW7xso8yhw/fzPLu/VaRKh5oz8ijWs1k2FPVLyCJPzLdARVHoeOb+1hTYDxH/k6SNEw5KFvhowkBRwXUPlsTQAW37YG8tYLh63ly8NkHhfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743606017; c=relaxed/simple;
	bh=Oy7GRuvB6U2ytA3uUgwr8wA2LZEdmftsuXC9lMF1sDY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f6vJORJgI/KFF/NUK/9L5g3Cic/SSlhTc9aU3LcBh3ED+mMSB5q6s38tEZvaotGMocMotwJFc2c48iKLpvUd2xSjmp+oIMcclt0jTDff5S3B8aOsssEtL/Re1GKFRbhxrulphKTc13bsdXgkpUcp8oI1ZnO8nniXKfnEC1gEBG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UnwirFlG; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=x5fMthl+YaILM39iz9o6tccRRw9/3DVe0YNJSzzz678=; b=UnwirFlGTRxdERwCdAhFqjsRYZ
	QoSUv85elJbet28sNBFxLnZYAHDmULxGIgfzgqPFxMCqUmRi/upx0/9/QDXW2BE8oS/QpNNoA1x5h
	p07RGrO2jfRAI4drMHFoURoaWDb1/B0jPKUN7Sd64RWmVdqDj4rm8hQsoNnTpxEpXm8fyubWc2VrX
	eiqEIVwY5723zFJd5POxZpsbkfU8xSLaGv0a8Px+rKDZVDIcfCHP2nOwILjdrTWfrAfrAAydB7KOR
	q5rOnmzK1YhElfHfdv0FsVGgt1vHLqsL1noYlitjyijpBXPKv7CIKBb0wChTCqjI7oejKaw7284Sn
	yzDMR8Lg==;
Received: from willy by casper.infradead.org with local (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzzZX-00000009gse-335e;
	Wed, 02 Apr 2025 15:00:07 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	intel-gfx@lists.freedesktop.org,
	linux-mm@kvack.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH v2 7/9] ttm: Call shmem_writeout() from ttm_backup_backup_page()
Date: Wed,  2 Apr 2025 16:00:01 +0100
Message-ID: <20250402150005.2309458-8-willy@infradead.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250402150005.2309458-1-willy@infradead.org>
References: <20250402150005.2309458-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ->writepage operation is being removed.  Since this function
exclusively deals with shmem folios, we can call shmem_writeout()
to write it.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 drivers/gpu/drm/ttm/ttm_backup.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_backup.c b/drivers/gpu/drm/ttm/ttm_backup.c
index 93c007f18855..0d5718466ffc 100644
--- a/drivers/gpu/drm/ttm/ttm_backup.c
+++ b/drivers/gpu/drm/ttm/ttm_backup.c
@@ -136,13 +136,13 @@ ttm_backup_backup_page(struct ttm_backup *backup, struct page *page,
 			.for_reclaim = 1,
 		};
 		folio_set_reclaim(to_folio);
-		ret = mapping->a_ops->writepage(folio_file_page(to_folio, idx), &wbc);
+		ret = shmem_writeout(to_folio, &wbc);
 		if (!folio_test_writeback(to_folio))
 			folio_clear_reclaim(to_folio);
 		/*
-		 * If writepage succeeds, it unlocks the folio.
-		 * writepage() errors are otherwise dropped, since writepage()
-		 * is only best effort here.
+		 * If writeout succeeds, it unlocks the folio.	errors
+		 * are otherwise dropped, since writeout is only best
+		 * effort here.
 		 */
 		if (ret)
 			folio_unlock(to_folio);
-- 
2.47.2


