Return-Path: <linux-fsdevel+bounces-8968-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B24D83C8C3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 17:54:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DAD71C22626
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 16:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3B8A141994;
	Thu, 25 Jan 2024 16:45:13 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B829135A55;
	Thu, 25 Jan 2024 16:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706201113; cv=none; b=scGs38KOmFkcmDYM72GIYIqcqq+gWQlLIXIpoF//2kKNkLeWNGoJo/CCainZBIfVr0r3p7w8EASlHTrlsEfFAjQXA2xBI+ejfA2+xPbSBiiI7IjUqWJhh7JSEpW7KjJmMXvcYeso8pY5mBT26KAJ1r7MfC34Rx/eh9Lmac3wpXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706201113; c=relaxed/simple;
	bh=7GSpvoz7AckF0nurdaP1+AUs5Wt1UqGcytFWfgfXtws=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d3g+29fziuSkccth75Nd1XFlUJVFwSBJe/e4qmW6ZY+PFq6FJLGVuoGlUWAfenUZFqhQKPjRklnAXrlDwSfrAu3BM7irzXwQIPFbSkT7notLZaveqK4GxNdSxc1AEHpObSKn0fon6bHe9f/gEFiWjS5aRUrOADjRLhtLhNvJRP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 08EF7169C;
	Thu, 25 Jan 2024 08:45:56 -0800 (PST)
Received: from e121798.cable.virginm.net (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1C34E3F5A1;
	Thu, 25 Jan 2024 08:45:05 -0800 (PST)
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: catalin.marinas@arm.com,
	will@kernel.org,
	oliver.upton@linux.dev,
	maz@kernel.org,
	james.morse@arm.com,
	suzuki.poulose@arm.com,
	yuzenghui@huawei.com,
	arnd@arndb.de,
	akpm@linux-foundation.org,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	bristot@redhat.com,
	vschneid@redhat.com,
	mhiramat@kernel.org,
	rppt@kernel.org,
	hughd@google.com
Cc: pcc@google.com,
	steven.price@arm.com,
	anshuman.khandual@arm.com,
	vincenzo.frascino@arm.com,
	david@redhat.com,
	eugenis@google.com,
	kcc@google.com,
	hyesoo.yu@samsung.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH RFC v3 25/35] arm64: mte: Reserve tag block for the zero page
Date: Thu, 25 Jan 2024 16:42:46 +0000
Message-Id: <20240125164256.4147-26-alexandru.elisei@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240125164256.4147-1-alexandru.elisei@arm.com>
References: <20240125164256.4147-1-alexandru.elisei@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On arm64, when a page is mapped as tagged, its tags are zeroed for two
reasons:

* To prevent leakage of tags to userspace.

* To allow userspace to access the contents of the page with having to set
  the tags explicitely (bits 59:56 of an userspace pointer are zero, which
  correspond to tag 0b0000).

The zero page receives special treatment, as the tags for the zero page are
zeroed when the MTE feature is being enabled. This is done for performance
reasons - the tags are zeroed once, instead of every time the page is
mapped.

When the tags for the zero page are zeroed, tag storage is not yet enabled.
Reserve tag storage for the page immediately after tag storage management
becomes enabled.

Note that zeroing tags before tag storage management is enabled is safe to
do because the tag storage pages are reserved at that point.

Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---

Changes since rfc v2:

* Expanded commit message (David Hildenbrand)

 arch/arm64/kernel/mte_tag_storage.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/kernel/mte_tag_storage.c b/arch/arm64/kernel/mte_tag_storage.c
index 8c347f4855e4..1c8469781870 100644
--- a/arch/arm64/kernel/mte_tag_storage.c
+++ b/arch/arm64/kernel/mte_tag_storage.c
@@ -363,6 +363,8 @@ static int __init mte_enable_tag_storage(void)
 			goto out_disabled;
 	}
 
+	reserve_tag_storage(ZERO_PAGE(0), 0, GFP_HIGHUSER);
+
 	static_branch_enable(&tag_storage_enabled_key);
 	pr_info("MTE tag storage region management enabled");
 
-- 
2.43.0


