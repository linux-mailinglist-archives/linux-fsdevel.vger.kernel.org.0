Return-Path: <linux-fsdevel+bounces-67707-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EA63C4773C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 16:15:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC1673A57FF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 15:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76674322DC0;
	Mon, 10 Nov 2025 15:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TpcCT2Yi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64DA3168F2;
	Mon, 10 Nov 2025 15:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762787368; cv=none; b=UjrDdtStHd/UB85I3xPRIHUJiaItgZwAo6g2G5HVAIXFFS8W7JVez2mrXk0tvH++Aq2BTuSlkGgFbTaCOEfPs4TfYJ7mZM/pm49Qirkt+vcsbCXgSCdHlbiazcTTC8VWy5QO6I5mGXrwZwZrAOA2s4kutN9MBoCGcWdVJy3BD+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762787368; c=relaxed/simple;
	bh=dXatTYZDmV0TMCByisPTdrsaz2iaa4IkJiwNTy6MUNo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y8SXw7ZBmGyGk7FA/neLDHMvWtJRsXzCs5jx2Qo8T3gN2DgsWILkzTmLeDyZxoTQdGs7yxQUC7Hn56aOfS21xtd0pNXeETvFXrexUetlvQGECKRuOkEvjt4OF2KIbKv2vo//cBD3k2VV5rgERX+gUHpH0VduhFY5RTn6S8kpw3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TpcCT2Yi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2EB0C4CEF5;
	Mon, 10 Nov 2025 15:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762787368;
	bh=dXatTYZDmV0TMCByisPTdrsaz2iaa4IkJiwNTy6MUNo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=TpcCT2YiktlcyFFTj+b7QR/lPIjlSBI4Bcx5d/vZ+BCboKJ/p+6mJCvgzR8K5b0aF
	 /zwHFfzFrrJDC5xmIvCIetFmvu2P/kiui34UeMgtyrI/43giAhVeK0KK6kscY36sE0
	 FFGBJUmcli/vtsxKw3J1pZ1hYdlvcGoJlY89rUeBg/18E4NLU/K9mcVuXSA3uW59VT
	 FyDOO3f+ajRul+n8MdYHf769WqVOkRrCi0Z4e8KGxr8gsEFQBeQBUMdyiuppkIsinZ
	 AxshB83gEbrKAtCQMZGHWYARd4/6mG4sod5RyrL0z8sBHEts2510gyiSpAKbrjlSzq
	 MCWNKl7/ba5Tw==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 10 Nov 2025 16:08:21 +0100
Subject: [PATCH 09/17] ns: rename is_initial_namespace()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251110-work-namespace-nstree-fixes-v1-9-e8a9264e0fb9@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1468; i=brauner@kernel.org;
 h=from:subject:message-id; bh=dXatTYZDmV0TMCByisPTdrsaz2iaa4IkJiwNTy6MUNo=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQK/v/MnTQr2Tnn2J+XTcwXcrcWTs5SUSz5Gy7tu9jR0
 +7GZDG+jlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIks1GL4K3FxH0eP0/kkVt7L
 l4t3P7s1rST077vL745nJ15n56hJ3MDwP7qfM1mmo7SL30DbM1H9c8CU7/tmXrj9c+t5v/SPzC9
 jmQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Rename is_initial_namespace() to ns_init_inum() and make it symmetrical
with the ns id variant.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/linux/ns_common.h | 2 +-
 kernel/nscommon.c         | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/ns_common.h b/include/linux/ns_common.h
index 7e4df96b7411..b9e8f21a6984 100644
--- a/include/linux/ns_common.h
+++ b/include/linux/ns_common.h
@@ -13,7 +13,7 @@ int __ns_common_init(struct ns_common *ns, u32 ns_type, const struct proc_ns_ope
 void __ns_common_free(struct ns_common *ns);
 struct ns_common *__must_check ns_owner(struct ns_common *ns);
 
-static __always_inline bool is_initial_namespace(const struct ns_common *ns)
+static __always_inline bool is_ns_init_inum(const struct ns_common *ns)
 {
 	VFS_WARN_ON_ONCE(ns->inum == 0);
 	return unlikely(in_range(ns->inum, MNT_NS_INIT_INO,
diff --git a/kernel/nscommon.c b/kernel/nscommon.c
index 88f70baccb75..bdc3c86231d3 100644
--- a/kernel/nscommon.c
+++ b/kernel/nscommon.c
@@ -82,7 +82,7 @@ int __ns_common_init(struct ns_common *ns, u32 ns_type, const struct proc_ns_ope
 	 * active use (installed in nsproxy) and decremented when all
 	 * active uses are gone. Initial namespaces are always active.
 	 */
-	if (is_initial_namespace(ns))
+	if (is_ns_init_inum(ns))
 		atomic_set(&ns->__ns_ref_active, 1);
 	else
 		atomic_set(&ns->__ns_ref_active, 0);

-- 
2.47.3


