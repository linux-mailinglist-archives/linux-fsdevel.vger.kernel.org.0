Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B8B670859B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 May 2023 18:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbjERQH1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 May 2023 12:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjERQHY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 May 2023 12:07:24 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6692F10D7
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 May 2023 09:07:20 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230518160716euoutp0244e9dbb9090f2f7a38add54ea8bb294c~gSI4qgLIu2458924589euoutp02R
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 May 2023 16:07:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230518160716euoutp0244e9dbb9090f2f7a38add54ea8bb294c~gSI4qgLIu2458924589euoutp02R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1684426036;
        bh=Ze+o09ZR17ldGY/8rqv5qNXytzqE0bHI/UYpvqWEbb8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=XHBIUDusdDSKijcLAWB6kfNdY4j1GHQ4T67zD6pLGwc4VOFHNM09sRol9uN302IH1
         qQtcCQdFBDV8Im6TyipuVa0/B9Gv+5fhzBBccNiVTWF+AyYm4Ptv+qRFzSNvCfLmlo
         NvYqm7jWmgkImr8xQg18QnZQXoAC6iEveDo7V69A=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230518160715eucas1p23ad608efcf7ecdf42580f254b9be8709~gSI4a6BBx2634626346eucas1p2u;
        Thu, 18 May 2023 16:07:15 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 2C.AA.37758.33D46646; Thu, 18
        May 2023 17:07:15 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230518160715eucas1p1973b53732f9b05aabbef2669124eb413~gSI3-5U3V2475724757eucas1p1_;
        Thu, 18 May 2023 16:07:15 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230518160715eusmtrp2bae472f5070362eba9b744430b186561~gSI3-VqVv0827608276eusmtrp2N;
        Thu, 18 May 2023 16:07:15 +0000 (GMT)
X-AuditID: cbfec7f5-7ffff7000002937e-c8-64664d33ec5c
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id B8.2B.10549.33D46646; Thu, 18
        May 2023 17:07:15 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230518160715eusmtip2e1b7d7e853961bcfb162d83d3734eb14~gSI30HY9s0076100761eusmtip2F;
        Thu, 18 May 2023 16:07:15 +0000 (GMT)
Received: from localhost (106.210.248.97) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Thu, 18 May 2023 17:07:12 +0100
From:   Joel Granados <j.granados@samsung.com>
To:     <mcgrof@kernel.org>
CC:     Alexander Viro <viro@zeniv.linux.org.uk>,
        <linux-kernel@vger.kernel.org>, Iurii Zaikin <yzaikin@google.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Christian Brauner <brauner@kernel.org>,
        <linux-fsdevel@vger.kernel.org>, Kees Cook <keescook@chromium.org>,
        "Joel Granados" <j.granados@samsung.com>
