Return-Path: <linux-fsdevel+bounces-67706-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 80CC3C478AF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 16:29:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 22D0D4ED9DC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 15:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5971B320CAD;
	Mon, 10 Nov 2025 15:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lUscQYvl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F2A320385;
	Mon, 10 Nov 2025 15:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762787363; cv=none; b=uKEc/vSW/nCwaH0WqEG2JXsWX6Bq3xe+Khj6BWSjh72q54KC9n1F8giL3QGAGV6HlhL/fh2qxb5ZGT9p5UE0s3lY0FXC2X2+dzzRz3b+a4IzHyTiYkMozF+r8uNKbI5FplvYGur5lwO9apQuP4uBSF+gkzTiaJwV0QESk8dXadc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762787363; c=relaxed/simple;
	bh=HPgjD3e34rRPdmUyvY+oogDusPJvi983SxNb2hcguoc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U8AzPwyyboBN12X4Iin8jgbecwx/G/V2+C3Qh0UbIZwLiLBkFl6aOtJfKzHY5D+r5IaIL7xQm8tN8usGWu3O1IBZJTR2YuUTkYZzZGW4lRsK3qFFLM5BSquwCTbhw6wfo9BY5gamxVzeovHdCHOiPjycwr77M53XnzzWg/6OVlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lUscQYvl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69C83C116B1;
	Mon, 10 Nov 2025 15:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762787363;
	bh=HPgjD3e34rRPdmUyvY+oogDusPJvi983SxNb2hcguoc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=lUscQYvlZXHEHUEuuXTkNtXlVkuTzVRSET9Nm+TB6Fms7nRoRspRnYmZqAAyXjnE5
	 o1imcyhkGUZDK++ypCz3rFgy84FubfrHNyeuUgTAAc8kb2wRegGo1ChmMIGOjAL+KR
	 JKf6QdpYzN6NnalVcnqC0bzQ0rwFPq6PY+I/8JfK+rQk8jLPP7KD70iPY/O+j9r/8C
	 Au1kM63MMfrVChciQFPUCYKnl+5HrjDS6MwLtvgQHV+L67o+JdWqdlln63S0WPHSOl
	 MDbivdL/8vV4zMiw/2v3sK608vrzQnBWbmzwGsQPzP8amhDEzbdWSgnoAJiA7e4iQ0
	 GfyLbUsZHAHpQ==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 10 Nov 2025 16:08:20 +0100
Subject: [PATCH 08/17] ns: make is_initial_namespace() argument const
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251110-work-namespace-nstree-fixes-v1-8-e8a9264e0fb9@kernel.org>
References: <20251110-work-namespace-nstree-fixes-v1-0-e8a9264e0fb9@kernel.org>
In-Reply-To: <20251110-work-namespace-nstree-fixes-v1-0-e8a9264e0fb9@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=863; i=brauner@kernel.org;
 h=from:subject:message-id; bh=HPgjD3e34rRPdmUyvY+oogDusPJvi983SxNb2hcguoc=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQK/v+sKca1r9HiXePv/wuYhFWUmu48/LQqsWCCqmPd3
 PvWnB//d5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzETIThf5rMXQnuvg0/pPh/
 mHaWbI65tffs9U/GNkx5vXVz2XiUdjAydDB55roG5F81NWc+evSP0CnlVetFU758Nt8tYnv910R
 2JgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

We don't modify the data structure at all so pass it as const.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/linux/ns_common.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/ns_common.h b/include/linux/ns_common.h
index f90509ee0900..7e4df96b7411 100644
--- a/include/linux/ns_common.h
+++ b/include/linux/ns_common.h
@@ -13,7 +13,7 @@ int __ns_common_init(struct ns_common *ns, u32 ns_type, const struct proc_ns_ope
 void __ns_common_free(struct ns_common *ns);
 struct ns_common *__must_check ns_owner(struct ns_common *ns);
 
-static __always_inline bool is_initial_namespace(struct ns_common *ns)
+static __always_inline bool is_initial_namespace(const struct ns_common *ns)
 {
 	VFS_WARN_ON_ONCE(ns->inum == 0);
 	return unlikely(in_range(ns->inum, MNT_NS_INIT_INO,

-- 
2.47.3


