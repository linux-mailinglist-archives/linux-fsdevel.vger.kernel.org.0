Return-Path: <linux-fsdevel+bounces-32153-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB9719A15B7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 00:16:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F46028236A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 22:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A17F71D4351;
	Wed, 16 Oct 2024 22:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r4XP/+kR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0664318BBBE;
	Wed, 16 Oct 2024 22:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729116997; cv=none; b=n8ZLiaTTA/cHv6ooXlAoyR9IBRqJbsOuaBeR7ORLwTLeXc2xtol6U0Qv2udTKH1npCCNL4iVqJGVfTif94Hvc+CEAVgMh4TGGKUjjTASJyC3M67nqoV04w44Ti0Q5hOLR4KzMjhL1QMQdPtZH62UWfc9FqCesQvZD8OgByNVlkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729116997; c=relaxed/simple;
	bh=mIZnrqKm6DZOGB75fmkZXzLmh3/McYTdxYBRYOABlQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X9+gOaUGypVqsQFsbVGhU6z8wibvS/cVkD2QaZL8Cr8jbX5p111JAmI859RTRufzUgs+FFev+fxQxq9NlAGw3XT0sXn9OQZAKn6a6QeM9br8+ZCxLcPAAerH2QQZgqOxYcVcoX1wgInJiF8TQyRmsEQmhc7JgyUq6eH26jHPJOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r4XP/+kR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FEC0C4CEC5;
	Wed, 16 Oct 2024 22:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729116996;
	bh=mIZnrqKm6DZOGB75fmkZXzLmh3/McYTdxYBRYOABlQ4=;
	h=From:To:Cc:Subject:Date:From;
	b=r4XP/+kR4l4ZnSbFOsJQVy6T1wlV3pn1GU//zOndpV7DNj+ZdjkHWrO+YwqarleIl
	 LprIwZQwPOyIgMMSp9Z0kXgk54qbCf6WD2KyOm7HTy5YkhW7spuHN5NycAyCjB/ebJ
	 RqXOHEFb/wGImRBbCKob9bWiUyaffB5RA1LRH7T7mLV9aFQzdbfHzwV+2YzzmwZJ0G
	 iOyahT74rqFYCP/YMYph5fQtdrOwwlf0UqK/lHc22FWX0j1N90l31MJspfufW0RoKy
	 2BFUtl7IJYN6DIOrFf/QWYPHNfs3rVjfjezw38pCWU9kNXyVcEuEsILCRFPHjJEhkz
	 yGzGQlxdCL1EA==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: linux-mm@kvack.org,
	linux-perf-users@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	rppt@kernel.org,
	david@redhat.com,
	yosryahmed@google.com,
	shakeel.butt@linux.dev,
	Andrii Nakryiko <andrii@kernel.org>,
	Yi Lai <yi1.lai@intel.com>
Subject: [PATCH v2 bpf] lib/buildid: handle memfd_secret() files in build_id_parse()
Date: Wed, 16 Oct 2024 15:16:29 -0700
Message-ID: <20241016221629.1043883-1-andrii@kernel.org>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From memfd_secret(2) manpage:

  The memory areas backing the file created with memfd_secret(2) are
  visible only to the processes that have access to the file descriptor.
  The memory region is removed from the kernel page tables and only the
  page tables of the processes holding the file descriptor map the
  corresponding physical memory. (Thus, the pages in the region can't be
  accessed by the kernel itself, so that, for example, pointers to the
  region can't be passed to system calls.)

So folios backed by such secretmem files are not mapped into kernel
address space and shouldn't be accessed, in general.

To make this a bit more generic of a fix and prevent regression in the
future for similar special mappings, do a generic check of whether the
folio we got is mapped with kernel_page_present(), as suggested in [1].
This will handle secretmem, and any future special cases that use
a similar approach.

Original report and repro can be found in [0].

  [0] https://lore.kernel.org/bpf/ZwyG8Uro%2FSyTXAni@ly-workstation/
  [1] https://lore.kernel.org/bpf/CAJD7tkbpEMx-eC4A-z8Jm1ikrY_KJVjWO+mhhz1_fni4x+COKw@mail.gmail.com/

Reported-by: Yi Lai <yi1.lai@intel.com>
Suggested-by: Yosry Ahmed <yosryahmed@google.com>
Fixes: de3ec364c3c3 ("lib/buildid: add single folio-based file reader abstraction")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 lib/buildid.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/lib/buildid.c b/lib/buildid.c
index 290641d92ac1..90df64fd64c1 100644
--- a/lib/buildid.c
+++ b/lib/buildid.c
@@ -5,6 +5,7 @@
 #include <linux/elf.h>
 #include <linux/kernel.h>
 #include <linux/pagemap.h>
+#include <linux/set_memory.h>
 
 #define BUILD_ID 3
 
@@ -74,7 +75,9 @@ static int freader_get_folio(struct freader *r, loff_t file_off)
 		filemap_invalidate_unlock_shared(r->file->f_mapping);
 	}
 
-	if (IS_ERR(r->folio) || !folio_test_uptodate(r->folio)) {
+	if (IS_ERR(r->folio) ||
+	    !kernel_page_present(&r->folio->page) ||
+	    !folio_test_uptodate(r->folio)) {
 		if (!IS_ERR(r->folio))
 			folio_put(r->folio);
 		r->folio = NULL;
-- 
2.43.5


