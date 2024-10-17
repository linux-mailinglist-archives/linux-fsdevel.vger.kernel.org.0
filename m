Return-Path: <linux-fsdevel+bounces-32169-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 152459A1AA2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 08:24:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4A511F23949
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 06:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9783917DE06;
	Thu, 17 Oct 2024 06:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="y806h+0N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBDF317A589
	for <linux-fsdevel@vger.kernel.org>; Thu, 17 Oct 2024 06:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729146238; cv=none; b=XQkeVsIpMC51Fl/rR/mUWT5w79won3qgAwDY74zCMGzILWvZQjO5MBa6WQNwiSt1JMgBv6iACY56EFW7tbE2xs+r9xeN73Mk6J85dSfzddXCKROKMFOAlKm+u8U+k1I9kw1K0mv1aD7z8yK2g48ti6pf6E63kv0DlOUI2Z3MK/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729146238; c=relaxed/simple;
	bh=t2mnmEc15n5cQKC9ebNeRO5Q36EG95tFYmjeTC5/gd8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SAbbJX6OirziPBJVFAOzOf9aLM1ViGmhvUsRMkaMpQoUfHWYlzRIz5YTDXxYuUPDVTD+sx/UCylV4ZnigBmR8y9WWQzrLr0J65iy+X1qJ1ziVewL6XJSX48ATw2HxQBK4qp1ASz8CwvFxOX32Yo94td+Q/YIuQ+iGQqx6lyoi6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=y806h+0N; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4XTd815SCRz9stW;
	Thu, 17 Oct 2024 08:23:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1729146225;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=uWJq3jm/0K8u47eg5W/WP541CVXGY7oY6qDd69RidKg=;
	b=y806h+0NNTLh6Cm/5dlCNQ7YJsjcWcBmDCHdVl35RdxBV4Oa6KHVZ2Fq69MJAHTqyr7wOT
	QAq1P+lXIXP+dnAacf+wvm0STgLFNdjBjDqX9FL/2OwGNHc/9OM1mdiHgfLkF8Q8pHUKjV
	LsPqvk3aLvfhE6ub+e7nxzb1awOCk3zOvZwOtmRGjOTgyscb0V4S1w5Rqn9xgPmy50UtSG
	ipkCwZBnw167O9gZuJR5L4+EAqio+s9djqvCwUFJ90YP6uN5hjNFzntjsNGyhWoaCgOC3q
	jS6JeC+9v4AEalr93KrumvGjpWq4VOKURv5Tx6rarY/7n9ETZQsQw3gsvAAA+A==
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: akpm@linux-foundation.org
Cc: kernel@pankajraghav.com,
	willy@infradead.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	mcgrof@kernel.org,
	gost.dev@samsung.com,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH v2] mm: don't set readahead flag on a folio when lookahead_size > nr_to_read
Date: Thu, 17 Oct 2024 08:23:42 +0200
Message-ID: <20241017062342.478973-1-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4XTd815SCRz9stW

From: Pankaj Raghav <p.raghav@samsung.com>

The readahead flag is set on a folio based on the lookahead_size and
nr_to_read. For example, when the readahead happens from index to index
+ nr_to_read, then the readahead `mark` offset from index is set at
nr_to_read - lookahead_size.

There are some scenarios where the lookahead_size > nr_to_read. For
example, readahead window was created, but the file was truncated before
the readahead starts. do_page_cache_ra() will clamp the nr_to_read if the
readahead window extends beyond EOF after truncation. If this happens,
readahead flag should not be set on any folio on the current readahead
window.

The current calculation for `mark` with mapping_min_order > 0 gives
incorrect results when lookahead_size > nr_to_read due to rounding
up operation:

index = 128
nr_to_read = 16
lookahead_size = 28
mapping_min_order = 4 (16 pages)

ra_folio_index = round_up(128 + 16 - 28, 16) = 128;
mark = 128 - 128 = 0; # offset from index to set RA flag

In the above example, the lookahead_size is actually lying outside the
current readahead window. Without this patch, RA flag will be set
incorrectly on the folio at index 128. This can lead to marking the
readahead flag on the wrong folio, therefore, triggering a readahead when
it is not necessary.

Explicitly initialize `mark` to be ULONG_MAX and only calculate it
when lookahead_size is within the readahead window.

Fixes: 26cfdb395eef ("readahead: allocate folios with mapping_min_order in readahead")
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 mm/readahead.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/mm/readahead.c b/mm/readahead.c
index 3dc6c7a128dd..475d2940a1ed 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -206,9 +206,9 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
 		unsigned long nr_to_read, unsigned long lookahead_size)
 {
 	struct address_space *mapping = ractl->mapping;
-	unsigned long ra_folio_index, index = readahead_index(ractl);
+	unsigned long index = readahead_index(ractl);
 	gfp_t gfp_mask = readahead_gfp_mask(mapping);
-	unsigned long mark, i = 0;
+	unsigned long mark = ULONG_MAX, i = 0;
 	unsigned int min_nrpages = mapping_min_folio_nrpages(mapping);
 
 	/*
@@ -232,9 +232,14 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
 	 * index that only has lookahead or "async_region" to set the
 	 * readahead flag.
 	 */
-	ra_folio_index = round_up(readahead_index(ractl) + nr_to_read - lookahead_size,
-				  min_nrpages);
-	mark = ra_folio_index - index;
+	if (lookahead_size <= nr_to_read) {
+		unsigned long ra_folio_index;
+
+		ra_folio_index = round_up(readahead_index(ractl) +
+					  nr_to_read - lookahead_size,
+					  min_nrpages);
+		mark = ra_folio_index - index;
+	}
 	nr_to_read += readahead_index(ractl) - index;
 	ractl->_index = index;
 

base-commit: d61a00525464bfc5fe92c6ad713350988e492b88
-- 
2.44.1


