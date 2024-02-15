Return-Path: <linux-fsdevel+bounces-11641-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6389855A86
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 07:37:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F0B2B286C2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 06:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB352C15B;
	Thu, 15 Feb 2024 06:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Rp1jtgBv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABEC9476;
	Thu, 15 Feb 2024 06:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707979026; cv=none; b=ktAAiAZGsD0prMfLiHk6Q06YmEVYIcdzCUCEtbhX1aLDelMg+clGG6DcL7f6iOm/vPa6rs1yyN/knIHS4t+E9UCfczU/PH4j1ZdxnTSU2tHdcV3J4ouf6ikrAsiRgqPeLLnGRnlGUUhsaINAQ7r+0vU4sbuL8RXV5a+BPd+l7Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707979026; c=relaxed/simple;
	bh=aPm+OiNHWi8D36QxBnxio15TjcV5ayggWQWJmM7uKJI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UXCtIB92CEqj09zs+4ipqzHoQ3AUyJsTRle+FeAWPAVbW/rsLHgSH4OBSIVMBgyGdJ8aTej0yVbIhw5WpD+J3SqmPhHjUw5Nt3RdAte2vDjS+dVRTFXraO21gcj510hbo+cmNmTOUfIHuq8rPJ3aB/781HkXJTU67veayGtQNXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Rp1jtgBv; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=5GhhuDyIOonlmDg/Vr+y+ffKK6l+9T3rNZ2pDiaN6Ho=; b=Rp1jtgBvUtxVvNXp1sP56Ko4Aa
	gktEnrNCtkAvu7DLUea8tY8oFyjpctbtKJQBqAp/Y3F+AZE9f2WmupbVNkGAO/jVSuRg5osa1TJDa
	5HXAMzm+rMKBxQw9f7g4YK38K2o2ZFM+2H8bJ08bAzZkL1d+WINW1Y+Pyn5UTq5dBzEnZ+yjgvrFc
	sTCCoQbU4LXqQbKUy6a6VISm3ggtoKihCXjmjG39/Ss9iIJFzecFVDLrIGrRf0JkdJcMjIRDWvDvB
	W0RXMYe1UBA0Vz6LnvyBO7Kbu6iVlmtQLIc/rbe6hSdf+UvEL+qMgQSU3ERH/uI3ylw1dPHiRL5cL
	kWnYLxfQ==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1raVMj-0000000F6rJ-3g8h;
	Thu, 15 Feb 2024 06:37:02 +0000
From: Christoph Hellwig <hch@lst.de>
To: linux-mm@kvack.org
Cc: Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.com>,
	David Howells <dhowells@redhat.com>,
	Brian Foster <bfoster@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 01/14] writeback: don't call mapping_set_error on AOP_WRITEPAGE_ACTIVATE
Date: Thu, 15 Feb 2024 07:36:36 +0100
Message-Id: <20240215063649.2164017-2-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240215063649.2164017-1-hch@lst.de>
References: <20240215063649.2164017-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

mapping_set_error should only be called on 0 returns (which it ignores)
or a negative error code.

writepage_cb ends up being able to call writepage_cb on the magic
AOP_WRITEPAGE_ACTIVATE return value from ->writepage which means
success but the caller needs to unlock the page.  Ignore that and
just call mapping_set_error on negative errors.

(no fixes tag as this goes back more than 20 years over various renames
 and refactors so I've given up chasing down the original introduction)

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 mm/page-writeback.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 3f255534986a2f..703e83c69ffe08 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2535,7 +2535,9 @@ static int writepage_cb(struct folio *folio, struct writeback_control *wbc,
 {
 	struct address_space *mapping = data;
 	int ret = mapping->a_ops->writepage(&folio->page, wbc);
-	mapping_set_error(mapping, ret);
+
+	if (ret < 0)
+		mapping_set_error(mapping, ret);
 	return ret;
 }
 
-- 
2.39.2


