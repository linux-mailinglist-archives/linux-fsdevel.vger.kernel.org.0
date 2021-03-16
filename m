Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB7433DE68
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Mar 2021 21:07:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238870AbhCPUGd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Mar 2021 16:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbhCPUG3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Mar 2021 16:06:29 -0400
Received: from smtp-bc09.mail.infomaniak.ch (smtp-bc09.mail.infomaniak.ch [IPv6:2001:1600:3:17::bc09])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4936C06174A
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Mar 2021 13:06:28 -0700 (PDT)
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4F0PSJ3SyNzMqHf6;
        Tue, 16 Mar 2021 21:06:24 +0100 (CET)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4F0PSG4YVGzlh8TH;
        Tue, 16 Mar 2021 21:06:22 +0100 (CET)
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
 <ec7a3a21-c402-c153-a932-ce4a40edadaa@digikod.net>
 <CAG48ez0UHP=B6MW5ySMOAQ677byzyWkwgPto1RdW6FYJH5b7Zg@mail.gmail.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Message-ID: <c7fbf088-02c2-6cac-f353-14bff23d6864@digikod.net>
Date:   Tue, 16 Mar 2021 21:06:25 +0100
User-Agent: 
MIME-Version: 1.0
In-Reply-To: <CAG48ez0UHP=B6MW5ySMOAQ677byzyWkwgPto1RdW6FYJH5b7Zg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 16/03/2021 20:31, Jann Horn wrote:
> On Tue, Mar 16, 2021 at 8:26 PM Mickaël Salaün <mic@digikod.net> wrote:
>> On 16/03/2021 20:04, Jann Horn wrote:
>>> On Tue, Mar 16, 2021 at 6:02 PM Mickaël Salaün <mic@digikod.net> wrote:
>>>> One could argue that chroot(2) is useless without a properly populated
>>>> root hierarchy (i.e. without /dev and /proc).  However, there are
>>>> multiple use cases that don't require the chrooting process to create
>>>> file hierarchies with special files nor mount points, e.g.:
>>>> * A process sandboxing itself, once all its libraries are loaded, may
>>>>   not need files other than regular files, or even no file at all.
>>>> * Some pre-populated root hierarchies could be used to chroot into,
>>>>   provided for instance by development environments or tailored
>>>>   distributions.
>>>> * Processes executed in a chroot may not require access to these special
>>>>   files (e.g. with minimal runtimes, or by emulating some special files
>>>>   with a LD_PRELOADed library or seccomp).
>>>>
>>>> Unprivileged chroot is especially interesting for userspace developers
>>>> wishing to harden their applications.  For instance, chroot(2) and Yama
>>>> enable to build a capability-based security (i.e. remove filesystem
>>>> ambient accesses) by calling chroot/chdir with an empty directory and
>>>> accessing data through dedicated file descriptors obtained with
>>>> openat2(2) and RESOLVE_BENEATH/RESOLVE_IN_ROOT/RESOLVE_NO_MAGICLINKS.
>>>
>>> I don't entirely understand. Are you writing this with the assumption
>>> that a future change will make it possible to set these RESOLVE flags
>>> process-wide, or something like that?
>>
>> No, this scenario is for applications willing to sandbox themselves and
>> only use the FDs to access legitimate data.
> 
> But if you're chrooted to /proc/self/fdinfo and have an fd to some
> directory - let's say /home/user/Downloads - there is nothing that
> ensures that you only use that fd with RESOLVE_BENEATH, right? If the
> application is compromised, it can do something like openat(fd,
> "../.bashrc", O_RDWR), right? Or am I missing something?

You're totally right, I was mistaken, this simple use case doesn't work
without a broker. Perhaps when seccomp will be able to check referenced
structs, or with a new FD limitation…

> 
>>> As long as that doesn't exist, I think that to make this safe, you'd
>>> have to do something like the following - let a child process set up a
>>> new mount namespace for you, and then chroot() into that namespace's
>>> root:
>>>
>>> struct shared_data {
>>>   int root_fd;
>>> };
>>> int helper_fn(void *args) {
>>>   struct shared_data *shared = args;
>>>   mount("none", "/tmp", "tmpfs", MS_NOSUID|MS_NODEV, "");
>>>   mkdir("/tmp/old_root", 0700);
>>>   pivot_root("/tmp", "/tmp/old_root");
>>>   umount("/tmp/old_root", "");
>>>   shared->root_fd = open("/", O_PATH);
>>> }
>>> void setup_chroot() {
>>>   struct shared_data shared = {};
>>>   prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
>>>   clone(helper_fn, my_stack,
>>> CLONE_VFORK|CLONE_VM|CLONE_FILES|CLONE_NEWUSER|CLONE_NEWNS|SIGCHLD,
>>> NULL);
>>>   fchdir(shared.root_fd);
>>>   chroot(".");
>>> }
>>
>> What about this?
>> chdir("/proc/self/fdinfo");
>> chroot(".");
>> close(all unnecessary FDs);
> 
> That breaks down if you can e.g. get a unix domain socket connected to
> a process in a different chroot, right? Isn't that a bit too fragile?

This relies on other (trusted) components, and yes it is fragile if the
process communicates with a service able send FDs.
