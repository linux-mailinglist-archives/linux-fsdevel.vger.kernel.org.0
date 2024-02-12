Return-Path: <linux-fsdevel+bounces-11091-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01BFD850DDB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 08:19:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3373E1C21136
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 07:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5C152AD2A;
	Mon, 12 Feb 2024 07:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qGm4DgDh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8792282F9;
	Mon, 12 Feb 2024 07:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707722080; cv=none; b=pY5dXmAfhKc/Tmyqz7pZcPnNzFGFP4xitXIsI0KLE+Ja2Q15Fh4EluEMByQ2JD/IWHFxPYgpUrkLV8NpBqhuGfJuD1fwDQ7vPgG5wilKXsdcoIRXIdPnkdt6McZ4Lv3j22SvyuDSZewuBSepPnayIBlsF0p5I+frVdka367d2WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707722080; c=relaxed/simple;
	bh=MKMZqD2/w+QWED2+pauhKDqx2bzrHQVvjTQI06WBrSw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E9f/ihYx8mQgbqpUG2zxIvNtBeYLYvwshJabEK0RZWsFCCL0ryR0+7nxtrv+T+H7moA8CCAF5i64oPTB0egZ06Lamfh7t6XVbGhAkyY/nfT2ATFXEJp9L8d4Ga/jOIaL6jrPmNzToQyJRj9xrrGKjJEvkIBnlCfvqNspm/whsnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qGm4DgDh; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=KFNTqb7k3Ymo30IuEwDaihs1yCQpUBV3RN+kFxOoV/I=; b=qGm4DgDhGagw28iocodC5iIhS6
	xsiMjPN63KLn6sFjMYCPL7iseVbubE2wS8w6bXJ+dcbmYvOHEWzOAZUcrSN0z9s6qgqeA4zE+v25Z
	Ieo4AhffrF+snI/gQkbKzpqjnhFvronw/KWUEfMYR/mvFkRA7Rkarbpg0iWyZZlXzrZJHp4jqfsi9
	q9boZv/wYg0kxsnUDqX9688gwSdlI9bqz14Z3r5AjizGcXXBELXp/TxTAsBR1zhWDROEl8xd9MQ6z
	QcXvVjnwYut7/ExXvXXIN3edVcs960N7aYgwjVh71uI9ph52Edo7WhetgJdrGm5ARyCfAEeyxZjds
	ynVt7v1g==;
Received: from [2001:4bb8:190:6eab:75e9:7295:a6e3:c35d] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZQWT-00000004T5c-0Fro;
	Mon, 12 Feb 2024 07:14:37 +0000
From: Christoph Hellwig <hch@lst.de>
To: linux-mm@kvack.org
Cc: Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.com>,
	David Howells <dhowells@redhat.com>,
	Brian Foster <bfoster@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 14/14] writeback: Remove a use of write_cache_pages() from do_writepages()
Date: Mon, 12 Feb 2024 08:13:48 +0100
Message-Id: <20240212071348.1369918-15-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240212071348.1369918-1-hch@lst.de>
References: <20240212071348.1369918-1-hch@lst.de>
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
Reviewed-by: Brian Foster <bfoster@redhat.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 mm/page-writeback.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 1996200849e577..2fd83d438f92bd 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2577,12 +2577,24 @@ int write_cache_pages(struct address_space *mapping,
 }
 EXPORT_SYMBOL(write_cache_pages);
 
-static int writepage_cb(struct folio *folio, struct writeback_control *wbc,
-		void *data)
+static int writeback_use_writepage(struct address_space *mapping,
+		struct writeback_control *wbc)
 {
-	struct address_space *mapping = data;
+	struct folio *folio = NULL;
+	struct blk_plug plug;
+	int err;
 
-	return mapping->a_ops->writepage(&folio->page, wbc);
+	blk_start_plug(&plug);
+	while ((folio = writeback_iter(mapping, wbc, folio, &err))) {
+		err = mapping->a_ops->writepage(&folio->page, wbc);
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
@@ -2598,12 +2610,7 @@ int do_writepages(struct address_space *mapping, struct writeback_control *wbc)
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


