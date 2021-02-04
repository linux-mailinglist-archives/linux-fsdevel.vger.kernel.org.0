Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F00430EBA6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Feb 2021 05:58:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbhBDE6A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Feb 2021 23:58:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbhBDE57 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Feb 2021 23:57:59 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06026C061573
        for <linux-fsdevel@vger.kernel.org>; Wed,  3 Feb 2021 20:57:18 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id d3so2589146lfg.10
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Feb 2021 20:57:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VaoyAu2R2LgaPMTds+p8WvJvn80i0Ta+OcibglP4ZbY=;
        b=MY4Fkt6lV/VlpwDRMN0wvwMsluYZ33SDDeabzkM192gYcdirZ7Gm6CqfPvkVTWdsY8
         BkF7m6gT9AI9zkkFF6BIFFaB/Pd2vmTgJzzoBF5dcXaGvTMISROUdrvAKusVL/W4Qyu3
         i8dhdpdVK5bN+THWSq3Os7bgqbC1ZmLoVMvHVkIYD1N97fnHaFRf3LB14COZR2eMORk2
         oqIqaMu9o3FSuNDF+MRZ/Lpt3yWdcwEkOrIPlntEYKrmVjMSVfmZf4v5isaEZBW4WfG8
         vUUY8syALFyHhphB1OJVguwMH5WOQp1KXV/BPukDPY5tlpvaUwY3zuQrhq+HeqT4GArp
         wmnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VaoyAu2R2LgaPMTds+p8WvJvn80i0Ta+OcibglP4ZbY=;
        b=ajaOrlukWAzJWj99xY9i8/ivSVIeE/bxc1HjmmTgGwjGDZI70BKAV0EV9B0vzLM3Iz
         P6TporOJqgQulEmtS+Y13We5ZL1aaAujPwk3BUl5KlrLDV6npw8FCxXFxcfXTzy6uGv/
         wxt51H8y1gp39UZWgsXv9o/rjR4wtmFvrE1TIqU54IUU4m6g7abQfBfRqPmtSueK0gos
         15FBFvDG/uQVxCBvokZdapf6p3PuUC1jf7fQvEwOEuSviQN5q9TU/3Vh2LpE8WF5MU0z
         hwVpdkUXxF3td9jJGJcFFOZ727Eb8YAgvEstTPcczsHJxxaz9kwV8oSRZpiwOhrwPxMq
         +6bw==
X-Gm-Message-State: AOAM532GcpvTbRBxPGX+5dg1F6dB3zbs5rt2lcN2sz4iI53250HZXieu
        MfnA59op0waa0MhlWXpvQ5HK3PbIB1bzTyBPmaY=
X-Google-Smtp-Source: ABdhPJxwQV2BCzLoF3uhMezTDw/Ik4uzjq1o1u3uIK0yV9vPfik4ikWm0a+scE8iLMwDU7Q7QequFr0fFSUFPtY00+w=
X-Received: by 2002:ac2:5f41:: with SMTP id 1mr3748161lfz.65.1612414636903;
 Wed, 03 Feb 2021 20:57:16 -0800 (PST)
MIME-Version: 1.0
References: <91568e002fed69425485c17de223bef0ff660f3a.1611313420.git.lucien.xin@gmail.com>
 <87r1m4fz72.fsf@notabene.neil.brown.name> <CADvbK_ehp0GaX8+9XOu0igCmDaVfj+WV1880qBwtbfePbK1QqA@mail.gmail.com>
In-Reply-To: <CADvbK_ehp0GaX8+9XOu0igCmDaVfj+WV1880qBwtbfePbK1QqA@mail.gmail.com>
From:   Xin Long <lucien.xin@gmail.com>
Date:   Thu, 4 Feb 2021 12:57:05 +0800
Message-ID: <CADvbK_dJG8o6VZpv4ks+E4Ej7Qj653YLJ2=mM1LrZCObONbp5w@mail.gmail.com>
Subject: Re: [PATCH] seq_read: move count check against iov_iter_count after
 calling op show
To:     NeilBrown <neilb@suse.de>
Cc:     linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        NeilBrown <neilb@suse.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi, Neil,

This is a kind of urgent issue, and I suggest going with the "m->index++"
one in both traverse() and seq_read_iter() first. Once you have a better
fix, you can follow up after. Sounds good?

