Return-Path: <linux-fsdevel+bounces-24718-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE8C5943F52
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 03:38:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C4B51C21E88
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 01:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7859C1C10C8;
	Thu,  1 Aug 2024 00:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZQOR8l4f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E1A1C0DE7;
	Thu,  1 Aug 2024 00:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722472707; cv=none; b=U697Uk1j5EnsoM41thB33fsoQuaiXL6tdfBeNH2AlmttKk8ESDS2NN2coGPqRQAdkreX8E8qgG8DRgEmSeAJ04DII+u+GfYNNE4oTEnSgY778rRb3CwTEDP+01IP9GlxTO3sihfdSaU/Dc9FZmbhn2scNdlbOP+28einAcfMpMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722472707; c=relaxed/simple;
	bh=TpTlO0OyDvh5kxfLQj5/RAuHtKBLDZLs0qXS8eQDUxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UoRUzRYWhPrDrE2OpvJghdyyEC0rERyCoKH0dJAgz8uAbRU/V6gVbYv1zBE0wiCzfDVQ7oMbWvTsi8PbQIJAGkx1+W5oKXsGnCRwdcR8trow8Rr2+/ONkdCU3cN4hkH8ILo/NTRnIQAdJHmJdo4hF189OG0TuwmB4qH3FMaVedo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZQOR8l4f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3EDBC32786;
	Thu,  1 Aug 2024 00:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722472707;
	bh=TpTlO0OyDvh5kxfLQj5/RAuHtKBLDZLs0qXS8eQDUxE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZQOR8l4fPF3o6+d47sYqpOAWfinX9pej0uoD0jaVG3Y6G+RePxzLHaKObfSDZ1y/b
	 TH3xJovIyBd4FDFBL7sYNeadPeII4uyxR56KVMuwduJwRfkD1DeSr2fC7sLMRzksvl
	 pSPb3LH+wBmkmZQpecRvPWq3Vu57+pij0lydL2Ymvs7kbmWD5/BYOIxIvO60GLgpBq
	 40LxRvaKF5U7gvogjDuoiGgzKGSGepkTgS/G+gJnDyyXsqIKqzdt8PV0hwZOUybxPt
	 z3XcrFNEU/C0ewcAtWeTpdkApHXchpQYqpZPkrPJJYBWPupFBVtAxM0YiLXLtF1JUV
	 YWLlvGpgYavjA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alexey Dobriyan <adobriyan@gmail.com>,
	Kees Cook <kees@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH AUTOSEL 5.10 27/38] ELF: fix kernel.randomize_va_space double read
Date: Wed, 31 Jul 2024 20:35:33 -0400
Message-ID: <20240801003643.3938534-27-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801003643.3938534-1-sashal@kernel.org>
References: <20240801003643.3938534-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.223
Content-Transfer-Encoding: 8bit

From: Alexey Dobriyan <adobriyan@gmail.com>

[ Upstream commit 2a97388a807b6ab5538aa8f8537b2463c6988bd2 ]

ELF loader uses "randomize_va_space" twice. It is sysctl and can change
at any moment, so 2 loads could see 2 different values in theory with
unpredictable consequences.

Issue exactly one load for consistent value across one exec.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
Link: https://lore.kernel.org/r/3329905c-7eb8-400a-8f0a-d87cff979b5b@p183
Signed-off-by: Kees Cook <kees@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/binfmt_elf.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index ccc4c6d8a578f..dcca9fe747496 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1005,7 +1005,8 @@ static int load_elf_binary(struct linux_binprm *bprm)
 	if (elf_read_implies_exec(*elf_ex, executable_stack))
 		current->personality |= READ_IMPLIES_EXEC;
 
-	if (!(current->personality & ADDR_NO_RANDOMIZE) && randomize_va_space)
+	const int snapshot_randomize_va_space = READ_ONCE(randomize_va_space);
+	if (!(current->personality & ADDR_NO_RANDOMIZE) && snapshot_randomize_va_space)
 		current->flags |= PF_RANDOMIZE;
 
 	setup_new_exec(bprm);
@@ -1275,7 +1276,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 	mm->end_data = end_data;
 	mm->start_stack = bprm->p;
 
-	if ((current->flags & PF_RANDOMIZE) && (randomize_va_space > 1)) {
+	if ((current->flags & PF_RANDOMIZE) && (snapshot_randomize_va_space > 1)) {
 		/*
 		 * For architectures with ELF randomization, when executing
 		 * a loader directly (i.e. no interpreter listed in ELF
-- 
2.43.0


