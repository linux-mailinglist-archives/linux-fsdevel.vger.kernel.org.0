Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB3F345D941
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Nov 2021 12:31:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231985AbhKYLe4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Nov 2021 06:34:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234686AbhKYLcz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Nov 2021 06:32:55 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3FA0C0619EE
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Nov 2021 03:23:14 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id t23so11932209oiw.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Nov 2021 03:23:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k33uva8py5s2sQ2S/wXwTEnMmE00okSQ3bv6VjoGK/4=;
        b=GLOggkqDbW8ICV/aUCEEyyyIRNpaJZt/3arlFFqeMmeU3gh4AAMlHftDeh8MWx1B2F
         jHPI2u76GirnHEYSl7USl12A3ctGfWQTYJhY7fF0yhumtDNLlgDsWSn8uGNcQ7cBP1ZX
         0RDKy0cPxtzKLCGtU35KJ5ndDLBSt3psyMOxAxg98lyq+V1GgSgQoF3Z8a+P18SH2f2f
         CIStmSXG3kLufY3OEz/YYmHmX+Dkgz9aRasqAn2ID82nOUEsVVobKbZfJq0MPajbYMo1
         CKJQzTa4QCZ7ckDDLZBMGn0wIdywTxSeqngh9LPXCv9Z3FQJvE7p4pS4AIb0lu6TziEN
         NLwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k33uva8py5s2sQ2S/wXwTEnMmE00okSQ3bv6VjoGK/4=;
        b=1A5UcqIo3YugkZZhYz5nh3MXVAoigCa1if4+iaUz+5TMqXNebN0PgrsGU1ZbD7KGC9
         HKd6GDQzRiQ9vRE1V+8MnBvTTIk8R0Juh2DC+OrrK6v/9eUjIzHVAbgHDhn/S905ShMv
         1JNrtwaqbqIKWH3U5cf53NLVpsT9CX2tjan7janRB4ELcYL1MTmMIMDgoXqAkuVHM1pi
         05vNyjY/aDfQj2IlbAHiZaajG+Ndc05unC1KiD25a/pbyRrx07d3Gfk4HlWvSAOvZHkx
         4jzDxXLikjnpYtzqLONrKMiiFC4gZDnNj3PZNJ3vwwe8FF2rteNpTtaAgPzyWulcYA+U
         DrNA==
X-Gm-Message-State: AOAM533d7uPJmnb8dAOtQWJ9NV2fIvnHBUceC3ZW66q9ETxda77giEuR
        LK8ZXQl7l7mdEdoExi/hvvb5CJWrdRfY0Rsqbt54pAkZ1J7+hw==
X-Google-Smtp-Source: ABdhPJznmS+DCdkfV67Q90sseiY8351bIVaeUAxLKuYAbuidYb6JUYEPLjjFbAaRquWAUiOqrjr+7KdtQeS+ptMNNLw=
X-Received: by 2002:a05:6808:ec9:: with SMTP id q9mr14497632oiv.160.1637839393932;
 Thu, 25 Nov 2021 03:23:13 -0800 (PST)
MIME-Version: 1.0
References: <000000000000c93bd505bf3646ed@google.com> <00000000000006b5b205d0f55d49@google.com>
 <CAJfpegtASmSmbNakuCYcgaF0Cy8kY=wu-w9_imiJnsCJngnR=A@mail.gmail.com>
In-Reply-To: <CAJfpegtASmSmbNakuCYcgaF0Cy8kY=wu-w9_imiJnsCJngnR=A@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 25 Nov 2021 12:23:02 +0100
Message-ID: <CACT4Y+bJ4Ap74hBOBg7WMNDvhkjE2soD4MZ267gGP11G6s7Dsw@mail.gmail.com>
Subject: Re: [syzbot] WARNING in inc_nlink (2)
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     syzbot <syzbot+1c8034b9f0e640f9ba45@syzkaller.appspotmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Miklos Szeredi <mszeredi@redhat.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 17 Nov 2021 at 08:25, Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> On Wed, 17 Nov 2021 at 06:32, syzbot
> <syzbot+1c8034b9f0e640f9ba45@syzkaller.appspotmail.com> wrote:
> >
> > syzbot suspects this issue was fixed by commit:
> >
> > commit 97f044f690bac2b094bfb7fb2d177ef946c85880
> > Author: Miklos Szeredi <mszeredi@redhat.com>
> > Date:   Fri Oct 22 15:03:02 2021 +0000
> >
> >     fuse: don't increment nlink in link()
> >
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10563ac9b00000
> > start commit:   1da38549dd64 Merge tag 'nfsd-5.15-3' of git://git.kernel.o..
> > git tree:       upstream
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=e2ffb281e6323643
> > dashboard link: https://syzkaller.appspot.com/bug?extid=1c8034b9f0e640f9ba45
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11f16d57300000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15758d57300000
> >
> > If the result looks correct, please mark the issue as fixed by replying with:
>
> Highly unlikely: the original report was for sysvfs and the fix is for fuse.

Hi Miklos,

The fuse bug was folded into this report (on the dashboard you can see
examples of reports in fuse).
This is unavoidable for bugs that are left unaddressed for long. They
become piles of assorted stuff.

Now the best course of action is to mark it as fixed. Or we will
exacerbate the problem even more: it will be a bug about sysvfs, this
fuse bug, and the next similar bug in fuse and bugs in other file
systems.

#syz fix: fuse: don't increment nlink in link()
