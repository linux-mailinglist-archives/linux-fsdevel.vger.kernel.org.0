Return-Path: <linux-fsdevel+bounces-54508-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7226B0039C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 15:36:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 995BE1C80F86
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 13:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAF69265637;
	Thu, 10 Jul 2025 13:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TN76xHTh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C5C25A620;
	Thu, 10 Jul 2025 13:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752154461; cv=none; b=FMpLQ8tUgT9LY2lBaEFCri4dviHMDt+Cj4Z4u+iW0jm50b/f0fzBIsUKpu8+tqoJVg/1GhyUzjccBeObIT8bOJnBOT+JWK3ovXuOCSPfFQDyCBm+XeHf0+wkEBj3xjnqRp5lT9czBLaa+rntTOM+KsLucDeNu7ngnbKBvMSmiuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752154461; c=relaxed/simple;
	bh=TmCB231m1Zdjb/9uiccojQGKOwv3LF1sobaDUUYKziY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iTDkuSg8E85rl4Vw3vQri4h6m2prlEOFvJ5oea2oJBevN2n+h6GnN+irkHg4uaywBL+FkzH/Jb5HxJS2TI4Ah6CcIeQzBfZNsl8uTIfoZFhiZ3PmxzSswliV5WMmezGPr5ZGM0KCxm8RJS8TUvgS6sz04YpyETQZXT90VZa/Qjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=TN76xHTh; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=ESGkbd1ZhD2UuXNe2XB9ABnU6I9/LHgGKcrmxejQkIk=; b=TN76xHTh7Qb9jlWqpQlqs6RPFw
	75+UX2vuWL+50h5RFYreK30dFTffP1qTSR3H+6GuX06OMldYFYuEiC2tjjpTP18qaj2XnORJKK12o
	aQFRGctf7EK94xV9ctoxiExJgI8FBTRO4spHcC32ZiP115cUSuY1kY4M1Bu59VZHqC5C0uZLXiik+
	yS+SCDkuo96PzVkn81ulKKJwKg3KqWy2o3BDBDWFbDJaIwofLwO51QF+nrbM3ywbUET1UNCCkU19X
	hzdJUXuG926IhCGnfaNwdgydHKiPyIBH/itSkTdVIC9Hf4HTyntZv6/Alc3SCL4inXAWgfSNBmvSy
	Xq1IUrjQ==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZrPm-0000000BwZV-49zI;
	Thu, 10 Jul 2025 13:34:19 +0000
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Joanne Koong <joannelkoong@gmail.com>,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-block@vger.kernel.org,
	gfs2@lists.linux.dev
Subject: [PATCH 10/14] iomap: export iomap_writeback_folio
Date: Thu, 10 Jul 2025 15:33:34 +0200
Message-ID: <20250710133343.399917-11-hch@lst.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250710133343.399917-1-hch@lst.de>
References: <20250710133343.399917-1-hch@lst.de>
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
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/iomap/buffered-io.c | 4 ++--
 include/linux/iomap.h  | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index ca45a6d1cb68..b4b398e8bd54 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1634,8 +1634,7 @@ static bool iomap_writeback_handle_eof(struct folio *folio, struct inode *inode,
 	return true;
 }
 
-static int iomap_writeback_folio(struct iomap_writepage_ctx *wpc,
-		struct folio *folio)
+int iomap_writeback_folio(struct iomap_writepage_ctx *wpc, struct folio *folio)
 {
 	struct iomap_folio_state *ifs = folio->private;
 	struct inode *inode = wpc->inode;
@@ -1717,6 +1716,7 @@ static int iomap_writeback_folio(struct iomap_writepage_ctx *wpc,
 	mapping_set_error(inode->i_mapping, error);
 	return error;
 }
+EXPORT_SYMBOL_GPL(iomap_writeback_folio);
 
 int
 iomap_writepages(struct iomap_writepage_ctx *wpc)
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index cbf9d299a616..b65d3f063bb0 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -466,6 +466,7 @@ void iomap_start_folio_write(struct inode *inode, struct folio *folio,
 void iomap_finish_folio_write(struct inode *inode, struct folio *folio,
 		size_t len);
 
+int iomap_writeback_folio(struct iomap_writepage_ctx *wpc, struct folio *folio);
 int iomap_writepages(struct iomap_writepage_ctx *wpc);
 
 /*
-- 
2.47.2


