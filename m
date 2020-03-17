Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DAF54188E3F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Mar 2020 20:46:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbgCQTqZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Mar 2020 15:46:25 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:32981 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbgCQTqZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Mar 2020 15:46:25 -0400
Received: by mail-ot1-f68.google.com with SMTP id x26so5987871otk.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Mar 2020 12:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9s2Sb3c4MxnnBmpoBuePNWugbWE68PyhFAR020YyxKI=;
        b=JI600Y+S7vaaL+M1SlEKgAEtEUPT5Q45PYyhNUPJY82ExiEm4yLvuyoLjANOxrw/L8
         K0LSxUZhq+pXM1GGwp3j51HMQSJZsaS91TWVYRhmi3aC265XUUVxVsf85Lt6C4FHfODU
         F+8841uMdqRd6VymvDirqjn9SmklKMzELb2nq4ltyUMq1nVMo8mh6KrYIj6CXSK8975s
         8Wppxc9EDwI6+CuP2CcdW21eufAGc9NTfDD0XTQ6x9Ta4mXhWmyFq+EubLApEE3PIMY3
         UluxszB5ZBrGmCkrxM1stsbflxhZ846CG2/SzeG3kVFjDKkewelUAmzGKrdjkzgjSzUp
         gkCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9s2Sb3c4MxnnBmpoBuePNWugbWE68PyhFAR020YyxKI=;
        b=HdILEtsHuumDYCBhXpUvwZ/ptkGFDdHGkrIpaeQWQjqGnSNFRgK8gqsWaHfIauOvSG
         OK8E4pt+SblRSxyRsDcdMGWsBNbe1ugADkmPb4hdhfajQcprk6uXKD4A8fGZryvH0tsZ
         WLQMQ2PYPpyTpK4VZnhCj7hj25nwcGfKQ7+TiZTfzSKscxpTum/FiqfMkc0s/8nsqKkd
         RhmS5ROtPD+RuA7tSeEUcwDpZJ4OH/NF9di/tr0srltrtTjNGtrzOg6GAKIPC15NBHGg
         KXAD0Guvq1mjH7D9+oLOmkJD/o7IuE7ShKfVoL3iRSbuzrEf4NeAnakj0oPdBO4mP5AN
         ypbA==
X-Gm-Message-State: ANhLgQ2uBO7ec94DmRalvtDgQ97mouMji2oTVPb0jvAK5Ii2I+kvgdQk
        tZ9cd5qEhDiKkzL1kAJtk/pV6tRl/FuI9iMBntSCXQ==
X-Google-Smtp-Source: ADFU+vuKl0l5cSfO5Cy+yKgBZm1XSTGaBWgXbflYl3a2hR5fw7Go07ECSMEPZtHP+SUIHarbwT5aqXaP0EMleeCdfQE=
X-Received: by 2002:a9d:5e8b:: with SMTP id f11mr858477otl.110.1584474384151;
 Tue, 17 Mar 2020 12:46:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200224160215.4136-1-mic@digikod.net> <CAG48ez21bEn0wL1bbmTiiu8j9jP5iEWtHOwz4tURUJ+ki0ydYw@mail.gmail.com>
 <873d7419-bdd9-8a52-0a9b-dddbe31df4f9@digikod.net> <CAG48ez0=0W5Ok-8nASqZrZ28JboXRRi3gDxV5u6mdcOtzwuRVA@mail.gmail.com>
 <688dda0f-0907-34eb-c19e-3e9e5f613a74@digikod.net>
In-Reply-To: <688dda0f-0907-34eb-c19e-3e9e5f613a74@digikod.net>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 17 Mar 2020 20:45:57 +0100
Message-ID: <CAG48ez16yT+zbK1WPxr2TnxrifW5c2DnpFLbWRRLUT_WpuFNmw@mail.gmail.com>
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

