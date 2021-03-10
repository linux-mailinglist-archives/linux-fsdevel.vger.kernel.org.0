Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC4D133465E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Mar 2021 19:14:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232918AbhCJSNt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Mar 2021 13:13:49 -0500
Received: from smtp-42a9.mail.infomaniak.ch ([84.16.66.169]:45663 "EHLO
        smtp-42a9.mail.infomaniak.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229503AbhCJSNl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Mar 2021 13:13:41 -0500
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4DwgDz4NX7zMqMqc;
        Wed, 10 Mar 2021 19:13:39 +0100 (CET)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4DwgDt0Ylzzlh8TK;
        Wed, 10 Mar 2021 19:13:33 +0100 (CET)
Subject: Re: [PATCH v1 1/1] fs: Allow no_new_privs tasks to call chroot(2)
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        James Morris <jmorris@namei.org>,
        Serge Hallyn <serge@hallyn.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christoph Hellwig <hch@lst.de>,
        David Howells <dhowells@redhat.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        John Johansen <john.johansen@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        kernel-hardening@lists.openwall.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@linux.microsoft.com>
References: <20210310161000.382796-1-mic@digikod.net>
 <20210310161000.382796-2-mic@digikod.net> <m1lfavt0bf.fsf@fess.ebiederm.org>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Message-ID: <5edd8272-a2d5-028d-28da-de76a93f2fa4@digikod.net>
Date:   Wed, 10 Mar 2021 19:13:33 +0100
User-Agent: 
MIME-Version: 1.0
In-Reply-To: <m1lfavt0bf.fsf@fess.ebiederm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 10/03/2021 17:56, Eric W. Biederman wrote:
> Mickaël Salaün <mic@digikod.net> writes:
> 
>> From: Mickaël Salaün <mic@linux.microsoft.com>
>>
>> Being able to easily change root directories enable to ease some
>> development workflow and can be used as a tool to strengthen
>> unprivileged security sandboxes.  chroot(2) is not an access-control
>> mechanism per se, but it can be used to limit the absolute view of the
>> filesystem, and then limit ways to access data and kernel interfaces
>> (e.g. /proc, /sys, /dev, etc.).
> 
> Actually chroot does not so limit the view of things.  It only limits
> the default view.
> 
> A process that is chrooted can always escape by something like
> chroot("../../../../../../../../..").

Not with this patch.

> 
> So I don't see the point of allowing chroot once you are in your locked
> down sandbox.
> 
>> Users may not wish to expose namespace complexity to potentially
>> malicious processes, or limit their use because of limited resources.
>> The chroot feature is much more simple (and limited) than the mount
>> namespace, but can still be useful.  As for containers, users of
>> chroot(2) should take care of file descriptors or data accessible by
>> other means (e.g. current working directory, leaked FDs, passed FDs,
>> devices, mount points, etc.).  There is a lot of literature that discuss
>> the limitations of chroot, and users of this feature should be aware of
>> the multiple ways to bypass it.  Using chroot(2) for security purposes
>> can make sense if it is combined with other features (e.g. dedicated
>> user, seccomp, LSM access-controls, etc.).
>>
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
>> Allowing a task to change its own root directory is not a threat to the
>> system if we can prevent confused deputy attacks, which could be
>> performed through execution of SUID-like binaries.  This can be
>> prevented if the calling task sets PR_SET_NO_NEW_PRIVS on itself with
>> prctl(2).  To only affect this task, its filesystem information must not
>> be shared with other tasks, which can be achieved by not passing
>> CLONE_FS to clone(2).  A similar no_new_privs check is already used by
>> seccomp to avoid the same kind of security issues.  Furthermore, because
>> of its security use and to avoid giving a new way for attackers to get
>> out of a chroot (e.g. using /proc/<pid>/root), an unprivileged chroot is
>> only allowed if the new root directory is the same or beneath the
>> current one.  This still allows a process to use a subset of its
>> legitimate filesystem to chroot into and then further reduce its view of
>> the filesystem.
>>
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
>> This patch is a follow-up of a previous one sent by Andy Lutomirski, but
>> with less limitations:
>> https://lore.kernel.org/lkml/0e2f0f54e19bff53a3739ecfddb4ffa9a6dbde4d.1327858005.git.luto@amacapital.net/
> 
> Last time I remember talking architecture we agreed that user namespaces
> would be used for enabling features and that no_new_privs would just be
> used to lock-down userspace.  That way no_new_privs could be kept simple
> and trivial to audit and understand.

chroot(2) is simple.

> 
> You can build your sandbox and use chroot if you use a user namespace at
> the start.  A mount namespace would also help lock things down.  Still
> allowing chroot after the sanbox has been built, a seccomp filter has
> been installed and no_new_privs has been enabled seems like it is asking
> for trouble and may weaken existing sandboxes.

Could you please provide a new attack scenario?

> 
> So I think we need a pretty compelling use case to consider allowing
> chroot(2).  You haven't even mentioned what your usecase is at this
> point so I don't know why we would tackle that complexity.

They are explained in this commit message.

> 
> Eric
> 
