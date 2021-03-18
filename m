Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22110340519
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Mar 2021 13:04:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbhCRMDs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Mar 2021 08:03:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33124 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230087AbhCRMDT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Mar 2021 08:03:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616068998;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/vPKCoiDPoFI6ICIDGTdBmYwxJqY/6shlgvtk4TVorQ=;
        b=L0uDBMsGo/QEb/vdEnxOSRz/GLhbSnwlDTpPZii5VK6P+6hHPjC9uU6B+5nMElvTGwwXDG
        K/3OQfuAO0bH+2KXVa01qqirWhEgq5ridxmNQ1KkDDSA0HijyoLuwLwddgrPUm9mAgMdVQ
        CrQBAfg6FsLIyKIEDJeK2TngUXhIpPA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-367-pG7kQ59TNaC9nRMDyf0p8w-1; Thu, 18 Mar 2021 08:03:13 -0400
X-MC-Unique: pG7kQ59TNaC9nRMDyf0p8w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 17E1C190A7A2;
        Thu, 18 Mar 2021 12:03:11 +0000 (UTC)
Received: from madcap2.tricolour.ca (unknown [10.10.110.12])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A7D365D6A8;
        Thu, 18 Mar 2021 12:03:06 +0000 (UTC)
Date:   Thu, 18 Mar 2021 08:03:04 -0400
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@parisplace.org>,
        Steve Grubb <sgrubb@redhat.com>, x86@kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Paris <eparis@redhat.com>, linux-alpha@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Aleksa Sarai <cyphar@cyphar.com>
Subject: Re: [PATCH 1/2] audit: add support for the openat2 syscall
Message-ID: <20210318120304.GJ3141668@madcap2.tricolour.ca>
References: <cover.1616031035.git.rgb@redhat.com>
 <49510cacfb5fbbaa312a4a389f3a6619675007ab.1616031035.git.rgb@redhat.com>
 <20210318104843.uiga6tmmhn5wfhbs@wittgenstein>
 <20210318105230.4ggpg5r3clloa6br@wittgenstein>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="f2QGlHpHGjS2mn6Y"
Content-Disposition: inline
In-Reply-To: <20210318105230.4ggpg5r3clloa6br@wittgenstein>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--f2QGlHpHGjS2mn6Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 2021-03-18 11:52, Christian Brauner wrote:
> On Thu, Mar 18, 2021 at 11:48:45AM +0100, Christian Brauner wrote:
> > On Wed, Mar 17, 2021 at 09:47:17PM -0400, Richard Guy Briggs wrote:
> > > The openat2(2) syscall was added in kernel v5.6 with commit fddb5d430ad9
> > > ("open: introduce openat2(2) syscall")
> > > Add the openat2(2) syscall to the audit syscall classifier.
> > > See the github issue
> > > https://github.com/linux-audit/audit-kernel/issues/67
> > > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>

...

> And one more comment, why return a hard-coded integer from all of these
> architectures instead of introducing an enum in a central place with
> proper names idk:

