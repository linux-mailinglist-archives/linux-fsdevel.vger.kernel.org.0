Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A419958C918
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Aug 2022 15:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243252AbiHHNJ7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Aug 2022 09:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242737AbiHHNJu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Aug 2022 09:09:50 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 464F8B7C5;
        Mon,  8 Aug 2022 06:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1659964158;
        bh=lELR8WYbBOTLMAY/ROaaXRuZyiwAFpzcRRcD1yGmR+U=;
        h=X-UI-Sender-Class:From:To:Subject:Date:In-Reply-To:References;
        b=YARkRCk+edkIn5nZtTwbKK3+c5x4yjVNPDa9GujrX2humxefMcP6U/5piDtobCt91
         mE894Vzo2J/rqBnP+M/O9/i+Xrz22svt5Szx2tjzGcOVwE4jcCJ2O4SXL1SGq5zwmx
         OcJCGuVzeFwDEtHtoszNgMaJ+SvMji6yr7O7AwqE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from p100.fritz.box ([92.116.169.184]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MGyxN-1o8AKD2zDf-00E4Zm; Mon, 08
 Aug 2022 15:09:18 +0200
From:   Helge Deller <deller@gmx.de>
To:     linux-s390@vger.kernel.org, Josh Triplett <josh@joshtriplett.org>,
        x86@kernel.org, linux-snps-arc@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 2/4] lib/dump_stack: Add dump_stack_print_cmdline() and wire up in dump_stack_print_info()
Date:   Mon,  8 Aug 2022 15:09:15 +0200
Message-Id: <20220808130917.30760-3-deller@gmx.de>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220808130917.30760-1-deller@gmx.de>
References: <20220808130917.30760-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dyv38+4Ugz+oNJYhEqwA1WGPLQMQCHxH7gYA9DzhxE1ZyTHPUeX
 lgD4MbyXnzij2je0A21JveizFDJ0RysmHlBxi1vdTStYEm+RmHzoUuMstEW+hD9FO33SxJr
 oP2WdouS9nQ1WcoKEklsuUfDBg9/nB9mx5tSBtp94vcEnDi6cGYPDjwHjZ/7PA8qYfqxH+H
 F9wPqtQXlYJ80YG68DQag==
X-UI-Out-Filterresults: notjunk:1;V03:K0:RpW0RFU0Z6E=:vHBeUsc70DYciJo0r3uauF
 MGJOW+2JX5iPyl7bzACYuZzcsgE0KOuDtO1K2Bppk4muzBADa/0UwkNWZnhnxq9gctbdzfM2F
 CjYlu/8hoQK8Rp2oi6uDjx0cvEw7fMo5WqUcUNzy/eq+XjoGQFk9oFfC6s4hJjWMIRGQtNjNM
 QcPSX8jSs3qP0DmNaFDGPankZ4Q+5EQr/+5SXjaSpwz59qzcyhuXKBV56vrYGFvdclmephBIq
 B7oxtrb2uaCWI+kvsoNLs/zrQv1fWspOyVBYQASk4fWO7nDttW8eUVv+FGqWNewFLKdxYj1Cx
 17xFxjhqi6jg4+258yvMd3QGes7U/5INRI5An1vrAxJH5fzxnwNa5zPcFWDdXr6824deE2ODO
 OnIvUA2lLkfbK+8WKDyeLKZvsnoifbZDBBXzHpy94LePbuI+4LeFGkvBQAXgWh89djmnICx+I
 bklL2SCdn6+Dj4mOle7BQzRhIdtZGFKKjmcbGFkOQ9mhbF/AEA0+p6vxkBh3l+Sg7YCaET3rX
 Cvn6uoFNHsLPmIGhUZ9naF1Tg1Utleqnayp70ND3Y/8G6eYDBwrdmJ09KCKMJLksREGa9gCLw
 QGLTi8C+auExK41IXHRYB1YmxVCytlyQkZpRSoEB0K4iKVRvdBlP1PMJMsR2YfYUG807KDgnx
 vytnyNGsCYDOSI8kcQLPdUWHRcUehw5OAt9bVZBM09KlvsDZOafd89xsjR8n+hQLQDgQXIv79
 EVl4Fwge064DHAD7FCCY1/yuzwgRafYs3caT3EgYOx0FP9ExsGBPef5/Xjz4gUcxhQ7xEAvEG
 1Yq4ZjOoSQ+WCbrKx2ftLQmfGPZLqor0mdgKBg/sfVEHQs6h0Qs8QYWVvlhaQIbWLavN+/5uV
 5FQmjRtWTcUL1tqvnWnOjjYl+4E41TpDG/r1W4ZyXt6usjTpUUKxzAbU1plRO4KLbMjfe6iGo
 OAVHd7w4z5xUq0GYnj0ApSE32SJ0q2AEhGU1eprIAN5I2PHSYdUvVzglD8DT1HnByn9qhqba9
 GfWGIRaNOFib7OQV8Uetfbqt4SniAEFZaEgLv2Vtvka4Z3i1FSZNu7FnWZKiSg3tCWc1Z0Rw1
 twVCPi6Gum3G2ewQ5/3id79oC2uC0VmtWK+w4iwrz3W4P9YWwp/BHym5w==
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLACK autolearn=no
        autolearn_force=no version=3.4.6
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

Josh Triplett noted that dumping such command line parameters into
syslog may theoretically lead to information disclosure.
That's why this patch checks the value of the kptr_restrict sysctl
variable and will not print any information if kptr_restrict=3D=3D2, and
will not show the program parameters if kptr_restrict=3D=3D1.

Signed-off-by: Helge Deller <deller@gmx.de>
=2D--
 include/linux/printk.h |  5 +++++
 lib/dump_stack.c       | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+)

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
index 83471e81501a..38ef1067c7eb 100644
=2D-- a/lib/dump_stack.c
+++ b/lib/dump_stack.c
@@ -14,6 +14,7 @@
 #include <linux/kexec.h>
 #include <linux/utsname.h>
 #include <linux/stop_machine.h>
+#include <linux/proc_fs.h>

 static char dump_stack_arch_desc_str[128];

@@ -45,6 +46,37 @@ void __init dump_stack_set_arch_desc(const char *fmt, .=
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
+	if (kptr_restrict >=3D 2)
+		return; /* never show command line */
+
+	/* get command line */
+	get_task_cmdline_kernel(current, cmdline, sizeof(cmdline));
+
+	if (kptr_restrict =3D=3D 1) {
+		char *p;
+
+		/* if restricted show program path only */
+		p =3D strchr(cmdline, ' ');
+		if (p) {
+			*p =3D 0;
+			strlcat(cmdline,
+				" ... [parameters hidden due to kptr_restrict]",
+				sizeof(cmdline));
+		}
+	}
+
+	printk("%s%s[%d] cmdline: %s\n", log_lvl, current->comm,
+		current->pid, cmdline);
+}
+
 /**
  * dump_stack_print_info - print generic debug info for dump_stack()
  * @log_lvl: log level
@@ -62,6 +94,8 @@ void dump_stack_print_info(const char *log_lvl)
 	       (int)strcspn(init_utsname()->version, " "),
 	       init_utsname()->version, BUILD_ID_VAL);

+	dump_stack_print_cmdline(log_lvl);
+
 	if (dump_stack_arch_desc_str[0] !=3D '\0')
 		printk("%sHardware name: %s\n",
 		       log_lvl, dump_stack_arch_desc_str);
=2D-
2.37.1

