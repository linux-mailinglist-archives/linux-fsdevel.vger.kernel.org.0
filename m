Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94EA94BEC77
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Feb 2022 22:22:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234795AbiBUVXU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Feb 2022 16:23:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234746AbiBUVXQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Feb 2022 16:23:16 -0500
X-Greylist: delayed 455 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 21 Feb 2022 13:22:51 PST
Received: from smtp-190b.mail.infomaniak.ch (smtp-190b.mail.infomaniak.ch [185.125.25.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6937E112C
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Feb 2022 13:22:51 -0800 (PST)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4K2Znw3YmjzMqKMQ;
        Mon, 21 Feb 2022 22:15:16 +0100 (CET)
Received: from localhost (unknown [23.97.221.149])
        by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4K2Znw1SQtzljTgR;
        Mon, 21 Feb 2022 22:15:16 +0100 (CET)
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Paul Moore <paul@paul-moore.com>,
        Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@linux.microsoft.com>
Subject: [PATCH v1 09/11] landlock: Document LANDLOCK_ACCESS_FS_REFER and ABI versioning
Date:   Mon, 21 Feb 2022 22:25:20 +0100
Message-Id: <20220221212522.320243-10-mic@digikod.net>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220221212522.320243-1-mic@digikod.net>
References: <20220221212522.320243-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Mickaël Salaün <mic@linux.microsoft.com>

Add LANDLOCK_ACCESS_FS_REFER in the example and properly check to only
use it if the current kernel support it thanks to the Landlock ABI
version.

Move the file renaming and linking limitation to a new "Previous
limitations" section.

Improve documentation about the backward and forward compatibility,
including the rational for ruleset's handled_access_fs.

Signed-off-by: Mickaël Salaün <mic@linux.microsoft.com>
Link: https://lore.kernel.org/r/20220221212522.320243-10-mic@digikod.net
---
 Documentation/userspace-api/landlock.rst | 124 +++++++++++++++++++----
 1 file changed, 104 insertions(+), 20 deletions(-)

diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
index f35552ff19ba..97db09d36a5c 100644
--- a/Documentation/userspace-api/landlock.rst
+++ b/Documentation/userspace-api/landlock.rst
@@ -8,7 +8,7 @@ Landlock: unprivileged access control
 =====================================
 
 :Author: Mickaël Salaün
-:Date: March 2021
+:Date: February 2022
 
 The goal of Landlock is to enable to restrict ambient rights (e.g. global
 filesystem access) for a set of processes.  Because Landlock is a stackable
@@ -29,14 +29,15 @@ the thread enforcing it, and its future children.
 Defining and enforcing a security policy
 ----------------------------------------
 
-We first need to create the ruleset that will contain our rules.  For this
+We first need to define the ruleset that will contain our rules.  For this
 example, the ruleset will contain rules that only allow read actions, but write
 actions will be denied.  The ruleset then needs to handle both of these kind of
-actions.
+actions.  This is required for backward and forward compatibility (i.e. the
+kernel and user space may not know each other's supported restrictions), hence
+the need to be explicit about the denied-by-default access rights.
 
 .. code-block:: c
 
-    int ruleset_fd;
     struct landlock_ruleset_attr ruleset_attr = {
         .handled_access_fs =
             LANDLOCK_ACCESS_FS_EXECUTE |
@@ -51,9 +52,34 @@ actions.
             LANDLOCK_ACCESS_FS_MAKE_SOCK |
             LANDLOCK_ACCESS_FS_MAKE_FIFO |
             LANDLOCK_ACCESS_FS_MAKE_BLOCK |
-            LANDLOCK_ACCESS_FS_MAKE_SYM,
+            LANDLOCK_ACCESS_FS_MAKE_SYM |
+            LANDLOCK_ACCESS_FS_REFER,
     };
 
+Because we may not know on which kernel version an application will be
+executed, it is safer to follow a best-effort security approach.  Indeed, we
+should try to protect users as much as possible whatever the kernel they are
+using.  To avoid binary enforcement (i.e. either all security features or
+none), we can leverage a dedicated Landlock command to get the current version
+of the Landlock ABI and adapt the handled accesses.  Let's check if we should
+remove the `LANDLOCK_ACCESS_FS_REFER` access right which is only supported
+starting with the second version of the ABI.
+
+.. code-block:: c
+
+    int abi;
+
+    abi = landlock_create_ruleset(NULL, 0, LANDLOCK_CREATE_RULESET_VERSION);
+    if (abi < 2) {
+        ruleset_attr.handled_access_fs &= ~LANDLOCK_ACCESS_FS_REFER;
+    }
+
+This enables to create an inclusive ruleset that will contain our rules.
+
+.. code-block:: c
+
+    int ruleset_fd;
+
     ruleset_fd = landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
     if (ruleset_fd < 0) {
         perror("Failed to create a ruleset");
@@ -92,6 +118,11 @@ descriptor.
         return 1;
     }
 
+It may also be required to create rules following the same logic as explained
+for the ruleset creation, by filtering access rights according to the Landlock
+ABI version.  In this example, this is not required because
+`LANDLOCK_ACCESS_FS_REFER` is not allowed by any rule.
+
 We now have a ruleset with one rule allowing read access to ``/usr`` while
 denying all other handled accesses for the filesystem.  The next step is to
 restrict the current thread from gaining more privileges (e.g. thanks to a SUID
@@ -192,6 +223,56 @@ To be allowed to use :manpage:`ptrace(2)` and related syscalls on a target
 process, a sandboxed process should have a subset of the target process rules,
 which means the tracee must be in a sub-domain of the tracer.
 
+Compatibility
+=============
+
+Backward and forward compatibility
+----------------------------------
+
+Landlock is designed to be compatible with past and future versions of the
+kernel.  This is achieved thanks to the system call attributes and the
+associated bitflags, particularly the ruleset's `handled_access_fs`.  Making
+handled access right explicit enables the kernel and user space to have a clear
+contract with each other.  This is required to make sure sandboxing will not
+get stricter with a system update, which could break applications.
+
+Developers can subscribe to the `Landlock mailing list
+<https://subspace.kernel.org/lists.linux.dev.html>`_ to knowingly update and
+test their applications with the latest available features.  In the interest of
+users, and because they may use different kernel versions, it is strongly
+encouraged to follow a best-effort security approach by checking the Landlock
+ABI version at runtime and only enforcing the supported features.
+
+Landlock ABI versions
+---------------------
+
+The Landlock ABI version can be read with the sys_landlock_create_ruleset()
+system call:
+
+.. code-block:: c
+
+    int abi;
+
+    abi = landlock_create_ruleset(NULL, 0, LANDLOCK_CREATE_RULESET_VERSION);
+    if (abi < 0) {
+        switch (errno) {
+        case ENOSYS:
+            printf("Landlock is not supported by the current kernel.\n");
+            break;
+        case EOPNOTSUPP:
+            printf("Landlock is currently disabled.\n");
+            break;
+        }
+        return 0;
+    }
+    if (abi >= 2) {
+        printf("Landlock supports LANDLOCK_ACCESS_FS_REFER.\n");
+    }
+
+The following kernel interfaces are implicitly supported by the first ABI
+version.  Features only supported from a specific version are explicitly marked
+as such.
+
 Kernel interface
 ================
 
@@ -228,21 +309,6 @@ Enforcing a ruleset
 Current limitations
 ===================
 
-File renaming and linking
--------------------------
-
-Because Landlock targets unprivileged access controls, it is needed to properly
-handle composition of rules.  Such property also implies rules nesting.
-Properly handling multiple layers of ruleset, each one of them able to restrict
-access to files, also implies to inherit the ruleset restrictions from a parent
-to its hierarchy.  Because files are identified and restricted by their
-hierarchy, moving or linking a file from one directory to another implies to
-propagate the hierarchy constraints.  To protect against privilege escalations
-through renaming or linking, and for the sake of simplicity, Landlock currently
-limits linking and renaming to the same directory.  Future Landlock evolutions
-will enable more flexibility for renaming and linking, with dedicated ruleset
-flags.
-
 Filesystem topology modification
 --------------------------------
 
@@ -281,6 +347,24 @@ Memory usage
 Kernel memory allocated to create rulesets is accounted and can be restricted
 by the Documentation/admin-guide/cgroup-v1/memory.rst.
 
+Previous limitations
+====================
+
+File renaming and linking (ABI 1)
+---------------------------------
+
+Because Landlock targets unprivileged access controls, it is needed to properly
+handle composition of rules.  Such property also implies rules nesting.
+Properly handling multiple layers of ruleset, each one of them able to restrict
+access to files, also implies to inherit the ruleset restrictions from a parent
+to its hierarchy.  Because files are identified and restricted by their
+hierarchy, moving or linking a file from one directory to another implies to
+propagate the hierarchy constraints.  To protect against privilege escalations
+through renaming or linking, and for the sake of simplicity, Landlock previously
+limited linking and renaming to the same directory.  Starting with the Landlock
+ABI version 2, it is now possible to securely control renaming and linking
+thanks to the new `LANDLOCK_ACCESS_FS_REFER` access right.
+
 Questions and answers
 =====================
 
-- 
2.35.1

