Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6208636FFB4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Apr 2021 19:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231630AbhD3RgY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Apr 2021 13:36:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58077 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231178AbhD3RgT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Apr 2021 13:36:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619804130;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qtmdW6EUUNczJ/CI6cxYgV8DuofmDzJc9V+euofp2eQ=;
        b=V8+SMLQozlLRQDD4A9mqtbOmo0JvNBq5nTwDzRY7DD+c6X72aAIRmTaGvT6ogeIroaakEU
        cOhWlo2zhvk+fdkD2JpcrxXvhnzx620beup3n8fAc+lnBySVuSKIUINrVz8WovB/VIRC4A
        XoyKnqvyFF3b23c5HLbHKXA1WvPVEOI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-516-Jrazkov1NPewOb0owEvikg-1; Fri, 30 Apr 2021 13:35:26 -0400
X-MC-Unique: Jrazkov1NPewOb0owEvikg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6FB6A801FD8;
        Fri, 30 Apr 2021 17:35:25 +0000 (UTC)
Received: from madcap2.tricolour.ca (unknown [10.3.128.45])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6DE2D2AE9A;
        Fri, 30 Apr 2021 17:35:09 +0000 (UTC)
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@parisplace.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Richard Guy Briggs <rgb@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Paris <eparis@redhat.com>, linux-fsdevel@vger.kernel.org,
        Aleksa Sarai <cyphar@cyphar.com>
Subject: [PATCH v2 3/3] audit: add OPENAT2 record to list how
Date:   Fri, 30 Apr 2021 13:29:37 -0400
Message-Id: <dc78151ab8563c04d6015d708c6fee7123e6ecb7.1619729297.git.rgb@redhat.com>
In-Reply-To: <cover.1619729297.git.rgb@redhat.com>
References: <cover.1619729297.git.rgb@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
---
 fs/open.c                  |  2 ++
 include/linux/audit.h      | 10 ++++++++++
 include/uapi/linux/audit.h |  1 +
 kernel/audit.h             |  2 ++
 kernel/auditsc.c           | 18 +++++++++++++++++-
 5 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/fs/open.c b/fs/open.c
index e53af13b5835..2a15bec0cf6d 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1235,6 +1235,8 @@ SYSCALL_DEFINE4(openat2, int, dfd, const char __user *, filename,
 	if (err)
 		return err;
 
+	audit_openat2_how(&tmp);
+
 	/* O_LARGEFILE is only allowed for non-O_PATH. */
 	if (!(tmp.flags & O_PATH) && force_o_largefile())
 		tmp.flags |= O_LARGEFILE;
diff --git a/include/linux/audit.h b/include/linux/audit.h
index 1137df4d4171..32095e1f5bac 100644
--- a/include/linux/audit.h
+++ b/include/linux/audit.h
@@ -399,6 +399,7 @@ extern int __audit_log_bprm_fcaps(struct linux_binprm *bprm,
 				  const struct cred *old);
 extern void __audit_log_capset(const struct cred *new, const struct cred *old);
 extern void __audit_mmap_fd(int fd, int flags);
+extern void __audit_openat2_how(struct open_how *how);
 extern void __audit_log_kern_module(char *name);
 extern void __audit_fanotify(unsigned int response);
 extern void __audit_tk_injoffset(struct timespec64 offset);
@@ -495,6 +496,12 @@ static inline void audit_mmap_fd(int fd, int flags)
 		__audit_mmap_fd(fd, flags);
 }
 
+static inline void audit_openat2_how(struct open_how *how)
+{
+	if (unlikely(!audit_dummy_context()))
+		__audit_openat2_how(how);
+}
+
 static inline void audit_log_kern_module(char *name)
 {
 	if (!audit_dummy_context())
@@ -646,6 +653,9 @@ static inline void audit_log_capset(const struct cred *new,
 static inline void audit_mmap_fd(int fd, int flags)
 { }
 
+static inline void audit_openat2_how(struct open_how *how)
+{ }
+
 static inline void audit_log_kern_module(char *name)
 {
 }
diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
index cd2d8279a5e4..67aea2370c6d 100644
--- a/include/uapi/linux/audit.h
+++ b/include/uapi/linux/audit.h
@@ -118,6 +118,7 @@
 #define AUDIT_TIME_ADJNTPVAL	1333	/* NTP value adjustment */
 #define AUDIT_BPF		1334	/* BPF subsystem */
 #define AUDIT_EVENT_LISTENER	1335	/* Task joined multicast read socket */
+#define AUDIT_OPENAT2		1336	/* Record showing openat2 how args */
 
 #define AUDIT_AVC		1400	/* SE Linux avc denial or grant */
 #define AUDIT_SELINUX_ERR	1401	/* Internal SE Linux Errors */
diff --git a/kernel/audit.h b/kernel/audit.h
index 1522e100fd17..c5af17905976 100644
--- a/kernel/audit.h
+++ b/kernel/audit.h
@@ -11,6 +11,7 @@
 #include <linux/skbuff.h>
 #include <uapi/linux/mqueue.h>
 #include <linux/tty.h>
+#include <uapi/linux/openat2.h> // struct open_how
 
 /* AUDIT_NAMES is the number of slots we reserve in the audit_context
  * for saving names from getname().  If we get more names we will allocate
@@ -185,6 +186,7 @@ struct audit_context {
 			int			fd;
 			int			flags;
 		} mmap;
+		struct open_how openat2;
 		struct {
 			int			argc;
 		} execve;
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 27c747e0d5ab..2e9a1eea8b12 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -76,7 +76,7 @@
 #include <linux/fsnotify_backend.h>
 #include <uapi/linux/limits.h>
 #include <uapi/linux/netfilter/nf_tables.h>
-#include <uapi/linux/openat2.h>
+#include <uapi/linux/openat2.h> // struct open_how
 
 #include "audit.h"
 
@@ -1310,6 +1310,12 @@ static void show_special(struct audit_context *context, int *call_panic)
 		audit_log_format(ab, "fd=%d flags=0x%x", context->mmap.fd,
 				 context->mmap.flags);
 		break;
+	case AUDIT_OPENAT2:
+		audit_log_format(ab, "oflag=0%llo mode=0%llo resolve=0x%llx",
+				 context->openat2.flags,
+				 context->openat2.mode,
+				 context->openat2.resolve);
+		break;
 	case AUDIT_EXECVE:
 		audit_log_execve_info(context, &ab);
 		break;
@@ -2529,6 +2535,16 @@ void __audit_mmap_fd(int fd, int flags)
 	context->type = AUDIT_MMAP;
 }
 
+void __audit_openat2_how(struct open_how *how)
+{
+	struct audit_context *context = audit_context();
+
+	context->openat2.flags = how->flags;
+	context->openat2.mode = how->mode;
+	context->openat2.resolve = how->resolve;
+	context->type = AUDIT_OPENAT2;
+}
+
 void __audit_log_kern_module(char *name)
 {
 	struct audit_context *context = audit_context();
-- 
2.27.0

