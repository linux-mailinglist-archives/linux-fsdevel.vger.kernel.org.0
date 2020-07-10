Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50DE921B0C8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jul 2020 09:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbgGJH4m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Jul 2020 03:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726560AbgGJH4l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Jul 2020 03:56:41 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAB0EC08C5CE
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jul 2020 00:56:40 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id k15so2681329lfc.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jul 2020 00:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZXcbxwgnNdN6AgFOPfHDAbPj/lmoR2tjjqmqpya8o/k=;
        b=M4g7tke+QMNS6x69qNRAFRRs2OoINGT4rqJVDko7GDKiHHusV9GiXnYqVIxiQp51x2
         M/fXV8G16zmHM57h6KEORDkR8Iis4QYoObo7XjmhehmLjOI+InV7Eig/X/axf2d6m/DN
         BgAyP9luxsKIJPW9ZEa9RkDRgeqdwe2IeW0yE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZXcbxwgnNdN6AgFOPfHDAbPj/lmoR2tjjqmqpya8o/k=;
        b=k65+4hGf8nHvXCoXVAyV0KH1vWVfuejiflp3zU0cO7kh+qThaJ0j7XFzGtq/BI0x+7
         3L7sgPkH6fJo2/5RsI1PZmEQccyvcD4CSafGSdIg5CBfJfqkNuljWQFkosOb5nVkaOIq
         DRSf1LkupT67L2JR+ROGbrjXDXKByg5/nNG9+dkV/mWsgaWM4ZsTgkke+E/uQ7UI4qqk
         Er9cB7FHEKuLu7mJkM4Sr4hMqjBO3MTRTE95YWQa59d/Do0oeTuBq34ApKRkKEiuSGdV
         dBFMkRt2Yh6152jNsDt4Yifd3ajXbzzZ0J9CXFXVSKPIMNTs+Xe3f8yiQoZOa7jtAf0P
         OCng==
X-Gm-Message-State: AOAM532PGxDct3khiPiA3wpV5S9V6mXOU1uNXC7vlspmQNemeRA4TeWY
        Mp8izGsvTIDOIbyZ7MUGo7fsiw==
X-Google-Smtp-Source: ABdhPJwLXd9N89jj8OkZWkL9WrDn9m+IDjaPdKXVOLaUH/xRC7rpgvaiSvc5ePtH3hMM3iAG0b0UgQ==
X-Received: by 2002:a19:8307:: with SMTP id f7mr42333880lfd.174.1594367799309;
        Fri, 10 Jul 2020 00:56:39 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id f18sm1634609ljn.73.2020.07.10.00.56.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 00:56:38 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Cyrill Gorcunov <gorcunov@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] kcmp: add separate Kconfig symbol for kcmp syscall
Date:   Fri, 10 Jul 2020 09:56:31 +0200
Message-Id: <20200710075632.14661-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The ability to check open file descriptions for equality (without
resorting to unreliable fstat() and fcntl(F_GETFL) comparisons) can be
useful outside of the checkpoint/restore use case - for example,
systemd uses kcmp() to deduplicate the per-service file descriptor
store.

Make it possible to have the kcmp() syscall without the full
CONFIG_CHECKPOINT_RESTORE.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
I deliberately drop the ifdef in the eventpoll.h header rather than
replace with KCMP_SYSCALL; it's harmless to declare a function that
isn't defined anywhere.

 fs/eventpoll.c            |  4 ++--
 include/linux/eventpoll.h |  2 --
 init/Kconfig              | 11 +++++++++++
 kernel/Makefile           |  2 +-
 4 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 12eebcdea9c8..b0313ce2df73 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -1064,7 +1064,7 @@ static struct epitem *ep_find(struct eventpoll *ep, struct file *file, int fd)
 	return epir;
 }
 
-#ifdef CONFIG_CHECKPOINT_RESTORE
+#ifdef CONFIG_KCMP_SYSCALL
 static struct epitem *ep_find_tfd(struct eventpoll *ep, int tfd, unsigned long toff)
 {
 	struct rb_node *rbp;
@@ -1106,7 +1106,7 @@ struct file *get_epoll_tfile_raw_ptr(struct file *file, int tfd,
 
 	return file_raw;
 }
-#endif /* CONFIG_CHECKPOINT_RESTORE */
+#endif /* CONFIG_KCMP_SYSCALL */
 
 /**
  * Adds a new entry to the tail of the list in a lockless way, i.e.
diff --git a/include/linux/eventpoll.h b/include/linux/eventpoll.h
index 8f000fada5a4..aa799295e373 100644
--- a/include/linux/eventpoll.h
+++ b/include/linux/eventpoll.h
@@ -18,9 +18,7 @@ struct file;
 
 #ifdef CONFIG_EPOLL
 
-#ifdef CONFIG_CHECKPOINT_RESTORE
 struct file *get_epoll_tfile_raw_ptr(struct file *file, int tfd, unsigned long toff);
-#endif
 
 /* Used to initialize the epoll bits inside the "struct file" */
 static inline void eventpoll_init_file(struct file *file)
diff --git a/init/Kconfig b/init/Kconfig
index 0498af567f70..95e9486d4217 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1158,9 +1158,20 @@ config NET_NS
 
 endif # NAMESPACES
 
+config KCMP_SYSCALL
+	bool "kcmp system call"
+	help
+	  Enable the kcmp system call, which allows one to determine
+	  whether to tasks share various kernel resources, for example
+	  whether they share address space, or if two file descriptors
+	  refer to the same open file description.
+
+	  If unsure, say N.
+
 config CHECKPOINT_RESTORE
 	bool "Checkpoint/restore support"
 	select PROC_CHILDREN
+	select KCMP_SYSCALL
 	default n
 	help
 	  Enables additional kernel features in a sake of checkpoint/restore.
diff --git a/kernel/Makefile b/kernel/Makefile
index f3218bc5ec69..3daedba2146a 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -49,7 +49,7 @@ obj-y += rcu/
 obj-y += livepatch/
 obj-y += dma/
 
-obj-$(CONFIG_CHECKPOINT_RESTORE) += kcmp.o
+obj-$(CONFIG_KCMP_SYSCALL) += kcmp.o
 obj-$(CONFIG_FREEZER) += freezer.o
 obj-$(CONFIG_PROFILING) += profile.o
 obj-$(CONFIG_STACKTRACE) += stacktrace.o
-- 
2.23.0