Oh, believe me, I tried hard to do that because I really don't like
hard-coded magic values, but for expediency I continued the same
approach until I could sort out the header file mess.  There was an
extra preparatory patch (attached) in this patchset with a different
audit syscall perms patch (also attached).  By including "#include
<linux/audit.h>" in each of the compat source files there were warnings
of redefinitions of every __NR_* syscall number.  The easiest way to get
rid of it would have been to pull the new AUDITSC_* definitions into a
new <linux/auditsc.h> file and include that from <linux/audit.h> and
each of the arch/*/*/*audit.c (and lib/*audit.c) files.

> enum audit_match_perm_t {
> 	.
> 	.
> 	.
> 	AUDIT_MATCH_PERM_EXECVE = 5,
> 	AUDIT_MATCH_PERM_OPENAT2 = 6,
> 	.
> 	.
> 	.
> }
> 
> Then you can drop these hard-coded comments too and it's way less
> brittle overall.

Totally agree.

> Christian

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635

--f2QGlHpHGjS2mn6Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="0001-audit-replace-magic-audit-syscall-class-numbers-with.patch"

From 599ae48091296a3ad3eb4259e7af39cdf0f743c7 Mon Sep 17 00:00:00 2001
Message-Id: <599ae48091296a3ad3eb4259e7af39cdf0f743c7.1616067847.git.rgb@redhat.com>
In-Reply-To: <cover.1616067847.git.rgb@redhat.com>
References: <cover.1616067847.git.rgb@redhat.com>
From: Richard Guy Briggs <rgb@redhat.com>
Date: Fri, 22 Jan 2021 16:27:42 -0500
Subject: [PATCH 1/3] audit: replace magic audit syscall class numbers with
 macros

Replace the magic numbers used to indicate audit syscall classes with macros.

Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
---
 arch/alpha/kernel/audit.c          |  8 ++++----
 arch/ia64/kernel/audit.c           |  8 ++++----
 arch/parisc/kernel/audit.c         |  8 ++++----
 arch/parisc/kernel/compat_audit.c  |  9 +++++----
 arch/powerpc/kernel/audit.c        | 10 +++++-----
 arch/powerpc/kernel/compat_audit.c | 11 ++++++-----
 arch/s390/kernel/audit.c           | 10 +++++-----
 arch/s390/kernel/compat_audit.c    | 11 ++++++-----
 arch/sparc/kernel/audit.c          | 10 +++++-----
 arch/sparc/kernel/compat_audit.c   | 11 ++++++-----
 arch/x86/ia32/audit.c              | 11 ++++++-----
 arch/x86/kernel/audit_64.c         |  8 ++++----
 include/linux/audit.h              |  7 +++++++
 kernel/auditsc.c                   | 12 ++++++------
 lib/audit.c                        | 10 +++++-----
 lib/compat_audit.c                 | 11 ++++++-----
 16 files changed, 84 insertions(+), 71 deletions(-)

diff --git a/arch/alpha/kernel/audit.c b/arch/alpha/kernel/audit.c
index 96a9d18ff4c4..81cbd804e375 100644
--- a/arch/alpha/kernel/audit.c
+++ b/arch/alpha/kernel/audit.c
@@ -37,13 +37,13 @@ int audit_classify_syscall(int abi, unsigned syscall)
 {
 	switch(syscall) {
 	case __NR_open:
-		return 2;
+		return AUDITSC_OPEN;
 	case __NR_openat:
-		return 3;
+		return AUDITSC_OPENAT;
 	case __NR_execve:
-		return 5;
+		return AUDITSC_EXECVE;
 	default:
-		return 0;
+		return AUDITSC_NATIVE;
 	}
 }
 
diff --git a/arch/ia64/kernel/audit.c b/arch/ia64/kernel/audit.c
index 5192ca899fe6..dba6a74c9ab3 100644
--- a/arch/ia64/kernel/audit.c
+++ b/arch/ia64/kernel/audit.c
@@ -38,13 +38,13 @@ int audit_classify_syscall(int abi, unsigned syscall)
 {
 	switch(syscall) {
 	case __NR_open:
-		return 2;
+		return AUDITSC_OPEN;
 	case __NR_openat:
-		return 3;
+		return AUDITSC_OPENAT;
 	case __NR_execve:
-		return 5;
+		return AUDITSC_EXECVE;
 	default:
-		return 0;
+		return AUDITSC_NATIVE;
 	}
 }
 
diff --git a/arch/parisc/kernel/audit.c b/arch/parisc/kernel/audit.c
index 9eb47b2225d2..14244e83db75 100644
--- a/arch/parisc/kernel/audit.c
+++ b/arch/parisc/kernel/audit.c
@@ -47,13 +47,13 @@ int audit_classify_syscall(int abi, unsigned syscall)
 #endif
 	switch (syscall) {
 	case __NR_open:
-		return 2;
+		return AUDITSC_OPEN;
 	case __NR_openat:
-		return 3;
+		return AUDITSC_OPENAT;
 	case __NR_execve:
-		return 5;
+		return AUDITSC_EXECVE;
 	default:
-		return 0;
+		return AUDITSC_NATIVE;
 	}
 }
 
diff --git a/arch/parisc/kernel/compat_audit.c b/arch/parisc/kernel/compat_audit.c
index 20c39c9d86a9..68102807aba7 100644
--- a/arch/parisc/kernel/compat_audit.c
+++ b/arch/parisc/kernel/compat_audit.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <linux/audit.h>
 #include <asm/unistd.h>
 
 unsigned int parisc32_dir_class[] = {
@@ -30,12 +31,12 @@ int parisc32_classify_syscall(unsigned syscall)
 {
 	switch (syscall) {
 	case __NR_open:
-		return 2;
+		return AUDITSC_OPEN;
 	case __NR_openat:
-		return 3;
+		return AUDITSC_OPENAT;
 	case __NR_execve:
-		return 5;
+		return AUDITSC_EXECVE;
 	default:
-		return 1;
+		return AUDITSC_COMPAT;
 	}
 }
diff --git a/arch/powerpc/kernel/audit.c b/arch/powerpc/kernel/audit.c
index a2dddd7f3d09..6eb18ef77dff 100644
--- a/arch/powerpc/kernel/audit.c
+++ b/arch/powerpc/kernel/audit.c
@@ -47,15 +47,15 @@ int audit_classify_syscall(int abi, unsigned syscall)
 #endif
 	switch(syscall) {
 	case __NR_open:
-		return 2;
+		return AUDITSC_OPEN;
 	case __NR_openat:
-		return 3;
+		return AUDITSC_OPENAT;
 	case __NR_socketcall:
-		return 4;
+		return AUDITSC_SOCKETCALL;
 	case __NR_execve:
-		return 5;
+		return AUDITSC_EXECVE;
 	default:
-		return 0;
+		return AUDITSC_NATIVE;
 	}
 }
 
diff --git a/arch/powerpc/kernel/compat_audit.c b/arch/powerpc/kernel/compat_audit.c
index 55c6ccda0a85..b3fd2d43bfff 100644
--- a/arch/powerpc/kernel/compat_audit.c
+++ b/arch/powerpc/kernel/compat_audit.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #undef __powerpc64__
+#include <linux/audit.h>
 #include <asm/unistd.h>
 
 unsigned ppc32_dir_class[] = {
@@ -31,14 +32,14 @@ int ppc32_classify_syscall(unsigned syscall)
 {
 	switch(syscall) {
 	case __NR_open:
-		return 2;
+		return AUDITSC_OPEN;
 	case __NR_openat:
-		return 3;
+		return AUDITSC_OPENAT;
 	case __NR_socketcall:
-		return 4;
+		return AUDITSC_SOCKETCALL;
 	case __NR_execve:
-		return 5;
+		return AUDITSC_EXECVE;
 	default:
-		return 1;
+		return AUDITSC_COMPAT;
 	}
 }
diff --git a/arch/s390/kernel/audit.c b/arch/s390/kernel/audit.c
index d395c6c9944c..7e331e1831d4 100644
--- a/arch/s390/kernel/audit.c
+++ b/arch/s390/kernel/audit.c
@@ -47,15 +47,15 @@ int audit_classify_syscall(int abi, unsigned syscall)
 #endif
 	switch(syscall) {
 	case __NR_open:
-		return 2;
+		return AUDITSC_OPEN;
 	case __NR_openat:
-		return 3;
+		return AUDITSC_OPENAT;
 	case __NR_socketcall:
-		return 4;
+		return AUDITSC_SOCKETCALL;
 	case __NR_execve:
-		return 5;
+		return AUDITSC_EXECVE;
 	default:
-		return 0;
+		return AUDITSC_NATIVE;
 	}
 }
 
diff --git a/arch/s390/kernel/compat_audit.c b/arch/s390/kernel/compat_audit.c
index 444fb1f66944..704d04cfd9dd 100644
--- a/arch/s390/kernel/compat_audit.c
+++ b/arch/s390/kernel/compat_audit.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #undef __s390x__
+#include <linux/audit.h>
 #include <asm/unistd.h>
 #include "audit.h"
 
@@ -32,14 +33,14 @@ int s390_classify_syscall(unsigned syscall)
 {
 	switch(syscall) {
 	case __NR_open:
-		return 2;
+		return AUDITSC_OPEN;
 	case __NR_openat:
-		return 3;
+		return AUDITSC_OPENAT;
 	case __NR_socketcall:
-		return 4;
+		return AUDITSC_SOCKETCALL;
 	case __NR_execve:
-		return 5;
+		return AUDITSC_EXECVE;
 	default:
-		return 1;
+		return AUDITSC_COMPAT;
 	}
 }
diff --git a/arch/sparc/kernel/audit.c b/arch/sparc/kernel/audit.c
index a6e91bf34d48..50fab35bdaba 100644
--- a/arch/sparc/kernel/audit.c
+++ b/arch/sparc/kernel/audit.c
@@ -48,15 +48,15 @@ int audit_classify_syscall(int abi, unsigned int syscall)
 #endif
 	switch(syscall) {
 	case __NR_open:
-		return 2;
+		return AUDITSC_OPEN;
 	case __NR_openat:
-		return 3;
+		return AUDITSC_OPENAT;
 	case __NR_socketcall:
-		return 4;
+		return AUDITSC_SOCKETCALL;
 	case __NR_execve:
-		return 5;
+		return AUDITSC_EXECVE;
 	default:
-		return 0;
+		return AUDITSC_NATIVE;
 	}
 }
 
diff --git a/arch/sparc/kernel/compat_audit.c b/arch/sparc/kernel/compat_audit.c
index 10eeb4f15b20..4c2f9a4ee845 100644
--- a/arch/sparc/kernel/compat_audit.c
+++ b/arch/sparc/kernel/compat_audit.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #define __32bit_syscall_numbers__
+#include <linux/audit.h>
 #include <asm/unistd.h>
 #include "kernel.h"
 
@@ -32,14 +33,14 @@ int sparc32_classify_syscall(unsigned int syscall)
 {
 	switch(syscall) {
 	case __NR_open:
-		return 2;
+		return AUDITSC_OPEN;
 	case __NR_openat:
-		return 3;
+		return AUDITSC_OPENAT;
 	case __NR_socketcall:
-		return 4;
+		return AUDITSC_SOCKETCALL;
 	case __NR_execve:
-		return 5;
+		return AUDITSC_EXECVE;
 	default:
-		return 1;
+		return AUDITSC_COMPAT;
 	}
 }
diff --git a/arch/x86/ia32/audit.c b/arch/x86/ia32/audit.c
index 6efe6cb3768a..0798a6b66314 100644
--- a/arch/x86/ia32/audit.c
+++ b/arch/x86/ia32/audit.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <linux/audit.h>
 #include <asm/unistd_32.h>
 #include <asm/audit.h>
 
@@ -31,15 +32,15 @@ int ia32_classify_syscall(unsigned syscall)
 {
 	switch (syscall) {
 	case __NR_open:
-		return 2;
+		return AUDITSC_OPEN;
 	case __NR_openat:
-		return 3;
+		return AUDITSC_OPENAT;
 	case __NR_socketcall:
-		return 4;
+		return AUDITSC_SOCKETCALL;
 	case __NR_execve:
 	case __NR_execveat:
-		return 5;
+		return AUDITSC_EXECVE;
 	default:
-		return 1;
+		return AUDITSC_COMPAT;
 	}
 }
diff --git a/arch/x86/kernel/audit_64.c b/arch/x86/kernel/audit_64.c
index 83d9cad4e68b..2a6cc9c9c881 100644
--- a/arch/x86/kernel/audit_64.c
+++ b/arch/x86/kernel/audit_64.c
@@ -47,14 +47,14 @@ int audit_classify_syscall(int abi, unsigned syscall)
 #endif
 	switch(syscall) {
 	case __NR_open:
-		return 2;
+		return AUDITSC_OPEN;
 	case __NR_openat:
-		return 3;
+		return AUDITSC_OPENAT;
 	case __NR_execve:
 	case __NR_execveat:
-		return 5;
+		return AUDITSC_EXECVE;
 	default:
-		return 0;
+		return AUDITSC_NATIVE;
 	}
 }
 
diff --git a/include/linux/audit.h b/include/linux/audit.h
index 82b7c1116a85..bcf0150b1528 100644
--- a/include/linux/audit.h
+++ b/include/linux/audit.h
@@ -120,6 +120,13 @@ enum audit_nfcfgop {
 
 extern int is_audit_feature_set(int which);
 
+#define AUDITSC_NATIVE		0
+#define AUDITSC_COMPAT		1
+#define AUDITSC_OPEN		2
+#define AUDITSC_OPENAT		3
+#define AUDITSC_SOCKETCALL	4
+#define AUDITSC_EXECVE		5
+
 extern int __init audit_register_class(int class, unsigned *list);
 extern int audit_classify_syscall(int abi, unsigned syscall);
 extern int audit_classify_arch(int arch);
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 71ead2969eeb..dddea985f23e 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -165,7 +165,7 @@ static int audit_match_perm(struct audit_context *ctx, int mask)
 	n = ctx->major;
 
 	switch (audit_classify_syscall(ctx->arch, n)) {
-	case 0:	/* native */
+	case AUDITSC_NATIVE:
 		if ((mask & AUDIT_PERM_WRITE) &&
 		     audit_match_class(AUDIT_CLASS_WRITE, n))
 			return 1;
@@ -176,7 +176,7 @@ static int audit_match_perm(struct audit_context *ctx, int mask)
 		     audit_match_class(AUDIT_CLASS_CHATTR, n))
 			return 1;
 		return 0;
