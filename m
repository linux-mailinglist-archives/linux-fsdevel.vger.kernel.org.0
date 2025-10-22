Return-Path: <linux-fsdevel+bounces-65147-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 917C8BFD1B2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 18:19:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 45B23564796
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 16:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F30F1350298;
	Wed, 22 Oct 2025 16:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K4c6vvD3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F5E337100;
	Wed, 22 Oct 2025 16:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761149267; cv=none; b=N7pPgpRG/MHeFDBN6vC54h6Lzn7iFo00Zb1AABGOWrgwtKLcyia9xLRFUEmadzNcxDMjU5TVpstPRExt6C9affhibpnQB7EUuRsBl8FQ1as6HIv5ZnPM7JYM7XuXPdTFfoAr32sUYX5KsORpn9yAsqiRXHufpwq7cu9/kZIJkyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761149267; c=relaxed/simple;
	bh=5c8S8VpHc/7sZMeT1/SbhEW34RvFd3Tre08SPwP5pEQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R/AWvdmcye7K6GDxRllFPwS4KLroeF5MEhbJyLHUnJZlboscGdNCDJFCXiWPA5dPZ+bFuH2wAcv7oYB+uNKSaiovIMPorBAfJErpyAdULpQUWyk5L+2BmPqAfxTsE7XIHav7SGVKfw9dHs9WFvSX/920WT/C4pv1+7N1LblrcjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K4c6vvD3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D6B4C116B1;
	Wed, 22 Oct 2025 16:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761149267;
	bh=5c8S8VpHc/7sZMeT1/SbhEW34RvFd3Tre08SPwP5pEQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=K4c6vvD3rnSEEu+Jw1oM0YWh9q2imSru6TNaOD++k0VR4cEqbfqFdhNdsKSD/z5uv
	 sIo/aA9cSpR+hHC5zByS/f6h333JchazdC1dcsTCh/L/U+PCVvvFKpKSzME2UWFqbr
	 b/MGv2RES2TBICoiaO/Z9UjSPpWUDNpO7lmeFe1PkQSpreeennSF298tBWh7YHfJZc
	 o6qKBk4vN/6UocTJ+3aRjMf/Zp0FOyMOQezSyWKszW/N3B4csOsS3cu3NunOa/Z1lo
	 1ddHMHjSqDy+ykRe0yYGksdlzmRlgUWJHgaqd0qybKNUrupn5PaY6OtxA6G2HR+F4E
	 Fxvkk8Fsx6gzg==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 22 Oct 2025 18:05:57 +0200
Subject: [PATCH v2 19/63] selftests/filesystems: remove CLONE_NEWPIDNS from
 setup_userns() helper
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-work-namespace-nstree-listns-v2-19-71a588572371@kernel.org>
References: <20251022-work-namespace-nstree-listns-v2-0-71a588572371@kernel.org>
In-Reply-To: <20251022-work-namespace-nstree-listns-v2-0-71a588572371@kernel.org>
To: linux-fsdevel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
 Jeff Layton <jlayton@kernel.org>
Cc: Jann Horn <jannh@google.com>, Mike Yuan <me@yhndnzj.com>, 
 =?utf-8?q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
 Lennart Poettering <mzxreary@0pointer.de>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>, 
 Amir Goldstein <amir73il@gmail.com>, Tejun Heo <tj@kernel.org>, 
 Johannes Weiner <hannes@cmpxchg.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, bpf@vger.kernel.org, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 netdev@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-96507
X-Developer-Signature: v=1; a=openpgp-sha256; l=852; i=brauner@kernel.org;
 h=from:subject:message-id; bh=5c8S8VpHc/7sZMeT1/SbhEW34RvFd3Tre08SPwP5pEQ=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT8ZHj6ek9eNou5+ozcXuWy5a+eP93QuyU7N+60cQdL4
 NQnJ147d5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzEQZuRYeNnjyTNkMLk5Qd1
 Y1aubDc9PMHlUdvPW6q7bYo8VqqE1TAynGoP9WTUm7db5YfcdZVvG3e9ZVXnKyoO0+1+dWSdwPm
 DPAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

This is effectively unused and doesn't really server any purpose after
having reviewed all of the tests that rely on it.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 tools/testing/selftests/filesystems/utils.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/filesystems/utils.c b/tools/testing/selftests/filesystems/utils.c
index c43a69dffd83..a0c64f415a7f 100644
--- a/tools/testing/selftests/filesystems/utils.c
+++ b/tools/testing/selftests/filesystems/utils.c
@@ -487,7 +487,7 @@ int setup_userns(void)
 	uid_t uid = getuid();
 	gid_t gid = getgid();
 
-	ret = unshare(CLONE_NEWNS|CLONE_NEWUSER|CLONE_NEWPID);
+	ret = unshare(CLONE_NEWNS|CLONE_NEWUSER);
 	if (ret) {
 		ksft_exit_fail_msg("unsharing mountns and userns: %s\n",
 				   strerror(errno));

-- 
2.47.3


