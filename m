Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19F0034F08E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Mar 2021 20:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232640AbhC3SK3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Mar 2021 14:10:29 -0400
Received: from smtp-42ab.mail.infomaniak.ch ([84.16.66.171]:49221 "EHLO
        smtp-42ab.mail.infomaniak.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232664AbhC3SKN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Mar 2021 14:10:13 -0400
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4F8yCl4LyKzMqFPd;
        Tue, 30 Mar 2021 20:10:11 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4F8yCf2LZ1zlh8T4;
        Tue, 30 Mar 2021 20:10:06 +0200 (CEST)
Subject: Re: [PATCH v5 1/1] fs: Allow no_new_privs tasks to call chroot(2)
To:     Casey Schaufler <casey@schaufler-ca.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        James Morris <jmorris@namei.org>,
        Serge Hallyn <serge@hallyn.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christoph Hellwig <hch@lst.de>,
        David Howells <dhowells@redhat.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Jann Horn <jannh@google.com>,
        John Johansen <john.johansen@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        kernel-hardening@lists.openwall.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@linux.microsoft.com>
References: <20210316203633.424794-1-mic@digikod.net>
 <20210316203633.424794-2-mic@digikod.net>
 <fef10d28-df59-640e-ecf7-576f8348324e@digikod.net>
 <85ebb3a1-bd5e-9f12-6d02-c08d2c0acff5@schaufler-ca.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Message-ID: <b47f73fe-1e79-ff52-b93e-d86b2927bbdc@digikod.net>
Date:   Tue, 30 Mar 2021 20:11:08 +0200
User-Agent: 
MIME-Version: 1.0
In-Reply-To: <85ebb3a1-bd5e-9f12-6d02-c08d2c0acff5@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 30/03/2021 19:19, Casey Schaufler wrote:
> On 3/30/2021 10:01 AM, Mickaël Salaün wrote:
>> Hi,
>>
>> Is there new comments on this patch? Could we move forward?
> 
> I don't see that new comments are necessary when I don't see
> that you've provided compelling counters to some of the old ones.

Which ones? I don't buy your argument about the beauty of CAP_SYS_CHROOT.

> It's possible to use minimal privilege with CAP_SYS_CHROOT.

CAP_SYS_CHROOT can lead to privilege escalation.

> It looks like namespaces provide alternatives for all your
> use cases.

I explained in the commit message why it is not the case. In a nutshell,
namespaces bring complexity which may not be required. When designing a
secure system, we want to avoid giving access to such complexity to
untrusted processes (i.e. more complexity leads to more bugs). An
unprivileged chroot would enable to give just the minimum feature to
drop some accesses. Of course it is not enough on its own, but it can be
combined with existing (and future) security features.

> The constraints required to make this work are quite
> limiting. Where is the real value add?

As explain in the commit message, it is useful when hardening
applications (e.g. network services, browsers, parsers, etc.). We don't
want an untrusted (or compromised) application to have CAP_SYS_CHROOT
nor (complex) namespace access.

> 
>>
>> Regards,
>>  Mickaël
>>
>>
>> On 16/03/2021 21:36, Mickaël Salaün wrote:
>>> From: Mickaël Salaün <mic@linux.microsoft.com>
>>>
>>> Being able to easily change root directories enables to ease some
>>> development workflow and can be used as a tool to strengthen
>>> unprivileged security sandboxes.  chroot(2) is not an access-control
>>> mechanism per se, but it can be used to limit the absolute view of the
>>> filesystem, and then limit ways to access data and kernel interfaces
>>> (e.g. /proc, /sys, /dev, etc.).
>>>
>>> Users may not wish to expose namespace complexity to potentially
>>> malicious processes, or limit their use because of limited resources.
>>> The chroot feature is much more simple (and limited) than the mount
>>> namespace, but can still be useful.  As for containers, users of
>>> chroot(2) should take care of file descriptors or data accessible by
>>> other means (e.g. current working directory, leaked FDs, passed FDs,
>>> devices, mount points, etc.).  There is a lot of literature that discuss
>>> the limitations of chroot, and users of this feature should be aware of
>>> the multiple ways to bypass it.  Using chroot(2) for security purposes
>>> can make sense if it is combined with other features (e.g. dedicated
>>> user, seccomp, LSM access-controls, etc.).
>>>
>>> One could argue that chroot(2) is useless without a properly populated
>>> root hierarchy (i.e. without /dev and /proc).  However, there are
>>> multiple use cases that don't require the chrooting process to create
>>> file hierarchies with special files nor mount points, e.g.:
>>> * A process sandboxing itself, once all its libraries are loaded, may
>>>   not need files other than regular files, or even no file at all.
>>> * Some pre-populated root hierarchies could be used to chroot into,
>>>   provided for instance by development environments or tailored
>>>   distributions.
>>> * Processes executed in a chroot may not require access to these special
>>>   files (e.g. with minimal runtimes, or by emulating some special files
>>>   with a LD_PRELOADed library or seccomp).
>>>
>>> Allowing a task to change its own root directory is not a threat to the
>>> system if we can prevent confused deputy attacks, which could be
>>> performed through execution of SUID-like binaries.  This can be
>>> prevented if the calling task sets PR_SET_NO_NEW_PRIVS on itself with
>>> prctl(2).  To only affect this task, its filesystem information must not
>>> be shared with other tasks, which can be achieved by not passing
>>> CLONE_FS to clone(2).  A similar no_new_privs check is already used by
>>> seccomp to avoid the same kind of security issues.  Furthermore, because
>>> of its security use and to avoid giving a new way for attackers to get
>>> out of a chroot (e.g. using /proc/<pid>/root, or chroot/chdir), an
>>> unprivileged chroot is only allowed if the calling process is not
>>> already chrooted.  This limitation is the same as for creating user
>>> namespaces.
>>>
>>> This change may not impact systems relying on other permission models
>>> than POSIX capabilities (e.g. Tomoyo).  Being able to use chroot(2) on
>>> such systems may require to update their security policies.
>>>
>>> Only the chroot system call is relaxed with this no_new_privs check; the
>>> init_chroot() helper doesn't require such change.
>>>
>>> Allowing unprivileged users to use chroot(2) is one of the initial
>>> objectives of no_new_privs:
>>> https://www.kernel.org/doc/html/latest/userspace-api/no_new_privs.html
>>> This patch is a follow-up of a previous one sent by Andy Lutomirski:
>>> https://lore.kernel.org/lkml/0e2f0f54e19bff53a3739ecfddb4ffa9a6dbde4d.1327858005.git.luto@amacapital.net/
>>>
>>> Cc: Al Viro <viro@zeniv.linux.org.uk>
>>> Cc: Andy Lutomirski <luto@amacapital.net>
>>> Cc: Christian Brauner <christian.brauner@ubuntu.com>
>>> Cc: Christoph Hellwig <hch@lst.de>
>>> Cc: David Howells <dhowells@redhat.com>
>>> Cc: Dominik Brodowski <linux@dominikbrodowski.net>
>>> Cc: Eric W. Biederman <ebiederm@xmission.com>
>>> Cc: James Morris <jmorris@namei.org>
>>> Cc: Jann Horn <jannh@google.com>
>>> Cc: John Johansen <john.johansen@canonical.com>
>>> Cc: Kentaro Takeda <takedakn@nttdata.co.jp>
>>> Cc: Serge Hallyn <serge@hallyn.com>
>>> Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
>>> Signed-off-by: Mickaël Salaün <mic@linux.microsoft.com>
>>> Reviewed-by: Kees Cook <keescook@chromium.org>
>>> Link: https://lore.kernel.org/r/20210316203633.424794-2-mic@digikod.net
>>> ---
>>>
>>> Changes since v4:
>>> * Use READ_ONCE(current->fs->users) (found by Jann Horn).
>>> * Remove ambiguous example in commit description.
>>> * Add Reviewed-by Kees Cook.
>>>
>>> Changes since v3:
>>> * Move the new permission checks to a dedicated helper
>>>   current_chroot_allowed() to make the code easier to read and align
>>>   with user_path_at(), path_permission() and security_path_chroot()
>>>   calls (suggested by Kees Cook).
>>> * Remove now useless included file.
>>> * Extend commit description.
>>> * Rebase on v5.12-rc3 .
>>>
>>> Changes since v2:
>>> * Replace path_is_under() check with current_chrooted() to gain the same
>>>   protection as create_user_ns() (suggested by Jann Horn). See commit
>>>   3151527ee007 ("userns:  Don't allow creation if the user is chrooted")
>>>
>>> Changes since v1:
>>> * Replace custom is_path_beneath() with existing path_is_under().
>>> ---
>>>  fs/open.c | 23 +++++++++++++++++++++--
>>>  1 file changed, 21 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/fs/open.c b/fs/open.c
>>> index e53af13b5835..480010a551b2 100644
>>> --- a/fs/open.c
>>> +++ b/fs/open.c
>>> @@ -532,6 +532,24 @@ SYSCALL_DEFINE1(fchdir, unsigned int, fd)
>>>  	return error;
>>>  }
>>>  
>>> +static inline int current_chroot_allowed(void)
>>> +{
>>> +	/*
>>> +	 * Changing the root directory for the calling task (and its future
>>> +	 * children) requires that this task has CAP_SYS_CHROOT in its
>>> +	 * namespace, or be running with no_new_privs and not sharing its
>>> +	 * fs_struct and not escaping its current root (cf. create_user_ns()).
>>> +	 * As for seccomp, checking no_new_privs avoids scenarios where
>>> +	 * unprivileged tasks can affect the behavior of privileged children.
>>> +	 */
>>> +	if (task_no_new_privs(current) && READ_ONCE(current->fs->users) == 
> 1 &&
>>> +			!current_chrooted())
>>> +		return 0;
>>> +	if (ns_capable(current_user_ns(), CAP_SYS_CHROOT))
>>> +		return 0;
>>> +	return -EPERM;
>>> +}
>>> +
>>>  SYSCALL_DEFINE1(chroot, const char __user *, filename)
>>>  {
>>>  	struct path path;
>>> @@ -546,9 +564,10 @@ SYSCALL_DEFINE1(chroot, const char __user *, filename)
>>>  	if (error)
>>>  		goto dput_and_out;
>>>  
>>> -	error = -EPERM;
>>> -	if (!ns_capable(current_user_ns(), CAP_SYS_CHROOT))
>>> +	error = current_chroot_allowed();
>>> +	if (error)
>>>  		goto dput_and_out;
>>> +
>>>  	error = security_path_chroot(&path);
>>>  	if (error)
>>>  		goto dput_and_out;
>>>
> 
