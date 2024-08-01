Return-Path: <linux-fsdevel+bounces-24716-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16514943EE6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 03:28:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33FC91C2156C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 01:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96AB61DCC6D;
	Thu,  1 Aug 2024 00:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IryUmZ+m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBECD1A71FD;
	Thu,  1 Aug 2024 00:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722472511; cv=none; b=oxut7J+cdJ5WM5uFNUS3wSpeJf4CKuHVqeUu+RlTNKltIWYRkJIELZJeXAQYczEbonoI8iHciDSM/r5ngSdcjljai9q+9PprtsHf0KGu7/qVHusRRERBuHRaDr2TaI6kGbtpoNkodCDGQmnCdy+VDYBlh9wGcZIkk8R68OGCGds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722472511; c=relaxed/simple;
	bh=cmjFbj4dkpWcVlZABFJ28iwCCS6WyrWAhdu12n0Iwms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=St9u40/4MIVSncHcLLymL7EkzLf434QFFbVyoUeuTnjNtTVqop9qPS+Au7J593XhrRa+8rky4/PRGwshFzIqU5QppcI4g/qiY7XiOT7LtEfMOasqT5e0ncGjSqLpQ9e9FYLHbICR+IHiFFC8YbNSE4Co7NNGil83KBZBlM+rZK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IryUmZ+m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60413C116B1;
	Thu,  1 Aug 2024 00:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722472510;
	bh=cmjFbj4dkpWcVlZABFJ28iwCCS6WyrWAhdu12n0Iwms=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IryUmZ+mXF4GfyQdAHopS4/cmmA+xngA6VRRg1SncpJsF4RmFhXXRSDGRoorqw4za
	 hA0/IfoJk/XxY2olUVGCV5msq6vk+3GWfXNhgqXliqRzF6viIfKlZgKZLwDOatUOK1
	 CH+67oBvFyksjumqvQu6BF+4uu8Lvofiwui5pUMRL6I0BDTHUlNctW+AuroRFsXijf
	 PnOn8EkXIenlS1OnkJ5N+QDQazWOaXqS9oqt6WM0Tt9DzXXknaGYH6QnLbdyO/U81Y
	 31ruFNPBrRImfzVwt59jh1ZNtfaWcTvcXEPSUYZ7BiGDXcML6K59FFj6iyusVWBdAU
	 JFeTt9TgQMoJA==
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
Subject: [PATCH AUTOSEL 5.15 34/47] ELF: fix kernel.randomize_va_space double read
Date: Wed, 31 Jul 2024 20:31:24 -0400
Message-ID: <20240801003256.3937416-34-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801003256.3937416-1-sashal@kernel.org>
References: <20240801003256.3937416-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.164
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
index 30379c33ad20c..4a11784b9f896 100644
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
@@ -1278,7 +1279,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 	mm->end_data = end_data;
 	mm->start_stack = bprm->p;
 
-	if ((current->flags & PF_RANDOMIZE) && (randomize_va_space > 1)) {
+	if ((current->flags & PF_RANDOMIZE) && (snapshot_randomize_va_space > 1)) {
 		/*
 		 * For architectures with ELF randomization, when executing
 		 * a loader directly (i.e. no interpreter listed in ELF
-- 
2.43.0


