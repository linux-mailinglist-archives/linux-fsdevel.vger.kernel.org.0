Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3ED156E5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2019 02:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbfEGAZJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 May 2019 20:25:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:51406 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726073AbfEGAZJ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 May 2019 20:25:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 72C33AE5A;
        Tue,  7 May 2019 00:25:07 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Date:   Tue, 07 May 2019 10:24:58 +1000
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Andreas =?utf-8?Q?Gr=C3=BCnbacher?= 
        <andreas.gruenbacher@gmail.com>,
        Patrick Plagwitz <Patrick_Plagwitz@web.de>,
        "linux-unionfs\@vger.kernel.org" <linux-unionfs@vger.kernel.org>,
        Linux NFS list <linux-nfs@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] overlayfs: ignore empty NFSv4 ACLs in ext4 upperdir
In-Reply-To: <20190503153531.GJ12608@fieldses.org>
References: <CAJfpegtpkavseTFLspaC7svbvHRq-0-7jvyh63+DK5iWHTGnaQ@mail.gmail.com> <20161205162559.GB17517@fieldses.org> <CAHpGcMKHjic6L+J0qvMYNG9hVCcDO1hEpx4BiEk0ZCKDV39BmA@mail.gmail.com> <266c571f-e4e2-7c61-5ee2-8ece0c2d06e9@web.de> <CAHpGcMKmtppfn7PVrGKEEtVphuLV=YQ2GDYKOqje4ZANhzSgDw@mail.gmail.com> <CAHpGcMKjscfhmrAhwGes0ag2xTkbpFvCO6eiLL_rHz87XE-ZmA@mail.gmail.com> <CAJfpegvRFGOc31gVuYzanzWJ=mYSgRgtAaPhYNxZwHin3Wc0Gw@mail.gmail.com> <CAHc6FU4JQ28BFZE9_8A06gtkMvvKDzFmw9=ceNPYvnMXEimDMw@mail.gmail.com> <20161206185806.GC31197@fieldses.org> <87bm0l4nra.fsf@notabene.neil.brown.name> <20190503153531.GJ12608@fieldses.org>
Message-ID: <87woj3157p.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, May 03 2019, J. Bruce Fields wrote:

> On Thu, May 02, 2019 at 12:02:33PM +1000, NeilBrown wrote:
>> On Tue, Dec 06 2016, J. Bruce Fields wrote:
>>=20
>> > On Tue, Dec 06, 2016 at 02:18:31PM +0100, Andreas Gruenbacher wrote:
>> >> On Tue, Dec 6, 2016 at 11:08 AM, Miklos Szeredi <miklos@szeredi.hu> w=
rote:
>> >> > On Tue, Dec 6, 2016 at 12:24 AM, Andreas Gr=C3=BCnbacher
>> >> > <andreas.gruenbacher@gmail.com> wrote:
>> >> >> 2016-12-06 0:19 GMT+01:00 Andreas Gr=C3=BCnbacher <andreas.gruenba=
cher@gmail.com>:
>> >> >
>> >> >>> It's not hard to come up with a heuristic that determines if a
>> >> >>> system.nfs4_acl value is equivalent to a file mode, and to ignore=
 the
