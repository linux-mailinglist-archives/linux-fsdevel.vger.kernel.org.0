Return-Path: <linux-fsdevel+bounces-22894-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 873C091E6D9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2024 19:48:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7FB41C21922
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2024 17:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF1CC16EB6A;
	Mon,  1 Jul 2024 17:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JTlR11Z3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564F81649BF;
	Mon,  1 Jul 2024 17:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719856091; cv=none; b=Wyqj1yk0hdbc6dgGKpDAjAXW7lKxJJbe+UWbFhqQQoPT/vdQVPnqmlgR2PJMFJOdjD4FJOn9vYjaAYHzyYOTHVsG5FLhWcBq76J6GECC548+l9/OiwVUdDEgfU7CskX64VwwPpr4JlGNlljWZRWjzd+qHqa7UfJUi9Xr9Koe9yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719856091; c=relaxed/simple;
	bh=KaH8oQNKC2J+JbJiecogG+d2lkZRfkZprOTkDkcmMME=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VU1zimpaDZV04+XgUY8AwadyfVWVxVCoki3xyyhjvgCabN6NCGqJZ3D1BE0GkjY/xiHXGk+tcaYBydZ8XyevaQvP+O50zFhjzAwCUL/y/+6QbCxeqd7Bsfoy8yOvOWnyOfmcOmnkjxrBguYkQDvHUuMVgU14bN0ss5iDDZAStqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JTlR11Z3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D7DFC116B1;
	Mon,  1 Jul 2024 17:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719856089;
	bh=KaH8oQNKC2J+JbJiecogG+d2lkZRfkZprOTkDkcmMME=;
	h=From:To:Cc:Subject:Date:From;
	b=JTlR11Z3vOzVWgjESAvFRce5NH8+OcWnKAfBj7vbmDanIPrM/sUpbNpmek+sVO0bT
	 uW4CS3aWvOC7fb88eYKjAP06LN865mcwXQ41hmWLnj9z8rUs8fXIwdYRWdZThVbswC
	 jub4pkOis0IiXzHnSp2zkzofD2uyG3Se7MLjaJd7qzw8GXKpDxHRwqFtE9mpMz/Cxf
	 PMOo5yeXGUOsBB9Sv7gT8mcmk5OxuvYOsPTSsdFj+hzkrA9lxfar6Yov77+bVhgIo8
	 vTJxn2SzqufaVYLQUKIT6/BRJMBdGrQrodC3bZDhZl2EP+Q6zgjgPF/OSFB7BJPkDB
	 533lcLLASM2hA==
From: Andrii Nakryiko <andrii@kernel.org>
To: linux-mm@kvack.org,
	akpm@linux-foundation.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	adobriyan@gmail.com,
	Andrii Nakryiko <andrii@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH v2 1/2] fs/procfs: fix integer to pointer cast warning in do_procmap_query()
Date: Mon,  1 Jul 2024 10:48:04 -0700
Message-ID: <20240701174805.1897344-1-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 32-bit architectures compiler will complain about casting __u64 to
void * pointer:

fs/proc/task_mmu.c: In function 'do_procmap_query':
fs/proc/task_mmu.c:598:48: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
  598 |         if (karg.vma_name_size && copy_to_user((void __user *)karg.vma_name_addr,
      |                                                ^
fs/proc/task_mmu.c:605:48: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
  605 |         if (karg.build_id_size && copy_to_user((void __user *)karg.build_id_addr,
      |                                                ^

Fix this by using u64_to_user_ptr() helper that's meant to handle this
properly.

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Fixes: df789ce1eb90 ("fs/procfs: add build ID fetching to PROCMAP_QUERY API")
Fixes: 3757be498749 ("fs/procfs: implement efficient VMA querying API for /proc/<pid>/maps")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 fs/proc/task_mmu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index d99a390a0f41..3f1d0d2f78fe 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -595,14 +595,14 @@ static int do_procmap_query(struct proc_maps_private *priv, void __user *uarg)
 	query_vma_teardown(mm, vma);
 	mmput(mm);
 
-	if (karg.vma_name_size && copy_to_user((void __user *)karg.vma_name_addr,
+	if (karg.vma_name_size && copy_to_user(u64_to_user_ptr(karg.vma_name_addr),
 					       name, karg.vma_name_size)) {
 		kfree(name_buf);
 		return -EFAULT;
 	}
 	kfree(name_buf);
 
-	if (karg.build_id_size && copy_to_user((void __user *)karg.build_id_addr,
+	if (karg.build_id_size && copy_to_user(u64_to_user_ptr(karg.build_id_addr),
 					       build_id_buf, karg.build_id_size))
 		return -EFAULT;
 
-- 
2.43.0


