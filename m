Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DCF233CF88
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Mar 2021 09:17:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234390AbhCPIRS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Mar 2021 04:17:18 -0400
Received: from smtp-190a.mail.infomaniak.ch ([185.125.25.10]:36907 "EHLO
        smtp-190a.mail.infomaniak.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234380AbhCPIRO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Mar 2021 04:17:14 -0400
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4F05jz237PzMq183;
        Tue, 16 Mar 2021 09:17:11 +0100 (CET)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4F05js6zP4zlpq06;
        Tue, 16 Mar 2021 09:17:05 +0100 (CET)
Subject: Re: [PATCH v3 1/1] fs: Allow no_new_privs tasks to call chroot(2)
To:     Kees Cook <keescook@chromium.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        James Morris <jmorris@namei.org>,
        Serge Hallyn <serge@hallyn.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christoph Hellwig <hch@lst.de>,
        David Howells <dhowells@redhat.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        John Johansen <john.johansen@canonical.com>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        kernel-hardening@lists.openwall.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@linux.microsoft.com>
References: <20210311105242.874506-1-mic@digikod.net>
 <20210311105242.874506-2-mic@digikod.net> <202103151405.88334370F@keescook>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Message-ID: <041935de-83fb-5651-73d9-2ea88d4d84cc@digikod.net>
Date:   Tue, 16 Mar 2021 09:17:08 +0100
User-Agent: 
MIME-Version: 1.0
In-Reply-To: <202103151405.88334370F@keescook>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 15/03/2021 22:17, Kees Cook wrote:
> On Thu, Mar 11, 2021 at 11:52:42AM +0100, Mickaël Salaün wrote:
>> [...]
>> This change may not impact systems relying on other permission models
>> than POSIX capabilities (e.g. Tomoyo).  Being able to use chroot(2) on
>> such systems may require to update their security policies.
>>
>> Only the chroot system call is relaxed with this no_new_privs check; the
>> init_chroot() helper doesn't require such change.
>>
>> Allowing unprivileged users to use chroot(2) is one of the initial
>> objectives of no_new_privs:
>> https://www.kernel.org/doc/html/latest/userspace-api/no_new_privs.html
>> This patch is a follow-up of a previous one sent by Andy Lutomirski:
>> https://lore.kernel.org/lkml/0e2f0f54e19bff53a3739ecfddb4ffa9a6dbde4d.1327858005.git.luto@amacapital.net/
> 
> I liked it back when Andy first suggested it, and I still like it now.
> :) I'm curious, do you have a specific user in mind for this feature?

Except for development and test purposes, being able to use root
(without CAP_SYS_CHROOT) would now enable to easily remove ambient
filesystem access. Indeed, thanks to openat2 with RESOLVE_BENEATH or
RESOLVE_IN_ROOT, it would be simple for most processes to chroot/chdir
into an empty directory after opening (or being given) file descriptors
opened with RESOLVE_BENEATH (e.g. configuration directory, cache
directory, data directory, etc.). We can get something really close to a
security capability system (different than POSIX capabilities), which
wasn't possible when Andy posted the previous patches, and can help
improve the state of userspace security.

It is already possible to limit ptrace-like attacks, even when multiple
processes are running with the same UID, with the help of SELinux, or
even simply with Yama. This already enables sysadmins or distros to
harden their system, and this kind of restrictions (with additional
access-control bits) will be available to userspace developers thanks to
Landlock.

> 
>> [...]
>> @@ -546,8 +547,18 @@ SYSCALL_DEFINE1(chroot, const char __user *, filename)
>>  	if (error)
>>  		goto dput_and_out;
>>  
>> +	/*
>> +	 * Changing the root directory for the calling task (and its future
>> +	 * children) requires that this task has CAP_SYS_CHROOT in its
>> +	 * namespace, or be running with no_new_privs and not sharing its
>> +	 * fs_struct and not escaping its current root (cf. create_user_ns()).
>> +	 * As for seccomp, checking no_new_privs avoids scenarios where
>> +	 * unprivileged tasks can affect the behavior of privileged children.
>> +	 */
>>  	error = -EPERM;
>> -	if (!ns_capable(current_user_ns(), CAP_SYS_CHROOT))
>> +	if (!ns_capable(current_user_ns(), CAP_SYS_CHROOT) &&
>> +			!(task_no_new_privs(current) && current->fs->users == 1
>> +				&& !current_chrooted()))
>>  		goto dput_and_out;
>>  	error = security_path_chroot(&path);
>>  	if (error)
> 
> I think the logic here needs to be rearranged to avoid setting
> PF_SUPERPRIV, and I find the many negations hard to read. Perhaps:
> 
> static inline int current_chroot_allowed(void)
> {
> 	/* comment here */
> 	if (task_no_new_privs(current) && current->fs->users == 1 &&
> 	    !current_chrooted())
> 		return 0;
> 
> 	if (ns_capable(current_user_ns(), CAP_SYS_CHROOT))
> 		return 0;
> 
> 	return -EPERM;
> }
> 
> ...
> 
> 	error = current_chroot_allowed();
> 	if (error)
> 		goto dput_and_out;
> 
> 
> I can't think of a way to race current->fs->users ...
> 

OK, I would be a bit bigger patch but easier to read.
