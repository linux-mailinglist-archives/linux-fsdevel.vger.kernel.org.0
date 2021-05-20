Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85E8B38B11C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 May 2021 16:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243636AbhETOKf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 May 2021 10:10:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31480 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243776AbhETOJf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 May 2021 10:09:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621519694;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=It7btjJ0p3Yc2h3EMcw3zPNhica8EKGBJRqOiDF2YA8=;
        b=JGTrc2686UD91BD29aCQTHoob1EIJG4SjNsjYTSeTvghFphZyVlcZCtMw1nKoRJNO81IPi
        oFKEfOJrvaguFR863Mw/tUlNN4MHz5tliQrb5igEBWBAepv/aPX5QynEXnkPCvRMvCuF9x
        hSvfy35RG+xe/w2hd9iskBxbISVYX8o=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-16-FBhu774sPKaiTuYLO1Iavg-1; Thu, 20 May 2021 10:08:09 -0400
X-MC-Unique: FBhu774sPKaiTuYLO1Iavg-1
Received: by mail-wm1-f70.google.com with SMTP id g9-20020a1c39090000b029017545f2da89so2140800wma.8
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 May 2021 07:08:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=It7btjJ0p3Yc2h3EMcw3zPNhica8EKGBJRqOiDF2YA8=;
        b=nd8yqECcnBpMqINUUaESy06jQiVDOaY71JRt4ugUWdsbKRONSpY3sZEVGIQBFG2031
         Hax+fu2vHceDFDo1ymuZpSRhwEdKOpzektQxq1AdnPcz2UqZbeDoKX2yoQbpBFwcmThN
         ZLWj1+jb9x537Xp9EFIKJqOBVeTrJKa9vLfkYPQA+QmWaJ76Hx6Dql3pkVMz7YWPz+RM
         yBaIaVkXIpkJf/mOZzao+/2TDFSrHUlqT5AMh4OMFirZ6axXuoxXGjvCYzFPXIej9nAY
         8yLuuZ85QDGrfn/5EUkspP+TM38g7dC3DIt/Ks54szYM3t++NlTTz0QFTAq50HK/A1am
         u/eg==
X-Gm-Message-State: AOAM533hQTUp75Wwqr6ls/Yvk8B+aIJoiVyJgsr3eGlPd9Sddk9C92oj
        V/yVthWzaWijGVbQx/5DvlJC2PbWZ5/IPKFkQwg+0ydnhu03CL92KmQ1Vdk/PoOD8JIXiR9ymVr
        B+YRz+JLbu/3TO3yJQiflT88Z0dEPl+dpf0vUxdFneg==
X-Received: by 2002:adf:f54b:: with SMTP id j11mr4244091wrp.376.1621519688379;
        Thu, 20 May 2021 07:08:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJynUwLFZ6h5RolD2UQb7WF4s79K47EEkXJZu1PY0ld5PYQtlKR2A/3xR2UsNW2/X99LMni/DqLrlJC+9YY0p8E=
X-Received: by 2002:adf:f54b:: with SMTP id j11mr4244068wrp.376.1621519688151;
 Thu, 20 May 2021 07:08:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210520122536.1596602-1-agruenba@redhat.com> <20210520122536.1596602-7-agruenba@redhat.com>
 <20210520133015.GC18952@quack2.suse.cz>
