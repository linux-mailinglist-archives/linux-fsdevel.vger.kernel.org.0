Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABE1E484514
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jan 2022 16:45:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235075AbiADPpX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Jan 2022 10:45:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235070AbiADPpU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Jan 2022 10:45:20 -0500
Received: from smtp-1908.mail.infomaniak.ch (smtp-1908.mail.infomaniak.ch [IPv6:2001:1600:4:17::1908])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4107BC0617A2
        for <linux-fsdevel@vger.kernel.org>; Tue,  4 Jan 2022 07:45:18 -0800 (PST)
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4JSxlF1GWrzN3f1x;
        Tue,  4 Jan 2022 16:45:13 +0100 (CET)
Received: from localhost (unknown [23.97.221.149])
        by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4JSxlD5cMHzljsW5;
        Tue,  4 Jan 2022 16:45:12 +0100 (CET)
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Alejandro Colomar <alx.manpages@gmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christian Heimes <christian@python.org>,
        Deven Bowers <deven.desai@linux.microsoft.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Eric Chiang <ericchiang@google.com>,
        Florian Weimer <fweimer@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        James Morris <jmorris@namei.org>, Jan Kara <jack@suse.cz>,
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        "Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>,
        Matthew Garrett <mjg59@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Paul Moore <paul@paul-moore.com>,
        =?UTF-8?q?Philippe=20Tr=C3=A9buchet?= 
        <philippe.trebuchet@ssi.gouv.fr>,
        Scott Shell <scottsh@microsoft.com>,
        Shuah Khan <shuah@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Steve Dower <steve.dower@python.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>,
        Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
        Xiaoming Ni <nixiaoming@huawei.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@linux.microsoft.com>
Subject: [PATCH v18 1/4] printk: Move back proc_dointvec_minmax_sysadmin() to sysctl.c
Date:   Tue,  4 Jan 2022 16:50:21 +0100
Message-Id: <20220104155024.48023-2-mic@digikod.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220104155024.48023-1-mic@digikod.net>
References: <20220104155024.48023-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Mickaël Salaün <mic@linux.microsoft.com>

The proc_dointvec_minmax_sysadmin() helper is useful for the
fs.trusted_for_policy sysctl brought by the next commit.

This partially revert commit 642fd23fb826 ("printk: move printk sysctl
to printk/sysctl.c") from Luis Chamberlain's 20211129-sysctl-cleanups
branch [1], to share the proc_dointvec_minmax_sysadmin() helper.  FYI,
this previous commit also got the buffer pointer an __user attribute.

Also remove the forgotten ten_thousand static variable (moved to
kernel/printk/sysctl.c).

Link: https://lkml.kernel.org/r/20211124231435.1445213-6-mcgrof@kernel.org [1]
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: Xiaoming Ni <nixiaoming@huawei.com>
Signed-off-by: Mickaël Salaün <mic@linux.microsoft.com>
Link: https://lore.kernel.org/r/20220104155024.48023-2-mic@digikod.net
---
 include/linux/sysctl.h | 2 ++
 kernel/printk/sysctl.c | 9 ---------
 kernel/sysctl.c        | 9 +++++++++
 3 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index 180adf7da785..cf1ba98aab50 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -69,6 +69,8 @@ int proc_dobool(struct ctl_table *table, int write, void *buffer,
 int proc_dointvec(struct ctl_table *, int, void *, size_t *, loff_t *);
 int proc_douintvec(struct ctl_table *, int, void *, size_t *, loff_t *);
 int proc_dointvec_minmax(struct ctl_table *, int, void *, size_t *, loff_t *);
+int proc_dointvec_minmax_sysadmin(struct ctl_table *, int, void *, size_t *,
+		loff_t *);
 int proc_douintvec_minmax(struct ctl_table *table, int write, void *buffer,
 		size_t *lenp, loff_t *ppos);
 int proc_dou8vec_minmax(struct ctl_table *table, int write, void *buffer,
diff --git a/kernel/printk/sysctl.c b/kernel/printk/sysctl.c
index 653ae04aab7f..c7129428ee9b 100644
--- a/kernel/printk/sysctl.c
+++ b/kernel/printk/sysctl.c
@@ -11,15 +11,6 @@
 
 static const int ten_thousand = 10000;
 
-static int proc_dointvec_minmax_sysadmin(struct ctl_table *table, int write,
-				void __user *buffer, size_t *lenp, loff_t *ppos)
-{
-	if (write && !capable(CAP_SYS_ADMIN))
-		return -EPERM;
-
-	return proc_dointvec_minmax(table, write, buffer, lenp, ppos);
-}
-
 static struct ctl_table printk_sysctls[] = {
 	{
 		.procname	= "printk",
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 5ae443b2882e..2e2027e323fd 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -888,6 +888,15 @@ static int proc_taint(struct ctl_table *table, int write,
 	return err;
 }
 
+int proc_dointvec_minmax_sysadmin(struct ctl_table *table, int write,
+				void __user *buffer, size_t *lenp, loff_t *ppos)
+{
+	if (write && !capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	return proc_dointvec_minmax(table, write, buffer, lenp, ppos);
+}
+
 /**
  * struct do_proc_dointvec_minmax_conv_param - proc_dointvec_minmax() range checking structure
  * @min: pointer to minimum allowable value
-- 
2.34.1

