Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 819C8239C61
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Aug 2020 23:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728177AbgHBV7p (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 2 Aug 2020 17:59:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728146AbgHBV7l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 2 Aug 2020 17:59:41 -0400
Received: from smtp-42a9.mail.infomaniak.ch (smtp-42a9.mail.infomaniak.ch [IPv6:2001:1600:3:17::42a9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF64C061757
        for <linux-fsdevel@vger.kernel.org>; Sun,  2 Aug 2020 14:59:40 -0700 (PDT)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4BKZgH0KQNzlhQxh;
        Sun,  2 Aug 2020 23:59:39 +0200 (CEST)
Received: from localhost (unknown [94.23.54.103])
        by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4BKZgG4DC0zlh8T3;
        Sun,  2 Aug 2020 23:59:38 +0200 (CEST)
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@amacapital.net>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Casey Schaufler <casey@schaufler-ca.com>,
        James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>,
        Jeff Dike <jdike@addtoit.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Shuah Khan <shuah@kernel.org>,
        Vincent Dagonneau <vincent.dagonneau@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-security-module@vger.kernel.org, x86@kernel.org
Subject: [PATCH v20 12/12] landlock: Add user and kernel documentation
Date:   Sun,  2 Aug 2020 23:59:03 +0200
Message-Id: <20200802215903.91936-13-mic@digikod.net>
X-Mailer: git-send-email 2.28.0.rc2
In-Reply-To: <20200802215903.91936-1-mic@digikod.net>
References: <20200802215903.91936-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Antivirus: Dr.Web (R) for Unix mail servers drweb plugin ver.6.0.2.8
X-Antivirus-Code: 0x100000
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This documentation can be built with the Sphinx framework.

Signed-off-by: Mickaël Salaün <mic@digikod.net>
Reviewed-by: Vincent Dagonneau <vincent.dagonneau@ssi.gouv.fr>
Cc: James Morris <jmorris@namei.org>
Cc: Jann Horn <jannh@google.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Serge E. Hallyn <serge@hallyn.com>
---

Changes since v19:
* Update examples and documentation with the new syscalls.

Changes since v15:
* Add current limitations.

Changes since v14:
* Fix spelling (contributed by Randy Dunlap).
* Extend documentation about inheritance and explain layer levels.
* Remove the use of now-removed access rights.
* Use GitHub links.
* Improve kernel documentation.
* Add section for tests.
* Update example.

Changes since v13:
* Rewrote the documentation according to the major revamp.

Previous changes:
https://lore.kernel.org/lkml/20191104172146.30797-8-mic@digikod.net/
---
 Documentation/security/index.rst           |   1 +
 Documentation/security/landlock/index.rst  |  18 ++
 Documentation/security/landlock/kernel.rst |  69 ++++++
 Documentation/security/landlock/user.rst   | 271 +++++++++++++++++++++
 include/uapi/linux/landlock.h              |  49 +---
 security/landlock/syscall.c                |  27 +-
 6 files changed, 388 insertions(+), 47 deletions(-)
 create mode 100644 Documentation/security/landlock/index.rst
 create mode 100644 Documentation/security/landlock/kernel.rst
 create mode 100644 Documentation/security/landlock/user.rst

diff --git a/Documentation/security/index.rst b/Documentation/security/index.rst
index 8129405eb2cc..e3f2bf4fef77 100644
--- a/Documentation/security/index.rst
+++ b/Documentation/security/index.rst
@@ -16,3 +16,4 @@ Security Documentation
    siphash
    tpm/index
    digsig
+   landlock/index
diff --git a/Documentation/security/landlock/index.rst b/Documentation/security/landlock/index.rst
new file mode 100644
index 000000000000..2520f8f33f5e
--- /dev/null
+++ b/Documentation/security/landlock/index.rst
@@ -0,0 +1,18 @@
+=========================================
+Landlock LSM: unprivileged access control
+=========================================
+
+:Author: Mickaël Salaün
+
+The goal of Landlock is to enable to restrict ambient rights (e.g.  global
+filesystem access) for a set of processes.  Because Landlock is a stackable
+LSM, it makes possible to create safe security sandboxes as new security layers
+in addition to the existing system-wide access-controls. This kind of sandbox
+is expected to help mitigate the security impact of bugs or
+unexpected/malicious behaviors in user-space applications. Landlock empowers
+any process, including unprivileged ones, to securely restrict themselves.
+
+.. toctree::
+
+    user
+    kernel
diff --git a/Documentation/security/landlock/kernel.rst b/Documentation/security/landlock/kernel.rst
new file mode 100644
index 000000000000..f382d830cbc0
--- /dev/null
+++ b/Documentation/security/landlock/kernel.rst
@@ -0,0 +1,69 @@
+==============================
+Landlock: kernel documentation
+==============================
+
+Landlock's goal is to create scoped access-control (i.e. sandboxing).  To
+harden a whole system, this feature should be available to any process,
+including unprivileged ones.  Because such process may be compromised or
+backdoored (i.e. untrusted), Landlock's features must be safe to use from the
+kernel and other processes point of view.  Landlock's interface must therefore
+expose a minimal attack surface.
+
+Landlock is designed to be usable by unprivileged processes while following the
+system security policy enforced by other access control mechanisms (e.g. DAC,
+LSM).  Indeed, a Landlock rule shall not interfere with other access-controls
+enforced on the system, only add more restrictions.
+
+Any user can enforce Landlock rulesets on their processes.  They are merged and
+evaluated according to the inherited ones in a way that ensures that only more
+constraints can be added.
+
+Guiding principles for safe access controls
+===========================================
+
+* A Landlock rule shall be focused on access control on kernel objects instead
+  of syscall filtering (i.e. syscall arguments), which is the purpose of
+  seccomp-bpf.
+* To avoid multiple kinds of side-channel attacks (e.g. leak of security
+  policies, CPU-based attacks), Landlock rules shall not be able to
+  programmatically communicate with user space.
+* Kernel access check shall not slow down access request from unsandboxed
+  processes.
+* Computation related to Landlock operations (e.g. enforcing a ruleset) shall
+  only impact the processes requesting them.
+
+Tests
+=====
+
+Userspace tests for backward compatibility, ptrace restrictions and filesystem
+support can be found here: `tools/testing/selftests/landlock/`_.
+
+Kernel structures
+=================
+
+Object
+------
+
+.. kernel-doc:: security/landlock/object.h
+    :identifiers:
+
+Ruleset and domain
+------------------
+
+A domain is a read-only ruleset tied to a set of subjects (i.e. tasks'
+credentials).  Each time a ruleset is enforced on a task, the current domain is
+duplicated and the ruleset is imported as a new layer of rules in the new
+domain.  Indeed, once in a domain, each rule is tied to a layer level.  To
+grant access to an object, at least one rule of each layer must allow the
+requested action on the object.  A task can then only transit to a new domain
+which is the intersection of the constraints from the current domain and those
+of a ruleset provided by the task.
+
+The definition of a subject is implicit for a task sandboxing itself, which
+makes the reasoning much easier and helps avoid pitfalls.
+
+.. kernel-doc:: security/landlock/ruleset.h
+    :identifiers:
+
+.. Links
+.. _tools/testing/selftests/landlock/: https://github.com/landlock-lsm/linux/tree/landlock-v20/tools/testing/selftests/landlock/
diff --git a/Documentation/security/landlock/user.rst b/Documentation/security/landlock/user.rst
new file mode 100644
index 000000000000..605ff5991fe7
--- /dev/null
+++ b/Documentation/security/landlock/user.rst
@@ -0,0 +1,271 @@
+=================================
+Landlock: userspace documentation
+=================================
+
+Landlock rules
+==============
+
+A Landlock rule enables to describe an action on an object.  An object is
+currently a file hierarchy, and the related filesystem actions are defined in
+`Access rights`_.  A set of rules is aggregated in a ruleset, which can then
+restrict the thread enforcing it, and its future children.
+
+Defining and enforcing a security policy
+----------------------------------------
+
+Before defining a security policy, an application should first probe for the
+features supported by the running kernel, which is important to be compatible
+with older kernels.  This can be done thanks to the sys_landlock_get_features().
+syscall.
+
+.. code-block:: c
+
+    struct landlock_attr_features attr_features;
+
+    if (landlock_get_features(&attr_features, sizeof(attr_features), 0)) {
+        perror("Failed to probe the Landlock supported features");
+        return 1;
+    }
+
+Then, we need to create the ruleset that will contain our rules.  For this
+example, the ruleset will contain rules which only allow read actions, but
+write actions will be denied.  The ruleset then needs to handle both of these
+kind of actions.  To have a backward compatibility, these actions should be
+ANDed with the supported ones.
+
+.. code-block:: c
+
+    int ruleset_fd;
+    struct landlock_attr_ruleset ruleset = {
+        .handled_access_fs =
+            LANDLOCK_ACCESS_FS_EXECUTE |
+            LANDLOCK_ACCESS_FS_WRITE_FILE |
+            LANDLOCK_ACCESS_FS_READ_FILE |
+            LANDLOCK_ACCESS_FS_READ_DIR |
+            LANDLOCK_ACCESS_FS_REMOVE_DIR |
+            LANDLOCK_ACCESS_FS_REMOVE_FILE |
+            LANDLOCK_ACCESS_FS_MAKE_CHAR |
+            LANDLOCK_ACCESS_FS_MAKE_DIR |
+            LANDLOCK_ACCESS_FS_MAKE_REG |
+            LANDLOCK_ACCESS_FS_MAKE_SOCK |
+            LANDLOCK_ACCESS_FS_MAKE_FIFO |
+            LANDLOCK_ACCESS_FS_MAKE_BLOCK |
+            LANDLOCK_ACCESS_FS_MAKE_SYM,
+    };
+
+    ruleset.handled_access_fs &= attr_features.access_fs;
+    ruleset_fd = landlock_create_ruleset(&ruleset, sizeof(ruleset), 0);
+    if (ruleset_fd < 0) {
+        perror("Failed to create a ruleset");
+        return 1;
+    }
+
+We can now add a new rule to this ruleset thanks to the returned file
+descriptor referring to this ruleset.  The rule will only enable to read the
+file hierarchy ``/usr``.  Without another rule, write actions would then be
+denied by the ruleset.  To add ``/usr`` to the ruleset, we open it with the
+``O_PATH`` flag and fill the &struct landlock_attr_path_beneath with this file
+descriptor.
+
+.. code-block:: c
+
+    int err;
+    struct landlock_attr_path_beneath path_beneath = {
+        .allowed_access =
+            LANDLOCK_ACCESS_FS_EXECUTE |
+            LANDLOCK_ACCESS_FS_READ_FILE |
+            LANDLOCK_ACCESS_FS_READ_DIR,
+    };
+
+    path_beneath.allowed_access &= attr_features.access_fs;
+    path_beneath.parent_fd = open("/usr", O_PATH | O_CLOEXEC);
+    if (path_beneath.parent_fd < 0) {
+        perror("Failed to open file");
+        close(ruleset_fd);
+        return 1;
+    }
+    err = landlock_add_rule(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
+                            &path_beneath, sizeof(path_beneath), 0);
+    close(path_beneath.parent_fd);
+    if (err) {
+        perror("Failed to update ruleset");
+        close(ruleset_fd);
+        return 1;
+    }
+
+We now have a ruleset with one rule allowing read access to ``/usr`` while
+denying all accesses featured in ``attr_features.access_fs`` to everything else
+on the filesystem.  The next step is to restrict the current thread from
+gaining more privileges (e.g. thanks to a SUID binary).
+
+.. code-block:: c
+
+    if (prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0)) {
+        perror("Failed to restrict privileges");
+        close(ruleset_fd);
+        return 1;
+    }
+
+The current thread is now ready to sandbox itself with the ruleset.
+
+.. code-block:: c
+
+    if (landlock_enforce_ruleset(ruleset_fd, 0)) {
+        perror("Failed to enforce ruleset");
+        close(ruleset_fd);
+        return 1;
+    }
+    close(ruleset_fd);
+
+If the `landlock_enforce_ruleset` system call succeeds, the current thread is
+now restricted and this policy will be enforced on all its subsequently created
+children as well.  Once a thread is landlocked, there is no way to remove its
+security policy; only adding more restrictions is allowed.  These threads are
+now in a new Landlock domain, merge of their parent one (if any) with the new
+ruleset.
+
+Full working code can be found in `samples/landlock/sandboxer.c`_.
+
+Inheritance
+-----------
+
+Every new thread resulting from a :manpage:`clone(2)` inherits Landlock domain
+restrictions from its parent.  This is similar to the seccomp inheritance (cf.
+:doc:`/userspace-api/seccomp_filter`) or any other LSM dealing with task's
+:manpage:`credentials(7)`.  For instance, one process's thread may apply
+Landlock rules to itself, but they will not be automatically applied to other
+sibling threads (unlike POSIX thread credential changes, cf.
+:manpage:`nptl(7)`).
+
+When a thread sandbox itself, we have the grantee that the related security
+policy will stay enforced on all this thread's descendants.  This enables to
+create standalone and modular security policies per application, which will
+automatically be composed between themselves according to their runtime parent
+policies.
+
+Ptrace restrictions
+-------------------
+
+A sandboxed process has less privileges than a non-sandboxed process and must
+then be subject to additional restrictions when manipulating another process.
+To be allowed to use :manpage:`ptrace(2)` and related syscalls on a target
+process, a sandboxed process should have a subset of the target process rules,
+which means the tracee must be in a sub-domain of the tracer.
+
+Kernel interface
+================
+
+Access rights
+-------------
+
+.. kernel-doc:: include/uapi/linux/landlock.h
+    :identifiers: fs_access
+
+
+Fetching the supported features
+-------------------------------
+
+.. kernel-doc:: security/landlock/syscall.c
+    :identifiers: sys_landlock_get_features
+
+.. kernel-doc:: include/uapi/linux/landlock.h
+    :identifiers: landlock_attr_features
+
+Creating a new ruleset
+----------------------
+
+.. kernel-doc:: security/landlock/syscall.c
+    :identifiers: sys_landlock_create_ruleset
+
+.. kernel-doc:: include/uapi/linux/landlock.h
+    :identifiers: landlock_attr_ruleset
+
+Extending a ruleset
+-------------------
+
+.. kernel-doc:: security/landlock/syscall.c
+    :identifiers: sys_landlock_add_rule
+
+.. kernel-doc:: include/uapi/linux/landlock.h
+    :identifiers: landlock_rule_type landlock_attr_path_beneath
+
+Enforcing a ruleset
+-------------------
+
+.. kernel-doc:: security/landlock/syscall.c
+    :identifiers: sys_landlock_enforce_ruleset
+
+.. kernel-doc:: include/uapi/linux/landlock.h
+    :identifiers: landlock_target_type
+
+Current limitations
+===================
+
+File renaming and linking
+-------------------------
+
+Because Landlock targets unprivileged access controls, it is needed to properly
+handle composition of rules.  Such property also implies rules nesting.
+Properly handling multiple layers of ruleset, each one of them able to restrict
+access to files, also imply to inherit the ruleset restrictions from a parent
+to its hierarchy.  Because files are identified and restricted by their
+hierarchy, moving or linking a file from one directory to another imply to
+propagate the hierarchy constraints.  To protect against privilege escalations
+through renaming or linking, and for the sack of simplicity, Landlock currently
+limits linking and renaming to the same directory.  Future Landlock evolutions
+will enable more flexibility for renaming and linking, with dedicated ruleset
+options.
+
+OverlayFS
+---------
+
+An OverlayFS mount point consists of upper and lower layers.  It is currently
+not possible to reliably infer which underlying file hierarchy matches an
+OverlayFS path composed of such layers.  It is then not currently possible to
+track the source of an indirect access-request, and then not possible to
+properly identify and allow an unified OverlayFS hierarchy.  Restricting files
+in an OverlayFS mount point works, but files allowed in one layer may not be
+allowed in a related OverlayFS mount point.  A future Landlock evolution will
+make possible to properly work with OverlayFS, according to a dedicated ruleset
+option.
+
+
+Special filesystems
+-------------------
+
+Access to regular files and directories can be restricted by Landlock,
+according to the handled accesses of a ruleset.  However, files which do not
+come from a user-visible filesystem (e.g. pipe, socket), but can still be
+accessed through /proc/self/fd/, cannot currently be restricted.  Likewise,
+some special kernel filesystems such as nsfs which can be accessed through
+/proc/self/ns/, cannot currently be restricted.  For now, these kind of special
+paths are then always allowed.  Future Landlock evolutions will enable to
+restrict such paths, with dedicated ruleset options.
+
+Questions and answers
+=====================
+
+What about user space sandbox managers?
+---------------------------------------
+
+Using user space process to enforce restrictions on kernel resources can lead
+to race conditions or inconsistent evaluations (i.e. `Incorrect mirroring of
+the OS code and state
+<https://www.ndss-symposium.org/ndss2003/traps-and-pitfalls-practical-problems-system-call-interposition-based-security-tools/>`_).
+
+What about namespaces and containers?
+-------------------------------------
+
+Namespaces can help create sandboxes but they are not designed for
+access-control and then miss useful features for such use case (e.g. no
+fine-grained restrictions).  Moreover, their complexity can lead to security
+issues, especially when untrusted processes can manipulate them (cf.
+`Controlling access to user namespaces <https://lwn.net/Articles/673597/>`_).
+
+Additional documentation
+========================
+
+See https://landlock.io
+
+.. Links
+.. _samples/landlock/sandboxer.c: https://github.com/landlock-lsm/linux/tree/landlock-v20/samples/landlock/sandboxer.c
diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
index eb2a5e0d61a4..7d3bbde738b6 100644
--- a/include/uapi/linux/landlock.h
+++ b/include/uapi/linux/landlock.h
@@ -11,18 +11,6 @@
 
 #include <linux/types.h>
 
-#if 0
-/**
- * DOC: options_intro
- *
- * These options may be used as second argument of sys_landlock().  Each
- * command have a dedicated set of options, represented as bitmasks.  For two
- * different commands, their options may overlap.  Each command have at least
- * one option defining the used attribute type.  This also enables to always
- * have a usable &struct landlock_attr_features (i.e. filled with bits).
- */
-#endif
-
 /**
  * enum landlock_rule_type - Landlock rule type
  *
@@ -52,31 +40,7 @@ enum landlock_target_type {
 /**
  * struct landlock_attr_features - Receives the supported features
  *
- * This struct should be allocated by user space but it will be filled by the
- * kernel to indicate the subset of Landlock features effectively handled by
- * the running kernel.  This enables backward compatibility for applications
- * which are developed on a newer kernel than the one running the application.
- * This helps avoid hard errors that may entirely disable the use of Landlock
- * features because some of them may not be supported.  Indeed, because
- * Landlock is a security feature, even if the kernel doesn't support all the
- * requested features, user space applications should still use the subset
- * which is supported by the running kernel.  Indeed, a partial security policy
- * can still improve the security of the application and better protect the
- * user (i.e. best-effort approach).  The %LANDLOCK_CMD_GET_FEATURES command
- * and &struct landlock_attr_features are future-proof because the future
- * unknown fields requested by user space (i.e. a larger &struct
- * landlock_attr_features) can still be filled with zeros.
- *
- * The Landlock commands will fail if an unsupported option or access is
- * requested.  By firstly requesting the supported options and accesses, it is
- * quite easy for the developer to binary AND these returned bitmasks with the
- * used options and accesses from the attribute structs (e.g. &struct
- * landlock_attr_ruleset), and even infer the supported Landlock commands.
- * Indeed, because each command must support at least one option, the options_*
- * fields are always filled if the related commands are supported.  The
- * supported attributes are also discoverable thanks to the size_* fields.  All
- * this data enable to create applications doing their best to sandbox
- * themselves regardless of the running kernel.
+ * Argument of sys_landlock_get_features().
  */
 struct landlock_attr_features {
 	/**
@@ -138,8 +102,7 @@ struct landlock_attr_features {
 /**
  * struct landlock_attr_ruleset- Defines a new ruleset
  *
- * Used as first attribute for the %LANDLOCK_CMD_CREATE_RULESET command and
- * with the %LANDLOCK_OPT_CREATE_RULESET option.
+ * Argument of sys_landlock_create_ruleset().
  */
 struct landlock_attr_ruleset {
 	/**
@@ -147,15 +110,17 @@ struct landlock_attr_ruleset {
 	 * that is handled by this ruleset and should then be forbidden if no
 	 * rule explicitly allow them.  This is needed for backward
 	 * compatibility reasons.  The user space code should check the
-	 * effectively supported actions thanks to %LANDLOCK_CMD_GET_FEATURES
-	 * and &struct landlock_attr_features, and then adjust the arguments of
-	 * the next calls to sys_landlock() accordingly.
+	 * effectively supported actions thanks to sys_landlock_get_features()
+	 * and then adjust the arguments of the next calls to
+	 * sys_landlock_create_ruleset() accordingly.
 	 */
 	__u64 handled_access_fs;
 };
 
 /**
  * struct landlock_attr_path_beneath - Defines a path hierarchy
+ *
+ * Argument of sys_landlock_add_rule().
  */
 struct landlock_attr_path_beneath {
 	/**
diff --git a/security/landlock/syscall.c b/security/landlock/syscall.c
index 7bf4dc175dee..bba66db211a1 100644
--- a/security/landlock/syscall.c
+++ b/security/landlock/syscall.c
@@ -132,15 +132,32 @@ static void build_check_abi(void)
 /**
  * sys_landlock_get_features - Identify the supported Landlock features
  *
- * @features_ptr: Pointer to a &struct landlock_attr_features to be filled by
- *		  the supported features.
+ * @features_ptr: Pointer to a &struct landlock_attr_features (allocated by
+ *                user space) to be filled by the supported features.
  * @features_size: Size of the pointed &struct landlock_attr_features (needed
  *		   for backward and forward compatibility).
  * @options: Must be 0.
  *
- * This system call enables to ask the kernel for supported Landlock features.
- * This is important to build user space code compatible with older and newer
- * kernels.
+ * This system call enables to ask for the Landlock features effectively
+ * handled by the running kernel.  This enables backward compatibility for
+ * applications which are developed on a newer kernel than the one running the
+ * application.  This helps avoid hard errors that may entirely disable the use
+ * of Landlock features because some of them may not be supported.  Indeed,
+ * because Landlock is a security feature, even if the kernel doesn't support
+ * all the requested features, user space applications should still use the
+ * subset which is supported by the running kernel.  Indeed, a partial security
+ * policy can still improve the security of the application and better protect
+ * the user (i.e. best-effort approach).  Handling of &struct
+ * landlock_attr_features with sys_landlock_get_features() is future-proof
+ * because the future unknown fields requested by user space (i.e. a larger
+ * &struct landlock_attr_features) can still be filled with zeros.
+ *
+ * The other Landlock syscalls will fail if an unsupported option or access is
+ * requested.  By firstly requesting the supported options and accesses, it is
+ * quite easy for the developer to binary AND these returned bitmasks with the
+ * used options and accesses from the attribute structs (e.g. &struct
+ * landlock_attr_ruleset).  This enables to create applications doing their
+ * best to sandbox themselves regardless of the running kernel.
  *
  * Possible returned errors are:
  *
-- 
2.28.0.rc2

