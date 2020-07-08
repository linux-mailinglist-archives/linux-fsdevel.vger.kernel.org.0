Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55CA1218868
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jul 2020 15:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729147AbgGHNEq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jul 2020 09:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729113AbgGHNEp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jul 2020 09:04:45 -0400
Received: from smtp-42ab.mail.infomaniak.ch (smtp-42ab.mail.infomaniak.ch [IPv6:2001:1600:3:17::42ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C557C08E81A;
        Wed,  8 Jul 2020 06:04:45 -0700 (PDT)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4B1zzZ05YPzlhDCx;
        Wed,  8 Jul 2020 15:04:42 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [94.23.54.103])
        by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4B1zzL5JtJzlh8TK;
        Wed,  8 Jul 2020 15:04:30 +0200 (CEST)
Subject: Re: [PATCH v19 08/12] landlock: Add syscall implementation
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@amacapital.net>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>,
        Jeff Dike <jdike@addtoit.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mickael.salaun@ssi.gouv.fr>,
        Richard Weinberger <richard@nod.at>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Shuah Khan <shuah@kernel.org>,
        Vincent Dagonneau <vincent.dagonneau@ssi.gouv.fr>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
References: <20200707180955.53024-1-mic@digikod.net>
 <20200707180955.53024-9-mic@digikod.net>
 <CAK8P3a0FkoxFtcQJ2jSqyLbDCOp3R8-1JoY8CWAgbSZ9hH9wdQ@mail.gmail.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Message-ID: <7f407b67-d470-25fd-1287-f4f55f18e74a@digikod.net>
Date:   Wed, 8 Jul 2020 15:04:28 +0200
User-Agent: 
MIME-Version: 1.0
In-Reply-To: <CAK8P3a0FkoxFtcQJ2jSqyLbDCOp3R8-1JoY8CWAgbSZ9hH9wdQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Antivirus: Dr.Web (R) for Unix mail servers drweb plugin ver.6.0.2.8
X-Antivirus-Code: 0x100000
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 08/07/2020 10:57, Arnd Bergmann wrote:
> On Tue, Jul 7, 2020 at 8:10 PM Mickaël Salaün <mic@digikod.net> wrote:
>>
>> This system call, inspired from seccomp(2) and bpf(2), is designed to be
>> used by unprivileged processes to sandbox themselves.  It has the same
>> usage restrictions as seccomp(2): the caller must have the no_new_privs
>> attribute set or have CAP_SYS_ADMIN in the current user namespace.
>>
>> Here are the motivations for this new syscall:
>> * A sandboxed process may not have access to file systems, including
>>   /dev, /sys or /proc, but it should still be able to add more
>>   restrictions to itself.
>> * Neither prctl(2) nor seccomp(2) (which was used in a previous version)
>>   fit well with the current definition of a Landlock security policy.
>> * It is quite easy to whitelist this syscall with seccomp-bpf to enable
>>   all processes to use it.  It is also easy to filter specific commands
>>   or options to restrict a process to a subset of Landlock features.
>>
>> There is currently four commands:
>> * LANDLOCK_CMD_GET_FEATURES: Gets the supported features (required for
>>   backward and forward compatibility, and best-effort security).
>> * LANDLOCK_CMD_CREATE_RULESET: Creates a ruleset and returns its file
>>   descriptor.
>> * LANDLOCK_CMD_ADD_RULE: Adds a rule (e.g. file hierarchy access) to a
>>   ruleset, identified by the dedicated file descriptor.
>> * LANDLOCK_CMD_ENFORCE_RULESET: Enforces a ruleset on the current thread
>>   and its future children (similar to seccomp).
> 
> I never paid attention to the patch series so far, so I'm sorry if this
> has all been discussed before, but I think the syscall prototype needs
> to be different, with *much* less extensibility built in.
> 
>> Each command has at least one option, which enables to define the
>> attribute types passed to the syscall.  All attribute types (structures)
>> are checked at build time to ensure that they don't contain holes and
>> that they are aligned the same way for each architecture.  The struct
>> landlock_attr_features contains __u32 options_* fields which is enough
>> to store 32-bits syscall arguments, and __u16 size_attr_* fields which
>> is enough for the maximal struct size (i.e. page size) passed through
>> the landlock syscall.  The other fields can have __u64 type for flags
>> and bitfields, and __s32 type for file descriptors.
>>
>> See the user and kernel documentation for more details (provided by a
>> following commit): Documentation/security/landlock/
> 
> System calls with their own sub-commands have turned out to be a
> bad idea many times in the past and cause more problems than they
> solve. See sys_ipc, sys_socketcall and sys_futex for common examples.
> 
> The first step I would recommend is to split out the individual commands
> into separate syscalls. For each one of those, pick a simple prototype
> that can do what it needs, with one 'flags' argument for extensibility.

OK, I'll replace each command with a specific syscall. I don't think
there will be much more commands/syscalls than these four and it will
make a better API.

> 
>> +/**
>> + * DOC: options_intro
>> + *
>> + * These options may be used as second argument of sys_landlock().  Each
>> + * command have a dedicated set of options, represented as bitmasks.  For two
>> + * different commands, their options may overlap.  Each command have at least
>> + * one option defining the used attribute type.  This also enables to always
>> + * have a usable &struct landlock_attr_features (i.e. filled with bits).
>> + */
>> +
>> +/**
>> + * DOC: options_get_features
>> + *
>> + * Options for ``LANDLOCK_CMD_GET_FEATURES``
>> + * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> + *
>> + * - %LANDLOCK_OPT_GET_FEATURES: the attr type is `struct
>> + *   landlock_attr_features`.
>> + */
>> +#define LANDLOCK_OPT_GET_FEATURES                      (1 << 0)
> 
> For each command, you currently have one attribute that is defined
> to have a name directly corresponding to the command, making it
> entirely redundant. I'd suggest just check the 'flags' argument for
> being zero at syscall entry for future extension if you think there may
> be a need to extend it, or completely leave out attributes and flags.

The goal is to easily "type" the attr pointers (arguments 3 to 6), not
the command, to avoid future attr composability issues (for the same
command). However, with one syscall per command, these kind of options
may not be required.

The other reason to set an option bit for each command is to avoid empty
fields in struct landlock_attr_features, which enables to detect if a
specific command is supported. However, if necessary, a "commands" field
can be use for such usage.

> 
>> +static int syscall_create_ruleset(const void __user *const attr_ptr,
>> +               const size_t attr_size)
>> +{
>> +       struct landlock_attr_ruleset attr_ruleset;
>> +       struct landlock_ruleset *ruleset;
>> +       int err, ruleset_fd;
>> +
>> +       /* Copies raw user space buffer. */
>> +       err = copy_struct_if_any_from_user(&attr_ruleset, sizeof(attr_ruleset),
>> +                       offsetofend(typeof(attr_ruleset), handled_access_fs),
>> +                       attr_ptr, attr_size);
>> +       if (err)
>> +               return err;
>> +
>> +       /* Checks content (and 32-bits cast). */
>> +       if ((attr_ruleset.handled_access_fs | _LANDLOCK_ACCESS_FS_MASK) !=
>> +                       _LANDLOCK_ACCESS_FS_MASK)
>> +               return -EINVAL;
>> +
>> +       /* Checks arguments and transforms to kernel struct. */
>> +       ruleset = landlock_create_ruleset(attr_ruleset.handled_access_fs);
>> +       if (IS_ERR(ruleset))
>> +               return PTR_ERR(ruleset);
>> +
>> +       /* Creates anonymous FD referring to the ruleset. */
>> +       ruleset_fd = anon_inode_getfd("landlock-ruleset", &ruleset_fops,
>> +                       ruleset, O_RDWR | O_CLOEXEC);
>> +       if (ruleset_fd < 0)
>> +               landlock_put_ruleset(ruleset);
>> +       return ruleset_fd;
>> +}
> 
> It looks like all you need here today is a single argument bit, plus
> possibly some room for extensibility. I would suggest removing all
> the extra bits and using a syscall like
> 
> SYSCALL_DEFINE1(landlock_create_ruleset, u32, flags);
> 
> I don't really see how this needs any variable-length arguments,
> it really doesn't do much.

We need the attr_ptr/attr_size pattern because the number of ruleset
properties will increase (e.g. network access mask).

> 
> To be on the safe side, you might split up the flags into either the
> upper/lower 16 bits or two u32 arguments, to allow both compatible
> (ignored by older kernels if flag is set) and incompatible (return error
> when an unknown flag is set) bits.

This may be a good idea in general, but in the case of Landlock, because
this kind of (discretionary) sandboxing should be a best-effort security
feature, we should avoid incompatible behavior. In practice, every
unknown bit returns an error because userland can probe for available
bits thanks to the get_features command. This kind of (in)compatibility
can then be handled by userland.

I suggest this syscall signature:
SYSCALL_DEFINE3(landlock_create_ruleset, __u32, options, const struct
landlock_attr_ruleset __user *, ruleset_ptr, size_t, ruleset_size);

> 
>> +struct landlock_attr_path_beneath {
>> +       /**
>> +        * @ruleset_fd: File descriptor tied to the ruleset which should be
>> +        * extended with this new access.
>> +        */
>> +       __s32 ruleset_fd;
>> +       /**
>> +        * @parent_fd: File descriptor, open with ``O_PATH``, which identify
>> +        * the parent directory of a file hierarchy, or just a file.
>> +        */
>> +       __s32 parent_fd;
>> +       /**
>> +        * @allowed_access: Bitmask of allowed actions for this file hierarchy
>> +        * (cf. `Filesystem flags`_).
>> +        */
>> +       __u64 allowed_access;
>> +};
> 
>> +static int syscall_add_rule_path_beneath(const void __user *const attr_ptr,
>> +               const size_t attr_size)
>> +{
>> +       struct landlock_attr_path_beneath attr_path_beneath;
>> +       struct path path;
>> +       struct landlock_ruleset *ruleset;
>> +       int err;
> 
> Similarly, it looks like this wants to be
> 
> SYSCALL_DEFINE3(landlock_add_rule_path_beneath, int, ruleset, int,
> path, __u32, flags)
> 
> I don't see any need to extend this in a way that wouldn't already
> be served better by adding another system call. You might argue
> that 'flags' and 'allowed_access' could be separate, with the latter
> being an indirect in/out argument here, like
> 
> SYSCALL_DEFINE4(landlock_add_rule_path_beneath, int, ruleset, int, path,
>                            __u64 *, allowed_acces, __u32, flags)

To avoid adding a new syscall for each new rule type (e.g. path_beneath,
path_range, net_ipv4_range, etc.), I think it would be better to keep
the attr_ptr/attr_size pattern and to explicitely set a dedicated option
flag to specify the attr type.

This would look like this:
SYSCALL_DEFINE4(landlock_add_rule, __u32, options, int, ruleset, const
void __user *, rule_ptr, size_t, rule_size);

The rule_ptr could then point to multiple types like struct
landlock_attr_path_beneath (without the current ruleset_fd field).

> 
>> +static int syscall_enforce_ruleset(const void __user *const attr_ptr,
>> +               const size_t attr_size)
> 
> Here it seems like you just need to pass the file descriptor, or maybe
> 
> SYSCALL_DEFINE2(landlock_enforce, int, ruleset, __u32 flags);
> 
> if you need flags for extensibility.

Right, but for consistency I prefer to change the arguments like this:
SYSCALL_DEFINE2(landlock_enforce, __u32 options, int, ruleset);


About the get_features command, because the number of features will
increase, the corresponding syscall should look like this:
SYSCALL_DEFINE3(landlock_get_features, __u32, options, struct
landlock_attr_features __user *, features_ptr, size_t features_size);
