Return-Path: <linux-fsdevel+bounces-66235-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C3DC1A475
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 13:38:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C61745671D3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 12:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB193587A6;
	Wed, 29 Oct 2025 12:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SsGrgLfx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA700346763;
	Wed, 29 Oct 2025 12:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761740550; cv=none; b=SdmILZDKhbgHbTXGxS2e0yeMLAWJ6W4rl21bq41o17RaSJOcRIHXDOBOb4y/sXp4kzZwzZktL/Ra2wnxhbt+FAT4TN0IMDSNp7tK9IA/gfbeu3aHkXbUYJnlcrK/EMEcrKFo3XusAXvXarzVeZcLRr2j/QCC4W5qS2mBE9bF8VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761740550; c=relaxed/simple;
	bh=5c8S8VpHc/7sZMeT1/SbhEW34RvFd3Tre08SPwP5pEQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Em/GMCjU82yzHrjOTY+IltzcQ7D97fTwck1HlDY8AorshE261wZXardQafzmN1eCCZ1nkeoCGLFXBitqPm/L10MkEL5pa8LxnqbriMf/dZaYCn0ERhI5JRS/RdwQ+fu1sEFYDcald7t+9zOKzNqzj0mPFyPK+hY6dBSJ/AiktLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SsGrgLfx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64448C4CEF7;
	Wed, 29 Oct 2025 12:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761740550;
	bh=5c8S8VpHc/7sZMeT1/SbhEW34RvFd3Tre08SPwP5pEQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=SsGrgLfxGFAPNjBFaanr021st19GL1uSaRJGSedIXt1IXWiTA4etGmGZoTCX+Pz1C
	 mC1wGPmRIuN9J7msJJD8adiOh98Oihw8DrOVlUApyhUkk74/SBdBOHRP9TX35mAgPS
	 +Ap9t1l2DS6rU/3TtOLYo+9aZqW5e33b83klXz0Nf5zOkdnYy9NuMuv0zTXck9fw7B
	 wvUoK8vKemqjxL7BDgniWcOLh36u/vXApQvxTD3PqYR9+qrf6IZh2/KeKzR59+sONc
	 wL+LMJmAbTwtmI0hsgULpP/ORrSuTeVxhHuls8Uiv/yvBVdXEviZ2wJ26f81j1rr2e
	 PW+WZQDh4rInw==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 29 Oct 2025 13:20:35 +0100
Subject: [PATCH v4 22/72] selftests/filesystems: remove CLONE_NEWPIDNS from
 setup_userns() helper
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-work-namespace-nstree-listns-v4-22-2e6f823ebdc0@kernel.org>
References: <20251029-work-namespace-nstree-listns-v4-0-2e6f823ebdc0@kernel.org>
In-Reply-To: <20251029-work-namespace-nstree-listns-v4-0-2e6f823ebdc0@kernel.org>
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
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQysfU2RnK9il70V8/5Ht/voh+LPmx/tTdp0u8N/7fpz
 orZ9+c8e0cpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBETJIY/socDnp8J0HYImj+
 pbLstRu4o75F6QQrX9SRuBUjPsuTaz8jw7NrS0z5wjs6TZfyznecXqu4ZMH3OXtDPB3sxap3/No
 vzg4A
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


