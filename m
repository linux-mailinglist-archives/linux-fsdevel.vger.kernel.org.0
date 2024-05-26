Return-Path: <linux-fsdevel+bounces-20175-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CC618CF394
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 May 2024 11:50:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCB921F2127B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 May 2024 09:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17EA912883C;
	Sun, 26 May 2024 09:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QRPFUp54"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4E5171BA;
	Sun, 26 May 2024 09:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716716588; cv=none; b=EOhpOOBaMgWNq/egeHxK266ISH98I32bA+nhgpzEm3RB1GIslt0TZgxfAMl8NvW2VSg2xPCWEJcoBK8/FWn1cACBqj0vgv8Rqda2RPXjTNC20cvMD56w4LUGySkKx3tW/lm+CtA+FxJzZvQBxL65BtJ/OP/BciYXGxhoCRGelT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716716588; c=relaxed/simple;
	bh=4A7m0dO5V/ZZvMQzkvzSPqhwwciFofl3dKe7JykXZyk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hx2zzlZQqlvL3k+gkeeePEkfulNk9PA7rtd8BY3UrqeOCwAts+JlMtIQYoUB+8XM72t/gDrUVaMRVRQSSwRKhLZgqjp+r8i2P/oUqVWosJ9YFnJaHjuff9Po4GFEOk8DW/ru4JeUT+4k/Sko+CqKdxrOFdTBugTvTyiO2uZyut4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QRPFUp54; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0294BC32781;
	Sun, 26 May 2024 09:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716716588;
	bh=4A7m0dO5V/ZZvMQzkvzSPqhwwciFofl3dKe7JykXZyk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QRPFUp54bcn0Kg0V2K1+V3UJSOhJnzn0hi1KlLPIHhxT+rp7eYZ8vGLrn6jUYlJNI
	 HCOx4I8i2l396abWzWdzv4B0L6wUXO3lQPcl7TxxtAlkf3+qij08KhuDhvmv8TxQJ2
	 DLC4o0313NIBhZG53VavKza8UxU/RcbwVNsSbutfwEM1yfSJqxWOTi/SAHP1Dhu2mH
	 1o6+l+TrLXaQBsS9fFtnrB64yG60TGsyrHH5hpTtFG1Gyif3kto8UzXgzHUVDiPqKD
	 UORVBRxUJPXvvY4u9rVp7tunAAjP8LDo8FSkSwWDkLTh/+h3Wk53/iCQ5Y556tIEo+
	 ijDb0CjZTH/sQ==
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
Subject: [PATCH AUTOSEL 6.6 10/11] binfmt_elf: Leave a gap between .bss and brk
Date: Sun, 26 May 2024 05:42:48 -0400
Message-ID: <20240526094251.3413178-10-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240526094251.3413178-1-sashal@kernel.org>
References: <20240526094251.3413178-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.31
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
index 7b3d2d4914073..aae062a272cef 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1311,6 +1311,9 @@ static int load_elf_binary(struct linux_binprm *bprm)
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


