Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1E1E70DC77
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 May 2023 14:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236872AbjEWMW7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 May 2023 08:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236833AbjEWMWw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 May 2023 08:22:52 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D10E12B
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 May 2023 05:22:38 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230523122237euoutp02a95e7539b03695218cd98a57efb37e3e~hxTK72Ev_1943019430euoutp02K
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 May 2023 12:22:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230523122237euoutp02a95e7539b03695218cd98a57efb37e3e~hxTK72Ev_1943019430euoutp02K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1684844557;
        bh=XgkbRo19UlgdrEJvMNy7N2uFh3oWcAT22mim1ypDjVs=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=a7ofdDb0csT5TBo0Gzshl+6CUFh30TL9pPvEOnlhE6xMgVkSE3kBMG2NACXoLQTH6
         /TJ1zo7CRwfPnz3YwOl946TcDGJ11Yy01ufCe3cgHyHhpyeUsRg0XQa4rWWSHp3HkU
         0eWOoLat1PCacffKWDc3wO4y3qMaHksUMvNgacr0=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230523122236eucas1p1836bfa829d041455149d950379d7752d~hxTKoiG5j1843818438eucas1p1y;
        Tue, 23 May 2023 12:22:36 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 7F.16.11320.C00BC646; Tue, 23
        May 2023 13:22:36 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230523122236eucas1p17639bfdbfb30c9d751e0a8fc85fe2fd3~hxTKUg2Ds1843818438eucas1p1x;
        Tue, 23 May 2023 12:22:36 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230523122236eusmtrp2a28f795e5ac8c29f6d0a98a61d1d61ea~hxTKT6T3Q0682206822eusmtrp2Z;
        Tue, 23 May 2023 12:22:36 +0000 (GMT)
X-AuditID: cbfec7f4-993ff70000022c38-ad-646cb00c97bd
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 1A.81.14344.C00BC646; Tue, 23
        May 2023 13:22:36 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230523122236eusmtip28b71ff19fdedac7014bc085feb7047cf~hxTKHgzmo2661526615eusmtip2W;
        Tue, 23 May 2023 12:22:36 +0000 (GMT)
