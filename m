Return-Path: <linux-fsdevel+bounces-23801-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7590933736
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 08:37:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62E0A28272D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 06:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36518168BD;
	Wed, 17 Jul 2024 06:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ESZalBPa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A2D14F6C
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jul 2024 06:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721198264; cv=none; b=jkVvP/t+d5byxe2hBAO78ClXolUTWLjH6CZrprBnHHSkh/I/gFzUfk8i/k6MdX3+zvvabWThPHLcSZpg2ZhEM9iiGjy/JQ4QhKXErQWtz8jSST0oC3vQBpVWwblye1i/1bBGm3VPPbIZSyL4eY5JZnrHltGK1quTV3jRh4pPDGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721198264; c=relaxed/simple;
	bh=RafdoVl1AFvZSDDVIyVeaJylvKWEkW/4IWEZ4W2Y7BQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ez13fdETUdQuhL++y4yOKfeeH9l/C9K2FSHwrGoGytepkqKn3TPorqVdJy5hx3Tut/zOOlSWofThSJlyoCMWCr1dCwKKBBf9oM/hqRgJQ7uSMg0+5uGzZS7s3gAVMZ2GNiIDOsjwtGO45U2i0E+vUVwBfsuhC3pNrJnirmONPFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ESZalBPa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0626C32782;
	Wed, 17 Jul 2024 06:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721198264;
	bh=RafdoVl1AFvZSDDVIyVeaJylvKWEkW/4IWEZ4W2Y7BQ=;
	h=From:To:Cc:Subject:Date:From;
	b=ESZalBPaEcV6O5v4H8p3O+aGUY37+5UAqjd3nDo/wx1JGrqMcTYDC+i9Tk8mWgwee
	 B02fzipFx5qOxZKNEbv4CISKziNashRtUCkFcVDhqExV6/wLzSQLAsJl5TUpFVNzsL
	 gLxnXMfr4Gfu+ZGHI7/02m69m/a3kFzICbTg1VZvxspNHK8pMu7MQToA+hgsk/wJ0W
	 lEBeTjYz7oSlUxhYBg2kEM64u9PtHI4wgjJ8j54Zba9MR4XKigvyvtLpwbEXFr/bxl
	 PUetAhkCi8UM4F/Io32Sj7ibByvaHMRJkNfJvZNzSaqqmb0laep10+dM6YlOoqFBTC
	 dzP/APjLm0HVw==
From: cem@kernel.org
To: linux-fsdevel@vger.kernel.org
Cc: aris@redhat.com,
	jack@suse.cz,
	brauner@kernel.org,
	akpm@linux-foundation.org,
	hughd@google.com
Subject: [PATCH] shmem_quota: Build the object file conditionally to the config option
Date: Wed, 17 Jul 2024 08:37:27 +0200
Message-ID: <20240717063737.910840-1-cem@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Carlos Maiolino <cem@kernel.org>

Initially I added shmem-quota to obj-y, move it to the correct place and
remove the uneeded full file #ifdef

Sugested-by: Aristeu Rozanski <aris@redhat.com>
Signed-off-by: Carlos Maiolino <cmaiolino@redhat.com>
---
 mm/Makefile      | 3 ++-
 mm/shmem_quota.c | 3 ---
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/mm/Makefile b/mm/Makefile
index 8fb85acda1b1c..c3cc1f51bc721 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -52,7 +52,7 @@ obj-y			:= filemap.o mempool.o oom_kill.o fadvise.o \
 			   readahead.o swap.o truncate.o vmscan.o shrinker.o \
 			   shmem.o util.o mmzone.o vmstat.o backing-dev.o \
 			   mm_init.o percpu.o slab_common.o \
-			   compaction.o show_mem.o shmem_quota.o\
+			   compaction.o show_mem.o \
 			   interval_tree.o list_lru.o workingset.o \
 			   debug.o gup.o mmap_lock.o $(mmu-y)
 
@@ -139,3 +139,4 @@ obj-$(CONFIG_HAVE_BOOTMEM_INFO_NODE) += bootmem_info.o
 obj-$(CONFIG_GENERIC_IOREMAP) += ioremap.o
 obj-$(CONFIG_SHRINKER_DEBUG) += shrinker_debug.o
 obj-$(CONFIG_EXECMEM) += execmem.o
+obj-$(CONFIG_TMPFS_QUOTA) += shmem_quota.o
diff --git a/mm/shmem_quota.c b/mm/shmem_quota.c
index ce514e700d2f6..d1e32ac01407a 100644
--- a/mm/shmem_quota.c
+++ b/mm/shmem_quota.c
@@ -34,8 +34,6 @@
 #include <linux/quotaops.h>
 #include <linux/quota.h>
 
-#ifdef CONFIG_TMPFS_QUOTA
-
 /*
  * The following constants define the amount of time given a user
  * before the soft limits are treated as hard limits (usually resulting
@@ -351,4 +349,3 @@ const struct dquot_operations shmem_quota_operations = {
 	.mark_dirty		= shmem_mark_dquot_dirty,
 	.get_next_id		= shmem_get_next_id,
 };
-#endif /* CONFIG_TMPFS_QUOTA */
-- 
2.45.2


