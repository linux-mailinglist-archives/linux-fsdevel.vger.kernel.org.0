Return-Path: <linux-fsdevel+bounces-60800-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E04FFB51A26
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 16:50:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5EF1D7BFA5F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 14:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A7BB3705A8;
	Wed, 10 Sep 2025 14:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pink4nL/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7AD233769E;
	Wed, 10 Sep 2025 14:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757515182; cv=none; b=Oz240tzCsA6yQOlvJIT+/hGIXCR6Ep8YZkoDNaa2OXzS3109+8KDnJ/mbewTsuUwUcB7kWIFkjLK17Mr8nZnXO55ym6xsPMcFiqOI0W3zo82qiJEA1WB3kbMzP3PZiJuzWwngLYDUed2weKO5mND8YTyiM+Cdt3SN/GKk317WK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757515182; c=relaxed/simple;
	bh=V2knpP68ov2ShGssBrReM+o3kSt82DUPUH0cG76sD7U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LYRSyYMTKGYivarxn7MgJ1Eb/EcFPKgUBaopD6MQVAr6o6nMrxFLNn4fFE44ba0ZFgTpgi2v7xYd7ygmwugBnJfmgyrVZNwmv5Y4ryhcyQb0JQANHKee5pxkLLSdSfFS9v19RlYqhOGE2dpFeH3eyaSnaBrtRcTCuAKDJ7aaeKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pink4nL/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 382D1C4CEEB;
	Wed, 10 Sep 2025 14:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757515181;
	bh=V2knpP68ov2ShGssBrReM+o3kSt82DUPUH0cG76sD7U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Pink4nL/AOO5/6CZ0au4nS9W1zntK1GrKZuLW+/1kJG2M6ji5trlTqaRBD32aQ7Qx
	 4gdLqs05aoIMOANtEtjQaMdXX8JofONBmfr4c9dewaKgVs7q1xCOmA0N8g9c8kXfhs
	 +3tBDWJYMSDiRp5q4nWue5wQmEqHlW94MALNhFsUznLoqSC2z/DY568jYqh7O4jKP+
	 Qdpgf3QSl8wjEsSLx+BvjP18uyx11fqgTly7qH4vJIJ78CpshnqtExUKCqygKYLI/N
	 BiXGR8qK4Zke7iedLkgI4WOc849vupZZfLfVJ7hBJKw6KZ3Q8EW2uuBLrscVxYOlrr
	 6J/aS2K/Z1AIA==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 10 Sep 2025 16:37:11 +0200
Subject: [PATCH 26/32] nsfs: add current_in_namespace()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250910-work-namespace-v1-26-4dd56e7359d8@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1554; i=brauner@kernel.org;
 h=from:subject:message-id; bh=V2knpP68ov2ShGssBrReM+o3kSt82DUPUH0cG76sD7U=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQc7OV89GIKW4OOLkvS6/JpV8qjrklNmNks9fnFRwOty
 TXb/nRLdpSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEwk1IGRYaNqjWjkdgdB83US
 mwIYE1853eOcyfWURZ5lZ8jmju1xVQz/lNa+VtmnEb/V+qqvYVn5wu97ZzNNL1rZn6dybp/cJXY
 hVgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Add a helper to easily check whether a given namespace is the caller's
current namespace. This is currently open-coded in a lot of places.
Simply switch on the type and compare the results.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/linux/nsfs.h | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/include/linux/nsfs.h b/include/linux/nsfs.h
index fb84aa538091..e5a5fa83d36b 100644
--- a/include/linux/nsfs.h
+++ b/include/linux/nsfs.h
@@ -5,6 +5,8 @@
 #define _LINUX_NSFS_H
 
 #include <linux/ns_common.h>
+#include <linux/cred.h>
+#include <linux/pid_namespace.h>
 
 struct path;
 struct task_struct;
@@ -22,5 +24,17 @@ int ns_get_name(char *buf, size_t size, struct task_struct *task,
 			const struct proc_ns_operations *ns_ops);
 void nsfs_init(void);
 
-#endif /* _LINUX_NSFS_H */
+#define __current_namespace_from_type(__ns)				\
+	_Generic((__ns),						\
+		struct cgroup_namespace *: current->nsproxy->cgroup_ns,	\
+		struct ipc_namespace *:    current->nsproxy->ipc_ns,	\
+		struct net *:              current->nsproxy->net_ns,	\
+		struct pid_namespace *:    task_active_pid_ns(current),	\
+		struct mnt_namespace *:    current->nsproxy->mnt_ns,	\
+		struct time_namespace *:   current->nsproxy->time_ns,	\
+		struct user_namespace *:   current_user_ns(),		\
+		struct uts_namespace *:    current->nsproxy->uts_ns)
+
+#define current_in_namespace(__ns) (__current_namespace_from_type(__ns) == __ns)
 
+#endif /* _LINUX_NSFS_H */

-- 
2.47.3


