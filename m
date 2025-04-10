Return-Path: <linux-fsdevel+bounces-46146-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D614EA835F8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 03:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20FD346598F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 01:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E081C700C;
	Thu, 10 Apr 2025 01:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="R26qRIYk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A353596F;
	Thu, 10 Apr 2025 01:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744249792; cv=none; b=KfF32NzB1cgAcsRtdUtX0/prBYMBmaEiupnQ63emhiea4fzmbQp60nmiV/H9lElNu9wWQA2S0Xi1ym7+4DdfiwPVPY9p+IuIRf1YKlLpOYVuoiKCLskgQoDxe8004aNYforXahLA5UwvGiEr9QIadvTmgWlFYFgYH6fPnOk7BxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744249792; c=relaxed/simple;
	bh=n4Z3bfNYR4ZdMyATwh0SIQXXYPOl4F3OtrnP8lUJ4ms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yp+R2OPO4E4KAWxRxBd//siwbi9546ILBKu1XjXws7CVPr+K6kXzY/eAdjCdO1xG5lwoEaWi9AuAhk+0phVjJZr8o12MzyDARkH0ydOXz6YSybSU2bPlGpWke560j1TCSJjHGbhi3B8ox9keCuhGwd75YKvz/c3FSbvJ+ftS3JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=R26qRIYk; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=+ZrhLZCm8tm/ew0QWyWZbWu1XvI3GATXCgCuKoXd9Bk=; b=R26qRIYkXu0Z3b41jJAv/FgCEj
	5Fz5zYumTTbKmUt+n0M/Y2qgsSkKGqiYMVYHQ29n1yoaKcyHxy1Ewjv/RG5lzQG8KQcgLDrrCvriD
	9SAkHIK+HG+MCxJyh9NrYIyTPtgf72uG/3nOjjBXM8nijBwDcAcGZxztjJyNqN9u+GeTe4iSEqBbh
	/MohfrhorRHSbEqcCF3FSpEQOPzGBRol+BXc1dLRMa7hLfJNZ7+7YHy8AAJOxd0T7eZFR2G1fAcsv
	hs6YeBJqb6Z/nxrgkNXDpvLGd5on0WMn2dNqIKRY88dYoauT2Q+Nbbxj/FJYQ+uYvr5BJ0dJbGmN0
	+jP/BxDw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2h35-00000008yvM-3pIY;
	Thu, 10 Apr 2025 01:49:47 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: brauner@kernel.org,
	jack@suse.cz,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org,
	riel@surriel.com
Cc: dave@stgolabs.net,
	willy@infradead.org,
	hannes@cmpxchg.org,
	oliver.sang@intel.com,
	david@redhat.com,
	axboe@kernel.dk,
	hare@suse.de,
	david@fromorbit.com,
	djwong@kernel.org,
	ritesh.list@gmail.com,
	linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-mm@kvack.org,
	gost.dev@samsung.com,
	p.raghav@samsung.com,
	da.gomez@samsung.com,
	mcgrof@kernel.org
Subject: [PATCH v2 4/8] fs/ocfs2: use sleeping version of __find_get_block()
Date: Wed,  9 Apr 2025 18:49:41 -0700
Message-ID: <20250410014945.2140781-5-mcgrof@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250410014945.2140781-1-mcgrof@kernel.org>
References: <20250410014945.2140781-1-mcgrof@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>

From: Davidlohr Bueso <dave@stgolabs.net>

This is a path that allows for blocking as it does IO. Convert
to the new nonatomic flavor to benefit from potential performance
benefits and adapt in the future vs migration such that semantics
are kept.

Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 fs/ocfs2/journal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ocfs2/journal.c b/fs/ocfs2/journal.c
index f1b4b3e611cb..c7a9729dc9d0 100644
--- a/fs/ocfs2/journal.c
+++ b/fs/ocfs2/journal.c
@@ -1249,7 +1249,7 @@ static int ocfs2_force_read_journal(struct inode *inode)
 		}
 
 		for (i = 0; i < p_blocks; i++, p_blkno++) {
-			bh = __find_get_block(osb->sb->s_bdev, p_blkno,
+			bh = __find_get_block_nonatomic(osb->sb->s_bdev, p_blkno,
 					osb->sb->s_blocksize);
 			/* block not cached. */
 			if (!bh)
-- 
2.47.2


