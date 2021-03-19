Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF215342835
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Mar 2021 22:54:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbhCSVxc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Mar 2021 17:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbhCSVxY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Mar 2021 17:53:24 -0400
Received: from smtp-1909.mail.infomaniak.ch (smtp-1909.mail.infomaniak.ch [IPv6:2001:1600:3:17::1909])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2966C06175F
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Mar 2021 14:53:23 -0700 (PDT)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4F2HhL0SLdzMqNhY;
        Fri, 19 Mar 2021 22:53:22 +0100 (CET)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4F2HhB6LQyzlh8T8;
        Fri, 19 Mar 2021 22:53:14 +0100 (CET)
Subject: Re: [PATCH v30 08/12] landlock: Add syscall implementations
To:     Kees Cook <keescook@chromium.org>
Cc:     James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Casey Schaufler <casey@schaufler-ca.com>,
        David Howells <dhowells@redhat.com>,
        Jeff Dike <jdike@addtoit.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Shuah Khan <shuah@kernel.org>,
        Vincent Dagonneau <vincent.dagonneau@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-security-module@vger.kernel.org, x86@kernel.org,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@linux.microsoft.com>
References: <20210316204252.427806-1-mic@digikod.net>
 <20210316204252.427806-9-mic@digikod.net> <202103191157.CF13C34@keescook>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Message-ID: <380d65b2-f515-f3f5-5d57-7f99c528e5c7@digikod.net>
Date:   Fri, 19 Mar 2021 22:53:31 +0100
User-Agent: 
MIME-Version: 1.0
In-Reply-To: <202103191157.CF13C34@keescook>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 19/03/2021 20:06, Kees Cook wrote:
> On Tue, Mar 16, 2021 at 09:42:48PM +0100, Mickaël Salaün wrote:
>> From: Mickaël Salaün <mic@linux.microsoft.com>
>>
>> These 3 system calls are designed to be used by unprivileged processes
>> to sandbox themselves:
>> * landlock_create_ruleset(2): Creates a ruleset and returns its file
>>   descriptor.
>> * landlock_add_rule(2): Adds a rule (e.g. file hierarchy access) to a
>>   ruleset, identified by the dedicated file descriptor.
>> * landlock_restrict_self(2): Enforces a ruleset on the calling thread
>>   and its future children (similar to seccomp).  This syscall has the
>>   same usage restrictions as seccomp(2): the caller must have the
>>   no_new_privs attribute set or have CAP_SYS_ADMIN in the current user
>>   namespace.
>>
>> All these syscalls have a "flags" argument (not currently used) to
>> enable extensibility.
> 
> For the new-style extensible syscalls, you want only a "size" argument;
> "flags" should be within the argument structure.

Not necessarily, we should avoid complexity as much as possible. A flag
argument is simple, and extensible arguments should be avoided as much
as possible. Here it is only used for an extensible list of properties
that can't be expressed otherwise.

> 
> (And to this end, why 3 syscalls instead of 1, if you're going to use
> extensibility anyway?)

This was discussed with people such as Arnd and Jann. Multiplexer
syscalls should be avoided. Here are some background:
https://lore.kernel.org/lkml/CAG48ez2V-eSH2+HL9zrYYD4QMpP4a5y8=mTQtk20PB0wUz_4Tw@mail.gmail.com/

