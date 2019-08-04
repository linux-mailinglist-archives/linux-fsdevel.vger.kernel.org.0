Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B39D780F7D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2019 01:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbfHDX4O (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 4 Aug 2019 19:56:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:51988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726822AbfHDX4N (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 4 Aug 2019 19:56:13 -0400
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C65BF2182B
        for <linux-fsdevel@vger.kernel.org>; Sun,  4 Aug 2019 23:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564962973;
        bh=hacK3bFBwtrAv/U9OhwzLwLEIvnI+bjiQ7pJZVwvUsc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HE6lxrmjjgnSG6WMJBYy7hwTcselKZPNXoRvcHYGTFNp3d++lIEJWhIZhGyVTS0ij
         H5FuIRXvlb9WQVf0AEMhzx6VdSK1wG/sCITYb3PR/VuWOOcW49nSAPUIywi/xC3Yyi
         uwJfifblUxcnxoOJG8iVwLXlt2VK74AOKZDUbEtI=
Received: by mail-wr1-f49.google.com with SMTP id y4so82575670wrm.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 04 Aug 2019 16:56:12 -0700 (PDT)
X-Gm-Message-State: APjAAAXPqVrsurBuDn5HGEFNZIObO9MHK8mhU5rITfsceCttbSiLJblY
        GhnShQK0RwAGZr/Dl9vPJcoA4Qlb80VIOlo3osU+eA==
X-Google-Smtp-Source: APXvYqxn3tZqaoihIH7prfCxvRtZSNWX//uET+sc6tDLm69XbTAHCOuntBreYunR4c+HxPSsMOCqCHJjQE50/g3L7Sc=
X-Received: by 2002:adf:dd0f:: with SMTP id a15mr3574634wrm.265.1564962969300;
 Sun, 04 Aug 2019 16:56:09 -0700 (PDT)
MIME-Version: 1.0
References: <20181212081712.32347-1-mic@digikod.net> <20181212081712.32347-2-mic@digikod.net>
 <20181212144306.GA19945@quack2.suse.cz>
In-Reply-To: <20181212144306.GA19945@quack2.suse.cz>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sun, 4 Aug 2019 16:55:58 -0700
X-Gmail-Original-Message-ID: <CALCETrVeZ0eufFXwfhtaG_j+AdvbzEWE0M3wjXMWVEO7pj+xkw@mail.gmail.com>
Message-ID: <CALCETrVeZ0eufFXwfhtaG_j+AdvbzEWE0M3wjXMWVEO7pj+xkw@mail.gmail.com>
Subject: Re: [RFC PATCH v1 1/5] fs: Add support for an O_MAYEXEC flag on sys_open()
To:     Jan Kara <jack@suse.cz>, Song Liu <songliubraving@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        James Morris <jmorris@namei.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Matthew Garrett <mjg59@google.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mickael.salaun@ssi.gouv.fr>,
        Mimi Zohar <zohar@linux.ibm.com>,
        =?UTF-8?Q?Philippe_Tr=C3=A9buchet?= 
        <philippe.trebuchet@ssi.gouv.fr>, Shuah Khan <shuah@kernel.org>,
        Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>,
        Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
        Yves-Alexis Perez <yves-alexis.perez@ssi.gouv.fr>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 12, 2018 at 6:43 AM Jan Kara <jack@suse.cz> wrote:
>
> On Wed 12-12-18 09:17:08, Micka=C3=ABl Sala=C3=BCn wrote:
> > When the O_MAYEXEC flag is passed, sys_open() may be subject to
> > additional restrictions depending on a security policy implemented by a=
n
> > LSM through the inode_permission hook.
> >
> > The underlying idea is to be able to restrict scripts interpretation
> > according to a policy defined by the system administrator.  For this to
> > be possible, script interpreters must use the O_MAYEXEC flag
> > appropriately.  To be fully effective, these interpreters also need to
> > handle the other ways to execute code (for which the kernel can't help)=
:
> > command line parameters (e.g., option -e for Perl), module loading
> > (e.g., option -m for Python), stdin, file sourcing, environment
> > variables, configuration files...  According to the threat model, it ma=
y
> > be acceptable to allow some script interpreters (e.g. Bash) to interpre=
t
> > commands from stdin, may it be a TTY or a pipe, because it may not be
> > enough to (directly) perform syscalls.
> >
> > A simple security policy implementation is available in a following
> > patch for Yama.
> >
> > This is an updated subset of the patch initially written by Vincent
> > Strubel for CLIP OS:
> > https://github.com/clipos-archive/src_platform_clip-patches/blob/f5cb33=
0d6b684752e403b4e41b39f7004d88e561/1901_open_mayexec.patch
> > This patch has been used for more than 10 years with customized script
> > interpreters.  Some examples can be found here:
> > https://github.com/clipos-archive/clipos4_portage-overlay/search?q=3DO_=
MAYEXEC
> >
> > Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> > Signed-off-by: Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>
> > Signed-off-by: Vincent Strubel <vincent.strubel@ssi.gouv.fr>
> > Reviewed-by: Philippe Tr=C3=A9buchet <philippe.trebuchet@ssi.gouv.fr>
> > Cc: Al Viro <viro@zeniv.linux.org.uk>
> > Cc: Kees Cook <keescook@chromium.org>
> > Cc: Micka=C3=ABl Sala=C3=BCn <mickael.salaun@ssi.gouv.fr>
>
> ...
>
> > diff --git a/fs/open.c b/fs/open.c
> > index 0285ce7dbd51..75479b79a58f 100644
> > --- a/fs/open.c
> > +++ b/fs/open.c
> > @@ -974,6 +974,10 @@ static inline int build_open_flags(int flags, umod=
e_t mode, struct open_flags *o
> >       if (flags & O_APPEND)
> >               acc_mode |=3D MAY_APPEND;
> >
> > +     /* Check execution permissions on open. */
> > +     if (flags & O_MAYEXEC)
> > +             acc_mode |=3D MAY_OPENEXEC;
> > +
> >       op->acc_mode =3D acc_mode;
> >
> >       op->intent =3D flags & O_PATH ? 0 : LOOKUP_OPEN;
>
> I don't feel experienced enough in security to tell whether we want this
> functionality or not. But if we do this, shouldn't we also set FMODE_EXEC
> on the resulting struct file? That way also security_file_open() can be
> used to arbitrate such executable opens and in particular
> fanotify permission event FAN_OPEN_EXEC will get properly generated which=
 I
> guess is desirable (support for it is sitting in my tree waiting for the
> merge window) - adding some audit people involved in FAN_OPEN_EXEC to
> CC. Just an idea...
>

I would really like to land this patch.  I'm fiddling with making
bpffs handle permissions intelligently, and the lack of a way to say
"hey, I want to open this bpf program so that I can run it" is
annoying.

--Andy
