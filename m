Return-Path: <linux-fsdevel+bounces-51002-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AB873AD1A81
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 11:28:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1F497A2BDF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 09:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE539252286;
	Mon,  9 Jun 2025 09:27:47 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 569A4246769;
	Mon,  9 Jun 2025 09:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749461267; cv=none; b=ME6VWzFeG5CtYABxV1wORjzZofrla8gtmcDR84qLVrFqSyuuQTus9Pt2voEllrMUtn7HRJ6S/LEPdl1FlM4stGZ9BmK+h+tlbnmYYs8AhCg2QFWULMQMICfhnpJZRdU/yDJeVJqbCztROa9DHhWO/n9zyUCaPxEK0gGBtcWA/cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749461267; c=relaxed/simple;
	bh=MvvlCfoWOyhnqkS5J3ZrLkvPuzOjAAjwg5VpziH/HUE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IfnX/WBIotoIlR49IrlAEmGI9F5+p5m+Pswwspd2Scpu8xtyW70G+Nav6hh9hcK68/GY1P3zbt/IVoFon05ipijYrj0OvauS0XXmj8X1qoRZG6vZnfZ3t4XKxILAVVnaGiUH+x7GCHCoAMAtlvlIWbIxmu4nVpM+/kF5XH5a90k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 12A232573;
	Mon,  9 Jun 2025 02:27:26 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 87E243F59E;
	Mon,  9 Jun 2025 02:27:42 -0700 (PDT)
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
Subject: [PATCH v5 2/5] mm/readahead: Terminate async readahead on natural boundary
Date: Mon,  9 Jun 2025 10:27:24 +0100
Message-ID: <20250609092729.274960-3-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250609092729.274960-1-ryan.roberts@arm.com>
References: <20250609092729.274960-1-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previously asynchonous readahead would read ra_pages (usually 128K)
directly after the end of the synchonous readahead and given the
synchronous readahead portion had no alignment guarantees (beyond page
boundaries) it is possible (and likely) that the end of the initial 128K
region would not fall on a natural boundary for the folio size being
used. Therefore smaller folios were used to align down to the required
boundary, both at the end of the previous readahead block and at the
start of the new one.

In the worst cases, this can result in never properly ramping up the
folio size, and instead getting stuck oscillating between order-0, -1
and -2 folios. The next readahead will try to use folios whose order is
+2 bigger than the folio that had the readahead marker. But because of
the alignment requirements, that folio (the first one in the readahead
block) can end up being order-0 in some cases.

There will be 2 modifications to solve this issue:

1) Calculate the readahead size so the end is aligned to a folio
   boundary. This prevents needing to allocate small folios to align
   down at the end of the window and fixes the oscillation problem.

2) Remember the "preferred folio order" in the ra state instead of
   inferring it from the folio with the readahead marker. This solves
   the slow ramp up problem (discussed in a subsequent patch).

This patch addresses (1) only. A subsequent patch will address (2).

Worked example:

The following shows the previous pathalogical behaviour when the initial
synchronous readahead is unaligned. We start reading at page 17 in the
file and read sequentially from there. I'm showing a dump of the pages
in the page cache just after we read the first page of the folio with
the readahead marker.

Initially there are no pages in the page cache:

TYPE    STARTOFFS     ENDOFFS        SIZE  STARTPG    ENDPG   NRPG  ORDER  RA
-----  ----------  ----------  ----------  -------  -------  -----  -----  --
HOLE   0x00000000  0x00800000     8388608        0     2048   2048

Then we access page 17, causing synchonous read-around of 128K with a
readahead marker set up at page 25. So far, all as expected:

