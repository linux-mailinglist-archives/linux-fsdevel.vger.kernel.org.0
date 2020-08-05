Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D674E23C4CB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Aug 2020 06:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbgHEEyS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Aug 2020 00:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726056AbgHEEyQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Aug 2020 00:54:16 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C35EBC061756
        for <linux-fsdevel@vger.kernel.org>; Tue,  4 Aug 2020 21:54:15 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id j9so32866359ilc.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Aug 2020 21:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NWo03ksp49RFL4JmDzwg1K5bhOAK4XGZLQniw/219G8=;
        b=E81rywuv5jgi+eBdLbYbwYDvs4S2czenFZvhB1YC1y/NftdIsFgVUA1ZK/wfI8Jxj7
         xMYUePEk5sVOqPfniR68qjURFNzRoMrGSoE5dSgOUmNJwrGcAyypBKlA6AmZA8KLsTIg
         wAPFQug2Ys9nENpQZ3ggfwyjSOCw+I/+q3smVA66LCDzfkN9Yq3yx2A6OGzcXh6mps23
         1l7s7ApF1guhJE7KxDtu42Dt+DLOCA3J8fkUaRPyXAuY43Q1DWwg5hTiwcoQf8ng6AFk
         8nzH05HEs0ud7F6dwzX1qsgr1rxkVMC+HFsC4rYWaZ/H8SwfUlPJwsCbpsOC5Mm0oVDv
         LPWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NWo03ksp49RFL4JmDzwg1K5bhOAK4XGZLQniw/219G8=;
        b=NrsXxd6+Gz/y57KaqUpLOCsZE9eZe1+K5QwtRurNtOmXFEr6g55U3/RkitUONzLDhF
         ZbyARLI81Nt/uQ7rQ08n+Ytp/qN+nj4b5q60/jOrCxcNIifh5iK9ED76/H3BhopNm++e
         Rrx4tffkWFuY9Rw+8Lcuvvt9uLiA0HNjN58vdSCREQwflpZBR3LG8UMptHU09EJBVqGL
         IGaGnDj3k8UbFlTHagrzfyT0dESqZvHn56kdwmtInt4VxjA6PKGZ0izH2x+eqluW1e2I
         x1J+4nsIJLYX8ycU0T55/kW0VloGvZrySU3Wdo7CqHChrlbCk7u1lyLHzQAIKSQ2GC6m
         Tdsw==
X-Gm-Message-State: AOAM533b10+XTqMNgKakbCjwjcGBq4M6j0i7GPthGlybEdI3dslwpUHt
        KBmbG0GxQHg7KMJu9iQ9KU5ms3/kz+Lunp/ljp55MA==
X-Google-Smtp-Source: ABdhPJz5MeslcA4Sik6ZMi6cw+tVlvFZuDre6Q9opHEXM/cGMG+OCYbcl2xE9BruElI6JfBmumJtPWPdmjALO/LCbQI=
X-Received: by 2002:a92:c0c3:: with SMTP id t3mr2167405ilf.47.1596603254968;
 Tue, 04 Aug 2020 21:54:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200804203155.2181099-1-lokeshgidra@google.com>
 <20200805034758.lrobunwdcqtknsvz@yavin.dot.cyphar.com> <20200805040806.GB1136@sol.localdomain>
In-Reply-To: <20200805040806.GB1136@sol.localdomain>
From:   Lokesh Gidra <lokeshgidra@google.com>
Date:   Tue, 4 Aug 2020 21:54:03 -0700
Message-ID: <CA+EESO6hds3EJY-MWKiG3tRJfJnyTr4Y_v9+hu5zU1=jiQ_xmQ@mail.gmail.com>
Subject: Re: [PATCH] Userfaultfd: Avoid double free of userfault_ctx and
 remove O_CLOEXEC
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Aleksa Sarai <cyphar@cyphar.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
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

On Tue, Aug 4, 2020 at 9:08 PM Eric Biggers <ebiggers@kernel.org> wrote:
>
> On Wed, Aug 05, 2020 at 01:47:58PM +1000, Aleksa Sarai wrote:
> > On 2020-08-04, Lokesh Gidra <lokeshgidra@google.com> wrote:
> > > when get_unused_fd_flags returns error, ctx will be freed by
> > > userfaultfd's release function, which is indirectly called by fput().
> > > Also, if anon_inode_getfile_secure() returns an error, then
> > > userfaultfd_ctx_put() is called, which calls mmdrop() and frees ctx.
> > >
> > > Also, the O_CLOEXEC was inadvertently added to the call to
> > > get_unused_fd_flags() [1].
> >
> > I disagree that it is "wrong" to do O_CLOEXEC-by-default (after all,
> > it's trivial to disable O_CLOEXEC, but it's non-trivial to enable it on
> > an existing file descriptor because it's possible for another thread to
> > exec() before you set the flag). Several new syscalls and fd-returning
> > facilities are O_CLOEXEC-by-default now (the most obvious being pidfds
> > and seccomp notifier fds).
>
> Sure, O_CLOEXEC *should* be the default, but this is an existing syscall so it
> has to keep the existing behavior.
>
> > At the very least there should be a new flag added that sets O_CLOEXEC.
>
> There already is one (but these patches broke it).
>
I looked at the existing implementation, and the right thing is to
pass on the 'flags' (that is passed in to the syscall) to fetch 'fd'.

Besides, as you said in the other email thread,
anon_inode_getfile_secure() should be replaced with
anon_inode_getfd_secure(), which will remove this ambiguity.

I'll resend the patch series soon with all the changes that you proposed.
> - Eric
