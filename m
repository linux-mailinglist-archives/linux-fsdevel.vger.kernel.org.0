Return-Path: <linux-fsdevel+bounces-8964-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C081A83C8B6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 17:52:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46804B26B9F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 16:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C689F1350EF;
	Thu, 25 Jan 2024 16:44:50 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4FE1350EA;
	Thu, 25 Jan 2024 16:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706201090; cv=none; b=IyYXVRhh2vDPZUmzgN81WAaGd9pIpG1RiCeu5belcXrQvSEjKWMODBg4wo6c6kJuKWe2p2eb5jaxrweZI40ekllHb3eSb+2/yBA1k5pGEKiWgSw0kRK2rjfu9DCWaK7h603bIXGBe0nR6rmqCup7ALj8Wpj7UhkZ+3cBk5UK+Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706201090; c=relaxed/simple;
	bh=64mQn4vPAyYkyVD8dgjbvXz3vStqAMFDRY18jZb6JI8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i+CfSjO1tRuq6FILEUH8CVuGe+KldQs1rIvMjK0YqvnQ6kbDU6vjlR/BJ6wcyftQYzsexxfuyRCigx8YQG3sZrnWu6GnJf8LqZbpszY1tlDE6F6bFaD558MDnX2qmdijjB0CbZJ451ZtH5FEWOg6P0CRHIe+zNs8vct30dKgTv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E894C1688;
	Thu, 25 Jan 2024 08:45:32 -0800 (PST)
Received: from e121798.cable.virginm.net (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 03CA73F5A1;
	Thu, 25 Jan 2024 08:44:42 -0800 (PST)
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
Subject: [PATCH RFC v3 21/35] arm64: mte: Disable dynamic tag storage management if HW KASAN is enabled
Date: Thu, 25 Jan 2024 16:42:42 +0000
Message-Id: <20240125164256.4147-22-alexandru.elisei@arm.com>
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

To be able to reserve the tag storage associated with a tagged page
requires that the tag storage can be migrated, if it's in use for data.

The kernel allocates pages in non-preemptible contexts, which makes
migration impossible. The only user of tagged pages in the kernel is HW
KASAN, so don't use tag storage pages if HW KASAN is enabled.

Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---

Changes since rfc v2:

* Expanded commit message (David Hildenbrand)

 arch/arm64/kernel/mte_tag_storage.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/kernel/mte_tag_storage.c b/arch/arm64/kernel/mte_tag_storage.c
index 90b157132efa..9a1a8a45171e 100644
--- a/arch/arm64/kernel/mte_tag_storage.c
+++ b/arch/arm64/kernel/mte_tag_storage.c
@@ -256,6 +256,16 @@ void __init mte_init_tag_storage(void)
 		goto out_disabled;
 	}
 
+	/*
+	 * The kernel allocates memory in non-preemptible contexts, which makes
+	 * migration impossible when reserving the associated tag storage. The
+	 * only in-kernel user of tagged pages is HW KASAN.
+	 */
+	if (kasan_hw_tags_enabled()) {
+		pr_info("KASAN HW tags incompatible with MTE tag storage management");
+		goto out_disabled;
+	}
+
 	/*
 	 * Check that tag storage is addressable by the kernel.
 	 * cma_init_reserved_mem(), unlike cma_declare_contiguous_nid(), doesn't
-- 
2.43.0


