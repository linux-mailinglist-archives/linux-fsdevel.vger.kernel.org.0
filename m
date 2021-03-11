Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40EE0337027
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Mar 2021 11:38:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232344AbhCKKiZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Mar 2021 05:38:25 -0500
Received: from smtp-42ae.mail.infomaniak.ch ([84.16.66.174]:44113 "EHLO
        smtp-42ae.mail.infomaniak.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232330AbhCKKiD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Mar 2021 05:38:03 -0500
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Dx54p0jM0zMq4M4;
        Thu, 11 Mar 2021 11:38:02 +0100 (CET)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4Dx54j5vRPzlh8T5;
        Thu, 11 Mar 2021 11:37:57 +0100 (CET)
Subject: Re: [PATCH v2 1/1] fs: Allow no_new_privs tasks to call chroot(2)
To:     Jann Horn <jannh@google.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        James Morris <jmorris@namei.org>,
        Serge Hallyn <serge@hallyn.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christoph Hellwig <hch@lst.de>,
        David Howells <dhowells@redhat.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        John Johansen <john.johansen@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@linux.microsoft.com>
References: <20210310181857.401675-1-mic@digikod.net>
 <20210310181857.401675-2-mic@digikod.net> <m17dmeq0co.fsf@fess.ebiederm.org>
 <CAG48ez2gVdyFT3r_wVuqePWGQAi6YuYYXZcRJ7ENNdnpfpvkuw@mail.gmail.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Message-ID: <661858f8-92ea-9638-01c7-931e0bfa83c1@digikod.net>
Date:   Thu, 11 Mar 2021 11:37:57 +0100
User-Agent: 
MIME-Version: 1.0
In-Reply-To: <CAG48ez2gVdyFT3r_wVuqePWGQAi6YuYYXZcRJ7ENNdnpfpvkuw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 10/03/2021 20:33, Jann Horn wrote:
> On Wed, Mar 10, 2021 at 8:23 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>>
>> Mickaël Salaün <mic@digikod.net> writes:
>>
>>> From: Mickaël Salaün <mic@linux.microsoft.com>
>>>
>>> Being able to easily change root directories enable to ease some
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
>>> out of a chroot (e.g. using /proc/<pid>/root), an unprivileged chroot is
>>> only allowed if the new root directory is the same or beneath the
>>> current one.  This still allows a process to use a subset of its
>>> legitimate filesystem to chroot into and then further reduce its view of
>>> the filesystem.
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
>>> This patch is a follow-up of a previous one sent by Andy Lutomirski, but
>>> with less limitations:
>>> https://lore.kernel.org/lkml/0e2f0f54e19bff53a3739ecfddb4ffa9a6dbde4d.1327858005.git.luto@amacapital.net/
> [...]
>> Neither is_path_beneath nor path_is_under really help prevent escapes,
>> as except for open files and files accessible from proc chroot already
>> disallows going up.  The reason is the path is resolved with the current
>> root before switching to it.
> 
> Yeah, this probably should use the same check as the CLONE_NEWUSER
> logic, current_chrooted() from CLONE_NEWUSER; that check is already
> used for guarding against the following syscall sequence, which has
> similar security properties:
> unshare(CLONE_NEWUSER); // gives the current process namespaced CAP_SYS_ADMIN
> chroot("<...>"); // succeeds because of namespaced CAP_SYS_ADMIN
> 
> The current_chrooted() check in create_user_ns() is for the same
> purpose as the check you're introducing here, so they should use the
> same logic.
> 

I don't know how I missed this, but current_chrooted() is definitely the
right approach.
