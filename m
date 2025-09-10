Return-Path: <linux-fsdevel+bounces-60783-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9426FB519E1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 16:44:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8F04160A13
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 14:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED85B2652A2;
	Wed, 10 Sep 2025 14:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PvxGHMeV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330B531A540;
	Wed, 10 Sep 2025 14:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757515080; cv=none; b=lBqW1kB0oc8yUvvz1BzreBmY1HACXZx7YdeW9YWGnlq+sEv7/n741VAxT342+P5zpzLIZ8JSZl6SSWs8c3npnKQIlKflrn+p3nFIrtGRCoa3IiVThxCt/ePFtDMWs84Cv1m830Zba5KBMFMDtTrovrwtwZ2TGETay/IGLSKmkbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757515080; c=relaxed/simple;
	bh=oLTEkd9LPucYI91jao02VqhHmofn8nqyUbSyayMXIto=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GlACwxpiGfd/Wm6j6j9Cc4/OXtvhg/VwvmqDyNPc7xhOxaJOtD2wxuDOZchLLtxYFnYXgJdGypiWaLu0Ljv17N8G3YTogf6i0d2vpuuQVU1MOZzxdVQEgq2mlVojziRJUIee2tQbBCUd0liJlAeZNvqmpEQHTsqH8vfvNTshoYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PvxGHMeV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36BB9C4CEEB;
	Wed, 10 Sep 2025 14:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757515079;
	bh=oLTEkd9LPucYI91jao02VqhHmofn8nqyUbSyayMXIto=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PvxGHMeVvUXzDP5m3PMB+FTPaMiNaGPf2S+VA/toc1PtQKYPmDUVHuCIj3x4OZat4
	 +3ydbMzYZUAYSJPYvJJp384A2rK9bOyc46Pz5nQojmPaoLnsuG3pfJVmxONaVXAMTW
	 DtiySdUWlkzrfwsGyDYrePnHNpM2ue4+pQ7FCBfzsbljMWFKjQgDYcS9kIHAmOtVZ0
	 nTr5uy1ft82iyVqIb8ptNteMZ0BYaqPYo0jyPUjwOvyUbuY3kpgDZYPWxWQ9HKtUiJ
	 eLhGgW452v1kdytRAHLPZcaul7mvl56csR9H0EFYf+aAF3ZjCzfkgb6rr/h8htqsYM
	 Plg6WqsvTz/+w==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 10 Sep 2025 16:36:54 +0200
Subject: [PATCH 09/32] cgroup: use ns_common_init()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250910-work-namespace-v1-9-4dd56e7359d8@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1134; i=brauner@kernel.org;
 h=from:subject:message-id; bh=oLTEkd9LPucYI91jao02VqhHmofn8nqyUbSyayMXIto=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQc7OUQ7ogyf1DNuPPJFEnNSrH9jIELt04VzZaYa5RS5
 c4xP82to5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCKtRYwMZ4IPT58zK3lKwq0z
 e3bOe5f+rnJbmK68lE3NtNCv3xZ0P2X4H+H683xM+N7MiXJbtHf0Pbrkt+jIj+DalqmfWZuOqu5
 m4AUA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Don't cargo-cult the same thing over and over.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 kernel/cgroup/namespace.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/kernel/cgroup/namespace.c b/kernel/cgroup/namespace.c
index 144a464e45c6..0391b6ab0bf1 100644
--- a/kernel/cgroup/namespace.c
+++ b/kernel/cgroup/namespace.c
@@ -21,20 +21,16 @@ static void dec_cgroup_namespaces(struct ucounts *ucounts)
 
 static struct cgroup_namespace *alloc_cgroup_ns(void)
 {
-	struct cgroup_namespace *new_ns;
+	struct cgroup_namespace *new_ns __free(kfree) = NULL;
 	int ret;
 
 	new_ns = kzalloc(sizeof(struct cgroup_namespace), GFP_KERNEL_ACCOUNT);
 	if (!new_ns)
 		return ERR_PTR(-ENOMEM);
-	ret = ns_alloc_inum(&new_ns->ns);
-	if (ret) {
-		kfree(new_ns);
+	ret = ns_common_init(&new_ns->ns, &cgroupns_operations, true);
+	if (ret)
 		return ERR_PTR(ret);
-	}
-	refcount_set(&new_ns->ns.count, 1);
-	new_ns->ns.ops = &cgroupns_operations;
-	return new_ns;
+	return no_free_ptr(new_ns);
 }
 
 void free_cgroup_ns(struct cgroup_namespace *ns)

-- 
2.47.3


