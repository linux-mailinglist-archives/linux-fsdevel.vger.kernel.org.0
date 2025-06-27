Return-Path: <linux-fsdevel+bounces-53150-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0348AEAFAB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jun 2025 09:05:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2201E6A06DD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jun 2025 07:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 500F7225397;
	Fri, 27 Jun 2025 07:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="z5pwcu3/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09A621ABCF;
	Fri, 27 Jun 2025 07:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751007839; cv=none; b=n6AcZ4dESiLVXF0iDpT0pFhRtGFg5AOFD6Yo7OBSBvwino7ll5XpxcnacxKjKX35v/v5EMR8kW7/HKeN8dS7q/pmAcCN/INgsep/COF7AG10p9lFhp+MwjKhk6iFXicuMKsaWFp4dKGSiprymhIVBKjijPcuwhl2VR3x6NacCYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751007839; c=relaxed/simple;
	bh=+Ay59gf5yFuA/lSkWGBN+rawh293xEkIyigCPw9hirg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HcwKzJEPn5U/7CJBR/vOIditHnPP0LbeEh547e9r+hgEHw8Gdb+lL2ZxKxJtLDhKIFp8mBtasGTNWm2Q0MgTqEVAdVcOI/MeJivpsocXRM7AjUlQcGHzvW4gGh+5Uvb+GCmWKAK/D2Eu4Cdu7YWuloPO9Lz2zbiciinKfVRe/nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=z5pwcu3/; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=hQm3oLYv5issJPxqHbNnfthBfCKxtQkQPr7ZnrM6bxk=; b=z5pwcu3/wwJFb8lWsJtisAFOqx
	I8w6t4gj2SwqNv8kyPCvyloTjInSw5t5ZLKZi7pzMa5gReBwuVNFqxSg0hmfbvV8b5QruB/kT8xCH
	UNklIFuDKRc5Tfk+6ceU6BQcDILcpUzbRvRwU/Ed9xkrg+jB8WoNWPPhasahe1LD+XBPDFtUO+oVR
	aM5X8FaawayKNdVJzkdWJ2qivs10kL6uG/VmCO7mvGLa24rcbnq60AaDRyrc5oDrk0Vnkp1td9sSH
	X3pRKxYoeB5U7rA7/LoopBsfcO/QHgXNIByYpsmxap1bUz8+VEIxI+DwNFOyxRFGS8mX4KIVA3M6b
	jm1RAbMg==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uV37s-0000000Dm0L-2TEh;
	Fri, 27 Jun 2025 07:03:57 +0000
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Joanne Koong <joannelkoong@gmail.com>,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-block@vger.kernel.org,
	gfs2@lists.linux.dev
Subject: [PATCH 09/12] iomap: export iomap_writeback_folio
Date: Fri, 27 Jun 2025 09:02:42 +0200
Message-ID: <20250627070328.975394-10-hch@lst.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250627070328.975394-1-hch@lst.de>
References: <20250627070328.975394-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Allow fuse to use iomap_writeback_folio for folio laundering.  Note
that the caller needs to manually submit the pending writeback context.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/iomap/buffered-io.c | 4 ++--
 include/linux/iomap.h  | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index a1dccf4e7063..18ae896bcfcc 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1638,8 +1638,7 @@ static bool iomap_writeback_handle_eof(struct folio *folio, struct inode *inode,
 	return true;
 }
 
-static int iomap_writeback_folio(struct iomap_writeback_ctx *wpc,
-		struct folio *folio)
+int iomap_writeback_folio(struct iomap_writeback_ctx *wpc, struct folio *folio)
 {
 	struct iomap_folio_state *ifs = folio->private;
 	struct inode *inode = wpc->inode;
@@ -1721,6 +1720,7 @@ static int iomap_writeback_folio(struct iomap_writeback_ctx *wpc,
 	mapping_set_error(inode->i_mapping, error);
 	return error;
 }
+EXPORT_SYMBOL_GPL(iomap_writeback_folio);
 
 int
 iomap_writepages(struct iomap_writeback_ctx *wpc)
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 1a07d8fa9459..568a246f949b 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -465,6 +465,7 @@ void iomap_start_folio_write(struct inode *inode, struct folio *folio,
 		size_t len);
 void iomap_finish_folio_write(struct inode *inode, struct folio *folio,
 		size_t len);
+int iomap_writeback_folio(struct iomap_writeback_ctx *wpc, struct folio *folio);
 int iomap_writepages(struct iomap_writeback_ctx *wpc);
 
 /*
-- 
2.47.2


