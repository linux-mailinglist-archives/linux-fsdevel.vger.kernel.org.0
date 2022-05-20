Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 549C752E7E0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 May 2022 10:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347305AbiETIjs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 May 2022 04:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347327AbiETIjV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 May 2022 04:39:21 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1031FB0A5F;
        Fri, 20 May 2022 01:39:13 -0700 (PDT)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220520083912epoutp04475d86947c29a6a873fdc8406b40b7e1~ww3C0Uw8c0301803018epoutp04f;
        Fri, 20 May 2022 08:39:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220520083912epoutp04475d86947c29a6a873fdc8406b40b7e1~ww3C0Uw8c0301803018epoutp04f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1653035952;
        bh=DWp8DOllJXXACHeuxZYMqjT1Q6GxgVAt1nlrOcuuYKs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aqyOA/9F/aqly1EbRo/oFIoK5BewuquEYc8yevnVyWmIy4ccuH79VM09FPBLBPWvv
         G6FDEkjOuWZ7lM0zHsWizBeUsLzdtuOoCwqI0i8QOiNP+CQ8tV3ISWpFd5+LvDglJL
         8tFpQfttPl2SFb3NDSCYJF4qkDQJvuc95FAVkpsU=
Received: from epsmges5p1new.samsung.com (unknown [182.195.42.73]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20220520083911epcas5p238389a60a0a4934fe1a985838830625b~ww3B0v7li2019220192epcas5p2r;
        Fri, 20 May 2022 08:39:11 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        C5.40.10063.EA357826; Fri, 20 May 2022 17:39:10 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20220520083755epcas5p454d450935fb427fd270295e967b0cbe8~ww17gzPkq1594815948epcas5p4s;
        Fri, 20 May 2022 08:37:55 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220520083755epsmtrp120d9f1f2072e0aacf3e6792cce6989f9~ww17d_Udb0237202372epsmtrp1b;
        Fri, 20 May 2022 08:37:55 +0000 (GMT)
X-AuditID: b6c32a49-4cbff7000000274f-06-628753ae135c
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        8A.FB.11276.36357826; Fri, 20 May 2022 17:37:55 +0900 (KST)
Received: from localhost.localdomain (unknown [107.109.224.44]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220520083747epsmtip215081bd0146d158931317d338b0869db~ww10EHZ-M3025030250epsmtip2w;
        Fri, 20 May 2022 08:37:47 +0000 (GMT)
From:   Maninder Singh <maninder1.s@samsung.com>
To:     keescook@chromium.org, pmladek@suse.com, bcain@quicinc.com,
        mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com, satishkh@cisco.com,
        sebaddel@cisco.com, kartilak@cisco.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, mcgrof@kernel.org,
        jason.wessel@windriver.com, daniel.thompson@linaro.org,
        dianders@chromium.org, naveen.n.rao@linux.ibm.com,
        anil.s.keshavamurthy@intel.com, davem@davemloft.net,
        mhiramat@kernel.org, peterz@infradead.org, mingo@redhat.com,
        will@kernel.org, longman@redhat.com, boqun.feng@gmail.com,
        rostedt@goodmis.org, senozhatsky@chromium.org,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        akpm@linux-foundation.org, arnd@arndb.de
Cc:     linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-modules@vger.kernel.org,
        kgdb-bugreport@lists.sourceforge.net, v.narang@samsung.com,
        onkarnath.1@samsung.com, Maninder Singh <maninder1.s@samsung.com>
Subject: [PATCH 4/5] kallsyms: pass buffer size argument in *lookup* APIs
Date:   Fri, 20 May 2022 14:07:00 +0530
Message-Id: <20220520083701.2610975-5-maninder1.s@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220520083701.2610975-1-maninder1.s@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te0yTZxTG9379+vWSdftWXHgBNw2KEcyqzDHeZUbcYshHyBYW3ZwmGxZs
        QKFYW4FtMdJixyaloVaMpXTcOpHbioWCSAsCdVwEkUvGRS4y6YRq54ANyCCFtRQy//udc54n
        zzlv8jJpXCXDl3k66bxAnMRP9CfYeJ01MPAdw5EfYvbV1IYiY5edQLqqSgIp069jyDwziiOn
        uo2BfjfLcTSb/j0NVZpkGJpythKo2zHOQLqHrsGDkhYC9WoX6eh5fjlAU20mDBUP12FopEKC
        uhVCJDf20ZGlsRNHf8nrCTTQoCOQNG+JjlRFl2hIMeTqTWnzCbSytEpHXW0dOLIWZODoZvsq
        hoZVfwCkv7kL9TcXYsgkdSVX5DgZqDRrlo4q7+kZqF3ZjKG1qQU6avpxEkPdN/IAUiznAmQ2
        FhOopOoXBmrt/Akg+VjIIR61sqwGVJ60D6dyVox0ylQ2glHFdilO3dGOMyh50yMGVVMaROkt
        dozKcsjpVHX5ZYIaG7QQVIdmBadUxc2Ayu/8jHqoKQJRvifYB04JEk+nCMR7D55kxyumLYQo
        XwG+cXaraVLQKMoELCYk34PT2ZcZmYDN5JJmAGuM8zRPMQ/gRNYDzFMsAthlNtE2LfbCjg1L
        I4D/3k7fKP4BcFp2dV1FkDxY3mDB3byFNBJwsfsTt4hGjmPQMDPLcA+8yAg496Ka7macDID3
        swzAzRzyIBx0FGzEbYO5/UvrehYZBodfjOEezRuwM9e2zjSX5lJt3vrikGxkwxmnfsN8GF4z
        jG6wF3zWbmJ42BfaszNczHRxKqxVpXm8cgDv6nIIjyYM2vqK6G4NjQyEVQ17Pe234LX7BsyT
        +xpUrtgwT58D6/M3OQDKR27RPewH/56bwz1MQWW9FXheSw2gukBDqMB27Uv3aF+6R/t/dCGg
        lQMfgUgijBNIQkTBSYJUnoQvlCQnxfFizwqrwfqPCYqoB+OTs7xWgDFBK4BMmv8WDhDKY7ic
        U/xvvxOIz0aLkxMFklbgx8T9vTnkmiyGS8bxzwsSBAKRQLw5xZgsXykGGMbs+F/PneSGLJ45
        8Jtx4aPwo6F2b27LDpYotPfKo+zV3pA/J6SKng+Dw3WjcUzkFTgY8nTrbvOV0E9fnV8Y+WLP
        1NevJOSyLoTv2fokeVSTss+5YzJD+EH/46jxxI9P5N7VPE9rsx0bGngz7enrNtsR/eMuJt5h
        k144c3QbO8onW2/d/65aT7apI3bdu1O6fyR1oUTWePFWpDmw2ie2omfsSY8mEg4KSx0p3txj
        SkWm5f2I6EiejN/y5XGj4+LblttX/QLqJlhW5drOw7IBh+RZIgj4Shw+fyNseefoz9MDsbvL
        rF5xn5cNJVBZqu0Kp4E411vdFJ2RfoijKzpubnD445J4fnAQTSzh/wfGoIsNoAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0xbdRiG/Z1rS2Q5KyQ7gkLGnBfCEBTMp1mKcQTPjDd0GmeyYGEnbFlb
        mnbg0LkUVsW1DBsgsxTkUnYpbdkAEbmUiZ0r1JXbZpAhGAljXR1hgGMwCp0tzGT/vXmfJ9/7
        zyfART+TEYKD8sO8Ui6RxlAhRNulmOgdWR8UZSa4PGHQfMVLQdUFGwUnC7/DoOvWnwSslTpp
        mOzSEDBX+BUOttYCDKbWHBS4ZyZoqBoMgP6zv1AwZLxHwu1qC4IpZysGptE2DK5bVeDWyUDT
        PEyCvdtFwB1NOwXXOqsoUFcukaCvO46D7o9AN2WspsC35CfhirOPgEs1XxNwrtePwah+GkH9
        uWfgak8tBq3qwLK1fI0Gc/EcCbZf62noPdmDwYOpRRIufvM3Bu4zlQh0KxUIuppNFJy90EiD
        w/U9As148mvxnG+lFHGV6mGCK/c1k1xrw3WMM3nVBNdhnKA5zcUxmvvBHMvV270YVzyjIbkW
        ywmKGx+xU1yfwUdwelMP4qpd6dygoQ69F/FJyM79vPRgHq98QfxpyAGdx04pqnXoyJq7FFej
        boUWCQUsk8R6a/toLQoRiJguxNo7lvENEMne998hNnIY2+D3PJQWEOtt8FJBQDHxrKXTTgRB
        ODNBsTeLStYtnPFgbNNk3/qpMGY3Oz/bQgYzwWxnfys+j4I5lBGzIzM1D+ei2YqrS3QwC5kU
        dnR2fH1aFHCc5XXUhr+ZdVXcWO/xgH/8x0pcjxjjI8j4CKpFmAU9wStUsmyZKlGRKOc/i1dJ
        ZKpceXZ8Vo6sBa3/WOzz7egny1y8A2EC5ECsAI8JD0UyTaYodL8k/3NemZOhzJXyKgeKFBAx
        W0KHtK4MEZMtOcwf4nkFr/yfYgJhhBpLNuQtDKd4T0ftIhJOCVvEjSbJyHTBTfc0kzMk/Ktp
        Z1T43ZVy845npfWulC5Dx92t/ZuMheJ94Yptu7y7nR5109vLlD4/Tvq0+ghrzX1ZM9j9ZLr7
        suDD8Kx/0qJte9OJyeXGVXmZ9sS9uITNeh9t7i/IX70RnSbbkrFaFvHi0U0Di8aVraqmW0ym
        2PZv6kzE6fnnEvaGUf1tjaizLXWyoWZg4czlN6nZ22N9umtxHy0ankpyzA68tEe8Pe1bPNQP
        R/Pe31ei/D2y89095i+PDb3ly/aU2Ba2vWLl76diSVHjj2nlx1Jej2LbNW8c+vhBmXX+fHNR
        7+Pv9CZ/MfaqQ6GOIVQHJImxuFIl+Q+u8EN70gMAAA==
X-CMS-MailID: 20220520083755epcas5p454d450935fb427fd270295e967b0cbe8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20220520083755epcas5p454d450935fb427fd270295e967b0cbe8
References: <20220520083701.2610975-1-maninder1.s@samsung.com>
        <CGME20220520083755epcas5p454d450935fb427fd270295e967b0cbe8@epcas5p4.samsung.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Although *lookup* APIs are safe, but better to pass size
as an argument rather than using define KSYM_NAME_LEN.
Because it can cause issue if called with lesser array size.

Co-developed-by: Onkarnath <onkarnath.1@samsung.com>
Signed-off-by: Onkarnath <onkarnath.1@samsung.com>
Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
---
 arch/hexagon/kernel/traps.c        |  2 +-
 arch/powerpc/xmon/xmon.c           |  4 ++--
 fs/proc/base.c                     |  2 +-
 include/linux/kallsyms.h           |  8 ++++----
 include/linux/module.h             |  8 ++++----
 kernel/debug/kdb/kdb_support.c     |  2 +-
 kernel/kallsyms.c                  | 24 ++++++++++++------------
 kernel/kprobes.c                   |  4 ++--
 kernel/locking/lockdep.c           |  8 ++++----
 kernel/locking/lockdep_internals.h |  2 +-
 kernel/locking/lockdep_proc.c      |  4 ++--
 kernel/module/kallsyms.c           |  8 ++++----
 kernel/trace/ftrace.c              |  9 +++++----
 kernel/trace/trace_kprobe.c        |  2 +-
 kernel/trace/trace_output.c        |  2 +-
 kernel/trace/trace_syscalls.c      |  2 +-
 16 files changed, 46 insertions(+), 45 deletions(-)

diff --git a/arch/hexagon/kernel/traps.c b/arch/hexagon/kernel/traps.c
index 65b30b6ea226..a0306e96e82c 100644
--- a/arch/hexagon/kernel/traps.c
+++ b/arch/hexagon/kernel/traps.c
@@ -118,7 +118,7 @@ static void do_show_stack(struct task_struct *task, unsigned long *fp,
 
 	for (i = 0; i < kstack_depth_to_print; i++) {
 
-		name = kallsyms_lookup(ip, &size, &offset, &modname, tmpstr);
+		name = kallsyms_lookup(ip, &size, &offset, &modname, tmpstr, KSYM_NAME_LEN);
 
 		printk("%s[%p] 0x%lx: %s + 0x%lx", loglvl, fp, ip, name, offset);
 		if (((unsigned long) fp < low) || (high < (unsigned long) fp))
diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 3441fc70ac92..183e2a55ba5c 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -1710,7 +1710,7 @@ static void get_function_bounds(unsigned long pc, unsigned long *startp,
 	if (setjmp(bus_error_jmp) == 0) {
 		catch_memory_errors = 1;
 		sync();
-		name = kallsyms_lookup(pc, &size, &offset, NULL, tmpstr);
+		name = kallsyms_lookup(pc, &size, &offset, NULL, tmpstr, KSYM_NAME_LEN);
 		if (name != NULL) {
 			*startp = pc - offset;
 			*endp = pc - offset + size;
@@ -3730,7 +3730,7 @@ static void xmon_print_symbol(unsigned long address, const char *mid,
 		catch_memory_errors = 1;
 		sync();
 		name = kallsyms_lookup(address, &size, &offset, &modname,
-				       tmpstr);
+				       tmpstr, KSYM_NAME_LEN);
 		sync();
 		/* wait a little while to see if we get a machine check */
 		__delay(200);
diff --git a/fs/proc/base.c b/fs/proc/base.c
index 617816168748..939006f3b2b0 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -392,7 +392,7 @@ static int proc_pid_wchan(struct seq_file *m, struct pid_namespace *ns,
 		goto print0;
 
 	wchan = get_wchan(task);
-	if (wchan && !lookup_symbol_name(wchan, symname)) {
+	if (wchan && !lookup_symbol_name(wchan, symname, KSYM_NAME_LEN)) {
 		seq_puts(m, symname);
 		return 0;
 	}
diff --git a/include/linux/kallsyms.h b/include/linux/kallsyms.h
index 598ff08c72d6..8fe535fd848a 100644
--- a/include/linux/kallsyms.h
+++ b/include/linux/kallsyms.h
@@ -81,7 +81,7 @@ extern int kallsyms_lookup_size_offset(unsigned long addr,
 const char *kallsyms_lookup(unsigned long addr,
 			    unsigned long *symbolsize,
 			    unsigned long *offset,
-			    char **modname, char *namebuf);
+			    char **modname, char *namebuf, size_t size);
 
 /* Look up a kernel symbol and return it in a text buffer. */
 extern int sprint_symbol(char *buffer, size_t size, unsigned long address);
@@ -90,7 +90,7 @@ extern int sprint_symbol_no_offset(char *buffer, size_t size, unsigned long addr
 extern int sprint_backtrace(char *buffer, size_t size, unsigned long address);
 extern int sprint_backtrace_build_id(char *buffer, size_t size, unsigned long address);
 
-int lookup_symbol_name(unsigned long addr, char *symname);
+int lookup_symbol_name(unsigned long addr, char *symname, size_t size);
 int lookup_symbol_attrs(unsigned long addr, unsigned long *size, unsigned long *offset, char *modname, char *name);
 
 /* How and when do we show kallsyms values? */
@@ -113,7 +113,7 @@ static inline int kallsyms_lookup_size_offset(unsigned long addr,
 static inline const char *kallsyms_lookup(unsigned long addr,
 					  unsigned long *symbolsize,
 					  unsigned long *offset,
-					  char **modname, char *namebuf)
+					  char **modname, char *namebuf, size_t size)
 {
 	return NULL;
 }
@@ -148,7 +148,7 @@ static inline int sprint_backtrace_build_id(char *buffer, size_t size, unsigned
 	return 0;
 }
 
-static inline int lookup_symbol_name(unsigned long addr, char *symname)
+static inline int lookup_symbol_name(unsigned long addr, char *symname, size_t size)
 {
 	return -ERANGE;
 }
diff --git a/include/linux/module.h b/include/linux/module.h
index abd9fa916b7d..9b91209d615f 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -656,8 +656,8 @@ const char *module_address_lookup(unsigned long addr,
 			    unsigned long *symbolsize,
 			    unsigned long *offset,
 			    char **modname, const unsigned char **modbuildid,
-			    char *namebuf);
-int lookup_module_symbol_name(unsigned long addr, char *symname);
+			    char *namebuf, size_t buf_size);
+int lookup_module_symbol_name(unsigned long addr, char *symname, size_t size);
 int lookup_module_symbol_attrs(unsigned long addr, unsigned long *size, unsigned long *offset, char *modname, char *name);
 
 int register_module_notifier(struct notifier_block *nb);
@@ -756,12 +756,12 @@ static inline const char *module_address_lookup(unsigned long addr,
 					  unsigned long *offset,
 					  char **modname,
 					  const unsigned char **modbuildid,
-					  char *namebuf)
+					  char *namebuf, size_t buf_size)
 {
 	return NULL;
 }
 
-static inline int lookup_module_symbol_name(unsigned long addr, char *symname)
+static inline int lookup_module_symbol_name(unsigned long addr, char *symname, size_t size)
 {
 	return -ERANGE;
 }
diff --git a/kernel/debug/kdb/kdb_support.c b/kernel/debug/kdb/kdb_support.c
index 0a39497140bf..bf19e9587c23 100644
--- a/kernel/debug/kdb/kdb_support.c
+++ b/kernel/debug/kdb/kdb_support.c
@@ -92,7 +92,7 @@ int kdbnearsym(unsigned long addr, kdb_symtab_t *symtab)
 		goto out;
 
 	symtab->sym_name = kallsyms_lookup(addr, &symbolsize , &offset,
-				(char **)(&symtab->mod_name), namebuf);
+				(char **)(&symtab->mod_name), namebuf, KSYM_NAME_LEN);
 	if (offset > 8*1024*1024) {
 		symtab->sym_name = NULL;
 		addr = offset = symbolsize = 0;
diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index 9e4316fe0ba1..d6efce28505d 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -342,18 +342,18 @@ int kallsyms_lookup_size_offset(unsigned long addr, unsigned long *symbolsize,
 		get_symbol_pos(addr, symbolsize, offset);
 		return 1;
 	}
-	return !!module_address_lookup(addr, symbolsize, offset, NULL, NULL, namebuf) ||
+	return !!module_address_lookup(addr, symbolsize, offset, NULL, NULL, namebuf, KSYM_NAME_LEN) ||
 	       !!__bpf_address_lookup(addr, symbolsize, offset, namebuf);
 }
 
 static const char *kallsyms_lookup_buildid(unsigned long addr,
 			unsigned long *symbolsize,
 			unsigned long *offset, char **modname,
-			const unsigned char **modbuildid, char *namebuf)
+			const unsigned char **modbuildid, char *namebuf, size_t size)
 {
 	const char *ret;
 
-	namebuf[KSYM_NAME_LEN - 1] = 0;
+	namebuf[size - 1] = 0;
 	namebuf[0] = 0;
 
 	if (is_ksym_addr(addr)) {
@@ -362,7 +362,7 @@ static const char *kallsyms_lookup_buildid(unsigned long addr,
 		pos = get_symbol_pos(addr, symbolsize, offset);
 		/* Grab name */
 		kallsyms_expand_symbol(get_symbol_offset(pos),
-				       namebuf, KSYM_NAME_LEN);
+				       namebuf, size);
 		if (modname)
 			*modname = NULL;
 		if (modbuildid)
@@ -374,7 +374,7 @@ static const char *kallsyms_lookup_buildid(unsigned long addr,
 
 	/* See if it's in a module or a BPF JITed image. */
 	ret = module_address_lookup(addr, symbolsize, offset,
-				    modname, modbuildid, namebuf);
+				    modname, modbuildid, namebuf, size);
 	if (!ret)
 		ret = bpf_address_lookup(addr, symbolsize,
 					 offset, modname, namebuf);
@@ -398,18 +398,18 @@ static const char *kallsyms_lookup_buildid(unsigned long addr,
 const char *kallsyms_lookup(unsigned long addr,
 			    unsigned long *symbolsize,
 			    unsigned long *offset,
-			    char **modname, char *namebuf)
+			    char **modname, char *namebuf, size_t size)
 {
 	return kallsyms_lookup_buildid(addr, symbolsize, offset, modname,
-				       NULL, namebuf);
+				       NULL, namebuf, size);
 }
 
-int lookup_symbol_name(unsigned long addr, char *symname)
+int lookup_symbol_name(unsigned long addr, char *symname, size_t size)
 {
 	int res;
 
 	symname[0] = '\0';
-	symname[KSYM_NAME_LEN - 1] = '\0';
+	symname[size - 1] = '\0';
 
 	if (is_ksym_addr(addr)) {
 		unsigned long pos;
@@ -417,11 +417,11 @@ int lookup_symbol_name(unsigned long addr, char *symname)
 		pos = get_symbol_pos(addr, NULL, NULL);
 		/* Grab name */
 		kallsyms_expand_symbol(get_symbol_offset(pos),
-				       symname, KSYM_NAME_LEN);
+				       symname, size);
 		goto found;
 	}
 	/* See if it's in a module. */
-	res = lookup_module_symbol_name(addr, symname);
+	res = lookup_module_symbol_name(addr, symname, size);
 	if (res)
 		return res;
 
@@ -470,7 +470,7 @@ static int __sprint_symbol(char *buffer, size_t buf_size, unsigned long address,
 
 	address += symbol_offset;
 	name = kallsyms_lookup_buildid(address, &size, &offset, &modname, &buildid,
-				       buffer);
+				       buffer, buf_size);
 	if (!name)
 		return scnprintf(buffer, buf_size, "0x%lx", address - symbol_offset);
 
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index dd58c0be9ce2..3b362b70e72b 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1478,7 +1478,7 @@ bool within_kprobe_blacklist(unsigned long addr)
 		return true;
 
 	/* Check if the address is on a suffixed-symbol */
-	if (!lookup_symbol_name(addr, symname)) {
+	if (!lookup_symbol_name(addr, symname, KSYM_NAME_LEN)) {
 		p = strchr(symname, '.');
 		if (!p)
 			return false;
@@ -2806,7 +2806,7 @@ static int show_kprobe_addr(struct seq_file *pi, void *v)
 	preempt_disable();
 	hlist_for_each_entry_rcu(p, head, hlist) {
 		sym = kallsyms_lookup((unsigned long)p->addr, NULL,
-					&offset, &modname, namebuf);
+					&offset, &modname, namebuf, KSYM_NAME_LEN);
 		if (kprobe_aggrprobe(p)) {
 			list_for_each_entry_rcu(kp, &p->list, list)
 				report_probe(pi, kp, sym, offset, modname, p);
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 81e87280513e..c74bbf90fdfb 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -659,9 +659,9 @@ static const char *usage_str[] =
 };
 #endif
 
-const char *__get_key_name(const struct lockdep_subclass_key *key, char *str)
+const char *__get_key_name(const struct lockdep_subclass_key *key, char *str, size_t size)
 {
-	return kallsyms_lookup((unsigned long)key, NULL, NULL, NULL, str);
+	return kallsyms_lookup((unsigned long)key, NULL, NULL, NULL, str, size);
 }
 
 static inline unsigned long lock_flag(enum lock_usage_bit bit)
@@ -715,7 +715,7 @@ static void __print_lock_name(struct lock_class *class)
 
 	name = class->name;
 	if (!name) {
-		name = __get_key_name(class->key, str);
+		name = __get_key_name(class->key, str, KSYM_NAME_LEN);
 		printk(KERN_CONT "%s", name);
 	} else {
 		printk(KERN_CONT "%s", name);
@@ -746,7 +746,7 @@ static void print_lockdep_cache(struct lockdep_map *lock)
 
 	name = lock->name;
 	if (!name)
-		name = __get_key_name(lock->key->subkeys, str);
+		name = __get_key_name(lock->key->subkeys, str, KSYM_NAME_LEN);
 
 	printk(KERN_CONT "%s", name);
 }
diff --git a/kernel/locking/lockdep_internals.h b/kernel/locking/lockdep_internals.h
index bbe9000260d0..ab32ee6a0c87 100644
--- a/kernel/locking/lockdep_internals.h
+++ b/kernel/locking/lockdep_internals.h
@@ -129,7 +129,7 @@ extern void get_usage_chars(struct lock_class *class,
 			    char usage[LOCK_USAGE_CHARS]);
 
 extern const char *__get_key_name(const struct lockdep_subclass_key *key,
-				  char *str);
+				  char *str, size_t size);
 
 struct lock_class *lock_chain_get_class(struct lock_chain *chain, int i);
 
diff --git a/kernel/locking/lockdep_proc.c b/kernel/locking/lockdep_proc.c
index 15fdc7fa5c68..bf4ca5ec109e 100644
--- a/kernel/locking/lockdep_proc.c
+++ b/kernel/locking/lockdep_proc.c
@@ -63,7 +63,7 @@ static void print_name(struct seq_file *m, struct lock_class *class)
 	const char *name = class->name;
 
 	if (!name) {
-		name = __get_key_name(class->key, str);
+		name = __get_key_name(class->key, str, KSYM_NAME_LEN);
 		seq_printf(m, "%s", name);
 	} else{
 		seq_printf(m, "%s", name);
@@ -485,7 +485,7 @@ static void seq_stats(struct seq_file *m, struct lock_stat_data *data)
 		char str[KSYM_NAME_LEN];
 		const char *key_name;
 
-		key_name = __get_key_name(ckey, str);
+		key_name = __get_key_name(ckey, str, KSYM_NAME_LEN);
 		snprintf(name, namelen, "%s", key_name);
 	} else {
 		snprintf(name, namelen, "%s", cname);
diff --git a/kernel/module/kallsyms.c b/kernel/module/kallsyms.c
index 3e11523bc6f6..c982860405c6 100644
--- a/kernel/module/kallsyms.c
+++ b/kernel/module/kallsyms.c
@@ -320,7 +320,7 @@ const char *module_address_lookup(unsigned long addr,
 			    unsigned long *offset,
 			    char **modname,
 			    const unsigned char **modbuildid,
-			    char *namebuf)
+			    char *namebuf, size_t buf_size)
 {
 	const char *ret = NULL;
 	struct module *mod;
@@ -342,7 +342,7 @@ const char *module_address_lookup(unsigned long addr,
 	}
 	/* Make a copy in here where it's safe */
 	if (ret) {
-		strncpy(namebuf, ret, KSYM_NAME_LEN - 1);
+		strncpy(namebuf, ret, buf_size - 1);
 		ret = namebuf;
 	}
 	preempt_enable();
@@ -350,7 +350,7 @@ const char *module_address_lookup(unsigned long addr,
 	return ret;
 }
 
-int lookup_module_symbol_name(unsigned long addr, char *symname)
+int lookup_module_symbol_name(unsigned long addr, char *symname, size_t size)
 {
 	struct module *mod;
 
@@ -365,7 +365,7 @@ int lookup_module_symbol_name(unsigned long addr, char *symname)
 			if (!sym)
 				goto out;
 
-			strscpy(symname, sym, KSYM_NAME_LEN);
+			strscpy(symname, sym, size);
 			preempt_enable();
 			return 0;
 		}
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index c12bcd26cb17..4d9a8621eaac 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -520,7 +520,7 @@ static int function_stat_show(struct seq_file *m, void *v)
 		goto out;
 #endif
 
-	kallsyms_lookup(rec->ip, NULL, NULL, NULL, str);
+	kallsyms_lookup(rec->ip, NULL, NULL, NULL, str, KSYM_SYMBOL_LEN);
 	seq_printf(m, "  %-30.30s  %10lu", str, rec->counter);
 
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
@@ -3980,7 +3980,7 @@ ftrace_match_record(struct dyn_ftrace *rec, struct ftrace_glob *func_g,
 	char str[KSYM_SYMBOL_LEN];
 	char *modname;
 
-	kallsyms_lookup(rec->ip, NULL, NULL, &modname, str);
+	kallsyms_lookup(rec->ip, NULL, NULL, &modname, str, KSYM_SYMBOL_LEN);
 
 	if (mod_g) {
 		int mod_matches = (modname) ? ftrace_match(modname, mod_g) : 0;
@@ -4738,7 +4738,7 @@ unregister_ftrace_function_probe_func(char *glob, struct trace_array *tr,
 
 			if (func_g.search) {
 				kallsyms_lookup(entry->ip, NULL, NULL,
-						NULL, str);
+						NULL, str, KSYM_SYMBOL_LEN);
 				if (!ftrace_match(str, &func_g))
 					continue;
 			}
@@ -6846,7 +6846,8 @@ static void save_ftrace_mod_rec(struct ftrace_mod_map *mod_map,
 	char *modname;
 	const char *ret;
 
-	ret = kallsyms_lookup(rec->ip, &symsize, &offset, &modname, str);
+	ret = kallsyms_lookup(rec->ip, &symsize, &offset, &modname,
+				str, KSYM_SYMBOL_LEN);
 	if (!ret)
 		return;
 
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 47cebef78532..8a1d2a0dc2dc 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -456,7 +456,7 @@ static bool within_notrace_func(struct trace_kprobe *tk)
 		return false;
 
 	/* Check if the address is on a suffixed-symbol */
-	if (!lookup_symbol_name(addr, symname)) {
+	if (!lookup_symbol_name(addr, symname, KSYM_NAME_LEN)) {
 		p = strchr(symname, '.');
 		if (!p)
 			return true;
diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index 2a6ec049cab5..0d3e1c9b59fb 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -364,7 +364,7 @@ trace_seq_print_sym(struct trace_seq *s, unsigned long address, bool offset)
 	if (offset)
 		sprint_symbol(str, KSYM_SYMBOL_LEN, address);
 	else
-		kallsyms_lookup(address, NULL, NULL, NULL, str);
+		kallsyms_lookup(address, NULL, NULL, NULL, str, KSYM_SYMBOL_LEN);
 	name = kretprobed(str, address);
 
 	if (name && strlen(name)) {
diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.c
index f755bde42fd0..3a67877ce658 100644
--- a/kernel/trace/trace_syscalls.c
+++ b/kernel/trace/trace_syscalls.c
@@ -89,7 +89,7 @@ find_syscall_meta(unsigned long syscall)
 
 	start = __start_syscalls_metadata;
 	stop = __stop_syscalls_metadata;
-	kallsyms_lookup(syscall, NULL, NULL, NULL, str);
+	kallsyms_lookup(syscall, NULL, NULL, NULL, str, KSYM_SYMBOL_LEN);
 
 	if (arch_syscall_match_sym_name(str, "sys_ni_syscall"))
 		return NULL;
-- 
2.17.1

