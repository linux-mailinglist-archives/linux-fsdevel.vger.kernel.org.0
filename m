Return-Path: <linux-fsdevel+bounces-62398-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BFBFB912D3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Sep 2025 14:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B9F4171992
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Sep 2025 12:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 570ED30B527;
	Mon, 22 Sep 2025 12:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pvGOWEvv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982BD308F38;
	Mon, 22 Sep 2025 12:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758544982; cv=none; b=eYFUNQbe46eedhUWe3ZdKmWDjeHv/3gjgnKsoXcn8Aw1wzXGtow/nLmInxiBvXV2AEaxTd+3p7uuNkJeTRtJX/TpPQ4VPteVjp3PvM4+jErepB42TZkIjgdCYfL9fJo8EM4scu3dx0Fobra29vyjlxjIo8YAZZ17PKvGB2hstoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758544982; c=relaxed/simple;
	bh=eXegoR9+/J66AI1dQB6rfx5+3Y1FvmBpnCRJJsJbBZU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FuZZDUtTVOhzLHwc6j/gvzAcTjTiBaJ1Rh9vg/CF6ZI5aw4SHLLtpJUkJ7yl238Y+oXf0lSmUQYW4Lk00SqqpCw2q+JtLrMBuEHPuIrKv33MxkaHXAMN2JmAr/5BQUZEiMEWr0xY9DN5sNZLSBH662wXa2g1OIbJyROC0MNeHu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pvGOWEvv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47C15C4CEF7;
	Mon, 22 Sep 2025 12:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758544981;
	bh=eXegoR9+/J66AI1dQB6rfx5+3Y1FvmBpnCRJJsJbBZU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=pvGOWEvvz9AYqq4lFnEth96LOGzcnJfCvhzo3JO+7VDH3zywlRPE4G561r4ydtIRg
	 2cBYkO3Gs4Zk56Wk6UMJ35mPXPkQ/p9d5Fos+dNfJ+AKDPzvTWbNp2nXxTxIWMwh4Y
	 TCl3GP96z3RGcIzv33KlcYc+1ahL3Gpni2UgtWP4NLkf+OyWiphO30UPTyUX+cs+ms
	 EASnO9rl303Mdrv21Oqe4TnhJVioMpXzF+FKe4/duPOuuHibokFL7vZMBqBeLaIMM8
	 Bs+cvH94gQrzHZ+oNDQ5Bl0n+zkZGFRrR6+AdVkoHL1WvDv3ihQCTGvQObjdRn0CiW
	 Jkemgng632A4g==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 22 Sep 2025 14:42:37 +0200
Subject: [PATCH 3/3] ns: add ns_debug()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250922-work-namespace-ns_common-fixes-v1-3-3c26aeb30831@kernel.org>
References: <20250922-work-namespace-ns_common-fixes-v1-0-3c26aeb30831@kernel.org>
In-Reply-To: <20250922-work-namespace-ns_common-fixes-v1-0-3c26aeb30831@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Amir Goldstein <amir73il@gmail.com>, Josef Bacik <josef@toxicpanda.com>, 
 Jeff Layton <jlayton@kernel.org>, Mike Yuan <me@yhndnzj.com>, 
 =?utf-8?q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
 Lennart Poettering <mzxreary@0pointer.de>, Aleksa Sarai <cyphar@cyphar.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, cgroups@vger.kernel.org, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-56183
X-Developer-Signature: v=1; a=openpgp-sha256; l=2013; i=brauner@kernel.org;
 h=from:subject:message-id; bh=eXegoR9+/J66AI1dQB6rfx5+3Y1FvmBpnCRJJsJbBZU=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRcdHGufLdqp3vlk4Q1Dk/fn3ohZJy/jeVH4POoLO7nA
 tcESutyOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACYi38vwP7dtrWyCt61CzoL3
 X1Mq/MoZhadP8lScKVY6/aeGl/y+EIb/LgILxT4EsL3ecm/N0gQHx44va5Q9L5owT5GfJucvfdm
 QBwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Add ns_debug() that asserts that the correct operations are used for the
namespace type.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 kernel/nscommon.c | 53 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/kernel/nscommon.c b/kernel/nscommon.c
index 7aa2be6a0c32..3cef89ddef41 100644
--- a/kernel/nscommon.c
+++ b/kernel/nscommon.c
@@ -2,6 +2,55 @@
 
 #include <linux/ns_common.h>
 #include <linux/proc_ns.h>
+#include <linux/vfsdebug.h>
+
+#ifdef CONFIG_DEBUG_VFS
+static void ns_debug(struct ns_common *ns, const struct proc_ns_operations *ops)
+{
+	switch (ns->ops->type) {
+#ifdef CONFIG_CGROUPS
+	case CLONE_NEWCGROUP:
+		VFS_WARN_ON_ONCE(ops != &cgroupns_operations);
+		break;
+#endif
+#ifdef CONFIG_IPC_NS
+	case CLONE_NEWIPC:
+		VFS_WARN_ON_ONCE(ops != &ipcns_operations);
+		break;
+#endif
+	case CLONE_NEWNS:
+		VFS_WARN_ON_ONCE(ops != &mntns_operations);
+		break;
+#ifdef CONFIG_NET_NS
+	case CLONE_NEWNET:
+		VFS_WARN_ON_ONCE(ops != &netns_operations);
+		break;
+#endif
+#ifdef CONFIG_PID_NS
+	case CLONE_NEWPID:
+		VFS_WARN_ON_ONCE(ops != &pidns_operations);
+		break;
+#endif
+#ifdef CONFIG_TIME_NS
+	case CLONE_NEWTIME:
+		VFS_WARN_ON_ONCE(ops != &timens_operations);
+		break;
+#endif
+#ifdef CONFIG_USER_NS
+	case CLONE_NEWUSER:
+		VFS_WARN_ON_ONCE(ops != &userns_operations);
+		break;
+#endif
+#ifdef CONFIG_UTS_NS
+	case CLONE_NEWUTS:
+		VFS_WARN_ON_ONCE(ops != &utsns_operations);
+		break;
+#endif
+	default:
+		VFS_WARN_ON_ONCE(true);
+	}
+}
+#endif
 
 int __ns_common_init(struct ns_common *ns, const struct proc_ns_operations *ops, int inum)
 {
@@ -12,6 +61,10 @@ int __ns_common_init(struct ns_common *ns, const struct proc_ns_operations *ops,
 	RB_CLEAR_NODE(&ns->ns_tree_node);
 	INIT_LIST_HEAD(&ns->ns_list_node);
 
+#ifdef CONFIG_DEBUG_VFS
+	ns_debug(ns, ops);
+#endif
+
 	if (inum) {
 		ns->inum = inum;
 		return 0;

-- 
2.47.3


