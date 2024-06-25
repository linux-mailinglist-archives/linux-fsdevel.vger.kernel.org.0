Return-Path: <linux-fsdevel+bounces-22444-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AC68917327
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 23:18:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE20D2831E7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 21:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC73E17E449;
	Tue, 25 Jun 2024 21:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BBr9RjEV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6598248D;
	Tue, 25 Jun 2024 21:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719350291; cv=none; b=UCln9QhRevJ/UYs8Js1oV8PKQFtzpyF6KkSP19wLLVDkYvVmw0SlCMOlCu+PM4io8HF2aPwmKIByFvm0sDmJFxpcSt4/LdAYwyt06/5CQzif83tr35tOsoPqjZ4IY9Zki7qhysWTM1vUGCAN02QDbQBUMGh6WBfPyrlF6n8nuBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719350291; c=relaxed/simple;
	bh=vQvaW5w0Li2SfcadZpOVHUJfaRsv8Eava3bSY/+NCHc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tjWSP2tgqV3v74wyAZfVZtuJeVfNPfET2DgM2YwMqaqMGjYMqSsMy9n+6lVx1j+f2Q38HIORLPEW8jd2RfPkYUJdq2zGlRI693OaTkC++77vJQ7Z4v+plUZKaaZ8eAXAoxkG9cgJKEAqVQek235Ab9B7LZ1uYih4+RdLotnOolU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BBr9RjEV; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=Sb6ACkUd4CO5RdUu78EWqLMX3GvyMHObHltD037Rayc=; b=BBr9RjEVVwqu90Ed0hi0+x4w01
	kqmaLJ4Bl67InK6HPYRGnHpmNIw2noKN7IOzFdkt+eDXXUlNRNaoTnqBix8N17Gb9LA/4l8WYSnsu
	ykkD9CoRCyITv4MfM34fQBYoILvlqKwdydyuSHbvXrDf24he1yuFgTuZ4A9jhGwJLFcoY/LGK4PYd
	9qrosdlGtXVRgzVdINZTjvJbD3/fbDHeF1uBex5h9PP6l0+U2PESah1nR+afnyZes6TPewobmdAUd
	8bjagjktUJoB2KV9lfK/4V28YX1RNRwHB8fNLhPmQaKD6Il3G1B+gJnwzwfS02DUJyupMDLGtfXXj
	WdeIoRTQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMDYE-0000000BXYI-2ylQ;
	Tue, 25 Jun 2024 21:18:07 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org,
	maple-tree@lists.infradead.org
Subject: [PATCH v2 1/5] tools: Add kernel stubs needed for rosebush
Date: Tue, 25 Jun 2024 22:17:56 +0100
Message-ID: <20240625211803.2750563-2-willy@infradead.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240625211803.2750563-1-willy@infradead.org>
References: <20240625211803.2750563-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Various parts of the kernel API didn't need to exist before, so add
them:

 - spin_trylock()
 - DECLARE_FLEX_ARRAY
 - vmalloc
 - __vmalloc_node
 - kvmalloc
 - kvfree_rcu_mightsleep

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 tools/include/linux/compiler.h           |  4 ++++
 tools/include/linux/compiler_types.h     |  2 ++
 tools/include/linux/spinlock.h           |  2 ++
 tools/include/linux/stddef.h             |  3 +++
 tools/testing/radix-tree/linux/kernel.h  |  2 ++
 tools/testing/radix-tree/linux/vmalloc.h | 14 ++++++++++++++
 6 files changed, 27 insertions(+)
 create mode 100644 tools/include/linux/stddef.h
 create mode 100644 tools/testing/radix-tree/linux/vmalloc.h

diff --git a/tools/include/linux/compiler.h b/tools/include/linux/compiler.h
index 8a63a9913495..936b5153b0fe 100644
--- a/tools/include/linux/compiler.h
+++ b/tools/include/linux/compiler.h
@@ -62,6 +62,10 @@
 #define __nocf_check __attribute__((nocf_check))
 #endif
 