Subject: [PATCH 1/2] sysctl: Refactor base paths registrations
Date:   Thu, 18 May 2023 18:07:04 +0200
Message-ID: <20230518160705.3888592-2-j.granados@samsung.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230518160705.3888592-1-j.granados@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [106.210.248.97]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0xSYRjex0E4so47Yc1XsUzWTUut2Y/TxVatFmvlSqt1c0pytCaggbea
        NshqZmVaFolp2vKSbv0gTcnsQhreklguTbNWaWNqaSK2sjTw0Oa/532f53m/59k+HOMXuHjh
        x+WJtEIulgo5PPbDl79MAcG7YiSreuoCqKEXY4hqvyijHje0sKk3j25xqO6cAUQ9a8vDKNNf
        owtVpg/dhIsKVGa2SK/t44qKdUkiXeUFjsiqWyjS9X9j7eYc4m2Q0NLjybQiaGMU79jddhVK
        mPZMtd0YQyr0YH4WcsWBXAO6xilOFuLhfLICQcPNDI6D4JPjCPp/rmMIK4KvpT3c/47huo9c
        hihHUF3+2+mwqyrzgSGqEYzbymYcHHIlmIbfYw48j/SA5rYHyCHCyHoW5N6vnHG7kxuhN9uA
        HJhNLoG/luyZPUGGwFBzDYt52gfOd2lmNK52/c96E5fRzIWW/H62A2N2TUZNAcZggOcWC8Z4
        hVDbm+/C4HRore5hOUIAOYpD1oc8+1HcPmyFT83Omu4waKx2Ym+Y1t926q8heDo1ymWGKgRl
        apsz3Xo429nvdGyGO9cmnEfdoPvbXCaQG1x9qMGYNQGZ5/k5aLF2VgXtrAraWRWKEVaJPOgk
        pSyWVgbL6ZRApVimTJLHBkbHy3TI/n/apoy2OlQx+CPQgFg4MiDAMeE8Yk92tIRPSMQnT9GK
        +EhFkpRWGpAAZws9iBUhLdF8MlacSMfRdAKt+M+ycFcvFSuvpMT89kqZqYP+2JdK+Ai71QY5
        Ndkbhk26j3dcNNrmRChsWOJub2nKwTie5ehhvwpf9YfITkK9ndegelQYqk+v27LgQOndqmU7
        F016VDWeIY7IImrLI3fIBNd7PEsXveYvXce6fC5Dk/Vda9b7CbJTsMyaTMrXpzNekBd+42th
        xacAc4lYK3i8v2sgqumSn3rEOvqnucntXkyurSmjlNIfXN4+ZM31Mevz+Z81p6UTyZnt6xsF
        J1KNZHpM65PI2jR/40BN17ai7ol9Of7TQ9qc3KuhEs2XsFfJsH9qIKgo7t1ew9rB4m0RUSvD
        iWHLmGvCAd++tPH6wZHPCqtJyFYeE6/2xxRK8T+Hv/wSrgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCIsWRmVeSWpSXmKPExsVy+t/xe7rGvmkpBvsXC1q8PvyJ0eJMd67F
        nr0nWSwu75rDZnFjwlNGiwOnpzBbnP97nNVi2U4/Bw6P2Q0XWTx2zrrL7rFgU6nHplWdbB6f
        N8l5bHrylimALUrPpii/tCRVISO/uMRWKdrQwkjP0NJCz8jEUs/Q2DzWyshUSd/OJiU1J7Ms
        tUjfLkEvY8mZBsaC/5IVX6d9Ymxg3CzaxcjJISFgIvFmx332LkYuDiGBpYwS+z/PZYZIyEhs
        /HKVFcIWlvhzrYsNougjo0TDrP+sEM4WRom+/z/YQKrYBHQkzr+5A9YtIiAuceL0ZkYQm1lg
        N5PEq18yILawgJ3E7b5DYHEWAVWJvy/6wHp5BWwlXp/YygSxTV6i7fp0sBpOoPrvu8+zg9hC
        QDWXFi5hhagXlDg58wkLxHx5ieats5khbAmJgy9eQH2gJLH99kyoD2olPv99xjiBUWQWkvZZ
        SNpnIWlfwMi8ilEktbQ4Nz232FCvODG3uDQvXS85P3cTIzA6tx37uXkH47xXH/UOMTJxMB5i
        lOBgVhLhDexLThHiTUmsrEotyo8vKs1JLT7EaAr050RmKdHkfGB6yCuJNzQzMDU0MbM0MLU0
        M1YS5/Us6EgUEkhPLEnNTk0tSC2C6WPi4JRqYDplwhd3YaLEp0u+67nYtPPbe0OtHiYc+f7J
        NmdKwmG1vrvHLETnFD3LEa+Z99Xpbwn/8hm6YhY7A6ZH9motTGz72/vXVYFZ0Tdn4XxLR/nC
        CzaC0qv1X0+JC35vFf8r82jL4akqu2RKQ+vyIm1ELiXO2nU+PHjuChn++Y2L5Q7skljMGlgt
        cYvf6tyB2jZNu96LV7P9xfgvGs04ss/qgYq+weX/PcahJ+5u5V7ruJptB1etTv0Ja6dFsx90
        TjExs1bi/5X4gctmju7pO0ZrpZK/H9n/O1yrlzP+n4zDDnsWn7ffiyJ95jc+6ew4pxTxLyFu
        R8aPY7d/uJz93f8jsrP5x9LWi/aTtj5I0w6fpsRSnJFoqMVcVJwIAJewtfBXAwAA
