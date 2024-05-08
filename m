Return-Path: <linux-fsdevel+bounces-19016-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E425D8BF679
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 08:45:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 215A01C21259
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 06:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 688BD24B33;
	Wed,  8 May 2024 06:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="qhTQqj2I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E96C20312
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 May 2024 06:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715150695; cv=none; b=gOiPyWXC4wHs0nDFTgFLU9Z1QayxLW3LnqO0KsYHjtRwGN1DwESrjPzi/v8M3ZMfo4DUBxDe895r+NWMykO4GeJkL4iHT1gPQfnDBLPIq7sosNjyW/RoDIWRLku6bwLq3lE/XFcK+pZDWM3D/c338AteuMY0/xtpTjhP8StMWmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715150695; c=relaxed/simple;
	bh=zm0OL/mV7taDSKIxmKXBTLtxqC/GZ5ghQMwsrfxcOV4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Z5jSLZvHi9pGuWxaQ0iUEibliNNjabJqmz/14lRiGttMgEtDpkQjeW3n1Zzsz09dlfR/jfwWYoCBXH9EsLyoxV20OndPBRUU0+A4Pr+Wl6B5P8j6PApFnaAR1UEDyJmGWDNQw7/t8avHi+ILK3WfFFl45EAcySBzOjtY2CsSIEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=qhTQqj2I; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=zeWDbF7WGMQiyRv+5bNEbRD0bhLyls69X87xbi8kiD0=; b=qhTQqj2IJ88CTSrcffYwM3CyWh
	wC8gFqTaEUhV7z0bq31gfGSiZBjoqYgqtpkrqh+fVFh06nEg9B4RPAmhbOyPbORdywdCKaJO73m+A
	BSbUglnzAXZ0/YgQlrlfT1aFyhUU2xw8LyTYULdQR0iM4aLxtywb+vAweOk0Caqr1plR0K9efkfZV
	Ej6G1nzbroHqVGT0gC44pEucnPcJWS7HlQZava4PBZQaTWN+aZkHSg9fGCkuR/QCSAnVr2TVQr4f6
	aGKz4RoA0E/Ri+x+MFKdNvdtl81IdrfdGnVaWocqBOeWPteKsAiMn5bqqkS34o6aELRalzbc9GEqr
	01WYgdQg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1s4b2q-00FvzP-2H;
	Wed, 08 May 2024 06:44:52 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: axboe@kernel.dk,
	brauner@kernel.org,
	hch@lst.de
Subject: [PATCHES part 2 03/10] grow_dev_folio(): we only want ->bd_inode->i_mapping there
Date: Wed,  8 May 2024 07:44:45 +0100
Message-Id: <20240508064452.3797817-3-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240508064452.3797817-1-viro@zeniv.linux.org.uk>
References: <20240508063522.GO2118490@ZenIV>
 <20240508064452.3797817-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Link: https://lore.kernel.org/r/20240411145346.2516848-3-viro@zeniv.linux.org.uk
Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Christian Brauner <brauner@kernel.org>
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


