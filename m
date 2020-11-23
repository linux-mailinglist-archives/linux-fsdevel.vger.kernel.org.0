Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B2E32C14A9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Nov 2020 20:50:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729521AbgKWTol (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Nov 2020 14:44:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730584AbgKWTok (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Nov 2020 14:44:40 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3461EC061A4F
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Nov 2020 11:44:40 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id d17so25424707lfq.10
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Nov 2020 11:44:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WkkyfzYc5dkm/KIiF9W4jRT3BRx+3sqZpO+ldzSWHAU=;
        b=ucprSht07o3L8qhZLLc2Vt4PubCLLYecCKNAauQVntt/WOQx0TnUKdvhSMo4O3kPUB
         uaUTYfr9u7VuLEvtbM35aoZwakgOWHYVHjw4Mng7Nx7VrQbWv4Tt/KS5ugKh9SaGeFX2
         RVWHUO8H6oE35g5xy4ExNT0J9tz1RPg7b9HOQlsjqvp5KHt1ZdUObef9cJxmfTjtGs3e
         thKIj2KnAjmAnht0O8u+JMUIDM9eFbTD7ieYfOqhRhtEVosbjAvqv+gyPmolJ+wWqzdt
         5ZUswM45maUXB35BfcN7RSu535krwgoOUgZM4t2JGI8pMMDiwiDnaCVZppVOab7LjX70
         E/mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WkkyfzYc5dkm/KIiF9W4jRT3BRx+3sqZpO+ldzSWHAU=;
        b=rIRFleQKPrx681tzrEPbhs00vvg4ckUlftAf+R0MLIpPa3AEShO5yYqdA1bZKv68CM
         gtJernXgZZp3QRY4G4XTsGyvoEiPbZOx19SPLMPcGGFdDeWhgcdiQU3ZfpIrMf3N0G98
         iALVXWaC53F3q+DNHBx7KfgXFTMdMiTQzqCBZzmEFcAiZIQKgge7WPSvwm3oU2aiiIUp
         GfnFRkvCJMgsJrBIYi9ngw8vieaqstx7zIFTdEtiKyKkZszzlrhjGOfbNCpsVKolCEbz
         yF3Geo3751AV3GXzoD9Z+Ak/CcLAi8bCefYuTTIfLi89eZnrRH2NXUBuzlrjEaYVVADu
         tzZA==
X-Gm-Message-State: AOAM530tlnY6PpEBbAx50pl2noNGR58pI4i7JoFzYI6NvRQ0hIMdeyAW
        d7ECSOhwwhNdRaIHrOuF6IKOfPdOZjGDX2EPxITP6Q==
X-Google-Smtp-Source: ABdhPJxvAu80d98nm8DgUgnbxicof2cbnVoJUKvK4sfJq22s1FLjdXhc3R1+79TzlVPSsvuacsn9pSzptfgKcYYBWqk=
X-Received: by 2002:ac2:5a49:: with SMTP id r9mr259465lfn.381.1606160678276;
 Mon, 23 Nov 2020 11:44:38 -0800 (PST)
MIME-Version: 1.0
References: <20201112205141.775752-1-mic@digikod.net> <20201112205141.775752-8-mic@digikod.net>
 <CAG48ez3HA63CX852LLDFCcNyzRGwAr3x_cvA1-t8tgDxfF1dOQ@mail.gmail.com> <1d524ea9-85eb-049c-2156-05cad6d6fcfd@digikod.net>
In-Reply-To: <1d524ea9-85eb-049c-2156-05cad6d6fcfd@digikod.net>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 23 Nov 2020 20:44:11 +0100
Message-ID: <CAG48ez2cmsrZbUEmQmzPQugJikkvfs_MWmMizxmoyspCeXAXRQ@mail.gmail.com>
Subject: Re: [PATCH v24 07/12] landlock: Support filesystem access-control
To:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@amacapital.net>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Jeff Dike <jdike@addtoit.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Shuah Khan <shuah@kernel.org>,
        Vincent Dagonneau <vincent.dagonneau@ssi.gouv.fr>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Nov 21, 2020 at 11:06 AM Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>=
 wrote:
> On 21/11/2020 08:00, Jann Horn wrote:
> > On Thu, Nov 12, 2020 at 9:52 PM Micka=C3=ABl Sala=C3=BCn <mic@digikod.n=
et> wrote:
> >> Thanks to the Landlock objects and ruleset, it is possible to identify
> >> inodes according to a process's domain.  To enable an unprivileged
> >> process to express a file hierarchy, it first needs to open a director=
y
> >> (or a file) and pass this file descriptor to the kernel through
> >> landlock_add_rule(2).  When checking if a file access request is
> >> allowed, we walk from the requested dentry to the real root, following
> >> the different mount layers.  The access to each "tagged" inodes are
> >> collected according to their rule layer level, and ANDed to create
> >> access to the requested file hierarchy.  This makes possible to identi=
fy
> >> a lot of files without tagging every inodes nor modifying the
> >> filesystem, while still following the view and understanding the user
> >> has from the filesystem.
> >>
> >> Add a new ARCH_EPHEMERAL_INODES for UML because it currently does not
> >> keep the same struct inodes for the same inodes whereas these inodes a=
re
> >> in use.
> >>
> >> This commit adds a minimal set of supported filesystem access-control
> >> which doesn't enable to restrict all file-related actions.  This is th=
e
> >> result of multiple discussions to minimize the code of Landlock to eas=
e
> >> review.  Thanks to the Landlock design, extending this access-control
> >> without breaking user space will not be a problem.  Moreover, seccomp
> >> filters can be used to restrict the use of syscall families which may
> >> not be currently handled by Landlock.
> >>
> >> Cc: Al Viro <viro@zeniv.linux.org.uk>
> >> Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
> >> Cc: James Morris <jmorris@namei.org>
> >> Cc: Jann Horn <jannh@google.com>
> >> Cc: Jeff Dike <jdike@addtoit.com>
> >> Cc: Kees Cook <keescook@chromium.org>
> >> Cc: Richard Weinberger <richard@nod.at>
> >> Cc: Serge E. Hallyn <serge@hallyn.com>
> >> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@linux.microsoft.com>
> >> ---
> >>
> >> Changes since v23:
> >> * Enforce deterministic interleaved path rules.  To have consistent
> >>   layered rules, granting access to a path implies that all accesses
> >>   tied to inodes, from the requested file to the real root, must be
> >>   checked.  Otherwise, stacked rules may result to overzealous
> >>   restrictions.  By excluding the ability to add exceptions in the sam=
e
> >>   layer (e.g. /a allowed, /a/b denied, and /a/b/c allowed), we get
> >>   deterministic interleaved path rules.  This removes an optimization
> >
> > I don't understand the "deterministic interleaved path rules" part.
>
> I explain bellow.
>
> >
> >
> > What if I have a policy like this?
> >
> > /home/user READ
> > /home/user/Downloads READ+WRITE
> >
> > That's a reasonable policy, right?
>
> Definitely, I forgot this, thanks for the outside perspective!
>
> >
> > If I then try to open /home/user/Downloads/foo in WRITE mode, the loop
> > will first check against the READ+WRITE rule for /home/user, that
> > check will pass, and then it will check against the READ rule for /,
> > which will deny the access, right? That seems bad.
>
> Yes that was the intent.
>
> >
> >
> > The v22 code ensured that for each layer, the most specific rule (the
> > first we encounter on the walk) always wins, right? What's the problem
> > with that?
>
> This can be explained with the interleaved_masked_accesses test:
> https://github.com/landlock-lsm/linux/blob/landlock-v24/tools/testing/sel=
ftests/landlock/fs_test.c#L647
>
> In this case there is 4 stacked layers:
> layer 1: allows s1d1/s1d2/s1d3/file1
> layer 2: allows s1d1/s1d2/s1d3
>          denies s1d1/s1d2
> layer 3: allows s1d1
> layer 4: allows s1d1/s1d2
>
> In the v23, access to file1 would be allowed until layer 3, but layer 4
> would merge a new rule for the s1d2 inode. Because we don't record where
> exactly the access come from, we can't tell that layer 2 allowed access
> thanks to s1d3 and that its s1d2 rule was ignored. I think this behavior
> doesn't make sense from the user point of view.

Aah, I think I'm starting to understand the issue now. Basically, with
the current UAPI, the semantics have to be "an access is permitted if,
for each policy layer, at least one rule encountered on the pathwalk
permits the access; rules that deny the access are irrelevant". And if
it turns out that someone needs to be able to deny access to specific
inodes, we'll have to extend struct landlock_path_beneath_attr.

That reminds me... if we do need to make such a change in the future,
it would be easier in terms of UAPI compatibility if
landlock_add_rule() used copy_struct_from_user(), which is designed to
create backwards and forwards compatibility with other version of UAPI
headers. So adding that now might save us some headaches later.


> In the v24, access to file1 would only be allowed with layer 1. The
> layer 2, would deny access to file1 because of the s1d2 rule. This makes
> the reasoning consistent and deterministic whatever the layers are,
> while storing the same access and layer bits. But I agree that this may
> not be desirable.
>
> In a perfect v25, file1 should be allowed by all these layers. I didn't
> find a simple solution to this while minimizing the memory allocated by
> rule (cf. struct landlock_rule: mainly 32-bits for access rights and
> 64-bits for the layers that contributed to this ANDed accesses). I would
> like to avoid storing 32-bits access rights per stacked layer. Do you
> see another solution?

I don't think you can avoid storing the access rights per layer unless
you actually merge the layers when setting up the ruleset (which would
be messy). But I don't think that's a big problem. A straightforward
implementation might become inefficient if you stack too many policy
layers, but I don't think that's a problem for an initial
implementation - the common usecase is probably going to be a single
layer, or maybe two, or something like that?

If you had a ton of layers, most of them would likely specify the same
access permissions - so one possible optimization might be to use the
current representation if all rules matching the inode specify the
same permissions, and use a different representation otherwise. But I
don't think such an optimization is necessary at this point.
