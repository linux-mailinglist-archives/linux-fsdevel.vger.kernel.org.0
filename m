Return-Path: <linux-fsdevel+bounces-60793-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1046AB51A3A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 16:51:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5D25580423
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 14:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3B1635FC0F;
	Wed, 10 Sep 2025 14:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c/kUIU0V"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E7B315D34;
	Wed, 10 Sep 2025 14:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757515140; cv=none; b=hPCG86Y30m5wj4XBClTf37uZ3+9vdrGWxjFrB2gJVYRwfOvHVC6t65DoZoZPcf/OaHGT3/yA6zzvxkvKIiSOrUx0jPD8F428PiBkrnnwk2uywTu8LvTCrulHYiVN3hHLtXiBQwH0NjHL+zFm1pjk6B0nqYSpgTJR2o65gSP1/08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757515140; c=relaxed/simple;
	bh=SZfqMg6X4elv6PVRXbYLnsx0Kwlyt6iqs4u/5eCFwbk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F2nGcXbK50X2vfUlmOXelS/U0Ko/bVf2ejMXO5i1CGCoxNALUJln5TFCEk0R2uD5gEQxFVASVN+09GDfTLIHJ1gnH25RCgs7H9o8OZNZuAZQiVknU/XFvU+wDzujviFMhTyLJKnrf5zFJ/eDeO0rgfwDrGRNpRkJX4s/tNJGKn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c/kUIU0V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3913FC4CEEB;
	Wed, 10 Sep 2025 14:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757515139;
	bh=SZfqMg6X4elv6PVRXbYLnsx0Kwlyt6iqs4u/5eCFwbk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=c/kUIU0VAfPGzEOXITyI4Ht1mcsq8Zwr+dRtmaKlgIN0Rt2eXG8Y68R41AwxnQi5H
	 C4j3yNj7nxKR131qjX7KAENZ8u8ZI44qEAyc+xj0uPqYozE/O+610YeCCxndBrvtkk
	 xsrM39vEmU/Rx8zK4+BPVi2PSGBgj1PySSiTTICzBY4bpwJbUIj7XC7ImucQ1emEPG
	 7xGpRN0uPwg8n+C11rLUbDH5LoCACMH8XpF2Fh5zb0yxm+MqSzUoxE3jy6hrGPrlTW
	 y21O38uZcE8NVjAWA4com46q6dNs+eOgE5fsB5p17mLUu6rAYyF75d78q5XIdDUwac
	 FKv0/Guz8F85Q==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 10 Sep 2025 16:37:04 +0200
Subject: [PATCH 19/32] ipc: support iterator
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250910-work-namespace-v1-19-4dd56e7359d8@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1794; i=brauner@kernel.org;
 h=from:subject:message-id; bh=SZfqMg6X4elv6PVRXbYLnsx0Kwlyt6iqs4u/5eCFwbk=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQc7OWYc+k40zWf1pit+VWXD3k4sdpqzLy1xcVwdtGBa
 2bca7x+d5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExkRQQjw8PNr+0dQ1w33v35
 7KBavgXzkXPRYelhZU3yn6dcnsL0Xp2RofPN5+y/4vM3c04QPBzy4kmaRenxBWdn/fl2wK3q4rU
 LnvwA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Support the generic namespace iterator and lookup infrastructure to
support file handles for namespaces.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 ipc/msgutil.c   | 1 +
 ipc/namespace.c | 3 +++
 ipc/shm.c       | 2 ++
 3 files changed, 6 insertions(+)

diff --git a/ipc/msgutil.c b/ipc/msgutil.c
index c7be0c792647..bbf61275df41 100644
--- a/ipc/msgutil.c
+++ b/ipc/msgutil.c
@@ -15,6 +15,7 @@
 #include <linux/proc_ns.h>
 #include <linux/uaccess.h>
 #include <linux/sched.h>
+#include <linux/nstree.h>
 
 #include "util.h"
 
diff --git a/ipc/namespace.c b/ipc/namespace.c
index d4188a88ee57..9f923c1a1eb3 100644
--- a/ipc/namespace.c
+++ b/ipc/namespace.c
@@ -15,6 +15,7 @@
 #include <linux/mount.h>
 #include <linux/user_namespace.h>
 #include <linux/proc_ns.h>
+#include <linux/nstree.h>
 #include <linux/sched/task.h>
 
 #include "util.h"
@@ -85,6 +86,7 @@ static struct ipc_namespace *create_ipc_ns(struct user_namespace *user_ns,
 
 	sem_init_ns(ns);
 	shm_init_ns(ns);
+	ns_tree_add(ns);
 
 	return ns;
 
@@ -201,6 +203,7 @@ void put_ipc_ns(struct ipc_namespace *ns)
 		mq_clear_sbinfo(ns);
 		spin_unlock(&mq_lock);
 
+		ns_tree_remove(ns);
 		if (llist_add(&ns->mnt_llist, &free_ipc_list))
 			schedule_work(&free_ipc_work);
 	}
diff --git a/ipc/shm.c b/ipc/shm.c
index a9310b6dbbc3..3db36773dd10 100644
--- a/ipc/shm.c
+++ b/ipc/shm.c
@@ -45,6 +45,7 @@
 #include <linux/mount.h>
 #include <linux/ipc_namespace.h>
 #include <linux/rhashtable.h>
+#include <linux/nstree.h>
 
 #include <linux/uaccess.h>
 
@@ -148,6 +149,7 @@ void shm_exit_ns(struct ipc_namespace *ns)
 static int __init ipc_ns_init(void)
 {
 	shm_init_ns(&init_ipc_ns);
+	ns_tree_add(&init_ipc_ns);
 	return 0;
 }
 

-- 
2.47.3


