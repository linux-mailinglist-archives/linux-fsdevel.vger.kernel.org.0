Return-Path: <linux-fsdevel+bounces-7776-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D5782A873
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jan 2024 08:37:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36A5D2819D0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jan 2024 07:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 307B1D294;
	Thu, 11 Jan 2024 07:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YsepFaiS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D21D27D;
	Thu, 11 Jan 2024 07:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=86lzbsT3tHHU5IGJayzM10iebi9uekS0Ew74ZP6MAfg=; b=YsepFaiSqx0RO4qH4yw0MQrHjS
	TGtO9iIWtmd/891g+N1xnAXCKRg8QJNUDDAPy6IKqCt5mpALwfbdbpfMPsFceElDnt1LnTcuYpMXN
	qC7IXHjyAEoJ9FLqvh6x/vWlz695RiU4ay75VFO3gT8t7bjOli3WXh9VNLJGP+T8Ic/M92aPzfsyt
	ChDiDo+HEP6w4PApBIHTpq1ePgFpEoIYrepoL9ZhRDBEXdiVkGuJLbr6yIH4Ua0KCprek+37HEKaK
	PiCofkB/8xX5BBZJ+XNDkdLxtWjEHyiYiSuSgRWElGmoIupXhIF+4KFk032+84+00hGNm9L63jv4B
	1HL8cFYA==;
Received: from [2001:4bb8:191:2f6b:63ff:a340:8ed1:7cd5] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rNpcY-00GKDk-31;
	Thu, 11 Jan 2024 07:36:59 +0000
From: Christoph Hellwig <hch@lst.de>
To: kent.overstreet@linux.dev,
	bfoster@redhat.com
Cc: linux-bcachefs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH] bcachefs: fix incorrect usage of REQ_OP_FLUSH
Date: Thu, 11 Jan 2024 08:36:55 +0100
Message-Id: <20240111073655.2095423-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

REQ_OP_FLUSH is only for internal use in the blk-mq and request based
drivers. File systems and other block layer consumers must use
REQ_OP_WRITE | REQ_PREFLUSH as documented in
Documentation/block/writeback_cache_control.rst.

While REQ_OP_FLUSH appears to work for blk-mq drivers it does not
get the proper flush state machine handling, and completely fails
for any bio based drivers, including all the stacking drivers.  The
block layer will also get a check in 6.8 to reject this use case
entirely.

[Note: completely untested, but as this never got fixed since the
original bug report in November:

   https://bugzilla.kernel.org/show_bug.cgi?id=218184

and the the discussion in December:

    https://lore.kernel.org/all/20231221053016.72cqcfg46vxwohcj@moria.home.lan/T/

this seems to be best way to force it]

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/bcachefs/fs-io.c      | 2 +-
 fs/bcachefs/journal_io.c | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/bcachefs/fs-io.c b/fs/bcachefs/fs-io.c
index b0e8144ec5500c..a8500af6c7438f 100644
--- a/fs/bcachefs/fs-io.c
+++ b/fs/bcachefs/fs-io.c
@@ -79,7 +79,7 @@ void bch2_inode_flush_nocow_writes_async(struct bch_fs *c,
 			continue;
 
 		bio = container_of(bio_alloc_bioset(ca->disk_sb.bdev, 0,
-						    REQ_OP_FLUSH,
+						    REQ_OP_WRITE | REQ_PREFLUSH,
 						    GFP_KERNEL,
 						    &c->nocow_flush_bioset),
 				   struct nocow_flush, bio);
diff --git a/fs/bcachefs/journal_io.c b/fs/bcachefs/journal_io.c
index 3eb6c3f62a811b..43c76c9ad9a316 100644
--- a/fs/bcachefs/journal_io.c
+++ b/fs/bcachefs/journal_io.c
@@ -1948,7 +1948,8 @@ CLOSURE_CALLBACK(bch2_journal_write)
 			percpu_ref_get(&ca->io_ref);
 
 			bio = ca->journal.bio;
-			bio_reset(bio, ca->disk_sb.bdev, REQ_OP_FLUSH);
+			bio_reset(bio, ca->disk_sb.bdev,
+					REQ_OP_WRITE | REQ_PREFLUSH),
 			bio->bi_end_io		= journal_write_endio;
 			bio->bi_private		= ca;
 			closure_bio_submit(bio, cl);
-- 
2.39.2


