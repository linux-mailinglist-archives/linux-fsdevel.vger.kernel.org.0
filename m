Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC5B029EA85
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Oct 2020 12:30:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727250AbgJ2LaR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Oct 2020 07:30:17 -0400
Received: from smtp-190a.mail.infomaniak.ch ([185.125.25.10]:60301 "EHLO
        smtp-190a.mail.infomaniak.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725805AbgJ2LaR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Oct 2020 07:30:17 -0400
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4CMNXQ2xhPzlkXck;
        Thu, 29 Oct 2020 12:30:14 +0100 (CET)
Received: from ns3096276.ip-94-23-54.eu (unknown [94.23.54.103])
        by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4CMNXN3zl3zlh8TL;
        Thu, 29 Oct 2020 12:30:12 +0100 (CET)
Subject: Re: [PATCH v22 08/12] landlock: Add syscall implementations
To:     Jann Horn <jannh@google.com>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@amacapital.net>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Jeff Dike <jdike@addtoit.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Shuah Khan <shuah@kernel.org>,
        Vincent Dagonneau <vincent.dagonneau@ssi.gouv.fr>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@linux.microsoft.com>
References: <20201027200358.557003-1-mic@digikod.net>
 <20201027200358.557003-9-mic@digikod.net>
 <CAG48ez1San538w=+He309vHg4pBSCvAf7e5xeHdqeOHA6qwitw@mail.gmail.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Message-ID: <de287149-ff42-40ca-5bd1-f48969880a06@digikod.net>
Date:   Thu, 29 Oct 2020 12:30:12 +0100
User-Agent: 
MIME-Version: 1.0
In-Reply-To: <CAG48ez1San538w=+He309vHg4pBSCvAf7e5xeHdqeOHA6qwitw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 29/10/2020 02:06, Jann Horn wrote:
> On Tue, Oct 27, 2020 at 9:04 PM Mickaël Salaün <mic@digikod.net> wrote:
>> These 3 system calls are designed to be used by unprivileged processes
>> to sandbox themselves:
>> * landlock_create_ruleset(2): Creates a ruleset and returns its file
>>   descriptor.
>> * landlock_add_rule(2): Adds a rule (e.g. file hierarchy access) to a
>>   ruleset, identified by the dedicated file descriptor.
>> * landlock_enforce_ruleset_current(2): Enforces a ruleset on the current
>>   thread and its future children (similar to seccomp).  This syscall has
>>   the same usage restrictions as seccomp(2): the caller must have the
>>   no_new_privs attribute set or have CAP_SYS_ADMIN in the current user
>>   namespace.
> [...]
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Cc: James Morris <jmorris@namei.org>
>> Cc: Jann Horn <jannh@google.com>
>> Cc: Kees Cook <keescook@chromium.org>
>> Cc: Serge E. Hallyn <serge@hallyn.com>
>> Signed-off-by: Mickaël Salaün <mic@linux.microsoft.com>
> [...]
>> diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
> [...]
>> +/**
>> + * struct landlock_path_beneath_attr - Path hierarchy definition
>> + *
>> + * Argument of sys_landlock_add_rule().
>> + */
>> +struct landlock_path_beneath_attr {
>> +       /**
>> +        * @allowed_access: Bitmask of allowed actions for this file hierarchy
>> +        * (cf. `Filesystem flags`_).
>> +        */
>> +       __u64 allowed_access;
>> +       /**
>> +        * @parent_fd: File descriptor, open with ``O_PATH``, which identify
> 
> nit: "identifies"

OK

> 
>> +        * the parent directory of a file hierarchy, or just a file.
>> +        */
>> +       __s32 parent_fd;
>> +       /*
>> +        * This struct is packed to avoid trailing reserved members.
>> +        * Cf. security/landlock/syscall.c:build_check_abi()
>> +        */
>> +} __attribute__((packed));
> [...]
>> diff --git a/security/landlock/syscall.c b/security/landlock/syscall.c
> [...]
>> +static int copy_min_struct_from_user(void *const dst, const size_t ksize,
>> +               const size_t ksize_min, const void __user *const src,
>> +               const size_t usize)
>> +{
>> +       /* Checks buffer inconsistencies. */
>> +       BUILD_BUG_ON(!dst);
>> +       if (!src)
>> +               return -EFAULT;
>> +
>> +       /* Checks size ranges. */
>> +       BUILD_BUG_ON(ksize <= 0);
>> +       BUILD_BUG_ON(ksize < ksize_min);
> 
> To make these checks work reliably, you should add __always_inline to
> the function.

Done.

> 
>> +       if (usize < ksize_min)
>> +               return -EINVAL;
>> +       if (usize > PAGE_SIZE)
>> +               return -E2BIG;
>> +
>> +       /* Copies user buffer and fills with zeros. */
>> +       return copy_struct_from_user(dst, ksize, src, usize);
>> +}
> [...]
>> +static int get_path_from_fd(const s32 fd, struct path *const path)
>> +{
>> +       struct fd f;
>> +       int err = 0;
>> +
>> +       BUILD_BUG_ON(!__same_type(fd,
>> +               ((struct landlock_path_beneath_attr *)NULL)->parent_fd));
>> +
>> +       /* Handles O_PATH. */
>> +       f = fdget_raw(fd);
>> +       if (!f.file)
>> +               return -EBADF;
>> +       /*
>> +        * Only allows O_PATH file descriptor: enables to restrict ambient
>> +        * filesystem access without requiring to open and risk leaking or
>> +        * misusing a file descriptor.  Forbid internal filesystems (e.g.
>> +        * nsfs), including pseudo filesystems that will never be mountable
>> +        * (e.g. sockfs, pipefs).
>> +        */
>> +       if (!(f.file->f_mode & FMODE_PATH) ||
>> +                       (f.file->f_path.mnt->mnt_flags & MNT_INTERNAL) ||
>> +                       (f.file->f_path.dentry->d_sb->s_flags & SB_NOUSER) ||
>> +                       d_is_negative(f.file->f_path.dentry) ||
>> +                       IS_PRIVATE(d_backing_inode(f.file->f_path.dentry))) {
>> +               err = -EBADFD;
>> +               goto out_fdput;
>> +       }
>> +       path->mnt = f.file->f_path.mnt;
>> +       path->dentry = f.file->f_path.dentry;
> 
> those two lines can be replaced with "*path = f.file->f_path"

Done.

> 
>> +       path_get(path);
>> +
>> +out_fdput:
>> +       fdput(f);
>> +       return err;
>> +}
> [...]
>> +/**
>> + * sys_landlock_enforce_ruleset_current - Enforce a ruleset on the current task
>> + *
>> + * @ruleset_fd: File descriptor tied to the ruleset to merge with the target.
>> + * @flags: Must be 0.
>> + *
>> + * This system call enables to enforce a Landlock ruleset on the current
>> + * thread.  Enforcing a ruleset requires that the task has CAP_SYS_ADMIN in its
>> + * namespace or be running with no_new_privs.  This avoids scenarios where
> 
> s/be/is/

OK.

> 
>> + * unprivileged tasks can affect the behavior of privileged children.
>> + *
>> + * Possible returned errors are:
>> + *
>> + * - EOPNOTSUPP: Landlock is supported by the kernel but disabled at boot time;
>> + * - EINVAL: @flags is not 0.
>> + * - EBADF: @ruleset_fd is not a file descriptor for the current thread;
>> + * - EBADFD: @ruleset_fd is not a ruleset file descriptor;
>> + * - EPERM: @ruleset_fd has no read access to the underlying ruleset, or the
>> + *   current thread is not running with no_new_privs (or doesn't have
>> + *   CAP_SYS_ADMIN in its namespace).
>> + */
>> +SYSCALL_DEFINE2(landlock_enforce_ruleset_current,
>> +               const int, ruleset_fd, const __u32, flags)
>> +{
>> +       struct landlock_ruleset *new_dom, *ruleset;
>> +       struct cred *new_cred;
>> +       struct landlock_cred_security *new_llcred;
>> +       int err;
>> +
>> +       if (!landlock_initialized)
>> +               return -EOPNOTSUPP;
>> +
>> +       /* No flag for now. */
>> +       if (flags)
>> +               return -EINVAL;
>> +
>> +       /*
>> +        * Similar checks as for seccomp(2), except that an -EPERM may be
>> +        * returned.
>> +        */
>> +       if (!task_no_new_privs(current)) {
>> +               err = security_capable(current_cred(), current_user_ns(),
>> +                               CAP_SYS_ADMIN, CAP_OPT_NOAUDIT);
> 
> I think this should be ns_capable_noaudit(current_user_ns(), CAP_SYS_ADMIN)?

Right. The main difference is that ns_capable*() set PF_SUPERPRIV in
current->flags. I guess seccomp should use ns_capable_noaudit() as well?

> 
>> +               if (err)
>> +                       return err;
>> +       }
>> +
>> +       /* Gets and checks the ruleset. */
>> +       ruleset = get_ruleset_from_fd(ruleset_fd, FMODE_CAN_READ);
>> +       if (IS_ERR(ruleset))
>> +               return PTR_ERR(ruleset);
>> +
>> +       /* Prepares new credentials. */
>> +       new_cred = prepare_creds();
>> +       if (!new_cred) {
>> +               err = -ENOMEM;
>> +               goto out_put_ruleset;
>> +       }
>> +       new_llcred = landlock_cred(new_cred);
>> +
>> +       /*
>> +        * There is no possible race condition while copying and manipulating
>> +        * the current credentials because they are dedicated per thread.
>> +        */
>> +       new_dom = landlock_merge_ruleset(new_llcred->domain, ruleset);
>> +       if (IS_ERR(new_dom)) {
>> +               err = PTR_ERR(new_dom);
>> +               goto out_put_creds;
>> +       }
>> +
>> +       /* Replaces the old (prepared) domain. */
>> +       landlock_put_ruleset(new_llcred->domain);
>> +       new_llcred->domain = new_dom;
>> +
>> +       landlock_put_ruleset(ruleset);
>> +       return commit_creds(new_cred);
>> +
>> +out_put_creds:
>> +       abort_creds(new_cred);
>> +       return err;
> 
> I think this "return err" is wrong - don't we still have to put "ruleset" here?

Oh yes, good catch!

> 
> 
>> +out_put_ruleset:
>> +       landlock_put_ruleset(ruleset);
>> +       return err;
>> +}
>> --
>> 2.28.0
>>
