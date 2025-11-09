Return-Path: <linux-fsdevel+bounces-67609-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E36C4472C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 09 Nov 2025 22:14:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D3923B08E5
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Nov 2025 21:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FF9026F2BE;
	Sun,  9 Nov 2025 21:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kPnWD0id"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7293B537E9;
	Sun,  9 Nov 2025 21:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762722803; cv=none; b=NuCuMUsS56yd56/gNwqykrYKgUGaXBgcMdum0nroFZQHaII4N5KZh2ikSJtPAwJTOeXDTsHpsA8KMduyHs+JkElajvEagjDTxCMKsfcYQX8bXWUJ3Tqjvy9npzLcxOE/crmG6za0FsIclChwPVXmkNQrvV67QUtgA/1tmxj+GLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762722803; c=relaxed/simple;
	bh=e8o+HFjAfwAZDJFrtqSN9t1c4O21+LqtO4Xq3Z91+Rc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DQignIF2RP+h8nAox9TY2yBH/BjRQTq3uvJ7HJLsdGymuINRUkhwd88vdm8CrrK713gvFn/aVCIeEBmAMhT3Da8AEJF6+N2l0avWNKfi0rdCd9KZRFFke8zf/KSeZ6Y6QquaZQ/LpTBedNDfnsEGkhPdgcw0I5ozpzY4+Rg1mZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kPnWD0id; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7210CC19423;
	Sun,  9 Nov 2025 21:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762722803;
	bh=e8o+HFjAfwAZDJFrtqSN9t1c4O21+LqtO4Xq3Z91+Rc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kPnWD0idXLT923SzBCwSSPqIuJZot0Gh/CaFdnJHfa4h1skMH2hsLNpza/0y+rIPz
	 Ma9LOG2TG/lbG717bwJAMh15bwR6Z2dZb5PsAW+IBoC7oYropAwoaM2o7e3MnMqxyi
	 BzQ7+4fOPCn+RMPsuqk3mrbVput4H4knzFzy5RlqnA9Q+t3bQWRGRE9leu6fnPDlPg
	 IedBF7UySDRdDJCZgUsL4GQfQVp6B3sXJM2N37qYrwuDsyI1IVE2p0lQRE/C648zYm
	 n4PeOjF37LF3ehTd97d25coG83YBjKzgOb40MMQQ+UtrRUP6XkTzahxA53vXbZoNXC
	 clAth6UtPy/NQ==
From: Christian Brauner <brauner@kernel.org>
Date: Sun, 09 Nov 2025 22:11:22 +0100
Subject: [PATCH 1/8] ns: don't skip active reference count initialization
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251109-namespace-6-19-fixes-v1-1-ae8a4ad5a3b3@kernel.org>
References: <20251109-namespace-6-19-fixes-v1-0-ae8a4ad5a3b3@kernel.org>
In-Reply-To: <20251109-namespace-6-19-fixes-v1-0-ae8a4ad5a3b3@kernel.org>
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
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1127; i=brauner@kernel.org;
 h=from:subject:message-id; bh=e8o+HFjAfwAZDJFrtqSN9t1c4O21+LqtO4Xq3Z91+Rc=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQKMr8Q+245RWauFlvbwZiLqla79Jbe1Vmbblz7Qtyzx
 M76Q59VRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwEQm1DL8s7bevlLM/1RjctH3
 6eXugrst2/WXLf3x52o5U2j/756L3IwMn1eJLJ1dFV3ZapA1Penh1Ld7PCdHzfSTuJtftz2558I
 fDgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Don't skip active reference count initialization for initial namespaces.
Doing this will break network namespace active reference counting.

Fixes: 3a18f809184b ("ns: add active reference count")
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 kernel/nscommon.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/kernel/nscommon.c b/kernel/nscommon.c
index 6fe1c747fa46..d67ae7ad7759 100644
--- a/kernel/nscommon.c
+++ b/kernel/nscommon.c
@@ -54,7 +54,7 @@ static void ns_debug(struct ns_common *ns, const struct proc_ns_operations *ops)
 
 int __ns_common_init(struct ns_common *ns, u32 ns_type, const struct proc_ns_operations *ops, int inum)
 {
-	int ret;
+	int ret = 0;
 
 	refcount_set(&ns->__ns_ref, 1);
 	ns->stashed = NULL;
@@ -74,11 +74,10 @@ int __ns_common_init(struct ns_common *ns, u32 ns_type, const struct proc_ns_ope
 	ns_debug(ns, ops);
 #endif
 
-	if (inum) {
+	if (inum)
 		ns->inum = inum;
-		return 0;
-	}
-	ret = proc_alloc_inum(&ns->inum);
+	else
+		ret = proc_alloc_inum(&ns->inum);
 	if (ret)
 		return ret;
 	/*

-- 
2.47.3