-	case 1: /* 32bit on biarch */
+	case AUDITSC_COMPAT: /* 32bit on biarch */
 		if ((mask & AUDIT_PERM_WRITE) &&
 		     audit_match_class(AUDIT_CLASS_WRITE_32, n))
 			return 1;
@@ -187,13 +187,13 @@ static int audit_match_perm(struct audit_context *ctx, int mask)
 		     audit_match_class(AUDIT_CLASS_CHATTR_32, n))
 			return 1;
 		return 0;
-	case 2: /* open */
+	case AUDITSC_OPEN:
 		return mask & ACC_MODE(ctx->argv[1]);
-	case 3: /* openat */
+	case AUDITSC_OPENAT:
 		return mask & ACC_MODE(ctx->argv[2]);
-	case 4: /* socketcall */
+	case AUDITSC_SOCKETCALL:
 		return ((mask & AUDIT_PERM_WRITE) && ctx->argv[0] == SYS_BIND);
-	case 5: /* execve */
+	case AUDITSC_EXECVE:
 		return mask & AUDIT_PERM_EXEC;
 	default:
 		return 0;
diff --git a/lib/audit.c b/lib/audit.c
index 5004bff928a7..3ec1a94d8d64 100644
--- a/lib/audit.c
+++ b/lib/audit.c
@@ -45,23 +45,23 @@ int audit_classify_syscall(int abi, unsigned syscall)
 	switch(syscall) {
 #ifdef __NR_open
 	case __NR_open:
-		return 2;
+		return AUDITSC_OPEN;
 #endif
 #ifdef __NR_openat
 	case __NR_openat:
-		return 3;
+		return AUDITSC_OPENAT;
 #endif
 #ifdef __NR_socketcall
 	case __NR_socketcall:
-		return 4;
+		return AUDITSC_SOCKETCALL;
 #endif
 #ifdef __NR_execveat
 	case __NR_execveat:
 #endif
 	case __NR_execve:
-		return 5;
+		return AUDITSC_EXECVE;
 	default:
-		return 0;
+		return AUDITSC_NATIVE;
 	}
 }
 
