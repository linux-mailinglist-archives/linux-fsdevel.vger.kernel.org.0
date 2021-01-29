Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6AE4308621
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Jan 2021 08:02:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232252AbhA2G6Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Jan 2021 01:58:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232143AbhA2G6P (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Jan 2021 01:58:15 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77E10C0613D6
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Jan 2021 22:57:35 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id b2so11094449lfq.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Jan 2021 22:57:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NEM0fiit64y7fKRGqdUpVYOmOrer0iqc3oPGOWs5w6c=;
        b=YYjBkzdRUrbi0suoXfv7bYkrsHH4ehZQUzOnqO1W/G1bm41C9a+9TqhDPcTWj9Eore
         AYCYIPFK1CJ94yLeszgdTRHu8ToSv4CMp2sNcR9q1VsZX/q/pCfAtLflWd5vdkeg3tYG
         krIcnreyq6nwKPVC/nn80ISV2R7Nj2PnYeDCSSSRPyJSjFxuPifWkJ4RGK/K85sSF3EJ
         L9ZMD+0ob+WN78m+UiLlQhH45Q+zsXiKQ43lV2dIs45Jz+ZyzBv97/cKer5w5lH8TqFi
         dcSntEdkGTGrmfii/5kFfrWnEUIvR/2l8NvdQuZUyvnZmB/h1pXyybTKRpNdLPHQJZtc
         N+yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NEM0fiit64y7fKRGqdUpVYOmOrer0iqc3oPGOWs5w6c=;
        b=pvTvQxWWcz18SK9ToMJazuaKqfU28UHvk8mBq4vP1zsa8JQ+qR94PuZcicYf6PYYKj
         LcvBz1UYYW/ZVtyxKmNKHNFL1DQIPZ+049H4UneJ9Gwvt9IsFFMQd5CudPD2g9UOUn4G
         R/qrMRS0MewR57H0VXebcvnVr4zcNRr+kn1MqQQywFZO5EQKlao38D30nTnNcT+E0vAk
         uX+XZs9u+coA3+D9vP4sn5NmOZp+9/oDZ3v7wjC3DrCHvpQ1dEZTtBM8qZw077ygh2WL
         /3lURPoZkyEkyn3/tkT6Sb5ADVbn3p93+SLfLFgYxs1Gx8GBNrUhFm6SFAQhbaxvb9Eu
         iv1A==
X-Gm-Message-State: AOAM531DGmvgDjESZEaIAy/qwmU0E01GKsnFkOsUV8zSG3LmnjGGH9ZC
        MeS5LDDtD/HM96usTiSrH7nNBSNsvEPmzXHkQmM=
X-Google-Smtp-Source: ABdhPJzt4HaTgVAdig40x5krcp6hI5He4vBn5zqyEgWt3KbrLk/+Jl2ZyF3UTHjma/ZkfWzqee+vArxH7tO3MZiTrqA=
X-Received: by 2002:a19:750b:: with SMTP id y11mr1456204lfe.479.1611903454015;
 Thu, 28 Jan 2021 22:57:34 -0800 (PST)
MIME-Version: 1.0
References: <91568e002fed69425485c17de223bef0ff660f3a.1611313420.git.lucien.xin@gmail.com>
 <87r1m4fz72.fsf@notabene.neil.brown.name>
In-Reply-To: <87r1m4fz72.fsf@notabene.neil.brown.name>
From:   Xin Long <lucien.xin@gmail.com>
Date:   Fri, 29 Jan 2021 14:57:22 +0800
Message-ID: <CADvbK_ehp0GaX8+9XOu0igCmDaVfj+WV1880qBwtbfePbK1QqA@mail.gmail.com>
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

Thanks for reviewing, more below.

On Fri, Jan 29, 2021 at 6:56 AM NeilBrown <neilb@suse.de> wrote:
>
> On Fri, Jan 22 2021, Xin Long wrote:
>
> > In commit 1f4aace60b0e ("fs/seq_file.c: simplify seq_file iteration code
> > and interface"), it broke a behavior: op show() is always called when op
> > next() returns an available obj.
>
> Interesting.  I was not aware that some callers assumed this guarantee.
> If we are going to support it (which seems reasonable) we should add a
> statement of this guarantee to the documentation -
> Documentation/filesystems/seq_file.rst.
> Maybe a new paragraph after "Finally, the show() function ..."
>
>    Note that show() will *always* be called after a successful start()
>    or next() call, so that it can release any resources (such as
>    ref-counts) that was acquired by those calls.
OK, that's good, will add it.
>
>
> >
> > This caused a refcnt leak in net/sctp/proc.c, as of the seq_operations
> > sctp_assoc_ops, transport obj is held in op next() and released in op
> > show().
> >
> > Here fix it by moving count check against iov_iter_count after calling
> > op show() so that op show() can still be called when op next() returns
> > an available obj.
> >
> > Note that m->index needs to increase so that op start() could go fetch
> > the next obj in the next round.
>
> This is certainly wrong.
> As the introduction in my patch said:
>
>     A large part of achieving this is to *always* call ->next after ->show
>     has successfully stored all of an entry in the buffer.  Never just
>     increment the index instead.
Understand.

>
> Incrementing ->index in common seq_file code is wrong.
>
> As we are no longer calling ->next after a successful ->show, we need to
> make that ->show appear unsuccessful so that it will be retried.  This
> is done be setting "m->count = offs".
> So the moved code below becomes
>
>   if (m->count >= iov_iter_count(iter)) {
>         /* That record is more than we want, so discard it */
>         m->count = offs;
>         break;
>   }
But I'm not sure if this's a better way, as discarding it means the last
show() call is just a waste, next time it has to call show() for that
obj again. Note that this is a different case from [1] (show() call
actually failed) and [2](the buffer overflowed), and it makes sense
to call show() again due to [1] and [2] next time.

                if (err > 0) { <---[1]
                        m->count = offs;
                } else if (err || seq_has_overflowed(m)) { <--- [2]
                        m->count = offs;
                        break;
                }
                 if (m->count >= iov_iter_count(iter)) { <---[3]

But for this one [3], all it needs is just enter into seq_read again and
do the copying, no need to discard it.

>
> Possibly that can be merged into the preceding 'if'.
>
> Also the traverse() function contains a call to ->next that is not
> reliably followed by a call to ->show, even when successful.  That needs
> to be fixed too.
Right, But I don't see a way here other than Incrementing m->index in
traverse():

@@ -114,16 +114,19 @@ static int traverse(struct seq_file *m, loff_t offset)
                }
                if (seq_has_overflowed(m))
                        goto Eoverflow;
-               p = m->op->next(m, p, &m->index);
                if (pos + m->count > offset) {
                        m->from = offset - pos;
                        m->count -= m->from;
+                       m->index++;
                        break;
                }
                pos += m->count;
                m->count = 0;
-               if (pos == offset)
+               if (pos == offset) {
+                       m->index++;
                        break;
+               }
+               p = m->op->next(m, p, &m->index);
        }

>
> Thanks,
> NeilBrown
>
>
>
> >
> > Fixes: 1f4aace60b0e ("fs/seq_file.c: simplify seq_file iteration code and interface")
> > Reported-by: Prijesh <prpatel@redhat.com>
> > Signed-off-by: Xin Long <lucien.xin@gmail.com>
> > ---
> >  fs/seq_file.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/fs/seq_file.c b/fs/seq_file.c
> > index 03a369c..da304f7 100644
> > --- a/fs/seq_file.c
> > +++ b/fs/seq_file.c
> > @@ -264,8 +264,6 @@ ssize_t seq_read_iter(struct kiocb *iocb, struct iov_iter *iter)
> >               }
> >               if (!p || IS_ERR(p))    // no next record for us
> >                       break;
> > -             if (m->count >= iov_iter_count(iter))
> > -                     break;
> >               err = m->op->show(m, p);
> >               if (err > 0) {          // ->show() says "skip it"
> >                       m->count = offs;
> > @@ -273,6 +271,10 @@ ssize_t seq_read_iter(struct kiocb *iocb, struct iov_iter *iter)
> >                       m->count = offs;
> >                       break;
> >               }
> > +             if (m->count >= iov_iter_count(iter)) {
> > +                     m->index++;
> > +                     break;
> > +             }
> >       }
> >       m->op->stop(m, p);
> >       n = copy_to_iter(m->buf, m->count, iter);
> > --
> > 2.1.0
