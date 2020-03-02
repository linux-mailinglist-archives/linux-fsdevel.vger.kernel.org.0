Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 518D61757E1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2020 11:03:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727576AbgCBKDk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Mar 2020 05:03:40 -0500
Received: from smtp-42ae.mail.infomaniak.ch ([84.16.66.174]:45297 "EHLO
        smtp-42ae.mail.infomaniak.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727545AbgCBKDk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Mar 2020 05:03:40 -0500
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id E0D75100384F5;
        Mon,  2 Mar 2020 11:03:35 +0100 (CET)
Received: from ns3096276.ip-94-23-54.eu (unknown [94.23.54.103])
        by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 48WG1X0501zlh8V6;
        Mon,  2 Mar 2020 11:03:27 +0100 (CET)
Subject: Re: [RFC PATCH v14 10/10] landlock: Add user and kernel documentation
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@amacapital.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Morris <jmorris@namei.org>, Jann Horn <jann@thejh.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mickael.salaun@ssi.gouv.fr>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Shuah Khan <shuah@kernel.org>,
        Vincent Dagonneau <vincent.dagonneau@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-security-module@vger.kernel.org, x86@kernel.org
References: <20200224160215.4136-1-mic@digikod.net>
 <20200224160215.4136-11-mic@digikod.net>
 <cc8da381-d3dc-3c0a-5afd-96824362b636@infradead.org>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Message-ID: <e22709f2-af4f-9316-d83e-b794f083595c@digikod.net>
Date:   Mon, 2 Mar 2020 11:03:55 +0100
User-Agent: 
MIME-Version: 1.0
In-Reply-To: <cc8da381-d3dc-3c0a-5afd-96824362b636@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Antivirus: Dr.Web (R) for Unix mail servers drweb plugin ver.6.0.2.8
X-Antivirus-Code: 0x100000
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 29/02/2020 18:23, Randy Dunlap wrote:
> Hi,
> Here are a few corrections for you to consider.
> 
> 
> On 2/24/20 8:02 AM, Mickaël Salaün wrote:
>> This documentation can be built with the Sphinx framework.
>>
>> Another location might be more appropriate, though.
>>
>> Signed-off-by: Mickaël Salaün <mic@digikod.net>
>> Reviewed-by: Vincent Dagonneau <vincent.dagonneau@ssi.gouv.fr>
>> Cc: Andy Lutomirski <luto@amacapital.net>
>> Cc: James Morris <jmorris@namei.org>
>> Cc: Kees Cook <keescook@chromium.org>
>> Cc: Serge E. Hallyn <serge@hallyn.com>
>> ---
>>
>> Changes since v13:
>> * Rewrote the documentation according to the major revamp.
>>
>> Previous version:
>> https://lore.kernel.org/lkml/20191104172146.30797-8-mic@digikod.net/
>> ---
>>  Documentation/security/index.rst           |   1 +
>>  Documentation/security/landlock/index.rst  |  18 ++
>>  Documentation/security/landlock/kernel.rst |  44 ++++
>>  Documentation/security/landlock/user.rst   | 233 +++++++++++++++++++++
>>  4 files changed, 296 insertions(+)
>>  create mode 100644 Documentation/security/landlock/index.rst
>>  create mode 100644 Documentation/security/landlock/kernel.rst
>>  create mode 100644 Documentation/security/landlock/user.rst
>>
>> diff --git a/Documentation/security/landlock/index.rst b/Documentation/security/landlock/index.rst
>> new file mode 100644
>> index 000000000000..dbd33b96ce60
>> --- /dev/null
>> +++ b/Documentation/security/landlock/index.rst
>> @@ -0,0 +1,18 @@
>> +=========================================
>> +Landlock LSM: unprivileged access control
>> +=========================================
>> +
>> +:Author: Mickaël Salaün
>> +
>> +The goal of Landlock is to enable to restrict ambient rights (e.g.  global
>> +filesystem access) for a set of processes.  Because Landlock is a stackable
>> +LSM, it makes possible to create safe security sandboxes as new security layers
>> +in addition to the existing system-wide access-controls. This kind of sandbox
>> +is expected to help mitigate the security impact of bugs or
>> +unexpected/malicious behaviors in user-space applications. Landlock empower any
> 
>                                                                        empowers
> 
>> +process, including unprivileged ones, to securely restrict themselves.
>> +
>> +.. toctree::
>> +
>> +    user
>> +    kernel
>> diff --git a/Documentation/security/landlock/kernel.rst b/Documentation/security/landlock/kernel.rst
>> new file mode 100644
>> index 000000000000..b87769909029
>> --- /dev/null
>> +++ b/Documentation/security/landlock/kernel.rst
>> @@ -0,0 +1,44 @@
>> +==============================
>> +Landlock: kernel documentation
>> +==============================
>> +
>> +Landlock's goal is to create scoped access-control (i.e. sandboxing).  To
>> +harden a whole system, this feature should be available to any process,
>> +including unprivileged ones.  Because such process may be compromised or
>> +backdoored (i.e. untrusted), Landlock's features must be safe to use from the
>> +kernel and other processes point of view.  Landlock's interface must therefore
>> +expose a minimal attack surface.
>> +
>> +Landlock is designed to be usable by unprivileged processes while following the
>> +system security policy enforced by other access control mechanisms (e.g. DAC,
>> +LSM).  Indeed, a Landlock rule shall not interfere with other access-controls
>> +enforced on the system, only add more restrictions.
>> +
>> +Any user can enforce Landlock rulesets on their processes.  They are merged and
>> +evaluated according to the inherited ones in a way that ensure that only more
> 
>                                                            ensures
> 
>> +constraints can be added.
>> +
>> +
>> +Guiding principles for safe access controls
>> +===========================================
>> +
>> +* A Landlock rule shall be focused on access control on kernel objects instead
>> +  of syscall filtering (i.e. syscall arguments), which is the purpose of
>> +  seccomp-bpf.
>> +* To avoid multiple kind of side-channel attacks (e.g. leak of security
> 
>                        kinds
> 
>> +  policies, CPU-based attacks), Landlock rules shall not be able to
>> +  programmatically communicate with user space.
>> +* Kernel access check shall not slow down access request from unsandboxed
>> +  processes.
>> +* Computation related to Landlock operations (e.g. enforce a ruleset) shall
>> +  only impact the processes requesting them.
>> +
>> +
>> +Landlock rulesets and domains
>> +=============================
>> +
>> +A domain is a read-only ruleset tied to a set of subjects (i.e. tasks).  A
>> +domain can transition to a new one which is the intersection of the constraints
>> +from the current and a new ruleset.  The definition of a subject is implicit
>> +for a task sandboxing itself, which makes the reasoning much easier and helps
>> +avoid pitfalls.
>> diff --git a/Documentation/security/landlock/user.rst b/Documentation/security/landlock/user.rst
>> new file mode 100644
>> index 000000000000..cbd7f61fca8c
>> --- /dev/null
>> +++ b/Documentation/security/landlock/user.rst
>> @@ -0,0 +1,233 @@
>> +=================================
>> +Landlock: userspace documentation
>> +=================================
>> +
>> +Landlock rules
>> +==============
>> +
>> +A Landlock rule enables to describe an action on an object.  An object is
>> +currently a file hierarchy, and the related filesystem actions are defined in
>> +`Access rights`_.  A set of rules are aggregated in a ruleset, which can then
> 
>                                      is
> 
>> +restricts the thread enforcing it, and its future children.
> 
>    restrict
> 
>> +
>> +
>> +Defining and enforcing a security policy
>> +----------------------------------------
>> +
>> +Before defining a security policy, an application should first probe for the
>> +features supported by the running kernel, which is important to be compatible
>> +with older kernels.  This can be done thanks to the `landlock` syscall (cf.
>> +:ref:`syscall`).
>> +
>> +.. code-block:: c
>> +
>> +    struct landlock_attr_features attr_features;
>> +
>> +    if (landlock(LANDLOCK_CMD_GET_FEATURES, LANDLOCK_OPT_GET_FEATURES,
>> +            sizeof(attr_features), &attr_features)) {
>> +        perror("Failed to probe the Landlock supported features");
>> +        return 1;
>> +    }
>> +
>> +Then, we need to create the ruleset that will contains our rules.  For this
> 
>                                                  contain
> 
>> +example, the ruleset will contains rules which only allow read actions, but
> 
>                              contain
> 
>> +write actions will be denied.  The ruleset then needs to handle both of these
>> +kind of actions.  To have a backward compatibility, these actions should be
>> +ANDed with the supported ones.
>> +
>> +.. code-block:: c
>> +
>> +    int ruleset_fd;
>> +    struct landlock_attr_ruleset ruleset = {
>> +        .handled_access_fs =
>> +            LANDLOCK_ACCESS_FS_READ |
>> +            LANDLOCK_ACCESS_FS_READDIR |
>> +            LANDLOCK_ACCESS_FS_EXECUTE |
>> +            LANDLOCK_ACCESS_FS_WRITE |
>> +            LANDLOCK_ACCESS_FS_TRUNCATE |
>> +            LANDLOCK_ACCESS_FS_CHMOD |
>> +            LANDLOCK_ACCESS_FS_CHOWN |
>> +            LANDLOCK_ACCESS_FS_CHGRP |
>> +            LANDLOCK_ACCESS_FS_LINK_TO |
>> +            LANDLOCK_ACCESS_FS_RENAME_FROM |
>> +            LANDLOCK_ACCESS_FS_RENAME_TO |
>> +            LANDLOCK_ACCESS_FS_RMDIR |
>> +            LANDLOCK_ACCESS_FS_UNLINK |
>> +            LANDLOCK_ACCESS_FS_MAKE_CHAR |
>> +            LANDLOCK_ACCESS_FS_MAKE_DIR |
>> +            LANDLOCK_ACCESS_FS_MAKE_REG |
>> +            LANDLOCK_ACCESS_FS_MAKE_SOCK |
>> +            LANDLOCK_ACCESS_FS_MAKE_FIFO |
>> +            LANDLOCK_ACCESS_FS_MAKE_BLOCK |
>> +            LANDLOCK_ACCESS_FS_MAKE_SYM,
>> +    };
>> +
>> +    ruleset.handled_access_fs &= attr_features.access_fs;
>> +    ruleset_fd = landlock(LANDLOCK_CMD_CREATE_RULESET,
>> +                    LANDLOCK_OPT_CREATE_RULESET, sizeof(ruleset), &ruleset);
>> +    if (ruleset_fd < 0) {
>> +        perror("Failed to create a ruleset");
>> +        return 1;
>> +    }
>> +
>> +We can now add a new rule to this ruleset thanks to the returned file
>> +descriptor referring to this ruleset.  The rule will only enable to read the
>> +file hierarchy ``/usr``.  Without other rule, write actions would then be
> 
>                              Without other rules,
> or
>                              Without another rule,
> 
>> +denied by the ruleset.  To add ``/usr`` to the ruleset, we open it with the
>> +``O_PATH`` flag and fill the &struct landlock_attr_path_beneath with this file
>> +descriptor.
>> +
>> +.. code-block:: c
>> +
>> +    int err;
>> +    struct landlock_attr_path_beneath path_beneath = {
>> +        .ruleset_fd = ruleset_fd,
>> +        .allowed_access =
>> +            LANDLOCK_ACCESS_FS_READ |
>> +            LANDLOCK_ACCESS_FS_READDIR |
>> +            LANDLOCK_ACCESS_FS_EXECUTE,
>> +    };
>> +
>> +    path_beneath.allowed_access &= attr_features.access_fs;
>> +    path_beneath.parent_fd = open("/usr", O_PATH | O_CLOEXEC);
>> +    if (path_beneath.parent_fd < 0) {
>> +        perror("Failed to open file");
>> +        close(ruleset_fd);
>> +        return 1;
>> +    }
>> +    err = landlock(LANDLOCK_CMD_ADD_RULE, LANDLOCK_OPT_ADD_RULE_PATH_BENEATH,
>> +            sizeof(path_beneath), &path_beneath);
>> +    close(path_beneath.parent_fd);
>> +    if (err) {
>> +        perror("Failed to update ruleset");
>> +        close(ruleset_fd);
>> +        return 1;
>> +    }
>> +
>> +We now have a ruleset with one rule allowing read access to ``/usr`` while
>> +denying all accesses featured in ``attr_features.access_fs`` to everything else
>> +on the filesystem.  The next step is to restrict the current thread from
>> +gaining more privileges (e.g. thanks to a SUID binary).
>> +
>> +.. code-block:: c
>> +
>> +    if (prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0)) {
>> +        perror("Failed to restrict privileges");
>> +        close(ruleset_fd);
>> +        return 1;
>> +    }
>> +
>> +The current thread is now ready to sandbox itself with the ruleset.
>> +
>> +.. code-block:: c
>> +
>> +    struct landlock_attr_enforce attr_enforce = {
>> +        .ruleset_fd = ruleset_fd,
>> +    };
>> +
>> +    if (landlock(LANDLOCK_CMD_ENFORCE_RULESET, LANDLOCK_OPT_ENFORCE_RULESET,
>> +            sizeof(attr_enforce), &attr_enforce)) {
>> +        perror("Failed to enforce ruleset");
>> +        close(ruleset_fd);
>> +        return 1;
>> +    }
>> +    close(ruleset_fd);
>> +
>> +If this last system call succeeds, the current thread is now restricted and
> 
>    If this last landlock system call succeeds,
> 
> [because close() is the last system call]
> 
>> +this policy will be enforced on all its subsequently created children as well.
>> +Once a thread is landlocked, there is no way to remove its security policy,
> 
>                                                    preferably:         policy;
> 
>> +only adding more restrictions is allowed.  These threads are now in a new
>> +Landlock domain, merge of their parent one (if any) with the new ruleset.
>> +
>> +A full working code can be found in `samples/landlock/sandboxer.c`_.
> 
>    Full working code
> 
>> +
>> +
>> +Inheritance
>> +-----------
>> +
>> +Every new thread resulting from a :manpage:`clone(2)` inherits Landlock program
>> +restrictions from its parent.  This is similar to the seccomp inheritance (cf.
>> +:doc:`/userspace-api/seccomp_filter`) or any other LSM dealing with task's
>> +:manpage:`credentials(7)`.  For instance, one process' thread may apply
> 
>                                                  process's
> 
>> +Landlock rules to itself, but they will not be automatically applied to other
>> +sibling threads (unlike POSIX thread credential changes, cf.
>> +:manpage:`nptl(7)`).
> 
> [snip]
> 
> thanks for the documentation.
> 

Done. Thanks for this attentive review!