diff --git a/lib/compat_audit.c b/lib/compat_audit.c
index 77eabad69b4a..528dafa2c2bb 100644
--- a/lib/compat_audit.c
+++ b/lib/compat_audit.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/init.h>
 #include <linux/types.h>
+#include <linux/audit.h>
 #include <asm/unistd32.h>
 
 unsigned compat_dir_class[] = {
@@ -33,19 +34,19 @@ int audit_classify_compat_syscall(int abi, unsigned syscall)
 	switch (syscall) {
 #ifdef __NR_open
 	case __NR_open:
-		return 2;
+		return AUDITSC_OPEN;
 #endif
 #ifdef __NR_openat
 	case __NR_openat:
-		return 3;
+		return AUDITSC_OPENAT;
 #endif
 #ifdef __NR_socketcall
 	case __NR_socketcall:
-		return 4;
+		return AUDITSC_SOCKETCALL;
 #endif
 	case __NR_execve:
-		return 5;
+		return AUDITSC_EXECVE;
 	default:
-		return 1;
+		return AUDITSC_COMPAT;
 	}
 }
-- 
2.27.0


--f2QGlHpHGjS2mn6Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="0002-audit-add-support-for-the-openat2-syscall.patch"

From cfd217b99e6e2646e0740b2ddead4c56ba394509 Mon Sep 17 00:00:00 2001
Message-Id: <cfd217b99e6e2646e0740b2ddead4c56ba394509.1616067847.git.rgb@redhat.com>
In-Reply-To: <cover.1616067847.git.rgb@redhat.com>
References: <cover.1616067847.git.rgb@redhat.com>
From: Richard Guy Briggs <rgb@redhat.com>
Date: Fri, 22 Jan 2021 13:48:17 -0500
Subject: [PATCH 2/3] audit: add support for the openat2 syscall

Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
---
 arch/alpha/kernel/audit.c          | 2 ++
 arch/ia64/kernel/audit.c           | 2 ++
 arch/parisc/kernel/audit.c         | 2 ++
 arch/parisc/kernel/compat_audit.c  | 2 ++
 arch/powerpc/kernel/audit.c        | 2 ++
 arch/powerpc/kernel/compat_audit.c | 2 ++
 arch/s390/kernel/audit.c           | 2 ++
 arch/s390/kernel/compat_audit.c    | 2 ++
 arch/sparc/kernel/audit.c          | 2 ++
 arch/sparc/kernel/compat_audit.c   | 2 ++
 arch/x86/ia32/audit.c              | 2 ++
 arch/x86/kernel/audit_64.c         | 2 ++
 include/linux/audit.h              | 1 +
 kernel/auditsc.c                   | 3 +++
 lib/audit.c                        | 4 ++++
 lib/compat_audit.c                 | 4 ++++
 16 files changed, 36 insertions(+)

