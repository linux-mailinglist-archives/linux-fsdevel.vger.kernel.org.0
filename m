Return-Path: <linux-fsdevel+bounces-28248-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3276F968815
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 14:57:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97362B20FFD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 12:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345431DAC47;
	Mon,  2 Sep 2024 12:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="V79wYxoF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39CA19C54C;
	Mon,  2 Sep 2024 12:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725281862; cv=none; b=se1ZSdsoXdBll94sRryQbY6L+XzU7YsFlwpW3SBEc72/zbn9GVhiuCxHTjlRnEOMOfcS3A0kXDHVPE0M3qqRL/M8+WEBo2CscZUpSuMjGSj4x0765VrS+7ZBDQzSlgdPzpX4bc3PBXKqff+JDoRD/UBH5wXx/1t+mA/E1zUSWj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725281862; c=relaxed/simple;
	bh=2Xz+cdrNUOCcOx7UKStcKEaoSYj24YmjqX72woDI7JU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=smBIDztc6Ix5zAQPElGkxmyzG5FRG1Mw4cKasfIrp5oHQiPV4lctOyAkqK2XiqfR9hdBDCX245cuMu0sPIOv8fUxy3DDJsEvv5pAQt7jvlEIT1W2XRH9qMBw+vH9C3WMXt7O2lQqPuOJ6jbd2GZTHIddUY+RBcrDLAQhpKsdkdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=V79wYxoF; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4Wy7rg0Fg5z9tRr;
	Mon,  2 Sep 2024 14:50:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1725281411;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zgNc4EUwevKoCFWkdis1bQilpGFIfwwlx7wOLIpzp8s=;
	b=V79wYxoFzz1cEfBpOLqEapMqH2GHIEkrnAlVAvhW9w6uJGoUvEo6nSXNpdBshWQUIqwZbR
	aGxoI+f2us3gFlrZNiEg4mpJ6o+Jhb0ulFG35wHmthyEUyFHS8eRaYFzrcPpVFy4kAdjoX
	tt1iq5gT4xDKLScygAVUa0JFh/58eugbWEv40ybmGAQ5GYa4n9JXrubJAIFOvHMbfHLPFB
	/3VbztVOKNji5vBocpsOE/I+MSHfnmX9haTSkjonrniUZHWv9Tv0mPW+uVn8hT7bXie2nG
	EsOS0LHht3Ntc6fUVyB4nwJGIoov9AkdhK13rWjME0ZLZf7N9W3Zexx32IOk4g==
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: brauner@kernel.org,
	sfr@canb.auug.org.au,
	akpm@linux-foundation.org
Cc: linux-next@vger.kernel.org,
	mcgrof@kernel.org,
	willy@infradead.org,
	ziy@nvidia.com,
	da.gomez@samsung.com,
	kernel@pankajraghav.com,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	Pankaj Raghav <p.raghav@samsung.com>,
	Sven Schnelle <svens@linux.ibm.com>
Subject: [PATCH] mm: don't convert the page to folio before splitting in split_huge_page()
Date: Mon,  2 Sep 2024 14:49:32 +0200
Message-ID: <20240902124931.506061-2-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pankaj Raghav <p.raghav@samsung.com>

Sven reported that a commit from bs > ps series was breaking the ksm ltp
test[1].

split_huge_page() takes precisely a page that is locked, and it also
expects the folio that contains that page to be locked after that
huge page has been split. The changes introduced converted the page to
folio, and passed the head page to be split, which might not be locked,
resulting in a kernel panic.

This commit fixes it by always passing the correct page to be split from
split_huge_page() with the appropriate minimum order for splitting.

[1] https://lore.kernel.org/linux-xfs/yt9dttf3r49e.fsf@linux.ibm.com/
Reported-by: Sven Schnelle <svens@linux.ibm.com>
Fixes: fd031210c9ce ("mm: split a folio in minimum folio order chunks")
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
This applies to the vfs.blocksize branch on the vfs tree.

@Christian, Stephen already sent a mail saying that there is a conflict
with these changes and mm-unstable. For now, I have based these patches
out of your tree. Let me know if you need the same patch based on
linux-next.

 include/linux/huge_mm.h | 16 +++++++++++++++-
 mm/huge_memory.c        | 21 +++++++++++++--------
 2 files changed, 28 insertions(+), 9 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 7c50aeed0522..7a570e0437c9 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -319,10 +319,24 @@ unsigned long thp_get_unmapped_area_vmflags(struct file *filp, unsigned long add
 bool can_split_folio(struct folio *folio, int *pextra_pins);
 int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
 		unsigned int new_order);
+int min_order_for_split(struct folio *folio);
 int split_folio_to_list(struct folio *folio, struct list_head *list);
 static inline int split_huge_page(struct page *page)
 {
-	return split_folio(page_folio(page));
+	struct folio *folio = page_folio(page);
+	int ret = min_order_for_split(folio);
+
+	if (ret < 0)
+		return ret;
+
+	/*
+	 * split_huge_page() locks the page before splitting and
+	 * expects the same page that has been split to be locked when
+	 * returned. split_folio(page_folio(page)) cannot be used here
+	 * because it converts the page to folio and passes the head
+	 * page to be split.
+	 */
+	return split_huge_page_to_list_to_order(page, NULL, ret);
 }
 void deferred_split_folio(struct folio *folio);
 
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index c29af9451d92..9931ff1d9a9d 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3297,12 +3297,10 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
 	return ret;
 }
 
-int split_folio_to_list(struct folio *folio, struct list_head *list)
+int min_order_for_split(struct folio *folio)
 {
-	unsigned int min_order = 0;
-
 	if (folio_test_anon(folio))
-		goto out;
+		return 0;
 
 	if (!folio->mapping) {
 		if (folio_test_pmd_mappable(folio))
@@ -3310,10 +3308,17 @@ int split_folio_to_list(struct folio *folio, struct list_head *list)
 		return -EBUSY;
 	}
 
-	min_order = mapping_min_folio_order(folio->mapping);
-out:
-	return split_huge_page_to_list_to_order(&folio->page, list,
-							min_order);
+	return mapping_min_folio_order(folio->mapping);
+}
+
+int split_folio_to_list(struct folio *folio, struct list_head *list)
+{
+	int ret = min_order_for_split(folio);
+
+	if (ret < 0)
+		return ret;
+
+	return split_huge_page_to_list_to_order(&folio->page, list, ret);
 }
 
 void __folio_undo_large_rmappable(struct folio *folio)
-- 
2.44.1