Received: from localhost (106.210.248.82) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Tue, 23 May 2023 13:22:35 +0100
From:   Joel Granados <j.granados@samsung.com>
To:     <mcgrof@kernel.org>
CC:     Christian Brauner <brauner@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Joel Granados <j.granados@samsung.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH v4 7/8] sysctl: Refactor base paths registrations
Date:   Tue, 23 May 2023 14:22:19 +0200
Message-ID: <20230523122220.1610825-8-j.granados@samsung.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230523122220.1610825-1-j.granados@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [106.210.248.82]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNKsWRmVeSWpSXmKPExsWy7djPc7o8G3JSDGZOtbB4ffgTo8WZ7lyL
        PXtPslhc3jWHzeLGhKeMFgdOT2G2OP/3OKvFsp1+DhwesxsusnjsnHWX3WPBplKPTas62Tw+
        b5Lz2PTkLVMAWxSXTUpqTmZZapG+XQJXxtHONWwFD9Uq1rd9Zmpg/CnbxcjJISFgIjHz1ge2
        LkYuDiGBFYwSi3cfYwJJCAl8YZRovyYCkfjMKHFxzmcmmI5D+29AdSxnlJj65RgrXNX8A3+g
        MlsYJRZOOsUO0sImoCNx/s0dZhBbREBc4sTpzYwgRcwCO5kk+jtvAXVwcAgLOEpsnV0NUsMi
        oCqx69ZysHW8ArYS33vfs0Gslpdouz6dEcTmFLCTOPRsHytEjaDEyZlPWEBsZqCa5q2zmSFs
        CYmDL14wQ/QqSazu+gM1p1bi1JZbTCA3SAj855BY0voUKuEi8fjUJChbWOLV8S3sELaMxP+d
        86EaJjNK7P/3gR3CWc0osazxKzRkrCVarjxhB/lGAuibmTP0IUw+iRtvBSEO4pOYtG06M0SY
        V6KjTWgCo8osJC/MQvLCLCQvLGBkXsUonlpanJueWmyUl1quV5yYW1yal66XnJ+7iRGYfk7/
        O/5lB+PyVx/1DjEycTAeYpTgYFYS4T1Rnp0ixJuSWFmVWpQfX1Sak1p8iFGag0VJnFfb9mSy
        kEB6YklqdmpqQWoRTJaJg1OqgWn9+03/SwQ+1dyTS2xL0c1XfKz00GPrvroTu4QOVXL8l/90
        8u2XDwXJ20ufOsdwznU+WTfRYm/+5jtv1DgUlnY78H4Q1gnMKbZqcW2XC9/g++tVpO71jfcy
        63Mn8z9vsNv7kVfu+Z1ITdsgrin8C36VWZR7H/qzS1P3Yv4z0XulR/6/duCwu8zhGf49V3Xy
        oRlrg5V51l48eCIyZ4e3esiSD2cU965gCDdb9HDJudNXLW99WX0mqtQiam3jQ/lVjL/EG3Wk
        C98rWRfUP418Wedh3NBaMH/6xcLFV4JVV4oc935wK7lsUfNHpXNmLwWs3QSm7Pl3lMvq78aw
        Szz+5z4ytPDPXSLtekp1hVuBb5ISS3FGoqEWc1FxIgDjGDaZrgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMIsWRmVeSWpSXmKPExsVy+t/xe7o8G3JSDLZcUrB4ffgTo8WZ7lyL
        PXtPslhc3jWHzeLGhKeMFgdOT2G2OP/3OKvFsp1+DhwesxsusnjsnHWX3WPBplKPTas62Tw+
        b5Lz2PTkLVMAW5SeTVF+aUmqQkZ+cYmtUrShhZGeoaWFnpGJpZ6hsXmslZGpkr6dTUpqTmZZ
        apG+XYJextHONWwFD9Uq1rd9Zmpg/CnbxcjJISFgInFo/w22LkYuDiGBpYwSWzfsY4dIyEhs
        /HKVFcIWlvhzrYsNxBYS+MgosXyxLETDFkaJ8zPvMIIk2AR0JM6/ucMMYosIiEucOL2ZEaSI
        WWA7k8SEv7uAujk4hAUcJbbOrgapYRFQldh1azkTiM0rYCvxvfc9G8QyeYm269PBZnIK2Ekc
        eraPFWKxrUTrq02sEPWCEidnPmEBsZmB6pu3zmaGsCUkDr54wQwxR0liddcfqJm1Ep//PmOc
        wCgyC0n7LCTts5C0L2BkXsUoklpanJueW2ykV5yYW1yal66XnJ+7iREYm9uO/dyyg3Hlq496
        hxiZOBgPMUpwMCuJ8J4oz04R4k1JrKxKLcqPLyrNSS0+xGgK9OdEZinR5HxgcsgriTc0MzA1
        NDGzNDC1NDNWEuf1LOhIFBJITyxJzU5NLUgtgulj4uCUamCyeXGmminUaX22y/Lnr632mIsv
        OKB7wbdFQkLS8NGa5793VF2eU3DwUN/Lj9v7hQV3ifzZJrp2Kf9V+y9Fs8LteScp2GjaTbAz
        +OnWYSmYFvVw/nb5Bvn78T9fX7iiEVnplPz5d9oy7sMafdXnUyd8bi6u/njjl83soosMH0zP
        qpv9z/6/VfDIviXZmgVrWKym5zyb+Of20lDDyY+2nZ4bWr3yzNrmvTssWtgV1HMLZ0vvbLXz
        n8Xr/ly7kX9Br+Bpo5NFcxUSCv+KclT6nXryMJS1R+6AQFqpXgd3R2rHy6OrZzy6tK/348zo
        rxuaJ22o9JhzVT878vttpawXBq9WmO1Y47X38bTOAP44J4dGJZbijERDLeai4kQA9yom8FYD
        AAA=
