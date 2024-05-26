Return-Path: <linux-fsdevel+bounces-20171-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F05DB8CF34C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 May 2024 11:44:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC00B2820CB
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 May 2024 09:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD282941F;
	Sun, 26 May 2024 09:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZyiIzPDD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5BA628383;
	Sun, 26 May 2024 09:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716716531; cv=none; b=fQm5sYtf1FSgC/dlmUH2ZKhK9Qdvbgevi1d5kYEDKZibQ9a4/9wJLuVhn2gzX0DUS26kCUE5tdRtkwIET/5lH8v1RHUR/zl31qpKOon2KQTBT2uOzJaMpilxDdeMrPOFciFKcbQWBAwV2co+JXqNUXap/k1124xoehRReho0VGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716716531; c=relaxed/simple;
	bh=OQ+fq/qWEXzONvHCfi5eHyNulhHelfhdcuRZeYfz8DA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I/cUIXQG9dz+M6y2E6seBTBLUfomeVbQMYwf1HyNw2xxKtbBpDMLmaiA/Cc+WkrNYfwGLST2CHfiXcQL75MKPK8NLh9BXkUbbdcebfo1pEBKDoX467WHmj2KM700Q1ue4dtkbIkIZ7jwqx0xH9rpyeMs8jCy4attfeLfgGhHsYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZyiIzPDD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAE27C32781;
	Sun, 26 May 2024 09:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716716531;
	bh=OQ+fq/qWEXzONvHCfi5eHyNulhHelfhdcuRZeYfz8DA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZyiIzPDDsTGz8jRFgYVCd8PtAL85Ywt244irg6bdyodQlFbHKBQ84PKRpcMvJDBM5
	 VGe6eSVwYNDSeaY5q5nDwUb4GZ3B23dr9j0Saejy5GKMIn4uXHj6M/dLih2F9FLKJN
	 aAMCFCh0MsTwNWcE3pz2rLAgOUUReuLnahbU++Hs4qIPe9fcuIsdnPxKD+YeoypaQQ
	 wfKqSXu79h66zGuv0gv07Xx+s2rXmAnFg6MedPf9mzM4LuHqzmV1rsIfp7vCvcTbOe
	 j81KeM4C7y1tsZv46vZDq46jygicUY/8rkO0lLEXOSJWLfJWCpEhVAojHPdtNol++k
	 68FWqzAe1JOsw==
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
Subject: [PATCH AUTOSEL 6.9 12/15] binfmt_elf: Leave a gap between .bss and brk
Date: Sun, 26 May 2024 05:41:44 -0400
Message-ID: <20240526094152.3412316-12-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240526094152.3412316-1-sashal@kernel.org>
References: <20240526094152.3412316-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.1
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


