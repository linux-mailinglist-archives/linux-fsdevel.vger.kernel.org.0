Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7C9536FFAF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Apr 2021 19:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231548AbhD3RgJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Apr 2021 13:36:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25668 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231502AbhD3RgE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Apr 2021 13:36:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619804115;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SQYw3zCy9t/k2wahs4H0j/BC6DtksIRtIBmPuRS8DNY=;
        b=WRsaF+e1OyidAqpid9wR/9Sfg7vYazCvk3kS70wlGXht2ctkFhYa4RNQEukmxqKl2LAUXS
        /5+rTbb4IgNc7mH2vl34j+wdFMupcYeC/Mp6Qh2Q7LPPu0fYF3+p97Q7892CI4BTaacMuf
        LmJ5tAOiM8lPEKbSBAzVjBz4l7l43Bg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-334-xUmCy0L5OOGm4rR5KcxFMw-1; Fri, 30 Apr 2021 13:35:11 -0400
X-MC-Unique: xUmCy0L5OOGm4rR5KcxFMw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 825BF1020C20;
        Fri, 30 Apr 2021 17:35:09 +0000 (UTC)
Received: from madcap2.tricolour.ca (unknown [10.3.128.45])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 99E6D2B196;
        Fri, 30 Apr 2021 17:35:02 +0000 (UTC)
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Cc:     Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@parisplace.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Richard Guy Briggs <rgb@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Paris <eparis@redhat.com>, x86@kernel.org,
        linux-alpha@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
        Aleksa Sarai <cyphar@cyphar.com>
Subject: [PATCH v2 2/3] audit: add support for the openat2 syscall
Date:   Fri, 30 Apr 2021 13:29:36 -0400
Message-Id: <83b87c0fef646d0fc2ea1441c7a1bccde65eb2bc.1619729297.git.rgb@redhat.com>
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
 include/linux/auditscm.h           | 1 +
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
index 0c181bb39f34..02cfd9d1ebeb 100644
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
index f250777f6365..1fa0c902be8a 100644
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
index b2a2ed5d605a..320b5e7d96f0 100644
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
index fdf0d70b569b..b0a7d0112b96 100644
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
index d3dc8b57df81..8f6bf3a46a3a 100644
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
diff --git a/include/linux/auditscm.h b/include/linux/auditscm.h
index 1c4f0ead5931..0893c373e12b 100644
--- a/include/linux/auditscm.h
+++ b/include/linux/auditscm.h
@@ -16,6 +16,7 @@ enum auditsc_class_t {
 	AUDITSC_OPENAT,
 	AUDITSC_SOCKETCALL,
 	AUDITSC_EXECVE,
+	AUDITSC_OPENAT2,
 
 	AUDITSC_NVALS /* count */
 };
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 8807afa6e237..27c747e0d5ab 100644
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
index 63125ad2edc0..7ed9461b52b7 100644
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

