Return-Path: <linux-fsdevel+bounces-1246-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0B877D8439
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Oct 2023 16:08:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07A841C20F51
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Oct 2023 14:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A02292E41E;
	Thu, 26 Oct 2023 14:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="QKW4VmSP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2927D2E3F5
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Oct 2023 14:08:47 +0000 (UTC)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC68F1B6;
	Thu, 26 Oct 2023 07:08:44 -0700 (PDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4SGSMC5Gj0z9sWp;
	Thu, 26 Oct 2023 16:08:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1698329319;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5R4EGfShOD0w/jE9kidAs7NQbrorkJlAAUpuwmTA4wg=;
	b=QKW4VmSPz3yGmbngc15+Gg3LaoO684U1RfeUaYWkeDhU/B9grB/oC7Z4ukq6wcF0tc4Znc
	tR11V9zazJ5gON7GIh8HE6XrzPLWUyrlp+DfhL5/LbInCUav9+XaeUuviApBaqJSAr0QUx
	wDXYyfmUKGXMCrDvysrboc4NkVSnAIlI4joZBsCyruAhvT3iQ/LM9vBBPk/1N4WpqneY3i
	9vE6Cq+SOVg/XTKX7Lv+NEx59lX1fT6JsCrvqUuuu1yetQbXLfFqVyXroUiRbX0jDluXsJ
	BBgvL45EUNdxilXjiQY718Xo6ygT/OVtpEImmq4GxVn9U54OIOL3AEVHaTKgMw==
From: Pankaj Raghav <kernel@pankajraghav.com>
To: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: willy@infradead.org,
	djwong@kernel.org,
	mcgrof@kernel.org,
	hch@lst.de,
	da.gomez@samsung.com,
	gost.dev@samsung.com,
	david@fromorbit.com,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH] iomap: fix iomap_dio_zero() for fs bs > system page size
Date: Thu, 26 Oct 2023 16:08:32 +0200
Message-Id: <20231026140832.1089824-1-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pankaj Raghav <p.raghav@samsung.com>

iomap_dio_zero() will pad a fs block with zeroes if the direct IO size
< fs block size. iomap_dio_zero() has an implicit assumption that fs block
size < page_size. This is true for most filesystems at the moment.

If the block size > page size (Large block sizes)[1], this will send the
contents of the page next to zero page(as len > PAGE_SIZE) to the
underlying block device, causing FS corruption.

iomap is a generic infrastructure and it should not make any assumptions
about the fs block size and the page size of the system.

Fixes: db074436f421 ("iomap: move the direct IO code into a separate file")
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>

[1] https://lore.kernel.org/lkml/20230915183848.1018717-1-kernel@pankajraghav.com/
---
I had initially planned on sending this as a part of LBS patches but I                                                                                                                                                                                                                                                  
think this can go as a standalone patch as it is a generic fix to iomap.                                                                                                                                                                                                                                                
                                                                                                                                                                                                                                                                                                                        
@Dave chinner This fixes the corruption issue you were seeing in                                                                                                                                                                                                                                                        
generic/091 for bs=64k in [2]                                                                                                                                                                                                                                                                                           
                                                                                                                                                                                                                                                                                                                        
[2] https://lore.kernel.org/lkml/ZQfbHloBUpDh+zCg@dread.disaster.area/

 fs/iomap/direct-io.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index bcd3f8cf5ea4..04f6c5548136 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -239,14 +239,23 @@ static void iomap_dio_zero(const struct iomap_iter *iter, struct iomap_dio *dio,
 	struct page *page = ZERO_PAGE(0);
 	struct bio *bio;
 
-	bio = iomap_dio_alloc_bio(iter, dio, 1, REQ_OP_WRITE | REQ_SYNC | REQ_IDLE);
+	WARN_ON_ONCE(len > (BIO_MAX_VECS * PAGE_SIZE));
+
+	bio = iomap_dio_alloc_bio(iter, dio, BIO_MAX_VECS,
+				  REQ_OP_WRITE | REQ_SYNC | REQ_IDLE);
 	fscrypt_set_bio_crypt_ctx(bio, inode, pos >> inode->i_blkbits,
 				  GFP_KERNEL);
+
 	bio->bi_iter.bi_sector = iomap_sector(&iter->iomap, pos);
 	bio->bi_private = dio;
 	bio->bi_end_io = iomap_dio_bio_end_io;
 
-	__bio_add_page(bio, page, len, 0);
+	while (len) {
+		unsigned int io_len = min_t(unsigned int, len, PAGE_SIZE);
+
+		__bio_add_page(bio, page, io_len, 0);
+		len -= io_len;
+	}
 	iomap_dio_submit_bio(iter, dio, bio, pos);
 }
 

base-commit: 05d3ef8bba77c1b5f98d941d8b2d4aeab8118ef1
-- 
2.40.1