X-CMS-MailID: 20230518160715eucas1p1973b53732f9b05aabbef2669124eb413
X-Msg-Generator: CA
X-RootMTR: 20230518160715eucas1p1973b53732f9b05aabbef2669124eb413
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230518160715eucas1p1973b53732f9b05aabbef2669124eb413
References: <20230518160705.3888592-1-j.granados@samsung.com>
        <CGME20230518160715eucas1p1973b53732f9b05aabbef2669124eb413@eucas1p1.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is part of the general push to deprecate register_sysctl_paths and
register_sysctl_table. The old way of doing this through
register_sysctl_base and DECLARE_SYSCTL_BASE macro is replaced with a
call to register_sysctl. The 5 base paths affected are: "kernel", "vm",
"debug", "dev" and "fs".

We remove the register_sysctl_base function and the DECLARE_SYSCTL_BASE
macro since they are no longer needed.

In order to quickly acertain that the paths did not actually change I
executed `find /proc/sys/ | sha1sum` and made sure that the sha was the
same before and after the commit.

Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 fs/sysctls.c           |  9 ++++++---
 include/linux/sysctl.h | 23 -----------------------
 kernel/sysctl.c        | 13 ++++---------
 3 files changed, 10 insertions(+), 35 deletions(-)

diff --git a/fs/sysctls.c b/fs/sysctls.c
index c701273c9432..228420f5fe1b 100644
--- a/fs/sysctls.c
+++ b/fs/sysctls.c
@@ -29,11 +29,14 @@ static struct ctl_table fs_shared_sysctls[] = {
 	{ }
 };
 
-DECLARE_SYSCTL_BASE(fs, fs_shared_sysctls);
-
 static int __init init_fs_sysctls(void)
 {
-	return register_sysctl_base(fs);
+	/*
+	 * We do not check the return code for register_sysctl because the
+	 * original call to register_sysctl_base always returned 0.
+	 */
+	register_sysctl("fs", fs_shared_sysctls);
+	return 0;
 }
 
 early_initcall(init_fs_sysctls);
diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index 218e56a26fb0..653b66c762b1 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -197,20 +197,6 @@ struct ctl_path {
 
 #ifdef CONFIG_SYSCTL
 
-#define DECLARE_SYSCTL_BASE(_name, _table)				\
-static struct ctl_table _name##_base_table[] = {			\
-	{								\
-		.procname	= #_name,				\
-		.mode		= 0555,					\
-		.child		= _table,				\
-	},								\
-	{ },								\
-}
-
-extern int __register_sysctl_base(struct ctl_table *base_table);
-
-#define register_sysctl_base(_name) __register_sysctl_base(_name##_base_table)
-
 void proc_sys_poll_notify(struct ctl_table_poll *poll);
 
 extern void setup_sysctl_set(struct ctl_table_set *p,
@@ -247,15 +233,6 @@ extern struct ctl_table sysctl_mount_point[];
 
 #else /* CONFIG_SYSCTL */
 
-#define DECLARE_SYSCTL_BASE(_name, _table)
-
-static inline int __register_sysctl_base(struct ctl_table *base_table)
-{
-	return 0;
-}
-
-#define register_sysctl_base(table) __register_sysctl_base(table)
-
 static inline void register_sysctl_init(const char *path, struct ctl_table *table)
 {
 }
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index bfe53e835524..f784b0fe5689 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -2348,17 +2348,12 @@ static struct ctl_table dev_table[] = {
 	{ }
 };
 
-DECLARE_SYSCTL_BASE(kernel, kern_table);
-DECLARE_SYSCTL_BASE(vm, vm_table);
-DECLARE_SYSCTL_BASE(debug, debug_table);
-DECLARE_SYSCTL_BASE(dev, dev_table);
-
 int __init sysctl_init_bases(void)
 {
-	register_sysctl_base(kernel);
-	register_sysctl_base(vm);
-	register_sysctl_base(debug);
-	register_sysctl_base(dev);
+	register_sysctl("kernel", kern_table);
+	register_sysctl("vm", vm_table);
+	register_sysctl("debug", debug_table);
+	register_sysctl("dev", dev_table);
 
 	return 0;
 }
-- 
2.30.2

