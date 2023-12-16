Return-Path: <linux-fsdevel+bounces-6269-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93A958156DC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Dec 2023 04:31:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C69301C24953
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Dec 2023 03:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29875156EE;
	Sat, 16 Dec 2023 03:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BT9Ag6IZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06AC4134C4
	for <linux-fsdevel@vger.kernel.org>; Sat, 16 Dec 2023 03:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702697412;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BWWbNWB6VpQ4v6HXE97z0y+8sBKzqDJYsJkDQq7GMzU=;
	b=BT9Ag6IZF8G1irnOMIJzzmo2Vm7P/PbA51fsRpCFyMHM7GkF/KyOo7s5nF5ZUtg9mtgohM
	MnPdk+4WGq9bmhVq5Z8iwMdIf+sOgRsg9c57jBEdlN65RQArj8/UnDj+5G7LOogiGRFx7P
	rWWZWziTLjPAuIQlwfGV05WGcaXEg4U=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	tglx@linutronix.de,
	x86@kernel.org,
	tj@kernel.org,
	peterz@infradead.org,
	mathieu.desnoyers@efficios.com,
	paulmck@kernel.org,
	keescook@chromium.org,
	dave.hansen@linux.intel.com,
	mingo@redhat.com,
	will@kernel.org,
	longman@redhat.com,
	boqun.feng@gmail.com,
	brauner@kernel.org,
	Kent Overstreet <kent.overstreet@linux.dev>
Subject: [PATCH 25/50] wait: Remove uapi header file from main header file
Date: Fri, 15 Dec 2023 22:29:31 -0500
Message-ID: <20231216032957.3553313-4-kent.overstreet@linux.dev>
In-Reply-To: <20231216032957.3553313-1-kent.overstreet@linux.dev>
References: <20231216024834.3510073-1-kent.overstreet@linux.dev>
 <20231216032957.3553313-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

There's really no overlap between uapi/linux/wait.h and linux/wait.h.
There are two files which rely on the uapi file being implcitly included,
so explicitly include it there and remove it from the main header file.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 include/linux/wait.h   | 1 -
 kernel/exit.c          | 4 +++-
 kernel/pid_namespace.c | 1 +
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/linux/wait.h b/include/linux/wait.h
index 3473b663176f..8aa3372f21a0 100644
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -9,7 +9,6 @@
 #include <linux/spinlock.h>
 
 #include <asm/current.h>
-#include <uapi/linux/wait.h>
 
 typedef struct wait_queue_entry wait_queue_entry_t;
 
diff --git a/kernel/exit.c b/kernel/exit.c
index ee9f43bed49a..2ef33047371b 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -69,8 +69,10 @@
 #include <linux/rethook.h>
 #include <linux/sysfs.h>
 #include <linux/user_events.h>
-
 #include <linux/uaccess.h>
+
+#include <uapi/linux/wait.h>
+
 #include <asm/unistd.h>
 #include <asm/mmu_context.h>
 
diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
index 3028b2218aa4..7ade20e95232 100644
--- a/kernel/pid_namespace.c
+++ b/kernel/pid_namespace.c
@@ -23,6 +23,7 @@
 #include <linux/sched/task.h>
 #include <linux/sched/signal.h>
 #include <linux/idr.h>
+#include <uapi/linux/wait.h>
 #include "pid_sysctl.h"
 
 static DEFINE_MUTEX(pid_caches_mutex);
-- 
2.43.0


