Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C503A5B1BE6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Sep 2022 13:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbiIHLvI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Sep 2022 07:51:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiIHLvH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Sep 2022 07:51:07 -0400
X-Greylist: delayed 955 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 08 Sep 2022 04:51:03 PDT
Received: from mxout70.expurgate.net (mxout70.expurgate.net [91.198.224.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFEB1923D1
        for <linux-fsdevel@vger.kernel.org>; Thu,  8 Sep 2022 04:51:03 -0700 (PDT)
Received: from [127.0.0.1] (helo=localhost)
        by relay.expurgate.net with smtp (Exim 4.92)
        (envelope-from <prvs=226421540e=fe@dev.tdt.de>)
        id 1oWFoE-000Tdy-NY; Thu, 08 Sep 2022 13:35:02 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
        by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <fe@dev.tdt.de>)
        id 1oWFoD-000TUm-Ru; Thu, 08 Sep 2022 13:35:01 +0200
Received: from securemail.tdt.de (localhost [127.0.0.1])
        by securemail.tdt.de (Postfix) with ESMTP id 5C20B240049;
        Thu,  8 Sep 2022 13:35:02 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
        by securemail.tdt.de (Postfix) with ESMTP id D0FE2240040;
        Thu,  8 Sep 2022 13:35:01 +0200 (CEST)
Received: from localhost.localdomain (unknown [10.2.3.40])
        by mail.dev.tdt.de (Postfix) with ESMTPSA id 6F1DD292C3;
        Thu,  8 Sep 2022 13:35:00 +0200 (CEST)
From:   Florian Eckert <fe@dev.tdt.de>
To:     masahiroy@kernel.org, michal.lkml@markovi.net,
        ndesaulniers@google.com
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kbuild@vger.kernel.org, Eckert.Florian@googlemail.com
Subject: [PATCH] fs/proc: add compile time info
Date:   Thu,  8 Sep 2022 13:34:49 +0200
Message-ID: <20220908113449.259942-1-fe@dev.tdt.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Content-Transfer-Encoding: quoted-printable
X-purgate-ID: 151534::1662636902-527FC6FE-A96F9D50/0/0
X-purgate: clean
X-purgate-type: clean
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We already have this information available during the build process.
This information is output in the first line of the boot log during the
boot process.

Unfortunately, this information is only readbale humans when
they look at the first line of the boolog. In order for this information
to be further processed by the machine and other userland services,
it should be separately readable as epoch date in the proc directory.

Signed-off-by: Florian Eckert <fe@dev.tdt.de>
---
 fs/proc/Makefile       |  1 +
 fs/proc/compile_time.c | 20 ++++++++++++++++++++
 scripts/mkcompile_h    |  5 ++++-
 3 files changed, 25 insertions(+), 1 deletion(-)
 create mode 100644 fs/proc/compile_time.c

diff --git a/fs/proc/Makefile b/fs/proc/Makefile
index bd08616ed8ba..ee61a8c2c840 100644
--- a/fs/proc/Makefile
+++ b/fs/proc/Makefile
@@ -23,6 +23,7 @@ proc-y	+=3D stat.o
 proc-y	+=3D uptime.o
 proc-y	+=3D util.o
 proc-y	+=3D version.o
+proc-y	+=3D compile_time.o
 proc-y	+=3D softirqs.o
 proc-y	+=3D namespaces.o
 proc-y	+=3D self.o
diff --git a/fs/proc/compile_time.c b/fs/proc/compile_time.c
new file mode 100644
index 000000000000..4cf659d3c28c
--- /dev/null
+++ b/fs/proc/compile_time.c
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <generated/compile.h>
+#include <linux/fs.h>
+#include <linux/init.h>
+#include <linux/proc_fs.h>
+#include <linux/seq_file.h>
+
+static int compile_time_proc_show(struct seq_file *m, void *v)
+{
+	seq_printf(m, "%s\n", LINUX_COMPILE_EPOCH);
+	return 0;
+}
+
+static int __init proc_compile_time_init(void)
+{
+	proc_create_single("compile_time", 0, NULL, compile_time_proc_show);
+	return 0;
+}
+
+fs_initcall(proc_compile_time_init);
diff --git a/scripts/mkcompile_h b/scripts/mkcompile_h
index ca40a5258c87..d0e927602276 100755
--- a/scripts/mkcompile_h
+++ b/scripts/mkcompile_h
@@ -24,8 +24,10 @@ else
 fi
=20
 if [ -z "$KBUILD_BUILD_TIMESTAMP" ]; then
-	TIMESTAMP=3D`date`
+	LINUX_COMPILE_EPOCH=3D$(date +%s)
+	TIMESTAMP=3D$(date -d "@$LINUX_COMPILE_EPOCH")
 else
+	LINUX_COMPILE_EPOCH=3D$(date -d "$KBUILD_BUILD_TIMESTAMP" +%s)
 	TIMESTAMP=3D$KBUILD_BUILD_TIMESTAMP
 fi
 if test -z "$KBUILD_BUILD_USER"; then
@@ -64,6 +66,7 @@ UTS_VERSION=3D"$(echo $UTS_VERSION $CONFIG_FLAGS $TIMES=
TAMP | cut -b -$UTS_LEN)"
=20
   echo \#define UTS_VERSION \"$UTS_VERSION\"
=20
+  printf '#define LINUX_COMPILE_EPOCH "%s"\n' "$LINUX_COMPILE_EPOCH"
   printf '#define LINUX_COMPILE_BY "%s"\n' "$LINUX_COMPILE_BY"
   echo \#define LINUX_COMPILE_HOST \"$LINUX_COMPILE_HOST\"
=20
--=20
2.30.2

