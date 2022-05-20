Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC6A352E7CC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 May 2022 10:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347282AbiETIjO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 May 2022 04:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347242AbiETIjC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 May 2022 04:39:02 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F5F69D4F3;
        Fri, 20 May 2022 01:39:00 -0700 (PDT)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220520083858epoutp01f63876db122f22a254f3048e34e755eb~ww22eq2bc2582325823epoutp01I;
        Fri, 20 May 2022 08:38:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220520083858epoutp01f63876db122f22a254f3048e34e755eb~ww22eq2bc2582325823epoutp01I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1653035938;
        bh=tGQbcADDC9Fa03PFlfhjPFDOHvT6aH+E1Jkc3ryxF7Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tsu5EaV+kpXXRtq0bfaZOYjgr0vXVUkPsQah8PfwSdBSUlscRsrKfxiOlZlTcz7Tv
         CwUHypFtFHa9ibH3iF4X64NQKQWCL6SyK/HY5lChVqIgO1OdJpnxbO7Ky/Lsy5MKQb
         9q6CTX8IXnAQO8jwstpIeAldIC7fTvS1kmwIy4JE=
Received: from epsmges5p3new.samsung.com (unknown [182.195.42.75]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20220520083858epcas5p3b3b9c0bac758e8667d9ce6aaf1cf413f~ww22B7AA20239702397epcas5p3D;
        Fri, 20 May 2022 08:38:58 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        47.83.09762.2A357826; Fri, 20 May 2022 17:38:58 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20220520083725epcas5p1c3e2989c991e50603a40c81ccc4982e0~ww1fHeaQi0616006160epcas5p1U;
        Fri, 20 May 2022 08:37:25 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220520083724epsmtrp2c9780becbc7d0a832da74153df35b414~ww1fF2Byh1034110341epsmtrp2M;
        Fri, 20 May 2022 08:37:24 +0000 (GMT)
X-AuditID: b6c32a4b-1fdff70000002622-27-628753a219df
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        E6.F7.08924.44357826; Fri, 20 May 2022 17:37:24 +0900 (KST)
Received: from localhost.localdomain (unknown [107.109.224.44]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220520083716epsmtip24bdb8c10deccb8563372f2c9e2f53548~ww1XlR8I13055130551epsmtip2Q;
        Fri, 20 May 2022 08:37:16 +0000 (GMT)
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
Subject: [PATCH 1/5] kallsyms: pass buffer size in sprint_* APIs
Date:   Fri, 20 May 2022 14:06:57 +0530
Message-Id: <20220520083701.2610975-2-maninder1.s@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220520083701.2610975-1-maninder1.s@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02TfVBUVRjGOXfvvbuss3UBzSNU1BKSNGFmO3MaHbCGhjuWjSmZ4xS6xB0g
        Plx3BYx/WGCLYNkGEIRdvkE+WvluQdhF4xsWcQiYVkAoBCpBwgUEDATaD5j873fe93nP8z5n
        5nBY9nK2Iyc4/DIjDheG8kku3tB+wO3totMJ/u/cHOSh2jszJMqpriCRIi4TQ7qH93G0kdbF
        Rg90MhwZ475joQpNLIamNtpI1Dc3zkY5/abG3dJWEv2qWiHQozw1QFNdGgwVDTdgaOSGBPXJ
        w5CsdoBAzbf0OHosayTRkDaHRNLsVQKlFMazkPyeqTalyiPR+uomge509eCoPf97HJV1b2Jo
        OOVPgIrL9qPBlgIMaaQm5xvpG2xUnmwkUEVHMRt1K1owtDW1TKDbP0xgqK8kGyD5mhIgXW0R
        iUqrK9moTZ8LkGxMcMyDXl9LA3S2dACn09drCVrz0whGF81IcbpJNc6mZbdH2fTP5e50cfMM
        RifPyQi6Tp1I0mOGZpLuyVrH6ZSiFkDn6T+j+7MKwUnHc9yjAUxocCQjPuh5gRs0fS2WLRo9
        c+WJ3oBJQZJPErDlQOo92DIxgJnZntIBqO0BSYBr4kUAKzvbWdbDEoANlXL2zkRByQRubWgB
        /KWxFbMengCY2fI3MKtIygOqtc24mXdTtSRc6TthFrGocQxWPTRarnKgjsGClU4L45QrVFf1
        E2bmUZ5wcn4Js9o5Q+XgqkVjS3nB4fkx3Kqxg3rltIVZJk18fbZlV0h1cmGcLBa3DntD44/x
        pJUd4Gy3ZjuDI1yav2Wqc0wcBetTYqyzMlOcnPRtvRecHigkzBoWdQBWaw9ay6/AjN4qzOr7
        AlSsT2/vyYONeTvsCmUjNYSVneDSwsL2OjRc7n20/cBpAC5ezyRSwGuq5/Konsuj+t+6ALDU
        YB8jkoQFMhKB6HA4E+UhEYZJIsIDPb6+GFYHLP/F/eNGMDlh9GgDGAe0Achh8XfzQJjM354X
        IPw2mhFfPC+OCGUkbcCJg/P38qitWH97KlB4mQlhGBEj3uliHFtHKfZW1GbM8a2OyC+uOz0L
        mHERhf6Vv/9SfGOy0W7pyz1Cp8ibIVVPz2eeVLwkUC+67HpTVdlB7Ivh6kWtwxm//3bIxTXe
        q6Q8aW9dSH4qin7/qxOG+j/USueFEYdAeUTixr250tFo35h6b9cFQfPLCRfcrtm0vvtY6Z/b
        lHA/qO+fVdDx4F+d2NlvWfdixDe9Cse61g63Cr78k1VB2fyrnkMZ3nez1wj+h4cVM1V2QzYj
        nx6pHjx9XGfzzGcx9VTNufLES/KzR/Erc2eSU/u1UqUmwTcxS2D3hiFBM6Txmuz+wBA5Z3BL
        9Zkq2HX2yOdXx0899Wuqkfkuzgb7vZ47u6dcMf6RP+LjkiDhIXeWWCL8D65vPVieBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sf1CTdRzH7/vseZ79KOwJzJ7wPGqddXEXiGf5yYzwgniu0jTUMK+jKc8N
        jSFtCEpnzrEiBsPlcQiDcGMhsvFDEDhwa4dDcTvWAXKHyI9uCjFJ2QgDcgtqg7rzv/fn/X59
        7v3548PjhFqIcN6RjCxWmiFKF5ICvL1bGPF6fFL+oU239VuguXeahMqmehLUivMYmO+P4rB0
        rocLd81KHGYV33KgvvUMBhNLNhKcD8e5UNkXCH65eI2Efu0CAQ+qjAgmeloxqB5ux+COSQbO
        QgkomwcIsPzswMGr7CBh8GolCfKKRQI0+jwOFN4OeBPaKhL8i8sE9PbYcei+8B0OtTeXMRjW
        /IbAUPsK3OrSYdAqDzSbSpa4cKloloD66wYu3FR3YfDPxDwB1u9dGDhrKhAU+soRmJurSbjY
        1MAFm+NHBMqxN+KiGL/vHGIq5AM4U+JvJpjWujsYUz0tx5lO7TiXUVpHuMyVS5GMwTKNMUUP
        lQTTYiwgmbEhC8nYy/w4o6nuQkyVYw/TV6ZHu8M/E2xPZdOPZLPS6NgvBGmTpWe4mSP7T/zp
        GMLkSJWoQnweTW2hdTUuPKhDqQ5Eu9Vpq/56+vGyF1/VYXTdspu7yswhuuzG7qAmqSjaeNUS
        YAS8tdQ4SU/lF3ODA4dyY/Tlu3ZOkAqj4mjdwo2VbZzaSBsb+4igDqFi6XueR9hqQwRdfmtx
        heFT79LDnrH/Loqle0r05Cr/LO0on1zxOQE+r62Co0GU9olI+0SkQ5gRvcBmyiRiiSwmc3MG
        mxMlE0lkxzPEUYePSVrQyoNFRnYgi3E2yoYwHrIhmscRrg1BEuWh0JBU0clcVnosRXo8nZXZ
        0HoeLnw+pF/lSAmlxKIs9kuWzWSl/6cYjx8ux64fLtZcUe8gUopPOzqz87eaZfcruwaiT5/9
        1XWAv7fu2mYj+bZs59MwernF4PckN2Kv7dk28454DX9SOTg0rDc39ndfuPdRaZZ11+eNA4mD
        cdHrvjpoejkn+dW/t8+EJ+wreBRxnrNsH3kp19mWM+csfWbx04NZnk8iamv29tpcSU/t9/9U
        kz01N7Vh2w8P3mLWnP3rxIsz9u6EurYDf8R/rW9v8aU+HrVu6Depfe6t/oU3vwHTyZiiU8K5
        o4oq7770NBWWtK7T6vQI8nZ8TBpGkxW/b3IfVWx8r9Nrsuftisg+Fa8kGhy5igIk1j0nT0jM
        mW9qmPdivg+mVe8L8A/DXDuFuCxNFBPJkcpE/wKKLVJUzwMAAA==
X-CMS-MailID: 20220520083725epcas5p1c3e2989c991e50603a40c81ccc4982e0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20220520083725epcas5p1c3e2989c991e50603a40c81ccc4982e0
References: <20220520083701.2610975-1-maninder1.s@samsung.com>
        <CGME20220520083725epcas5p1c3e2989c991e50603a40c81ccc4982e0@epcas5p1.samsung.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

As of now sprint_* APIs don't pass buffer size as an argument
and use sprintf directly.

To replace dangerous sprintf API to scnprintf,
buffer size is required in arguments.

Co-developed-by: Onkarnath <onkarnath.1@samsung.com>
Signed-off-by: Onkarnath <onkarnath.1@samsung.com>
Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
---
 arch/s390/lib/test_unwind.c    |  2 +-
 drivers/scsi/fnic/fnic_trace.c |  8 ++++----
 include/linux/kallsyms.h       | 20 ++++++++++----------
 init/main.c                    |  2 +-
 kernel/kallsyms.c              | 27 ++++++++++++++++-----------
 kernel/trace/trace_output.c    |  2 +-
 lib/vsprintf.c                 | 10 +++++-----
 7 files changed, 38 insertions(+), 33 deletions(-)

diff --git a/arch/s390/lib/test_unwind.c b/arch/s390/lib/test_unwind.c
index 5a053b393d5c..adbc2b53db16 100644
--- a/arch/s390/lib/test_unwind.c
+++ b/arch/s390/lib/test_unwind.c
@@ -75,7 +75,7 @@ static noinline int test_unwind(struct task_struct *task, struct pt_regs *regs,
 			ret = -EINVAL;
 			break;
 		}
-		sprint_symbol(sym, addr);
+		sprint_symbol(sym, KSYM_SYMBOL_LEN, addr);
 		if (bt_pos < BT_BUF_SIZE) {
 			bt_pos += snprintf(bt + bt_pos, BT_BUF_SIZE - bt_pos,
 					   state.reliable ? " [%-7s%px] %pSR\n" :
diff --git a/drivers/scsi/fnic/fnic_trace.c b/drivers/scsi/fnic/fnic_trace.c
index 4a7536bb0ab3..33acaa9bb4ba 100644
--- a/drivers/scsi/fnic/fnic_trace.c
+++ b/drivers/scsi/fnic/fnic_trace.c
@@ -128,10 +128,10 @@ int fnic_get_trace_data(fnic_dbgfs_t *fnic_dbgfs_prt)
 			}
 			/* Convert function pointer to function name */
 			if (sizeof(unsigned long) < 8) {
-				sprint_symbol(str, tbp->fnaddr.low);
+				sprint_symbol(str, KSYM_SYMBOL_LEN, tbp->fnaddr.low);
 				jiffies_to_timespec64(tbp->timestamp.low, &val);
 			} else {
-				sprint_symbol(str, tbp->fnaddr.val);
+				sprint_symbol(str, KSYM_SYMBOL_LEN, tbp->fnaddr.val);
 				jiffies_to_timespec64(tbp->timestamp.val, &val);
 			}
 			/*
@@ -170,10 +170,10 @@ int fnic_get_trace_data(fnic_dbgfs_t *fnic_dbgfs_prt)
 			}
 			/* Convert function pointer to function name */
 			if (sizeof(unsigned long) < 8) {
-				sprint_symbol(str, tbp->fnaddr.low);
+				sprint_symbol(str, KSYM_SYMBOL_LEN, tbp->fnaddr.low);
 				jiffies_to_timespec64(tbp->timestamp.low, &val);
 			} else {
-				sprint_symbol(str, tbp->fnaddr.val);
+				sprint_symbol(str, KSYM_SYMBOL_LEN, tbp->fnaddr.val);
 				jiffies_to_timespec64(tbp->timestamp.val, &val);
 			}
 			/*
diff --git a/include/linux/kallsyms.h b/include/linux/kallsyms.h
index 649faac31ddb..598ff08c72d6 100644
--- a/include/linux/kallsyms.h
+++ b/include/linux/kallsyms.h
@@ -84,11 +84,11 @@ const char *kallsyms_lookup(unsigned long addr,
 			    char **modname, char *namebuf);
 
 /* Look up a kernel symbol and return it in a text buffer. */
-extern int sprint_symbol(char *buffer, unsigned long address);
-extern int sprint_symbol_build_id(char *buffer, unsigned long address);
-extern int sprint_symbol_no_offset(char *buffer, unsigned long address);
-extern int sprint_backtrace(char *buffer, unsigned long address);
-extern int sprint_backtrace_build_id(char *buffer, unsigned long address);
+extern int sprint_symbol(char *buffer, size_t size, unsigned long address);
+extern int sprint_symbol_build_id(char *buffer, size_t size, unsigned long address);
+extern int sprint_symbol_no_offset(char *buffer, size_t size, unsigned long address);
+extern int sprint_backtrace(char *buffer, size_t size, unsigned long address);
+extern int sprint_backtrace_build_id(char *buffer, size_t size, unsigned long address);
 
 int lookup_symbol_name(unsigned long addr, char *symname);
 int lookup_symbol_attrs(unsigned long addr, unsigned long *size, unsigned long *offset, char *modname, char *name);
@@ -118,31 +118,31 @@ static inline const char *kallsyms_lookup(unsigned long addr,
 	return NULL;
 }
 
-static inline int sprint_symbol(char *buffer, unsigned long addr)
+static inline int sprint_symbol(char *buffer, size_t size, unsigned long addr)
 {
 	*buffer = '\0';
 	return 0;
 }
 
-static inline int sprint_symbol_build_id(char *buffer, unsigned long address)
+static inline int sprint_symbol_build_id(char *buffer, size_t size, unsigned long address)
 {
 	*buffer = '\0';
 	return 0;
 }
 
-static inline int sprint_symbol_no_offset(char *buffer, unsigned long addr)
+static inline int sprint_symbol_no_offset(char *buffer, size_t size, unsigned long addr)
 {
 	*buffer = '\0';
 	return 0;
 }
 
-static inline int sprint_backtrace(char *buffer, unsigned long addr)
+static inline int sprint_backtrace(char *buffer, size_t size, unsigned long addr)
 {
 	*buffer = '\0';
 	return 0;
 }
 
-static inline int sprint_backtrace_build_id(char *buffer, unsigned long addr)
+static inline int sprint_backtrace_build_id(char *buffer, size_t size, unsigned long addr)
 {
 	*buffer = '\0';
 	return 0;
diff --git a/init/main.c b/init/main.c
index 40255f110885..399a15857bf9 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1207,7 +1207,7 @@ static bool __init_or_module initcall_blacklisted(initcall_t fn)
 		return false;
 
 	addr = (unsigned long) dereference_function_descriptor(fn);
-	sprint_symbol_no_offset(fn_name, addr);
+	sprint_symbol_no_offset(fn_name, KSYM_SYMBOL_LEN, addr);
 
 	/*
 	 * fn will be "function_name [module_name]" where [module_name] is not
diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index 87e2b1638115..f354378e241f 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -459,7 +459,7 @@ int lookup_symbol_attrs(unsigned long addr, unsigned long *size,
 }
 
 /* Look up a kernel symbol and return it in a text buffer. */
-static int __sprint_symbol(char *buffer, unsigned long address,
+static int __sprint_symbol(char *buffer, size_t buf_size, unsigned long address,
 			   int symbol_offset, int add_offset, int add_buildid)
 {
 	char *modname;
@@ -502,6 +502,7 @@ static int __sprint_symbol(char *buffer, unsigned long address,
 /**
  * sprint_symbol - Look up a kernel symbol and return it in a text buffer
  * @buffer: buffer to be stored
+ * @size: size of buffer
  * @address: address to lookup
  *
  * This function looks up a kernel symbol with @address and stores its name,
@@ -510,15 +511,16 @@ static int __sprint_symbol(char *buffer, unsigned long address,
  *
  * This function returns the number of bytes stored in @buffer.
  */
-int sprint_symbol(char *buffer, unsigned long address)
+int sprint_symbol(char *buffer, size_t size, unsigned long address)
 {
-	return __sprint_symbol(buffer, address, 0, 1, 0);
+	return __sprint_symbol(buffer, size, address, 0, 1, 0);
 }
 EXPORT_SYMBOL_GPL(sprint_symbol);
 
 /**
  * sprint_symbol_build_id - Look up a kernel symbol and return it in a text buffer
  * @buffer: buffer to be stored
+ * @size: size of buffer
  * @address: address to lookup
  *
  * This function looks up a kernel symbol with @address and stores its name,
@@ -527,15 +529,16 @@ EXPORT_SYMBOL_GPL(sprint_symbol);
  *
  * This function returns the number of bytes stored in @buffer.
  */
-int sprint_symbol_build_id(char *buffer, unsigned long address)
+int sprint_symbol_build_id(char *buffer, size_t size, unsigned long address)
 {
-	return __sprint_symbol(buffer, address, 0, 1, 1);
+	return __sprint_symbol(buffer, size, address, 0, 1, 1);
 }
 EXPORT_SYMBOL_GPL(sprint_symbol_build_id);
 
 /**
  * sprint_symbol_no_offset - Look up a kernel symbol and return it in a text buffer
  * @buffer: buffer to be stored
+ * @size: size of buffer
  * @address: address to lookup
  *
  * This function looks up a kernel symbol with @address and stores its name
@@ -544,15 +547,16 @@ EXPORT_SYMBOL_GPL(sprint_symbol_build_id);
  *
  * This function returns the number of bytes stored in @buffer.
  */
-int sprint_symbol_no_offset(char *buffer, unsigned long address)
+int sprint_symbol_no_offset(char *buffer, size_t size, unsigned long address)
 {
-	return __sprint_symbol(buffer, address, 0, 0, 0);
+	return __sprint_symbol(buffer, size, address, 0, 0, 0);
 }
 EXPORT_SYMBOL_GPL(sprint_symbol_no_offset);
 
 /**
  * sprint_backtrace - Look up a backtrace symbol and return it in a text buffer
  * @buffer: buffer to be stored
+ * @size: size of buffer
  * @address: address to lookup
  *
  * This function is for stack backtrace and does the same thing as
@@ -564,14 +568,15 @@ EXPORT_SYMBOL_GPL(sprint_symbol_no_offset);
  *
  * This function returns the number of bytes stored in @buffer.
  */
-int sprint_backtrace(char *buffer, unsigned long address)
+int sprint_backtrace(char *buffer, size_t size, unsigned long address)
 {
-	return __sprint_symbol(buffer, address, -1, 1, 0);
+	return __sprint_symbol(buffer, size, address, -1, 1, 0);
 }
 
 /**
  * sprint_backtrace_build_id - Look up a backtrace symbol and return it in a text buffer
  * @buffer: buffer to be stored
+ * @size: size of buffer
  * @address: address to lookup
  *
  * This function is for stack backtrace and does the same thing as
@@ -584,9 +589,9 @@ int sprint_backtrace(char *buffer, unsigned long address)
  *
  * This function returns the number of bytes stored in @buffer.
  */
-int sprint_backtrace_build_id(char *buffer, unsigned long address)
+int sprint_backtrace_build_id(char *buffer, size_t size, unsigned long address)
 {
-	return __sprint_symbol(buffer, address, -1, 1, 1);
+	return __sprint_symbol(buffer, size, address, -1, 1, 1);
 }
 
 /* To avoid using get_symbol_offset for every symbol, we carry prefix along. */
diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index 8aa493d25c73..2a6ec049cab5 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -362,7 +362,7 @@ trace_seq_print_sym(struct trace_seq *s, unsigned long address, bool offset)
 	const char *name;
 
 	if (offset)
-		sprint_symbol(str, address);
+		sprint_symbol(str, KSYM_SYMBOL_LEN, address);
 	else
 		kallsyms_lookup(address, NULL, NULL, NULL, str);
 	name = kretprobed(str, address);
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index f8ff861ef24a..cb241b63c967 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -991,15 +991,15 @@ char *symbol_string(char *buf, char *end, void *ptr,
 
 #ifdef CONFIG_KALLSYMS
 	if (*fmt == 'B' && fmt[1] == 'b')
-		sprint_backtrace_build_id(sym, value);
+		sprint_backtrace_build_id(sym, KSYM_SYMBOL_LEN, value);
 	else if (*fmt == 'B')
-		sprint_backtrace(sym, value);
+		sprint_backtrace(sym, KSYM_SYMBOL_LEN, value);
 	else if (*fmt == 'S' && (fmt[1] == 'b' || (fmt[1] == 'R' && fmt[2] == 'b')))
-		sprint_symbol_build_id(sym, value);
+		sprint_symbol_build_id(sym, KSYM_SYMBOL_LEN, value);
 	else if (*fmt != 's')
-		sprint_symbol(sym, value);
+		sprint_symbol(sym, KSYM_SYMBOL_LEN, value);
 	else
-		sprint_symbol_no_offset(sym, value);
+		sprint_symbol_no_offset(sym, KSYM_SYMBOL_LEN, value);
 
 	return string_nocheck(buf, end, sym, spec);
 #else
-- 
2.17.1

