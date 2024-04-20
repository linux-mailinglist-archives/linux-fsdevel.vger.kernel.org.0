Return-Path: <linux-fsdevel+bounces-17333-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE2BE8AB8ED
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Apr 2024 04:51:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E01B71C20C2F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Apr 2024 02:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA8714A8C;
	Sat, 20 Apr 2024 02:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BnR6+cuO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD8E524A;
	Sat, 20 Apr 2024 02:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713581455; cv=none; b=SHQQjknjLpiIE4p6xdiJEhM6FUBUMPfvmE7ysERDuivN3TZyem6sa5Cpzu1uLbHtraneuxj3uuOe42Gm3aYDdOpgKQ2gArwYzsrv1hYT+RniXuE3XT1X+Ja7mpALdp0izXzMlnPTgTLcGWPkq3jJfuOBcBxNMlTgPtFFvfy61Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713581455; c=relaxed/simple;
	bh=ViXNIW1SLdv0nde+ZVI4iGu52qH5oiMusV+Y9g+vLlI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JGF6aNw6LD/u8aBK+WpF4d9BGhBhPcYyQXAjp4hJj48iuijS04p7ACGa+U10QVn444H9vms3rN42s8J6UC1vVV+5Gene11Wwl2QBL7lqXgm/OdLIWk+DWtXO2G/47WONUEbRd3+JYmwhALs2xT5SahX31pVpMRb/oeLj777FKkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BnR6+cuO; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=chzZuDfvyKueDkxp43gj4gyRB7S/U2vP2n7I3PARTas=; b=BnR6+cuOapGQsp32FKIMq8Mimc
	2KW+31ziJ4ibIcoDLYHEjZvGYs/MhFlYzKnMpNAQ5p7Fxm8hLRhvvioeCFvJYiXtkTXBNmpsYWsvu
	qHJLjrzYF2yEczWaDAwfwHNXHn0nyc1TbNcM7sAOGR8/H+Ay0EQSWkeAfBw4+smJguBQ31F7tstaW
	Uv0bazg+RQ6iiuw1fTmVZkgdVOn6Q841hgPjx+LqYrIDv1+nlwKi60rpJPoUkllo/FTxxAA5bHcDu
	71mr0uwWIwlkAiIC9NaxGBc8+PzZrpfXqBN6DU8NynAJiyhqp6v7iAT8lvYQ5xQcNVO364N6TUShN
	7b11pzhA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ry0oR-000000095eP-2qd4;
	Sat, 20 Apr 2024 02:50:47 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Brian Foster <bfoster@redhat.com>,
	linux-bcachefs@vger.kernel.org
Subject: [PATCH 06/30] bcachefs: Remove calls to folio_set_error
Date: Sat, 20 Apr 2024 03:50:01 +0100
Message-ID: <20240420025029.2166544-7-willy@infradead.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240420025029.2166544-1-willy@infradead.org>
References: <20240420025029.2166544-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Common code doesn't test the error flag, so we don't need to set it in
bcachefs.  We can use folio_end_read() to combine the setting (or not)
of the uptodate flag and clearing the lock flag.

Cc: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Brian Foster <bfoster@redhat.com>
Cc: linux-bcachefs@vger.kernel.org
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/bcachefs/fs-io-buffered.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/fs/bcachefs/fs-io-buffered.c b/fs/bcachefs/fs-io-buffered.c
index 39292e7ef342..4bff641b8be6 100644
--- a/fs/bcachefs/fs-io-buffered.c
+++ b/fs/bcachefs/fs-io-buffered.c
@@ -30,15 +30,8 @@ static void bch2_readpages_end_io(struct bio *bio)
 {
 	struct folio_iter fi;
 
-	bio_for_each_folio_all(fi, bio) {
-		if (!bio->bi_status) {
-			folio_mark_uptodate(fi.folio);
-		} else {
-			folio_clear_uptodate(fi.folio);
-			folio_set_error(fi.folio);
-		}
-		folio_unlock(fi.folio);
-	}
+	bio_for_each_folio_all(fi, bio)
+		folio_end_read(fi.folio, bio->bi_status == BLK_STS_OK);
 
 	bio_put(bio);
 }
@@ -408,7 +401,6 @@ static void bch2_writepage_io_done(struct bch_write_op *op)
 		bio_for_each_folio_all(fi, bio) {
 			struct bch_folio *s;
 
-			folio_set_error(fi.folio);
 			mapping_set_error(fi.folio->mapping, -EIO);
 
 			s = __bch2_folio(fi.folio);
-- 
2.43.0


