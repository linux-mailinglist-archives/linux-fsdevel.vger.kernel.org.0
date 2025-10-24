Return-Path: <linux-fsdevel+bounces-65542-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC44C077FF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 19:13:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5239240721B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 17:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3339C33FE26;
	Fri, 24 Oct 2025 17:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DoAdhQbz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AAD82DC78C
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Oct 2025 17:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761325709; cv=none; b=ncmQbVxJ64LRKhqzMtHLsJSjG0KwhZZ8yIUM5NGU5z9zqZKgrPYG7oHHIHcYLoqKU15SkvaZGXFa72Pga2D4TSxKit92q44ezKg9vupgNLA2fBz3gBrNfkeBFkmfTpggKdu0LONlm520bA0KMN7GZy5juZ8rz/YMAMomgkBKOg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761325709; c=relaxed/simple;
	bh=7YfUNFEos5GUXJbNr0I2JtJS+XQ3SKwVkCn3rvnp1P4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PBQOpWbHRU8ii/j7VeXI+vwZrrSK6UNSrzP9NRRlJQoRSNt5kO+PNG7WLcqC7Iwu/aQfmA7t5q3bnkePrL8lamJieyhnSk0tnShCag6r39X2X/lJuD/4RHVRXX0ah4iBlG58Bnv43QIBcklU2jqS5ejMoPALXroSlV89MyWAiRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DoAdhQbz; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=1QHoZOrwsCPAzDlpOqwKXz2GtllAQbA/2AD49iTZAa0=; b=DoAdhQbzAKrQYkaxN3vVHiqNBN
	TsGMt1ta4va6eb7dKsVRnWwyOn8VrP407cgb9KLYaORGqAUlp0DQhnQre0pxuQ7fBDszxR+scVOLO
	5JoAJOPiTZt6hkakInMtB3+uj9PVa9TateaZYBvGkgVwoG4cZL0gji3p+ZkqgYwvjhgya5gn2WENv
	gDP6e7ZQSjz9rjxXgx8kdnIXZbfDLFCYaMb78S1Pi3+2ZZaLJe+I2eKbn9dB+XdOIm0O8pqW1iu5c
	s5dbeDmFQByl6wyZmar5hklmqbFhqDH3znW0arDk4QCZODIiMVMMyOgyq1kxsWKGOxLs0HEpIagR/
	sZIaMsBw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vCLH6-00000005zLB-22Li;
	Fri, 24 Oct 2025 17:08:24 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 03/10] buffer: Use folio_next_pos()
Date: Fri, 24 Oct 2025 18:08:11 +0100
Message-ID: <20251024170822.1427218-4-willy@infradead.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251024170822.1427218-1-willy@infradead.org>
References: <20251024170822.1427218-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is one instruction more efficient than open-coding folio_pos() +
folio_size().  It's the equivalent of (x + y) << z rather than
x << z + y << z.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Jan Kara <jack@suse.cz>
---
 fs/buffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 6a8752f7bbed..185ceb0d6baa 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2732,7 +2732,7 @@ int block_write_full_folio(struct folio *folio, struct writeback_control *wbc,
 	loff_t i_size = i_size_read(inode);
 
 	/* Is the folio fully inside i_size? */
-	if (folio_pos(folio) + folio_size(folio) <= i_size)
+	if (folio_next_pos(folio) <= i_size)
 		return __block_write_full_folio(inode, folio, get_block, wbc);
 
 	/* Is the folio fully outside i_size? (truncate in progress) */
-- 
2.47.2


