Return-Path: <linux-fsdevel+bounces-64861-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C51BF62B0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 13:51:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A917B48486F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 11:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58B72338904;
	Tue, 21 Oct 2025 11:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z5WLHdd+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934F9331A41;
	Tue, 21 Oct 2025 11:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761047082; cv=none; b=iBOxH5FsNdbGKm+7jvvbuq0dRsKn6kEuBaHqwM6PuVYH/XxE54k+2AnH89qgKQq2KP+RMB4lQ2kyFrIjIPIItjy7Q65vRyJMrSGd3YAABjq92DmSPm0jeWBI8Kit2zR61yD7GNeQSYQtCOQ811xQFjYprLlUaTo38tO3QRNEoaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761047082; c=relaxed/simple;
	bh=eNIUpqO2UCHoi2ksC8FU54CizOc19jWeKxEd6r2H28o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pSoUV1UbLK8N5kSLZKWbBp0pEI8S7ILXYp8Iw7cn9b7svGIli5M0xsiSoJqd7Y6/nxjcP4dnL5Z5b1Ai7eMpJwhVDOVwEnXT2+RfrtDewsxovHPv36adoQJloAqREW9ZXc/Llc0oZzrww2RJ5L4yyIL85WJB8YddjF1TKEF0G94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z5WLHdd+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12456C4CEF1;
	Tue, 21 Oct 2025 11:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761047082;
	bh=eNIUpqO2UCHoi2ksC8FU54CizOc19jWeKxEd6r2H28o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Z5WLHdd+EBfxO8Wsx4dELH3U3MnpmfFj+1e0RdpBk+8Z9N1PMClqYZ8vg+Nn7il/7
	 nC0KRI3vJ4uyCYS22JXA6Tkhde+X5OJ3itknXaLTlxcDKKmbGoeIjqRiN033iwQefP
	 mzpT9u1mkUlxhNl6ATQ8GvJNqEUQyDUBIP2h95vCM5VSy7jdCQy28akWj9fqadHinT
	 MUFN7ZNiAuCR0xlkCJQyMIzOOnz01n4gegwqDCNmN2xM2WOTPLnsXUtaLgaIxDGGfe
	 k/8GvYG9s/akqsUHebsAsbjux5Ji5DI/ATAFYc7anDtJ/QKUd0+t2jKfwsEkSJkB+T
	 S9Sk43Qk9ujMg==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 21 Oct 2025 13:43:16 +0200
Subject: [PATCH RFC DRAFT 10/50] ns: use anonymous struct to group list
 member
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-work-namespace-nstree-listns-v1-10-ad44261a8a5b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=775; i=brauner@kernel.org;
 h=from:subject:message-id; bh=eNIUpqO2UCHoi2ksC8FU54CizOc19jWeKxEd6r2H28o=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWR8L3yzXZVR83TgjbuKGScXzf67xtDm2M9pt1Qbk82Pz
 f13dQPLgo5SFgYxLgZZMUUWh3aTcLnlPBWbjTI1YOawMoEMYeDiFICJnN3PyDBRL+T2DJ9VwnHH
 UryZBDaca1vWbmbxr+5PV1ZDbHbgrwxGhlN8Tlmv5+/4qaVpN+tt8tmKpH83H+3WL2g9YBnSvvz
 kZj4A
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Make it easier to spot that they belong together conceptually.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/linux/ns_common.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/linux/ns_common.h b/include/linux/ns_common.h
index 5d19471235ab..34e072986955 100644
--- a/include/linux/ns_common.h
+++ b/include/linux/ns_common.h
@@ -115,8 +115,10 @@ struct ns_common {
 	union {
 		struct {
 			u64 ns_id;
-			struct rb_node ns_tree_node;
-			struct list_head ns_list_node;
+			struct /* per type rbtree and list */ {
+				struct rb_node ns_tree_node;
+				struct list_head ns_list_node;
+			};
 			atomic_t __ns_ref_active; /* do not use directly */
 		};
 		struct rcu_head ns_rcu;

-- 
2.47.3


