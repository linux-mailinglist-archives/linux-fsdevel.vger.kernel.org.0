Return-Path: <linux-fsdevel+bounces-66230-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68E66C1A3D2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 13:32:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D3D81AA7833
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 12:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F600355804;
	Wed, 29 Oct 2025 12:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EltZ3oTK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C673451DB;
	Wed, 29 Oct 2025 12:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761740524; cv=none; b=NkN0hd9vOtC83VBFoOVrQ9a6bAsw+pJcqgILn0xY4CVLc6O1755GrXTulXP0sD/2Dxy/cS7cQzeHkDAEHrDn+400iW93tvGAFrVVjEUQx1pvtbqJzPbBmqmb2Fhe/7DJuK6QiryM7q1hgcAf8NXzbkAGHnctHHzNgtHzp7jL4uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761740524; c=relaxed/simple;
	bh=96Z7otohCUrNqJl7r8gnx6tjRso9CQWk7dyZx4Mnc2A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qWNvuYmKkoKZDgV9h90mA4bG1vgY/yCtc8ctl7a13Irwt+KKz7NABaY2jfeAH4COYUCIOYxHfLTarmUpKlHV5tYsxPKZ0gGKMlmE7sOMWZNG4SZG50qykjg7GVACxxPHmmG+7IGX7QnOfjZDxuHWuhdZTT2Kb4UPHy7dw1EQFn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EltZ3oTK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E3D6C4CEFF;
	Wed, 29 Oct 2025 12:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761740524;
	bh=96Z7otohCUrNqJl7r8gnx6tjRso9CQWk7dyZx4Mnc2A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=EltZ3oTK5dsrsqmcFJPqkhX1RynQ+/6+WTQ0gXHlhphXrTTXs93fEADcDz6YqrCqM
	 usFHPwT5t/S2ADdtbErgv9rjEJy3tRPNK9q4MdoKnJQnSVQcl0tkkVPG++vHQ40J95
	 7OgCS/ghc3Erbfv2BXn9tEKHxIsjlq2huAVTlZ21hd2AG5Rm7BSwjTKdTcCs/GjusB
	 FrFmKwaNTbIUC8Qb70zl27LYGlShOSVSDSZmyvZQ5h/ADXAbGVQpgquWRrls4FgQgX
	 2MGb56stXnTaIOcw5X65/xEO/+kGL8VsE/RGa9KfFO9PI5/XRMTA1yGQR/kBLXrBVE
	 Fqh8+Rx0tpBCw==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 29 Oct 2025 13:20:30 +0100
Subject: [PATCH v4 17/72] nstree: simplify rbtree comparison helpers
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-work-namespace-nstree-listns-v4-17-2e6f823ebdc0@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2145; i=brauner@kernel.org;
 h=from:subject:message-id; bh=96Z7otohCUrNqJl7r8gnx6tjRso9CQWk7dyZx4Mnc2A=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQysfXs8fWZc5Dp3r2uQ+mxTun+3W/bnsQmuRVynsoLe
 /aG4cOijlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIksi2T4p8Om/X/FuSYdxk0n
 +b/LhzefO7NtmU3Dlb9XcnpzT+1zzWL477MlOGV+U97cWrP3D1J2Lr/Qve7lu/m2L4K27yxl/O1
 3iQkA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

They all do the same basic thing.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 kernel/nstree.c | 40 +++++++++++-----------------------------
 1 file changed, 11 insertions(+), 29 deletions(-)

diff --git a/kernel/nstree.c b/kernel/nstree.c
index 59ec7d6ba302..1779fa314a7d 100644
--- a/kernel/nstree.c
+++ b/kernel/nstree.c
@@ -109,46 +109,28 @@ static inline struct ns_common *node_to_ns_owner(const struct rb_node *node)
 	return rb_entry(node, struct ns_common, ns_owner_tree_node);
 }
 
-static inline int ns_cmp(struct rb_node *a, const struct rb_node *b)
+static int ns_id_cmp(u64 id_a, u64 id_b)
 {
-	struct ns_common *ns_a = node_to_ns(a);
-	struct ns_common *ns_b = node_to_ns(b);
-	u64 ns_id_a = ns_a->ns_id;
-	u64 ns_id_b = ns_b->ns_id;
-
-	if (ns_id_a < ns_id_b)
+	if (id_a < id_b)
 		return -1;
-	if (ns_id_a > ns_id_b)
+	if (id_a > id_b)
 		return 1;
 	return 0;
 }
 
-static inline int ns_cmp_unified(struct rb_node *a, const struct rb_node *b)
+static int ns_cmp(struct rb_node *a, const struct rb_node *b)
 {
-	struct ns_common *ns_a = node_to_ns_unified(a);
-	struct ns_common *ns_b = node_to_ns_unified(b);
-	u64 ns_id_a = ns_a->ns_id;
-	u64 ns_id_b = ns_b->ns_id;
-
-	if (ns_id_a < ns_id_b)
-		return -1;
-	if (ns_id_a > ns_id_b)
-		return 1;
-	return 0;
+	return ns_id_cmp(node_to_ns(a)->ns_id, node_to_ns(b)->ns_id);
 }
 
-static inline int ns_cmp_owner(struct rb_node *a, const struct rb_node *b)
+static int ns_cmp_unified(struct rb_node *a, const struct rb_node *b)
 {
-	struct ns_common *ns_a = node_to_ns_owner(a);
-	struct ns_common *ns_b = node_to_ns_owner(b);
-	u64 ns_id_a = ns_a->ns_id;
-	u64 ns_id_b = ns_b->ns_id;
+	return ns_id_cmp(node_to_ns_unified(a)->ns_id, node_to_ns_unified(b)->ns_id);
+}
 
-	if (ns_id_a < ns_id_b)
-		return -1;
-	if (ns_id_a > ns_id_b)
-		return 1;
-	return 0;
+static int ns_cmp_owner(struct rb_node *a, const struct rb_node *b)
+{
+	return ns_id_cmp(node_to_ns_owner(a)->ns_id, node_to_ns_owner(b)->ns_id);
 }
 
 void __ns_tree_add_raw(struct ns_common *ns, struct ns_tree *ns_tree)

-- 
2.47.3


