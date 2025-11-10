Return-Path: <linux-fsdevel+bounces-67703-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4111BC47721
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 16:13:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8003A4EDE10
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 15:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D32F31BC85;
	Mon, 10 Nov 2025 15:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nt5xXpSw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC6B31618B;
	Mon, 10 Nov 2025 15:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762787353; cv=none; b=N0GqyIebaKdebfa4sOC5FrWl+XsqK5Se8q609pkux8Oqa7oXrxm5Ilni7FlLBIBrPR4qB7r7GPR4uTuNmf9y+7IYot816k0S6HjHo/Vprij4y7hcD0BbzRBIn6o0pvSA1JH4PCDyYz0Va9psZjZSIkuub8KjaG/6c2oNXjp6SRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762787353; c=relaxed/simple;
	bh=fPUpkXDuA98ty6VzfVdiYfN4xnYHVGY0UZr7ntB2HBk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P6zbfeS0VM6GugLoJNh4WC2bF7LPcfzgbATKzbOSB/GLpVZzJKDSxzgPZSt/IBpX3/uAOUjqoLDJo3y44zAzFF3HPhesrNEh/y9zY8ff8086Qf+wNRcwFChsTgxLbbSfiWFoY7ePSFGST+BkaOCIJdlEtts28PUvE8TvM8Ez/es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nt5xXpSw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18D01C19425;
	Mon, 10 Nov 2025 15:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762787352;
	bh=fPUpkXDuA98ty6VzfVdiYfN4xnYHVGY0UZr7ntB2HBk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Nt5xXpSwnPmdp8CdrFwsaa/bpTjBt4Kittbd20RUFjnjoNZdLG6mLcsVBqyHe6kG0
	 uUbSyZZBYCn9fsaOnG6QdM4YpN0tChV6Wi/jDstUTRiQxbz029vXDg6XWDYPVFrYU8
	 SJ35/iu9zuF+TWxjyjbAZi+WGME4lZ98nAi6fFvJvBadbysUhowdGPIiZtTrJHF85j
	 3CBTqERsWd0huR1jqXEmr0aszoIy15RxMUmiEirBohmF0SyM5/M5RzdbCqUHo2eMlz
	 lvXQbVJZvkr7yKCjkvTj07oRNVKzOhpxRveRDbv4On9/nMByC/Jl4TZLcEmmXWR9/L
	 JfPoHoP60+IbQ==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 10 Nov 2025 16:08:18 +0100
Subject: [PATCH 06/17] nstree: simplify owner list iteration
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251110-work-namespace-nstree-fixes-v1-6-e8a9264e0fb9@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1053; i=brauner@kernel.org;
 h=from:subject:message-id; bh=fPUpkXDuA98ty6VzfVdiYfN4xnYHVGY0UZr7ntB2HBk=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQK/v+stPjgCjYJviRd6eyyX/Ha5+crbNX/MCtUnF95i
 oK5SsvqjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIls72FkWMH5doU2e94TyYlb
 Vq37eVr3XjfzL5G1Znfai5p6PvgaHGb4Z/OP1eNA3aqfjw13hv7o/s5wpfNonEDe7d9vuq62n/6
 /lgUA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Make use of list_for_each_entry_from_rcu().

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 kernel/nstree.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/kernel/nstree.c b/kernel/nstree.c
index 6c7ec9fbf25f..476dd738d653 100644
--- a/kernel/nstree.c
+++ b/kernel/nstree.c
@@ -598,11 +598,15 @@ static ssize_t do_listns_userns(struct klistns *kls)
 	rcu_read_lock();
 
 	if (!first_ns)
-		first_ns = list_entry_rcu(head->next, typeof(*ns), ns_owner_node.ns_list_entry);
-	for (ns = first_ns; &ns->ns_owner_node.ns_list_entry != head && nr_ns_ids;
-	     ns = list_entry_rcu(ns->ns_owner_node.ns_list_entry.next, typeof(*ns), ns_owner_node.ns_list_entry)) {
+		first_ns = list_entry_rcu(head->next, typeof(*first_ns), ns_owner_node.ns_list_entry);
+
+	ns = first_ns;
+	list_for_each_entry_from_rcu(ns, head, ns_owner_node.ns_list_entry) {
 		struct ns_common *valid;
 
+		if (!nr_ns_ids)
+			break;
+
 		valid = legitimize_ns(kls, ns);
 		if (!valid)
 			continue;

-- 
2.47.3


