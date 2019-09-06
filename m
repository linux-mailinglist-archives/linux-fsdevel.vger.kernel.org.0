Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 315D2ABC62
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2019 17:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405725AbfIFP0o (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Sep 2019 11:26:44 -0400
Received: from smtp-sh2.infomaniak.ch ([128.65.195.6]:33283 "EHLO
        smtp-sh2.infomaniak.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404269AbfIFP0i (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Sep 2019 11:26:38 -0400
Received: from smtp5.infomaniak.ch (smtp5.infomaniak.ch [83.166.132.18])
        by smtp-sh2.infomaniak.ch (8.14.4/8.14.4/Debian-8+deb8u2) with ESMTP id x86FP7rm085954
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 6 Sep 2019 17:25:07 +0200
Received: from localhost (ns3096276.ip-94-23-54.eu [94.23.54.103])
        (authenticated bits=0)
        by smtp5.infomaniak.ch (8.14.5/8.14.5) with ESMTP id x86FP6Sd047657;
        Fri, 6 Sep 2019 17:25:06 +0200
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Heimes <christian@python.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Eric Chiang <ericchiang@google.com>,
        Florian Weimer <fweimer@redhat.com>,
        James Morris <jmorris@namei.org>, Jan Kara <jack@suse.cz>,
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Matthew Garrett <mjg59@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mickael.salaun@ssi.gouv.fr>,
        Mimi Zohar <zohar@linux.ibm.com>,
        =?UTF-8?q?Philippe=20Tr=C3=A9buchet?= 
        <philippe.trebuchet@ssi.gouv.fr>,
        Scott Shell <scottsh@microsoft.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Steve Dower <steve.dower@python.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>,
        Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
        Yves-Alexis Perez <yves-alexis.perez@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 3/5] fs: Enable to enforce noexec mounts or file exec through O_MAYEXEC
Date:   Fri,  6 Sep 2019 17:24:53 +0200
Message-Id: <20190906152455.22757-4-mic@digikod.net>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190906152455.22757-1-mic@digikod.net>
References: <20190906152455.22757-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Antivirus: Dr.Web (R) for Unix mail servers drweb plugin ver.6.0.2.8
X-Antivirus-Code: 0x100000
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Enable to either propagate the mount options from the underlying VFS
mount to prevent execution, or to propagate the file execute permission.
This may allow a script interpreter to check execution permissions
before reading commands from a file.

The main goal is to be able to protect the kernel by restricting
arbitrary syscalls that an attacker could perform with a crafted binary
or certain script languages.  It also improves multilevel isolation
by reducing the ability of an attacker to use side channels with
specific code.  These restrictions can natively be enforced for ELF
binaries (with the noexec mount option) but require this kernel
extension to properly handle scripts (e.g., Python, Perl).

Add a new sysctl fs.open_mayexec_enforce to control this behavior.  A
following patch adds documentation.

Changes since v1:
* move code from Yama to the FS subsystem (suggested by Kees Cook)
* make omayexec_inode_permission() static (suggested by Jann Horn)
* use mode 0600 for the sysctl
* only match regular files (not directories nor other types), which
  follows the same semantic as commit 73601ea5b7b1 ("fs/open.c: allow
  opening only regular files during execve()")

Signed-off-by: Mickaël Salaün <mic@digikod.net>
Reviewed-by: Philippe Trébuchet <philippe.trebuchet@ssi.gouv.fr>
Reviewed-by: Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Kees Cook <keescook@chromium.org>
Cc: Mickaël Salaün <mickael.salaun@ssi.gouv.fr>
---
 fs/namei.c         | 68 ++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/fs.h |  3 ++
 kernel/sysctl.c    |  7 +++++
 3 files changed, 78 insertions(+)

diff --git a/fs/namei.c b/fs/namei.c
index 0a6b9483d0cb..abd29a76ecef 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -39,6 +39,7 @@
 #include <linux/bitops.h>
 #include <linux/init_task.h>
 #include <linux/uaccess.h>
+#include <linux/sysctl.h>
 
 #include "internal.h"
 #include "mount.h"
@@ -411,6 +412,34 @@ static int sb_permission(struct super_block *sb, struct inode *inode, int mask)
 	return 0;
 }
 
+#define OMAYEXEC_ENFORCE_NONE	0
+#define OMAYEXEC_ENFORCE_MOUNT	(1 << 0)
+#define OMAYEXEC_ENFORCE_FILE	(1 << 1)
+#define _OMAYEXEC_LAST		OMAYEXEC_ENFORCE_FILE
+#define _OMAYEXEC_MASK		((_OMAYEXEC_LAST << 1) - 1)
+
+/**
+ * omayexec_inode_permission - check O_MAYEXEC before accessing an inode
+ * @inode: inode structure to check
+ * @mask: permission mask
+ *
+ * Return 0 if access is permitted, -EACCES otherwise.
+ */
+static int omayexec_inode_permission(struct inode *inode, int mask)
+{
+	if (!(mask & MAY_OPENEXEC))
+		return 0;
+
+	if ((sysctl_omayexec_enforce & OMAYEXEC_ENFORCE_MOUNT) &&
+			!(mask & MAY_EXECMOUNT))
+		return -EACCES;
+
+	if (sysctl_omayexec_enforce & OMAYEXEC_ENFORCE_FILE)
+		return generic_permission(inode, MAY_EXEC);
+
+	return 0;
+}
+
 /**
  * inode_permission - Check for access rights to a given inode
  * @inode: Inode to check permission on
@@ -454,10 +483,48 @@ int inode_permission(struct inode *inode, int mask)
 	if (retval)
 		return retval;
 
+	retval = omayexec_inode_permission(inode, mask);
+	if (retval)
+		return retval;
+
 	return security_inode_permission(inode, mask);
 }
 EXPORT_SYMBOL(inode_permission);
 
+/*
+ * Handle open_mayexec_enforce sysctl
+ */
+#ifdef CONFIG_SYSCTL
+int proc_omayexec(struct ctl_table *table, int write, void __user *buffer,
+		size_t *lenp, loff_t *ppos)
+{
+	int error;
+
+	if (write) {
+		struct ctl_table table_copy;
+		int tmp_mayexec_enforce;
+
+		if (!capable(CAP_MAC_ADMIN))
+			return -EPERM;
+		tmp_mayexec_enforce = *((int *)table->data);
+		table_copy = *table;
+		/* do not erase sysctl_omayexec_enforce */
+		table_copy.data = &tmp_mayexec_enforce;
+		error = proc_dointvec(&table_copy, write, buffer, lenp, ppos);
+		if (error)
+			return error;
+		if ((tmp_mayexec_enforce | _OMAYEXEC_MASK) != _OMAYEXEC_MASK)
+			return -EINVAL;
+		*((int *)table->data) = tmp_mayexec_enforce;
+	} else {
+		error = proc_dointvec(table, write, buffer, lenp, ppos);
+		if (error)
+			return error;
+	}
+	return 0;
+}
+#endif
+
 /**
  * path_get - get a reference to a path
  * @path: path to get the reference to
@@ -887,6 +954,7 @@ int sysctl_protected_symlinks __read_mostly = 0;
 int sysctl_protected_hardlinks __read_mostly = 0;
 int sysctl_protected_fifos __read_mostly;
 int sysctl_protected_regular __read_mostly;
+int sysctl_omayexec_enforce __read_mostly = OMAYEXEC_ENFORCE_NONE;
 
 /**
  * may_follow_link - Check symlink following for unsafe situations
diff --git a/include/linux/fs.h b/include/linux/fs.h
index e57609dac8dd..735f5950cfed 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -81,6 +81,7 @@ extern int sysctl_protected_symlinks;
 extern int sysctl_protected_hardlinks;
 extern int sysctl_protected_fifos;
 extern int sysctl_protected_regular;
+extern int sysctl_omayexec_enforce;
 
 typedef __kernel_rwf_t rwf_t;
 
@@ -3452,6 +3453,8 @@ int proc_nr_dentry(struct ctl_table *table, int write,
 		  void __user *buffer, size_t *lenp, loff_t *ppos);
 int proc_nr_inodes(struct ctl_table *table, int write,
 		   void __user *buffer, size_t *lenp, loff_t *ppos);
+int proc_omayexec(struct ctl_table *table, int write, void __user *buffer,
+		size_t *lenp, loff_t *ppos);
 int __init get_filesystem_list(char *buf);
 
 #define __FMODE_EXEC		((__force int) FMODE_EXEC)
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 078950d9605b..eaaeb229a828 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1911,6 +1911,13 @@ static struct ctl_table fs_table[] = {
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= &two,
 	},
+	{
+		.procname       = "open_mayexec_enforce",
+		.data           = &sysctl_omayexec_enforce,
+		.maxlen         = sizeof(int),
+		.mode           = 0600,
+		.proc_handler   = proc_omayexec,
+	},
 #if defined(CONFIG_BINFMT_MISC) || defined(CONFIG_BINFMT_MISC_MODULE)
 	{
 		.procname	= "binfmt_misc",
-- 
2.23.0