diff --git a/arch/alpha/kernel/audit.c b/arch/alpha/kernel/audit.c
index 81cbd804e375..3ab04709784a 100644
--- a/arch/alpha/kernel/audit.c
+++ b/arch/alpha/kernel/audit.c
@@ -42,6 +42,8 @@ int audit_classify_syscall(int abi, unsigned syscall)
 		return AUDITSC_OPENAT;
 	case __NR_execve:
 		return AUDITSC_EXECVE;
+	case __NR_openat2:
+		return AUDITSC_OPENAT2;
 	default:
 		return AUDITSC_NATIVE;
 	}
diff --git a/arch/ia64/kernel/audit.c b/arch/ia64/kernel/audit.c
index dba6a74c9ab3..ec61f20ca61f 100644
--- a/arch/ia64/kernel/audit.c
+++ b/arch/ia64/kernel/audit.c
@@ -43,6 +43,8 @@ int audit_classify_syscall(int abi, unsigned syscall)
 		return AUDITSC_OPENAT;
 	case __NR_execve:
 		return AUDITSC_EXECVE;
+	case __NR_openat2:
+		return AUDITSC_OPENAT2;
 	default:
 		return AUDITSC_NATIVE;
 	}
diff --git a/arch/parisc/kernel/audit.c b/arch/parisc/kernel/audit.c
index 14244e83db75..f420b5552140 100644
--- a/arch/parisc/kernel/audit.c
+++ b/arch/parisc/kernel/audit.c
@@ -52,6 +52,8 @@ int audit_classify_syscall(int abi, unsigned syscall)
 		return AUDITSC_OPENAT;
 	case __NR_execve:
 		return AUDITSC_EXECVE;
