Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1504A9426
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Feb 2022 07:55:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244796AbiBDGzC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Feb 2022 01:55:02 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:60744 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233514AbiBDGzB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Feb 2022 01:55:01 -0500
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id C3E2672C905;
        Fri,  4 Feb 2022 09:54:59 +0300 (MSK)
Received: from boyarsh.office.basealt.ru (unknown [193.43.10.250])
        by imap.altlinux.org (Postfix) with ESMTPSA id 997514A46F0;
        Fri,  4 Feb 2022 09:54:59 +0300 (MSK)
From:   "Anton V. Boyarshinov" <boyarsh@altlinux.org>
To:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org
Cc:     "Anton V. Boyarshinov" <boyarsh@altlinux.org>,
        ebiederm@xmission.com, legion@kernel.org, ldv@altlinux.org,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com
Subject: [PATCH] Add ability to disallow idmapped mounts
Date:   Fri,  4 Feb 2022 09:53:38 +0300
Message-Id: <20220204065338.251469-1-boyarsh@altlinux.org>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Idmapped mounts may have security implications [1] and have
no knobs to be disallowed at runtime or compile time.

This patch adds a sysctl and a config option to set its default value.

[1] https://lore.kernel.org/all/m18s7481xc.fsf@fess.ebiederm.org/

Based on work from Alexey Gladkov <legion@kernel.org>.

Signed-off-by: Anton V. Boyarshinov <boyarsh@altlinux.org>
---
 Documentation/admin-guide/sysctl/fs.rst | 12 ++++++++++++
 fs/Kconfig                              |  8 ++++++++
 fs/namespace.c                          | 21 ++++++++++++++++++++-
 3 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/sysctl/fs.rst b/Documentation/admin-guide/sysctl/fs.rst
index 2a501c9ddc55..f758c4ae5f66 100644
--- a/Documentation/admin-guide/sysctl/fs.rst
+++ b/Documentation/admin-guide/sysctl/fs.rst
@@ -105,6 +105,18 @@ you have some awesome number of simultaneous system users,
 you might want to raise the limit.
 
 
+idmap_mounts
+------------
+
+Idmapped mounts may have security implications.
+This knob controls whether creation of idmapped mounts is allowed.
+When set to "1", creation of idmapped mounts is allowed.
+When set to "0", creation of idmapped mounts is not allowed.
+
+The default value is
+* 0, if ``IDMAP_MOUNTS_DEFAULT_OFF`` is enabled in the kernel configuration;
+* 1, otherwise.
+
 file-max & file-nr
 ------------------
 
diff --git a/fs/Kconfig b/fs/Kconfig
index 7a2b11c0b803..d2203ba0183d 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -385,4 +385,12 @@ source "fs/unicode/Kconfig"
 config IO_WQ
 	bool
 
+config IDMAP_MOUNTS_DEFAULT_OFF
+       bool "Disallow idmappad mounts by default"
+       help
+         Idmapped mounts may have security implications.
+         Enable this to disallow idmapped mounts by setting
+         the default value of /proc/sys/fs/idmap_mounts to 0.
+
+
 endmenu
diff --git a/fs/namespace.c b/fs/namespace.c
index 40b994a29e90..66501ad75537 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -39,6 +39,10 @@
 /* Maximum number of mounts in a mount namespace */
 static unsigned int sysctl_mount_max __read_mostly = 100000;
 
+/* Whether idmapped mounts are allowed. */
+static int sysctl_idmap_mounts __read_mostly =
+	IS_ENABLED(CONFIG_IDMAP_MOUNTS_DEFAULT_OFF) ? 0 : 1;
+
 static unsigned int m_hash_mask __read_mostly;
 static unsigned int m_hash_shift __read_mostly;
 static unsigned int mp_hash_mask __read_mostly;
@@ -3965,7 +3969,13 @@ static int can_idmap_mount(const struct mount_kattr *kattr, struct mount *mnt)
 	if (!is_anon_ns(mnt->mnt_ns))
 		return -EINVAL;
 
-	return 0;
+	/* So far, there are concerns about the safety of idmaps. */
+	if (!sysctl_idmap_mounts) {
+		pr_warn_once("VFS: idmapped mounts are not allowed.\n");
+		return -EPERM;
+	} else {
+		return 0;
+	}
 }
 
 static struct mount *mount_setattr_prepare(struct mount_kattr *kattr,
@@ -4631,6 +4641,15 @@ static struct ctl_table fs_namespace_sysctls[] = {
 		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= SYSCTL_ONE,
 	},
+	{
+		.procname       = "idmap_mounts",
+		.data           = &sysctl_idmap_mounts,
+		.maxlen         = sizeof(int),
+		.mode           = 0644,
+		.proc_handler   = proc_dointvec_minmax,
+		.extra1         = SYSCTL_ZERO,
+		.extra2         = SYSCTL_ONE,
+	},
 	{ }
 };
 
-- 
2.33.0