On Fri, Jan 29, 2021 at 2:57 PM Xin Long <lucien.xin@gmail.com> wrote:
>
> Hi, Neil,
>
> Thanks for reviewing, more below.
>
> On Fri, Jan 29, 2021 at 6:56 AM NeilBrown <neilb@suse.de> wrote:
> >
> > On Fri, Jan 22 2021, Xin Long wrote:
> >
> > > In commit 1f4aace60b0e ("fs/seq_file.c: simplify seq_file iteration code
> > > and interface"), it broke a behavior: op show() is always called when op
> > > next() returns an available obj.
> >
> > Interesting.  I was not aware that some callers assumed this guarantee.
> > If we are going to support it (which seems reasonable) we should add a
> > statement of this guarantee to the documentation -
> > Documentation/filesystems/seq_file.rst.
> > Maybe a new paragraph after "Finally, the show() function ..."
> >
> >    Note that show() will *always* be called after a successful start()
> >    or next() call, so that it can release any resources (such as
> >    ref-counts) that was acquired by those calls.
> OK, that's good, will add it.
> >
> >
> > >
> > > This caused a refcnt leak in net/sctp/proc.c, as of the seq_operations
> > > sctp_assoc_ops, transport obj is held in op next() and released in op
> > > show().
> > >
> > > Here fix it by moving count check against iov_iter_count after calling
> > > op show() so that op show() can still be called when op next() returns
> > > an available obj.
> > >
> > > Note that m->index needs to increase so that op start() could go fetch
> > > the next obj in the next round.
> >
> > This is certainly wrong.
> > As the introduction in my patch said:
> >
> >     A large part of achieving this is to *always* call ->next after ->show
> >     has successfully stored all of an entry in the buffer.  Never just
> >     increment the index instead.
> Understand.
>
> >
> > Incrementing ->index in common seq_file code is wrong.
> >
> > As we are no longer calling ->next after a successful ->show, we need to
> > make that ->show appear unsuccessful so that it will be retried.  This
> > is done be setting "m->count = offs".
> > So the moved code below becomes
> >
> >   if (m->count >= iov_iter_count(iter)) {
> >         /* That record is more than we want, so discard it */
> >         m->count = offs;
> >         break;
> >   }
> But I'm not sure if this's a better way, as discarding it means the last
> show() call is just a waste, next time it has to call show() for that
> obj again. Note that this is a different case from [1] (show() call
> actually failed) and [2](the buffer overflowed), and it makes sense
> to call show() again due to [1] and [2] next time.
>
>                 if (err > 0) { <---[1]
>                         m->count = offs;
>                 } else if (err || seq_has_overflowed(m)) { <--- [2]
>                         m->count = offs;
>                         break;
>                 }
>                  if (m->count >= iov_iter_count(iter)) { <---[3]
>
> But for this one [3], all it needs is just enter into seq_read again and
> do the copying, no need to discard it.
>
> >
> > Possibly that can be merged into the preceding 'if'.
> >
> > Also the traverse() function contains a call to ->next that is not
> > reliably followed by a call to ->show, even when successful.  That needs
> > to be fixed too.
> Right, But I don't see a way here other than Incrementing m->index in
> traverse():
>
> @@ -114,16 +114,19 @@ static int traverse(struct seq_file *m, loff_t offset)
>                 }
>                 if (seq_has_overflowed(m))
>                         goto Eoverflow;
> -               p = m->op->next(m, p, &m->index);
>                 if (pos + m->count > offset) {
>                         m->from = offset - pos;
>                         m->count -= m->from;
> +                       m->index++;
>                         break;
>                 }
>                 pos += m->count;
>                 m->count = 0;
> -               if (pos == offset)
> +               if (pos == offset) {
> +                       m->index++;
>                         break;
> +               }
> +               p = m->op->next(m, p, &m->index);
>         }
>
> >
> > Thanks,
> > NeilBrown
> >
> >
> >
> > >
> > > Fixes: 1f4aace60b0e ("fs/seq_file.c: simplify seq_file iteration code and interface")
> > > Reported-by: Prijesh <prpatel@redhat.com>
> > > Signed-off-by: Xin Long <lucien.xin@gmail.com>
> > > ---
> > >  fs/seq_file.c | 6 ++++--
> > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/fs/seq_file.c b/fs/seq_file.c
> > > index 03a369c..da304f7 100644
> > > --- a/fs/seq_file.c
> > > +++ b/fs/seq_file.c
> > > @@ -264,8 +264,6 @@ ssize_t seq_read_iter(struct kiocb *iocb, struct iov_iter *iter)
> > >               }
> > >               if (!p || IS_ERR(p))    // no next record for us
> > >                       break;
> > > -             if (m->count >= iov_iter_count(iter))
> > > -                     break;
> > >               err = m->op->show(m, p);
> > >               if (err > 0) {          // ->show() says "skip it"
> > >                       m->count = offs;
> > > @@ -273,6 +271,10 @@ ssize_t seq_read_iter(struct kiocb *iocb, struct iov_iter *iter)
> > >                       m->count = offs;
> > >                       break;
> > >               }
> > > +             if (m->count >= iov_iter_count(iter)) {
> > > +                     m->index++;
> > > +                     break;
> > > +             }
> > >       }
> > >       m->op->stop(m, p);
> > >       n = copy_to_iter(m->buf, m->count, iter);
> > > --
> > > 2.1.0
