Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C90CF334809
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Mar 2021 20:34:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233351AbhCJTdy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Mar 2021 14:33:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233951AbhCJTdl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Mar 2021 14:33:41 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB8C4C061762
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Mar 2021 11:33:40 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id k12so27118670ljg.9
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Mar 2021 11:33:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=C0lOxwjMEr6SWX1hFkOaQGtQdtdGB5FiXwich6XA348=;
        b=NM0J3hx50vHdC/p5h3lzfZtYNUEYEEEUohjNigiA0KbbFneszGz381/p3GLd6yhcWu
         1KuK6TsD+n34eVK+nnQVCLf7Ie1gBju2CVq9ZLZdvETqSzALoCaMBhnofjKv/3sNUuYN
         Q+U9UAUcm9S3x+gB24/4Dfqmv17Vzecl9QcOThzFQv18IpgBij82+yGRMQkEuNTIH62P
         CHqkLGTcxXMX4XVmnYWQNqi/lUVZXi/3hSoVBkV7dSo11C67xn4g9eGuGxYzntTDETq0
         gZmbcBXsEeXMzgX7wVy0G9U7fO0WveTk3yR14wSE1t3VhTeVYQHPwgmWcjKqCHW98c+d
         QxrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=C0lOxwjMEr6SWX1hFkOaQGtQdtdGB5FiXwich6XA348=;
        b=udaX3+d+bXT4J1xi0LgA5Xf60qGeGRaawK5yzkak08Yy2gTMpz+mkhxLeD/CwVqoYB
         tJYzPDvAIReVu4kZ1R3xPbIh5Vtqo92jEPv0KPrL3cmieFpXYMDGVE6W2zbMSMPCtfeq
         Q4PoWCVJwo8ZsSZqpsY3a7kSWGMyQ21hHWygoLEOls1ZnNc3YEW8+PxIzbK4x2k5k+KK
         prpJCCQhlDrKkE9kxCTzalGOTbvWkmDkvP+lYvTlovc8tY6VMowWpxC926KoUM8tJnIJ
         ujmJqmeS+JnqrMuxq4mZuZVPNLvtBWULs6oJArQTgDcSQlLxOdha8iiXWtAGtfV+L0Tm
         9Dng==
X-Gm-Message-State: AOAM531fusSQBM1agUhTtoPq968NQKSKOtcNvJGM29kFYVJMIdvQA+PL
        BgoNjdzaBrsVOuCPzxs8JK9Da9qa//QMVRURsAzDVw==
X-Google-Smtp-Source: ABdhPJywfvsHOIz0NkR2nMiYoKEhfTkPo9yaeevm6MgBPXJj4NmO1bY3FBXA9+0DF6QnwYxqUt/SZcMZ24QK6nH4d6g=
X-Received: by 2002:a2e:9bcd:: with SMTP id w13mr2643039ljj.43.1615404819005;
 Wed, 10 Mar 2021 11:33:39 -0800 (PST)
MIME-Version: 1.0
References: <20210310181857.401675-1-mic@digikod.net> <20210310181857.401675-2-mic@digikod.net>
 <m17dmeq0co.fsf@fess.ebiederm.org>