+	case __NR_openat2:
+		return AUDITSC_OPENAT2;
 	default:
 		return AUDITSC_NATIVE;
 	}
diff --git a/arch/parisc/kernel/compat_audit.c b/arch/parisc/kernel/compat_audit.c
index 68102807aba7..139b7f736b67 100644
--- a/arch/parisc/kernel/compat_audit.c
+++ b/arch/parisc/kernel/compat_audit.c
@@ -36,6 +36,8 @@ int parisc32_classify_syscall(unsigned syscall)
 		return AUDITSC_OPENAT;
 	case __NR_execve:
 		return AUDITSC_EXECVE;
+	case __NR_openat2:
+		return AUDITSC_OPENAT2;
 	default:
 		return AUDITSC_COMPAT;
 	}
diff --git a/arch/powerpc/kernel/audit.c b/arch/powerpc/kernel/audit.c
index 6eb18ef77dff..1bcfca5fdf67 100644
--- a/arch/powerpc/kernel/audit.c
+++ b/arch/powerpc/kernel/audit.c
@@ -54,6 +54,8 @@ int audit_classify_syscall(int abi, unsigned syscall)
 		return AUDITSC_SOCKETCALL;
 	case __NR_execve:
 		return AUDITSC_EXECVE;
+	case __NR_openat2:
+		return AUDITSC_OPENAT2;
 	default:
 		return AUDITSC_NATIVE;
 	}
