Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61F9F17ECCA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Mar 2020 00:45:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727470AbgCIXpW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Mar 2020 19:45:22 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:38129 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727464AbgCIXpW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Mar 2020 19:45:22 -0400
Received: by mail-ot1-f67.google.com with SMTP id i14so11454086otp.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Mar 2020 16:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fmBdIxd2DBH3drat2RxXw5EvMETx4X35UelSAv/ALh8=;
        b=TEQwnLgh8B3PsJKBlW2TWyJTnA9DDlkOy51XwT8ZvW45CdlsU0L88IRmKnKkRltzBm
         kGOI6UBw/K7+paEi85+jlPPq3aiTme3vzGx0b9SuJDLCK0DjPl3v+LDgpJwsWFjalO1g
         VMe5PrqnKGg8d5GsqbZHoRMhh7Niv0b3RLcDFnfMlagHZIzScsm1LLtypLf7E73dZsIz
         Uu+rOdydlnVXzRtmsfDp6JQRHCADpg+3xOUK4fvE+ZcX7GO7hPaNAxIED0JiHv2Ndvjm
         IgTFCLoYEf13ad9TCi4MxxRLj54zFArGjR3fZwoYAoFD1Y+5F1sl/nxCYT1zPUp2xbwH
         keJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fmBdIxd2DBH3drat2RxXw5EvMETx4X35UelSAv/ALh8=;
        b=FdWHQDxv1BqOKJJz7PGdGLum1HfvUds82+X53rBFEFTc65jEhOKvrkjVKekWD7MJDp
         627oXAnYEhC0ksj1gfyE2CGufX1g+GgRKFYP6LKrt4yF6+YhnEED20eeetbpITaHHGv+
         qXzZvS/4eJomovViVZUmovvtO/+eYMSmj2WaYpPP0ohEqZeZngP4cJ0djChYpuJOJbGs
         WJGMWIOxQKsg0Gm6O8/pteR5D9Zyxu03av+AWykHs4exbnthe1mOKqFg8+85vV9jRcXx
         1fTMENYBByih9hKEWPLu3Id/XxstCL1v6pV5zzn+2dE94SviODKCY1RHTrtngNXSdsmj
         L5/Q==
X-Gm-Message-State: ANhLgQ2UteSmEzAIAwfgLpd3+GRYKNRtsN11m0gIUDwktC/tXBAfrjrZ
        6kxpBtHnfW1o/yAXhJ6jmb1UCTrMwHhKLwv7XU8cFg==
X-Google-Smtp-Source: ADFU+vu3ctqe66UiWnus61OOtoDCVSNb+kXOZJ2waD27t2a3YUthZNqfb4fWuw2uMljnqbH/s6/XwWZrmf2yGIRlebQ=
X-Received: by 2002:a9d:7358:: with SMTP id l24mr14121308otk.228.1583797521077;
 Mon, 09 Mar 2020 16:45:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200224160215.4136-1-mic@digikod.net>
In-Reply-To: <20200224160215.4136-1-mic@digikod.net>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 10 Mar 2020 00:44:54 +0100
Message-ID: <CAG48ez21bEn0wL1bbmTiiu8j9jP5iEWtHOwz4tURUJ+ki0ydYw@mail.gmail.com>
Subject: Re: [RFC PATCH v14 00/10] Landlock LSM
To:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@amacapital.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Morris <jmorris@namei.org>, Jann Horn <jann@thejh.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mickael.salaun@ssi.gouv.fr>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Shuah Khan <shuah@kernel.org>,
        Vincent Dagonneau <vincent.dagonneau@ssi.gouv.fr>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-doc@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 24, 2020 at 5:03 PM Micka=C3=ABl Sala=C3=BCn <mic@digikod.net> =
wrote:
> This new version of Landlock is a major revamp of the previous series
> [1], hence the RFC tag.  The three main changes are the replacement of
> eBPF with a dedicated safe management of access rules, the replacement
> of the use of seccomp(2) with a dedicated syscall, and the management of
> filesystem access-control (back from the v10).
>
> As discussed in [2], eBPF may be too powerful and dangerous to be put in
> the hand of unprivileged and potentially malicious processes, especially
> because of side-channel attacks against access-controls or other parts
> of the kernel.
>
> Thanks to this new implementation (1540 SLOC), designed from the ground
> to be used by unprivileged processes, this series enables a process to
> sandbox itself without requiring CAP_SYS_ADMIN, but only the
> no_new_privs constraint (like seccomp).  Not relying on eBPF also
> enables to improve performances, especially for stacked security
> policies thanks to mergeable rulesets.
>
> The compiled documentation is available here:
> https://landlock.io/linux-doc/landlock-v14/security/landlock/index.html
>
> This series can be applied on top of v5.6-rc3.  This can be tested with
> CONFIG_SECURITY_LANDLOCK and CONFIG_SAMPLE_LANDLOCK.  This patch series
> can be found in a Git repository here:
> https://github.com/landlock-lsm/linux/commits/landlock-v14
> I would really appreciate constructive comments on the design and the cod=
e.

I've looked through the patchset, and I think that it would be
possible to simplify it quite a bit. I have tried to do that (and
compiled-tested it, but not actually tried running it); here's what I
came up with:

https://github.com/thejh/linux/commits/landlock-mod

