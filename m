Return-Path: <linux-fsdevel+bounces-24720-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5F40943FAD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 03:48:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE2C91C22429
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 01:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC4411E9ADE;
	Thu,  1 Aug 2024 00:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rxv/ee1S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7441E9AC7;
	Thu,  1 Aug 2024 00:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722472854; cv=none; b=nIwc6SL78rh6KGU0vqBQlwYiAytNjr8IIrudqNmcx51oju5Um2XTRzc3eFFmD9kWZnxbKheiTR95zxL4SgNdxE8iEKmhu9I5EPcz/Amkrp07EaO/eKaZ+NqAEG9cdtYkZc7Rkb3PUg7FGLXqm1Em9e26nH8o/7RM6DE4LMfPRow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722472854; c=relaxed/simple;
	bh=xpNOueL8LsTpELZTogQwevQccaGHx3UJJeuEUYFzloE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CZtHm8Vb7Sk/SLhp/JXaVlNo+AOg90rsRnhuKkjFEq+zahyIyrVlF5qODC98iXqkp6+NTXPjEW7gCZqGUmmUUdujDA8VbcHFlKECeSR8/i7kAYpVLmyNi4x3fbTTa1jElBg8K1IFW7Mmt5z+BI9YAr4qfH1FBFKVoBshXlpslOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rxv/ee1S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEC5BC4AF0C;
	Thu,  1 Aug 2024 00:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722472854;
	bh=xpNOueL8LsTpELZTogQwevQccaGHx3UJJeuEUYFzloE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rxv/ee1SHz+Ksny0xphP2JbrlQ1bQYVSj5nkxcsPGb44VhbewqzFN2WwYbocvkAH3
	 c+z5or8FzYcLEScoF30p56VMAps5SrdfmP6xyxWgKcdwQw4gU+5t1RpSGLI87LryFj
	 onn4E/pN3iPWSGOcrMCI37WjF/0tDqeexGX/T6h1Ln/4JHZBn0PSann1dZfB/PVIra
	 02sHnIwOywCXxVJvq2GVB8sVzyJ7p/fVdnqGJc9YvYWXaH6ZYFaZmL81buJvX3tM/p
	 9CexARZbm2NVxTf1q5czot9oU2PqMpBWLbl0BMyAhXVkJ54laMWLiJ9VAOGVl8ZPC/
	 /OyA1qYNDVNZg==
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
Subject: [PATCH AUTOSEL 4.19 06/14] ELF: fix kernel.randomize_va_space double read
Date: Wed, 31 Jul 2024 20:40:14 -0400
Message-ID: <20240801004037.3939932-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801004037.3939932-1-sashal@kernel.org>
References: <20240801004037.3939932-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.319
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
index c41c568ad1b8a..af8830878fa0b 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -876,7 +876,8 @@ static int load_elf_binary(struct linux_binprm *bprm)
 	if (elf_read_implies_exec(loc->elf_ex, executable_stack))
 		current->personality |= READ_IMPLIES_EXEC;
 
-	if (!(current->personality & ADDR_NO_RANDOMIZE) && randomize_va_space)
+	const int snapshot_randomize_va_space = READ_ONCE(randomize_va_space);
+	if (!(current->personality & ADDR_NO_RANDOMIZE) && snapshot_randomize_va_space)
 		current->flags |= PF_RANDOMIZE;
 
 	setup_new_exec(bprm);
@@ -1136,7 +1137,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 	current->mm->end_data = end_data;
 	current->mm->start_stack = bprm->p;
 
-	if ((current->flags & PF_RANDOMIZE) && (randomize_va_space > 1)) {
+	if ((current->flags & PF_RANDOMIZE) && (snapshot_randomize_va_space > 1)) {
 		/*
 		 * For architectures with ELF randomization, when executing
 		 * a loader directly (i.e. no interpreter listed in ELF
-- 
2.43.0


