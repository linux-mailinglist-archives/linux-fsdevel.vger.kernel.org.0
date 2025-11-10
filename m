Return-Path: <linux-fsdevel+bounces-67709-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 178CEC47776
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 16:17:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A60D3AA0C2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 15:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0660326D55;
	Mon, 10 Nov 2025 15:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F3EaVUIS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C04314B85;
	Mon, 10 Nov 2025 15:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762787379; cv=none; b=Y90dPEgImx6hWHrEv36DWEqULgBK3jo0Nw9O7ZjxVo5klioCBXPPgVtO+d9EuDTk4Fb53nK8QVulnCtwLlNHEPszqDpT18xQtBHHs3SCwmylvcXMrOtFUl4eKWQUp9nlpFZwuWNE3p5pMQ2aju4bgWXH9iwZS+GIn3dU4lZkiPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762787379; c=relaxed/simple;
	bh=rprGNgrU60nSbXWpc0c3qL3kYmqB0q5qdX5WSiHZsww=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oESgwb2DdIJQn0u2kcUrlIoQsbcUoRDz6q8CB4eHLLHnG8A0zrFoxfvnoMSgf75Z5C9zzX8+z4aiSdzi6uwNxmpcQkc+o3Y1aHIb4qvr6+MWh5UMwxZpFgVC0zJJTR8D7ygn3UVZBUMD4M3BwGglOPYnvpfrcAbJWpq3j9WUZqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F3EaVUIS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14A68C113D0;
	Mon, 10 Nov 2025 15:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762787378;
	bh=rprGNgrU60nSbXWpc0c3qL3kYmqB0q5qdX5WSiHZsww=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=F3EaVUISGBNG4M2t2hHpAdbA/y2LKioAB7v3zGd910k9TZ4bG8bTxfK0kzH2diqzL
	 JikUS/eut+u5a/EpcVolhfggykq3Gda8uhB8A29AljxIh0O6sgV0xmJ7ppwOpXcCee
	 j46KnZcaLCauRMM/tV0yjvlAB/4FALFb6w0VIh/CY3H31FW6eluiBtiL7dXtY0PavG
	 DyVC2vTmebVsOu2v2QYsnQ3VnlpbpJQy7Zl9j7IzWg11Bc4KxDoJOhIX88qS1ZpNk2
	 ZBGYX3fv/9QcNQ9GCpm6YPtMl4FJYU6z+sQM78JIhMiFO/4h9iJWD0kGjpwMjF+L5l
	 oryxZziOI47vQ==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 10 Nov 2025 16:08:23 +0100
Subject: [PATCH 11/17] ipc: enable is_ns_init_id() assertions
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251110-work-namespace-nstree-fixes-v1-11-e8a9264e0fb9@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=872; i=brauner@kernel.org;
 h=from:subject:message-id; bh=rprGNgrU60nSbXWpc0c3qL3kYmqB0q5qdX5WSiHZsww=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQK/v+8ptm+o/twSTr/nexOo+91fZ3XSp5nnhPn6hG9k
 3a4P2dzRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwET6Cxj+yn6vjZavMnx4w/2y
 +p/XTfbPtR7cfrjqbifr9/iZyYZxYgz/fVbfb6yJet70+tdsvVXbV/lsOC1gPMVM5cj+e/U1L94
 vZAYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

The ipc namespace may call put_ipc_ns() and get_ipc_ns() before it is
added to the namespace tree. Assign the id early like we do for a some
other namespaces.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 ipc/namespace.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/ipc/namespace.c b/ipc/namespace.c
index 59b12fcb40bd..c0dbfdd9015f 100644
--- a/ipc/namespace.c
+++ b/ipc/namespace.c
@@ -66,6 +66,7 @@ static struct ipc_namespace *create_ipc_ns(struct user_namespace *user_ns,
 	if (err)
 		goto fail_free;
 
+	ns_tree_gen_id(ns);
 	ns->user_ns = get_user_ns(user_ns);
 	ns->ucounts = ucounts;
 
@@ -86,7 +87,7 @@ static struct ipc_namespace *create_ipc_ns(struct user_namespace *user_ns,
 
 	sem_init_ns(ns);
 	shm_init_ns(ns);
-	ns_tree_add(ns);
+	ns_tree_add_raw(ns);
 
 	return ns;
 

-- 
2.47.3


