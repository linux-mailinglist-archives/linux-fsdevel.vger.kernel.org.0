Return-Path: <linux-fsdevel+bounces-56038-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1467B12127
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jul 2025 17:45:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCFE53B80CA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jul 2025 15:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 553A22EE988;
	Fri, 25 Jul 2025 15:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="h6BVHzyr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.7])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D869F2EF28F;
	Fri, 25 Jul 2025 15:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753458314; cv=none; b=qwy+coKGBscmD/CF5J+4U7JS2JKCgaAMPf7sDEytEG5ROptDQcRdcEWosCOMkflniIYqk1sJCkVJINEHr4NSsh+JIMOLx3kTn9tuurBV3ZtILuGM9Zib4kO3qFtIwygN4o6P6dsCWAUBKOLqujkg7b7gaeLkuU8e5nYPLijlDDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753458314; c=relaxed/simple;
	bh=bRTwAex3uw2sHmBQKikLyqvO0vZHeTYQKTlTMuAwdAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dWPIXAEOpEPmNybP8onmiJZRG0giUyzeET3J7/qVxYaehJRnb5ryS9+beMH1IesjnowNYBjCttJsdjlFK1bfps89cSk7ombkFZ2ymNHnpXptlHxf5QY/b6A7WTdAcS64F7uWMxWHLDJxMzDG39i/5rYUOuQeaeRQztYV0JRI6Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=h6BVHzyr; arc=none smtp.client-ip=117.135.210.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=h1
	Dz29rI+/K8fhWCMTI5e7yo/1TAQNiw3qtHZWLJAKc=; b=h6BVHzyr8uNf327rNA
	IKMyL0JkijHEQVT07M4ZBEEE4q3R9+3Gf5AF+xb5iS//SMvRlEHnlt8dnESazBW3
	5PI+8l5xIEJjlnEIB9BTNvbvKKEWyVscCLzfAv0Of1n6JZIRQ8VNlJiPxtsjCddS
	xJBrJ8LTPw3lp3DqOyAX8E9VY=
Received: from hexiaole-VMware-Virtual-Platform.localdomain (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wDnN+W1ooNoTy_DAg--.30721S2;
	Fri, 25 Jul 2025 23:28:54 +0800 (CST)
From: Xiaole He <hexiaole1994@126.com>
To: Matthew Wilcox <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Xiaole He <hexiaole1994@126.com>
Subject: [PATCH v1] mm/readahead: Optimize nr_to_read boundary check
Date: Fri, 25 Jul 2025 23:28:34 +0800
Message-ID: <20250725152834.7602-1-hexiaole1994@126.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnN+W1ooNoTy_DAg--.30721S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tFWfJF43Gw43GF1DJr13Arb_yoW8WF1rpr
	y7Cw4fKas7Wr4rCrykA3WkAw4Sk3yj9FW3X3y5J343Zw1fAFsFqF9F9a4YqayUCr42yayr
	ZFWqv3y5Aw4UXaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pijQ6dUUUUU=
X-CM-SenderInfo: 5kh0xt5rohimizu6ij2wof0z/1tbikAaVBmiDlXfIqgAAsu

The current boundary check for nr_to_read in do_page_cache_ra can lead
to a redundant self-assignment when the desired read length precisely
matches the remaining pages to the end of the file.

Currently, the code is:

if (nr_to_read > end_index - index)
    nr_to_read = end_index - index + 1;

If nr_to_read is, for instance, 3, and end_index - index + 1 is also 3
(meaning 3 pages remain), the condition 3 > 2 evaluates to true, leading
 to nr_to_read being assigned 3 again. While compilers might optimize
this trivial self-assignment, it introduces unnecessary logical overhead
 and reduces code clarity.

This patch refines the condition to be more explicit and avoid this
redundant assignment:

if (nr_to_read > end_index - index + 1)
    nr_to_read = end_index - index + 1;

This ensures the assignment only occurs when nr_to_read genuinely
exceeds the available pages, improving code precision and slightly
enhancing readability without altering the core functionality.

Signed-off-by: Xiaole He <hexiaole1994@126.com>
---
 mm/readahead.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/readahead.c b/mm/readahead.c
index 20d36d6b055e..bbcfbebe7569 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -321,7 +321,7 @@ static void do_page_cache_ra(struct readahead_control *ractl,
 	if (index > end_index)
 		return;
 	/* Don't read past the page containing the last byte of the file */
-	if (nr_to_read > end_index - index)
+	if (nr_to_read > end_index - index + 1)
 		nr_to_read = end_index - index + 1;
 
 	page_cache_ra_unbounded(ractl, nr_to_read, lookahead_size);
-- 
2.43.0


