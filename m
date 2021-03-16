Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F9F433DD7B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Mar 2021 20:28:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240427AbhCPT1i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Mar 2021 15:27:38 -0400
Received: from smtp-1909.mail.infomaniak.ch ([185.125.25.9]:55011 "EHLO
        smtp-1909.mail.infomaniak.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236778AbhCPT0y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Mar 2021 15:26:54 -0400
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4F0NZY4lYKzMqDZ6;
        Tue, 16 Mar 2021 20:26:45 +0100 (CET)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4F0NZX3Hbrzlh8TK;
        Tue, 16 Mar 2021 20:26:44 +0100 (CET)
Subject: Re: [PATCH v4 1/1] fs: Allow no_new_privs tasks to call chroot(2)
To:     Jann Horn <jannh@google.com>
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
        Kees Cook <keescook@chromium.org>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@linux.microsoft.com>
References: <20210316170135.226381-1-mic@digikod.net>
 <20210316170135.226381-2-mic@digikod.net>
 <CAG48ez3=M-5WT73HqmFJr6UHwO0+2FJXxcAgRzp6wcd0P3TN=Q@mail.gmail.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Message-ID: <ec7a3a21-c402-c153-a932-ce4a40edadaa@digikod.net>
Date:   Tue, 16 Mar 2021 20:26:46 +0100
User-Agent: 
MIME-Version: 1.0
In-Reply-To: <CAG48ez3=M-5WT73HqmFJr6UHwO0+2FJXxcAgRzp6wcd0P3TN=Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 16/03/2021 20:04, Jann Horn wrote:
> On Tue, Mar 16, 2021 at 6:02 PM Mickaël Salaün <mic@digikod.net> wrote:
>> One could argue that chroot(2) is useless without a properly populated
>> root hierarchy (i.e. without /dev and /proc).  However, there are
>> multiple use cases that don't require the chrooting process to create
>> file hierarchies with special files nor mount points, e.g.:
>> * A process sandboxing itself, once all its libraries are loaded, may
>>   not need files other than regular files, or even no file at all.
>> * Some pre-populated root hierarchies could be used to chroot into,
>>   provided for instance by development environments or tailored
>>   distributions.
>> * Processes executed in a chroot may not require access to these special
>>   files (e.g. with minimal runtimes, or by emulating some special files
>>   with a LD_PRELOADed library or seccomp).
>>
>> Unprivileged chroot is especially interesting for userspace developers
>> wishing to harden their applications.  For instance, chroot(2) and Yama
>> enable to build a capability-based security (i.e. remove filesystem
>> ambient accesses) by calling chroot/chdir with an empty directory and
>> accessing data through dedicated file descriptors obtained with
>> openat2(2) and RESOLVE_BENEATH/RESOLVE_IN_ROOT/RESOLVE_NO_MAGICLINKS.
> 
> I don't entirely understand. Are you writing this with the assumption
> that a future change will make it possible to set these RESOLVE flags
> process-wide, or something like that?

No, this scenario is for applications willing to sandbox themselves and
only use the FDs to access legitimate data.

> 
> 
> As long as that doesn't exist, I think that to make this safe, you'd
> have to do something like the following - let a child process set up a
> new mount namespace for you, and then chroot() into that namespace's
> root:
> 
> struct shared_data {
>   int root_fd;
> };
> int helper_fn(void *args) {
>   struct shared_data *shared = args;
>   mount("none", "/tmp", "tmpfs", MS_NOSUID|MS_NODEV, "");
>   mkdir("/tmp/old_root", 0700);
>   pivot_root("/tmp", "/tmp/old_root");
>   umount("/tmp/old_root", "");
>   shared->root_fd = open("/", O_PATH);
> }
> void setup_chroot() {
>   struct shared_data shared = {};
>   prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
>   clone(helper_fn, my_stack,
> CLONE_VFORK|CLONE_VM|CLONE_FILES|CLONE_NEWUSER|CLONE_NEWNS|SIGCHLD,
> NULL);
>   fchdir(shared.root_fd);
>   chroot(".");
> }

What about this?
chdir("/proc/self/fdinfo");
chroot(".");
close(all unnecessary FDs);

> 
> [...]
>> diff --git a/fs/open.c b/fs/open.c
> [...]
>> +static inline int current_chroot_allowed(void)
>> +{
>> +       /*
>> +        * Changing the root directory for the calling task (and its future
>> +        * children) requires that this task has CAP_SYS_CHROOT in its
>> +        * namespace, or be running with no_new_privs and not sharing its
>> +        * fs_struct and not escaping its current root (cf. create_user_ns()).
>> +        * As for seccomp, checking no_new_privs avoids scenarios where
>> +        * unprivileged tasks can affect the behavior of privileged children.
>> +        */
>> +       if (task_no_new_privs(current) && current->fs->users == 1 &&
> 
> this read of current->fs->users should be using READ_ONCE()

Right, I'll fix this.

> 
>> +                       !current_chrooted())
>> +               return 0;
>> +       if (ns_capable(current_user_ns(), CAP_SYS_CHROOT))
>> +               return 0;
>> +       return -EPERM;
>> +}
> [...]
> 
> Overall I think this change is a good idea.
> 
