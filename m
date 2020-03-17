Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5B94188A0D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Mar 2020 17:20:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgCQQUL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Mar 2020 12:20:11 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:34448 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726207AbgCQQUL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Mar 2020 12:20:11 -0400
Received: by mail-ot1-f65.google.com with SMTP id j16so22241782otl.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Mar 2020 09:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LDDLPrurbXme3HphtMq0LDhgeuYDSZr9cLDGYqfGR1U=;
        b=pJM18bnIe3Novdg3QP++3NYc6FrVfVjft3IKS7J/CPzIJsoZweJFv9jqcPBuw3zt3/
         5oaKc57yprv/RlDts/CD2k7XS9cAhxBVpzU43/ACyjXfmXDpYFw7MU4zGOorMZoMbALD
         WWpfjyMYDz/zd243nfbYCG7qDeZx3DbYkyORWG72zEs95pvL65Yy+agupol0WiCmw7e1
         gq6Z2MUSiFv09vFrStVjZbWX3Idrh5WvnBFsChRibn2YFuzwq3+4BZ9P27lLIWdtIuZf
         xj6EILeP/mGKSlKAI3Qt0vd6RlVK/X9J6qeeqpohG7fzznWAr6FL5ixkohRw7HJBWG0e
         cFeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LDDLPrurbXme3HphtMq0LDhgeuYDSZr9cLDGYqfGR1U=;
        b=Z/mQCYwmRThLccXr2MRCUWpM1zMh+CnX8YatXIeamwXhuhkX2CVhlBXqWPvOqsFCnz
         kvi57Ob3xqH9VrkNqFGW1Zyl/MN3qjWyiPM6Omh6ica1JuJ5nUY0eKCoRQmR4OSEj9Aq
         trVNyq72ytIoAQC2jueb6GVV0kTN0C31g9VM3x8THRe2Rif4ASWJULCjTlggZthJHp4L
         I9ZPJgKN5PmufQ2dQ3XJz8EywTwopeOVvUS957Clw5oEcqSdpynE2/wR3EnifyShuAKv
         b9uD/jasGsUA9LKPOGA/RkUmuSXNdzSQ9ZUfrE/ZtH7U5j4PkOkfb1FsPIkMW3rXRa8Z
         ph9w==
X-Gm-Message-State: ANhLgQ3OjCEd05mikq3MjXfuVW/gzOjwvWsD8NrvjA3zZDpAolzHqY39
        9ttlOVJvtEBakJtyPnRQ/QALuZuoOcFSIaZlALMNkw==
X-Google-Smtp-Source: ADFU+vvYtV0FKPWq7LFeyokEHyBI71vTbRcOgoCKbPcTmFER+gCEBMqzGIoqAItRSRLT/GDI4LPOGMTySoaWeJJtd9c=
X-Received: by 2002:a9d:7cd1:: with SMTP id r17mr4602832otn.183.1584462009635;
 Tue, 17 Mar 2020 09:20:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200224160215.4136-1-mic@digikod.net> <CAG48ez21bEn0wL1bbmTiiu8j9jP5iEWtHOwz4tURUJ+ki0ydYw@mail.gmail.com>
 <873d7419-bdd9-8a52-0a9b-dddbe31df4f9@digikod.net>
In-Reply-To: <873d7419-bdd9-8a52-0a9b-dddbe31df4f9@digikod.net>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 17 Mar 2020 17:19:43 +0100
Message-ID: <CAG48ez0=0W5Ok-8nASqZrZ28JboXRRi3gDxV5u6mdcOtzwuRVA@mail.gmail.com>
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

On Thu, Mar 12, 2020 at 12:38 AM Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>=
 wrote:
