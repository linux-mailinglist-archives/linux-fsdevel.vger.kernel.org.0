Return-Path: <linux-fsdevel+bounces-37692-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A05DC9F5CDA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 03:27:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F1707A2CE6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 02:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C3A113D619;
	Wed, 18 Dec 2024 02:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YF8qki9A"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2C2487A5;
	Wed, 18 Dec 2024 02:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734488792; cv=none; b=VTtwon77Ig3wECHNw+aM5hUXreZxe7lJetjJcAS5LmvN80xE8r9EUuq9tNwiK6jE9EaNpHROT8rMctz33HmlyHrxovVcN8WeIPnuFwWoKi46SqhuPHquld885lPmJ6p3+Sy/l61hii1nkKO6FYs0Fgpx8zkfSZpCTJbCBR5r3NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734488792; c=relaxed/simple;
	bh=NIV9/pYL4zSBZEdju4ZrrpKy6bRxTm4c8YMNGicjqoU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tnZGk3L0Awa1JvxPr+j36cswPVYKbArGl2+F3YGy27GNUci06SZgf9LCB64cylDfjROb2i3ojaypW4JiY5SW9ONE05ZBVdus7cAi58EW88qmTyNQM4VkcZpNdyUnDl2kLu+vumx9uG/qqWBapUID04JlmNu2Lchj7KE0S/mSWNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YF8qki9A; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=/TZr4nFjkp9nWadpjSdHplXgIdajpwwrN5XnPc56j5k=; b=YF8qki9ApWj9O9QPiw4UQveFJ3
	NQfKB26z4bEkBtNfWRijXe1dUgTBw9CxUwpzJfYVsCd7Rq3m0PVX5FbT0zu4spnX3P2bTOWTbHIjs
	BBAKfLiuJkXTrFwI1eODbWULVvv7LXNdVU2+HPaC/SoEa6MMKjk6+1fI6cFnczLZBrKbdhlAH3uDF
	C9+9eaa4KZovy/GjDgqOnOaKmip06d+jjsyFjML7RHJ3Hdb+H55jjeq0uLDA47ZG/ZvAyfapr3C1p
	o6Hs0K+5NPo/jujeuy6EEI7JzJXKcEytrh6LDi/AUNYX0/j6taWl5O/Me4vjhI5OGY20dAqBWLowM
	qmN/oplQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tNjlc-0000000FOFW-1EJE;
	Wed, 18 Dec 2024 02:26:28 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: hare@suse.de,
	willy@infradead.org,
	dave@stgolabs.net,
	david@fromorbit.com,
	djwong@kernel.org,
	kbusch@kernel.org
Cc: john.g.garry@oracle.com,
	hch@lst.de,
	ritesh.list@gmail.com,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-mm@kvack.org,
	linux-block@vger.kernel.org,
	gost.dev@samsung.com,
	p.raghav@samsung.com,
	da.gomez@samsung.com,
	kernel@pankajraghav.com,
	mcgrof@kernel.org
Subject: [PATCH 3/5] fs/buffer: add a for_each_bh() for block_read_full_folio()
Date: Tue, 17 Dec 2024 18:26:24 -0800
Message-ID: <20241218022626.3668119-4-mcgrof@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241218022626.3668119-1-mcgrof@kernel.org>
References: <20241218022626.3668119-1-mcgrof@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>

We want to be able to work through all buffer heads on a folio
for an async read, but in the future we want to support the option
to stop before we've processed all linked buffer heads. To make
code easier to read and follow adopt a for_each_bh(tmp, head) loop
instead of using a do { ... } while () to make the code easier to
read and later be expanded in subsequent patches.

This introduces no functional changes.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 fs/buffer.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 8baf87db110d..1aeef7dd2281 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2397,6 +2397,17 @@ static void bh_read_batch_async(struct folio *folio,
 	}
 }
 
+#define bh_is_last(__bh, __head) ((__bh)->b_this_page == (__head))
+
+#define bh_next(__bh, __head) \
+    (bh_is_last(__bh, __head) ? NULL : (__bh)->b_this_page)
+
+/* Starts from the provided head */
+#define for_each_bh(__tmp, __head)			\
+    for ((__tmp) = (__head);				\
+         (__tmp);					\
+         (__tmp) = bh_next(__tmp, __head))
+
 /*
  * Generic "read_folio" function for block devices that have the normal
  * get_block functionality. This is most of the block device filesystems.
@@ -2426,13 +2437,14 @@ int block_read_full_folio(struct folio *folio, get_block_t *get_block)
 
 	iblock = div_u64(folio_pos(folio), blocksize);
 	lblock = div_u64(limit + blocksize - 1, blocksize);
-	bh = head;
 	nr = 0;
 
 	/* Stage one - collect buffer heads we need issue a read for */
-	do {
-		if (buffer_uptodate(bh))
+	for_each_bh(bh, head) {
+		if (buffer_uptodate(bh)) {
+			iblock++;
 			continue;
+		}
 
 		if (!buffer_mapped(bh)) {
 			int err = 0;
@@ -2449,17 +2461,21 @@ int block_read_full_folio(struct folio *folio, get_block_t *get_block)
 						blocksize);
 				if (!err)
 					set_buffer_uptodate(bh);
+				iblock++;
 				continue;
 			}
 			/*
 			 * get_block() might have updated the buffer
 			 * synchronously
 			 */
-			if (buffer_uptodate(bh))
+			if (buffer_uptodate(bh)) {
+				iblock++;
 				continue;
+			}
 		}
 		arr[nr++] = bh;
-	} while (iblock++, (bh = bh->b_this_page) != head);
+		iblock++;
+	}
 
 	bh_read_batch_async(folio, nr, arr, fully_mapped, nr == 0, page_error);
 
-- 
2.43.0


