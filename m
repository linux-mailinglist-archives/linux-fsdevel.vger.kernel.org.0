Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1D425EEAC
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Sep 2020 17:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729009AbgIFPiP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Sep 2020 11:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728905AbgIFPh0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Sep 2020 11:37:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B8ACC061573;
        Sun,  6 Sep 2020 08:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Resent-To:Resent-Message-ID:Resent-Date:
        Resent-From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        In-Reply-To:References; bh=HHWFRuEjpwIOXF7bCKWeM4a7Gbd1H7mpKL9VNiaPJTA=; b=vR
        zoyIgEAi4iUhcGAfu05yIGRGLtx/nVRFtggn80AnqsYPDc9KL0pFhrF5eAvXu05ZCOVw3QuT6tpXj
        htudfgpaP0aaDyrLM9l+i9zd1q7qlKDcFQVpB8dvPDI+7OSGvsFrSMMOlCK/dOz4dLSwEFr9X6jlq
        bXn9NPZbHQgtuIz8pNOn530Cmny6hS0qylaxd7FIv1qIAZpSJF7rGp8BRPaCjOGtmVqeKIt79APua
        SUEUAMoCXInqPnxmEDVDTLCJnqxwwU9hkt1nkTC5dhxWfmzFrJAXdKBGSaI8eO9seRoIKsHCzs4QW
        yTivDneKttLGahhNvYJF1PZHs1mBjhxw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kEwj8-0000zW-71; Sun, 06 Sep 2020 15:37:10 +0000
Received: from mout.gmx.net ([212.227.17.22])
        by casper.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kEwW8-0000AK-Lu
        for willy@infradead.org; Sun, 06 Sep 2020 15:23:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1599405812;
        bh=VROIkO5uZFKsGitKUg2bOT0YSmMyUgd5L55Q6L52pS0=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=cMQ4hK2ttARkZw4TLHsi6zh7VJQMCP0tMItp+XlAPEUO04XF/56UG12jK9keoDhw/
         atx93ZFSUod4OJLvP3k9lX6suGyu7qUNqqDg5gspwLZElUzNYRB1YHEqwph8sxKjO+
         Soiv3XirEippebRHbB9uAgskbXsmQl5AfVsn0V34=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([79.150.73.70]) by mail.gmx.com
 (mrgmx105 [212.227.17.174]) with ESMTPSA (Nemesis) id
 1M2O6Y-1kGZsT3j1q-003tW0; Sun, 06 Sep 2020 17:23:32 +0200
