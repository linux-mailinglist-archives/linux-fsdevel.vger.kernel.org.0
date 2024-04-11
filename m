Return-Path: <linux-fsdevel+bounces-16691-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5464B8A17E1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 16:54:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3050AB21166
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 14:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB7F10799;
	Thu, 11 Apr 2024 14:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="u1cbZEye"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31968DDB3;
	Thu, 11 Apr 2024 14:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712847234; cv=none; b=fvIVDHLYJroIxIPHBrxF0aWqt4Vr02dkN2qf0yWeqrGPwJNcZDjKb5YozGxOGbgFQ7yAFox7iqW/o+e0/dFVn1czt4ZrTYJxV4n/ftUQlzmbXaGsGx0iQtdzkt33YPjQjSvDTekSEBvxqucjtXnvS3aF3e02s72WYbVajQT3Oy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712847234; c=relaxed/simple;
	bh=80EZziW8KOKIUy4gquzqZL9sk2+1rUCt52rAzzw5UWk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=phN2fi6kn/b32e2O1H2vhZoYCbZZBaFW4ZdSJ5ige8HkIQ/CXj66m4dfd0GtFc+Bm0Wxt/Y3Olxk3dj+M1Bq1e7/WbS1SaeQfWHF9f+52VsnWo+7i5R/d6PwF0KaZ6jp004ZIlLSlzCH+fZZd5irRqN8AnV46K233Nxt6yUsQtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=u1cbZEye; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=MMVyWaFO2urdgbwnK6AVyd8xNuu0uM6tJv9H0qBnG9c=; b=u1cbZEye5y6lGRXcTJKJIQFlH1
	srG6jvxwGSzNHcsL7LddYitJhObI0OPONQMmPGkjxC7EKy4k3CoEYUDZFHiLgDXfdrwpSCmyt8atX
	J7kPyKLkBRts6+Nuw1lsmA/ns//IjEjA/D62oktRkMbqcMuxhwYK+ezxnCmsiKvJCqKv0b0iNPRCE
	yfVYX7vG6IEe+5TPLKnAQMSWrCVNWcbfUG9vbBKDUrhJ0+EFcPIKDg1JoGd2rUOBEJS/27zmQON5R
	iu6eq6mX6G5ySDGNs2VTwgEGTEsv4PbtQh86ojAknGV0kS7q1DAlQQtcPvJZYOY5JldEUvEVdzMcL
	l2Y4F6OA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1ruvoA-00AYkX-2k;
	Thu, 11 Apr 2024 14:53:46 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	Yu Kuai <yukuai1@huaweicloud.com>,
	hch@lst.de,
	axboe@kernel.dk,
	linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	"yukuai (C)" <yukuai3@huawei.com>
Subject: [PATCH 03/11] grow_dev_folio(): we only want ->bd_inode->i_mapping there
Date: Thu, 11 Apr 2024 15:53:38 +0100
Message-Id: <20240411145346.2516848-3-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240411145346.2516848-1-viro@zeniv.linux.org.uk>
References: <20240411144930.GI2118490@ZenIV>
 <20240411145346.2516848-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/buffer.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index d5a0932ae68d..78a4e95ba2f2 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -1034,12 +1034,12 @@ static sector_t folio_init_buffers(struct folio *folio,
 static bool grow_dev_folio(struct block_device *bdev, sector_t block,
 		pgoff_t index, unsigned size, gfp_t gfp)
 {
-	struct inode *inode = bdev->bd_inode;
+	struct address_space *mapping = bdev->bd_mapping;
 	struct folio *folio;
 	struct buffer_head *bh;
 	sector_t end_block = 0;
 
-	folio = __filemap_get_folio(inode->i_mapping, index,
+	folio = __filemap_get_folio(mapping, index,
 			FGP_LOCK | FGP_ACCESSED | FGP_CREAT, gfp);
 	if (IS_ERR(folio))
 		return false;
@@ -1073,10 +1073,10 @@ static bool grow_dev_folio(struct block_device *bdev, sector_t block,
 	 * lock to be atomic wrt __find_get_block(), which does not
 	 * run under the folio lock.
 	 */
-	spin_lock(&inode->i_mapping->i_private_lock);
+	spin_lock(&mapping->i_private_lock);
 	link_dev_buffers(folio, bh);
 	end_block = folio_init_buffers(folio, bdev, size);
-	spin_unlock(&inode->i_mapping->i_private_lock);
+	spin_unlock(&mapping->i_private_lock);
 unlock:
 	folio_unlock(folio);
 	folio_put(folio);
-- 
2.39.2


