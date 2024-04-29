Return-Path: <linux-fsdevel+bounces-18092-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9238B8B56F0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 13:40:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3C001C21749
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 11:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52A004597D;
	Mon, 29 Apr 2024 11:40:34 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62CDD3C24;
	Mon, 29 Apr 2024 11:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714390834; cv=none; b=QE+/t90mZMMvHkE6l6LOn3ShoiUqA5EAgGyIPi9Ka6xPw+Kx0eM8E7fDg/DUOGc55Igx2+IE2+vj1B56SyoxLViCFNzQUK2v9nizMulAKG15N82Kx7LXPh3Y8mXjjKGQBiIZWe/Bx4az2tX/Km25m6JKfzN8vMMhq6ZTU2mEDlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714390834; c=relaxed/simple;
	bh=/gI/+z7qi46TOsKZwW+XKxc4nIlP1Z7bWqZ7E6UNQhA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=REf6t3PH68m/SlSQVKTkTKaKxwbMXSy+3XFWQiZJgFmlQg9/KCZQTJ5urc/c5piuUKNJlMJZzsSDw74UDM2/8RwJest5lZ2z8wUnuHrmpk9D9jpD0fZ8tw5H3jyV0Vehtjnqtnsn829MBoAPLz0HYKbB/OkdUsBs9VOKxCpNs+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 307C52F4;
	Mon, 29 Apr 2024 04:40:57 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 607543F793;
	Mon, 29 Apr 2024 04:40:29 -0700 (PDT)
From: Ryan Roberts <ryan.roberts@arm.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	Peter Xu <peterx@redhat.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v1] fs/proc/task_mmu: Fix loss of young/dirty bits during pagemap scan
Date: Mon, 29 Apr 2024 12:40:17 +0100
Message-Id: <20240429114017.182570-1-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

make_uffd_wp_pte() was previously doing:

  pte = ptep_get(ptep);
  ptep_modify_prot_start(ptep);
  pte = pte_mkuffd_wp(pte);
  ptep_modify_prot_commit(ptep, pte);

But if another thread accessed or dirtied the pte between the first 2
calls, this could lead to loss of that information. Since
ptep_modify_prot_start() gets and clears atomically, the following is
the correct pattern and prevents any possible race. Any access after the
first call would see an invalid pte and cause a fault:

  pte = ptep_modify_prot_start(ptep);
  pte = pte_mkuffd_wp(pte);
  ptep_modify_prot_commit(ptep, pte);

Fixes: 52526ca7fdb9 ("fs/proc/task_mmu: implement IOCTL to get and optionally clear info about PTEs")
Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 fs/proc/task_mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 23fbab954c20..af4bc1da0c01 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1825,7 +1825,7 @@ static void make_uffd_wp_pte(struct vm_area_struct *vma,
 		pte_t old_pte;

 		old_pte = ptep_modify_prot_start(vma, addr, pte);
-		ptent = pte_mkuffd_wp(ptent);
+		ptent = pte_mkuffd_wp(old_pte);
 		ptep_modify_prot_commit(vma, addr, pte, old_pte, ptent);
 	} else if (is_swap_pte(ptent)) {
 		ptent = pte_swp_mkuffd_wp(ptent);
--
2.25.1