> On 10/03/2020 00:44, Jann Horn wrote:
> > On Mon, Feb 24, 2020 at 5:03 PM Micka=C3=ABl Sala=C3=BCn <mic@digikod.n=
et> wrote:
> >> This new version of Landlock is a major revamp of the previous series
> >> [1], hence the RFC tag.  The three main changes are the replacement of
> >> eBPF with a dedicated safe management of access rules, the replacement
> >> of the use of seccomp(2) with a dedicated syscall, and the management =
of
> >> filesystem access-control (back from the v10).
> >>
> >> As discussed in [2], eBPF may be too powerful and dangerous to be put =
in
> >> the hand of unprivileged and potentially malicious processes, especial=
ly
> >> because of side-channel attacks against access-controls or other parts
> >> of the kernel.
> >>
> >> Thanks to this new implementation (1540 SLOC), designed from the groun=
d
> >> to be used by unprivileged processes, this series enables a process to
> >> sandbox itself without requiring CAP_SYS_ADMIN, but only the
> >> no_new_privs constraint (like seccomp).  Not relying on eBPF also
> >> enables to improve performances, especially for stacked security
> >> policies thanks to mergeable rulesets.
> >>
> >> The compiled documentation is available here:
> >> https://landlock.io/linux-doc/landlock-v14/security/landlock/index.htm=
l
> >>
> >> This series can be applied on top of v5.6-rc3.  This can be tested wit=
h
> >> CONFIG_SECURITY_LANDLOCK and CONFIG_SAMPLE_LANDLOCK.  This patch serie=
s
> >> can be found in a Git repository here:
> >> https://github.com/landlock-lsm/linux/commits/landlock-v14
> >> I would really appreciate constructive comments on the design and the =
code.
> >
> > I've looked through the patchset, and I think that it would be
> > possible to simplify it quite a bit. I have tried to do that (and
> > compiled-tested it, but not actually tried running it); here's what I
> > came up with:
> >
> > https://github.com/thejh/linux/commits/landlock-mod
> >
> > The three modified patches (patches 1, 2 and 5) are marked with
> > "[MODIFIED]" in their title. Please take a look - what do you think?
> > Feel free to integrate my changes into your patches if you think they
> > make sense.
>
> Regarding the landlock_release_inodes(), the final wait_var_event() is
> indeed needed (as does fsnotify), but why do you use a READ_ONCE() for
> landlock_initialized?

Ah, good point - that READ_ONCE() should be unnecessary.

> The other main change is about the object cross-reference: you entirely
> removed it, which means that an object will only be free when there are
> no rules using it. This does not free an object when its underlying
> object is being terminated. We now only have to worry about the
> termination of the parent of an underlying object (e.g. the super-block
> of an inode).
>
> However, I think you forgot to increment object->usage in
> create_ruleset_elem().

Whoops, you're right.

> There is also an unused checked_mask variable in merge_ruleset().

Oh, yeah, oops.

> All this removes optimizations that made the code more difficult to
> understand. The performance difference is negligible, and I think that
> the memory footprint is fine.
> These optimizations (and others) could be discussed later. I'm
> integrating most of your changes in the next patch series.

:)

