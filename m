Return-Path: <linux-fsdevel+bounces-48591-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A18AB1407
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 14:56:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CA6C981938
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 12:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 382F82920A8;
	Fri,  9 May 2025 12:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SGIOsJx4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF17290DBC;
	Fri,  9 May 2025 12:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746795306; cv=none; b=YPYxktc7F7OL6XuC4CYKIOR9FDFuT+5eswtgwqLQodk2M7nQ/ImXN9qRe49s6VRAOE925E0bH8NpgQyZlU1vnhJpyRXClAwT6PMDBwompqI3eheWhkVWU/AmIh3VyvjzUuEydYLxf6XQrzq2LMcXwHAlKA9z/Mgtml+2GaQNHXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746795306; c=relaxed/simple;
	bh=m38oSF1bsk4q8XGkb05UXXsxgbOmuEMD50QR+Uz7CYc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ufj5Hkwj6AlXGv1BZ1A14zJciJWjJU4a+tZcVJcfAp6h8twduv/0s0BKY0U7iZ8rh+C51CiNggwFiLzOJiBG1cX1GI5lx+Q2T1jqo0TXcpXBHKqPPS9iwUi9zfJ8pl78Qz/EXW796CV3ZMdrhNO93zot3e/MttEimw5Kfw9N7/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SGIOsJx4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CB96AC4CEEE;
	Fri,  9 May 2025 12:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746795305;
	bh=m38oSF1bsk4q8XGkb05UXXsxgbOmuEMD50QR+Uz7CYc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=SGIOsJx42H5Nlud04v6QJtwpQIa+btBJZzPy80+nof8he1otM7798Z6eTanP4WZ7Q
	 LWcETjTxdplEq8jJxptGlHEFWPvdJkQDCuvaureBHpQCNKS5n7QO3ZhIXXdgE4PHc8
	 4ivdYewXH6PQp2yWb93BpIP+pjIujmbmzfv5Y8SlfIDvBsS8CHARjXru6ArwJhbnCz
	 r3fWm3JPMgS5q8i/anreJqrdDlUpObRh/y6h8RksQ3Y2TzzGM7x8/xLlw36OSWQNxx
	 eM1v7PyTPZzDigqrp/wVeBzl/q+36ELB8i1G+M6XyaF5brdQX0+5+0luolIEyY7M7I
	 oguGDP7Mld/+A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA4DFC3ABCC;
	Fri,  9 May 2025 12:55:05 +0000 (UTC)
From: Joel Granados <joel.granados@kernel.org>
Date: Fri, 09 May 2025 14:54:06 +0200
Subject: [PATCH 02/12] locking/rtmutex: Move max_lock_depth into rtmutex.c
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250509-jag-mv_ctltables_iter2-v1-2-d0ad83f5f4c3@kernel.org>
References: <20250509-jag-mv_ctltables_iter2-v1-0-d0ad83f5f4c3@kernel.org>
In-Reply-To: <20250509-jag-mv_ctltables_iter2-v1-0-d0ad83f5f4c3@kernel.org>
To: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
 Sami Tolvanen <samitolvanen@google.com>, 
 Daniel Gomez <da.gomez@samsung.com>, Kees Cook <kees@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
 Waiman Long <longman@redhat.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
 Joel Fernandes <joel@joelfernandes.org>, 
 Josh Triplett <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 Helge Deller <deller@gmx.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, rcu@vger.kernel.org, linux-mm@kvack.org, 
 linux-parisc@vger.kernel.org, linux-serial@vger.kernel.org, 
 Joel Granados <joel.granados@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3350;
 i=joel.granados@kernel.org; h=from:subject:message-id;
 bh=m38oSF1bsk4q8XGkb05UXXsxgbOmuEMD50QR+Uz7CYc=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGgd+yFGAm/Om5FxfE5IBLkbOWnP5gjnTcP/E
 wE2pCdoia9aUIkBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJoHfshAAoJELqXzVK3
 lkFPej4L/3tUO7WMqQqglIlWRHXlqTWnxNRYnKJZsiWhYbMrGWU4eNprXYMvMDxp4JszWCrc+s/
 dHmZpjlZm84mz3wparfKY41aEWSr7T1OyrvxIHx+unxR9zyRa+ILYevo9846AmVIaP24Eh0rn/3
 5Cie9W07x5dm/HcvUcOwFgQ1dv9o41QFMKP2kyAnbmhmXtQeF3w54Sjg1Z0KB8PO4YvSJNUReGL
 WzaCrJEvSmK2XEzGGrjEeb3FlYKd0OfHShmxh3fnX7xb9CzwgsS+6NNqsuRLVIv0gTZShloGJr7
 8uDDxU2WngQ49c6Jb5IDh+QtPUfDul3yqLOkx0XpwzoEmrzVkgrPk6iZV960PvH51ShMRX15ca5
 ZHZ3neelFOecKdIjeq52ldmUvrYdxZYiv/YeW2hnSDdQQ78uPma7JuRm7RrJ/tGA96vqd00i43Y
 IE4RlTg9xRQXIFnwXFOWjnTph14ioLpEP8BCgrqaTOB8/JrM47yU5/1EECWiK/lMDwB3lSgRJH6
 JM=
