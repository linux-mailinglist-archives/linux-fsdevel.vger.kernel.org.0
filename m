Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3993D570967
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Jul 2022 19:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbiGKRsV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Jul 2022 13:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbiGKRsU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Jul 2022 13:48:20 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 652E72AC69
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Jul 2022 10:48:19 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 26BGUFS4013599
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Jul 2022 10:48:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=Ziq1gzB9L/hW1OA9ldNTXu0NFxd9b8/YHfK7r6sKr74=;
 b=KiqZNAPn09THDriy6/+KWwVj2dy/IebLiSItlUI0ZNayZyfmoDX+YTnfhVKZZzbgw3JP
 5D7V1x+lIVoPFsHHd004uF/a99gAIQYKjYAyREZd2yYSdaIqR8jywVbAmmaxHgfX2LLd
 yMpef4MUR+phJMUi3rZGXyvmJ0x43ZfGX+Q= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net (PPS) with ESMTPS id 3h7567twsy-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Jul 2022 10:48:18 -0700
Received: from twshared22934.08.ash9.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 11 Jul 2022 10:48:16 -0700
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
        id 21F19A243DCD; Mon, 11 Jul 2022 10:48:09 -0700 (PDT)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <linux-fsdevel@vger.kernel.org>
CC:     Miklos Szeredi <miklos@szeredi.hu>,
        Christian Brauner <brauner@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Seth Forshee <sforshee@digitalocean.com>,
        kernel-team <kernel-team@fb.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>, <clm@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [RESEND PATCH v4] fuse: Add module param for CAP_SYS_ADMIN access bypassing allow_other
Date:   Mon, 11 Jul 2022 10:48:08 -0700
Message-ID: <20220711174808.2579654-1-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: pVac-zmTRHajNXvklXa2ZoFLkZb1PF-C
X-Proofpoint-ORIG-GUID: pVac-zmTRHajNXvklXa2ZoFLkZb1PF-C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-11_22,2022-07-08_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Since commit 73f03c2b4b52 ("fuse: Restrict allow_other to the
superblock's namespace or a descendant"), access to allow_other FUSE
filesystems has been limited to users in the mounting user namespace or
descendants. This prevents a process that is privileged in its userns -
but not its parent namespaces - from mounting a FUSE fs w/ allow_other
that is accessible to processes in parent namespaces.

While this restriction makes sense overall it breaks a legitimate
usecase: I have a tracing daemon which needs to peek into
process' open files in order to symbolicate - similar to 'perf'. The
daemon is a privileged process in the root userns, but is unable to peek
into FUSE filesystems mounted by processes in child namespaces.

This patch adds a module param, allow_sys_admin_access, to act as an
escape hatch for this descendant userns logic and for the allow_other
mount option in general. Setting allow_sys_admin_access allows
processes with CAP_SYS_ADMIN in the initial userns to access FUSE
filesystems irrespective of the mounting userns or whether allow_other
was set. A sysadmin setting this param must trust FUSEs on the host to
not DoS processes as described in 73f03c2b4b52.

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---
v3 -> v4: lore.kernel.org/linux-fsdevel/20220617004710.621301-1-davemarch=
evsky@fb.com
  * Add discussion of new module option and allow_other userns
    interaction in docs (Christian)
	* (v4 RESEND) Add Christian's reviewed-by

v2 -> v3: lore.kernel.org/linux-fsdevel/20220601184407.2086986-1-davemarc=
hevsky@fb.com
  * Module param now allows initial userns CAP_SYS_ADMIN to bypass allow_=
other
    check entirely

v1 -> v2: lore.kernel.org/linux-fsdevel/20211111221142.4096653-1-davemarc=
hevsky@fb.com
  * Use module param instead of capability check

 Documentation/filesystems/fuse.rst | 29 ++++++++++++++++++++++++-----
 fs/fuse/dir.c                      | 10 ++++++++++
 2 files changed, 34 insertions(+), 5 deletions(-)

diff --git a/Documentation/filesystems/fuse.rst b/Documentation/filesyste=
ms/fuse.rst
index 8120c3c0cb4e..1e31e87aee68 100644
--- a/Documentation/filesystems/fuse.rst
+++ b/Documentation/filesystems/fuse.rst
@@ -279,7 +279,7 @@ How are requirements fulfilled?
 	the filesystem or not.
=20
 	Note that the *ptrace* check is not strictly necessary to
-	prevent B/2/i, it is enough to check if mount owner has enough
+	prevent C/2/i, it is enough to check if mount owner has enough
 	privilege to send signal to the process accessing the
 	filesystem, since *SIGSTOP* can be used to get a similar effect.
=20
@@ -288,10 +288,29 @@ I think these limitations are unacceptable?
=20
 If a sysadmin trusts the users enough, or can ensure through other
 measures, that system processes will never enter non-privileged
-mounts, it can relax the last limitation with a 'user_allow_other'
-config option.  If this config option is set, the mounting user can
-add the 'allow_other' mount option which disables the check for other
-users' processes.
+mounts, it can relax the last limitation in several ways:
+
+  - With the 'user_allow_other' config option. If this config option is
+    set, the mounting user can add the 'allow_other' mount option which
+    disables the check for other users' processes.
+
+    User namespaces have an unintuitive interaction with 'allow_other':
+    an unprivileged user - normally restricted from mounting with
+    'allow_other' - could do so in a user namespace where they're
+    privileged. If any process could access such an 'allow_other' mount
+    this would give the mounting user the ability to manipulate
+    processes in user namespaces where they're unprivileged. For this
+    reason 'allow_other' restricts access to users in the same userns
+    or a descendant.
+
+  - With the 'allow_sys_admin_access' module option. If this option is
+    set, super user's processes have unrestricted access to mounts
+    irrespective of allow_other setting or user namespace of the
+    mounting user.
+
+Note that both of these relaxations expose the system to potential
+information leak or *DoS* as described in points B and C/2/i-ii in the
+preceding section.
=20
 Kernel - userspace interface
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 9dfee44e97ad..d325d2387615 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -11,6 +11,7 @@
 #include <linux/pagemap.h>
 #include <linux/file.h>
 #include <linux/fs_context.h>
+#include <linux/moduleparam.h>
 #include <linux/sched.h>
 #include <linux/namei.h>
 #include <linux/slab.h>
@@ -21,6 +22,12 @@
 #include <linux/types.h>
 #include <linux/kernel.h>
=20
+static bool __read_mostly allow_sys_admin_access;
+module_param(allow_sys_admin_access, bool, 0644);
+MODULE_PARM_DESC(allow_sys_admin_access,
+ "Allow users with CAP_SYS_ADMIN in initial userns "
+ "to bypass allow_other access check");
+
 static void fuse_advise_use_readdirplus(struct inode *dir)
 {
 	struct fuse_inode *fi =3D get_fuse_inode(dir);
@@ -1229,6 +1236,9 @@ int fuse_allow_current_process(struct fuse_conn *fc=
)
 {
 	const struct cred *cred;
=20
+	if (allow_sys_admin_access && capable(CAP_SYS_ADMIN))
+		return 1;
+
 	if (fc->allow_other)
 		return current_in_userns(fc->user_ns);
=20
--=20
2.30.2

