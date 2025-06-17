Return-Path: <linux-fsdevel+bounces-51889-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D649ADC8EC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 12:57:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 112287A1521
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 10:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66B832DF3FB;
	Tue, 17 Jun 2025 10:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LfJAxQrw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724D62DF3DC;
	Tue, 17 Jun 2025 10:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750157741; cv=none; b=nS/mkobOq1ezjP4KTGePTGI/h/gwr7eUNjmGMcKmEbWHd6K+sFHzJ4ELgcO9AcnURbjBNxZzBGBDhRBgIkGYE1x9gB03R2oGsXvOwCH6aAnee9s4NLa4WMhOWRREJJJKuGL2URYR576bQRH1lVQ7xmrpQUbAsgtKoca31AI/1os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750157741; c=relaxed/simple;
	bh=vyHMwmO+R42OEUuTT9Vwrr6xhiR8LTFCPML3/Rh3Mas=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NWQ1XRQ9fMcx0h9v3jNCtIGNHo+Qb8HreXvqHcn9uKOXoYJCuzJ+JRJafhxWsd/hWPLlyp6lH7ifnGiAPyvMlYRebNaML0BIWrixSdeBWPawg8+R50KCETnFTLlWP8Iap2tkcHcPYwJ4zf107D/Ap7meVZPmjqqiT1jtqJxxYpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LfJAxQrw; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=yjJ7dhTXDD8M04RA1Vul3cPRCux3xN3MgGuicjJaIjk=; b=LfJAxQrwD2UO8EQdYbKFAqG4Vx
	NPQEB/DKvUdQuTuSjodgjgoG0h6gdmCiDS95Hc+K4l7Qx5+3UId4IYxNbinAlg66l2jFpQrbyiLxl
	OIwkDfpacVJLfrNf4Lo4IP6MHr76UsRPSHtdsEgzxHhkxonFbShcRPo2uT+dhU3RWQN+g0NIkbSe1
	JaihDV+gpcLqng6341kaSe9yhqCnd7AxpyS30cQTvwlCkme3oMYhqg3D1OxivsS2lYlOnrf1/ShIS
	PcjW5d6wK6uyjHEOPYrzajLVlZ7ye5r30aGk7+GQYPz7g2dQrBOzUF0W8OtnK/hFRqIfjSKEzrWwZ
	zCdELm0w==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uRTyd-00000006yrr-31y4;
	Tue, 17 Jun 2025 10:55:40 +0000
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Joanne Koong <joannelkoong@gmail.com>,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-block@vger.kernel.org,
	gfs2@lists.linux.dev
Subject: [PATCH 09/11] iomap: export iomap_writeback_folio
Date: Tue, 17 Jun 2025 12:55:08 +0200
Message-ID: <20250617105514.3393938-10-hch@lst.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250617105514.3393938-1-hch@lst.de>
References: <20250617105514.3393938-1-hch@lst.de>
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
---
 fs/iomap/buffered-io.c | 4 ++--
 include/linux/iomap.h  | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 2973fced2a52..d7fa885b1a0c 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1638,8 +1638,7 @@ static bool iomap_writeback_handle_eof(struct folio *folio, struct inode *inode,
 	return true;
 }
 
-static int iomap_writeback_folio(struct iomap_writepage_ctx *wpc,
-		struct folio *folio)
+int iomap_writeback_folio(struct iomap_writepage_ctx *wpc, struct folio *folio)
 {
 	struct iomap_folio_state *ifs = folio->private;
 	struct inode *inode = wpc->inode;
@@ -1721,6 +1720,7 @@ static int iomap_writeback_folio(struct iomap_writepage_ctx *wpc,
 	mapping_set_error(inode->i_mapping, error);
 	return error;
 }
+EXPORT_SYMBOL_GPL(iomap_writeback_folio);
 
 int
 iomap_writepages(struct iomap_writepage_ctx *wpc)
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index bfd178fb7cfc..7e06b3a392f8 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -465,6 +465,7 @@ void iomap_start_folio_write(struct inode *inode, struct folio *folio,
 		size_t len);
 void iomap_finish_folio_write(struct inode *inode, struct folio *folio,
 		size_t len);
+int iomap_writeback_folio(struct iomap_writepage_ctx *wpc, struct folio *folio);
 int iomap_writepages(struct iomap_writepage_ctx *wpc);
 
 /*
-- 
2.47.2


