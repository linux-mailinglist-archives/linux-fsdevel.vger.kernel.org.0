Return-Path: <linux-fsdevel+bounces-20178-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 319A68CF3CD
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 May 2024 11:55:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCEEBB215D5
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 May 2024 09:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21826131BB1;
	Sun, 26 May 2024 09:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HoACqVRC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AEB413175C;
	Sun, 26 May 2024 09:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716716630; cv=none; b=eJ/Sdbxxtc/3ZcLZzKPw2MMqNcjQoq7mvSMUMsY9u2/7FwaOoMvdukzDmYbzu17BhfxfVy9TykDA1OUXED99vkTv/CzGv7h0Rw3EL+51+S3e/PgDfYotwCao/Iqb/u/eRf7b+t9Qwr+F1zjlGBiyZlZuLHz5I/mf+hx+tdQIWMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716716630; c=relaxed/simple;
	bh=+yvYSvUyie0rL8Tnq4/NAG7bAUWD64OtXUT4XqJCH2U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SQaWUAq/FWX11eglGtalHW8ZCorF7EK1Y2wpq7Krc+724N8rSCDOEnGzO03Rx0P+4cNTlAkaOsOait4W+PZsE+sLap3yIl+Gjh6p0alp5sHHpURmDO0bnQnbC1xQ2fy6z2H92OCwwUjr9y2z+7c78fEMt2BYbIlUaMwF3aX2AAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HoACqVRC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AC85C2BD10;
	Sun, 26 May 2024 09:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716716630;
	bh=+yvYSvUyie0rL8Tnq4/NAG7bAUWD64OtXUT4XqJCH2U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HoACqVRCE0xRvyVKNs0ekxGuKjJrDXjbw9sq3KgnI5d8XQKs56BI38ORU+NiHeTZ3
	 whn9soUwbTLpMgPryc9r8BeVp6mN1Bd0ecY/1xZOgHrU4K/MJSKaXexptHBvbDGjl4
	 Y6Adwrnc/PmryT4Z1R9+NBY0OqpNCJ7M2OqWORP80345ALaR0BE+zbbYuKW7aPlRri
	 cX2BSiLwSZAZpXkmqysV6Lbj7ROTx3f6h+x1OktKNg9bb84+OSoeuid99evrJzNe5g
	 7zj0sXGKToks+oHeKIy5dr9cGoEiqev/b4IZh+kqT/mqvlECjFQ+8zFyEVol4xg3NZ
	 QjUSwwG1yNfZA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	y0un9n132@gmail.com,
	Sasha Levin <sashal@kernel.org>,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH AUTOSEL 5.10 4/5] binfmt_elf: Leave a gap between .bss and brk
Date: Sun, 26 May 2024 05:43:40 -0400
Message-ID: <20240526094342.3413841-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240526094342.3413841-1-sashal@kernel.org>
References: <20240526094342.3413841-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.217
Content-Transfer-Encoding: 8bit

From: Kees Cook <keescook@chromium.org>

[ Upstream commit 2a5eb9995528441447d33838727f6ec1caf08139 ]

Currently the brk starts its randomization immediately after .bss,
which means there is a chance that when the random offset is 0, linear
overflows from .bss can reach into the brk area. Leave at least a single
page gap between .bss and brk (when it has not already been explicitly
relocated into the mmap range).

Reported-by:  <y0un9n132@gmail.com>
Closes: https://lore.kernel.org/linux-hardening/CA+2EKTVLvc8hDZc+2Yhwmus=dzOUG5E4gV7ayCbu0MPJTZzWkw@mail.gmail.com/
Link: https://lore.kernel.org/r/20240217062545.1631668-2-keescook@chromium.org
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/binfmt_elf.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index ccc4c6d8a578f..d5f9ad0651ea5 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1286,6 +1286,9 @@ static int load_elf_binary(struct linux_binprm *bprm)
 		if (IS_ENABLED(CONFIG_ARCH_HAS_ELF_RANDOMIZE) &&
 		    elf_ex->e_type == ET_DYN && !interpreter) {
 			mm->brk = mm->start_brk = ELF_ET_DYN_BASE;
+		} else {
+			/* Otherwise leave a gap between .bss and brk. */
+			mm->brk = mm->start_brk = mm->brk + PAGE_SIZE;
 		}
 
 		mm->brk = mm->start_brk = arch_randomize_brk(mm);
-- 
2.43.0


