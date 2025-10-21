Return-Path: <linux-fsdevel+bounces-64869-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C88C9BF62D1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 13:51:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D35819A2268
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 11:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A4AC33F8D6;
	Tue, 21 Oct 2025 11:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kCr65ean"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5250832ED49;
	Tue, 21 Oct 2025 11:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761047126; cv=none; b=KDxsDeVuLgoGsmf2E2fkEaMOTjDGNorm7kIubfGZPn0CUBp14Kpc86THy9z3aaXP2oBgs8xlJkGTb7pLpg2ycFYT+l7e87UPp8QvFcDSZL8saZzteClcF8wf8vDFPVir94UM2HxujrGHxc9598kJGmnamUOgMIJlcuaCmixFAK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761047126; c=relaxed/simple;
	bh=5c8S8VpHc/7sZMeT1/SbhEW34RvFd3Tre08SPwP5pEQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Yy8ZLJ4TujYZIs+lTbkx3KXHTdsDp3FaI2sftWdgwfhogl9rzZIHGA+aADq/YK4YvDwtXkZME1sPoS3idDmtIwRsOTUS9awAZeTbbnwfwutIZs6rfeI34/TUaFUkQU8bgYvZsMz6jnlW6nvI3GtumXFhTnxGITVxo1qS9uDNsXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kCr65ean; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CFA8C4CEF1;
	Tue, 21 Oct 2025 11:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761047126;
	bh=5c8S8VpHc/7sZMeT1/SbhEW34RvFd3Tre08SPwP5pEQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kCr65eanvMnYJZba2Kgc4XWQmNq4LGa8p0PTDJ7XNwDA3M4G3rlJiPdrX02Bl3nHb
	 bZU1poX6N8vtTsAp+WNmwd2Q4YvLmo7eWBJJKc4QAv4byevGaxDEdyW/VYjfn+J83y
	 wxLAqKQJ5hG9tB7gEQhS692ij8yVUolecm4yA2w/XLjpiDBqn7opi6fvDwmeVmzbG2
	 xoxeT0w7lXI/EU3xnIMKHLDd/FL3Ho6qq/hyjf+zKP+gA/jcEFG16NdvBB/PErHIj3
	 EcLy2VtNRVemM2+R/xRGoWsMhljHCQykdswfH+0rfKua7O70L8cB2DeuBchE4e+bIW
	 MWRbPVkReHfqw==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 21 Oct 2025 13:43:24 +0200
Subject: [PATCH RFC DRAFT 18/50] selftests/filesystems: remove
 CLONE_NEWPIDNS from setup_userns() helper
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-work-namespace-nstree-listns-v1-18-ad44261a8a5b@kernel.org>
References: <20251021-work-namespace-nstree-listns-v1-0-ad44261a8a5b@kernel.org>
In-Reply-To: <20251021-work-namespace-nstree-listns-v1-0-ad44261a8a5b@kernel.org>
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
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWR8L3w7v1koKPPS3VnmJlGnFoqlGj8pnMJrc+B2ZNxDi
 xtsUqJJHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABO55MvwvzQ6987ivYJrTCR3
 Sbk9kPrSvfX4khNXvViCclySUqeI6DEynJr/JEWpf6ODTHyTx65AhXPh3FLnTyYvv1fWX8ZvvOw
 UCwA=
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


