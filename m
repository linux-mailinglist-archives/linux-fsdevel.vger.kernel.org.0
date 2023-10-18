Return-Path: <linux-fsdevel+bounces-610-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B452C7CD9AB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 12:52:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29373B213DC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 10:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 156F21DDD7;
	Wed, 18 Oct 2023 10:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED8018655;
	Wed, 18 Oct 2023 10:51:31 +0000 (UTC)
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E06AEA;
	Wed, 18 Oct 2023 03:51:26 -0700 (PDT)
Received: from weisslap.aisec.fraunhofer.de ([91.67.186.133]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MV2Sk-1r0Fxo2dio-00S59G; Wed, 18 Oct 2023 12:50:54 +0200
From: =?UTF-8?q?Michael=20Wei=C3=9F?= <michael.weiss@aisec.fraunhofer.de>
To: Alexander Mikhalitsyn <alexander@mihalicyn.com>,
	Christian Brauner <brauner@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Paul Moore <paul@paul-moore.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Quentin Monnet <quentin@isovalent.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	gyroidos@aisec.fraunhofer.de,
	=?UTF-8?q?Michael=20Wei=C3=9F?= <michael.weiss@aisec.fraunhofer.de>
Subject: [RFC PATCH v2 01/14] device_cgroup: Implement devcgroup hooks as lsm security hooks
Date: Wed, 18 Oct 2023 12:50:20 +0200
Message-Id: <20231018105033.13669-2-michael.weiss@aisec.fraunhofer.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231018105033.13669-1-michael.weiss@aisec.fraunhofer.de>
References: <20231018105033.13669-1-michael.weiss@aisec.fraunhofer.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:NYn2Q/FJsBpPLwL6AYRbw6g+mvD9uXm7MaGGQ06m5jjG1FNv7WU
 2QTVffPny26UCwr+vVG/VsOvJeacDtyPD2cEohjwK10jpsaM9yjlzhyo06yNdXHT4qA3ltF
 jOwkVSym6NcX4BC5vvMfHaA6UiAMhWIAhlWsvtcbBXSfQopFNFUM3akIwD2/YRJuZR0StAa
 /6EDn8+trYkP+8p5/x1Bg==
UI-OutboundReport: notjunk:1;M01:P0:aqgkTipOigE=;YCpIJ+5sW523xU65I2Dfqei/MFg
 Qdqu1xWW1cIDqsky2u2vbp/3rW9K7eCtKjEwne/qlAH/tzYmw7Uz3wD9zuE3VRCv/7MGtdYAF
 rYZ4FXtv7v4sVyTjxcDV0Z/dIIvD2I97tY+4eIbrzzyiUkE/pJD9qpS8hXyrirca0TZKhURFO
 oaAKalshJVI/0fmSIOes5YfLNmwDUPKAzhLHYyqYRaEYabgIY66B5Hhn6xAdZQYVlsE5p/B9D
 UVTYd59JJP80yhbATGiB1erA6OneCjJLPxSVU8zoHyZRn37ePgadxQ+7qDzEbp2g31RvglCQ1
 MXcSqv/FVP08kQXfYQ4MgElcN1fMlfvBNEnnalBWcmRfkUstJ3k8Wl605di5wnblhcKkWJFMy
 piztMydvWeWfI56BaEy9GiGgOp7Je6sIVMS0BGmZnSvjBj6SPcp7PB3/wU3pW2r+lMb5Phq1q
 5A9Z1gIbiD1upPVf9K57t5UYsqcRp4EP9Vtf4SGmA8phxe7zP3B9HNJ2RK/0xhizRxeUsOpf5
 FFToK5jrwyxx6oa7MohYpzV4y7mXs6HdueqB/HGDMMyv0bLMf275reksEtVX8qxgkNGqlv2hn
 B1lLyszJktFNpRd6348xQTSLFPCQF6sVwfHqtVJFQi1GW+mYhQPS7Bo1gZMwDPPPHSxT22tGv
 7vQMLUZwLEWdMvVwnXyrPdfqpyGevQb/3qcZ3Ep788TYcjaJs4r+e81j4ndgDyHzMlATEcL0H
 IQGjlL/OVklULuuqo0b24//j7tavwra5ri/xLJndvPx3xGz266lrCPI6AtH3Mlc0ltRPzBt6Q
 y0Wm+Em8hhE4+6DyviRBVOy7cYZNlyBIpHIqqjEhTE7/GTHnogOBBd3QZNHxTR7TyG6xUJWBN
 wcfNVOblIO4FTwA==
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

devcgroup_inode_mknod and devcgroup_inode_permission hooks are
called at place where already the corresponding lsm hooks
security_inode_mknod and security_inode_permission are called
to govern device access. Though introduce a small LSM which
implements those two security hooks instead of the additional
explicit devcgroup calls. The explicit API will be removed when
corresponding subsystems will drop the direct call to devcgroup
hooks.

Signed-off-by: Michael Weiß <michael.weiss@aisec.fraunhofer.de>
---
 init/Kconfig                                 |  4 +
 security/Kconfig                             |  1 +
 security/Makefile                            |  2 +-
 security/device_cgroup/Kconfig               |  7 ++
 security/device_cgroup/Makefile              |  4 +
 security/{ => device_cgroup}/device_cgroup.c |  0
 security/device_cgroup/lsm.c                 | 82 ++++++++++++++++++++
 7 files changed, 99 insertions(+), 1 deletion(-)
 create mode 100644 security/device_cgroup/Kconfig
 create mode 100644 security/device_cgroup/Makefile
 rename security/{ => device_cgroup}/device_cgroup.c (100%)
 create mode 100644 security/device_cgroup/lsm.c

diff --git a/init/Kconfig b/init/Kconfig
index 6d35728b94b2..5ed28dc821f3 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1111,6 +1111,8 @@ config PROC_PID_CPUSET
 
 config CGROUP_DEVICE
 	bool "Device controller"
+	select SECURITY
+	select SECURITY_DEVICE_CGROUP
 	help
 	  Provides a cgroup controller implementing whitelists for
 	  devices which a process in the cgroup can mknod or open.
@@ -1136,6 +1138,8 @@ config CGROUP_BPF
 	bool "Support for eBPF programs attached to cgroups"
 	depends on BPF_SYSCALL
 	select SOCK_CGROUP_DATA
+	select SECURITY
+	select SECURITY_DEVICE_CGROUP
 	help
 	  Allow attaching eBPF programs to a cgroup using the bpf(2)
 	  syscall command BPF_PROG_ATTACH.
diff --git a/security/Kconfig b/security/Kconfig
index 52c9af08ad35..0a0e60fc50e1 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -194,6 +194,7 @@ source "security/yama/Kconfig"
 source "security/safesetid/Kconfig"
 source "security/lockdown/Kconfig"
 source "security/landlock/Kconfig"
+source "security/device_cgroup/Kconfig"
 
 source "security/integrity/Kconfig"
 
diff --git a/security/Makefile b/security/Makefile
index 18121f8f85cd..7000cb8a69e8 100644
--- a/security/Makefile
+++ b/security/Makefile
@@ -21,7 +21,7 @@ obj-$(CONFIG_SECURITY_YAMA)		+= yama/
 obj-$(CONFIG_SECURITY_LOADPIN)		+= loadpin/
 obj-$(CONFIG_SECURITY_SAFESETID)       += safesetid/
 obj-$(CONFIG_SECURITY_LOCKDOWN_LSM)	+= lockdown/
-obj-$(CONFIG_CGROUPS)			+= device_cgroup.o
+obj-$(CONFIG_SECURITY_DEVICE_CGROUP)	+= device_cgroup/
 obj-$(CONFIG_BPF_LSM)			+= bpf/
 obj-$(CONFIG_SECURITY_LANDLOCK)		+= landlock/
 
diff --git a/security/device_cgroup/Kconfig b/security/device_cgroup/Kconfig
new file mode 100644
index 000000000000..93934bda3b8e
--- /dev/null
+++ b/security/device_cgroup/Kconfig
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config SECURITY_DEVICE_CGROUP
+	bool "Device Cgroup Support"
+	depends on SECURITY
+	help
+	  Provides the necessary security framework integration
+	  for cgroup device controller implementations.
diff --git a/security/device_cgroup/Makefile b/security/device_cgroup/Makefile
new file mode 100644
index 000000000000..c715b2b96388
--- /dev/null
+++ b/security/device_cgroup/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0-only
+obj-$(CONFIG_SECURITY_DEVICE_CGROUP) += devcgroup.o
+
+devcgroup-y := lsm.o device_cgroup.o
diff --git a/security/device_cgroup.c b/security/device_cgroup/device_cgroup.c
similarity index 100%
rename from security/device_cgroup.c
rename to security/device_cgroup/device_cgroup.c
diff --git a/security/device_cgroup/lsm.c b/security/device_cgroup/lsm.c
new file mode 100644
index 000000000000..ef30cff1f610
--- /dev/null
+++ b/security/device_cgroup/lsm.c
@@ -0,0 +1,82 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device cgroup security module
+ *
+ * This file contains device cgroup LSM hooks.
+ *
+ * Copyright (C) 2023 Fraunhofer AISEC. All rights reserved.
+ * Based on code copied from <file:include/linux/device_cgroups.h> (which has no copyright)
+ *
+ * Authors: Michael Weiß <michael.weiss@aisec.fraunhofer.de>
+ */
+
+#include <linux/bpf-cgroup.h>
+#include <linux/device_cgroup.h>
+#include <linux/lsm_hooks.h>
+
+static int devcg_inode_permission(struct inode *inode, int mask)
+{
+	short type, access = 0;
+
+	if (likely(!inode->i_rdev))
+		return 0;
+
+	if (S_ISBLK(inode->i_mode))
+		type = DEVCG_DEV_BLOCK;
+	else if (S_ISCHR(inode->i_mode))
+		type = DEVCG_DEV_CHAR;
+	else
+		return 0;
+
+	if (mask & MAY_WRITE)
+		access |= DEVCG_ACC_WRITE;
+	if (mask & MAY_READ)
+		access |= DEVCG_ACC_READ;
+
+	return devcgroup_check_permission(type, imajor(inode), iminor(inode),
+					  access);
+}
+
+static int __devcg_inode_mknod(int mode, dev_t dev, short access)
+{
+	short type;
+
+	if (!S_ISBLK(mode) && !S_ISCHR(mode))
+		return 0;
+
+	if (S_ISCHR(mode) && dev == WHITEOUT_DEV)
+		return 0;
+
+	if (S_ISBLK(mode))
+		type = DEVCG_DEV_BLOCK;
+	else
+		type = DEVCG_DEV_CHAR;
+
+	return devcgroup_check_permission(type, MAJOR(dev), MINOR(dev),
+					  access);
+}
+
+static int devcg_inode_mknod(struct inode *dir, struct dentry *dentry,
+				 umode_t mode, dev_t dev)
+{
+	return __devcg_inode_mknod(mode, dev, DEVCG_ACC_MKNOD);
+}
+
+static struct security_hook_list devcg_hooks[] __ro_after_init = {
+	LSM_HOOK_INIT(inode_permission, devcg_inode_permission),
+	LSM_HOOK_INIT(inode_mknod, devcg_inode_mknod),
+};
+
+static int __init devcgroup_init(void)
+{
+	security_add_hooks(devcg_hooks, ARRAY_SIZE(devcg_hooks),
+			   "devcgroup");
+	pr_info("device cgroup initialized\n");
+	return 0;
+}
+
+DEFINE_LSM(devcgroup) = {
+	.name = "devcgroup",
+	.order = LSM_ORDER_FIRST,
+	.init = devcgroup_init,
+};
-- 
2.30.2


