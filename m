Return-Path: <linux-fsdevel+bounces-6275-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E53A8156E9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Dec 2023 04:33:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58809B21A06
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Dec 2023 03:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B123307C;
	Sat, 16 Dec 2023 03:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Xy8STZZD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328502D788
	for <linux-fsdevel@vger.kernel.org>; Sat, 16 Dec 2023 03:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702697423;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4LN+fvuL5eeNR/VPNkxK0aRm1LVsQsiIk1+jyA5Xy5c=;
	b=Xy8STZZDVdZuXXrC81y0mDfKavQQ2OsvnlwBdfdk/NBXkbjQnS0aa+hU9xi+XbObTcpPSv
	QM/BrJstbhqYuJfsOFrrHDTzE/XtnsyxrBYi935HCxJo/kLSk4vECtaGsYgElYOBdmOjz4
	S/mWnNfeu0pQbzKb7Sz+7MydM4f0wIM=
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
Subject: [PATCH 31/50] shm: Slim down dependencies
Date: Fri, 15 Dec 2023 22:29:37 -0500
Message-ID: <20231216032957.3553313-10-kent.overstreet@linux.dev>
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

list_head is in types.h, not list.h., and the uapi header wasn't needed.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 include/linux/shm.h        | 4 ++--
 ipc/shm.c                  | 1 +
 security/selinux/hooks.c   | 1 +
 security/smack/smack_lsm.c | 1 +
 4 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/linux/shm.h b/include/linux/shm.h
index d8e69aed3d32..c55bef0538e5 100644
--- a/include/linux/shm.h
+++ b/include/linux/shm.h
@@ -2,12 +2,12 @@
 #ifndef _LINUX_SHM_H_
 #define _LINUX_SHM_H_
 
-#include <linux/list.h>
+#include <linux/types.h>
 #include <asm/page.h>
-#include <uapi/linux/shm.h>
 #include <asm/shmparam.h>
 
 struct file;
+struct task_struct;
 
 #ifdef CONFIG_SYSVIPC
 struct sysv_shm {
diff --git a/ipc/shm.c b/ipc/shm.c
index 222aaf035afb..a89f001a8bf0 100644
--- a/ipc/shm.c
+++ b/ipc/shm.c
@@ -29,6 +29,7 @@
 #include <linux/mm.h>
 #include <linux/hugetlb.h>
 #include <linux/shm.h>
+#include <uapi/linux/shm.h>
 #include <linux/init.h>
 #include <linux/file.h>
 #include <linux/mman.h>
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index feda711c6b7b..b9ccc98421e9 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -85,6 +85,7 @@
 #include <linux/export.h>
 #include <linux/msg.h>
 #include <linux/shm.h>
+#include <uapi/linux/shm.h>
 #include <linux/bpf.h>
 #include <linux/kernfs.h>
 #include <linux/stringhash.h>	/* for hashlen_string() */
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 65130a791f57..7a5600834f16 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -37,6 +37,7 @@
 #include <linux/personality.h>
 #include <linux/msg.h>
 #include <linux/shm.h>
+#include <uapi/linux/shm.h>
 #include <linux/binfmts.h>
 #include <linux/parser.h>
 #include <linux/fs_context.h>
-- 
2.43.0


