Return-Path: <linux-fsdevel+bounces-6285-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 018148156FE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Dec 2023 04:36:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32F161C248FD
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Dec 2023 03:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F02441236;
	Sat, 16 Dec 2023 03:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eZB1hQbw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25BD540BEB
	for <linux-fsdevel@vger.kernel.org>; Sat, 16 Dec 2023 03:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702697614;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X87VjxlUd18l9kDwUL6NaoqByTrZMfLVDHgwYnIbMw0=;
	b=eZB1hQbwqfmiZUO+79GfWV0LuKKMJ6JKSkbeassQpJlaB2P+Rb0z4HWp9m5kghK/zTCFRw
	vJRY1U00mr95LX29azmSiTsBvVEZYNGSLwTZ3UuvgDMDz5Oy95eu5Tdx/+nO15FNRWWMvP
	5ry/UrjcV1NmicWNvaiu6kQTbR+GEOY=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
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
	brauner@kernel.org
Subject: [PATCH 41/50] uidgid: Split out uidgid_types.h
Date: Fri, 15 Dec 2023 22:32:47 -0500
Message-ID: <20231216033300.3553457-9-kent.overstreet@linux.dev>
In-Reply-To: <20231216033300.3553457-1-kent.overstreet@linux.dev>
References: <20231216024834.3510073-1-kent.overstreet@linux.dev>
 <20231216033300.3553457-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

More sched.h dependency pruning.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 include/linux/sched.h        |  1 +
 include/linux/uidgid.h       | 11 +----------
 include/linux/uidgid_types.h | 15 +++++++++++++++
 3 files changed, 17 insertions(+), 10 deletions(-)
 create mode 100644 include/linux/uidgid_types.h

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 9bfa61ab2750..157e7af36bb7 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -37,6 +37,7 @@
 #include <linux/kcsan.h>
 #include <linux/rv.h>
 #include <linux/livepatch_sched.h>
+#include <linux/uidgid_types.h>
 #include <asm/kmap_size.h>
 
 /* task_struct member predeclarations (sorted alphabetically): */
diff --git a/include/linux/uidgid.h b/include/linux/uidgid.h
index b0542cd11aeb..ba20b62f13e1 100644
--- a/include/linux/uidgid.h
+++ b/include/linux/uidgid.h
@@ -12,21 +12,12 @@
  * to detect when we overlook these differences.
  *
  */
-#include <linux/types.h>
+#include <linux/uidgid_types.h>
 #include <linux/highuid.h>
 
 struct user_namespace;
 extern struct user_namespace init_user_ns;
 
-typedef struct {
-	uid_t val;
-} kuid_t;
-
-
-typedef struct {
-	gid_t val;
-} kgid_t;
-
 #define KUIDT_INIT(value) (kuid_t){ value }
 #define KGIDT_INIT(value) (kgid_t){ value }
 
diff --git a/include/linux/uidgid_types.h b/include/linux/uidgid_types.h
new file mode 100644
index 000000000000..b35ac4955a33
--- /dev/null
+++ b/include/linux/uidgid_types.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_UIDGID_TYPES_H
+#define _LINUX_UIDGID_TYPES_H
+
+#include <linux/types.h>
+
+typedef struct {
+	uid_t val;
+} kuid_t;
+
+typedef struct {
+	gid_t val;
+} kgid_t;
+
+#endif /* _LINUX_UIDGID_TYPES_H */
-- 
2.43.0


