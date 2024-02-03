Return-Path: <linux-fsdevel+bounces-10137-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41A1E848455
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Feb 2024 08:16:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D13021F2C38E
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Feb 2024 07:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDB1B57870;
	Sat,  3 Feb 2024 07:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FDgMugVo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12DB57312;
	Sat,  3 Feb 2024 07:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706944383; cv=none; b=r5Oyem+7ZgE1WWROLkNvCGkgY4dZucBYmiRCsY4LIa5QoHf5zW/Y8wWEPAF59CKTlyTx80goUK7AaM7pQ8R/Ct/SvwZIZPQtwSUy8BkdKJ/hcsg5hO2c+LWq9+DyTD3snoB1Gw35yKgs50Ywaw5l+JmdxpAeaFU9dD8y+p33jRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706944383; c=relaxed/simple;
	bh=tYS0fAOiFIhd5iBGGom3yizrN/cdEhJ6ynoZIQ4dwCQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GszER4YpHFfc30E+kaH4bydwNtrmHGRKiNv8irYRfiAWJMamf/4gqbgu7HuaIZAcPqqdvk8seGpCXf9sMJGGFvG2I5oxyL5XGmcv5oxotL+zwbpdZyMPK5CUTu/nra9sgmMyXmtlCFq/3AqlT4SRV3Z4G+lC0JVaHqr4RYYbtYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=FDgMugVo; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=aBLx8GrPTTpnrFrYwat6koWXvCPglp7/mI2LOOfVaJQ=; b=FDgMugVoB7MSUNHernp01Fwg/x
	MO+pR9JFMoCL9rwCqYotraUCpxDX06NW4fyeZ6vX5JPS0X8tpbgo7moefxhXVI67QAr0Xxmzp5E37
	psFmoZYeys27ykwrnviTUvz/SmbokAZR4N9bZEyFSFJOJlxuJ2QZbK1SuEFbb8Vdsk7p/XGeR7TL8
	+XGOB5d0OGem8uOS4FN4sM1iYvLyTDpZ+wlMffmwZiv2yPxszrIZH53rlSPctCCQy5qXCcVdpqrYW
	3kZ1BMlFOw32O9rX7U/qB7G4p6dLZExzOJuw2VLdjcwXSgL2j1i6HzWGmXtoS3nBfwUSXDi/FI0fc
	ndPdGBiw==;
Received: from [89.144.222.32] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rWACv-0000000FkMz-41QH;
	Sat, 03 Feb 2024 07:12:59 +0000
From: Christoph Hellwig <hch@lst.de>
To: linux-mm@kvack.org
Cc: Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.com>,
	David Howells <dhowells@redhat.com>,
	Brian Foster <bfoster@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 13/13] writeback: Remove a use of write_cache_pages() from do_writepages()
Date: Sat,  3 Feb 2024 08:11:47 +0100
Message-Id: <20240203071147.862076-14-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240203071147.862076-1-hch@lst.de>
References: <20240203071147.862076-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Use the new writeback_iter() directly instead of indirecting
through a callback.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
[hch: ported to the while based iter style]
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 mm/page-writeback.c | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 5fe4cdb7dbd61a..53ff2d8219ddb6 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2577,13 +2577,25 @@ int write_cache_pages(struct address_space *mapping,
 }
 EXPORT_SYMBOL(write_cache_pages);
 
-static int writepage_cb(struct folio *folio, struct writeback_control *wbc,
-		void *data)
+static int writeback_use_writepage(struct address_space *mapping,
+		struct writeback_control *wbc)
 {
-	struct address_space *mapping = data;
-	int ret = mapping->a_ops->writepage(&folio->page, wbc);
-	mapping_set_error(mapping, ret);
-	return ret;
+	struct folio *folio = NULL;
+	struct blk_plug plug;
+	int err;
+
+	blk_start_plug(&plug);
+	while ((folio = writeback_iter(mapping, wbc, folio, &err))) {
+		err = mapping->a_ops->writepage(&folio->page, wbc);
+		mapping_set_error(mapping, err);
+		if (err == AOP_WRITEPAGE_ACTIVATE) {
+			folio_unlock(folio);
+			err = 0;
+		}
+	}
+	blk_finish_plug(&plug);
+
+	return err;
 }
 
 int do_writepages(struct address_space *mapping, struct writeback_control *wbc)
@@ -2599,12 +2611,7 @@ int do_writepages(struct address_space *mapping, struct writeback_control *wbc)
 		if (mapping->a_ops->writepages) {
 			ret = mapping->a_ops->writepages(mapping, wbc);
 		} else if (mapping->a_ops->writepage) {
-			struct blk_plug plug;
-
-			blk_start_plug(&plug);
-			ret = write_cache_pages(mapping, wbc, writepage_cb,
-						mapping);
-			blk_finish_plug(&plug);
+			ret = writeback_use_writepage(mapping, wbc);
 		} else {
 			/* deal with chardevs and other special files */
 			ret = 0;
-- 
2.39.2