TYPE    STARTOFFS     ENDOFFS        SIZE  STARTPG    ENDPG   NRPG  ORDER  RA
-----  ----------  ----------  ----------  -------  -------  -----  -----  --
HOLE   0x00000000  0x00001000        4096        0        1      1
FOLIO  0x00001000  0x00002000        4096        1        2      1      0
FOLIO  0x00002000  0x00003000        4096        2        3      1      0
FOLIO  0x00003000  0x00004000        4096        3        4      1      0
FOLIO  0x00004000  0x00005000        4096        4        5      1      0
FOLIO  0x00005000  0x00006000        4096        5        6      1      0
FOLIO  0x00006000  0x00007000        4096        6        7      1      0
FOLIO  0x00007000  0x00008000        4096        7        8      1      0
FOLIO  0x00008000  0x00009000        4096        8        9      1      0
FOLIO  0x00009000  0x0000a000        4096        9       10      1      0
FOLIO  0x0000a000  0x0000b000        4096       10       11      1      0
FOLIO  0x0000b000  0x0000c000        4096       11       12      1      0
FOLIO  0x0000c000  0x0000d000        4096       12       13      1      0
FOLIO  0x0000d000  0x0000e000        4096       13       14      1      0
FOLIO  0x0000e000  0x0000f000        4096       14       15      1      0
FOLIO  0x0000f000  0x00010000        4096       15       16      1      0
FOLIO  0x00010000  0x00011000        4096       16       17      1      0
FOLIO  0x00011000  0x00012000        4096       17       18      1      0
FOLIO  0x00012000  0x00013000        4096       18       19      1      0
FOLIO  0x00013000  0x00014000        4096       19       20      1      0
FOLIO  0x00014000  0x00015000        4096       20       21      1      0
FOLIO  0x00015000  0x00016000        4096       21       22      1      0
FOLIO  0x00016000  0x00017000        4096       22       23      1      0
FOLIO  0x00017000  0x00018000        4096       23       24      1      0
FOLIO  0x00018000  0x00019000        4096       24       25      1      0
FOLIO  0x00019000  0x0001a000        4096       25       26      1      0  Y
FOLIO  0x0001a000  0x0001b000        4096       26       27      1      0
FOLIO  0x0001b000  0x0001c000        4096       27       28      1      0
FOLIO  0x0001c000  0x0001d000        4096       28       29      1      0
FOLIO  0x0001d000  0x0001e000        4096       29       30      1      0
FOLIO  0x0001e000  0x0001f000        4096       30       31      1      0
FOLIO  0x0001f000  0x00020000        4096       31       32      1      0
FOLIO  0x00020000  0x00021000        4096       32       33      1      0
HOLE   0x00021000  0x00800000     8253440       33     2048   2015

Now access pages 18-25 inclusive. This causes an asynchronous 128K
readahead starting at page 33. But since we are unaligned, even though
the preferred folio order is 2, the first folio in this batch (the one
with the new readahead marker) is order-0:

TYPE    STARTOFFS     ENDOFFS        SIZE  STARTPG    ENDPG   NRPG  ORDER  RA
-----  ----------  ----------  ----------  -------  -------  -----  -----  --
HOLE   0x00000000  0x00001000        4096        0        1      1
FOLIO  0x00001000  0x00002000        4096        1        2      1      0
FOLIO  0x00002000  0x00003000        4096        2        3      1      0
FOLIO  0x00003000  0x00004000        4096        3        4      1      0
FOLIO  0x00004000  0x00005000        4096        4        5      1      0
FOLIO  0x00005000  0x00006000        4096        5        6      1      0
FOLIO  0x00006000  0x00007000        4096        6        7      1      0
FOLIO  0x00007000  0x00008000        4096        7        8      1      0
FOLIO  0x00008000  0x00009000        4096        8        9      1      0
FOLIO  0x00009000  0x0000a000        4096        9       10      1      0
FOLIO  0x0000a000  0x0000b000        4096       10       11      1      0
FOLIO  0x0000b000  0x0000c000        4096       11       12      1      0
FOLIO  0x0000c000  0x0000d000        4096       12       13      1      0
FOLIO  0x0000d000  0x0000e000        4096       13       14      1      0
FOLIO  0x0000e000  0x0000f000        4096       14       15      1      0
FOLIO  0x0000f000  0x00010000        4096       15       16      1      0
FOLIO  0x00010000  0x00011000        4096       16       17      1      0
FOLIO  0x00011000  0x00012000        4096       17       18      1      0
FOLIO  0x00012000  0x00013000        4096       18       19      1      0
FOLIO  0x00013000  0x00014000        4096       19       20      1      0
FOLIO  0x00014000  0x00015000        4096       20       21      1      0
FOLIO  0x00015000  0x00016000        4096       21       22      1      0
FOLIO  0x00016000  0x00017000        4096       22       23      1      0
FOLIO  0x00017000  0x00018000        4096       23       24      1      0
FOLIO  0x00018000  0x00019000        4096       24       25      1      0
FOLIO  0x00019000  0x0001a000        4096       25       26      1      0
FOLIO  0x0001a000  0x0001b000        4096       26       27      1      0
FOLIO  0x0001b000  0x0001c000        4096       27       28      1      0
FOLIO  0x0001c000  0x0001d000        4096       28       29      1      0
FOLIO  0x0001d000  0x0001e000        4096       29       30      1      0
FOLIO  0x0001e000  0x0001f000        4096       30       31      1      0
FOLIO  0x0001f000  0x00020000        4096       31       32      1      0
FOLIO  0x00020000  0x00021000        4096       32       33      1      0
FOLIO  0x00021000  0x00022000        4096       33       34      1      0  Y
FOLIO  0x00022000  0x00024000        8192       34       36      2      1
FOLIO  0x00024000  0x00028000       16384       36       40      4      2
FOLIO  0x00028000  0x0002c000       16384       40       44      4      2
FOLIO  0x0002c000  0x00030000       16384       44       48      4      2
FOLIO  0x00030000  0x00034000       16384       48       52      4      2
FOLIO  0x00034000  0x00038000       16384       52       56      4      2
FOLIO  0x00038000  0x0003c000       16384       56       60      4      2
FOLIO  0x0003c000  0x00040000       16384       60       64      4      2
FOLIO  0x00040000  0x00041000        4096       64       65      1      0
HOLE   0x00041000  0x00800000     8122368       65     2048   1983