In-Reply-To: <20210520133015.GC18952@quack2.suse.cz>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Thu, 20 May 2021 16:07:56 +0200
Message-ID: <CAHc6FU7ESASp+G59d218LekK8+YMBvH9GxbPr-qOVBhzyVmq4Q@mail.gmail.com>
Subject: Re: [PATCH 6/6] gfs2: Fix mmap + page fault deadlocks (part 2)
To:     Jan Kara <jack@suse.cz>, Andy Lutomirski <luto@kernel.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        cluster-devel <cluster-devel@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 20, 2021 at 3:30 PM Jan Kara <jack@suse.cz> wrote:
> On Thu 20-05-21 14:25:36, Andreas Gruenbacher wrote:
> > Now that we handle self-recursion on the inode glock in gfs2_fault and
> > gfs2_page_mkwrite, we need to take care of more complex deadlock
> > scenarios like the following (example by Jan Kara):
> >
> > Two independent processes P1, P2. Two files F1, F2, and two mappings M1,
> > M2 where M1 is a mapping of F1, M2 is a mapping of F2. Now P1 does DIO
> > to F1 with M2 as a buffer, P2 does DIO to F2 with M1 as a buffer. They
> > can race like:
> >
> > P1                                      P2
> > read()                                  read()
> >   gfs2_file_read_iter()                   gfs2_file_read_iter()
> >     gfs2_file_direct_read()                 gfs2_file_direct_read()
> >       locks glock of F1                       locks glock of F2
> >       iomap_dio_rw()                          iomap_dio_rw()
> >         bio_iov_iter_get_pages()                bio_iov_iter_get_pages()
> >           <fault in M2>                           <fault in M1>
> >             gfs2_fault()                            gfs2_fault()
> >               tries to grab glock of F2               tries to grab glock of F1
> >
> > Those kinds of scenarios are much harder to reproduce than
> > self-recursion.
> >
> > We deal with such situations by using the LM_FLAG_OUTER flag to mark
> > "outer" glock taking.  Then, when taking an "inner" glock, we use the
> > LM_FLAG_TRY flag so that locking attempts that don't immediately succeed
> > will be aborted.  In case of a failed locking attempt, we "unroll" to
> > where the "outer" glock was taken, drop the "outer" glock, and fault in
> > the first offending user page.  This will re-trigger the "inner" locking
> > attempt but without the LM_FLAG_TRY flag.  Once that has happened, we
> > re-acquire the "outer" glock and retry the original operation.
> >
> > Reported-by: Jan Kara <jack@suse.cz>
> > Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
>
> ...
>
> > diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
> > index 7d88abb4629b..8b26893f8dc6 100644
> > --- a/fs/gfs2/file.c
> > +++ b/fs/gfs2/file.c
> > @@ -431,21 +431,30 @@ static vm_fault_t gfs2_page_mkwrite(struct vm_fault *vmf)
> >       vm_fault_t ret = VM_FAULT_LOCKED;
> >       struct gfs2_holder gh;
> >       unsigned int length;
> > +     u16 flags = 0;
> >       loff_t size;
> >       int err;
> >
> >       sb_start_pagefault(inode->i_sb);
> >
> > -     gfs2_holder_init(ip->i_gl, LM_ST_EXCLUSIVE, 0, &gh);
> > +     if (current_holds_glock())
> > +             flags |= LM_FLAG_TRY;
> > +
> > +     gfs2_holder_init(ip->i_gl, LM_ST_EXCLUSIVE, flags, &gh);
> >       if (likely(!outer_gh)) {
> >               err = gfs2_glock_nq(&gh);
> >               if (err) {
> >                       ret = block_page_mkwrite_return(err);
> > +                     if (err == GLR_TRYFAILED) {
> > +                             set_current_needs_retry(true);
> > +                             ret = VM_FAULT_SIGBUS;
> > +                     }
>
> I've checked to make sure but do_user_addr_fault() indeed calls do_sigbus()
> which raises the SIGBUS signal. So if the application does not ignore
> SIGBUS, your retry will be visible to the application and can cause all
> sorts of interesting results...

I would have noticed that, but no SIGBUS signals were actually
delivered. So we probably end up in kernelmode_fixup_or_oops() when in
kernel mode, which just does nothing in that case.

Andy Lutomirski, you've been involved with this, could you please shed
some light?

> So you probably need to add a new VM_FAULT_
> return code that will behave like VM_FAULT_SIGBUS except it will not raise
> the signal.

A new VM_FAULT_* flag might make the code easier to read, but I don't
know if we can have one.

> Otherwise it seems to me your approach should work.

Thanks a lot,
Andreas

