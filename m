Return-Path: <linux-fsdevel+bounces-61072-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4E3CB54C90
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 14:08:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B613172365
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 12:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD41C307AF2;
	Fri, 12 Sep 2025 11:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lBwqf0lR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A68307AF0;
	Fri, 12 Sep 2025 11:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757678139; cv=none; b=JYKIsqK9nCM7vCsadaaZIeqIgkVNFn4UENCfNh7DxYrUGaHDaRvvraLVXLHOSFQdJTns62Yw7vi3ZBGsspJPt4YrXDmkbMsxUa2I3sdOWNnzIG+Bu7qstRGS2HhaQ2/3R632v9Md0UWubhwXj3x+OsAFr58VAd+NZ2lVWZ8KdX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757678139; c=relaxed/simple;
	bh=9cDHPv3W9xCOzTcc8m08HNvBL6X474XMUmLIQpmhKP0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S7jRQJP8O5uLQg6SagcuzY8ypptbM7KXA2F+akyXFpmecdsY7/6uHwV1CoywhaF9h+niYmDvgwZUKhtY7bae1aLxd0zEiYfe/3BGyutBZ5CFyYDgRq7elI8S991SwV46vJg6Dqa2G/ZNbhDRnH0SA1MoRl5TNWpXz6qoudHVCcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lBwqf0lR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7515CC4CEFA;
	Fri, 12 Sep 2025 11:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757678137;
	bh=9cDHPv3W9xCOzTcc8m08HNvBL6X474XMUmLIQpmhKP0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=lBwqf0lRnmmqHbseD8Bv3a1OZn1zqQi9oAjN6zmlyJR6rhq2yhdZ6GlibH455BmGp
	 Qp+JUBWLR0r1z4kVeL14bPyl4m2fyfQFOnCxz0VbpT6Oq37ElZsOm1yCjmRJBhERRo
	 OLJ2lfHbNsgkgY+KANP0DAlAFPhtLRwngzPpBRhXmj4kRDWKGOmqm3a1f0Gi4q9hud
	 /OqSlR63bpeTi3w/rVlQheUHQGqYl78bfACKw6Brgu9ZHuEUf8RI+ICSd+jzjbuRe7
	 9N8dZlTEKchAfaHWs+mD3vlSxEVNIRUTZmQdCC3n/0xIKBUMco7kGVfAwqlzjjV3jP
	 Z5+BHwANmRc6w==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 12 Sep 2025 13:52:50 +0200
Subject: [PATCH v2 27/33] nsfs: add current_in_namespace()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250912-work-namespace-v2-27-1a247645cef5@kernel.org>
References: <20250912-work-namespace-v2-0-1a247645cef5@kernel.org>
In-Reply-To: <20250912-work-namespace-v2-0-1a247645cef5@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1601; i=brauner@kernel.org;
 h=from:subject:message-id; bh=9cDHPv3W9xCOzTcc8m08HNvBL6X474XMUmLIQpmhKP0=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQc4ZxazCpwmi/ln3X1hIfZgo6GM2wMheI0nIMKbzBuf
 WjsE2bZUcrCIMbFICumyOLQbhIut5ynYrNRpgbMHFYmkCEMXJwCMJH55xn+52xxS3Y8sTfQLk9P
 hq9ZenLLtycHPm4SM1ks/PpZ+qScUIb/bvpH5WM05hdmqByWP9PBk5/x8tSegIiwW29+Hqjt2iH
 AAQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Add a helper to easily check whether a given namespace is the caller's
current namespace. This is currently open-coded in a lot of places.
Simply switch on the type and compare the results.

Reviewed-by: Aleksa Sarai <cyphar@cyphar.com>
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


