Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDF3A586D9A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Aug 2022 17:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232357AbiHAPUa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Aug 2022 11:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233461AbiHAPUW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Aug 2022 11:20:22 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51F456543;
        Mon,  1 Aug 2022 08:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1659367217;
        bh=z93eW6O/Zqb2IzNmzjvUpniK5rxoeVr74jaCWZju6pw=;
        h=X-UI-Sender-Class:From:To:Subject:Date:In-Reply-To:References;
        b=gH59Kkd5UhulzziAXMulZi6ahqnrCaMzzRy5lp1bl7fhVilt5x1R8vrZ5ObgXZA9w
         /q1xvnHZXRuaAA0EiVmtWHTQJZTG7Bmjd9sc+p/QiS4gQxvn+1uuldnzdobzIsFRTL
         k2/HFgw26GNddkgRECtAEApSFT1ezHGBpdcXYQ6Y=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from p100.fritz.box ([92.116.150.19]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MjS5A-1nc0OB0Z0U-00kxEA; Mon, 01
 Aug 2022 17:20:17 +0200
From:   Helge Deller <deller@gmx.de>
To:     linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] lib/dump_stack: Add dump_stack_print_cmdline() and wire up in dump_stack_print_info()
Date:   Mon,  1 Aug 2022 17:20:15 +0200
Message-Id: <20220801152016.36498-3-deller@gmx.de>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220801152016.36498-1-deller@gmx.de>
References: <20220801152016.36498-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:iUepW5wkUjPsZckWAYxGL+x9EAmhGDReEdlpXFYiT9j0izawb4Z
 Wtj6qgmcLjAo0N35RsY6Bv5h/kTh5iQ8bJmmb8wrIpsTW7uf/vm1Kg5G+u08KkB6MGDfuJV
 mmsXBB7rdXmNGJjXfCUJ4pscMRe92lty+C5JQcHkrHcFOzC6e+e1nIEoarh2duoUGzI+5he
 b43GaMjAS89WWodZQX5GA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wM47MDtDfh0=:dbb6b7qymycG950Oyqo/2i
 DCnHtQ3xMp+Qld/uCQKhx38pGnLWuHmt7JW/N6hGh6nI74ollkm/P0Dr7gv6KeHwcpqdazxgC
 vtdU0M5Bi55CeWtKFzYLHbJ/WvHx93WAcZXMPYAhwZx5AFuqoPp3tIlLuQSIwsImY+ZzDHuV1
 PBhgsSylXs41Abjt2uxSC0wYe7oUiPxEpPzQEcemvYPNA6OO4zo5cly1+T829vkKV28b9nJyI
 /BIm3NJjsAqxIWApGhZMlET5NXKGqE+yLmEtp1s3jlIEtMHXxANwgbRALx/NLWd1IM4PyY5fa
 7iLPyOqM6in6zmlyWB/hHabuBV+HooUZcy7XY3G23JCBLEitKJJXXZi4Ya6gWtuZG/SkGtu0D
 wxu2IaDPlbxX1ued51iBCcZDPhGsbxNMR/33lPkgtvBA9Hcc8upbMCrKeMwCKBzgoq9mDjtEo
 GGAxFAMQWlkdyFKVfZhlOn4cNTaIgGOE2eDnc4gce3isqbgLI8jwYI7h5h3Ike8+LXF/kkEN+
 Oq7M2+0eRH6s9A6hT0mNtw7E7NxX0Sq+rzeyfR15xAyXrETfTzn/sQEquPB2GjDWzPMFEuARO
 zF4X3bKW1lWoGrtQ3ICEkhd3aip8VXlU6Z5nIKTsSLTJSZjjD88cz3nFMucG+wzK87FPXnn58
 gt9NjrBFeZgiu6QwCXREO4e+DjJya2tloMOnYmBvwfjuSyJ2ryG+UT5H6eG1NaTEDb6cfsq7T
 s32O6MdwrAtQbPqHaMRzhM+W8bIqoa+fejsikfnaepU9RVuRTT69YDWW0PY56bo2UebeHizDO
 J3yIb5KY/82vqECSNhCRRSX7cB3wvydOvEmfd5xS97b0N9hDdjRSt9gu3+4OBppqANa6j1X9C
 DpZM39pPCw+OgtnUDfLQoOhiRUcWbND3IBZFTpOMym31LfW2l9cF2Zd36p0b6Y8WVw9aZ1qJH
 ie5kCHDhN1H7J/qXsA2okg6ApYNCBflahwXNG0HDPvhUtmDTwXyDCCW52zNG/H+NDf//GZyWb
 MJy1OJLHyc2jynfq0ngiE6PKdZg8jJdtjuz9dQ3iS5y5A8fD+1WEoWfg7dK4zzy72keFTPg3b
 glQ5K6j629nvjoiNR8xsFXV5HVGTTz3kBfvMMfcTubsZfy374hbMX1xYA==
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add the function dump_stack_print_cmdline() which can be used by arch
code to print the command line of the current processs.  This function
is useful in arch code when dumping information for a faulting process.