> 
>> +/**
>> + * copy_min_struct_from_user - Safe future-proof argument copying
>> + *
>> + * Extend copy_struct_from_user() to check for consistent user buffer.
>> + *
>> + * @dst: Kernel space pointer or NULL.
>> + * @ksize: Actual size of the data pointed to by @dst.
>> + * @ksize_min: Minimal required size to be copied.
>> + * @src: User space pointer or NULL.
>> + * @usize: (Alleged) size of the data pointed to by @src.
>> + */
>> +static __always_inline int copy_min_struct_from_user(void *const dst,
>> +		const size_t ksize, const size_t ksize_min,
>> +		const void __user *const src, const size_t usize)
>> +{
>> +	/* Checks buffer inconsistencies. */
>> +	BUILD_BUG_ON(!dst);
>> +	if (!src)
>> +		return -EFAULT;
>> +
>> +	/* Checks size ranges. */
>> +	BUILD_BUG_ON(ksize <= 0);
>> +	BUILD_BUG_ON(ksize < ksize_min);
>> +	if (usize < ksize_min)
>> +		return -EINVAL;
>> +	if (usize > PAGE_SIZE)
>> +		return -E2BIG;
>> +
>> +	/* Copies user buffer and fills with zeros. */
>> +	return copy_struct_from_user(dst, ksize, src, usize);
>> +}
> 
> I still wish this was built into copy_struct_from_user(). :) But yes,
> this appears to be the way to protect one's self when using
> copy_struct_from_user().
> 
>> +/**
>> + * sys_landlock_create_ruleset - Create a new ruleset
>> + *
>> + * @attr: Pointer to a &struct landlock_ruleset_attr identifying the scope of
>> + *        the new ruleset.
>> + * @size: Size of the pointed &struct landlock_ruleset_attr (needed for
>> + *        backward and forward compatibility).
>> + * @flags: Must be 0.
>> + *
>> + * This system call enables to create a new Landlock ruleset, and returns the
>> + * related file descriptor on success.
>> + *
>> + * Possible returned errors are:
>> + *
>> + * - EOPNOTSUPP: Landlock is supported by the kernel but disabled at boot time;
>> + * - EINVAL: @flags is not 0, or unknown access, or too small @size;
>> + * - E2BIG or EFAULT: @attr or @size inconsistencies;
>> + * - ENOMSG: empty &landlock_ruleset_attr.handled_access_fs.
>> + */
>> +SYSCALL_DEFINE3(landlock_create_ruleset,
>> +		const struct landlock_ruleset_attr __user *const, attr,
>> +		const size_t, size, const __u32, flags)
>> +{
>> +	struct landlock_ruleset_attr ruleset_attr;
>> +	struct landlock_ruleset *ruleset;
>> +	int err, ruleset_fd;
>> +
>> +	/* Build-time checks. */
>> +	build_check_abi();
>> +
>> +	if (!landlock_initialized)
>> +		return -EOPNOTSUPP;
>> +
>> +	/* No flag for now. */
>> +	if (flags)
>> +		return -EINVAL;
>> +
>> +	/* Copies raw user space buffer. */
>> +	err = copy_min_struct_from_user(&ruleset_attr, sizeof(ruleset_attr),
>> +			offsetofend(typeof(ruleset_attr), handled_access_fs),
> 
> The use of offsetofend() here appears to be kind of the "V1", "V2", ...
> sizes used in other extensible syscall implementations?

ruleset_attr is an extensible argument.

> 
>> +			attr, size);
>> +	if (err)
>> +		return err;
>> +
>> +	/* Checks content (and 32-bits cast). */
>> +	if ((ruleset_attr.handled_access_fs | LANDLOCK_MASK_ACCESS_FS) !=
>> +			LANDLOCK_MASK_ACCESS_FS)
>> +		return -EINVAL;
>> +
>> +	/* Checks arguments and transforms to kernel struct. */
>> +	ruleset = landlock_create_ruleset(ruleset_attr.handled_access_fs);
>> +	if (IS_ERR(ruleset))
>> +		return PTR_ERR(ruleset);
>> +
>> +	/* Creates anonymous FD referring to the ruleset. */
>> +	ruleset_fd = anon_inode_getfd("landlock-ruleset", &ruleset_fops,
>> +			ruleset, O_RDWR | O_CLOEXEC);
>> +	if (ruleset_fd < 0)
>> +		landlock_put_ruleset(ruleset);
>> +	return ruleset_fd;
>> +}
>> +
>> +/*
>> + * Returns an owned ruleset from a FD. It is thus needed to call
>> + * landlock_put_ruleset() on the return value.
>> + */
>> +static struct landlock_ruleset *get_ruleset_from_fd(const int fd,
>> +		const fmode_t mode)
>> +{
>> +	struct fd ruleset_f;
>> +	struct landlock_ruleset *ruleset;
>> +
>> +	ruleset_f = fdget(fd);
>> +	if (!ruleset_f.file)
>> +		return ERR_PTR(-EBADF);
>> +
>> +	/* Checks FD type and access right. */
>> +	if (ruleset_f.file->f_op != &ruleset_fops) {
>> +		ruleset = ERR_PTR(-EBADFD);
>> +		goto out_fdput;
>> +	}
>> +	if (!(ruleset_f.file->f_mode & mode)) {
>> +		ruleset = ERR_PTR(-EPERM);
>> +		goto out_fdput;
>> +	}
>> +	ruleset = ruleset_f.file->private_data;
>> +	if (WARN_ON_ONCE(ruleset->num_layers != 1)) {
>> +		ruleset = ERR_PTR(-EINVAL);
>> +		goto out_fdput;
>> +	}
>> +	landlock_get_ruleset(ruleset);
>> +
>> +out_fdput:
>> +	fdput(ruleset_f);
>> +	return ruleset;
>> +}
>> +
>> +/* Path handling */
>> +
>> +/*
>> + * @path: Must call put_path(@path) after the call if it succeeded.
>> + */
>> +static int get_path_from_fd(const s32 fd, struct path *const path)
>> +{
>> +	struct fd f;
>> +	int err = 0;
>> +
>> +	BUILD_BUG_ON(!__same_type(fd,
>> +		((struct landlock_path_beneath_attr *)NULL)->parent_fd));
>> +
>> +	/* Handles O_PATH. */
>> +	f = fdget_raw(fd);
>> +	if (!f.file)
>> +		return -EBADF;
>> +	/*
>> +	 * Only allows O_PATH file descriptor: enables to restrict ambient
>> +	 * filesystem access without requiring to open and risk leaking or
>> +	 * misusing a file descriptor.  Forbids ruleset FDs, internal
>> +	 * filesystems (e.g. nsfs), including pseudo filesystems that will
>> +	 * never be mountable (e.g. sockfs, pipefs).
>> +	 */
>> +	if (!(f.file->f_mode & FMODE_PATH) ||
>> +			(f.file->f_op == &ruleset_fops) ||
>> +			(f.file->f_path.mnt->mnt_flags & MNT_INTERNAL) ||
>> +			(f.file->f_path.dentry->d_sb->s_flags & SB_NOUSER) ||
>> +			d_is_negative(f.file->f_path.dentry) ||
>> +			IS_PRIVATE(d_backing_inode(f.file->f_path.dentry))) {
>> +		err = -EBADFD;
>> +		goto out_fdput;
>> +	}
>> +	*path = f.file->f_path;
>> +	path_get(path);
>> +
>> +out_fdput:
>> +	fdput(f);
>> +	return err;
>> +}
>> +
>> +/**
>> + * sys_landlock_add_rule - Add a new rule to a ruleset
>> + *
>> + * @ruleset_fd: File descriptor tied to the ruleset that should be extended
>> + *		with the new rule.
>> + * @rule_type: Identify the structure type pointed to by @rule_attr (only
>> + *             LANDLOCK_RULE_PATH_BENEATH for now).
>> + * @rule_attr: Pointer to a rule (only of type &struct
>> + *             landlock_path_beneath_attr for now).
>> + * @flags: Must be 0.
>> + *
>> + * This system call enables to define a new rule and add it to an existing
>> + * ruleset.
>> + *
>> + * Possible returned errors are:
>> + *
>> + * - EOPNOTSUPP: Landlock is supported by the kernel but disabled at boot time;
>> + * - EINVAL: @flags is not 0, or inconsistent access in the rule (i.e.
>> + *   &landlock_path_beneath_attr.allowed_access is not a subset of the rule's
>> + *   accesses);
>> + * - ENOMSG: Empty accesses (e.g. &landlock_path_beneath_attr.allowed_access);
>> + * - EBADF: @ruleset_fd is not a file descriptor for the current thread, or a
>> + *   member of @rule_attr is not a file descriptor as expected;
>> + * - EBADFD: @ruleset_fd is not a ruleset file descriptor, or a member of
>> + *   @rule_attr is not the expected file descriptor type (e.g. file open
>> + *   without O_PATH);
>> + * - EPERM: @ruleset_fd has no write access to the underlying ruleset;
>> + * - EFAULT: @rule_attr inconsistency.
>> + */
>> +SYSCALL_DEFINE4(landlock_add_rule,
>> +		const int, ruleset_fd, const enum landlock_rule_type, rule_type,
>> +		const void __user *const, rule_attr, const __u32, flags)
>> +{
> 
> If this is an extensible syscall, I'd expect a structure holding
> rule_type, rule_attr, and flags.

This does not use an extensible argument. rule_type specifies a type and
rule_attr specifies the content of this type. This is simpler and
sufficient.

> 
>> +	struct landlock_path_beneath_attr path_beneath_attr;
>> +	struct path path;
>> +	struct landlock_ruleset *ruleset;
>> +	int res, err;
>> +
>> +	if (!landlock_initialized)
>> +		return -EOPNOTSUPP;
>> +
>> +	/* No flag for now. */
>> +	if (flags)
>> +		return -EINVAL;
>> +
>> +	if (rule_type != LANDLOCK_RULE_PATH_BENEATH)
>> +		return -EINVAL;
>> +
>> +	/* Copies raw user space buffer, only one type for now. */
>> +	res = copy_from_user(&path_beneath_attr, rule_attr,
>> +			sizeof(path_beneath_attr));
>> +	if (res)
>> +		return -EFAULT;
>> +
>> +	/* Gets and checks the ruleset. */
>> +	ruleset = get_ruleset_from_fd(ruleset_fd, FMODE_CAN_WRITE);
>> +	if (IS_ERR(ruleset))
>> +		return PTR_ERR(ruleset);
>> +
>> +	/*
>> +	 * Informs about useless rule: empty allowed_access (i.e. deny rules)
>> +	 * are ignored in path walks.
>> +	 */
>> +	if (!path_beneath_attr.allowed_access) {
>> +		err = -ENOMSG;
>> +		goto out_put_ruleset;
>> +	}
>> +	/*
>> +	 * Checks that allowed_access matches the @ruleset constraints
>> +	 * (ruleset->fs_access_masks[0] is automatically upgraded to 64-bits).
>> +	 */
>> +	if ((path_beneath_attr.allowed_access | ruleset->fs_access_masks[0]) !=
>> +			ruleset->fs_access_masks[0]) {
>> +		err = -EINVAL;
>> +		goto out_put_ruleset;
>> +	}
>> +
>> +	/* Gets and checks the new rule. */
>> +	err = get_path_from_fd(path_beneath_attr.parent_fd, &path);
>> +	if (err)
>> +		goto out_put_ruleset;
>> +
>> +	/* Imports the new rule. */
>> +	err = landlock_append_fs_rule(ruleset, &path,
>> +			path_beneath_attr.allowed_access);
>> +	path_put(&path);
>> +
>> +out_put_ruleset:
>> +	landlock_put_ruleset(ruleset);
>> +	return err;
>> +}
>> +
>> +/* Enforcement */
>> +
>> +/**
>> + * sys_landlock_restrict_self - Enforce a ruleset on the calling thread
>> + *
>> + * @ruleset_fd: File descriptor tied to the ruleset to merge with the target.
>> + * @flags: Must be 0.
>> + *
>> + * This system call enables to enforce a Landlock ruleset on the current
>> + * thread.  Enforcing a ruleset requires that the task has CAP_SYS_ADMIN in its
>> + * namespace or is running with no_new_privs.  This avoids scenarios where
>> + * unprivileged tasks can affect the behavior of privileged children.
>> + *
>> + * Possible returned errors are:
>> + *
>> + * - EOPNOTSUPP: Landlock is supported by the kernel but disabled at boot time;
>> + * - EINVAL: @flags is not 0.
>> + * - EBADF: @ruleset_fd is not a file descriptor for the current thread;
>> + * - EBADFD: @ruleset_fd is not a ruleset file descriptor;
>> + * - EPERM: @ruleset_fd has no read access to the underlying ruleset, or the
>> + *   current thread is not running with no_new_privs, or it doesn't have
>> + *   CAP_SYS_ADMIN in its namespace.
>> + * - E2BIG: The maximum number of stacked rulesets is reached for the current
>> + *   thread.
>> + */
>> +SYSCALL_DEFINE2(landlock_restrict_self,
>> +		const int, ruleset_fd, const __u32, flags)
>> +{
> 
> Same observation about new style syscalls.

This design is simpler.

> 
>> +	struct landlock_ruleset *new_dom, *ruleset;
>> +	struct cred *new_cred;
>> +	struct landlock_cred_security *new_llcred;
>> +	int err;
>> +
>> +	if (!landlock_initialized)
>> +		return -EOPNOTSUPP;
>> +
>> +	/* No flag for now. */
>> +	if (flags)
>> +		return -EINVAL;
>> +
>> +	/*
>> +	 * Similar checks as for seccomp(2), except that an -EPERM may be
>> +	 * returned.
>> +	 */
>> +	if (!task_no_new_privs(current) &&
>> +			!ns_capable_noaudit(current_user_ns(), CAP_SYS_ADMIN))
>> +		return -EPERM;
>> +
>> +	/* Gets and checks the ruleset. */
>> +	ruleset = get_ruleset_from_fd(ruleset_fd, FMODE_CAN_READ);
>> +	if (IS_ERR(ruleset))
>> +		return PTR_ERR(ruleset);
>> +
>> +	/* Prepares new credentials. */
>> +	new_cred = prepare_creds();
>> +	if (!new_cred) {
>> +		err = -ENOMEM;
>> +		goto out_put_ruleset;
>> +	}
>> +	new_llcred = landlock_cred(new_cred);
>> +
>> +	/*
>> +	 * There is no possible race condition while copying and manipulating
>> +	 * the current credentials because they are dedicated per thread.
>> +	 */
>> +	new_dom = landlock_merge_ruleset(new_llcred->domain, ruleset);
>> +	if (IS_ERR(new_dom)) {
>> +		err = PTR_ERR(new_dom);
>> +		goto out_put_creds;
>> +	}
>> +
>> +	/* Replaces the old (prepared) domain. */
>> +	landlock_put_ruleset(new_llcred->domain);
>> +	new_llcred->domain = new_dom;
>> +
>> +	landlock_put_ruleset(ruleset);
>> +	return commit_creds(new_cred);
>> +
>> +out_put_creds:
>> +	abort_creds(new_cred);
>> +
>> +out_put_ruleset:
>> +	landlock_put_ruleset(ruleset);
>> +	return err;
>> +}
>> -- 
>> 2.30.2
>>
> 
