Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62BC91CE428
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 May 2020 21:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731464AbgEKTXR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 May 2020 15:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731433AbgEKTWU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 May 2020 15:22:20 -0400
Received: from smtp-42ab.mail.infomaniak.ch (smtp-42ab.mail.infomaniak.ch [IPv6:2001:1600:3:17::42ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 197C4C061A0E
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 May 2020 12:22:19 -0700 (PDT)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 49LW616VlQzlhHQB;
        Mon, 11 May 2020 21:22:17 +0200 (CEST)
Received: from localhost (unknown [94.23.54.103])
        by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 49LW613S17zlhHR1;
        Mon, 11 May 2020 21:22:17 +0200 (CEST)
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@amacapital.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Casey Schaufler <casey@schaufler-ca.com>,
        James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mickael.salaun@ssi.gouv.fr>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Shuah Khan <shuah@kernel.org>,
        Vincent Dagonneau <vincent.dagonneau@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-security-module@vger.kernel.org, x86@kernel.org
Subject: [PATCH v17 10/10] landlock: Add user and kernel documentation
Date:   Mon, 11 May 2020 21:21:56 +0200
Message-Id: <20200511192156.1618284-11-mic@digikod.net>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200511192156.1618284-1-mic@digikod.net>
References: <20200511192156.1618284-1-mic@digikod.net>
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
 Documentation/security/landlock/user.rst   | 268 +++++++++++++++++++++
 4 files changed, 356 insertions(+)
 create mode 100644 Documentation/security/landlock/index.rst
 create mode 100644 Documentation/security/landlock/kernel.rst
 create mode 100644 Documentation/security/landlock/user.rst

diff --git a/Documentation/security/index.rst b/Documentation/security/index.rst
index fc503dd689a7..4d213e76ddf4 100644
--- a/Documentation/security/index.rst
+++ b/Documentation/security/index.rst
@@ -15,3 +15,4 @@ Security Documentation
    self-protection
    siphash
    tpm/index
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
index 000000000000..bfe5b6192943
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
+* Computation related to Landlock operations (e.g. enforce a ruleset) shall
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
+.. _tools/testing/selftests/landlock/: https://github.com/landlock-lsm/linux/tree/landlock-v17/tools/testing/selftests/landlock/
diff --git a/Documentation/security/landlock/user.rst b/Documentation/security/landlock/user.rst
new file mode 100644
index 000000000000..1efd082fa234
--- /dev/null
+++ b/Documentation/security/landlock/user.rst
@@ -0,0 +1,268 @@
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
+with older kernels.  This can be done thanks to the `landlock` syscall (cf.
+:ref:`syscall`).
+
+.. code-block:: c
+
+    struct landlock_attr_features attr_features;
+
+    if (landlock(LANDLOCK_CMD_GET_FEATURES, LANDLOCK_OPT_GET_FEATURES,
+            sizeof(attr_features), &attr_features)) {
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
+    ruleset_fd = landlock(LANDLOCK_CMD_CREATE_RULESET,
+                    LANDLOCK_OPT_CREATE_RULESET, sizeof(ruleset), &ruleset);
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
+        .ruleset_fd = ruleset_fd,
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
+    err = landlock(LANDLOCK_CMD_ADD_RULE, LANDLOCK_OPT_ADD_RULE_PATH_BENEATH,
+            sizeof(path_beneath), &path_beneath);
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
+    struct landlock_attr_enforce attr_enforce = {
+        .ruleset_fd = ruleset_fd,
+    };
+
+    if (landlock(LANDLOCK_CMD_ENFORCE_RULESET, LANDLOCK_OPT_ENFORCE_RULESET,
+            sizeof(attr_enforce), &attr_enforce)) {
+        perror("Failed to enforce ruleset");
+        close(ruleset_fd);
+        return 1;
+    }
+    close(ruleset_fd);
+
+If the last `landlock` system call succeeds, the current thread is now
+restricted and this policy will be enforced on all its subsequently created
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
+.. _syscall:
+
+The `landlock` syscall and its arguments
+========================================
+
+.. kernel-doc:: security/landlock/syscall.c
+    :identifiers: sys_landlock
+
+Commands
+--------
+
+.. kernel-doc:: include/uapi/linux/landlock.h
+    :identifiers: landlock_cmd
+
+Options
+-------
+
+.. kernel-doc:: include/uapi/linux/landlock.h
+    :identifiers: options_intro
+                  options_get_features options_create_ruleset
+                  options_add_rule options_enforce_ruleset
+
+Attributes
+----------
+
+.. kernel-doc:: include/uapi/linux/landlock.h
+    :identifiers: landlock_attr_features landlock_attr_ruleset
+                  landlock_attr_path_beneath landlock_attr_enforce
+
+Access rights
+-------------
+
+.. kernel-doc:: include/uapi/linux/landlock.h
+    :identifiers: fs_access
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
+.. _samples/landlock/sandboxer.c: https://github.com/landlock-lsm/linux/tree/landlock-v17/samples/landlock/sandboxer.c
-- 
2.26.2

