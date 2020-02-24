Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31D5716AABA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2020 17:08:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727448AbgBXQIB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Feb 2020 11:08:01 -0500
Received: from smtp-1908.mail.infomaniak.ch ([185.125.25.8]:38901 "EHLO
        smtp-1908.mail.infomaniak.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727339AbgBXQIB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Feb 2020 11:08:01 -0500
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 977BE100389F3;
        Mon, 24 Feb 2020 17:02:36 +0100 (CET)
Received: from localhost (unknown [94.23.54.103])
        by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 48R6K81fbBzlh9Dl;
        Mon, 24 Feb 2020 17:02:36 +0100 (CET)
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@amacapital.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Morris <jmorris@namei.org>, Jann Horn <jann@thejh.net>,
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
Subject: [RFC PATCH v14 10/10] landlock: Add user and kernel documentation
Date:   Mon, 24 Feb 2020 17:02:15 +0100
Message-Id: <20200224160215.4136-11-mic@digikod.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200224160215.4136-1-mic@digikod.net>
References: <20200224160215.4136-1-mic@digikod.net>
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

Another location might be more appropriate, though.

Signed-off-by: Mickaël Salaün <mic@digikod.net>
Reviewed-by: Vincent Dagonneau <vincent.dagonneau@ssi.gouv.fr>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: James Morris <jmorris@namei.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Serge E. Hallyn <serge@hallyn.com>
---

Changes since v13:
* Rewrote the documentation according to the major revamp.

Previous version:
https://lore.kernel.org/lkml/20191104172146.30797-8-mic@digikod.net/
---
 Documentation/security/index.rst           |   1 +
 Documentation/security/landlock/index.rst  |  18 ++
 Documentation/security/landlock/kernel.rst |  44 ++++
 Documentation/security/landlock/user.rst   | 233 +++++++++++++++++++++
 4 files changed, 296 insertions(+)
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
index 000000000000..dbd33b96ce60
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
+unexpected/malicious behaviors in user-space applications. Landlock empower any
+process, including unprivileged ones, to securely restrict themselves.
+
+.. toctree::
+
+    user
+    kernel
diff --git a/Documentation/security/landlock/kernel.rst b/Documentation/security/landlock/kernel.rst
new file mode 100644
index 000000000000..b87769909029
--- /dev/null
+++ b/Documentation/security/landlock/kernel.rst
@@ -0,0 +1,44 @@
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
+evaluated according to the inherited ones in a way that ensure that only more
+constraints can be added.
+
+
+Guiding principles for safe access controls
+===========================================
+
+* A Landlock rule shall be focused on access control on kernel objects instead
+  of syscall filtering (i.e. syscall arguments), which is the purpose of
+  seccomp-bpf.
+* To avoid multiple kind of side-channel attacks (e.g. leak of security
+  policies, CPU-based attacks), Landlock rules shall not be able to
+  programmatically communicate with user space.
+* Kernel access check shall not slow down access request from unsandboxed
+  processes.
+* Computation related to Landlock operations (e.g. enforce a ruleset) shall
+  only impact the processes requesting them.
+
+
+Landlock rulesets and domains
+=============================
+
+A domain is a read-only ruleset tied to a set of subjects (i.e. tasks).  A
+domain can transition to a new one which is the intersection of the constraints
+from the current and a new ruleset.  The definition of a subject is implicit
+for a task sandboxing itself, which makes the reasoning much easier and helps
+avoid pitfalls.
diff --git a/Documentation/security/landlock/user.rst b/Documentation/security/landlock/user.rst
new file mode 100644
index 000000000000..cbd7f61fca8c
--- /dev/null
+++ b/Documentation/security/landlock/user.rst
@@ -0,0 +1,233 @@
+=================================
+Landlock: userspace documentation
+=================================
+
+Landlock rules
+==============
+
+A Landlock rule enables to describe an action on an object.  An object is
+currently a file hierarchy, and the related filesystem actions are defined in
+`Access rights`_.  A set of rules are aggregated in a ruleset, which can then
+restricts the thread enforcing it, and its future children.
+
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
+Then, we need to create the ruleset that will contains our rules.  For this
+example, the ruleset will contains rules which only allow read actions, but
+write actions will be denied.  The ruleset then needs to handle both of these
+kind of actions.  To have a backward compatibility, these actions should be
+ANDed with the supported ones.
+
+.. code-block:: c
+
+    int ruleset_fd;
+    struct landlock_attr_ruleset ruleset = {
+        .handled_access_fs =
+            LANDLOCK_ACCESS_FS_READ |
+            LANDLOCK_ACCESS_FS_READDIR |
+            LANDLOCK_ACCESS_FS_EXECUTE |
+            LANDLOCK_ACCESS_FS_WRITE |
+            LANDLOCK_ACCESS_FS_TRUNCATE |
+            LANDLOCK_ACCESS_FS_CHMOD |
+            LANDLOCK_ACCESS_FS_CHOWN |
+            LANDLOCK_ACCESS_FS_CHGRP |
+            LANDLOCK_ACCESS_FS_LINK_TO |
+            LANDLOCK_ACCESS_FS_RENAME_FROM |
+            LANDLOCK_ACCESS_FS_RENAME_TO |
+            LANDLOCK_ACCESS_FS_RMDIR |
+            LANDLOCK_ACCESS_FS_UNLINK |
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
+file hierarchy ``/usr``.  Without other rule, write actions would then be
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
+            LANDLOCK_ACCESS_FS_READ |
+            LANDLOCK_ACCESS_FS_READDIR |
+            LANDLOCK_ACCESS_FS_EXECUTE,
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
+If this last system call succeeds, the current thread is now restricted and
+this policy will be enforced on all its subsequently created children as well.
+Once a thread is landlocked, there is no way to remove its security policy,
+only adding more restrictions is allowed.  These threads are now in a new
+Landlock domain, merge of their parent one (if any) with the new ruleset.
+
+A full working code can be found in `samples/landlock/sandboxer.c`_.
+
+
+Inheritance
+-----------
+
+Every new thread resulting from a :manpage:`clone(2)` inherits Landlock program
+restrictions from its parent.  This is similar to the seccomp inheritance (cf.
+:doc:`/userspace-api/seccomp_filter`) or any other LSM dealing with task's
+:manpage:`credentials(7)`.  For instance, one process' thread may apply
+Landlock rules to itself, but they will not be automatically applied to other
+sibling threads (unlike POSIX thread credential changes, cf.
+:manpage:`nptl(7)`).
+
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
+
+.. _syscall:
+
+The `landlock` syscall and its arguments
+========================================
+
+.. kernel-doc:: security/landlock/syscall.c
+    :functions: sys_landlock
+
+Commands
+--------
+
+.. kernel-doc:: include/uapi/linux/landlock.h
+    :functions: landlock_cmd
+
+Options
+-------
+
+.. kernel-doc:: include/uapi/linux/landlock.h
+    :functions: options_intro
+                options_get_features options_create_ruleset
+                options_add_rule options_enforce_ruleset
+
+Attributes
+----------
+
+.. kernel-doc:: include/uapi/linux/landlock.h
+    :functions: landlock_attr_features landlock_attr_ruleset
+                landlock_attr_path_beneath landlock_attr_enforce
+
+Access rights
+-------------
+
+.. kernel-doc:: include/uapi/linux/landlock.h
+    :functions: fs_access
+
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
+
+Additional documentation
+========================
+
+See https://landlock.io
+
+
+.. Links
+.. _samples/landlock/sandboxer.c: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/samples/landlock/sandboxer.c
+.. _tools/testing/selftests/landlock/: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/tools/testing/selftests/landlock/
+.. _tools/testing/selftests/landlock/test_ptrace.c: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/tools/testing/selftests/landlock/test_ptrace.c
-- 
2.25.0