From:   John Wood <john.wood@gmx.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     John Wood <john.wood@gmx.com>
Subject: [RFC PATCH 4/9] security/fbfam: Add a new sysctl to control the crashing rate threshold
Date:   Sun,  6 Sep 2020 17:23:17 +0200
Message-Id: <20200906152317.7205-1-john.wood@gmx.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mk3kJe9rY10ZeHn2yGb+zOmUatUjQwSkdPG9zxQvSGz0VpSRDFT
 IiAQRrxOwA+CJlE/QUXh740SI2r5nCQs+fY1wqF2ebIeiLQO7Z+yDcbV/FjQinR55Fnm9+q
 KbYjFECz43ELE1KRM8Gf3ceLvkzveOwV8N/5UNMlCcnJ9OJ9d4bJIuuw4rR9xjkjDM9xyfH
 orAdS6Vsi7VrOAkLAlHHw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:hEo3Gmz3Nb4=:IXXiDAOW56JBjOT/9+Rxas
 BoSQiGtyiEBmcCkFqqi617lG6/SGc7E1JS+NXfE6yLikbfTZ2sm/+gVsGpVmmzhkowL1FwVfk
 QOS8hKUw/zyR5mGXxlCjCet5M+ZFfNbPidlyU7g3kj+YWsTxXO3IQsNIn9hN98+L0uZjPBczX
 ky0Mm4R/zouGShz0EcRqfEtxWPwTIKoUhkXkID01ByYrHJYSeTcoT89Z882clzdohXppwLeJc
 zJaTiQ7ZB2jEsEzAQIY1BApv+fOkexJQod86QUhjtFxAo+Su0ARS0jX4IV8rt0VQOY3m1pRrV
 4uErMsfnQx+cTaDqvgS6ZSKMS3VKkQQbvY7PuNrVH9gs8pVo131tzA3JizrnTaTZkgRf/Bgei
 HDLRJbaPcPneREctNQ+9x1DkUQcVD3va7jPXpCCNoxoP4aRhZyOKaXJ8hnlHpe3zWjonVnqx8
 sEXolQ3V9bVYVsAlUFbK7oXRUYUrM0H3ExMcLWM74ziZEOrlUjiYTVszAie2TRisfryo2/mS4
 YW/QTETlIpgCcDw0SsqngN5fhcx8SLUDUWEthjzCAyAkyiYXaa8ej8i1lNPzInu5DT+HGcOg5
 GDj8huOz26tYRz5Q+VOL2CTClGAnScQTgLMBT9sc+8RdodgMqGI6jMx1wLBYyK2tna7jjAHwh
 tGsdIFaBp+PGBxa7mGLWs4S6Z0tSZxT+mBFbP9hP/1fb47uTFiXo5IICsEbtFdLMrQNocqJMv
 Qk1h3TIBLHl31wFyL4AvJ0hwcbV+n4+Fp8UOrZM3EvqxFqKwkApKMsZdK1seuSzzm3tQKapUm
 qc7si+tMvt9iOYqwkRB47voi3h9J57vAFcpgGUoenNgMmNlTo/+B9Jl0K/ArtMzY2A1/H731T
 aPYm2ADr/lmxdHy7iMcNBhXnr+rpmnmmMLU/7KmbPEExGkr+Q5tCwr3IAjpg4HIwIbyrcb/Lx
 Wb9vHPOf8xzBltd6p1mMyQKTzP+S682jxIAoPLbuGhH/CQOj+oe9QVO/74BONmsZc9AaW/Gwv
 G5cyBd66SF4jkEKQYN9L5YrXrRa5fCCdGkH+QqlhWiIRTVyesvLqSMDzf4KRJ5ZKIKcA06I8Q
 MNosmeXK8sf38Q0T4U0qvhGSFRJcGDVv7jw2yMdPfSHl806KY3AkmzVdCghR6woP3KJQSgeLg
 K3nOWHgEaQw8rCKcEmNam0EUuXvIbZ8fbkLW+IuTcT9kUFmPHlU5qbq1pDFOvIE5ur78qf37+
 +LO4gV8rcRpZnfOo9adVVS1cu3ifVAICvUbmZIw==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200906_162344_889745_5F17CC16 
