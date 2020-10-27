Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49C4E29C99B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Oct 2020 21:07:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1830825AbgJ0UE4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Oct 2020 16:04:56 -0400
Received: from smtp-bc0c.mail.infomaniak.ch ([45.157.188.12]:50509 "EHLO
        smtp-bc0c.mail.infomaniak.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1830676AbgJ0UEg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Oct 2020 16:04:36 -0400
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4CLN2X0r1hzlhb67;
        Tue, 27 Oct 2020 21:04:20 +0100 (CET)
Received: from localhost (unknown [94.23.54.103])
        by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4CLN2W5QZTzlh8T9;
        Tue, 27 Oct 2020 21:04:19 +0100 (CET)
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@amacapital.net>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Jann Horn <jannh@google.com>, Jeff Dike <jdike@addtoit.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Shuah Khan <shuah@kernel.org>,
        Vincent Dagonneau <vincent.dagonneau@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-security-module@vger.kernel.org, x86@kernel.org,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@linux.microsoft.com>
Subject: [PATCH v22 12/12] landlock: Add user and kernel documentation
Date:   Tue, 27 Oct 2020 21:03:58 +0100
Message-Id: <20201027200358.557003-13-mic@digikod.net>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201027200358.557003-1-mic@digikod.net>
References: <20201027200358.557003-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Mickaël Salaün <mic@linux.microsoft.com>

This documentation can be built with the Sphinx framework.

Cc: James Morris <jmorris@namei.org>
Cc: Jann Horn <jannh@google.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Serge E. Hallyn <serge@hallyn.com>
Signed-off-by: Mickaël Salaün <mic@linux.microsoft.com>
Reviewed-by: Vincent Dagonneau <vincent.dagonneau@ssi.gouv.fr>
---

Changes since v21:
* Move the user space documentation to userspace-api/landlock.rst and
  the kernel documentation to security/landlock.rst .
* Add license headers.
* Add last update dates.
* Update MAINTAINERS file.
* Add (back) links to git.kernel.org .
* Fix spelling.

Changes since v20:
* Update examples and documentation with the new syscalls.

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
 Documentation/security/index.rst         |   1 +
 Documentation/security/landlock.rst      |  79 +++++++
 Documentation/userspace-api/index.rst    |   1 +
 Documentation/userspace-api/landlock.rst | 259 +++++++++++++++++++++++
 MAINTAINERS                              |   2 +
 5 files changed, 342 insertions(+)
 create mode 100644 Documentation/security/landlock.rst
 create mode 100644 Documentation/userspace-api/landlock.rst

diff --git a/Documentation/security/index.rst b/Documentation/security/index.rst
index 8129405eb2cc..16335de04e8c 100644
--- a/Documentation/security/index.rst
+++ b/Documentation/security/index.rst
@@ -16,3 +16,4 @@ Security Documentation
    siphash
    tpm/index
    digsig
+   landlock
diff --git a/Documentation/security/landlock.rst b/Documentation/security/landlock.rst
new file mode 100644
index 000000000000..9b619eb4fe55
--- /dev/null
+++ b/Documentation/security/landlock.rst
@@ -0,0 +1,79 @@
+.. SPDX-License-Identifier: GPL-2.0
+.. Copyright © 2017-2020 Mickaël Salaün <mic@digikod.net>
+.. Copyright © 2019-2020 ANSSI
+
+==================================
+Landlock LSM: kernel documentation
+==================================
+
+:Author: Mickaël Salaün
+:Date: October 2020
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
+User space documentation can be found here: :doc:`/userspace-api/landlock`.
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
+.. _tools/testing/selftests/landlock/:
+   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/tools/testing/selftests/landlock/
diff --git a/Documentation/userspace-api/index.rst b/Documentation/userspace-api/index.rst
index 69fc5167e648..4918fbed5be0 100644
--- a/Documentation/userspace-api/index.rst
+++ b/Documentation/userspace-api/index.rst
@@ -18,6 +18,7 @@ place where this information is gathered.
 
    no_new_privs
    seccomp_filter
+   landlock
    unshare
    spec_ctrl
    accelerators/ocxl
diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
new file mode 100644
index 000000000000..793d5ed11a05
--- /dev/null
+++ b/Documentation/userspace-api/landlock.rst
@@ -0,0 +1,259 @@
+.. SPDX-License-Identifier: GPL-2.0
+.. Copyright © 2017-2020 Mickaël Salaün <mic@digikod.net>
+.. Copyright © 2019-2020 ANSSI
+
+=====================================
+Landlock: unprivileged access control
+=====================================
+
+:Author: Mickaël Salaün
+:Date: October 2020
+
+The goal of Landlock is to enable to restrict ambient rights (e.g. global
+filesystem access) for a set of processes.  Because Landlock is a stackable
+LSM, it makes possible to create safe security sandboxes as new security layers
+in addition to the existing system-wide access-controls. This kind of sandbox
+is expected to help mitigate the security impact of bugs or
+unexpected/malicious behaviors in user space applications.  Landlock empowers
+any process, including unprivileged ones, to securely restrict themselves.
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
+We first need to create the ruleset that will contain our rules.  For this
+example, the ruleset will contain rules which only allow read actions, but
+write actions will be denied.  The ruleset then needs to handle both of these
+kind of actions.  To have a backward compatibility, these actions should be
+ANDed with the supported ones.
+
+.. code-block:: c
+
+    int ruleset_fd;
+    struct landlock_ruleset_attr ruleset_attr = {
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
+    ruleset_fd = landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
+    if (ruleset_fd < 0) {
+        perror("Failed to create a ruleset");
+        return 1;
+    }
+
+We can now add a new rule to this ruleset thanks to the returned file
+descriptor referring to this ruleset.  The rule will only enable to read the
+file hierarchy ``/usr``.  Without another rule, write actions would then be
+denied by the ruleset.  To add ``/usr`` to the ruleset, we open it with the
+``O_PATH`` flag and fill the &struct landlock_path_beneath_attr with this file
+descriptor.
+
+.. code-block:: c
+
+    int err;
+    struct landlock_path_beneath_attr path_beneath = {
+        .allowed_access =
+            LANDLOCK_ACCESS_FS_EXECUTE |
+            LANDLOCK_ACCESS_FS_READ_FILE |
+            LANDLOCK_ACCESS_FS_READ_DIR,
+    };
+
+    path_beneath.parent_fd = open("/usr", O_PATH | O_CLOEXEC);
+    if (path_beneath.parent_fd < 0) {
+        perror("Failed to open file");
+        close(ruleset_fd);
+        return 1;
+    }
+    err = landlock_add_rule(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
+                            &path_beneath, 0);
+    close(path_beneath.parent_fd);
+    if (err) {
+        perror("Failed to update ruleset");
+        close(ruleset_fd);
+        return 1;
+    }
+
+We now have a ruleset with one rule allowing read access to ``/usr`` while
+denying all other handled accesses for the filesystem.  The next step is to
+restrict the current thread from gaining more privileges (e.g. thanks to a SUID
+binary).
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
+    if (landlock_enforce_ruleset_current(ruleset_fd, 0)) {
+        perror("Failed to enforce ruleset");
+        close(ruleset_fd);
+        return 1;
+    }
+    close(ruleset_fd);
+
+If the `landlock_enforce_ruleset_current` system call succeeds, the current
+thread is now restricted and this policy will be enforced on all its
+subsequently created children as well.  Once a thread is landlocked, there is
+no way to remove its security policy; only adding more restrictions is allowed.
+These threads are now in a new Landlock domain, merge of their parent one (if
+any) with the new ruleset.
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
+Creating a new ruleset
+----------------------
+
+.. kernel-doc:: security/landlock/syscall.c
+    :identifiers: sys_landlock_create_ruleset
+
+.. kernel-doc:: include/uapi/linux/landlock.h
+    :identifiers: landlock_ruleset_attr
+
+Extending a ruleset
+-------------------
+
+.. kernel-doc:: security/landlock/syscall.c
+    :identifiers: sys_landlock_add_rule
+
+.. kernel-doc:: include/uapi/linux/landlock.h
+    :identifiers: landlock_rule_type landlock_path_beneath_attr
+
+Enforcing a ruleset
+-------------------
+
+.. kernel-doc:: security/landlock/syscall.c
+    :identifiers: sys_landlock_enforce_ruleset_current
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
+access to files, also implies to inherit the ruleset restrictions from a parent
+to its hierarchy.  Because files are identified and restricted by their
+hierarchy, moving or linking a file from one directory to another imply to
+propagate the hierarchy constraints.  To protect against privilege escalations
+through renaming or linking, and for the sack of simplicity, Landlock currently
+limits linking and renaming to the same directory.  Future Landlock evolutions
+will enable more flexibility for renaming and linking, with dedicated ruleset
+flags.
+
+OverlayFS
+---------
+
+An OverlayFS mount point consists of upper and lower layers.  It is currently
+not possible to reliably infer which underlying file hierarchy matches an
+OverlayFS path composed of such layers.  It is then not currently possible to
+track the source of an indirect access request, and then not possible to
+properly identify and allow an unified OverlayFS hierarchy.  Restricting files
+in an OverlayFS mount point works, but files allowed in one layer may not be
+allowed in a related OverlayFS mount point.  A future Landlock evolution will
+make possible to properly work with OverlayFS, according to a dedicated ruleset
+flag.
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
+restrict such paths, with dedicated ruleset flags.
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
+* :doc:`/security/landlock`
+* https://landlock.io
+
+.. Links
+.. _samples/landlock/sandboxer.c:
+   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/samples/landlock/sandboxer.c
diff --git a/MAINTAINERS b/MAINTAINERS
index 43021f8c95bb..ac31dfd7663c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9852,6 +9852,8 @@ L:	linux-security-module@vger.kernel.org
 S:	Supported
 W:	https://landlock.io
 T:	git https://github.com/landlock-lsm/linux.git
+F:	Documentation/security/landlock.rst
+F:	Documentation/userspace-api/landlock.rst
 F:	include/uapi/linux/landlock.h
 F:	security/landlock/
 K:	landlock
-- 
2.28.0

