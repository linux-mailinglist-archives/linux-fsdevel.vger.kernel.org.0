Return-Path: <linux-fsdevel+bounces-20177-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B010B8CF3BF
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 May 2024 11:54:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B85A280F69
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 May 2024 09:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E4E2130E29;
	Sun, 26 May 2024 09:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XwQd1XHc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7762130AEB;
	Sun, 26 May 2024 09:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716716620; cv=none; b=dv74DE4yUjyJvdlGsgBYyGD6KQB/Feps34rsNKLjL1pSxBa9Mo8tEVKC4aPV3pJ+rzw2pLPmWTmQewFYiFBMPMWgnwU53sPKIwtPPVL0JGMTVbtetJhqKcDFVtuljn/QFsR+XCuFQN9DD0vTnA7m77LN3s85AJ8TYbmejKs2mqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716716620; c=relaxed/simple;
	bh=8M2a9IXtQtKWm46K1pN791UcrKjl7qfSLlHLkSIFFNA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r9IdpKADXr7gA1tQ3tdTV2Khbxc7bx8+O7yOOiqHuBOHd7im7ZviL0QtdJde2DlDy6Nic18oYDS46/yEIi7g36UJRKdbvreSO4DWBn2FcFsCAe/oFB47sWtFtpIBnC/HiJswMbt4cxqvbdq18vhyDLZT/DXT9MK7VkGVZaacoK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XwQd1XHc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD3FBC32781;
	Sun, 26 May 2024 09:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716716619;
	bh=8M2a9IXtQtKWm46K1pN791UcrKjl7qfSLlHLkSIFFNA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XwQd1XHcK6DNpyzl4hOKUgDvzSmpj3vQH/2UXK5bXNppI5AqEUXDOPmaqY9iOUZBP
	 gN9zxaCvd8R7+1P3hRGFD2Ycu/Q6O3eVYbIIUY3OhL2F0wZ9grF8JYdzN3Jqytux20
	 gZucp4c8vIBMVAyLbutnyANN9nQWDfTTO1xrP06drvFoefPNzBsvsk/JH7DlVAOskA
	 uaS32FMOl911dleMVZ8JguLmz8K2YLJRUC0Kah/x39XYKqXofugMomvM/Qp++glYZa
	 hcUf/rqZaYaZUbaMDn2o82TgKdk6lM2KF/Lietb6hAj658DuTilz6hYkqir9PA4CuX
	 uDdheaOaxoGXA==
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
Subject: [PATCH AUTOSEL 5.15 6/7] binfmt_elf: Leave a gap between .bss and brk
Date: Sun, 26 May 2024 05:43:26 -0400
Message-ID: <20240526094329.3413652-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240526094329.3413652-1-sashal@kernel.org>
References: <20240526094329.3413652-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.159
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
index 30379c33ad20c..932141c93f3e3 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1289,6 +1289,9 @@ static int load_elf_binary(struct linux_binprm *bprm)
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


