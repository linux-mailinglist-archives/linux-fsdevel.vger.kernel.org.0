Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95AF6346914
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Mar 2021 20:30:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbhCWTaF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Mar 2021 15:30:05 -0400
Received: from smtp-bc0f.mail.infomaniak.ch ([45.157.188.15]:39161 "EHLO
        smtp-bc0f.mail.infomaniak.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230138AbhCWT3e (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Mar 2021 15:29:34 -0400
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4F4hJX0tWDzMqFPM;
        Tue, 23 Mar 2021 20:29:32 +0100 (CET)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4F4hJT4XNSzlh8TL;
        Tue, 23 Mar 2021 20:29:29 +0100 (CET)
Subject: Re: [PATCH v30 07/12] landlock: Support filesystem access-control
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
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
 <20210316204252.427806-8-mic@digikod.net> <202103191148.6E819426D@keescook>
 <f705f7e8-3ee3-bae9-c283-174fab41629a@digikod.net>
Message-ID: <79d96c0a-9254-63aa-6f0b-2c0fce370c29@digikod.net>
Date:   Tue, 23 Mar 2021 20:30:03 +0100
User-Agent: 
MIME-Version: 1.0
In-Reply-To: <f705f7e8-3ee3-bae9-c283-174fab41629a@digikod.net>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 19/03/2021 20:19, Mickaël Salaün wrote:
> 
> On 19/03/2021 19:57, Kees Cook wrote:
>> On Tue, Mar 16, 2021 at 09:42:47PM +0100, Mickaël Salaün wrote:
>>> From: Mickaël Salaün <mic@linux.microsoft.com>
>>>
>>> Using Landlock objects and ruleset, it is possible to tag inodes
>>> according to a process's domain.  To enable an unprivileged process to
>>> express a file hierarchy, it first needs to open a directory (or a file)
>>> and pass this file descriptor to the kernel through
>>> landlock_add_rule(2).  When checking if a file access request is
>>> allowed, we walk from the requested dentry to the real root, following
>>> the different mount layers.  The access to each "tagged" inodes are
>>> collected according to their rule layer level, and ANDed to create
>>> access to the requested file hierarchy.  This makes possible to identify
>>> a lot of files without tagging every inodes nor modifying the
>>> filesystem, while still following the view and understanding the user
>>> has from the filesystem.
>>>
>>> Add a new ARCH_EPHEMERAL_INODES for UML because it currently does not
>>> keep the same struct inodes for the same inodes whereas these inodes are
>>> in use.
>>>
>>> This commit adds a minimal set of supported filesystem access-control
>>> which doesn't enable to restrict all file-related actions.  This is the
>>> result of multiple discussions to minimize the code of Landlock to ease
>>> review.  Thanks to the Landlock design, extending this access-control
>>> without breaking user space will not be a problem.  Moreover, seccomp
>>> filters can be used to restrict the use of syscall families which may
>>> not be currently handled by Landlock.
>>>
>>> Cc: Al Viro <viro@zeniv.linux.org.uk>
>>> Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
>>> Cc: James Morris <jmorris@namei.org>
>>> Cc: Jann Horn <jannh@google.com>
>>> Cc: Jeff Dike <jdike@addtoit.com>
>>> Cc: Kees Cook <keescook@chromium.org>
>>> Cc: Richard Weinberger <richard@nod.at>
>>> Cc: Serge E. Hallyn <serge@hallyn.com>
>>> Signed-off-by: Mickaël Salaün <mic@linux.microsoft.com>
>>> Link: https://lore.kernel.org/r/20210316204252.427806-8-mic@digikod.net
>>> [...]
>>> +	spin_lock(&sb->s_inode_list_lock);
>>> +	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
>>> +		struct landlock_object *object;
>>> +
>>> +		/* Only handles referenced inodes. */
>>> +		if (!atomic_read(&inode->i_count))
>>> +			continue;
>>> +
>>> +		/*
>>> +		 * Checks I_FREEING and I_WILL_FREE  to protect against a race
>>> +		 * condition when release_inode() just called iput(), which
>>> +		 * could lead to a NULL dereference of inode->security or a
>>> +		 * second call to iput() for the same Landlock object.  Also
>>> +		 * checks I_NEW because such inode cannot be tied to an object.
>>> +		 */
>>> +		spin_lock(&inode->i_lock);
>>> +		if (inode->i_state & (I_FREEING | I_WILL_FREE | I_NEW)) {
>>> +			spin_unlock(&inode->i_lock);
>>> +			continue;
>>> +		}
>>
>> This (and elsewhere here) seems like a lot of inode internals getting
>> exposed. Can any of this be repurposed into helpers? I see this test
>> scattered around the kernel a fair bit:
>>
>> $ git grep I_FREEING | grep I_WILL_FREE | grep I_NEW | wc -l
>> 9
> 
> Dealing with the filesystem is complex. Some helpers could probably be
> added, but with a series dedicated to the filesystem. I can work on that
> once this series is merged.
> 
>>
>>> +static inline u32 get_mode_access(const umode_t mode)
>>> +{
>>> +	switch (mode & S_IFMT) {
>>> +	case S_IFLNK:
>>> +		return LANDLOCK_ACCESS_FS_MAKE_SYM;
>>> +	case 0:
>>> +		/* A zero mode translates to S_IFREG. */
>>> +	case S_IFREG:
>>> +		return LANDLOCK_ACCESS_FS_MAKE_REG;
>>> +	case S_IFDIR:
>>> +		return LANDLOCK_ACCESS_FS_MAKE_DIR;
>>> +	case S_IFCHR:
>>> +		return LANDLOCK_ACCESS_FS_MAKE_CHAR;
>>> +	case S_IFBLK:
>>> +		return LANDLOCK_ACCESS_FS_MAKE_BLOCK;
>>> +	case S_IFIFO:
>>> +		return LANDLOCK_ACCESS_FS_MAKE_FIFO;
>>> +	case S_IFSOCK:
>>> +		return LANDLOCK_ACCESS_FS_MAKE_SOCK;
>>> +	default:
>>> +		WARN_ON_ONCE(1);
>>> +		return 0;
>>> +	}
>>
>> I'm assuming this won't be reachable from userspace.
> 
> It should not, only a bogus kernel code could.
> 
>>
>>> [...]
>>> index a5d6ef334991..f8e8e980454c 100644
>>> --- a/security/landlock/setup.c
>>> +++ b/security/landlock/setup.c
>>> @@ -11,17 +11,24 @@
>>>  
>>>  #include "common.h"
>>>  #include "cred.h"
>>> +#include "fs.h"
>>>  #include "ptrace.h"
>>>  #include "setup.h"
>>>  
>>> +bool landlock_initialized __lsm_ro_after_init = false;
>>> +
>>>  struct lsm_blob_sizes landlock_blob_sizes __lsm_ro_after_init = {
>>>  	.lbs_cred = sizeof(struct landlock_cred_security),
>>> +	.lbs_inode = sizeof(struct landlock_inode_security),
>>> +	.lbs_superblock = sizeof(struct landlock_superblock_security),
>>>  };
>>>  
>>>  static int __init landlock_init(void)
>>>  {
>>>  	landlock_add_cred_hooks();
>>>  	landlock_add_ptrace_hooks();
>>> +	landlock_add_fs_hooks();
>>> +	landlock_initialized = true;
>>
>> I think this landlock_initialized is logically separate from the optional
>> DEFINE_LSM "enabled" variable, but I thought I'd double check. :)
> 
> An LSM can be marked as enabled (at boot) but not yet initialized.
> 
>>
>> It seems like it's used here to avoid releasing superblocks before
>> landlock_init() is called? What is the scenario where that happens?
> 
> It is a condition for LSM hooks, syscalls and superblock management.
> 
>>
>>>  	pr_info("Up and running.\n");
>>>  	return 0;
>>>  }
>>> diff --git a/security/landlock/setup.h b/security/landlock/setup.h
>>> index 9fdbf33fcc33..1daffab1ab4b 100644
>>> --- a/security/landlock/setup.h
>>> +++ b/security/landlock/setup.h
>>> @@ -11,6 +11,8 @@
>>>  
>>>  #include <linux/lsm_hooks.h>
>>>  
>>> +extern bool landlock_initialized;
>>> +
>>>  extern struct lsm_blob_sizes landlock_blob_sizes;
>>>  
>>>  #endif /* _SECURITY_LANDLOCK_SETUP_H */
>>> -- 
>>> 2.30.2
>>>
>>
>> The locking and inode semantics are pretty complex, but since, again,
>> it's got significant test and syzkaller coverage, it looks good to me.
>>
>> With the inode helper cleanup:

I think the inode helper would have to be in a separate patch focused on
fs/ (like all matches of your greps, except Landlock). Are you OK if I
send a patch for that once Landlock is merged?


>>
>> Reviewed-by: Kees Cook <keescook@chromium.org>
>>