Wire this function up in the dump_stack_print_info() function to include
the dumping of the command line for architectures which use
dump_stack_print_info().

As an example, with this patch a failing glibc testcase (which uses
ld.so.1 as starting program) up to now reported just "ld.so.1" failing:

 do_page_fault() command=3D'ld.so.1' type=3D15 address=3D0x565921d8 in lib=
c.so[f7339000+1bb000]
 trap #15: Data TLB miss fault, vm_start =3D 0x0001a000, vm_end =3D 0x0001=
b000

and now it reports in addition:

 ld.so.1[1151] cmdline: /home/gnu/glibc/objdir/elf/ld.so.1 --library-path =
/home/gnu/glibc/objdir:/home/gnu/glibc/objdir/math:/home/gnu/
    /home/gnu/glibc/objdir/malloc/tst-safe-linking-malloc-hugetlb1

Signed-off-by: Helge Deller <deller@gmx.de>
=2D--
 include/linux/printk.h |  5 +++++
 lib/dump_stack.c       | 17 +++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/include/linux/printk.h b/include/linux/printk.h
index cf7d666ab1f8..5290a32a197d 100644
=2D-- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -191,6 +191,7 @@ u32 log_buf_len_get(void);
 void log_buf_vmcoreinfo_setup(void);
 void __init setup_log_buf(int early);
 __printf(1, 2) void dump_stack_set_arch_desc(const char *fmt, ...);
+void dump_stack_print_cmdline(const char *log_lvl);
 void dump_stack_print_info(const char *log_lvl);
 void show_regs_print_info(const char *log_lvl);
 extern asmlinkage void dump_stack_lvl(const char *log_lvl) __cold;
@@ -262,6 +263,10 @@ static inline __printf(1, 2) void dump_stack_set_arch=
_desc(const char *fmt, ...)
 {
 }

+static inline void dump_stack_print_cmdline(const char *log_lvl)
+{
+}
+
 static inline void dump_stack_print_info(const char *log_lvl)
 {
 }
diff --git a/lib/dump_stack.c b/lib/dump_stack.c
index 83471e81501a..c9b6a4c0c4e1 100644
=2D-- a/lib/dump_stack.c
+++ b/lib/dump_stack.c
@@ -14,6 +14,7 @@
 #include <linux/kexec.h>
 #include <linux/utsname.h>
 #include <linux/stop_machine.h>
+#include <linux/proc_fs.h>

 static char dump_stack_arch_desc_str[128];

@@ -45,6 +46,20 @@ void __init dump_stack_set_arch_desc(const char *fmt, .=
..)
 #define BUILD_ID_VAL ""
 #endif

+/**
+ * dump_stack_print_cmdline - print the command line of current process
+ * @log_lvl: log level
+ */
+void dump_stack_print_cmdline(const char *log_lvl)
+{
+	char cmdline[256];
+
+	/* get command line */
+	get_task_cmdline_kernel(current, cmdline, sizeof(cmdline));
+	printk("%s%s[%d] cmdline: %s\n", log_lvl, current->comm,
+		current->pid, cmdline);
+}
+
 /**
  * dump_stack_print_info - print generic debug info for dump_stack()
  * @log_lvl: log level
@@ -62,6 +77,8 @@ void dump_stack_print_info(const char *log_lvl)
 	       (int)strcspn(init_utsname()->version, " "),
 	       init_utsname()->version, BUILD_ID_VAL);

+	dump_stack_print_cmdline(log_lvl);
+
 	if (dump_stack_arch_desc_str[0] !=3D '\0')
 		printk("%sHardware name: %s\n",
 		       log_lvl, dump_stack_arch_desc_str);
=2D-
2.37.1