In-Reply-To: <m17dmeq0co.fsf@fess.ebiederm.org>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 10 Mar 2021 20:33:12 +0100
Message-ID: <CAG48ez2gVdyFT3r_wVuqePWGQAi6YuYYXZcRJ7ENNdnpfpvkuw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] fs: Allow no_new_privs tasks to call chroot(2)
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
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
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 10, 2021 at 8:23 PM Eric W. Biederman <ebiederm@xmission.com> w=
rote:
>
> Micka=C3=ABl Sala=C3=BCn <mic@digikod.net> writes:
>
> > From: Micka=C3=ABl Sala=C3=BCn <mic@linux.microsoft.com>
> >
> > Being able to easily change root directories enable to ease some
> > development workflow and can be used as a tool to strengthen
> > unprivileged security sandboxes.  chroot(2) is not an access-control
> > mechanism per se, but it can be used to limit the absolute view of the
> > filesystem, and then limit ways to access data and kernel interfaces
> > (e.g. /proc, /sys, /dev, etc.).
> >
> > Users may not wish to expose namespace complexity to potentially
> > malicious processes, or limit their use because of limited resources.
> > The chroot feature is much more simple (and limited) than the mount
> > namespace, but can still be useful.  As for containers, users of
> > chroot(2) should take care of file descriptors or data accessible by
> > other means (e.g. current working directory, leaked FDs, passed FDs,
> > devices, mount points, etc.).  There is a lot of literature that discus=
s
> > the limitations of chroot, and users of this feature should be aware of
> > the multiple ways to bypass it.  Using chroot(2) for security purposes
> > can make sense if it is combined with other features (e.g. dedicated
> > user, seccomp, LSM access-controls, etc.).
> >
> > One could argue that chroot(2) is useless without a properly populated
> > root hierarchy (i.e. without /dev and /proc).  However, there are
> > multiple use cases that don't require the chrooting process to create
> > file hierarchies with special files nor mount points, e.g.:
> > * A process sandboxing itself, once all its libraries are loaded, may
> >   not need files other than regular files, or even no file at all.
> > * Some pre-populated root hierarchies could be used to chroot into,
> >   provided for instance by development environments or tailored
> >   distributions.
> > * Processes executed in a chroot may not require access to these specia=
l
> >   files (e.g. with minimal runtimes, or by emulating some special files
> >   with a LD_PRELOADed library or seccomp).
> >
> > Allowing a task to change its own root directory is not a threat to the
> > system if we can prevent confused deputy attacks, which could be
> > performed through execution of SUID-like binaries.  This can be
> > prevented if the calling task sets PR_SET_NO_NEW_PRIVS on itself with
> > prctl(2).  To only affect this task, its filesystem information must no=
t
> > be shared with other tasks, which can be achieved by not passing
> > CLONE_FS to clone(2).  A similar no_new_privs check is already used by
> > seccomp to avoid the same kind of security issues.  Furthermore, becaus=
e
> > of its security use and to avoid giving a new way for attackers to get
> > out of a chroot (e.g. using /proc/<pid>/root), an unprivileged chroot i=
s
> > only allowed if the new root directory is the same or beneath the
> > current one.  This still allows a process to use a subset of its
> > legitimate filesystem to chroot into and then further reduce its view o=
f
> > the filesystem.
> >
> > This change may not impact systems relying on other permission models
> > than POSIX capabilities (e.g. Tomoyo).  Being able to use chroot(2) on
> > such systems may require to update their security policies.
> >
> > Only the chroot system call is relaxed with this no_new_privs check; th=
e
> > init_chroot() helper doesn't require such change.
> >
> > Allowing unprivileged users to use chroot(2) is one of the initial
> > objectives of no_new_privs:
> > https://www.kernel.org/doc/html/latest/userspace-api/no_new_privs.html
> > This patch is a follow-up of a previous one sent by Andy Lutomirski, bu=
t
> > with less limitations:
> > https://lore.kernel.org/lkml/0e2f0f54e19bff53a3739ecfddb4ffa9a6dbde4d.1=
327858005.git.luto@amacapital.net/
[...]
> Neither is_path_beneath nor path_is_under really help prevent escapes,
> as except for open files and files accessible from proc chroot already
> disallows going up.  The reason is the path is resolved with the current
> root before switching to it.

Yeah, this probably should use the same check as the CLONE_NEWUSER
logic, current_chrooted() from CLONE_NEWUSER; that check is already
used for guarding against the following syscall sequence, which has
similar security properties:
unshare(CLONE_NEWUSER); // gives the current process namespaced CAP_SYS_ADM=
IN
chroot("<...>"); // succeeds because of namespaced CAP_SYS_ADMIN

The current_chrooted() check in create_user_ns() is for the same
purpose as the check you're introducing here, so they should use the
same logic.
