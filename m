Return-Path: <linux-fsdevel+bounces-20173-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 900638CF373
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 May 2024 11:47:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AB03280D24
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 May 2024 09:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6833D524A5;
	Sun, 26 May 2024 09:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dNci+3RL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E6750A7E;
	Sun, 26 May 2024 09:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716716563; cv=none; b=U52Rt+2IKeE/TjFO7QtULy6JVRDkfR15ztYl/ZTWvms6ePfI/c6q28U5UBfrkw04zim2oI2y+NoY/wpsSJABUoA3N3qR/AK9cLvSJSEY06vD6InQ4XXhieLGt7dh0tyyiGVqF+Itxiz/3agvgXZd/OdQjrAUFoPJnCyk0h/EGwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716716563; c=relaxed/simple;
	bh=OQ+fq/qWEXzONvHCfi5eHyNulhHelfhdcuRZeYfz8DA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=igGybOOFh5CEx2lZA/JyMqrg+0jDlhX0HvFcM0aQDR25FWlDhCY8GDrQseCOK0gov5jsx4SUvQy7Zt6KXPn9MR0uPkfdZKV9VKUji61QOI/6XNDOz5ZW+XF/9k2UqfP0n38HKd545UdlXQO9sn84+jKQ03uKt9gsjCdvuvThDV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dNci+3RL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C90DC2BD10;
	Sun, 26 May 2024 09:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716716563;
	bh=OQ+fq/qWEXzONvHCfi5eHyNulhHelfhdcuRZeYfz8DA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dNci+3RLyY5TnTxwNbvpQ5Tg9yrcPvkWrdCcT2pivBbxgE7/f/Pq+UCBh3Oqegu92
	 xWFuyH2PNEYDZvcYbhK4ve7XBZoZh2ZzfL41btkpqzEjh2uIlEgcpY22gKmSMBBYQx
	 NSMnvOd5ZHem4+N4vCb83o1PqzfDyZXTWIjWvIt4ivvme8ym+YFuCvQHtEACiZjB4c
	 rriwyDqTpCgV5dsbp/+VtuKuAJ51PAKC0U3zBr2ZTIW+ayeu303nvQ4TwQF1G58VS4
	 EuZbfvpHKnowmOm9rxy6etGS09BTBWFAxZnjJIV9KuwSqGsZ5im/OUBDlVje90mPbs
	 UKw4TTdZdO2cg==
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
Subject: [PATCH AUTOSEL 6.8 12/14] binfmt_elf: Leave a gap between .bss and brk
Date: Sun, 26 May 2024 05:42:17 -0400
Message-ID: <20240526094224.3412675-12-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240526094224.3412675-1-sashal@kernel.org>
References: <20240526094224.3412675-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.10
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
index 5397b552fbeb5..7862962f7a859 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1262,6 +1262,9 @@ static int load_elf_binary(struct linux_binprm *bprm)
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


