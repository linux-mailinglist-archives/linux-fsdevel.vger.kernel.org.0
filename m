Return-Path: <linux-fsdevel+bounces-62562-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E6C9B99992
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 13:34:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F4FD188563B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 11:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB4352FD1C2;
	Wed, 24 Sep 2025 11:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NeK1xsWA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368072FDC56;
	Wed, 24 Sep 2025 11:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758713656; cv=none; b=br83YWFQoSJKLfVNCgkcoGPh/wuajJW/ZAPJ4mdjKaYx4V1yaEO+82+arhSqCugualzAwCaltGDCPFph4ub+VGWSiXaD++0zv0XnN5xMp4nMjwf1ucPM1aP8N8bFkLXS6BhuXcrKLT/6BbYzbc5plnGr00X+pZ4zWAJynw5UBQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758713656; c=relaxed/simple;
	bh=zo0abxKTr1ANwWoChblQKIxscmAB5HLy8zkYWZ3S40E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FidD4LXjhYhhbRUATrMgI1A6yJYm9snmN03FTvbf/BXfCixmgD6HuwAL8wAqNuku2DhP/Ezn7v2k9ACCGdIGYFns2ex60hjZ+umCJlttNU0SXx075To6dqHJkFB78mveg1JGHvqzCuGMx1El+rUsNp+7RQXltfWnS6JtcZ3EUr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NeK1xsWA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0451AC19425;
	Wed, 24 Sep 2025 11:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758713655;
	bh=zo0abxKTr1ANwWoChblQKIxscmAB5HLy8zkYWZ3S40E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NeK1xsWAzNKRLHBfWUa7fNilEk934HBWn/B3AB+e/zd5+HHnFy2QEXcwmBEi7ZFoe
	 y6O7iwKd6FStLzCUnNwvqz+s1MUXmSJlyco0tTmRmXGBpL9fYJc2CJQ5KCTTGDt6dF
	 agjc4rCpeG6SODaii2Fc+dEudXyyg5m2TizK9SYKKv3snepkOjQpyb+emgWhwV6Y+n
	 s4iHeCBYuAj44c/i/adAVTKsp9klHIxpBONU+dSHKioHZ251TUQ8r+wT1ka9OHOZAG
	 xiQiv5RQupUBKvaKQaLhMRqbNWkeW6zYqguxg/yYcmR7vOo9R9yokAkaPvrd+au7L+
	 PB2seCm0cSLEQ==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 24 Sep 2025 13:33:58 +0200
Subject: [PATCH 1/3] nstree: make struct ns_tree private
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-work-namespaces-fixes-v1-1-8fb682c8678e@kernel.org>
References: <20250924-work-namespaces-fixes-v1-0-8fb682c8678e@kernel.org>
In-Reply-To: <20250924-work-namespaces-fixes-v1-0-8fb682c8678e@kernel.org>
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
 netdev@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-56183
X-Developer-Signature: v=1; a=openpgp-sha256; l=1694; i=brauner@kernel.org;
 h=from:subject:message-id; bh=zo0abxKTr1ANwWoChblQKIxscmAB5HLy8zkYWZ3S40E=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRcvq6fd0HqOJ9+/ufleZabE7X1Veq0mWsrv/1dkHCk+
 keS2oqnHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABM5MoeRYbfTl78vyl1ebVfq
 0I0KUA6Qkmc885RXT2im7+HZf3f6dDL8U2qL7pzfdNUuc9rbMLOjE0UPnPHYwnbFaVvjNpX89VN
 /MAMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Don't expose it directly. There's no need to do that.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/linux/nstree.h | 13 -------------
 kernel/nstree.c        | 13 +++++++++++++
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/include/linux/nstree.h b/include/linux/nstree.h
index 29ad6402260c..8b8636690473 100644
--- a/include/linux/nstree.h
+++ b/include/linux/nstree.h
@@ -9,19 +9,6 @@
 #include <linux/rculist.h>
 #include <linux/cookie.h>
 
-/**
- * struct ns_tree - Namespace tree
- * @ns_tree: Rbtree of namespaces of a particular type
- * @ns_list: Sequentially walkable list of all namespaces of this type
- * @ns_tree_lock: Seqlock to protect the tree and list
- */
-struct ns_tree {
-	struct rb_root ns_tree;
-	struct list_head ns_list;
-	seqlock_t ns_tree_lock;
-	int type;
-};
-
 extern struct ns_tree cgroup_ns_tree;
 extern struct ns_tree ipc_ns_tree;
 extern struct ns_tree mnt_ns_tree;
diff --git a/kernel/nstree.c b/kernel/nstree.c
index bbe8bedc924c..113d681857f1 100644
--- a/kernel/nstree.c
+++ b/kernel/nstree.c
@@ -4,6 +4,19 @@
 #include <linux/proc_ns.h>
 #include <linux/vfsdebug.h>
 
+/**
+ * struct ns_tree - Namespace tree
+ * @ns_tree: Rbtree of namespaces of a particular type
+ * @ns_list: Sequentially walkable list of all namespaces of this type
+ * @ns_tree_lock: Seqlock to protect the tree and list
+ */
+struct ns_tree {
+       struct rb_root ns_tree;
+       struct list_head ns_list;
+       seqlock_t ns_tree_lock;
+       int type;
+};
+
 struct ns_tree mnt_ns_tree = {
 	.ns_tree = RB_ROOT,
 	.ns_list = LIST_HEAD_INIT(mnt_ns_tree.ns_list),

-- 
2.47.3


