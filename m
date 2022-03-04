Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC3424CD355
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Mar 2022 12:24:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239477AbiCDLZF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Mar 2022 06:25:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238290AbiCDLY5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Mar 2022 06:24:57 -0500
Received: from smtpproxy21.qq.com (smtpbg703.qq.com [203.205.195.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A38EA18A780
        for <linux-fsdevel@vger.kernel.org>; Fri,  4 Mar 2022 03:24:09 -0800 (PST)
X-QQ-mid: bizesmtp91t1646393034trr618up
Received: from localhost.localdomain ( [58.240.82.166])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 04 Mar 2022 19:23:51 +0800 (CST)
X-QQ-SSF: 01400000002000C0G000000A0000000
X-QQ-FEAT: 4LFlwc+MlXkMhAcYm9dTNjI4L4eE39tcRdAGJ54+CcXfR2aXINChCvNNquT9X
        qAJDTN0kc5iAm2GHnNYKZGXU02eHXa4F1gZ+A+gNPDO528q8Yw2dRxDFpyaE/tn6fVubcPN
        rmtcJyqghdEk0aMaq2R0eoExNzqAe3/Pk1VEJu1sNXM2uUqmH26/bVgbvIMQHJwV8+AWd0d
        OwqilXMxOQVO/n3/KeS1eYxPQz+4qnHJ5TBnOtvuaYBRtQAZIUw3Wvzs0ic+EHs5Em5+I3p
        QbFqdScvOmnJx15BietccbLRRFga2cp9P6681tKUicXgMiUGJKRqYEfkSkhv1iIaXQCKlbj
        C8jd0ANRTaU8Intt9i2EvTGgWVR6LT3fEFijpCg9ZX3031I0D0=
X-QQ-GoodBg: 1
From:   Meng Tang <tangmeng@uniontech.com>
To:     mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        ebiederm@xmission.com, willy@infradead.org
Cc:     nixiaoming@huawei.com, nizhen@uniontech.com,
        zhanglianjie@uniontech.com, sujiaxun@uniontech.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Meng Tang <tangmeng@uniontech.com>
Subject: [PATCH v5 2/2] fs/proc: sysctl: remove register ctl_table end with empty
Date:   Fri,  4 Mar 2022 19:23:41 +0800
Message-Id: <20220304112341.19528-2-tangmeng@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220304112341.19528-1-tangmeng@uniontech.com>
References: <20220304112341.19528-1-tangmeng@uniontech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign1
X-QQ-Bgrelay: 1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Sysctls are being moved out of kernel/sysctl.c and out to
their own respective subsystems / users to help with easier
maintance and avoid merge conflicts. But when we move just
one entry and to its own new file the last entry for this
new file must be empty, so we are essentialy bloating the
kernel one extra empty entry per each newly moved sysctl.

To help with this, I have added support for registering just
one ctl_table, therefore not bloating the kernel when we
move a single ctl_table to its own file.

The optimization has been implemented in the previous patch,
here use register_sysctl_single() to register single one
ctl_table.

In this modification, I counted the size changes of each
object file during the compilation process.

When there is no strip, size changes are as follows:
                            before    now    save space
fs/dcache.o                  904936  904760   176bytes
fs/exec.o                    883584  883440   144bytes
fs/namespace.o              1614776 1614616   160bytes
fs/notify/dnotify/dnotify.o  255992  255872   120bytes
init/do_mounts_initrd.o      296552  296392   160bytes
kernel/acct.o                459184  459032   152bytes
kernel/delayacct.o           208680  208536   144bytes
kernel/kprobes.o             794968  794936    32bytes
kernel/panic.o               367696  367560   136bytes

When there is exec with 'strip -d', size changes are as follows:
                            before    now    save space
fs/dcache.o                  79040   78952     88bytes
fs/exec.o                    57960   57864     96bytes
fs/namespace.o              111904  111824     80bytes
fs/notify/dnotify/dnotify.o   8816    8736     80bytes
init/do_mounts_initrd.o       4872    4760    112bytes
kernel/acct.o                18104   18000    104bytes
kernel/delayacct.o            8768    8664    104bytes
kernel/kprobes.o             63192   63104     88bytes
kernel/panic.o               26760   26672     88bytes

Suggested-by: Matthew Wilcox <willy@infradead.org>
Suggested-by: Xiaoming Ni <nixiaoming@huawei.com>
Signed-off-by: Meng Tang <tangmeng@uniontech.com>
---
 fs/dcache.c                 | 3 +--
 fs/exec.c                   | 3 +--
 fs/namespace.c              | 3 +--
 fs/notify/dnotify/dnotify.c | 3 +--
 init/do_mounts_initrd.c     | 3 +--
 kernel/acct.c               | 3 +--
 kernel/delayacct.c          | 3 +--
 kernel/kprobes.c            | 3 +--
 kernel/panic.c              | 3 +--
 9 files changed, 9 insertions(+), 18 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index c84269c6e8bf..b8bccc151e37 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -190,8 +190,7 @@ static struct ctl_table fs_dcache_sysctls[] = {
 		.maxlen		= 6*sizeof(long),
 		.mode		= 0444,
 		.proc_handler	= proc_nr_dentry,
-	},
-	{ }
+	}
 };
 
 static int __init init_fs_dcache_sysctls(void)
