Return-Path: <linux-fsdevel+bounces-61065-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8FEEB54C4E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 14:04:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDDE2A043CA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 12:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5948A31D39D;
	Fri, 12 Sep 2025 11:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZUNcYMZ7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF6F305E1B;
	Fri, 12 Sep 2025 11:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757678096; cv=none; b=US/iU8AZCQp4dj9SqNg8pps7jppn+jFofHCTwwL2k/zc3c5JxobfZ2mvhkfgDI7epS0+aVmSut8cOJLo6vgjaZ6oBqSw7ZQNx143sYIh2Y3x0V9jhyUTKkgOZ13FjGAQ8m8H3rdkehcgA9zyhqjGDi/yDbycJ64iVOLoUFGT7DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757678096; c=relaxed/simple;
	bh=ywo4YwGPcpm62D3mc8keCOGyfWOmWTYH6nvEj3f9mmM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gvOb/xeIKRZ/MJsVD7XhzUWqHZy5T3GFjIfhUBoAvpkYlh9YXsh1x5GAFa+1TjTzw3uR8d2V5hAmszYutjFX+lZggE/gAXFLyB5m4w8pCi7uoHaVikd6tXdwYE+NNqzzMRaVit/RwosOf3yrDWjCKbn5bPuHy/RRjwGW3JCVUbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZUNcYMZ7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 193F4C4CEF1;
	Fri, 12 Sep 2025 11:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757678096;
	bh=ywo4YwGPcpm62D3mc8keCOGyfWOmWTYH6nvEj3f9mmM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZUNcYMZ7+JLg4GDv9EdSn547NbmFdXvN5RedfUypeb73TwUJjZt16grmqWLobw+D7
	 08cv72OKoPuz2pL2DXMwmplFmlb4+v0Mnw+STCU5D0sluEnbsA5i8jnSE6mKKTcjJ5
	 XAX2itFd2PUGC+CP/Sm4csfZsq09m3vBnn8+fGThx/W3Uv+Ci62j+ngu6CPH5btES8
	 W9HdkqmwFQunt/W5kTAdZ3XTlTnvAdDWyKwbxAl4tZAsRD0wa7Uoefq6ZoW7dCbxtN
	 hpb35tInjCr/P88aW7biyypH9fpGnA03EH7BSjSHHuBo9euHKSSckAuyTFPTiAVzNg
	 9VlRLQg1lTUAg==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 12 Sep 2025 13:52:43 +0200
Subject: [PATCH v2 20/33] ipc: support ns lookup
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250912-work-namespace-v2-20-1a247645cef5@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1774; i=brauner@kernel.org;
 h=from:subject:message-id; bh=ywo4YwGPcpm62D3mc8keCOGyfWOmWTYH6nvEj3f9mmM=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQc4Zy6li17cciL5M1cSpr9C1PXP17OfZbtxqVFjw5GX
 fQz+dd4t6OUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiR+QZ/nAHGp2YfSxSX1W/
 wPqp2gJ73i8rKu2nvDlhmn8kxZbd3YThf2GeXe/Z41Oe5xn+zlVffFzWUuJIwZXlu7a2LFmZURn
 hygUA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Support the generic ns lookup infrastructure to support file handles for
namespaces.

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


