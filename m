Return-Path: <linux-fsdevel+bounces-20176-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BD5C8CF3AD
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 May 2024 11:52:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48446280CCA
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 May 2024 09:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DED3512F379;
	Sun, 26 May 2024 09:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cAu+HC5A"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44EF212EBFC;
	Sun, 26 May 2024 09:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716716606; cv=none; b=nMPb43tgkCukC1T77co0nF7qWrO2DaM5pvqh8ELJLTtimOi3t0iICV49PLXjjjf2gCtmpC8MT/JePy8tfh0cTVi0j6HcQJztrQSBZFhP7G2plUParde/6qHv8GqpYESjY/+3tRuhkFh8AyG6UVwWV43NQncipZEyu9tjONM82Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716716606; c=relaxed/simple;
	bh=iuM2U8WEXSP3xVwKAhqQ+elhYN7vbyj9WNnTxM7DPvk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iU2cJxxLhEIRRf8gmsubsrgyDq7A44q5HeZ1uzEwiS2Y+1dmRBUDfFdB4TCFFsPwJidDXEFM0lKuhr1PbqEWmAps5BDSQbR6qoK0066BHocfDrEj1/isDJIQts/IvMmKrdMVVI8ePIXS9X4FYxS4fk6oIzvAgDHeK7XkOgUtMgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cAu+HC5A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAE05C32781;
	Sun, 26 May 2024 09:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716716605;
	bh=iuM2U8WEXSP3xVwKAhqQ+elhYN7vbyj9WNnTxM7DPvk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cAu+HC5AcTY6X89/kSPdZg4cay4OFmdNuVNblVk8X6nIEsYCHXJ1jfFZ3h0ZSd30K
	 8cLgTYJFRgqR/lr5JvIVakElVbO5lAWJfYa00apEBki2F9JKKJllni7qpAWac3vqri
	 bMVOQmIAyhXIjYUqAqcqOw/ny15kfQBoynZhOXwQv0oBxqpBc3P/m21wsBmoYIlhJB
	 OKABBKx10QUbn/XXGddmUg2lu12KR27hcYPEZrFfqS0lWP3N6ASxb4fXsGZimJ5vdC
	 qPDQFo0xuqq1bUb+mjc0FnYR/GEta0B0vcYpeAiVOl5jEGNdWxwrhHOudDj5z1dt/b
	 SPyvJYWAKAg6A==
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
Subject: [PATCH AUTOSEL 6.1 8/9] binfmt_elf: Leave a gap between .bss and brk
Date: Sun, 26 May 2024 05:43:09 -0400
Message-ID: <20240526094312.3413460-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240526094312.3413460-1-sashal@kernel.org>
References: <20240526094312.3413460-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.91
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
index e6c9c0e084486..ad01ba70a7baf 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1312,6 +1312,9 @@ static int load_elf_binary(struct linux_binprm *bprm)
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


