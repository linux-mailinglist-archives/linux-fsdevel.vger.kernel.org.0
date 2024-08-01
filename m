Return-Path: <linux-fsdevel+bounces-24719-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BA44943F89
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 03:43:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D65D1C2221B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 01:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5957414D446;
	Thu,  1 Aug 2024 00:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LOytw9Nh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A701E6E70;
	Thu,  1 Aug 2024 00:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722472800; cv=none; b=TlEtkQo2xmaRHJWFXJ40nscruV4W8Ayx83i9OSD6oZl/pKzaKYIo4nox2cClaM35cHSgb+DxmEaa/5yh4LDmWuIG0f41JP7VfDp3xoVAknN5cnoxfSOmdnLi16Yg1D4FrZ8XZQVnG5JDYhT9/GQCpfHsj8+13rvgT1MeraKGdZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722472800; c=relaxed/simple;
	bh=lsmGopSKeK/awEcL9oxaEYbKhcLLMu8DHedaDPU7CEg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iDi49vgPzYlHdUCe1bYL/vQ4uT2JGhY1vLBRtmufxENO3QUU921+8ky7HUsJOtCNXOgddXK8UAQRjnBZxqyRYFOlh+v4ANbyjabAOsWtJn1G9yjTMprIi2J3/pQfbwaWNjWZ0ClFI5b/LL9Zz0ns48ZX3+UgOyK/GNSEa5s/EQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LOytw9Nh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78826C4AF0C;
	Thu,  1 Aug 2024 00:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722472800;
	bh=lsmGopSKeK/awEcL9oxaEYbKhcLLMu8DHedaDPU7CEg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LOytw9NhgAb1CNkvhRSeeAZc1HZ2xkTJ0GW1xdqlJt7GcgC3xiIk/u8oyMjo7ii3X
	 8N7CKbMjXQZEGALKh226ST6xA9dNzapj86AFlIJQki49I2KLH/ABt8Q2OK5mFhzcsd
	 xgn1I6zG5lN7CSn42LuV6GpTXsB6S3gEMxRH/wMemD0fHfEobKVFeVhimRkLCIHboi
	 qas6VxXGxwM0X+IpHbglNNtDrw2UWCW2SjEqk5KL6hNlHC1KDEIYQkbZuDy2tKVFm3
	 q+d2BSTf9tJam5Gg3Cl9+gcKjoktuvWbndYbrwN6ViZPH4ybhdl1ILPnwAeB3cvbqR
	 WHZuxgvjN3GNQ==
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
Subject: [PATCH AUTOSEL 5.4 12/22] ELF: fix kernel.randomize_va_space double read
Date: Wed, 31 Jul 2024 20:38:41 -0400
Message-ID: <20240801003918.3939431-12-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801003918.3939431-1-sashal@kernel.org>
References: <20240801003918.3939431-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.281
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
index 72cd871544ac0..33c323a2ccb19 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -854,7 +854,8 @@ static int load_elf_binary(struct linux_binprm *bprm)
 	if (elf_read_implies_exec(loc->elf_ex, executable_stack))
 		current->personality |= READ_IMPLIES_EXEC;
 
-	if (!(current->personality & ADDR_NO_RANDOMIZE) && randomize_va_space)
+	const int snapshot_randomize_va_space = READ_ONCE(randomize_va_space);
+	if (!(current->personality & ADDR_NO_RANDOMIZE) && snapshot_randomize_va_space)
 		current->flags |= PF_RANDOMIZE;
 
 	setup_new_exec(bprm);
@@ -1106,7 +1107,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 	current->mm->end_data = end_data;
 	current->mm->start_stack = bprm->p;
 
-	if ((current->flags & PF_RANDOMIZE) && (randomize_va_space > 1)) {
+	if ((current->flags & PF_RANDOMIZE) && (snapshot_randomize_va_space > 1)) {
 		/*
 		 * For architectures with ELF randomization, when executing
 		 * a loader directly (i.e. no interpreter listed in ELF
-- 
2.43.0