X-CMS-MailID: 20230523122236eucas1p17639bfdbfb30c9d751e0a8fc85fe2fd3
X-Msg-Generator: CA
X-RootMTR: 20230523122236eucas1p17639bfdbfb30c9d751e0a8fc85fe2fd3
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230523122236eucas1p17639bfdbfb30c9d751e0a8fc85fe2fd3
References: <20230523122220.1610825-1-j.granados@samsung.com>
        <CGME20230523122236eucas1p17639bfdbfb30c9d751e0a8fc85fe2fd3@eucas1p1.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is part of the general push to deprecate register_sysctl_paths and
register_sysctl_table. The old way of doing this through
register_sysctl_base and DECLARE_SYSCTL_BASE macro is replaced with a
call to register_sysctl_init. The 5 base paths affected are: "kernel",
"vm", "debug", "dev" and "fs".

We remove the register_sysctl_base function and the DECLARE_SYSCTL_BASE
macro since they are no longer needed.

In order to quickly acertain that the paths did not actually change I
executed `find /proc/sys/ | sha1sum` and made sure that the sha was the
same before and after the commit.

We end up saving 563 bytes with this change:

./scripts/bloat-o-meter vmlinux.0.base vmlinux.1.refactor-base-paths
add/remove: 0/5 grow/shrink: 2/0 up/down: 77/-640 (-563)
Function                                     old     new   delta
sysctl_init_bases                             55     111     +56
init_fs_sysctls                               12      33     +21
vm_base_table                                128       -    -128
kernel_base_table                            128       -    -128
fs_base_table                                128       -    -128
dev_base_table                               128       -    -128
debug_base_table                             128       -    -128
Total: Before=21258215, After=21257652, chg -0.00%

Signed-off-by: Joel Granados <j.granados@samsung.com>
[mcgrof: modified to use register_sysctl_init() over register_sysctl()
 and add bloat-o-meter stats]
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
Tested-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 fs/sysctls.c           |  5 ++---
 include/linux/sysctl.h | 23 -----------------------
 kernel/sysctl.c        | 30 +++++++++---------------------
 3 files changed, 11 insertions(+), 47 deletions(-)

diff --git a/fs/sysctls.c b/fs/sysctls.c
index c701273c9432..76a0aee8c229 100644
--- a/fs/sysctls.c
+++ b/fs/sysctls.c
@@ -29,11 +29,10 @@ static struct ctl_table fs_shared_sysctls[] = {
 	{ }
 };
 
-DECLARE_SYSCTL_BASE(fs, fs_shared_sysctls);
-
 static int __init init_fs_sysctls(void)
 {
-	return register_sysctl_base(fs);
+	register_sysctl_init("fs", fs_shared_sysctls);
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
index bfe53e835524..73fa9cf7ee11 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1782,11 +1782,6 @@ static struct ctl_table kern_table[] = {
 		.mode		= 0644,
 		.proc_handler	= sysctl_max_threads,
 	},
-	{
-		.procname	= "usermodehelper",
-		.mode		= 0555,
-		.child		= usermodehelper_table,
-	},
 	{
 		.procname	= "overflowuid",
 		.data		= &overflowuid,
@@ -1962,13 +1957,6 @@ static struct ctl_table kern_table[] = {
 		.proc_handler	= proc_dointvec,
 	},
 #endif
-#ifdef CONFIG_KEYS
-	{
-		.procname	= "keys",
-		.mode		= 0555,
-		.child		= key_sysctls,
-	},
-#endif
 #ifdef CONFIG_PERF_EVENTS
 	/*
 	 * User-space scripts rely on the existence of this file
@@ -2348,17 +2336,17 @@ static struct ctl_table dev_table[] = {
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
+	register_sysctl_init("kernel", kern_table);
+	register_sysctl_init("kernel/usermodehelper", usermodehelper_table);
+#ifdef CONFIG_KEYS
+	register_sysctl_init("kernel/keys", key_sysctls);
+#endif
+
+	register_sysctl_init("vm", vm_table);
+	register_sysctl_init("debug", debug_table);
+	register_sysctl_init("dev", dev_table);
 
 	return 0;
 }
-- 
2.30.2

