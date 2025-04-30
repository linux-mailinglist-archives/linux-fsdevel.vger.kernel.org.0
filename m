Return-Path: <linux-fsdevel+bounces-47731-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8866DAA4F68
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 17:02:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 754125007CD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 15:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F98D262FCE;
	Wed, 30 Apr 2025 14:59:42 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68F7725A2CB;
	Wed, 30 Apr 2025 14:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746025182; cv=none; b=DR8q/DmFWZRwUxn50q9weiebrGikzhzPjuA0yKtZooG2YzSznkYO6NE0bMwmFk1rZHOda+HLI99ekBiFTqx4PnHyKL8giGD4D8F2Y2CA4ZVmUzPFNiCluXhBOkqUM2iNLlnBpTtzgVT3mEriiHnh0EG6kwA3qyIYs9fOzbgd2hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746025182; c=relaxed/simple;
	bh=BgEQpTLYRakW4ZCmB9hOX/pMkQoyIFbBGh2ZrJoHg6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iqetvG6a1wkZ1x7yuYqlqx/c4g8uotvwaCmZsuigzxyGb++KKdy9HEZgv5vUw31YtoejyzRQZAvggD07M4/KwJwoiUywk1dGIyf70FI7NEs46m1F9n3N2AepU4xN+c00QMKunJvqcxceFcMKq79L10cgk0Rc0LyS973gRDzOS0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8BC3B106F;
	Wed, 30 Apr 2025 07:59:26 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DA7D13F5A1;
	Wed, 30 Apr 2025 07:59:31 -0700 (PDT)
From: Ryan Roberts <ryan.roberts@arm.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	David Hildenbrand <david@redhat.com>,
	Dave Chinner <david@fromorbit.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Kalesh Singh <kaleshsingh@google.com>,
	Zi Yan <ziy@nvidia.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v4 1/5] mm/readahead: Honour new_order in page_cache_ra_order()
Date: Wed, 30 Apr 2025 15:59:14 +0100
Message-ID: <20250430145920.3748738-2-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250430145920.3748738-1-ryan.roberts@arm.com>
References: <20250430145920.3748738-1-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

page_cache_ra_order() takes a parameter called new_order, which is
intended to express the preferred order of the folios that will be
allocated for the readahead operation. Most callers indeed call this
with their preferred new order. But page_cache_async_ra() calls it with
the preferred order of the previous readahead request (actually the
order of the folio that had the readahead marker, which may be smaller
when alignment comes into play).

And despite the parameter name, page_cache_ra_order() always treats it
at the old order, adding 2 to it on entry. As a result, a cold readahead
always starts with order-2 folios.

Let's fix this behaviour by always passing in the *new* order.

Worked example:

Prior to the change, mmaping an 8MB file and touching each page
sequentially, resulted in the following, where we start with order-2
folios for the first 128K then ramp up to order-4 for the next 128K,
then get clamped to order-5 for the rest of the file because pa_pages is
limited to 128K:

TYPE    STARTOFFS     ENDOFFS       SIZE  STARTPG    ENDPG   NRPG  ORDER
-----  ----------  ----------  ---------  -------  -------  -----  -----
FOLIO  0x00000000  0x00004000      16384        0        4      4      2
FOLIO  0x00004000  0x00008000      16384        4        8      4      2
FOLIO  0x00008000  0x0000c000      16384        8       12      4      2
FOLIO  0x0000c000  0x00010000      16384       12       16      4      2
FOLIO  0x00010000  0x00014000      16384       16       20      4      2
FOLIO  0x00014000  0x00018000      16384       20       24      4      2
FOLIO  0x00018000  0x0001c000      16384       24       28      4      2
FOLIO  0x0001c000  0x00020000      16384       28       32      4      2
FOLIO  0x00020000  0x00030000      65536       32       48     16      4
FOLIO  0x00030000  0x00040000      65536       48       64     16      4
FOLIO  0x00040000  0x00060000     131072       64       96     32      5
FOLIO  0x00060000  0x00080000     131072       96      128     32      5
FOLIO  0x00080000  0x000a0000     131072      128      160     32      5
FOLIO  0x000a0000  0x000c0000     131072      160      192     32      5
...

After the change, the same operation results in the first 128K being
order-0, then we start ramping up to order-2, -4, and finally get
clamped at order-5:

TYPE    STARTOFFS     ENDOFFS       SIZE  STARTPG    ENDPG   NRPG  ORDER
-----  ----------  ----------  ---------  -------  -------  -----  -----
FOLIO  0x00000000  0x00001000       4096        0        1      1      0
FOLIO  0x00001000  0x00002000       4096        1        2      1      0
FOLIO  0x00002000  0x00003000       4096        2        3      1      0
FOLIO  0x00003000  0x00004000       4096        3        4      1      0
FOLIO  0x00004000  0x00005000       4096        4        5      1      0
FOLIO  0x00005000  0x00006000       4096        5        6      1      0
FOLIO  0x00006000  0x00007000       4096        6        7      1      0
FOLIO  0x00007000  0x00008000       4096        7        8      1      0
FOLIO  0x00008000  0x00009000       4096        8        9      1      0
FOLIO  0x00009000  0x0000a000       4096        9       10      1      0
FOLIO  0x0000a000  0x0000b000       4096       10       11      1      0
FOLIO  0x0000b000  0x0000c000       4096       11       12      1      0
FOLIO  0x0000c000  0x0000d000       4096       12       13      1      0
FOLIO  0x0000d000  0x0000e000       4096       13       14      1      0
FOLIO  0x0000e000  0x0000f000       4096       14       15      1      0
FOLIO  0x0000f000  0x00010000       4096       15       16      1      0
FOLIO  0x00010000  0x00011000       4096       16       17      1      0
FOLIO  0x00011000  0x00012000       4096       17       18      1      0
FOLIO  0x00012000  0x00013000       4096       18       19      1      0
FOLIO  0x00013000  0x00014000       4096       19       20      1      0
FOLIO  0x00014000  0x00015000       4096       20       21      1      0
FOLIO  0x00015000  0x00016000       4096       21       22      1      0
FOLIO  0x00016000  0x00017000       4096       22       23      1      0
FOLIO  0x00017000  0x00018000       4096       23       24      1      0
FOLIO  0x00018000  0x00019000       4096       24       25      1      0
FOLIO  0x00019000  0x0001a000       4096       25       26      1      0
FOLIO  0x0001a000  0x0001b000       4096       26       27      1      0
FOLIO  0x0001b000  0x0001c000       4096       27       28      1      0
FOLIO  0x0001c000  0x0001d000       4096       28       29      1      0
FOLIO  0x0001d000  0x0001e000       4096       29       30      1      0
FOLIO  0x0001e000  0x0001f000       4096       30       31      1      0
FOLIO  0x0001f000  0x00020000       4096       31       32      1      0
FOLIO  0x00020000  0x00024000      16384       32       36      4      2
FOLIO  0x00024000  0x00028000      16384       36       40      4      2
FOLIO  0x00028000  0x0002c000      16384       40       44      4      2
FOLIO  0x0002c000  0x00030000      16384       44       48      4      2
FOLIO  0x00030000  0x00034000      16384       48       52      4      2
FOLIO  0x00034000  0x00038000      16384       52       56      4      2
FOLIO  0x00038000  0x0003c000      16384       56       60      4      2
FOLIO  0x0003c000  0x00040000      16384       60       64      4      2
FOLIO  0x00040000  0x00050000      65536       64       80     16      4
FOLIO  0x00050000  0x00060000      65536       80       96     16      4
FOLIO  0x00060000  0x00080000     131072       96      128     32      5
FOLIO  0x00080000  0x000a0000     131072      128      160     32      5
FOLIO  0x000a0000  0x000c0000     131072      160      192     32      5
FOLIO  0x000c0000  0x000e0000     131072      192      224     32      5
...

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 mm/readahead.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/mm/readahead.c b/mm/readahead.c
index 6a4e96b69702..8bb316f5a842 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -479,9 +479,6 @@ void page_cache_ra_order(struct readahead_control *ractl,
 
 	limit = min(limit, index + ra->size - 1);
 
-	if (new_order < mapping_max_folio_order(mapping))
-		new_order += 2;
-
 	new_order = min(mapping_max_folio_order(mapping), new_order);
 	new_order = min_t(unsigned int, new_order, ilog2(ra->size));
 	new_order = max(new_order, min_order);
@@ -683,6 +680,7 @@ void page_cache_async_ra(struct readahead_control *ractl,
 	ra->size = get_next_ra_size(ra, max_pages);
 	ra->async_size = ra->size;
 readit:
+	order += 2;
 	ractl->_index = ra->start;
 	page_cache_ra_order(ractl, ra, order);
 }
-- 
2.43.0