The three modified patches (patches 1, 2 and 5) are marked with
"[MODIFIED]" in their title. Please take a look - what do you think?
Feel free to integrate my changes into your patches if you think they
make sense.


Apart from simplifying the code, I also found the following issues,
which I have fixed in the modified patches:

put_hierarchy() has to drop a reference on its parent. (However, this
must not recurse, so we have to do it with a loop.)

put_ruleset() is not in an RCU read-side critical section, so as soon
as it calls kfree_rcu(), "freeme" might disappear; but "orig" is in
"freeme", so when the loop tries to find the next element with
rb_next(orig), that can be a UAF.
rbtree_postorder_for_each_entry_safe() exists for dealing with such
issues.

AFAIK the calls to rb_erase() in clean_ruleset() is not safe if
someone is concurrently accessing the rbtree as an RCU reader, because
concurrent rotations can prevent a lookup from succeeding. The
simplest fix is probably to just make any rbtree that has been
installed on a process immutable, and give up on the cleaning -
arguably the memory wastage that can cause is pretty limited. (By the
way, as a future optimization, we might want to turn the rbtree into a
hashtable when installing it?)

The iput() in landlock_release_inode() looks unsafe - you need to
guarantee that even if the deletion of a ruleset races with
generic_shutdown_super(), every iput() for that superblock finishes
before landlock_release_inodes() returns, even if the iput() is
happening in the context of ruleset deletion. This is why
fsnotify_unmount_inodes() has that wait_var_event() at the end.


Aside from those things, there is also a major correctness issue where
I'm not sure how to solve it properly:

Let's say a process installs a filter on itself like this:

struct landlock_attr_ruleset ruleset =3D { .handled_access_fs =3D
ACCESS_FS_ROUGHLY_WRITE};
int ruleset_fd =3D landlock(LANDLOCK_CMD_CREATE_RULESET,
LANDLOCK_OPT_CREATE_RULESET, sizeof(ruleset), &ruleset);
struct landlock_attr_path_beneath path_beneath =3D {
  .ruleset_fd =3D ruleset_fd,
  .allowed_access =3D ACCESS_FS_ROUGHLY_WRITE,
  .parent_fd =3D open("/tmp/foobar", O_PATH),
};
landlock(LANDLOCK_CMD_ADD_RULE, LANDLOCK_OPT_ADD_RULE_PATH_BENEATH,
sizeof(path_beneath), &path_beneath);
prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
struct landlock_attr_enforce attr_enforce =3D { .ruleset_fd =3D ruleset_fd =
};
landlock(LANDLOCK_CMD_ENFORCE_RULESET, LANDLOCK_OPT_ENFORCE_RULESET,
sizeof(attr_enforce), &attr_enforce);

At this point, the process is not supposed to be able to write to
anything outside /tmp/foobar, right? But what happens if the process
does the following next?

struct landlock_attr_ruleset ruleset =3D { .handled_access_fs =3D
ACCESS_FS_ROUGHLY_WRITE};
int ruleset_fd =3D landlock(LANDLOCK_CMD_CREATE_RULESET,
LANDLOCK_OPT_CREATE_RULESET, sizeof(ruleset), &ruleset);
struct landlock_attr_path_beneath path_beneath =3D {
  .ruleset_fd =3D ruleset_fd,
  .allowed_access =3D ACCESS_FS_ROUGHLY_WRITE,
  .parent_fd =3D open("/", O_PATH),
};
landlock(LANDLOCK_CMD_ADD_RULE, LANDLOCK_OPT_ADD_RULE_PATH_BENEATH,
sizeof(path_beneath), &path_beneath);
prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
struct landlock_attr_enforce attr_enforce =3D { .ruleset_fd =3D ruleset_fd =
};
landlock(LANDLOCK_CMD_ENFORCE_RULESET, LANDLOCK_OPT_ENFORCE_RULESET,
sizeof(attr_enforce), &attr_enforce);

As far as I can tell from looking at the source, after this, you will
have write access to the entire filesystem again. I think the idea is
that LANDLOCK_CMD_ENFORCE_RULESET should only let you drop privileges,
not increase them, right?

I think the easy way to fix this would be to add a bitmask to each
rule that says from which ruleset it originally comes, and then let
check_access_path() collect these bitmasks from each rule with OR, and
check at the end whether the resulting bitmask is full - if not, at
least one of the rulesets did not permit the access, and it should be
denied.

But maybe it would make more sense to change how the API works
instead, and get rid of the concept of "merging" two rulesets
together? Instead, we could make the API work like this:

 - LANDLOCK_CMD_CREATE_RULESET gives you a file descriptor whose
->private_data contains a pointer to the old ruleset of the process,
as well as a pointer to a new empty ruleset.
 - LANDLOCK_CMD_ADD_RULE fails if the specified rule would not be
permitted by the old ruleset, then adds the rule to the new ruleset
 - LANDLOCK_CMD_ENFORCE_RULESET fails if the old ruleset pointer in
->private_data doesn't match the current ruleset of the process, then
replaces the old ruleset with the new ruleset.

With this, the new ruleset is guaranteed to be a subset of the old
ruleset because each of the new ruleset's rules is permitted by the
old ruleset. (Unless the directory hierarchy rotates, but in that case
the inaccuracy isn't much worse than what would've been possible
through RCU path walk anyway AFAIK.)

What do you think?