diff --git a/fs/exec.c b/fs/exec.c
index c2586b791b87..afb19eacacec 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -2140,8 +2140,7 @@ static struct ctl_table fs_exec_sysctls[] = {
 		.proc_handler	= proc_dointvec_minmax_coredump,
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_TWO,
-	},
-	{ }
+	}
 };
 
 static int __init init_fs_exec_sysctls(void)
diff --git a/fs/namespace.c b/fs/namespace.c
index df172818e1f8..c4800f2044c5 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -4673,8 +4673,7 @@ static struct ctl_table fs_namespace_sysctls[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= SYSCTL_ONE,
-	},
-	{ }
+	}
 };
 
 static int __init init_fs_namespace_sysctls(void)
diff --git a/fs/notify/dnotify/dnotify.c b/fs/notify/dnotify/dnotify.c
index 829dd4a61b66..961ef4af6a09 100644
--- a/fs/notify/dnotify/dnotify.c
+++ b/fs/notify/dnotify/dnotify.c
@@ -28,8 +28,7 @@ static struct ctl_table dnotify_sysctls[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec,
-	},
-	{}
+	}
 };
 static void __init dnotify_sysctl_init(void)
 {
diff --git a/init/do_mounts_initrd.c b/init/do_mounts_initrd.c
index 327962ea354c..dbda262e30f2 100644
--- a/init/do_mounts_initrd.c
+++ b/init/do_mounts_initrd.c
@@ -28,8 +28,7 @@ static struct ctl_table kern_do_mounts_initrd_table[] = {
 		.maxlen         = sizeof(int),
 		.mode           = 0644,
 		.proc_handler   = proc_dointvec,
-	},
-	{ }
+	}
 };
 
 static __init int kernel_do_mounts_initrd_sysctls_init(void)
diff --git a/kernel/acct.c b/kernel/acct.c
index 62200d799b9b..72d571cf090d 100644
--- a/kernel/acct.c
+++ b/kernel/acct.c
@@ -83,8 +83,7 @@ static struct ctl_table kern_acct_table[] = {
 		.maxlen         = 3*sizeof(int),
 		.mode           = 0644,
 		.proc_handler   = proc_dointvec,
-	},
-	{ }
+	}
 };
 
 static __init int kernel_acct_sysctls_init(void)
diff --git a/kernel/delayacct.c b/kernel/delayacct.c
index 2c1e18f7c5cf..1ee1397de9c3 100644
--- a/kernel/delayacct.c
+++ b/kernel/delayacct.c
@@ -73,8 +73,7 @@ static struct ctl_table kern_delayacct_table[] = {
 		.proc_handler   = sysctl_delayacct,
 		.extra1         = SYSCTL_ZERO,
 		.extra2         = SYSCTL_ONE,
-	},
-	{ }
+	}
 };
 
 static __init int kernel_delayacct_sysctls_init(void)
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 94cab8c9ce56..1eb18d73e4ae 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -970,8 +970,7 @@ static struct ctl_table kprobe_sysctls[] = {
 		.proc_handler	= proc_kprobes_optimization_handler,
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_ONE,
-	},
-	{}
+	}
 };
 
 static void __init kprobe_sysctls_init(void)
diff --git a/kernel/panic.c b/kernel/panic.c
index ae5c0ca86016..830d55e59ee3 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -85,8 +85,7 @@ static struct ctl_table kern_panic_table[] = {
 		.proc_handler   = proc_dointvec_minmax,
 		.extra1         = SYSCTL_ZERO,
 		.extra2         = SYSCTL_ONE,
-	},
-	{ }
+	}
 };
 
 static __init int kernel_panic_sysctls_init(void)
-- 
2.20.1