Which means that when we now read pages 26-33 and readahead is kicked
off again, the new preferred order is 2 (0 + 2), not 4 as we intended:

TYPE    STARTOFFS     ENDOFFS        SIZE  STARTPG    ENDPG   NRPG  ORDER  RA
-----  ----------  ----------  ----------  -------  -------  -----  -----  --
HOLE   0x00000000  0x00001000        4096        0        1      1
FOLIO  0x00001000  0x00002000        4096        1        2      1      0
FOLIO  0x00002000  0x00003000        4096        2        3      1      0
FOLIO  0x00003000  0x00004000        4096        3        4      1      0
FOLIO  0x00004000  0x00005000        4096        4        5      1      0
FOLIO  0x00005000  0x00006000        4096        5        6      1      0
FOLIO  0x00006000  0x00007000        4096        6        7      1      0
FOLIO  0x00007000  0x00008000        4096        7        8      1      0
FOLIO  0x00008000  0x00009000        4096        8        9      1      0
FOLIO  0x00009000  0x0000a000        4096        9       10      1      0
FOLIO  0x0000a000  0x0000b000        4096       10       11      1      0
FOLIO  0x0000b000  0x0000c000        4096       11       12      1      0
FOLIO  0x0000c000  0x0000d000        4096       12       13      1      0
FOLIO  0x0000d000  0x0000e000        4096       13       14      1      0
FOLIO  0x0000e000  0x0000f000        4096       14       15      1      0
FOLIO  0x0000f000  0x00010000        4096       15       16      1      0
FOLIO  0x00010000  0x00011000        4096       16       17      1      0
FOLIO  0x00011000  0x00012000        4096       17       18      1      0
FOLIO  0x00012000  0x00013000        4096       18       19      1      0
FOLIO  0x00013000  0x00014000        4096       19       20      1      0
FOLIO  0x00014000  0x00015000        4096       20       21      1      0
FOLIO  0x00015000  0x00016000        4096       21       22      1      0
FOLIO  0x00016000  0x00017000        4096       22       23      1      0
FOLIO  0x00017000  0x00018000        4096       23       24      1      0
FOLIO  0x00018000  0x00019000        4096       24       25      1      0
FOLIO  0x00019000  0x0001a000        4096       25       26      1      0
FOLIO  0x0001a000  0x0001b000        4096       26       27      1      0
FOLIO  0x0001b000  0x0001c000        4096       27       28      1      0
FOLIO  0x0001c000  0x0001d000        4096       28       29      1      0
FOLIO  0x0001d000  0x0001e000        4096       29       30      1      0
FOLIO  0x0001e000  0x0001f000        4096       30       31      1      0
FOLIO  0x0001f000  0x00020000        4096       31       32      1      0
FOLIO  0x00020000  0x00021000        4096       32       33      1      0
FOLIO  0x00021000  0x00022000        4096       33       34      1      0
FOLIO  0x00022000  0x00024000        8192       34       36      2      1
FOLIO  0x00024000  0x00028000       16384       36       40      4      2
FOLIO  0x00028000  0x0002c000       16384       40       44      4      2
FOLIO  0x0002c000  0x00030000       16384       44       48      4      2
FOLIO  0x00030000  0x00034000       16384       48       52      4      2
FOLIO  0x00034000  0x00038000       16384       52       56      4      2
FOLIO  0x00038000  0x0003c000       16384       56       60      4      2
FOLIO  0x0003c000  0x00040000       16384       60       64      4      2
FOLIO  0x00040000  0x00041000        4096       64       65      1      0
FOLIO  0x00041000  0x00042000        4096       65       66      1      0  Y
FOLIO  0x00042000  0x00044000        8192       66       68      2      1
FOLIO  0x00044000  0x00048000       16384       68       72      4      2
FOLIO  0x00048000  0x0004c000       16384       72       76      4      2
FOLIO  0x0004c000  0x00050000       16384       76       80      4      2
FOLIO  0x00050000  0x00054000       16384       80       84      4      2
FOLIO  0x00054000  0x00058000       16384       84       88      4      2
FOLIO  0x00058000  0x0005c000       16384       88       92      4      2
FOLIO  0x0005c000  0x00060000       16384       92       96      4      2
FOLIO  0x00060000  0x00061000        4096       96       97      1      0
HOLE   0x00061000  0x00800000     7991296       97     2048   1951

