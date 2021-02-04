Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED7EE30EC3D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Feb 2021 06:55:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231807AbhBDFyr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Feb 2021 00:54:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbhBDFyo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Feb 2021 00:54:44 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61371C061573
        for <linux-fsdevel@vger.kernel.org>; Wed,  3 Feb 2021 21:54:04 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id c12so2007854wrc.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Feb 2021 21:54:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wy54JRUca8QuGE08Xy1eCV62VLJPHYtp9WfbJrT+lEk=;
        b=P/P3jmxLrgCmKlMQn9io7SzPZVB8dMvHEnNfnrkFEFDuXDU33p85tTOgZXGMqAP4FR
         Ww1Evs35In48X+CBusQ0rRzldh4anOQWWRT/aRDQPwMqYtt29Nk5+CrStc69NvwGJklv
         5+CDUms1lEywBVZpXsSW0DudEIGnTyJURSNY/BxgidHG7oHVY2OwFNgIXTIJlc4bNcWP
         kwoW4d4tko+qgHtc+n10zEpXiFCILjSyNBeCPBtUHalO3/un1FcMnzi3xkyVXgMUsqyz
         h7qQX5aJquRhkcOIFakychMeuDJ1Nc3sKpFBQtuig7nrb7B7N/yd8r4m3fThtZnrLSFE
         jBrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wy54JRUca8QuGE08Xy1eCV62VLJPHYtp9WfbJrT+lEk=;
        b=S/MP/CR6eVsMsJvgCGs2w9zIh2i9yx9i2fS/6hBT4jzwsGdm6f/0py2FD37szmk+Qq
         wtFWhfQYSHA/NWGKcHThOIU3iy+Gto814u6IxEiMoc4ybu+pGUs9sP032yLL6WcRS38L
         R1a6lXeUdxIdMAfrBFve2HngTpcmRMotcW6qShYi/3ALBbb5GAgOh5X7CkJIF1GD2Fsm
         f6XlQV2SXb0x3pbgG9vErwYDAkjWUDyQUsWGNB3EN00mw0p5jspNmD6lnz7/C9+TJRhr
         hr1aw0Lqa4cY7wEBijQPi90+vc8nRDG2nHD1dVmhLTMfnWNK543y0BdDocRplBfcKnaT
         mREg==
X-Gm-Message-State: AOAM533ALN1lP4jER5OJaLW42pLBAnhyi9Vn8yY706OCuRrGyfhLITGe
        T26q8t3rwaffXEqn9cdXDMIIl/y60s7pClRE70bGErRxU9Y=
X-Google-Smtp-Source: ABdhPJy2h5SybSGVbQMe5gIC95OvkYEElBV1rEH0m7Fr3V+2Fh1GvArpQBhqRP0xNPMKCzxGYjl+Mfm02rQ321l0x+A=
X-Received: by 2002:a5d:4a0d:: with SMTP id m13mr7263498wrq.395.1612418043094;
 Wed, 03 Feb 2021 21:54:03 -0800 (PST)
MIME-Version: 1.0
References: <91568e002fed69425485c17de223bef0ff660f3a.1611313420.git.lucien.xin@gmail.com>
 <87r1m4fz72.fsf@notabene.neil.brown.name> <CADvbK_ehp0GaX8+9XOu0igCmDaVfj+WV1880qBwtbfePbK1QqA@mail.gmail.com>
 <CADvbK_dJG8o6VZpv4ks+E4Ej7Qj653YLJ2=mM1LrZCObONbp5w@mail.gmail.com> <87o8h0e675.fsf@notabene.neil.brown.name>
In-Reply-To: <87o8h0e675.fsf@notabene.neil.brown.name>
From:   Xin Long <lucien.xin@gmail.com>
Date:   Thu, 4 Feb 2021 13:53:51 +0800
Message-ID: <CADvbK_cRh+j8-K86EF25OnReQYz_YweR=S_7HCjOq5KcMbt42w@mail.gmail.com>
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

On Thu, Feb 4, 2021 at 1:46 PM NeilBrown <neilb@suse.de> wrote:
>
> On Thu, Feb 04 2021, Xin Long wrote:
>
> > Hi, Neil,
> >
> > This is a kind of urgent issue, and I suggest going with the "m->index++"
> > one in both traverse() and seq_read_iter() first. Once you have a better
> > fix, you can follow up after. Sounds good?
>
> I assumed you would be working on the better fix based on my feedback.
> I guess not.  In that case I had better prepare one.  I'll try to have
> something on Monday.
Thanks, we'll be waiting for your better fix, :-).

>
> As for "going with" your patch, it isn't my place to accept or reject
> your patch - that is the maintainer's responsibility.  I think your
> patch is wrong, so I cannot recommend it.
okay.