diff --git a/arch/powerpc/kernel/compat_audit.c b/arch/powerpc/kernel/compat_audit.c
index b3fd2d43bfff..a702374377d7 100644
--- a/arch/powerpc/kernel/compat_audit.c
+++ b/arch/powerpc/kernel/compat_audit.c
@@ -39,6 +39,8 @@ int ppc32_classify_syscall(unsigned syscall)
 		return AUDITSC_SOCKETCALL;
 	case __NR_execve:
 		return AUDITSC_EXECVE;
+	case __NR_openat2:
+		return AUDITSC_OPENAT2;
 	default:
 		return AUDITSC_COMPAT;
 	}
diff --git a/arch/s390/kernel/audit.c b/arch/s390/kernel/audit.c
index 7e331e1831d4..02051a596b87 100644
--- a/arch/s390/kernel/audit.c
+++ b/arch/s390/kernel/audit.c
@@ -54,6 +54,8 @@ int audit_classify_syscall(int abi, unsigned syscall)
 		return AUDITSC_SOCKETCALL;
 	case __NR_execve:
 		return AUDITSC_EXECVE;
+	case __NR_openat2:
+		return AUDITSC_OPENAT2;
 	default:
 		return AUDITSC_NATIVE;
 	}
diff --git a/arch/s390/kernel/compat_audit.c b/arch/s390/kernel/compat_audit.c
index 704d04cfd9dd..a6d9c82f86e4 100644
--- a/arch/s390/kernel/compat_audit.c
+++ b/arch/s390/kernel/compat_audit.c
@@ -40,6 +40,8 @@ int s390_classify_syscall(unsigned syscall)
 		return AUDITSC_SOCKETCALL;
 	case __NR_execve:
 		return AUDITSC_EXECVE;
+	case __NR_openat2:
+		return AUDITSC_OPENAT2;
 	default:
 		return AUDITSC_COMPAT;
 	}
diff --git a/arch/sparc/kernel/audit.c b/arch/sparc/kernel/audit.c
index 50fab35bdaba..b092274eca79 100644
--- a/arch/sparc/kernel/audit.c
+++ b/arch/sparc/kernel/audit.c
@@ -55,6 +55,8 @@ int audit_classify_syscall(int abi, unsigned int syscall)
 		return AUDITSC_SOCKETCALL;
 	case __NR_execve:
 		return AUDITSC_EXECVE;
+	case __NR_openat2:
+		return AUDITSC_OPENAT2;
 	default:
 		return AUDITSC_NATIVE;
 	}
diff --git a/arch/sparc/kernel/compat_audit.c b/arch/sparc/kernel/compat_audit.c
index 4c2f9a4ee845..047e87efd759 100644
--- a/arch/sparc/kernel/compat_audit.c
+++ b/arch/sparc/kernel/compat_audit.c
@@ -40,6 +40,8 @@ int sparc32_classify_syscall(unsigned int syscall)
 		return AUDITSC_SOCKETCALL;
 	case __NR_execve:
 		return AUDITSC_EXECVE;