On Tue, Mar 17, 2020 at 6:50 PM Micka=C3=ABl Sala=C3=BCn <mic@digikod.net> =
wrote:
> On 17/03/2020 17:19, Jann Horn wrote:
> > On Thu, Mar 12, 2020 at 12:38 AM Micka=C3=ABl Sala=C3=BCn <mic@digikod.=
net> wrote:
> >> On 10/03/2020 00:44, Jann Horn wrote:
> >>> On Mon, Feb 24, 2020 at 5:03 PM Micka=C3=ABl Sala=C3=BCn <mic@digikod=
.net> wrote:
>
> [...]
>
> >>> Aside from those things, there is also a major correctness issue wher=
e
> >>> I'm not sure how to solve it properly:
> >>>
> >>> Let's say a process installs a filter on itself like this:
> >>>
> >>> struct landlock_attr_ruleset ruleset =3D { .handled_access_fs =3D
> >>> ACCESS_FS_ROUGHLY_WRITE};
> >>> int ruleset_fd =3D landlock(LANDLOCK_CMD_CREATE_RULESET,
> >>> LANDLOCK_OPT_CREATE_RULESET, sizeof(ruleset), &ruleset);
> >>> struct landlock_attr_path_beneath path_beneath =3D {
> >>>   .ruleset_fd =3D ruleset_fd,
> >>>   .allowed_access =3D ACCESS_FS_ROUGHLY_WRITE,
> >>>   .parent_fd =3D open("/tmp/foobar", O_PATH),
> >>> };
> >>> landlock(LANDLOCK_CMD_ADD_RULE, LANDLOCK_OPT_ADD_RULE_PATH_BENEATH,
> >>> sizeof(path_beneath), &path_beneath);
> >>> prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
> >>> struct landlock_attr_enforce attr_enforce =3D { .ruleset_fd =3D rules=
et_fd };
> >>> landlock(LANDLOCK_CMD_ENFORCE_RULESET, LANDLOCK_OPT_ENFORCE_RULESET,
> >>> sizeof(attr_enforce), &attr_enforce);
> >>>
> >>> At this point, the process is not supposed to be able to write to
> >>> anything outside /tmp/foobar, right? But what happens if the process
> >>> does the following next?
> >>>
> >>> struct landlock_attr_ruleset ruleset =3D { .handled_access_fs =3D
> >>> ACCESS_FS_ROUGHLY_WRITE};
> >>> int ruleset_fd =3D landlock(LANDLOCK_CMD_CREATE_RULESET,
> >>> LANDLOCK_OPT_CREATE_RULESET, sizeof(ruleset), &ruleset);
> >>> struct landlock_attr_path_beneath path_beneath =3D {
> >>>   .ruleset_fd =3D ruleset_fd,
> >>>   .allowed_access =3D ACCESS_FS_ROUGHLY_WRITE,
> >>>   .parent_fd =3D open("/", O_PATH),
> >>> };
> >>> landlock(LANDLOCK_CMD_ADD_RULE, LANDLOCK_OPT_ADD_RULE_PATH_BENEATH,
> >>> sizeof(path_beneath), &path_beneath);
> >>> prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
> >>> struct landlock_attr_enforce attr_enforce =3D { .ruleset_fd =3D rules=
et_fd };
> >>> landlock(LANDLOCK_CMD_ENFORCE_RULESET, LANDLOCK_OPT_ENFORCE_RULESET,
> >>> sizeof(attr_enforce), &attr_enforce);
> >>>
> >>> As far as I can tell from looking at the source, after this, you will
> >>> have write access to the entire filesystem again. I think the idea is
> >>> that LANDLOCK_CMD_ENFORCE_RULESET should only let you drop privileges=
,
> >>> not increase them, right?
> >>
> >> There is an additionnal check in syscall.c:get_path_from_fd(): it is
> >> forbidden to add a rule with a path which is not accessible (according
> >> to LANDLOCK_ACCESS_FS_OPEN) thanks to a call to security_file_open(),
> >> but this is definitely not perfect.
> >
> > Ah, I missed that.
> >
> >>> I think the easy way to fix this would be to add a bitmask to each
> >>> rule that says from which ruleset it originally comes, and then let
> >>> check_access_path() collect these bitmasks from each rule with OR, an=
d
> >>> check at the end whether the resulting bitmask is full - if not, at
> >>> least one of the rulesets did not permit the access, and it should be
> >>> denied.
> >>>
> >>> But maybe it would make more sense to change how the API works
> >>> instead, and get rid of the concept of "merging" two rulesets
> >>> together? Instead, we could make the API work like this:
> >>>
> >>>  - LANDLOCK_CMD_CREATE_RULESET gives you a file descriptor whose
> >>> ->private_data contains a pointer to the old ruleset of the process,
> >>> as well as a pointer to a new empty ruleset.
> >>>  - LANDLOCK_CMD_ADD_RULE fails if the specified rule would not be
> >>> permitted by the old ruleset, then adds the rule to the new ruleset
> >>>  - LANDLOCK_CMD_ENFORCE_RULESET fails if the old ruleset pointer in
> >>> ->private_data doesn't match the current ruleset of the process, then
> >>> replaces the old ruleset with the new ruleset.
> >>>
> >>> With this, the new ruleset is guaranteed to be a subset of the old
> >>> ruleset because each of the new ruleset's rules is permitted by the
> >>> old ruleset. (Unless the directory hierarchy rotates, but in that cas=
e
> >>> the inaccuracy isn't much worse than what would've been possible
> >>> through RCU path walk anyway AFAIK.)
> >>>
> >>> What do you think?
> >>>
> >>
> >> I would prefer to add the same checks you described at first (with
> >> check_access_path), but only when creating a new ruleset with
> >> merge_ruleset() (which should probably be renamed). This enables not t=
o
> >> rely on a parent ruleset/domain until the enforcement, which is the ca=
se
> >> anyway.
> >> Unfortunately this doesn't work for some cases with bind mounts. Becau=
se
> >> check_access_path() goes through one path, another (bind mounted) path
> >> could be illegitimately allowed.
> >
> > Hmm... I'm not sure what you mean. At the moment, landlock doesn't
> > allow any sandboxed process to change the mount hierarchy, right? Can
> > you give an example where this would go wrong?
>
> Indeed, a Landlocked process must no be able to change its mount
> namespace layout. However, bind mounts may already exist.
> Let's say a process sandbox itself to only access /a in a read-write
> way.

So, first policy:

/a RW

> Then, this process (or one of its children) add a new restriction
> on /a/b to only be able to read this hierarchy.

You mean with the second policy looking like this?

/a RW
/a/b R

Then the resulting policy would be:

/a RW policy_bitmask=3D0x00000003 (bits 0 and 1 set)
/a/b R policy_bitmask=3D0x00000002 (bit 1 set)
required_bits=3D0x00000003 (bits 0 and 1 set)

> The check at insertion
> time would allow this because this access right is a subset of the
> access right allowed with the parent directory. However, If /a/b is bind
> mounted somewhere else, let's say in /private/b, then the second
> enforcement just gave new access rights to this hierarchy too.

But with the solution I proposed, landlock's path walk would see
something like this when accessing a file at /private/b/foo:
/private/b/foo <no rules>
  policies seen until now: 0x00000000
/private/b <access: R, policy_bitmask=3D0x00000002>
  policies seen until now: 0x00000002
/private <no rules>
  policies seen until now: 0x00000002
/ <no rules>
  policies seen until now: 0x00000002

It wouldn't encounter any rule from the first policy, so the OR of the
seen policy bitmasks would be 0x00000002, which is not the required
value 0x00000003, and so the access would be denied.
