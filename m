Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 119D21C7D5E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 May 2020 00:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729875AbgEFW2j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 May 2020 18:28:39 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:33313 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730318AbgEFW2i (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 May 2020 18:28:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588804117;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=wQTyzrrjxvEBxHFU1Nt/yiuwPloqRUZUg1732JX0QhY=;
        b=ZbQRVa9yjykWNzZDyUyT/6i36HV2x95OPul1oy6RgtXvKD7g4Qzkt2Wm1R0shFZqZP12NH
        77kKcvQid1OjrZDypT6DwWfsieU5lcYzNW5QBZINcvTWPMIlw7CQZ4D/V2c6SaBdStKB6i
        DRTMtvIpGuyv7yLIjp0yNzxYGLnHY0o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-122-PVdTOSqROH68QaI3WS8alw-1; Wed, 06 May 2020 18:28:33 -0400
X-MC-Unique: PVdTOSqROH68QaI3WS8alw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9092856C8E;
        Wed,  6 May 2020 22:28:31 +0000 (UTC)
Received: from optiplex-lnx.redhat.com (unknown [10.3.128.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3BB9A1001B07;
        Wed,  6 May 2020 22:28:25 +0000 (UTC)
From:   Rafael Aquini <aquini@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-doc@vger.kernel.org, kexec@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, dyoung@redhat.com, bhe@redhat.com,
        corbet@lwn.net, mcgrof@kernel.org, keescook@chromium.org,
        akpm@linux-foundation.org, cai@lca.pw
Subject: [PATCH] kernel: add panic_on_taint
Date:   Wed,  6 May 2020 18:28:15 -0400
Message-Id: <20200506222815.274570-1-aquini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Content-Transfer-Encoding: quoted-printable
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
 Documentation/admin-guide/kdump/kdump.rst     | 10 ++++++
 .../admin-guide/kernel-parameters.txt         |  3 ++
 Documentation/admin-guide/sysctl/kernel.rst   | 36 +++++++++++++++++++
 include/linux/kernel.h                        |  1 +
 kernel/panic.c                                |  7 ++++
 kernel/sysctl.c                               |  7 ++++
 6 files changed, 64 insertions(+)

diff --git a/Documentation/admin-guide/kdump/kdump.rst b/Documentation/ad=
min-guide/kdump/kdump.rst
index ac7e131d2935..de3cf6d377cc 100644
--- a/Documentation/admin-guide/kdump/kdump.rst
+++ b/Documentation/admin-guide/kdump/kdump.rst
@@ -521,6 +521,16 @@ will cause a kdump to occur at the panic() call.  In=
 cases where a user wants
 to specify this during runtime, /proc/sys/kernel/panic_on_warn can be se=
t to 1
 to achieve the same behaviour.
=20
+Trigger Kdump on add_taint()
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
+
+The kernel parameter, panic_on_taint, calls panic() from within add_tain=
t(),
+whenever the value set in this bitmask matches with the bit flag being s=
et
+by add_taint(). This will cause a kdump to occur at the panic() call.
+In cases where a user wants to specify this during runtime,
+/proc/sys/kernel/panic_on_taint can be set to a respective bitmask value
+to achieve the same behaviour.
+
 Contact
 =3D=3D=3D=3D=3D=3D=3D
=20
diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentat=
ion/admin-guide/kernel-parameters.txt
index 7bc83f3d9bdf..75c02c1841b2 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3404,6 +3404,9 @@
 	panic_on_warn	panic() instead of WARN().  Useful to cause kdump
 			on a WARN().
=20
+	panic_on_taint	panic() when the kernel gets tainted, if the taint
+			flag being set matches with the assigned bitmask.
+
 	crash_kexec_post_notifiers
 			Run kdump after running panic-notifiers and dumping
 			kmsg. This only for the users who doubt kdump always
diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/=
admin-guide/sysctl/kernel.rst
index 0d427fd10941..5b880102f2e3 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -658,6 +658,42 @@ a kernel rebuild when attempting to kdump at the loc=
ation of a WARN().
 =3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
=20
+panic_on_taint
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Bitmask for calling panic() in the add_taint() path.
+This is useful to avoid a kernel rebuild when attempting to
+kdump at the insertion of any specific TAINT flags.
+When set to 0 (default) add_taint() default behavior is maintained.
+
+=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+bit  0 TAINT_PROPRIETARY_MODULE
+bit  1 TAINT_FORCED_MODULE
+bit  2 TAINT_CPU_OUT_OF_SPEC
+bit  3 TAINT_FORCED_RMMOD
+bit  4 TAINT_MACHINE_CHECK
+bit  5 TAINT_BAD_PAGE
+bit  6 TAINT_USER
+bit  7 TAINT_DIE
+bit  8 TAINT_OVERRIDDEN_ACPI_TABLE
+bit  9 TAINT_WARN
+bit 10 TAINT_CRAP
+bit 11 TAINT_FIRMWARE_WORKAROUND
+bit 12 TAINT_OOT_MODULE
+bit 13 TAINT_UNSIGNED_MODULE
+bit 14 TAINT_SOFTLOCKUP
+bit 15 TAINT_LIVEPATCH
+bit 16 TAINT_AUX
+bit 17 TAINT_RANDSTRUCT
+bit 18 TAINT_FLAGS_COUNT
+=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+So, for example, to panic if the kernel gets tainted due to
+occurrences of bad pages and/or machine check errors, a user can::
+
+  echo 48 > /proc/sys/kernel/panic_on_taint
+
+
 panic_print
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
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
=20
diff --git a/kernel/panic.c b/kernel/panic.c
index b69ee9e76cb2..e2d4771ab911 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -44,6 +44,7 @@ static int pause_on_oops_flag;
 static DEFINE_SPINLOCK(pause_on_oops_lock);
 bool crash_kexec_post_notifiers;
 int panic_on_warn __read_mostly;
+unsigned long panic_on_taint __read_mostly;
=20
 int panic_timeout =3D CONFIG_PANIC_TIMEOUT;
 EXPORT_SYMBOL_GPL(panic_timeout);
@@ -434,6 +435,11 @@ void add_taint(unsigned flag, enum lockdep_ok lockde=
p_ok)
 		pr_warn("Disabling lock debugging due to kernel taint\n");
=20
 	set_bit(flag, &tainted_mask);
+
+	if (unlikely(tainted_mask & panic_on_taint)) {
+		panic_on_taint =3D 0;
+		panic("panic_on_taint set ...");
+	}
 }
 EXPORT_SYMBOL(add_taint);
=20
@@ -675,6 +681,7 @@ core_param(panic, panic_timeout, int, 0644);
 core_param(panic_print, panic_print, ulong, 0644);
 core_param(pause_on_oops, pause_on_oops, int, 0644);
 core_param(panic_on_warn, panic_on_warn, int, 0644);
+core_param(panic_on_taint, panic_on_taint, ulong, 0644);
 core_param(crash_kexec_post_notifiers, crash_kexec_post_notifiers, bool,=
 0644);
=20
 static int __init oops_setup(char *s)
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 8a176d8727a3..b80ab660d727 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1217,6 +1217,13 @@ static struct ctl_table kern_table[] =3D {
 		.extra1		=3D SYSCTL_ZERO,
 		.extra2		=3D SYSCTL_ONE,
 	},
+	{
+		.procname	=3D "panic_on_taint",
+		.data		=3D &panic_on_taint,
+		.maxlen		=3D sizeof(unsigned long),
+		.mode		=3D 0644,
+		.proc_handler	=3D proc_doulongvec_minmax,
+	},
 #if defined(CONFIG_SMP) && defined(CONFIG_NO_HZ_COMMON)
 	{
 		.procname	=3D "timer_migration",
--=20
2.25.4

