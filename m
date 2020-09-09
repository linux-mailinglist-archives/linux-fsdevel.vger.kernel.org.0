Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB320263A5A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Sep 2020 04:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730726AbgIJC1X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Sep 2020 22:27:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:57626 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730846AbgIJCXr (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Sep 2020 22:23:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 773F4AB3E;
        Wed,  9 Sep 2020 23:04:31 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Date:   Thu, 10 Sep 2020 09:04:08 +1000
Cc:     milan.opensource@gmail.com, lkml <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] fsync.2: ERRORS: add EIO and ENOSPC
In-Reply-To: <e4f5ccb298170357ba16ae2870fde6a90ca2aa81.camel@kernel.org>
References: <1598685186-27499-1-git-send-email-milan.opensource@gmail.com>
 <CAKgNAkiTjtdaQxbCYS67+SdqSPaGzJnfLEEMFgcoXjHLDxgemw@mail.gmail.com>
 <20200908112742.GA2956@quack2.suse.cz>
 <e4f5ccb298170357ba16ae2870fde6a90ca2aa81.camel@kernel.org>
Message-ID: <87k0x2k0wn.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 08 2020, Jeff Layton wrote:

> On Tue, 2020-09-08 at 13:27 +0200, Jan Kara wrote:
>> Added Jeff to CC since he has written the code...
>>=20
>> On Mon 07-09-20 09:11:06, Michael Kerrisk (man-pages) wrote:
>> > [Widening the CC to include Andrew and linux-fsdevel@]
>> > [Milan: thanks for the patch, but it's unclear to me from your commit
>> > message how/if you verified the details.]
>> >=20
>> > Andrew, maybe you (or someone else) can comment, since long ago your
>> >=20
>> >     commit f79e2abb9bd452d97295f34376dedbec9686b986
>> >     Author: Andrew Morton <akpm@osdl.org>
>> >     Date:   Fri Mar 31 02:30:42 2006 -0800
>> >=20
>> > included a comment that is referred to in  stackoverflow discussion
>> > about this topic (that SO discussion is in turn referred to by
>> > https://bugzilla.kernel.org/show_bug.cgi?id=3D194757).
>> >=20
>> > The essence as I understand it, is this:
>> > (1) fsync() (and similar) may fail EIO or ENOSPC, at which point data
>> > has not been synced.
>> > (2) In this case, the EIO/ENOSPC setting is cleared so that...
>> > (3) A subsequent fsync() might return success, but...
>> > (4) That doesn't mean that the data in (1) landed on the disk.
>>=20
>> Correct.
>>=20
>> > The proposed manual page patch below wants to document this, but I'd
>> > be happy to have an FS-knowledgeable person comment before I apply.
>>=20
>> Just a small comment below:
>>=20
>> > On Sat, 29 Aug 2020 at 09:13, <milan.opensource@gmail.com> wrote:
>> > > From: Milan Shah <milan.opensource@gmail.com>
>> > >=20
>> > > This Fix addresses Bug 194757.
>> > > Ref: https://bugzilla.kernel.org/show_bug.cgi?id=3D194757
>> > > ---
>> > >  man2/fsync.2 | 13 +++++++++++++
>> > >  1 file changed, 13 insertions(+)
>> > >=20
>> > > diff --git a/man2/fsync.2 b/man2/fsync.2
>> > > index 96401cd..f38b3e4 100644
>> > > --- a/man2/fsync.2
>> > > +++ b/man2/fsync.2
>> > > @@ -186,6 +186,19 @@ In these cases disk caches need to be disabled =
using
>> > >  or
>> > >  .BR sdparm (8)
>> > >  to guarantee safe operation.
>> > > +
>> > > +When
>> > > +.BR fsync ()
>> > > +or
>> > > +.BR fdatasync ()
>> > > +returns
>> > > +.B EIO
>> > > +or
>> > > +.B ENOSPC
>> > > +any error flags on pages in the file mapping are cleared, so subseq=
uent synchronisation attempts
>> > > +will return without error. It is
>> > > +.I not
>> > > +safe to retry synchronisation and assume that a non-error return me=
ans prior writes are now on disk.
>> > >  .SH SEE ALSO
>> > >  .BR sync (1),
>> > >  .BR bdflush (2),
>>=20
>> So the error state isn't really stored "on pages in the file mapping".
>> Current implementation (since 4.14) is that error state is stored in str=
uct
>> file (I think this tends to be called "file description" in manpages) and
>> so EIO / ENOSPC is reported once for each file description of the file t=
hat
>> was open before the error happened. Not sure if we want to be so precise=
 in
>> the manpages or if it just confuses people. Anyway your takeway that no
>> error on subsequent fsync() does not mean data was written is correct.
>>=20
>>=20
>
> Thinking about it more, I think we ought to spell this out explicitly as
> we can in the manpage. This is a point of confusion for a lot of people
> and not understanding this can lead to data integrity bugs. Maybe
> something like this in the NOTES section?
>
> '''
> When fsync returns an error, the file is considered to be "clean". A
> subsequent call to fsync will not result in a reattempt to write out the
> data, unless that data has been rewritten. Applications that want to
> reattempt writing to the file after a transient error must re-write
> their data.
> '''
>
> To be clear:
>
> In practice, you'd only have to write enough to redirty each page in
> most cases.

Nonononono.  In practice you have to repeat the entire write because you
cannot know if the cached page is from before the write failure, or has
since been flushed and reloaded.

>
> Also, it is hard to claim that the above behavior is universally true. A
> filesystem could opt to keep the pages dirty for some errors, but the
> vast majority just toss out the data whenever there is a writeback
> problem.

...and any filesystem that doesn't behave that way is wasting effort,
because nothing else can be assumed.

Regarding your "NOTES" addition, I don't feel comfortable with the
"clean" language.  I would prefer something like:

 When fsync() reports a failure (EIO, ENOSPC, EDQUOT) it must be assumed
 that any write requests initiated since the previous successful fsync
 was initiated may have failed, and that any cached data may have been
 lost.  A future fsync() will not attempt to write out the same data
 again.  If recovery is possible and desired, the application must
 repeat all the writes that may have failed.

 If the regions of a file that were written to prior to a failed fsync()
 are read, the content reported may not reflect the stored content, and
 subsequent reads may revert to the stored content at any time.

NeilBrown


>
>
> --=20
> Jeff Layton <jlayton@kernel.org>

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJCBAEBCAAsFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAl9ZX2gOHG5laWxiQHN1
c2UuZGUACgkQOeye3VZigbnQFg/+NMG3ScAwc+hbCuVVL4d2NQjGVXnnsCsVANqF
dJqVC2sFozvpRKZSqz+U6MLyCcJjG7DLqb5AtzMVQsaXjyvoZvqqgRbEm0SV8dYK
NUsHdkK+NQwvpxSQraM+Kgw2j5XhodHios34GycGhR/XVur06cG5rjwxfW5LjsRp
EBc631dUIfc5UylXGrZGSZIGCASPmSATD/mHKyfv7ns0f4f9enxn0s6Ntv7rjeoS
aB9MRoRGJMFx18egQ46lCxt0z45IXnPuLtLzY83pFJc5IEhbpRgU1nVVeyYuVZU7
tY+A91vP0Gn58nkel/Fd8Co465cYp6a+t374hFYZdjR+612X4Illu2lCHqYgWYV2
vUTVntiwPqy9PjbO1s7SErQsDlC7DG1xAZnqydOGsx90sAP+XcHVnKpd3L078BfP
EJ09prgTsKvI79ZS7i9sXfEW+v0jnCFcyIFQh8zj6OJOD1SjZMJNFFzoclAhWyf9
eKzQDMfJpHemLWWcaukyr2u3QYoHxDWLcTc/iajtH+hEb/mKWKISuVRLahUuwgyp
te6CMzDQm/3xhCuKfDeIBdnqB/wva0R7K3G91RCmPFxVBw6ZIyjBqs5QnFu/uxj1
blMOHr/5anM3ob0ScJxxurcmvjtQUmyGJpbgcBNgCN4DWCnr88BPH++1grC0JZ1m
qjKUlMA=
=J3Zn
-----END PGP SIGNATURE-----
--=-=-=--
