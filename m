Return-Path: <linux-fsdevel+bounces-24713-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CEEA943C4E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 02:37:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30FA32814C0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 00:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBE501BE246;
	Thu,  1 Aug 2024 00:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kzYlhmMw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5171BE22C;
	Thu,  1 Aug 2024 00:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722471416; cv=none; b=SsoNnBz/7AAdB2NP4JYSDFmTdcF8X64VU13IWO8mQYXxsxGkuIXWJQcc5wvrnTUzVot29ktOjjDX+WHelEznAVMIsLWzniNlgDSX4mpnqW5dbr8CiUXZGlUUTwGWVv/5O5n2/ZZNgFq7hy0KaWWlpqpj634FDHT+pALAlkapZG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722471416; c=relaxed/simple;
	bh=5B3jDTKFbGnvLZkE4B5MYaNhqhyCTyrK6VP++3rLpEA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bXI/Z2w7iH/LLnqTIeM1IaForN5H9oy8X9OkTFCkVUQ4HM5LH8ZgsXtQIwRkA9as+ifZNVJ9pcJAHdj5JxJjuP6ffI9nwlo/B1Yq96Qwj9f83EwmF6wnBMVmkPCpiSv20lDS63wrAmh97TmqVEL03y+rSB5Lt4+ruRBw5hk/lPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kzYlhmMw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98F9AC4AF0C;
	Thu,  1 Aug 2024 00:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722471415;
	bh=5B3jDTKFbGnvLZkE4B5MYaNhqhyCTyrK6VP++3rLpEA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kzYlhmMwwRiq/l+siTKBMT7hdMGnFMyMoFooxFzCG2j2DMuHV+I+wBSfOSGbSPrjn
	 ElXxpnxMLTl8XUhID3QNu3BWZYU3YgHb3rMF6Xfc5SRcpeiHE0Nl6mwdIfjvqkI2oK
	 8orp6a14MG/0Gr44De0Ry47MK0BHrmlW3G9trSnsFMaQJh5y10zx0iYpPaht7ui1NB
	 RJki4V44ZnuTuMsQxCiPpFrjEzqvAEZwaQ/D5RdvxCLBC5T39M8rqlFWQgfQT5K5PU
	 WHbcnoXTBu6tviWTqQYKbuJ92FvEGuPYLTXT4/tvEwNzlJ6huaChtWuQkU0NoDovKf
	 QwEw4+b8QY+VQ==
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
Subject: [PATCH AUTOSEL 6.10 090/121] ELF: fix kernel.randomize_va_space double read
Date: Wed, 31 Jul 2024 20:00:28 -0400
Message-ID: <20240801000834.3930818-90-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801000834.3930818-1-sashal@kernel.org>
References: <20240801000834.3930818-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.2
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
index a43897b03ce94..777405719de85 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1003,7 +1003,8 @@ static int load_elf_binary(struct linux_binprm *bprm)
 	if (elf_read_implies_exec(*elf_ex, executable_stack))
 		current->personality |= READ_IMPLIES_EXEC;
 
-	if (!(current->personality & ADDR_NO_RANDOMIZE) && randomize_va_space)
+	const int snapshot_randomize_va_space = READ_ONCE(randomize_va_space);
+	if (!(current->personality & ADDR_NO_RANDOMIZE) && snapshot_randomize_va_space)
 		current->flags |= PF_RANDOMIZE;
 
 	setup_new_exec(bprm);
@@ -1251,7 +1252,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 	mm->end_data = end_data;
 	mm->start_stack = bprm->p;
 
-	if ((current->flags & PF_RANDOMIZE) && (randomize_va_space > 1)) {
+	if ((current->flags & PF_RANDOMIZE) && (snapshot_randomize_va_space > 1)) {
 		/*
 		 * For architectures with ELF randomization, when executing
 		 * a loader directly (i.e. no interpreter listed in ELF
-- 
2.43.0


