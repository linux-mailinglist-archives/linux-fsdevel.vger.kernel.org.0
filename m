Return-Path: <linux-fsdevel+bounces-44739-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FEC0A6C41F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Mar 2025 21:25:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66F523B67A5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Mar 2025 20:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 836EA230277;
	Fri, 21 Mar 2025 20:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tBAg+TJp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE40428E7;
	Fri, 21 Mar 2025 20:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742588686; cv=none; b=KsaztD1L+xNQdWWv1qM9xb5g5KqRLLfqVHuNKNWV+qngJ9xwk+MKgByee3vLkrI7goT/2SA3oSWQ7g4ZffSTYHQksxPQscIuQ0MIJKKJz0DIEnWIFTCrwTZhsOv5kFoPqHWQziP4e61w1meub+quRYIBQcLfqfaA7nu2OLz2iGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742588686; c=relaxed/simple;
	bh=XbZX7WwcCrPZ0vVCqlR4/R7nZWsh4cRUWp5XinU3ZN0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=OtIywwqkue1EseGdiPz2jI1hL5Kfv+1NDL14XMarwLCCGwGgiRxc1kxeklGVzYut2lq5zT/Aa1HRYoaKrf19LN7nIzEF54+jDKqO4mnkaem+uAhMu3ZTeDP8Qvn8uo1/EojE1PDhsSSuNXhQCkVqVGmTba/dfa6oZdo6Jr95x1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tBAg+TJp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85957C4CEE3;
	Fri, 21 Mar 2025 20:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742588685;
	bh=XbZX7WwcCrPZ0vVCqlR4/R7nZWsh4cRUWp5XinU3ZN0=;
	h=From:Date:Subject:To:Cc:From;
	b=tBAg+TJprE3bKEpm9tNj0Udt4D8JfQw3N+qbkYuu5YYlrra2WigyWH+bPshgGvfp0
	 2RGngc1OC016wjhHfzGN6FVlNJXe4bL1KahMhD29b8Rge6pGXILBMp3lctQM0cjMtu
	 nSBynCMuMJorBSc7YaaO7g4RQCGOdr9nlkfzsjDZVZ47/Rbjf0ktWqaH+i7XhTFAdF
	 jwV2ASZbhuRcYdBEVsHfJ3tT9fAef+/WiM7xNBZu8eWoxNhOE1YD/sH82QEhA9zmV0
	 SVqhDpmNcNWQWTYw4etkdpPb8iTnw+6zd6sqR/f/vbCtUbDQ++wlhWNmB8epZxv80T
	 BXSyVqcsEZHZg==
From: Daniel Gomez <da.gomez@kernel.org>
Date: Fri, 21 Mar 2025 20:24:33 +0000
Subject: [PATCH] radix-tree: add missing cleanup.h
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250321-fix-radix-tree-build-v1-1-838a1e6540e2@samsung.com>
X-B4-Tracking: v=1; b=H4sIAADL3WcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDYyND3bTMCt2ixBQgWVKUmqqbVJqZk6JrZJFqZJiSYpJoZpKkBNRaUJQ
 KVAc2Njq2thYA1lnlOmYAAAA=
X-Change-ID: 20250321-fix-radix-tree-build-28e21dd4a64b
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
 Ravi Bangoria <ravi.bangoria@amd.com>, Matthew Wilcox <willy@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, gost.dev@samsung.com, 
 Daniel Gomez <da.gomez@kernel.org>, Daniel Gomez <da.gomez@samsung.com>
X-Mailer: b4 0.14.2

From: Daniel Gomez <da.gomez@samsung.com>

Add shared cleanup.h header for radix-tree testing tools.

Fixes build error found with kdevops [1]:

cc -I../shared -I. -I../../include -I../../../lib -g -Og -Wall
-D_LGPL_SOURCE -fsanitize=address -fsanitize=undefined   -c -o
radix-tree.o radix-tree.c
In file included from ../shared/linux/idr.h:1,
                 from radix-tree.c:18:
../shared/linux/../../../../include/linux/idr.h:18:10: fatal error:
linux/cleanup.h: No such file or directory
   18 | #include <linux/cleanup.h>
      |          ^~~~~~~~~~~~~~~~~
compilation terminated.
make: *** [<builtin>: radix-tree.o] Error 1

[1] https://github.com/linux-kdevops/kdevops
https://github.com/linux-kdevops/linux-mm-kpd/
actions/runs/13971648496/job/39114756401

Fixes: 6c8b0b835f00 ("perf/core: Simplify perf_pmu_register()")

Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
---
 tools/testing/shared/linux/cleanup.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/testing/shared/linux/cleanup.h b/tools/testing/shared/linux/cleanup.h
new file mode 100644
index 0000000000000000000000000000000000000000..6e1691f56e300b498c16647bb4b91d8c8be9c3eb
--- /dev/null
+++ b/tools/testing/shared/linux/cleanup.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _TEST_CLEANUP_H
+#define _TEST_CLEANUP_H
+
+#include "../../../../include/linux/cleanup.h"
+
+#endif /* _TEST_CLEANUP_H */

---
base-commit: 9388ec571cb1adba59d1cded2300eeb11827679c
change-id: 20250321-fix-radix-tree-build-28e21dd4a64b

Best regards,
-- 
Daniel Gomez <da.gomez@samsung.com>