>
> NeilBrown
>
>
> >
> > On Fri, Jan 29, 2021 at 2:57 PM Xin Long <lucien.xin@gmail.com> wrote:
> >>
> >> Hi, Neil,
> >>
> >> Thanks for reviewing, more below.
> >>
> >> On Fri, Jan 29, 2021 at 6:56 AM NeilBrown <neilb@suse.de> wrote:
> >> >
> >> > On Fri, Jan 22 2021, Xin Long wrote:
> >> >
> >> > > In commit 1f4aace60b0e ("fs/seq_file.c: simplify seq_file iteration code
> >> > > and interface"), it broke a behavior: op show() is always called when op
> >> > > next() returns an available obj.
> >> >
> >> > Interesting.  I was not aware that some callers assumed this guarantee.
> >> > If we are going to support it (which seems reasonable) we should add a
> >> > statement of this guarantee to the documentation -
> >> > Documentation/filesystems/seq_file.rst.
> >> > Maybe a new paragraph after "Finally, the show() function ..."
> >> >
> >> >    Note that show() will *always* be called after a successful start()
> >> >    or next() call, so that it can release any resources (such as
> >> >    ref-counts) that was acquired by those calls.
> >> OK, that's good, will add it.
> >> >
> >> >
> >> > >
> >> > > This caused a refcnt leak in net/sctp/proc.c, as of the seq_operations
> >> > > sctp_assoc_ops, transport obj is held in op next() and released in op
> >> > > show().
> >> > >
> >> > > Here fix it by moving count check against iov_iter_count after calling
> >> > > op show() so that op show() can still be called when op next() returns
> >> > > an available obj.
> >> > >
> >> > > Note that m->index needs to increase so that op start() could go fetch
> >> > > the next obj in the next round.
> >> >
> >> > This is certainly wrong.
> >> > As the introduction in my patch said:
> >> >
> >> >     A large part of achieving this is to *always* call ->next after ->show
> >> >     has successfully stored all of an entry in the buffer.  Never just
> >> >     increment the index instead.
> >> Understand.
> >>
> >> >
> >> > Incrementing ->index in common seq_file code is wrong.
> >> >
> >> > As we are no longer calling ->next after a successful ->show, we need to
> >> > make that ->show appear unsuccessful so that it will be retried.  This
> >> > is done be setting "m->count = offs".
> >> > So the moved code below becomes
> >> >
> >> >   if (m->count >= iov_iter_count(iter)) {
> >> >         /* That record is more than we want, so discard it */
> >> >         m->count = offs;
> >> >         break;
> >> >   }
> >> But I'm not sure if this's a better way, as discarding it means the last
> >> show() call is just a waste, next time it has to call show() for that
> >> obj again. Note that this is a different case from [1] (show() call
> >> actually failed) and [2](the buffer overflowed), and it makes sense
> >> to call show() again due to [1] and [2] next time.
> >>
> >>                 if (err > 0) { <---[1]
> >>                         m->count = offs;
> >>                 } else if (err || seq_has_overflowed(m)) { <--- [2]
> >>                         m->count = offs;
> >>                         break;
> >>                 }
> >>                  if (m->count >= iov_iter_count(iter)) { <---[3]
> >>
> >> But for this one [3], all it needs is just enter into seq_read again and
> >> do the copying, no need to discard it.
> >>
> >> >
> >> > Possibly that can be merged into the preceding 'if'.
> >> >
> >> > Also the traverse() function contains a call to ->next that is not
> >> > reliably followed by a call to ->show, even when successful.  That needs
> >> > to be fixed too.
> >> Right, But I don't see a way here other than Incrementing m->index in
> >> traverse():
> >>
> >> @@ -114,16 +114,19 @@ static int traverse(struct seq_file *m, loff_t offset)
> >>                 }
> >>                 if (seq_has_overflowed(m))
> >>                         goto Eoverflow;
> >> -               p = m->op->next(m, p, &m->index);
> >>                 if (pos + m->count > offset) {
> >>                         m->from = offset - pos;
> >>                         m->count -= m->from;
> >> +                       m->index++;
> >>                         break;
> >>                 }
> >>                 pos += m->count;
> >>                 m->count = 0;
> >> -               if (pos == offset)
> >> +               if (pos == offset) {
> >> +                       m->index++;
> >>                         break;
> >> +               }
> >> +               p = m->op->next(m, p, &m->index);
> >>         }
> >>
> >> >
> >> > Thanks,
> >> > NeilBrown
> >> >
> >> >
> >> >
> >> > >
> >> > > Fixes: 1f4aace60b0e ("fs/seq_file.c: simplify seq_file iteration code and interface")
> >> > > Reported-by: Prijesh <prpatel@redhat.com>
> >> > > Signed-off-by: Xin Long <lucien.xin@gmail.com>
> >> > > ---
> >> > >  fs/seq_file.c | 6 ++++--
> >> > >  1 file changed, 4 insertions(+), 2 deletions(-)
> >> > >
> >> > > diff --git a/fs/seq_file.c b/fs/seq_file.c
> >> > > index 03a369c..da304f7 100644
> >> > > --- a/fs/seq_file.c
> >> > > +++ b/fs/seq_file.c
> >> > > @@ -264,8 +264,6 @@ ssize_t seq_read_iter(struct kiocb *iocb, struct iov_iter *iter)
> >> > >               }
> >> > >               if (!p || IS_ERR(p))    // no next record for us
> >> > >                       break;
> >> > > -             if (m->count >= iov_iter_count(iter))
> >> > > -                     break;
> >> > >               err = m->op->show(m, p);
> >> > >               if (err > 0) {          // ->show() says "skip it"
> >> > >                       m->count = offs;
> >> > > @@ -273,6 +271,10 @@ ssize_t seq_read_iter(struct kiocb *iocb, struct iov_iter *iter)
> >> > >                       m->count = offs;
> >> > >                       break;
> >> > >               }
> >> > > +             if (m->count >= iov_iter_count(iter)) {
> >> > > +                     m->index++;
> >> > > +                     break;
> >> > > +             }
> >> > >       }
> >> > >       m->op->stop(m, p);
> >> > >       n = copy_to_iter(m->buf, m->count, iter);
> >> > > --
> >> > > 2.1.0
