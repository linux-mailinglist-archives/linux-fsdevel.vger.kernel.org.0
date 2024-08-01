Return-Path: <linux-fsdevel+bounces-24714-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBEA3943D7C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 03:00:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86058282963
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 01:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E5D1B272E;
	Thu,  1 Aug 2024 00:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JfKNGj+b"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F414C1B2718;
	Thu,  1 Aug 2024 00:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722471917; cv=none; b=gMsZqfnMII3QBGbazcE187yvICXGpiQZwQB9VgC1P3AYGgQGB8b7Oo4RAB7wDGSDHCpSmOZhZqMq8COXQ3iUl+1gGy8xX9IW8AEu0moaPsulfdoEysxghIyp0xJ+Zcq03dGtjSV6FpeSYFcMJVTE4R9txTi/JFjhfzzV90t4IZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722471917; c=relaxed/simple;
	bh=O1yR9stRS8iMyzwtJL17TgK1ZYQhO0o0ncQ6OPTKSHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZP4zMrR8U1+Jsco5Mhg8gcJHXEo+f2ykn50BLwTD6/6LIRjpEcI1i6wna1NPQD0IPR0Z0ZWFFHctHJ8oKytYvwChOYWYZscyYDbz2moMg9aVsgIkn6Ecs4CDUQWaVfdxdKtGMZgUsiXemJYUXrlQ9mWgqtWWJ0WyVgP/09/nBQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JfKNGj+b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD19AC116B1;
	Thu,  1 Aug 2024 00:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722471916;
	bh=O1yR9stRS8iMyzwtJL17TgK1ZYQhO0o0ncQ6OPTKSHQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JfKNGj+b1lcONxPatz470BjPtI1pOsJPU378C4rzFzPiJ3lXXxXaYiAb9rdw1UTxZ
	 d/txvw9NCdkFxukqSQMalQjDDDhNI1yWzkQUFQW55uGSsfOzPDTOqteUS/YUND0m2+
	 Sdlxwx4FLCZJuWYncqrk69d92KD1Rf49SvgbnIYaUvlENuMEWJSHTRttT0nmUGDgKT
	 Jhc4BlWYhGJn1ZArYK2y3ByF28I06AITtWZZtEGHVUGZStox+XVG29mU27OJVZbQNL
	 kygvSPkZ5+sK3ax5QuGQny55NMfyzDIQNtaeLhiEOaHgUsPrtJNUlVBMb4UeCz3ABB
	 MhAofoiMcdVwA==
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
Subject: [PATCH AUTOSEL 6.6 61/83] ELF: fix kernel.randomize_va_space double read
Date: Wed, 31 Jul 2024 20:18:16 -0400
Message-ID: <20240801002107.3934037-61-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801002107.3934037-1-sashal@kernel.org>
References: <20240801002107.3934037-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.43
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
index 7b3d2d4914073..fb2c8d14327ae 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1008,7 +1008,8 @@ static int load_elf_binary(struct linux_binprm *bprm)
 	if (elf_read_implies_exec(*elf_ex, executable_stack))
 		current->personality |= READ_IMPLIES_EXEC;
 
-	if (!(current->personality & ADDR_NO_RANDOMIZE) && randomize_va_space)
+	const int snapshot_randomize_va_space = READ_ONCE(randomize_va_space);
+	if (!(current->personality & ADDR_NO_RANDOMIZE) && snapshot_randomize_va_space)
 		current->flags |= PF_RANDOMIZE;
 
 	setup_new_exec(bprm);
@@ -1300,7 +1301,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 	mm->end_data = end_data;
 	mm->start_stack = bprm->p;
 
-	if ((current->flags & PF_RANDOMIZE) && (randomize_va_space > 1)) {
+	if ((current->flags & PF_RANDOMIZE) && (snapshot_randomize_va_space > 1)) {
 		/*
 		 * For architectures with ELF randomization, when executing
 		 * a loader directly (i.e. no interpreter listed in ELF
-- 
2.43.0


