Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCBE71C98CF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 May 2020 20:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728351AbgEGSGy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 May 2020 14:06:54 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:51655 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727904AbgEGSGy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 May 2020 14:06:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588874812;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ccOGTl4FTnd16XZZdgEmbWNOt//L006H8CcR0tkGGZY=;
        b=Yk2B+t5ynLeI1J2ypCrhRi1SsAAopbEmoKP/jZVRAagXn1/oHs2y2er6Mn2ss9/uHD8A0d
        Z9Uz8hVvuWGxSQw2txV+2060vuuFkdZTRcVY9idOxr9iHxCQz5WMYQTdFm64hqAFi3EEsb
        6skSwpnyxZADfq8jxbjQ+B8zW4tvTYU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-44-Rj0ReUCJNqW_gWEc8o6NOw-1; Thu, 07 May 2020 14:06:46 -0400
X-MC-Unique: Rj0ReUCJNqW_gWEc8o6NOw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 11E1010524FF;
        Thu,  7 May 2020 18:06:45 +0000 (UTC)
Received: from optiplex-lnx.redhat.com (unknown [10.3.128.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7FED025277;
        Thu,  7 May 2020 18:06:39 +0000 (UTC)
From:   Rafael Aquini <aquini@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-doc@vger.kernel.org, kexec@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, dyoung@redhat.com, bhe@redhat.com,
        corbet@lwn.net, mcgrof@kernel.org, keescook@chromium.org,
        akpm@linux-foundation.org, cai@lca.pw, rdunlap@infradead.org
Subject: [PATCH v2] kernel: add panic_on_taint
Date:   Thu,  7 May 2020 14:06:31 -0400
Message-Id: <20200507180631.308441-1-aquini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Analogously to the introduction of panic_on_warn, this patch
introduces a kernel option named panic_on_taint in order to
provide a simple and generic way to stop execution and catch
a coredump when the kernel gets tainted by any given taint flag.

This is useful for debugging sessions as it avoids rebuilding
the kernel to explicitly add calls to panic() or BUG() into
code sites that introduce the taint flags of interest.
Another, perhaps less frequent, use for this option would be
as a mean for assuring a security policy (in paranoid mode)
case where no single taint is allowed for the running system.

Suggested-by: Qian Cai <cai@lca.pw>
Signed-off-by: Rafael Aquini <aquini@redhat.com>
---
Changelog, from v1:
* get rid of unnecessary/misguided compiler hints		(Luis)
* enhance documentation text for the new kernel parameter	(Randy)

 Documentation/admin-guide/kdump/kdump.rst      | 10 ++++++++++
 .../admin-guide/kernel-parameters.txt          |  7 +++++++
 Documentation/admin-guide/sysctl/kernel.rst    | 18 ++++++++++++++++++
 include/linux/kernel.h                         |  1 +
 kernel/panic.c                                 |  7 +++++++
 kernel/sysctl.c                                |  7 +++++++
 6 files changed, 50 insertions(+)

diff --git a/Documentation/admin-guide/kdump/kdump.rst b/Documentation/admin-guide/kdump/kdump.rst
index ac7e131d2935..de3cf6d377cc 100644
--- a/Documentation/admin-guide/kdump/kdump.rst
+++ b/Documentation/admin-guide/kdump/kdump.rst
@@ -521,6 +521,16 @@ will cause a kdump to occur at the panic() call.  In cases where a user wants
 to specify this during runtime, /proc/sys/kernel/panic_on_warn can be set to 1
 to achieve the same behaviour.
 
+Trigger Kdump on add_taint()
+============================
+
+The kernel parameter, panic_on_taint, calls panic() from within add_taint(),
+whenever the value set in this bitmask matches with the bit flag being set
+by add_taint(). This will cause a kdump to occur at the panic() call.
+In cases where a user wants to specify this during runtime,
+/proc/sys/kernel/panic_on_taint can be set to a respective bitmask value
+to achieve the same behaviour.
+
 Contact
 =======
 
diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 7bc83f3d9bdf..6aa524928399 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3404,6 +3404,13 @@
 	panic_on_warn	panic() instead of WARN().  Useful to cause kdump
 			on a WARN().
 
+	panic_on_taint=	Bitmask for calling panic() when the kernel gets tainted
+			and the taint bit set matches with the assigned bitmask.
+			See Documentation/admin-guide/tainted-kernels.rst for
+			details on the taint flag bits that user can pick to
+			compose the bitmask to assign to panic_on_taint.
+			When set to 0 (default), this option is disabled.
+
 	crash_kexec_post_notifiers
 			Run kdump after running panic-notifiers and dumping
 			kmsg. This only for the users who doubt kdump always
diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index 0d427fd10941..60500d5c1ee0 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -658,6 +658,24 @@ a kernel rebuild when attempting to kdump at the location of a WARN().
 = ================================================
 
 
+panic_on_taint
+==============
+
+Bitmask for calling panic() in the add_taint() path.
+This is useful to avoid a kernel rebuild when attempting to
+kdump at the insertion of any specific TAINT flags.
+When set to 0 (default), the non-crashing default behavior
+of add_panic() is maintained.
+
+See :doc:`/admin-guide/tainted-kernels` for a complete list of
+taint flag bits and their decimal decoded values.
+
+So, for example, to panic if the kernel gets tainted due to
+occurrences of bad pages and/or machine check errors, a user can::
+
+  echo 48 > /proc/sys/kernel/panic_on_taint
+
+
 panic_print
 ===========
 
diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 9b7a8d74a9d6..518b9fd381c2 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -528,6 +528,7 @@ extern int panic_on_oops;
 extern int panic_on_unrecovered_nmi;
 extern int panic_on_io_nmi;
 extern int panic_on_warn;
+extern unsigned long panic_on_taint;
 extern int sysctl_panic_on_rcu_stall;
 extern int sysctl_panic_on_stackoverflow;
 
diff --git a/kernel/panic.c b/kernel/panic.c
index b69ee9e76cb2..d284241e702b 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -44,6 +44,7 @@ static int pause_on_oops_flag;
 static DEFINE_SPINLOCK(pause_on_oops_lock);
 bool crash_kexec_post_notifiers;
 int panic_on_warn __read_mostly;
+unsigned long panic_on_taint;
 
 int panic_timeout = CONFIG_PANIC_TIMEOUT;
 EXPORT_SYMBOL_GPL(panic_timeout);
@@ -434,6 +435,11 @@ void add_taint(unsigned flag, enum lockdep_ok lockdep_ok)
 		pr_warn("Disabling lock debugging due to kernel taint\n");
 
 	set_bit(flag, &tainted_mask);
+
+	if (tainted_mask & panic_on_taint) {
+		panic_on_taint = 0;
+		panic("panic_on_taint set ...");
+	}
 }
 EXPORT_SYMBOL(add_taint);
 
@@ -675,6 +681,7 @@ core_param(panic, panic_timeout, int, 0644);
 core_param(panic_print, panic_print, ulong, 0644);
 core_param(pause_on_oops, pause_on_oops, int, 0644);
 core_param(panic_on_warn, panic_on_warn, int, 0644);
+core_param(panic_on_taint, panic_on_taint, ulong, 0644);
 core_param(crash_kexec_post_notifiers, crash_kexec_post_notifiers, bool, 0644);
 
 static int __init oops_setup(char *s)
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 8a176d8727a3..b80ab660d727 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1217,6 +1217,13 @@ static struct ctl_table kern_table[] = {
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_ONE,
 	},
+	{
+		.procname	= "panic_on_taint",
+		.data		= &panic_on_taint,
+		.maxlen		= sizeof(unsigned long),
+		.mode		= 0644,
+		.proc_handler	= proc_doulongvec_minmax,
+	},
 #if defined(CONFIG_SMP) && defined(CONFIG_NO_HZ_COMMON)
 	{
 		.procname	= "timer_migration",
-- 
2.25.4

