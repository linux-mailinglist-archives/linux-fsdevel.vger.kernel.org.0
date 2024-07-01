Return-Path: <linux-fsdevel+bounces-22831-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DB4891D5C1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2024 03:24:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 559A51C20748
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2024 01:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8924A63B9;
	Mon,  1 Jul 2024 01:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pwm4SjLZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2C3443D;
	Mon,  1 Jul 2024 01:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719797034; cv=none; b=AB8kF8lbOq7vL8YERIqosFUk/9FX35euCXaYiAz5DcbnJXRyJGGIAa/fVMHxe7QLukfjcd/8AMn3eXBuQU++2a/qxPem2/K7ma5o8dZoecRuHhP+c6JhPlX0iDQoVMpQWaVTotQMFztF3FXrThwiXrDVsOvm6GhE9lGGFMzglws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719797034; c=relaxed/simple;
	bh=PXEVGb9oz8orp8VLr8ThkNcfgmDcGbc5DLjK93XJEqg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i3Hu8GP3c8LtVQnCdVgpgD33P8aRg7rT4GJljTqtDrHFeIYsdi9MHa+tm9mCsyWdIdKWSQAC2BY5peHMfOdwJi+2/RNXMjt5PBCh3XmZxMlSOwHEoVkmx3ZZcAGh7Vb/cgeaeYGaL+L23uCRHXwEXZClX69/NgB0EwBHgsxkfpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pwm4SjLZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51263C2BD10;
	Mon,  1 Jul 2024 01:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719797033;
	bh=PXEVGb9oz8orp8VLr8ThkNcfgmDcGbc5DLjK93XJEqg=;
	h=From:To:Cc:Subject:Date:From;
	b=Pwm4SjLZX09ACPcQSjvLIshCIvAiJk/sFRJChDuSLASzT3uNoYtLac5aal4BCYOsh
	 i/Fqp5yQh370oEBurgsGrFHlQI3NlDhuz4Q2q1Fp8LJZIupqG8q0b2pSi9oGTCq4CC
	 0OMvWhgK9o2SmpRPeP3n2y6u6NgMZFu8EiSJvs9HMgDTjRe3OrknSf8bVK7Fh17rjI
	 jVqCSSMdeX/uBFMkE2Sd7nzESi8/TQaDZIoNCWfTGPj3T/rtFaSrr9DPKzCPQ7Uaiy
	 HAKdrvix+i+xoNL2o+YQCAWFDPjk7VsNb7MY73Oa0WiZZDWaZPNXMD87QfvohaTN5u
	 l7SPm5ewg8Drg==
From: Andrii Nakryiko <andrii@kernel.org>
To: linux-mm@kvack.org,
	akpm@linux-foundation.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	adobriyan@gmail.com,
	Andrii Nakryiko <andrii@kernel.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH] fs/procfs: fix integer to pointer cast warning in do_procmap_query()
Date: Sun, 30 Jun 2024 18:23:48 -0700
Message-ID: <20240701012348.2409471-1-andrii@kernel.org>
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

Fix this by adding intermediate cast to uintptr_t.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Fixes: df789ce1eb90 ("fs/procfs: add build ID fetching to PROCMAP_QUERY API")
Fixes: 3757be498749 ("fs/procfs: implement efficient VMA querying API for /proc/<pid>/maps")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 fs/proc/task_mmu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index d99a390a0f41..e11d6197cef5 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -595,14 +595,14 @@ static int do_procmap_query(struct proc_maps_private *priv, void __user *uarg)
 	query_vma_teardown(mm, vma);
 	mmput(mm);
 
-	if (karg.vma_name_size && copy_to_user((void __user *)karg.vma_name_addr,
+	if (karg.vma_name_size && copy_to_user((void __user *)(uintptr_t)karg.vma_name_addr,
 					       name, karg.vma_name_size)) {
 		kfree(name_buf);
 		return -EFAULT;
 	}
 	kfree(name_buf);
 
-	if (karg.build_id_size && copy_to_user((void __user *)karg.build_id_addr,
+	if (karg.build_id_size && copy_to_user((void __user *)(uintptr_t)karg.build_id_addr,
 					       build_id_buf, karg.build_id_size))
 		return -EFAULT;
 
-- 
2.43.0