X-CRM114-Status: GOOD (  15.38  )
X-Spam-Score: -2.6 (--)
X-Spam-Report: SpamAssassin version 3.4.4 on casper.infradead.org summary:
 Content analysis details:   (-2.6 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -0.7 RCVD_IN_DNSWL_LOW      RBL: Sender listed at https://www.dnswl.org/,
                             low trust
                             [212.227.17.22 listed in list.dnswl.org]
 -0.0 RCVD_IN_MSPIKE_H2      RBL: Average reputation (+2)
                             [212.227.17.22 listed in wl.mailspike.net]
 -1.9 BAYES_00               BODY: Bayes spam probability is 0 to 1%
                             [score: 0.0000]
  0.0 FREEMAIL_FROM          Sender email is commonly abused enduser mail
                             provider
                             [john.wood[at]gmx.com]
 -0.0 SPF_PASS               SPF: sender matches SPF record
  0.0 SPF_HELO_NONE          SPF: HELO does not publish an SPF Record
  0.1 DKIM_SIGNED            Message has a DKIM or DK signature, not necessarily
                             valid
 -0.1 DKIM_VALID             Message has at least one valid DKIM or DK signature
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is a previous step to add the detection feature.

A fork brute force attack will be detected when an application crashes
quickly. Since, a rate can be defined as a time per fault, add a new
sysctl to control the crashing rate threshold.

This way, each system can tune the detection's sensibility adjusting the
milliseconds per fault. So, if the application's crashing rate falls
under this threshold an attack will be detected. So, the higher this
value, the faster an attack will be detected.

Signed-off-by: John Wood <john.wood@gmx.com>
=2D--
 include/fbfam/fbfam.h   |  4 ++++
 kernel/sysctl.c         |  9 +++++++++
 security/fbfam/Makefile |  1 +
 security/fbfam/fbfam.c  | 11 +++++++++++
 security/fbfam/sysctl.c | 20 ++++++++++++++++++++
 5 files changed, 45 insertions(+)
 create mode 100644 security/fbfam/sysctl.c

diff --git a/include/fbfam/fbfam.h b/include/fbfam/fbfam.h
index b5b7d1127a52..2cfe51d2b0d5 100644
=2D-- a/include/fbfam/fbfam.h
+++ b/include/fbfam/fbfam.h
@@ -3,8 +3,12 @@
 #define _FBFAM_H_

 #include <linux/sched.h>
+#include <linux/sysctl.h>

 #ifdef CONFIG_FBFAM
+#ifdef CONFIG_SYSCTL
+extern struct ctl_table fbfam_sysctls[];
+#endif
 int fbfam_fork(struct task_struct *child);
 int fbfam_execve(void);
 int fbfam_exit(void);
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 287862f91717..104b70c98251 100644
=2D-- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -77,6 +77,8 @@
 #include <linux/uaccess.h>
 #include <asm/processor.h>

+#include <fbfam/fbfam.h>
+
 #ifdef CONFIG_X86
 #include <asm/nmi.h>
 #include <asm/stacktrace.h>
@@ -2661,6 +2663,13 @@ static struct ctl_table kern_table[] =3D {
 		.extra1		=3D SYSCTL_ZERO,
 		.extra2		=3D SYSCTL_ONE,
 	},
+#endif
+#ifdef CONFIG_FBFAM
+	{
+		.procname	=3D "fbfam",
+		.mode		=3D 0555,
+		.child		=3D fbfam_sysctls,
+	},
 #endif
 	{ }
 };
diff --git a/security/fbfam/Makefile b/security/fbfam/Makefile
index f4b9f0b19c44..b8d5751ecea4 100644
=2D-- a/security/fbfam/Makefile
+++ b/security/fbfam/Makefile
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_FBFAM) +=3D fbfam.o
+obj-$(CONFIG_SYSCTL) +=3D sysctl.o
diff --git a/security/fbfam/fbfam.c b/security/fbfam/fbfam.c
index 0387f95f6408..9be4639b72eb 100644
=2D-- a/security/fbfam/fbfam.c
+++ b/security/fbfam/fbfam.c
@@ -7,6 +7,17 @@
 #include <linux/refcount.h>
 #include <linux/slab.h>

+/**
+ * sysctl_crashing_rate_threshold - Crashing rate threshold.
+ *
+ * The rate's units are in milliseconds per fault.
+ *
+ * A fork brute force attack will be detected if the application's crashi=
ng rate
+ * falls under this threshold. So, the higher this value, the faster an a=
ttack
+ * will be detected.
+ */
+unsigned long sysctl_crashing_rate_threshold =3D 30000;
+
 /**
  * struct fbfam_stats - Fork brute force attack mitigation statistics.
  * @refc: Reference counter.
diff --git a/security/fbfam/sysctl.c b/security/fbfam/sysctl.c
new file mode 100644
index 000000000000..430323ad8e9f
=2D-- /dev/null
+++ b/security/fbfam/sysctl.c
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/sysctl.h>
+
+extern unsigned long sysctl_crashing_rate_threshold;
+static unsigned long ulong_one =3D 1;
+static unsigned long ulong_max =3D ULONG_MAX;
+
+struct ctl_table fbfam_sysctls[] =3D {
+	{
+		.procname	=3D "crashing_rate_threshold",
+		.data		=3D &sysctl_crashing_rate_threshold,
+		.maxlen		=3D sizeof(sysctl_crashing_rate_threshold),
+		.mode		=3D 0644,
+		.proc_handler	=3D proc_doulongvec_minmax,
+		.extra1		=3D &ulong_one,
+		.extra2		=3D &ulong_max,
+	},
+	{ }
+};
+
=2D-
2.25.1

