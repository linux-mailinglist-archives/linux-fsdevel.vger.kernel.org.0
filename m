Return-Path: <linux-fsdevel+bounces-10125-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55525848431
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Feb 2024 08:12:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8851D1C21809
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Feb 2024 07:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 187084E1AD;
	Sat,  3 Feb 2024 07:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZOhz2dNr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B22F4D5B0;
	Sat,  3 Feb 2024 07:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706944330; cv=none; b=BsprzeZdkadbap1pTM5j82xcz/Sai2Z1MqkTGzF1ZuQJ6T786TbEbArEutqdtjVPZKOpt0taSFKPOCDcDXYYJcubInihcyCeqUgccO7rZReqNulEaSkCBCuuVNb4fPEfEIa7ELgX7w4SUqKAf4v8WlVHmNyCTpDJi1bFJrNikME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706944330; c=relaxed/simple;
	bh=Zp3cCLINEokOiPdXtcRCwweX4H6+xgszIGGxoW504HM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fU2KTsHtrish3vlblW198tpQCrAUlbLUgx6jcHLyR2IE+aCCKbCJENaK/J3iUmsRqbd0YvAUQj2qGrotxwG9a2uOx9XAkY2hlsbph0OAXCsl4K8pv1lcmaSMQvi/AEbypiOWdFBTjRTcV4FN62+RMiu1TTsufnQiPlTwA7Y5TPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZOhz2dNr; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=+lqvdXiJyeUBbv4RbCH+VsOF1ziPvzDxge6GroiRQvo=; b=ZOhz2dNrO2v9ls+tKOcQisMqRw
	d5QuM/23JepzSn1b7ipMDrTGniaboVzWpHlnXVcGXa/5j3pXzLv+92C4aMfdx5zI3LbWA1MpvxCKY
	bo5W1UBMWQIb6eFnzTI/vzwvbwoBSgimQvqAnr4GR3VdEvx2+dwJV10G4DEkR22tfac+AReRnaJYt
	h8GYwOYQFl5wxKZuROP6cuiRFwtrXGNKDtwvUJ/AVmUSktYdhaOMlOIIiUBh0PUyP/XuwiXXGy5pe
	XAktdBAhJf6YF2Km1CmRkcfi4sKlQTSHJQ5IcNX27jo73jG7Abl322/EiFmIEHqxYUnLKATMNc3uf
	Qhck81Xg==;
Received: from [89.144.222.32] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rWAC3-0000000Fjy5-2qvp;
	Sat, 03 Feb 2024 07:12:04 +0000
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
	linux-kernel@vger.kernel.org,
	Jan Kara <jack@suse.cz>,
	Dave Chinner <dchinner@redhat.com>
Subject: [PATCH 01/13] writeback: remove a duplicate prototype for tag_pages_for_writeback
Date: Sat,  3 Feb 2024 08:11:35 +0100
Message-Id: <20240203071147.862076-2-hch@lst.de>
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

Signed-off-by: Christoph Hellwig <hch@lst.de>
[hch: split from a larger patch]
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Brian Foster <bfoster@redhat.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Acked-by: Dave Chinner <dchinner@redhat.com>
---
 include/linux/writeback.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/writeback.h b/include/linux/writeback.h
index 453736fd1d23ce..4b8cf9e4810bad 100644
--- a/include/linux/writeback.h
+++ b/include/linux/writeback.h
@@ -363,8 +363,6 @@ bool wb_over_bg_thresh(struct bdi_writeback *wb);
 typedef int (*writepage_t)(struct folio *folio, struct writeback_control *wbc,
 				void *data);
 
-void tag_pages_for_writeback(struct address_space *mapping,
-			     pgoff_t start, pgoff_t end);
 int write_cache_pages(struct address_space *mapping,
 		      struct writeback_control *wbc, writepage_t writepage,
 		      void *data);
-- 
2.39.2


