Return-Path: <linux-fsdevel+bounces-30806-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1DC698E64E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 00:52:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B9B01F214AA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 22:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E5BE19CC31;
	Wed,  2 Oct 2024 22:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QqsHM7qm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA7719ABD1
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Oct 2024 22:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727909537; cv=none; b=ACbMR1cwiRXO3ta9RWD3K96l2+6MKhNFUpcWNAN1wF2Vmdi4SCCryvj+97NH5MiZEqtoRiWs5l/08DAFaNkvYtedj9hQv/o1rtrhZgPF+U0phTK/Um6Gc0sOVyZ0l4JiE8T5Llba+AkFxa+noTRUNzqTyigAiOAWSKdnrSon3+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727909537; c=relaxed/simple;
	bh=TJjVq2xhqxA+OE+q8HER+5Ws3yoF15rptsFNoFckz2w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mKCB9HU1+rdXNQ1fQwUCuT5mKLgVczAkLofhsJ3paoTtWGGOYqTih+fpMY1XUYvqY3GTTBWMCw86w3MpWQxZddaBK7NrpPZkX+vVWOBV3ZyhaJ55nqce+sAxAhetma3DMJpNblwxlDtgAmzFae7xCDUdAzs23CMtj9rJfyyfMdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QqsHM7qm; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1727909532;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=U8tOymQHHimVq3zwKDo6/iE7zqCLLuxcCMIxrRyJdq8=;
	b=QqsHM7qmlPxirfm91ti94oBUtzRUZYLH/7/BYyHom1785iMRjasFUbepgpkcpn0dYCIl8U
	ffk1M4+9vdbwTGftWLndO+D8P6X2/l/TB2jwqqbTteVs8fCy4zbdOT+4J2fQmMnrb9OM8n
	mgLFgQmlJgx4CSAEfQnKDZ0No+o3Qi0=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Matthew Wilcox <willy@infradead.org>,
	Yu Zhao <yuzhao@google.com>,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: [PATCH] mm/truncate: reset xa_has_values flag on each iteration
Date: Wed,  2 Oct 2024 15:51:50 -0700
Message-ID: <20241002225150.2334504-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Currently mapping_try_invalidate() and invalidate_inode_pages2_range()
traverses the xarray in batches and then for each batch, maintains and
set the flag named xa_has_values if the batch has a shadow entry to
clear the entries at the end of the iteration. However they forgot to
reset the flag at the end of the iteration which cause them to always
try to clear the shadow entries in the subsequent iterations where
there might not be any shadow entries. Fixing it.

Fixes: 61c663e020d2 ("mm/truncate: batch-clear shadow entries")
Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 mm/truncate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/truncate.c b/mm/truncate.c
index 520c8cf8f58f..e5151703ba04 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -463,10 +463,10 @@ unsigned long mapping_try_invalidate(struct address_space *mapping,
 	unsigned long ret;
 	unsigned long count = 0;
 	int i;
-	bool xa_has_values = false;
 
 	folio_batch_init(&fbatch);
 	while (find_lock_entries(mapping, &index, end, &fbatch, indices)) {
+		bool xa_has_values = false;
 		int nr = folio_batch_count(&fbatch);
 
 		for (i = 0; i < nr; i++) {
@@ -592,7 +592,6 @@ int invalidate_inode_pages2_range(struct address_space *mapping,
 	int ret = 0;
 	int ret2 = 0;
 	int did_range_unmap = 0;
-	bool xa_has_values = false;
 
 	if (mapping_empty(mapping))
 		return 0;
@@ -600,6 +599,7 @@ int invalidate_inode_pages2_range(struct address_space *mapping,
 	folio_batch_init(&fbatch);
 	index = start;
 	while (find_get_entries(mapping, &index, end, &fbatch, indices)) {
+		bool xa_has_values = false;
 		int nr = folio_batch_count(&fbatch);
 
 		for (i = 0; i < nr; i++) {
-- 
2.43.5


