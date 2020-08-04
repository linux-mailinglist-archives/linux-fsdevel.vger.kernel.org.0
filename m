Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44B4623C238
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Aug 2020 01:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbgHDXev (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Aug 2020 19:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726011AbgHDXet (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Aug 2020 19:34:49 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82102C061756
        for <linux-fsdevel@vger.kernel.org>; Tue,  4 Aug 2020 16:34:49 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id k23so43996734iom.10
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Aug 2020 16:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vGGF1J+ERy5X4cdVoozyTYTiQ8qrIwcki9GpVzuiAac=;
        b=S49gs35wchf/23S3uxZ+WP+evpMxe77HR56i82lZK5NggPBf9C072uwY/MRzBWTJUT
         uUkbo0r79QLmayMwJRaE7WWdaAvmRYlCw8pmFEetEeImITMz5f2Ch0y9KoVwOU84XUKz
         akVPWCRo77xUXadUti0PP1Cp9LhmUXz8zP6Tik+uyWkZVOMUlb+rhvvUm/6QBHvpcVS0
         GbmAXJIh2pl/ZVu288keExqTOg9TgMKZO8x3TMPp2xYJUgXnTLSFljth/xgJZ3DD5T48
         e4WzIsHdU67WlRmMsL0A8ZT3iW5ad5SKqWVlzhjuJoaQoFUlkcMv2avPx8JFFaR/UBv0
         8iuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vGGF1J+ERy5X4cdVoozyTYTiQ8qrIwcki9GpVzuiAac=;
        b=Dz49ul0yWYTsHe+4lIuoySHvs9qjpaCy9y2pjE7PvA/yXfaOR/ttnruaDj39rvXMk5
         jGPkxiaNS4YaeIKZ+6v9HRd+mj6EZkASL4lfhfKLziHsGvTuM5wWylLlD3qIw6+1OZcZ
         FBbV+XjOIhL3M+dv6pO8+8KN5kei7rpOsu5IcsgJwieeVvjhM46St/kovVvsywtsUv1i
         EePVux7pQvv1O1V7n5FS2zfDHszfzUucLlKBzCQfImv9tihJQ/CMVWD7cIjdJBwC528/
         Q/1Oa1ywBdaRUIwJP1ZuTC/bErSn7+xjaRI4lnSkFU35hpqzlp0vqQQlujfWTBIr0OG3
         /BXg==
X-Gm-Message-State: AOAM530c3ox+8GOchCgtUQfoSlMVKr21yMFqYCJYDMiZuXpd5xfOHCjM
        Uoaujfpl11p52teCQdWLNvnYPY3dcC7VEeCQkj+qjA==
X-Google-Smtp-Source: ABdhPJxWwj+mGIKejG+Y+aEk2jXUwSEzd/PT3OCVEnMiGbJ2xhGfjVDUJ/Wp8D4RrKrlxyXIqKF7qjPbHA/qTDTnUZs=
X-Received: by 2002:a5d:824f:: with SMTP id n15mr405195ioo.95.1596584088451;
 Tue, 04 Aug 2020 16:34:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200804203155.2181099-1-lokeshgidra@google.com>
 <20200804204543.GA1992048@gmail.com> <CA+EESO6XGpiTLnxPraZqBigY7mh6G2jkHa2PKXaHXpzdrZd4wA@mail.gmail.com>
 <20200804205846.GB1992048@gmail.com>
In-Reply-To: <20200804205846.GB1992048@gmail.com>
From:   Lokesh Gidra <lokeshgidra@google.com>
Date:   Tue, 4 Aug 2020 16:34:37 -0700
Message-ID: <CA+EESO7EtZSHmVTMJ53sHMUfrt0E8G7ywBZpYjh1f+oDpjW8=w@mail.gmail.com>
Subject: Re: [PATCH] Userfaultfd: Avoid double free of userfault_ctx and
 remove O_CLOEXEC
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        casey@schaufler-ca.com, James Morris <jmorris@namei.org>,
        Kalesh Singh <kaleshsingh@google.com>,
        Daniel Colascione <dancol@dancol.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Nick Kralevich <nnk@google.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Calin Juravle <calin@google.com>, kernel-team@android.com,
        yanfei.xu@windriver.com,
        syzbot+75867c44841cb6373570@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 4, 2020 at 1:58 PM Eric Biggers <ebiggers@kernel.org> wrote:
>
> On Tue, Aug 04, 2020 at 01:49:30PM -0700, Lokesh Gidra wrote:
> > On Tue, Aug 4, 2020 at 1:45 PM Eric Biggers <ebiggers@kernel.org> wrote:
> > >
> > > On Tue, Aug 04, 2020 at 01:31:55PM -0700, Lokesh Gidra wrote:
> > > > when get_unused_fd_flags returns error, ctx will be freed by
> > > > userfaultfd's release function, which is indirectly called by fput().
> > > > Also, if anon_inode_getfile_secure() returns an error, then
> > > > userfaultfd_ctx_put() is called, which calls mmdrop() and frees ctx.
> > > >
> > > > Also, the O_CLOEXEC was inadvertently added to the call to
> > > > get_unused_fd_flags() [1].
> > > >
> > > > Adding Al Viro's suggested-by, based on [2].
> > > >
> > > > [1] https://lore.kernel.org/lkml/1f69c0ab-5791-974f-8bc0-3997ab1d61ea@dancol.org/
> > > > [2] https://lore.kernel.org/lkml/20200719165746.GJ2786714@ZenIV.linux.org.uk/
> > > >
> > > > Fixes: d08ac70b1e0d (Wire UFFD up to SELinux)
> > > > Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
> > > > Reported-by: syzbot+75867c44841cb6373570@syzkaller.appspotmail.com
> > > > Signed-off-by: Lokesh Gidra <lokeshgidra@google.com>
> > >
> > > What branch does this patch apply to?  Neither mainline nor linux-next works.
> > >
> > On James Morris' tree (secure_uffd_v5.9 branch).
> >
>
> For those of us not "in the know", that apparently means branch secure_uffd_v5.9
> of https://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git
>
> Perhaps it would make more sense to resend your original patch series with this
> fix folded in?
>
OK. I'll resend the whole patch series with the fixes soon.

> > diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> > index ae859161908f..e15eb8fdc083 100644
> > --- a/fs/userfaultfd.c
> > +++ b/fs/userfaultfd.c
> > @@ -2042,24 +2042,18 @@ SYSCALL_DEFINE1(userfaultfd, int, flags)
> >               O_RDWR | (flags & UFFD_SHARED_FCNTL_FLAGS),
> >               NULL);
> >       if (IS_ERR(file)) {
> > -             fd = PTR_ERR(file);
> > -             goto out;
> > +             userfaultfd_ctx_put(ctx);
> > +             return PTR_ERR(file);
> >       }
> >
> > -     fd = get_unused_fd_flags(O_RDONLY | O_CLOEXEC);
> > +     fd = get_unused_fd_flags(O_RDONLY);
> >       if (fd < 0) {
> >               fput(file);
> > -             goto out;
> > +             return fd;
> >       }
> >
> >       ctx->owner = file_inode(file);
> >       fd_install(fd, file);
> > -
> > -out:
> > -     if (fd < 0) {
> > -             mmdrop(ctx->mm);
> > -             kmem_cache_free(userfaultfd_ctx_cachep, ctx);
> > -     }
> >       return fd;
>
> This introduces the opposite bug: now it's hardcoded to *not* use O_CLOEXEC,
> instead of using the flag the user passed in the flags argument to the syscall.

I get your point. I agree the flags passed in to the syscall should be used.
>
> - Eric