>> >> >>> attribute in that case. (The file mode is transmitted in its own
>> >> >>> attribute already, so actually converting .) That way, overlayfs =
could
>> >> >>> still fail copying up files that have an actual ACL. It's still an
>> >> >>> ugly hack ...
>> >> >>
>> >> >> Actually, that kind of heuristic would make sense in the NFS client
>> >> >> which could then hide the "system.nfs4_acl" attribute.
>> >> >
>> >> > Even simpler would be if knfsd didn't send the attribute if not
>> >> > necessary.  Looks like there's code actively creating the nfs4_acl =
on
>> >> > the wire even if the filesystem had none:
>> >> >
>> >> >     pacl =3D get_acl(inode, ACL_TYPE_ACCESS);
>> >> >     if (!pacl)
>> >> >         pacl =3D posix_acl_from_mode(inode->i_mode, GFP_KERNEL);
>> >> >
>> >> > What's the point?
>> >>=20
>> >> That's how the protocol is specified.
>> >
>> > Yep, even if we could make that change to nfsd it wouldn't help the
>> > client with the large number of other servers that are out there
>> > (including older knfsd's).
>> >
>> > --b.
>> >
>> >> (I'm not saying that that's very helpful.)
>> >>=20
>> >> Andreas
>>=20
>> Hi everyone.....
>>  I have a customer facing this problem, and so stumbled onto the email
>>  thread.
>>  Unfortunately it didn't resolve anything.  Maybe I can help kick things
>>  along???
>>=20
>>  The core problem here is that NFSv4 and ext4 use different and largely
>>  incompatible ACL implementations.  There is no way to accurately
>>  translate from one to the other in general (common specific examples
>>  can be converted).
>>=20
>>  This means that either:
>>    1/ overlayfs cannot use ext4 for upper and NFS for lower (or vice
>>       versa) or
>>    2/ overlayfs need to accept that sometimes it cannot copy ACLs, and
>>       that is OK.
>>=20
>>  Silently not copying the ACLs is probably not a good idea as it might
>>  result in inappropriate permissions being given away.  So if the
>>  sysadmin wants this (and some clearly do), they need a way to
>>  explicitly say "I accept the risk".
>
> So, I feel like silently copying ACLs up *also* carries a risk, if that
> means switching from server-enforcement to client-enforcement of those
> permissions.

Interesting perspective .... though doesn't NFSv4 explicitly allow
client-side ACL enforcement in the case of delegations?
Not sure how relevant that is....

It seems to me we have two options:
 1/ declare the NFSv4 doesn't work as a lower layer for overlayfs and
    recommend people use NFSv3, or
 2/ Modify overlayfs to work with NFSv4 by ignoring nfsv4 ACLs either
 2a/ always - and ignore all other acls and probably all system. xattrs,
 or
 2b/ based on a mount option that might be
      2bi/ general "noacl" or might be
      2bii/ explicit "noxattr=3Dsystem.nfs4acl"
=20
I think that continuing to discuss the miniature of the options isn't
going to help.  No solution is perfect - we just need to clearly
document the implications of whatever we come up with.

I lean towards 2a, but I be happy with with any '2' and '1' won't kill
me.

Do we have a vote?  Or does someone make an executive decision??

NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlzQ0FsACgkQOeye3VZi
gbmsVw//WnOlxrweqSKICkAAi603PMcmS8Md0wmkM70CI1jpJ83XZmzKxrcTex9N
yVZv4IqQ/WvQWTPFfqZQEjUJF9VD3hr18q0EPYqAxkTUINChjiqFtXVm7+I1Z/Ws
MplLXNj978izRf1k4M+HyET8FSc1cp1rADRgRj7yu9sejX85GmIqOjfso6s51KYZ
ji+GkrEvNiSSLx3H1hN5bzOQMpuzUMUPfTe4k+HvCYpngC5vxd5dpdwta6gFsK9Q
k8mtWmwXgmBmRCc0yIvzMPoxwH4LIKcg5fc0h0E5ZDduHwkTECRP9bRQ91BxxTT6
MDgooq7ykE8ymbM2nxsJOhBZbCqpZ4Ax14JiWHr1gHqf62JST/ButWYH+kJkfmWa
6YVm//jEorhKtBddNix+y9xDqz1vaY2kJvSa586rqO1jfc3k4JD8nhFQ0RyY7ZVp
35FR4z3hDu9zclmL76Dhisn623IFEkbiosjzXBCSavd4gKB2ps+McSQ+x+ZKhapx
3yEAMnbxp9Mw/58S5fdil9ftmRp1cf/BGWKOQes8SwxpOy7e3/aJOZRaMVnTk1FX
s8aIANnLaP2+Rp/0LyN9Z83bEI8sePgPGVBY768Q3QRuGD6K85WA2lc4rOXPrnCD
e1O4ESUMyEe6ZTOACTw/EF6ceotlqPEBTXrVecVAkI+c4JtwtYs=
=/EJ8
-----END PGP SIGNATURE-----
--=-=-=--