> > Aside from those things, there is also a major correctness issue where
> > I'm not sure how to solve it properly:
> >
> > Let's say a process installs a filter on itself like this:
> >
> > struct landlock_attr_ruleset ruleset =3D { .handled_access_fs =3D
> > ACCESS_FS_ROUGHLY_WRITE};
> > int ruleset_fd =3D landlock(LANDLOCK_CMD_CREATE_RULESET,
> > LANDLOCK_OPT_CREATE_RULESET, sizeof(ruleset), &ruleset);
> > struct landlock_attr_path_beneath path_beneath =3D {
> >   .ruleset_fd =3D ruleset_fd,
> >   .allowed_access =3D ACCESS_FS_ROUGHLY_WRITE,
> >   .parent_fd =3D open("/tmp/foobar", O_PATH),
> > };
> > landlock(LANDLOCK_CMD_ADD_RULE, LANDLOCK_OPT_ADD_RULE_PATH_BENEATH,
> > sizeof(path_beneath), &path_beneath);
> > prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
> > struct landlock_attr_enforce attr_enforce =3D { .ruleset_fd =3D ruleset=
_fd };
> > landlock(LANDLOCK_CMD_ENFORCE_RULESET, LANDLOCK_OPT_ENFORCE_RULESET,
> > sizeof(attr_enforce), &attr_enforce);
> >
> > At this point, the process is not supposed to be able to write to
> > anything outside /tmp/foobar, right? But what happens if the process
> > does the following next?
> >
> > struct landlock_attr_ruleset ruleset =3D { .handled_access_fs =3D
> > ACCESS_FS_ROUGHLY_WRITE};
> > int ruleset_fd =3D landlock(LANDLOCK_CMD_CREATE_RULESET,
> > LANDLOCK_OPT_CREATE_RULESET, sizeof(ruleset), &ruleset);
> > struct landlock_attr_path_beneath path_beneath =3D {
> >   .ruleset_fd =3D ruleset_fd,
> >   .allowed_access =3D ACCESS_FS_ROUGHLY_WRITE,
> >   .parent_fd =3D open("/", O_PATH),
> > };
> > landlock(LANDLOCK_CMD_ADD_RULE, LANDLOCK_OPT_ADD_RULE_PATH_BENEATH,
> > sizeof(path_beneath), &path_beneath);
> > prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
> > struct landlock_attr_enforce attr_enforce =3D { .ruleset_fd =3D ruleset=
_fd };
> > landlock(LANDLOCK_CMD_ENFORCE_RULESET, LANDLOCK_OPT_ENFORCE_RULESET,
> > sizeof(attr_enforce), &attr_enforce);
> >
> > As far as I can tell from looking at the source, after this, you will
> > have write access to the entire filesystem again. I think the idea is
> > that LANDLOCK_CMD_ENFORCE_RULESET should only let you drop privileges,
> > not increase them, right?
>
> There is an additionnal check in syscall.c:get_path_from_fd(): it is
> forbidden to add a rule with a path which is not accessible (according
> to LANDLOCK_ACCESS_FS_OPEN) thanks to a call to security_file_open(),
> but this is definitely not perfect.

Ah, I missed that.

> > I think the easy way to fix this would be to add a bitmask to each
> > rule that says from which ruleset it originally comes, and then let
> > check_access_path() collect these bitmasks from each rule with OR, and
> > check at the end whether the resulting bitmask is full - if not, at
> > least one of the rulesets did not permit the access, and it should be
> > denied.
> >
> > But maybe it would make more sense to change how the API works
> > instead, and get rid of the concept of "merging" two rulesets
> > together? Instead, we could make the API work like this:
> >
> >  - LANDLOCK_CMD_CREATE_RULESET gives you a file descriptor whose
> > ->private_data contains a pointer to the old ruleset of the process,
> > as well as a pointer to a new empty ruleset.
> >  - LANDLOCK_CMD_ADD_RULE fails if the specified rule would not be
> > permitted by the old ruleset, then adds the rule to the new ruleset
> >  - LANDLOCK_CMD_ENFORCE_RULESET fails if the old ruleset pointer in
> > ->private_data doesn't match the current ruleset of the process, then
> > replaces the old ruleset with the new ruleset.
> >
> > With this, the new ruleset is guaranteed to be a subset of the old
> > ruleset because each of the new ruleset's rules is permitted by the
> > old ruleset. (Unless the directory hierarchy rotates, but in that case
> > the inaccuracy isn't much worse than what would've been possible
> > through RCU path walk anyway AFAIK.)
> >
> > What do you think?
> >
>
> I would prefer to add the same checks you described at first (with
> check_access_path), but only when creating a new ruleset with
> merge_ruleset() (which should probably be renamed). This enables not to
> rely on a parent ruleset/domain until the enforcement, which is the case
> anyway.
> Unfortunately this doesn't work for some cases with bind mounts. Because
> check_access_path() goes through one path, another (bind mounted) path
> could be illegitimately allowed.

Hmm... I'm not sure what you mean. At the moment, landlock doesn't
allow any sandboxed process to change the mount hierarchy, right? Can
you give an example where this would go wrong?

> That makes the problem a bit more complicated. A solution may be to keep
> track of the hierarchy of each rule (e.g. with a layer/depth number),
> and only allow an access request if at least a rule of each layer allow
> this access. In this case we also need to correctly handle the case when
> rules from different layers are tied to the same object.
