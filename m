Return-Path: <linux-fsdevel+bounces-37415-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DEAA9F1C5A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Dec 2024 04:12:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D68217A0475
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Dec 2024 03:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06BF2180A80;
	Sat, 14 Dec 2024 03:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="y+Vot3PJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B811401C;
	Sat, 14 Dec 2024 03:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734145862; cv=none; b=NLphXPXRJO1cP2GadUHCVXzngjv7O04FbheJtgLAxj4rsV/5sOYsI7/LQTxqMkokKxC0ce5SbkSkD7lm5a4VxAwFrFG67MLQmKDYQ7Mnyf2OWZC+ubK9YveBKZiqh2axCajJyK0Szqh+XdpcXdz/B6C8Aw0kkZApiKEHoSaRYfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734145862; c=relaxed/simple;
	bh=vEzp21Qt7bdEDcirqhV48PHN9Uws+42ZUaIYtjNb4MQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oifTes4WWaSRADvou6hC1epjZHeqcKpYYhxxp21Lu0/k65iGMcARlk2C0xOl8sS0nVRnZB4dn/1GEn6Guy4sz043Qxj/Z8iX5tBsQA8VzMpFsOWOEb98qMMflYcycOhUDr0IOkln9kTIVBbBy4b+KgYG43JQJNeq/kzIbrGxAPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=y+Vot3PJ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=ly9Z0m8eTHU3wfdp35JFAoonrPj9YJ5xpu33d2EAXi4=; b=y+Vot3PJozFxtHqZ7Fp9JDbo4c
	jsrflL/YvKop7QmnivqVS3/9cSOrtdNg1NZt87O4y3Fo0P3YmFEh9/6/z11Ef8JQPkW11UbAml0SX
	dB33hD26ixC0mXy6W9q36zaEDrc+EuP2Gay4kESD2wcM+A4tuvYvCRryQz1gZrGPfX6i8p2pffDWZ
	DouswSptmAW/mI1zWobDfnT0kYB+yzVgSHn87hRfSub8MYVWaJdRL+WpipyflNXZIoh8fl/YQ4MMU
	hxiYm95uqF/bNOR2mx96TdbdT1NVHq4GImAWGKf8IHWbdAstSa0ejAnvTpz9mLIlOtxuybuU1h404
	JfGexPMg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tMIYN-00000005c3Z-3ONS;
	Sat, 14 Dec 2024 03:10:51 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: willy@infradead.org,
	hch@lst.de,
	hare@suse.de,
	dave@stgolabs.net,
	david@fromorbit.com,
	djwong@kernel.org
Cc: john.g.garry@oracle.com,
	ritesh.list@gmail.com,
	kbusch@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-mm@kvack.org,
	linux-block@vger.kernel.org,
	gost.dev@samsung.com,
	p.raghav@samsung.com,
	da.gomez@samsung.com,
	kernel@pankajraghav.com,
	mcgrof@kernel.org
Subject: [RFC v2 02/11] fs/buffer: add a for_each_bh() for block_read_full_folio()
Date: Fri, 13 Dec 2024 19:10:40 -0800
Message-ID: <20241214031050.1337920-3-mcgrof@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241214031050.1337920-1-mcgrof@kernel.org>
References: <20241214031050.1337920-1-mcgrof@kernel.org>
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

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 fs/buffer.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 580451337efa..108e1c36fc1a 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2392,6 +2392,17 @@ static void bh_read_batch_async(struct folio *folio,
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
@@ -2421,11 +2432,10 @@ int block_read_full_folio(struct folio *folio, get_block_t *get_block)
 
 	iblock = div_u64(folio_pos(folio), blocksize);
 	lblock = div_u64(limit + blocksize - 1, blocksize);
-	bh = head;
 	nr = 0;
 	i = 0;
 
-	do {
+	for_each_bh(bh, head) {
 		if (buffer_uptodate(bh))
 			continue;
 
@@ -2454,7 +2464,9 @@ int block_read_full_folio(struct folio *folio, get_block_t *get_block)
 				continue;
 		}
 		arr[nr++] = bh;
-	} while (i++, iblock++, (bh = bh->b_this_page) != head);
+		i++;
+		iblock++;
+	}
 
 	bh_read_batch_async(folio, nr, arr, fully_mapped, nr == 0, page_error);
 
-- 
2.43.0


