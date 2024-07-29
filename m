Return-Path: <linux-fsdevel+bounces-24499-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C90B093FC88
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 19:41:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D13F1C21E7D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 17:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 185D0183087;
	Mon, 29 Jul 2024 17:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="abSG6dIR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765BA80633;
	Mon, 29 Jul 2024 17:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722274847; cv=none; b=p6SRMvHe6LJVyxcCoDtfrYypnW3Zj9+OhPaMg8O4xY1WgtHk95vQevaUOsECMAPMHqpAwicw5x0tQOC+X8bhRkyMxIx2ySU1VdVcHt+IgKFpBoJTRmYKxUomiCyxoDlj+CrHRNnfxpX0BN/HyJC+yUfxiYPwWDgnbx/dlCmy4Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722274847; c=relaxed/simple;
	bh=LWW1/BZkWBLP3Tf/ZADHPaHtHdDn/4RW9VkLUmLTGQI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bNkQWeQzjzOYeiNyt15XwoirVHa4rrx3NsD1C9tAgZP0xqlF/NSzvvkdoUS2SyteTxhWnO+IzWPKDpWADEgJvMoyNHcl0qDhU+I4jLlc2etrSYrR2IBuX9ys+Q+yTsshC7uLeiXDO7tQUvZTsaJwugvg6uxzn4ZMPPPGy1ClBBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=abSG6dIR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FE79C32786;
	Mon, 29 Jul 2024 17:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722274847;
	bh=LWW1/BZkWBLP3Tf/ZADHPaHtHdDn/4RW9VkLUmLTGQI=;
	h=From:To:Cc:Subject:Date:From;
	b=abSG6dIRfLLXaJlWR4pdlEmEjg47ajPpuocowilM116XziMOGJqNCyZXPoYWR7FKI
	 P6vhhuq6NgfBo8ZW9z9O3DZrMOvLNB3xGiaIqpX3q96AmAB+EEW2mr/Ksetd2HIjHr
	 AHe55rLvFBNjqHrViakaHFZRfIz8uJgaSzq7z6UYEt3wQUY8EmFi7mBE0L3dDTBcCE
	 Iu5VK8CjP1xDrLvVNou7yRYASLJpQCIIobLnG4aWuunEq1pYanvL45m4dx7sYt3CWb
	 IY4WhAr/6yNUYdx/Df3r9MgdskXo+v1lAVVC9dGsbNSnKKvE9uKIWN2dbCuGmOvMNv
	 UN0FXu2ihgksA==
From: Andrii Nakryiko <andrii@kernel.org>
To: linux-mm@kvack.org,
	akpm@linux-foundation.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	adobriyan@gmail.com,
	Andrii Nakryiko <andrii@kernel.org>,
	Jann Horn <jannh@google.com>
Subject: [PATCH] fs/procfs: remove build ID-related code duplication in PROCMAP_QUERY
Date: Mon, 29 Jul 2024 10:40:44 -0700
Message-ID: <20240729174044.4008399-1-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A piece of build ID handling code in PROCMAP_QUERY ioctl() was
accidentally duplicated. It wasn't meant to be part of
ed5d583a88a9 ("fs/procfs: implement efficient VMA querying API for /proc/<pid>/maps")
commit, which is what introduced duplication.

It has no correctness implications, but we unnecessarily perform the
same work twice, if build ID parsing is requested. Drop the duplication.

Reported-by: Jann Horn <jannh@google.com>
Fixes: ed5d583a88a9 ("fs/procfs: implement efficient VMA querying API for /proc/<pid>/maps")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 fs/proc/task_mmu.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 5f171ad7b436..3ba613052506 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -543,21 +543,6 @@ static int do_procmap_query(struct proc_maps_private *priv, void __user *uarg)
 		}
 	}
 
-	if (karg.build_id_size) {
-		__u32 build_id_sz;
-
-		err = build_id_parse(vma, build_id_buf, &build_id_sz);
-		if (err) {
-			karg.build_id_size = 0;
-		} else {
-			if (karg.build_id_size < build_id_sz) {
-				err = -ENAMETOOLONG;
-				goto out;
-			}
-			karg.build_id_size = build_id_sz;
-		}
-	}
-
 	if (karg.vma_name_size) {
 		size_t name_buf_sz = min_t(size_t, PATH_MAX, karg.vma_name_size);
 		const struct path *path;
-- 
2.43.0


