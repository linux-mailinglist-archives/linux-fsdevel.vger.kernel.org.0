Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD5F930EC30
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Feb 2021 06:47:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbhBDFqy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Feb 2021 00:46:54 -0500
Received: from mx2.suse.de ([195.135.220.15]:43404 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229508AbhBDFqy (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Feb 2021 00:46:54 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3999FABD5;
        Thu,  4 Feb 2021 05:46:12 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Xin Long <lucien.xin@gmail.com>
Date:   Thu, 04 Feb 2021 16:46:06 +1100
Cc:     linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        NeilBrown <neilb@suse.com>
Subject: Re: [PATCH] seq_read: move count check against iov_iter_count after
 calling op show
In-Reply-To: <CADvbK_dJG8o6VZpv4ks+E4Ej7Qj653YLJ2=mM1LrZCObONbp5w@mail.gmail.com>
References: <91568e002fed69425485c17de223bef0ff660f3a.1611313420.git.lucien.xin@gmail.com>
 <87r1m4fz72.fsf@notabene.neil.brown.name>
 <CADvbK_ehp0GaX8+9XOu0igCmDaVfj+WV1880qBwtbfePbK1QqA@mail.gmail.com>
 <CADvbK_dJG8o6VZpv4ks+E4Ej7Qj653YLJ2=mM1LrZCObONbp5w@mail.gmail.com>
Message-ID: <87o8h0e675.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--=-=-=
Content-Type: text/plain

On Thu, Feb 04 2021, Xin Long wrote:

> Hi, Neil,
>
> This is a kind of urgent issue, and I suggest going with the "m->index++"
> one in both traverse() and seq_read_iter() first. Once you have a better
> fix, you can follow up after. Sounds good?

I assumed you would be working on the better fix based on my feedback.
I guess not.  In that case I had better prepare one.  I'll try to have
something on Monday.

As for "going with" your patch, it isn't my place to accept or reject
your patch - that is the maintainer's responsibility.  I think your
patch is wrong, so I cannot recommend it.

NeilBrown


>
> On Fri, Jan 29, 2021 at 2:57 PM Xin Long <lucien.xin@gmail.com> wrote:
>>
>> Hi, Neil,
>>
>> Thanks for reviewing, more below.
>>
>> On Fri, Jan 29, 2021 at 6:56 AM NeilBrown <neilb@suse.de> wrote:
>> >
>> > On Fri, Jan 22 2021, Xin Long wrote:
>> >
>> > > In commit 1f4aace60b0e ("fs/seq_file.c: simplify seq_file iteration code
>> > > and interface"), it broke a behavior: op show() is always called when op
>> > > next() returns an available obj.
>> >
>> > Interesting.  I was not aware that some callers assumed this guarantee.
>> > If we are going to support it (which seems reasonable) we should add a
>> > statement of this guarantee to the documentation -
>> > Documentation/filesystems/seq_file.rst.
>> > Maybe a new paragraph after "Finally, the show() function ..."
>> >
>> >    Note that show() will *always* be called after a successful start()
>> >    or next() call, so that it can release any resources (such as
>> >    ref-counts) that was acquired by those calls.
>> OK, that's good, will add it.
>> >
>> >
>> > >
>> > > This caused a refcnt leak in net/sctp/proc.c, as of the seq_operations
>> > > sctp_assoc_ops, transport obj is held in op next() and released in op
>> > > show().
>> > >
>> > > Here fix it by moving count check against iov_iter_count after calling
>> > > op show() so that op show() can still be called when op next() returns
>> > > an available obj.
>> > >
>> > > Note that m->index needs to increase so that op start() could go fetch
>> > > the next obj in the next round.
>> >
>> > This is certainly wrong.
>> > As the introduction in my patch said:
>> >
>> >     A large part of achieving this is to *always* call ->next after ->show
>> >     has successfully stored all of an entry in the buffer.  Never just
>> >     increment the index instead.
>> Understand.
>>
>> >
>> > Incrementing ->index in common seq_file code is wrong.
>> >
>> > As we are no longer calling ->next after a successful ->show, we need to
>> > make that ->show appear unsuccessful so that it will be retried.  This
>> > is done be setting "m->count = offs".
>> > So the moved code below becomes
>> >
>> >   if (m->count >= iov_iter_count(iter)) {
>> >         /* That record is more than we want, so discard it */
>> >         m->count = offs;
>> >         break;
>> >   }
>> But I'm not sure if this's a better way, as discarding it means the last
>> show() call is just a waste, next time it has to call show() for that
>> obj again. Note that this is a different case from [1] (show() call
>> actually failed) and [2](the buffer overflowed), and it makes sense
>> to call show() again due to [1] and [2] next time.
>>
>>                 if (err > 0) { <---[1]
>>                         m->count = offs;
>>                 } else if (err || seq_has_overflowed(m)) { <--- [2]
>>                         m->count = offs;
>>                         break;
>>                 }
>>                  if (m->count >= iov_iter_count(iter)) { <---[3]
>>
>> But for this one [3], all it needs is just enter into seq_read again and
>> do the copying, no need to discard it.
>>
>> >
>> > Possibly that can be merged into the preceding 'if'.
>> >
>> > Also the traverse() function contains a call to ->next that is not
>> > reliably followed by a call to ->show, even when successful.  That needs
>> > to be fixed too.
>> Right, But I don't see a way here other than Incrementing m->index in
>> traverse():
>>
>> @@ -114,16 +114,19 @@ static int traverse(struct seq_file *m, loff_t offset)
>>                 }
>>                 if (seq_has_overflowed(m))
>>                         goto Eoverflow;
>> -               p = m->op->next(m, p, &m->index);
>>                 if (pos + m->count > offset) {
>>                         m->from = offset - pos;
>>                         m->count -= m->from;
>> +                       m->index++;
>>                         break;
>>                 }
>>                 pos += m->count;
>>                 m->count = 0;
>> -               if (pos == offset)
>> +               if (pos == offset) {
>> +                       m->index++;
>>                         break;
>> +               }
>> +               p = m->op->next(m, p, &m->index);
>>         }
>>
>> >
>> > Thanks,
>> > NeilBrown
>> >
>> >
>> >
>> > >
>> > > Fixes: 1f4aace60b0e ("fs/seq_file.c: simplify seq_file iteration code and interface")
>> > > Reported-by: Prijesh <prpatel@redhat.com>
>> > > Signed-off-by: Xin Long <lucien.xin@gmail.com>
>> > > ---
>> > >  fs/seq_file.c | 6 ++++--
>> > >  1 file changed, 4 insertions(+), 2 deletions(-)
>> > >
>> > > diff --git a/fs/seq_file.c b/fs/seq_file.c
>> > > index 03a369c..da304f7 100644
>> > > --- a/fs/seq_file.c
>> > > +++ b/fs/seq_file.c
>> > > @@ -264,8 +264,6 @@ ssize_t seq_read_iter(struct kiocb *iocb, struct iov_iter *iter)
>> > >               }
>> > >               if (!p || IS_ERR(p))    // no next record for us
>> > >                       break;
>> > > -             if (m->count >= iov_iter_count(iter))
>> > > -                     break;
>> > >               err = m->op->show(m, p);
>> > >               if (err > 0) {          // ->show() says "skip it"
>> > >                       m->count = offs;
>> > > @@ -273,6 +271,10 @@ ssize_t seq_read_iter(struct kiocb *iocb, struct iov_iter *iter)
>> > >                       m->count = offs;
>> > >                       break;
>> > >               }
>> > > +             if (m->count >= iov_iter_count(iter)) {
>> > > +                     m->index++;
>> > > +                     break;
>> > > +             }
>> > >       }
>> > >       m->op->stop(m, p);
>> > >       n = copy_to_iter(m->buf, m->count, iter);
>> > > --
>> > > 2.1.0

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJCBAEBCAAsFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAmAbih4OHG5laWxiQHN1
c2UuZGUACgkQOeye3VZigbnq4A/+Me47S8Vw6sIykpahOFC/7hoNiFhtnhML9fzm
T4TYo+Od+lH+oP+jDdm0CTrivKDYg21sCiyROJ62QGIq6WIVCIlP2JVSJu47ognr
i49929BJT0vSFz+/u45owYN/P6nVaGbplm+EWJ8FBfFezj9WHNuIcL/G9oaoG0vT
aeBclqcnDKbsQhIJt7GCtcMW8BO/umJCApIvzmPvgjaaw0yvp2x+11XcLSGbF+s0
loLPQL5KkryGfhnjAvf1LfCmMUt5ITY/hRi2E2h/Jj7nS3c5CP6LdHIYwojCqQ12
seNes8YOlJaFHWXOcjmZ3wHDELxP5U6QF6Sck4H8u5+YRtw+6wb7emr5WmOy/Mgx
2BngejgTgrqO85RuJikOotlBD3YyXSnY50R8Xa48gmv30GqdwKC9aUJYPK9wbG4J
unB31Ay/9v41cJl9eKVmrO3VkWRI8MzZknMTdkIrDo0h6hxpQT81TLG31uxztHF1
fnhs/CuKbGxtgwbMBf8fIvyxaXLbRXu/GkMSTtG/NSIH3O8mOaubz1ZE2Qi4T/DO
jj8k4G/h16a8UUBVhBV+ez0Jb+E+5B6nYm2AxI0JwDBgtcpUm2MyPcOcTupQinRT
yy8EiqW02tYKZU6z0PEH7sfyS5aHNvmTZITt0FW34S58ybaqWyyAZedYF/3ssUK3
okygudI=
=QGGr
-----END PGP SIGNATURE-----
--=-=-=--