This ramp up from order-0 with smaller orders at the edges for alignment
cycle continues all the way to the end of the file (not shown).

After the change, we round down the end boundary to the order boundary
so we no longer get stuck in the cycle and can ramp up the order over
time. Note that the rate of the ramp up is still not as we would expect
it. We will fix that next. Here we are touching pages 17-256
sequentially:

TYPE    STARTOFFS     ENDOFFS        SIZE  STARTPG    ENDPG   NRPG  ORDER  RA
-----  ----------  ----------  ----------  -------  -------  -----  -----  --
HOLE   0x00000000  0x00001000        4096        0        1      1
FOLIO  0x00001000  0x00002000        4096        1        2      1      0
FOLIO  0x00002000  0x00003000        4096        2        3      1      0
FOLIO  0x00003000  0x00004000        4096        3        4      1      0
FOLIO  0x00004000  0x00005000        4096        4        5      1      0
FOLIO  0x00005000  0x00006000        4096        5        6      1      0
FOLIO  0x00006000  0x00007000        4096        6        7      1      0
FOLIO  0x00007000  0x00008000        4096        7        8      1      0
FOLIO  0x00008000  0x00009000        4096        8        9      1      0
FOLIO  0x00009000  0x0000a000        4096        9       10      1      0
FOLIO  0x0000a000  0x0000b000        4096       10       11      1      0
FOLIO  0x0000b000  0x0000c000        4096       11       12      1      0
FOLIO  0x0000c000  0x0000d000        4096       12       13      1      0
FOLIO  0x0000d000  0x0000e000        4096       13       14      1      0
FOLIO  0x0000e000  0x0000f000        4096       14       15      1      0
FOLIO  0x0000f000  0x00010000        4096       15       16      1      0
FOLIO  0x00010000  0x00011000        4096       16       17      1      0
FOLIO  0x00011000  0x00012000        4096       17       18      1      0
FOLIO  0x00012000  0x00013000        4096       18       19      1      0
FOLIO  0x00013000  0x00014000        4096       19       20      1      0
FOLIO  0x00014000  0x00015000        4096       20       21      1      0
FOLIO  0x00015000  0x00016000        4096       21       22      1      0
FOLIO  0x00016000  0x00017000        4096       22       23      1      0
FOLIO  0x00017000  0x00018000        4096       23       24      1      0
FOLIO  0x00018000  0x00019000        4096       24       25      1      0
FOLIO  0x00019000  0x0001a000        4096       25       26      1      0
FOLIO  0x0001a000  0x0001b000        4096       26       27      1      0
FOLIO  0x0001b000  0x0001c000        4096       27       28      1      0
FOLIO  0x0001c000  0x0001d000        4096       28       29      1      0
FOLIO  0x0001d000  0x0001e000        4096       29       30      1      0
FOLIO  0x0001e000  0x0001f000        4096       30       31      1      0
FOLIO  0x0001f000  0x00020000        4096       31       32      1      0
FOLIO  0x00020000  0x00021000        4096       32       33      1      0
FOLIO  0x00021000  0x00022000        4096       33       34      1      0
FOLIO  0x00022000  0x00024000        8192       34       36      2      1
FOLIO  0x00024000  0x00028000       16384       36       40      4      2
FOLIO  0x00028000  0x0002c000       16384       40       44      4      2
FOLIO  0x0002c000  0x00030000       16384       44       48      4      2
FOLIO  0x00030000  0x00034000       16384       48       52      4      2
FOLIO  0x00034000  0x00038000       16384       52       56      4      2
FOLIO  0x00038000  0x0003c000       16384       56       60      4      2
FOLIO  0x0003c000  0x00040000       16384       60       64      4      2
FOLIO  0x00040000  0x00044000       16384       64       68      4      2
FOLIO  0x00044000  0x00048000       16384       68       72      4      2
FOLIO  0x00048000  0x0004c000       16384       72       76      4      2
FOLIO  0x0004c000  0x00050000       16384       76       80      4      2
FOLIO  0x00050000  0x00054000       16384       80       84      4      2
FOLIO  0x00054000  0x00058000       16384       84       88      4      2
FOLIO  0x00058000  0x0005c000       16384       88       92      4      2
FOLIO  0x0005c000  0x00060000       16384       92       96      4      2
FOLIO  0x00060000  0x00070000       65536       96      112     16      4
FOLIO  0x00070000  0x00080000       65536      112      128     16      4
FOLIO  0x00080000  0x000a0000      131072      128      160     32      5
FOLIO  0x000a0000  0x000c0000      131072      160      192     32      5
FOLIO  0x000c0000  0x000e0000      131072      192      224     32      5
FOLIO  0x000e0000  0x00100000      131072      224      256     32      5
FOLIO  0x00100000  0x00120000      131072      256      288     32      5
FOLIO  0x00120000  0x00140000      131072      288      320     32      5  Y
HOLE   0x00140000  0x00800000     7077888      320     2048   1728

Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 mm/readahead.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/mm/readahead.c b/mm/readahead.c
index 973de2551efe..87be20ae00d0 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -620,7 +620,7 @@ void page_cache_async_ra(struct readahead_control *ractl,
 	unsigned long max_pages;
 	struct file_ra_state *ra = ractl->ra;
 	pgoff_t index = readahead_index(ractl);
-	pgoff_t expected, start;
+	pgoff_t expected, start, end, aligned_end, align;
 	unsigned int order = folio_order(folio);
 
 	/* no readahead */
@@ -652,7 +652,6 @@ void page_cache_async_ra(struct readahead_control *ractl,
 		 * the readahead window.
 		 */
 		ra->size = max(ra->size, get_next_ra_size(ra, max_pages));
-		ra->async_size = ra->size;
 		goto readit;
 	}
 
@@ -673,9 +672,14 @@ void page_cache_async_ra(struct readahead_control *ractl,
 	ra->size = start - index;	/* old async_size */
 	ra->size += req_count;
 	ra->size = get_next_ra_size(ra, max_pages);
-	ra->async_size = ra->size;
 readit:
 	order += 2;
+	align = 1UL << min(order, ffs(max_pages) - 1);
+	end = ra->start + ra->size;
+	aligned_end = round_down(end, align);
+	if (aligned_end > ra->start)
+		ra->size -= end - aligned_end;
+	ra->async_size = ra->size;
 	ractl->_index = ra->start;
 	page_cache_ra_order(ractl, ra, order);
 }
-- 
2.43.0


