Return-Path: <linux-fsdevel+bounces-51606-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 187EEAD94F7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 21:07:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55E703B665E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 19:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 591B423D2A4;
	Fri, 13 Jun 2025 19:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UgJRjg1V"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19CE4146A72;
	Fri, 13 Jun 2025 19:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749841634; cv=none; b=Z32mdAe0NLLaiK6lrgbzP//p69/wcO+ri3pXqFjr8I7PGT+nIw1AKnwmau8oNZBeG+ffdyouKvfDWRbt4U83xXWC3pGRZgAHPW8l856nkBITjCC4IIgHXOUpe0cxEqRWyanj48PPusrIF0gYa9pIzD9OAi65bxWwwLGs8CDr5ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749841634; c=relaxed/simple;
	bh=/MIGeIuqKDi3BECVvJhfLxE3QQknDOzsK855hkf/7oc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YjzpHx6qOHChw08QwJghWi1PztyrPrktewwmOLSC7dVj2FzPFREgQU4QTG5QpK6JsX1uMCsZBf6KWb7DgLZ+dCHEKvixfisa97P5TdVSgfb+TCNG+K8LMZgLabrdqoH2PWi8WGLEkr2DZl5Wv0pym+YxYTNXbnyNbHPh+IvHnh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UgJRjg1V; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=JBLsEQ2mqR+LlLszJ58kvJS0gAXpxAvbcjEgvSxl4dU=; b=UgJRjg1VeoSlv7UfRjXV3BlMDO
	yLEeiw5WlkSIff2T9WbBL36GqB6jtGrpXks9oPygjufYwr15BF3QkWCpU37yVwI/OgPux+csL0vfF
	aFlpu+UCIgDumv2qaPgaBqzEtCiO0xMuS0TdOauynLsxRsb2QPU2yYOlJKpLIm7iaar5cHcR0/PvY
	3zWP1CU1d78xo4dTGh3AZp35Eyg7PzJiHzlXkFADbpe49y5HIv6xKA2mb8Otht5k32GHwifZX05p6
	lCnAcn6f43AIzheH7vidwOsX+9gbNuzNQn+MpP8DWO06rjcFf2KZSu0TZbn2sXlgAkbNey0+UxT37
	Xj+ZSxcw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uQ9k3-0000000DHsd-1Ptq;
	Fri, 13 Jun 2025 19:07:07 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-btrfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 3/3] btrfs: Simplify dump_eb_and_memory_contents()
Date: Fri, 13 Jun 2025 20:07:02 +0100
Message-ID: <20250613190705.3166969-4-willy@infradead.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250613190705.3166969-1-willy@infradead.org>
References: <20250613190705.3166969-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the casting from folio back to page and remove the use of memcmp
for a single byte.  Change the type to u8 so we can do direct array
arithmetic instead of doing complicated casts.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/btrfs/tests/extent-io-tests.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/tests/extent-io-tests.c b/fs/btrfs/tests/extent-io-tests.c
index 36720b77b440..f5f6accbdc21 100644
--- a/fs/btrfs/tests/extent-io-tests.c
+++ b/fs/btrfs/tests/extent-io-tests.c
@@ -664,17 +664,17 @@ static int test_find_first_clear_extent_bit(void)
 	return ret;
 }
 
-static void dump_eb_and_memory_contents(struct extent_buffer *eb, void *memory,
-					const char *test_name)
+static void dump_eb_and_memory_contents(const struct extent_buffer *eb,
+		const u8 *memory, const char *test_name)
 {
 	for (int i = 0; i < eb->len; i++) {
-		struct page *page = folio_page(eb->folios[i >> PAGE_SHIFT], 0);
-		void *addr = page_address(page) + offset_in_page(i);
+		struct folio *folio = eb->folios[i / PAGE_SIZE];
+		u8 *addr = folio_address(folio) + i % PAGE_SIZE;
 
-		if (memcmp(addr, memory + i, 1) != 0) {
+		if (*addr != memory[i]) {
 			test_err("%s failed", test_name);
 			test_err("eb and memory diffs at byte %u, eb has 0x%02x memory has 0x%02x",
-				 i, *(u8 *)addr, *(u8 *)(memory + i));
+				 i, *addr, memory[i]);
 			return;
 		}
 	}
-- 
2.47.2