+	case __NR_openat2:
+		return AUDITSC_OPENAT2;
 	default:
 		return AUDITSC_COMPAT;
 	}
diff --git a/arch/x86/ia32/audit.c b/arch/x86/ia32/audit.c
index 0798a6b66314..595e5da358ba 100644
--- a/arch/x86/ia32/audit.c
+++ b/arch/x86/ia32/audit.c
@@ -40,6 +40,8 @@ int ia32_classify_syscall(unsigned syscall)
 	case __NR_execve:
 	case __NR_execveat:
 		return AUDITSC_EXECVE;
+	case __NR_openat2:
+		return AUDITSC_OPENAT2;
 	default:
 		return AUDITSC_COMPAT;
 	}
diff --git a/arch/x86/kernel/audit_64.c b/arch/x86/kernel/audit_64.c
index 2a6cc9c9c881..44c3601cfdc4 100644
--- a/arch/x86/kernel/audit_64.c
+++ b/arch/x86/kernel/audit_64.c
@@ -53,6 +53,8 @@ int audit_classify_syscall(int abi, unsigned syscall)
 	case __NR_execve:
 	case __NR_execveat:
 		return AUDITSC_EXECVE;
+	case __NR_openat2:
+		return AUDITSC_OPENAT2;
 	default:
 		return AUDITSC_NATIVE;
 	}
diff --git a/include/linux/audit.h b/include/linux/audit.h
index bcf0150b1528..2eb48c2b3bd4 100644
--- a/include/linux/audit.h
+++ b/include/linux/audit.h
@@ -126,6 +126,7 @@ extern int is_audit_feature_set(int which);
 #define AUDITSC_OPENAT		3
 #define AUDITSC_SOCKETCALL	4
 #define AUDITSC_EXECVE		5
+#define AUDITSC_OPENAT2		6
 
 extern int __init audit_register_class(int class, unsigned *list);
 extern int audit_classify_syscall(int abi, unsigned syscall);
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index dddea985f23e..f1519f672b20 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -76,6 +76,7 @@
 #include <linux/fsnotify_backend.h>
 #include <uapi/linux/limits.h>
 #include <uapi/linux/netfilter/nf_tables.h>
+#include <uapi/linux/openat2.h>
 
 #include "audit.h"
 
@@ -195,6 +196,8 @@ static int audit_match_perm(struct audit_context *ctx, int mask)
 		return ((mask & AUDIT_PERM_WRITE) && ctx->argv[0] == SYS_BIND);
 	case AUDITSC_EXECVE:
 		return mask & AUDIT_PERM_EXEC;
+	case AUDITSC_OPENAT2:
+		return mask & ACC_MODE((u32)((struct open_how *)ctx->argv[2])->flags);
 	default:
 		return 0;
 	}
diff --git a/lib/audit.c b/lib/audit.c
index 3ec1a94d8d64..738bda22dd39 100644
--- a/lib/audit.c
+++ b/lib/audit.c
@@ -60,6 +60,10 @@ int audit_classify_syscall(int abi, unsigned syscall)
 #endif
 	case __NR_execve:
 		return AUDITSC_EXECVE;
+#ifdef __NR_openat2
+	case __NR_openat2:
+		return AUDITSC_OPENAT2;
+#endif
 	default:
 		return AUDITSC_NATIVE;
 	}
diff --git a/lib/compat_audit.c b/lib/compat_audit.c
index 528dafa2c2bb..b2e4f8bcaf1d 100644
--- a/lib/compat_audit.c
+++ b/lib/compat_audit.c
@@ -46,6 +46,10 @@ int audit_classify_compat_syscall(int abi, unsigned syscall)
 #endif
 	case __NR_execve:
 		return AUDITSC_EXECVE;
+#ifdef __NR_openat2
+	case __NR_openat2:
+		return AUDITSC_OPENAT2;
+#endif
 	default:
 		return AUDITSC_COMPAT;
 	}
-- 
2.27.0


--f2QGlHpHGjS2mn6Y--

