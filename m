Return-Path: <linux-fsdevel+bounces-60778-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24113B519AE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 16:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30C3AA013D6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 14:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 399BC335BB5;
	Wed, 10 Sep 2025 14:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uXRhCXHQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78CC131AF06;
	Wed, 10 Sep 2025 14:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757515049; cv=none; b=UcmFEF/C/p5zp2phcCQIJzWc4784cOXeRAQ6G2lXWTuTErXIS+AfhUXoFM8F/B2QZ+yPtyM6e+FbD9/MmbNShOFH+UrdxXMxAsxZko+aSzJqbPdT1vRkfIds+2QHoerEiKcvDFaQEAjbNVt9/Ddako07YMVXdRpDsBewErJZRYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757515049; c=relaxed/simple;
	bh=ygHSdVECEky2ur8dAJ5kFJhfsJSwR30ApmvwmuGj5yo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EW8c/RH+JMDajKKFuoPUS4BIxrh0JCxzIR9rrqtru2kYboYM3cjkmcYPR8iL+owpgZw6Iepu45Gc3UsNUGqbab1gKImM+/qcJ6tw44Tjkn9b+dq3jYMqrCgyFCkWOlEM+F/WYL1mCpmeQqQeFjXvLDKartmnl+2yc1DFTVxaMe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uXRhCXHQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B19E0C4CEF9;
	Wed, 10 Sep 2025 14:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757515049;
	bh=ygHSdVECEky2ur8dAJ5kFJhfsJSwR30ApmvwmuGj5yo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=uXRhCXHQM7+BUFhrfe33B3BKlUxIF6zIEfkqE2XLwfVf1LpLaqTmqV3mRAvy3avlu
	 USavCz2kLkAYOedsFmywNwuPf2EOBoE+bXWiBR+oTYBDQEBEsccwemEkusIuuMILef
	 M9Eud7NUYL51LxCBsEJU2gWr5u0sU0DpddjGZUiLWdaldcIAgwPBgAi6CBFgU0e8ac
	 7Qjvo2lliTqzQyty/+wFP8ETdrvurZ67+w96MQREIXgpOWLIlQt938lnKyN2vkSVS9
	 l+DAybyDdjw+s/ciqZs6CDXsf8MwdFkSt39Vau0gA9wGt3XU6VGY9mqWTEJKzkr85h
	 nTJSbkPvcJnKQ==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 10 Sep 2025 16:36:49 +0200
Subject: [PATCH 04/32] ns: move to_ns_common() to ns_common.h
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250910-work-namespace-v1-4-4dd56e7359d8@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2191; i=brauner@kernel.org;
 h=from:subject:message-id; bh=ygHSdVECEky2ur8dAJ5kFJhfsJSwR30ApmvwmuGj5yo=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQc7GVfK1sx13oB05HdnhZHJJXX5zNGnXrYpHykLen5X
 t2Fi55GdpSwMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExEYgvDV6EcPy6lps4Xy6Nr
 q8V3Tk/8c2PilJAP9Z/5W/zbPmZ8ZfhfXzfPfpus+qkFOqcXt/RtTLxwT/KMx+dja/01TRkaC1t
 4AA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Move the helper to ns_common.h where it belongs.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/linux/ns_common.h | 20 ++++++++++++++++++++
 include/linux/nsproxy.h   | 11 -----------
 2 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/include/linux/ns_common.h b/include/linux/ns_common.h
index 7d22ea50b098..bc2e0758e1c9 100644
--- a/include/linux/ns_common.h
+++ b/include/linux/ns_common.h
@@ -6,6 +6,15 @@
 
 struct proc_ns_operations;
 
+struct cgroup_namespace;
+struct ipc_namespace;
+struct mnt_namespace;
+struct net;
+struct pid_namespace;
+struct time_namespace;
+struct user_namespace;
+struct uts_namespace;
+
 struct ns_common {
 	struct dentry *stashed;
 	const struct proc_ns_operations *ops;
@@ -13,4 +22,15 @@ struct ns_common {
 	refcount_t count;
 };
 
+#define to_ns_common(__ns)                              \
+	_Generic((__ns),                                \
+		struct cgroup_namespace *: &(__ns)->ns, \
+		struct ipc_namespace *:    &(__ns)->ns, \
+		struct mnt_namespace *:    &(__ns)->ns, \
+		struct net *:              &(__ns)->ns, \
+		struct pid_namespace *:    &(__ns)->ns, \
+		struct time_namespace *:   &(__ns)->ns, \
+		struct user_namespace *:   &(__ns)->ns, \
+		struct uts_namespace *:    &(__ns)->ns)
+
 #endif
diff --git a/include/linux/nsproxy.h b/include/linux/nsproxy.h
index dab6a1734a22..e6bec522b139 100644
--- a/include/linux/nsproxy.h
+++ b/include/linux/nsproxy.h
@@ -42,17 +42,6 @@ struct nsproxy {
 };
 extern struct nsproxy init_nsproxy;
 
-#define to_ns_common(__ns)                              \
-	_Generic((__ns),                                \
-		struct cgroup_namespace *: &(__ns->ns), \
-		struct ipc_namespace *:    &(__ns->ns), \
-		struct net *:              &(__ns->ns), \
-		struct pid_namespace *:    &(__ns->ns), \
-		struct mnt_namespace *:    &(__ns->ns), \
-		struct time_namespace *:   &(__ns->ns), \
-		struct user_namespace *:   &(__ns->ns), \
-		struct uts_namespace *:    &(__ns->ns))
-
 /*
  * A structure to encompass all bits needed to install
  * a partial or complete new set of namespaces.

-- 
2.47.3


