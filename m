Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE42C51DD36
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 May 2022 18:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443658AbiEFQNv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 May 2022 12:13:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443678AbiEFQNd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 May 2022 12:13:33 -0400
Received: from smtp-bc0e.mail.infomaniak.ch (smtp-bc0e.mail.infomaniak.ch [IPv6:2001:1600:4:17::bc0e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD5756EB2E
        for <linux-fsdevel@vger.kernel.org>; Fri,  6 May 2022 09:09:49 -0700 (PDT)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4KvwWF60pkzMqHNm;
        Fri,  6 May 2022 18:09:45 +0200 (CEST)
Received: from localhost (unknown [23.97.221.149])
        by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4KvwWF3whBzlhSLy;
        Fri,  6 May 2022 18:09:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1651853385;
        bh=L3EhBQuZ8JSyRKEViKbnN85U/wm7/nFg67YALqmghu8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JOza7zG25EY3L8hBE9WNhYxxfBMlXYdNrGY8ol46Kw7FJ085yeaSuzXiNbpAWJ1P5
         qj8sI6X3ivCDev5JQuMpz3L8leRicjZzeGCr4PkRPqul2caZViwhoR0j2sFYnhU6Y4
         FBW/n/cVgXPlSZLu0r7j2pZ6k5xuZaZG0/q9njfI=
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jann Horn <jannh@google.com>,
        John Johansen <john.johansen@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Paul Moore <paul@paul-moore.com>,
        Shuah Khan <shuah@kernel.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: [PATCH v3 10/12] landlock: Document LANDLOCK_ACCESS_FS_REFER and ABI versioning
Date:   Fri,  6 May 2022 18:11:00 +0200
Message-Id: <20220506161102.525323-11-mic@digikod.net>
In-Reply-To: <20220506161102.525323-1-mic@digikod.net>
References: <20220506161102.525323-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add LANDLOCK_ACCESS_FS_REFER in the example and properly check to only
use it if the current kernel support it thanks to the Landlock ABI
version.

Move the file renaming and linking limitation to a new "Previous
limitations" section.

Improve documentation about the backward and forward compatibility,
including the rational for ruleset's handled_access_fs.

Update the document date.

Reviewed-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20220506161102.525323-11-mic@digikod.net
---

Changes since v2:
* Fix spelling spotted by Paul.
* Explain a bit more the renaming and linking constraint alternative
  (previous limitations), which is implemented with
  LANDLOCK_ACCESS_FS_REFER.
* Update date.

Changes since v1:
* Add Reviewed-by: Paul Moore.
* Update date.
---
 Documentation/userspace-api/landlock.rst | 126 +++++++++++++++++++----
 1 file changed, 106 insertions(+), 20 deletions(-)

diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
index b68e7a51009f..ae2aea986aa6 100644
--- a/Documentation/userspace-api/landlock.rst
+++ b/Documentation/userspace-api/landlock.rst
@@ -8,7 +8,7 @@ Landlock: unprivileged access control
 =====================================
 
 :Author: Mickaël Salaün
-:Date: March 2021
+:Date: May 2022
 
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
 
@@ -281,6 +347,26 @@ Memory usage
 Kernel memory allocated to create rulesets is accounted and can be restricted
 by the Documentation/admin-guide/cgroup-v1/memory.rst.
 
+Previous limitations
+====================
+
+File renaming and linking (ABI 1)
+---------------------------------
+
+Because Landlock targets unprivileged access controls, it needs to properly
+handle composition of rules.  Such property also implies rules nesting.
+Properly handling multiple layers of rulesets, each one of them able to
+restrict access to files, also implies inheritance of the ruleset restrictions
+from a parent to its hierarchy.  Because files are identified and restricted by
+their hierarchy, moving or linking a file from one directory to another implies
+propagation of the hierarchy constraints, or restriction of these actions
+according to the potentially lost constraints.  To protect against privilege
+escalations through renaming or linking, and for the sake of simplicity,
+Landlock previously limited linking and renaming to the same directory.
+Starting with the Landlock ABI version 2, it is now possible to securely
+control renaming and linking thanks to the new `LANDLOCK_ACCESS_FS_REFER`
+access right.
+
 Questions and answers
 =====================
 
-- 
2.35.1