X-Developer-Key: i=joel.granados@kernel.org; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for joel.granados@kernel.org/default with
 auth_id=239

Move the max_lock_depth sysctl table element and variable into
rtmutex.c. Make the variable static as it no longer needs to be
exported. Removed the rtmutex.h include from sysctl.c.

This is part of a greater effort to move ctl tables into their
respective subsystems which will reduce the merge conflicts in
kernel/sysctl.c.

Signed-off-by: Joel Granados <joel.granados@kernel.org>
---
 include/linux/rtmutex.h      |  2 --
 kernel/locking/rtmutex.c     | 23 +++++++++++++++++++++++
 kernel/locking/rtmutex_api.c |  5 -----
 kernel/sysctl.c              | 12 ------------
 4 files changed, 23 insertions(+), 19 deletions(-)

diff --git a/include/linux/rtmutex.h b/include/linux/rtmutex.h
index 7d049883a08ace049384d70b4c97e3f4fb0e46f8..dc9a51cda97cdb6ac8e12be5209071744101b703 100644
--- a/include/linux/rtmutex.h
+++ b/include/linux/rtmutex.h
@@ -18,8 +18,6 @@
 #include <linux/rbtree_types.h>
 #include <linux/spinlock_types_raw.h>
 
-extern int max_lock_depth; /* for sysctl */
-
 struct rt_mutex_base {
 	raw_spinlock_t		wait_lock;
 	struct rb_root_cached   waiters;
diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index c80902eacd797c669dedcf10966a8cff38524b50..705a0e0fd72ab8da051e4227a5b89cb3d1539524 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -29,6 +29,29 @@
 #include "rtmutex_common.h"
 #include "lock_events.h"
 
+/*
+ * Max number of times we'll walk the boosting chain:
+ */
+static int max_lock_depth = 1024;
+
+static const struct ctl_table rtmutex_sysctl_table[] = {
+	{
+		.procname	= "max_lock_depth",
+		.data		= &max_lock_depth,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec,
+	},
+};
+
+static int __init init_rtmutex_sysctl(void)
+{
+	register_sysctl_init("kernel", rtmutex_sysctl_table);
+	return 0;
+}
+
+subsys_initcall(init_rtmutex_sysctl);
+
 #ifndef WW_RT
 # define build_ww_mutex()	(false)
 # define ww_container_of(rtm)	NULL
diff --git a/kernel/locking/rtmutex_api.c b/kernel/locking/rtmutex_api.c
index 191e4720e546627aed0d7ec715673b1b8753b130..2b5da8af206da6ee72df1234a4db94f5c4f6f882 100644
--- a/kernel/locking/rtmutex_api.c
+++ b/kernel/locking/rtmutex_api.c
@@ -8,11 +8,6 @@
 #define RT_MUTEX_BUILD_MUTEX
 #include "rtmutex.c"
 
-/*
- * Max number of times we'll walk the boosting chain:
- */
-int max_lock_depth = 1024;
-
 /*
  * Debug aware fast / slowpath lock,trylock,unlock
  *
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 473133d9651eac4ef44b8b63a44b77189818ac08..a22f35013da0d838ef421fc5d192f00d1e70fb0f 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -59,9 +59,6 @@
 #include <asm/nmi.h>
 #include <asm/io.h>
 #endif
-#ifdef CONFIG_RT_MUTEXES
-#include <linux/rtmutex.h>
-#endif
 
 /* shared constants to be used in various sysctls */
 const int sysctl_vals[] = { 0, 1, 2, 3, 4, 100, 200, 1000, 3000, INT_MAX, 65535, -1 };
@@ -1709,15 +1706,6 @@ static const struct ctl_table kern_table[] = {
 		.proc_handler	= proc_dointvec,
 	},
 #endif
-#ifdef CONFIG_RT_MUTEXES
-	{
-		.procname	= "max_lock_depth",
-		.data		= &max_lock_depth,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
-	},
-#endif
 #ifdef CONFIG_TREE_RCU
 	{
 		.procname	= "panic_on_rcu_stall",

-- 
2.47.2



