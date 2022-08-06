Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8130158B569
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Aug 2022 14:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231622AbiHFMYP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 6 Aug 2022 08:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231371AbiHFMYK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 6 Aug 2022 08:24:10 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30E661056F;
        Sat,  6 Aug 2022 05:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1659788631;
        bh=lELR8WYbBOTLMAY/ROaaXRuZyiwAFpzcRRcD1yGmR+U=;
        h=X-UI-Sender-Class:From:To:Subject:Date:In-Reply-To:References;
        b=WyehE8w1Jhfb7cmxf4r8c8mKj31OCf5NW+Kp+QP2am6/6DhXUOSZw6s6+iTRK7i2Y
         rKVfEXTH4O+4nNKfRWQgZAkHpLLJBZgCFcKMPhi/WxHeQTnOnEkSIkhhZTq3wwtXE/
         mm6hPmTT8zmbcf70eNsaPwtINlweqRt9dNU09GSQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from p100.fritz.box ([92.116.170.46]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MyKDe-1nUe3m3znY-00ygrT; Sat, 06
 Aug 2022 14:23:51 +0200
From:   Helge Deller <deller@gmx.de>
To:     linux-s390@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        Josh Triplett <josh@joshtriplett.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 2/3] lib/dump_stack: Add dump_stack_print_cmdline() and wire up in dump_stack_print_info()
Date:   Sat,  6 Aug 2022 14:23:47 +0200
Message-Id: <20220806122348.82584-3-deller@gmx.de>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220806122348.82584-1-deller@gmx.de>
References: <20220806122348.82584-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BialK5Gr6LY7i1wCJNhco7oXVVXlstreH3iQsxuzTtOakZOQe2F
 vaS/im2YcOCpaEPRnRhbwznsplhtoaQSv9+CnR8fhlHCyatnsnlA0W+ZsXyuLT3WuOa8/1s
 Je6ndthUB5LhqHBWmvC9Bs0YLneOfnYNLV77EF8VVLuieKytfZKrNg70+qqTKD8YXHgCVzQ
 /Op2Ok+TusjWlOroTn0dQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Mu3f6I4mzLw=:zjKIeXJ7YvUUYkQQndV98C
 Jh5XEN7sYnVdh0dFdTGaM76btoqfgn2XjywmBvgmEuoGYsto9NV1HO/07crZkwtG8F3E/yPy2
 b9JAfz1g80530g/AjEY+kX8TiKcjzd9QdOW01q7pneoQnGaJY9h5uQkhb/G7AfnxNMmSBIk21
 fVB7DH81TvX8qREv7VDmcyWuGfewc2QbC8d81QCAhTmcbh7YJ931dTpJI1Sff22C189bHjCWV
 YlKx4AoqQQhuBIRPCFdvLOyYkZU75uoAuazvgJ/wOICxwa4oa/6T9y5uyMfh7ufvPZ1yHm6c9
 c0kWsMFxsOypWGkLoW1ZnWd4oSPIjrD5MjsTWTjomvmyZOgTMEfVcJxxMXe3FLLIREdMrHn3h
 MUjr1gzWU0OBlasW44SSQzyG84YKxU3lXUX2DZKOSO1G30Zs3U/mD2wcC5xvNxGeTnxnzIkq8
 kBY2RwHKXnqpIlA9PXU69KLch3Tnq25AaM68d/sQQkYsc5w2aoxulLfejsz83mmCetq2b2T9k
 tNDG+teYLYWzdP/FR8QLuiqw0QX5TIzbN/f/AzOXeBdsM4MvEei414633RtoxCARM6NlKqqqg
 WrrbgTYmQUUc/+1CZwwMO2wx6FjdmTQI/icTMNWZ24LoP+QjHutOGOXwStlUkGaA3k6cDPeNQ
 tGLvuCkUQ6wkjm8yWx68N9HgeBEJ5XAJKZYcNx8/7GyqMb0TMaGjn3GuHPeyXtoHva73OnczO
 dwnyH6lDuZIi7aE7cw8t5vyknR0dY+GpHCVlRJPG2ahT9/pJ2y1tvkclwry2Q9ikFzRV8h9hI
 ylQSq+WsMHDugXffWmv5wBPznBOlx2rLyckCUoJxpNhXf1Lpl/iLbTEHwcYgRXAuTJxkDqbvn
 xA7eCe8GI2Joh0+2BMUgtSKu1XfhCHqcC5zelbtBbVeDy5PhRQeEdy4rzboIJY858SUbhW4hd
 v9L+dcswOxIb0oqxLDTt/mbcoN8sCX2AT3rZhm5cPExW8CZ9ySXty/4T1m8y+wXqvidb1V+NU
 ZNTqb++QElDkvaqYPdVPEIykOMOFxhJoq60pwhPvyQWxpsJ+VdeRkkGeKcHPnvNig4OdOYE4n
 xrTh+fgGdUpSiwelgs2BCsT+uZSzLwxcWMD7hETBr1lt8oOULoacU/zYg==
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