+#ifndef __refdata
+#define __refdata
+#endif
+
 /* Are two types/vars the same type (ignoring qualifiers)? */
 #ifndef __same_type
 # define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
diff --git a/tools/include/linux/compiler_types.h b/tools/include/linux/compiler_types.h
index d09f9dc172a4..18bd8767cebc 100644
--- a/tools/include/linux/compiler_types.h
+++ b/tools/include/linux/compiler_types.h
@@ -17,6 +17,7 @@
 /* context/locking */
 # define __must_hold(x)	__attribute__((context(x,1,1)))
 # define __acquires(x)	__attribute__((context(x,0,1)))
+# define __cond_acquires(x) __attribute__((context(x,0,-1)))
 # define __releases(x)	__attribute__((context(x,1,0)))
 # define __acquire(x)	__context__(x,1)
 # define __release(x)	__context__(x,-1)
@@ -27,6 +28,7 @@
 # define __acquires(x)
 # define __releases(x)
 # define __acquire(x)	(void)0
+# define __cond_acquires(x)
 # define __release(x)	(void)0
 # define __cond_lock(x,c) (c)
 #endif /* __CHECKER__ */
diff --git a/tools/include/linux/spinlock.h b/tools/include/linux/spinlock.h
index a6cdf25b6b9d..871a6a305b9d 100644
--- a/tools/include/linux/spinlock.h
+++ b/tools/include/linux/spinlock.h
@@ -20,6 +20,8 @@
 #define spin_lock_irqsave(x, f)		(void)f, pthread_mutex_lock(x)
 #define spin_unlock_irqrestore(x, f)	(void)f, pthread_mutex_unlock(x)
 
+#define spin_trylock(x)			(pthread_mutex_trylock(x) == 0)
+
 #define arch_spinlock_t pthread_mutex_t
 #define __ARCH_SPIN_LOCK_UNLOCKED PTHREAD_MUTEX_INITIALIZER
 
diff --git a/tools/include/linux/stddef.h b/tools/include/linux/stddef.h
new file mode 100644
index 000000000000..337f520eba1d
--- /dev/null
+++ b/tools/include/linux/stddef.h
@@ -0,0 +1,3 @@
+#include <uapi/linux/stddef.h>
+
+#define DECLARE_FLEX_ARRAY(TYPE, NAME) __DECLARE_FLEX_ARRAY(TYPE, NAME)
diff --git a/tools/testing/radix-tree/linux/kernel.h b/tools/testing/radix-tree/linux/kernel.h
index c0a2bb785b92..72a95fd9708c 100644
--- a/tools/testing/radix-tree/linux/kernel.h
+++ b/tools/testing/radix-tree/linux/kernel.h
@@ -26,4 +26,6 @@
 #define __must_hold(x)
 
 #define EXPORT_PER_CPU_SYMBOL_GPL(x)
+
+#define PAGE_SIZE	4096
 #endif /* _KERNEL_H */
diff --git a/tools/testing/radix-tree/linux/vmalloc.h b/tools/testing/radix-tree/linux/vmalloc.h
new file mode 100644
index 000000000000..2857c37472bb
--- /dev/null
+++ b/tools/testing/radix-tree/linux/vmalloc.h
@@ -0,0 +1,14 @@
+#include <malloc.h>
+
+#define vmalloc(x)		malloc(x)
+#define __vmalloc_node(size, align, gfp, node, caller)	memalign(size, align)
+#define vfree(x)		free(x)
+
+#define kvmalloc(x, gfp)	memalign(x, x)
+#define kvfree(x)		free(x)
+
+/* A correct but slow implementation */
+#define kvfree_rcu_mightsleep(x)	{				\
+	synchronize_rcu();						\
+	free(x);							\
+}
-- 
2.43.0


