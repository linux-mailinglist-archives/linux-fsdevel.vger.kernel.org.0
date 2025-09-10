Return-Path: <linux-fsdevel+bounces-60784-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C34EDB519E9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 16:45:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C80CA00A1F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 14:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D928A343D96;
	Wed, 10 Sep 2025 14:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i0iMavcc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD2632F74D;
	Wed, 10 Sep 2025 14:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757515086; cv=none; b=UvXpx9HdKO2Ihwav8a0y+E710dtit01EjqvA/iV1SIxr0UZu8VjRHaBFAI0F377Ut2Nkw5nDV6hE94G5diEmSljizEHaamaOmbZRFsMr+oihi0mwP66DpyWe7eH1CQWhuC32hgz+lGiXok+Tcg2QuvJ6tOKwHM/A1R2RLlntruI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757515086; c=relaxed/simple;
	bh=Cv4oIC9snRZNh6Az+KnfKIPi91lVOlLOl59hcQq05as=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mGukN6sr9AJYt6UxZ3S0e5g6mighiZg54MWH/XvUWGj4VUYF2gzrgH98ZAhH+wXyUYqTn8lUw1Z9mQfAu/A3DtVwMnyLvTg5Cc433spzjUBcMAM3eAXyDUYh7Z9b6qNBhnKEtk1cIUMoyHSE/KOaeCMYqyQYGfN+3jMosQ2J4WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i0iMavcc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33CEBC4CEF0;
	Wed, 10 Sep 2025 14:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757515085;
	bh=Cv4oIC9snRZNh6Az+KnfKIPi91lVOlLOl59hcQq05as=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=i0iMavccwG8XQvqcWy1HTa0bjwQkh+CJQtTpY8VFmtWstUwthNsi2dveZCIYbrAR4
	 LE1VotWlsW2FbiyyRLiIrZgbmEkyJJGP5yqvewekoYO/UjSQoUcYbZlxCxAVpwzQqJ
	 xEc8JyxWfwlxSnpuDKh2VlP11Cz4mMreS3YjCrY8McUXFpUq0YigdcTYusuZ6K46Wv
	 hDILOHd5R4IEYMW16mO1wChyyzQWLU33CQXx8w8cAVNpSvVd7w4EHlDN1SqLjgyMPX
	 JFvjpkLY813U2vusvMsDjPpTGvq4fZrG7n9lCkTcyj0G8BgS363n9qQ4cR4L4ldrY5
	 ZL/GWKfiyV25A==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 10 Sep 2025 16:36:55 +0200
Subject: [PATCH 10/32] pid: use ns_common_init()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250910-work-namespace-v1-10-4dd56e7359d8@kernel.org>
References: <20250910-work-namespace-v1-0-4dd56e7359d8@kernel.org>
In-Reply-To: <20250910-work-namespace-v1-0-4dd56e7359d8@kernel.org>
To: Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, 
 linux-fsdevel@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>, 
 Mike Yuan <me@yhndnzj.com>, 
 =?utf-8?q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
 Lennart Poettering <mzxreary@0pointer.de>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>, 
 Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
 netdev@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.14.3-dev-385fa
X-Developer-Signature: v=1; a=openpgp-sha256; l=946; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Cv4oIC9snRZNh6Az+KnfKIPi91lVOlLOl59hcQq05as=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQc7OXo2fh2k1TApy2HxNMdGbYsvRl3sdiUa2I4U09o1
 E2ugOnXO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbS08jwv+R/a/D/A7nu8zq+
 5rKceTN9Fk/2/Mlly6Ulv7UE6yWpH2Rk+PXg+ewv0Q2Tln90XWMs9yt29tz9LdKNNyYcYbf95hP
 xhAkA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Don't cargo-cult the same thing over and over.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 kernel/pid_namespace.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
index 7098ed44e717..20ce4052d1c5 100644
--- a/kernel/pid_namespace.c
+++ b/kernel/pid_namespace.c
@@ -102,17 +102,15 @@ static struct pid_namespace *create_pid_namespace(struct user_namespace *user_ns
 	if (ns->pid_cachep == NULL)
 		goto out_free_idr;
 
-	err = ns_alloc_inum(&ns->ns);
+	err = ns_common_init(&ns->ns, &pidns_operations, true);
 	if (err)
 		goto out_free_idr;
-	ns->ns.ops = &pidns_operations;
 
 	ns->pid_max = PID_MAX_LIMIT;
 	err = register_pidns_sysctls(ns);
 	if (err)
 		goto out_free_inum;
 
-	refcount_set(&ns->ns.count, 1);
 	ns->level = level;
 	ns->parent = get_pid_ns(parent_pid_ns);
 	ns->user_ns = get_user_ns(user_ns);

-- 
2.47.3


