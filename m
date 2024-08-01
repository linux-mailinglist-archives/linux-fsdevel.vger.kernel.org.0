Return-Path: <linux-fsdevel+bounces-24715-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8069943E3C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 03:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4400B2D472
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 01:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D001D4EDE;
	Thu,  1 Aug 2024 00:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ggsp67TP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5128F1D4EC9;
	Thu,  1 Aug 2024 00:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722472252; cv=none; b=klI/hOp8ADNy4TsUy7gXHOMRoRGBFpPo+w9E28w2tuApF+lGTRfERFSuykFYZnQE0hxTK7VutAQi2I0lw7eVqK3rEIESXeCxB5TFSJbLZsGnh8CKbh/Aer+NTRNrtlMGrVVk69taEB94SbE3tSMQfuRwAm5rooMu7WI55dlZRSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722472252; c=relaxed/simple;
	bh=xVj/RY1YK9ba+1fx93zIYgA7qPfIsnUqCCfTuW7IxnE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hu6ziRAdtexRM/4+FrayRMj0xWFu99E4XOcxZ7QGndjvJN2EmzdIc2boKGrep/SoZiQzJbDFRCB3CdRy0Jrt96ZDqq8IOgK5wCSfCxgUJb3SXlAkLHT8u6elYGstnuH9HySx2JvQt+V3EQSNJHr5ChaLLQGXUBAskzfjcIoVlGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ggsp67TP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBD4CC116B1;
	Thu,  1 Aug 2024 00:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722472252;
	bh=xVj/RY1YK9ba+1fx93zIYgA7qPfIsnUqCCfTuW7IxnE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ggsp67TPim5bzdXev8fE3H/cO9+92LaGQORbgSo26i3TOr1FYFuOqcFoBRUHuvxHw
	 He9sFoESZyBzjJJb1yR4cJ4Fx/tFldYXqx2agb8ovm9g54pAv38AMCoIuU67PfmP4j
	 FYYnLVF1UzV47xU67f45N+J//igJwROck9gZ++LPD9uyX6edyEZldBoLbVyHEQtwDb
	 tPRy9RrHXNSiS6xRnEFMAsT+/308f3yoyRIumk1XsV5kXUCmak3myCFs7tv07QMdkP
	 SwJsaucfn4sfVfEhTTQlx9v5t501ismlQazsI3OrzrECNkyyw41ZsLa/OwCU8qMpHR
	 +b3Y56nRlKbKQ==
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
Subject: [PATCH AUTOSEL 6.1 44/61] ELF: fix kernel.randomize_va_space double read
Date: Wed, 31 Jul 2024 20:26:02 -0400
Message-ID: <20240801002803.3935985-44-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801002803.3935985-1-sashal@kernel.org>
References: <20240801002803.3935985-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.102
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
index e6c9c0e084486..89e7e4826efce 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1009,7 +1009,8 @@ static int load_elf_binary(struct linux_binprm *bprm)
 	if (elf_read_implies_exec(*elf_ex, executable_stack))
 		current->personality |= READ_IMPLIES_EXEC;
 
-	if (!(current->personality & ADDR_NO_RANDOMIZE) && randomize_va_space)
+	const int snapshot_randomize_va_space = READ_ONCE(randomize_va_space);
+	if (!(current->personality & ADDR_NO_RANDOMIZE) && snapshot_randomize_va_space)
 		current->flags |= PF_RANDOMIZE;
 
 	setup_new_exec(bprm);
@@ -1301,7 +1302,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 	mm->end_data = end_data;
 	mm->start_stack = bprm->p;
 
-	if ((current->flags & PF_RANDOMIZE) && (randomize_va_space > 1)) {
+	if ((current->flags & PF_RANDOMIZE) && (snapshot_randomize_va_space > 1)) {
 		/*
 		 * For architectures with ELF randomization, when executing
 		 * a loader directly (i.e. no interpreter listed in ELF
-- 
2.43.0


