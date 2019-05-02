Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19F21111F9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2019 05:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbfEBD5Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 May 2019 23:57:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:46684 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726186AbfEBD5Q (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 May 2019 23:57:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A63C2AC10;
        Thu,  2 May 2019 03:57:13 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 02 May 2019 13:57:03 +1000
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Andreas =?utf-8?Q?Gr=C3=BCnbacher?= 
        <andreas.gruenbacher@gmail.com>,
        Patrick Plagwitz <Patrick_Plagwitz@web.de>,
        "linux-unionfs\@vger.kernel.org" <linux-unionfs@vger.kernel.org>,
        Linux NFS list <linux-nfs@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] overlayfs: ignore empty NFSv4 ACLs in ext4 upperdir
In-Reply-To: <CAOQ4uxjYEjqbLcVYoUaPzp-jqY_3tpPBhO7cE7kbq63XrPRQLQ@mail.gmail.com>
References: <CAJfpeguwUtRWRGmNmimNp-FXzWqMCCQMb24iWPu0w_J0_rOnnw@mail.gmail.com> <20161205151933.GA17517@fieldses.org> <CAJfpegtpkavseTFLspaC7svbvHRq-0-7jvyh63+DK5iWHTGnaQ@mail.gmail.com> <20161205162559.GB17517@fieldses.org> <CAHpGcMKHjic6L+J0qvMYNG9hVCcDO1hEpx4BiEk0ZCKDV39BmA@mail.gmail.com> <266c571f-e4e2-7c61-5ee2-8ece0c2d06e9@web.de> <CAHpGcMKmtppfn7PVrGKEEtVphuLV=YQ2GDYKOqje4ZANhzSgDw@mail.gmail.com> <CAHpGcMKjscfhmrAhwGes0ag2xTkbpFvCO6eiLL_rHz87XE-ZmA@mail.gmail.com> <CAJfpegvRFGOc31gVuYzanzWJ=mYSgRgtAaPhYNxZwHin3Wc0Gw@mail.gmail.com> <CAHc6FU4JQ28BFZE9_8A06gtkMvvKDzFmw9=ceNPYvnMXEimDMw@mail.gmail.com> <20161206185806.GC31197@fieldses.org> <87bm0l4nra.fsf@notabene.neil.brown.name> <CAOQ4uxjYEjqbLcVYoUaPzp-jqY_3tpPBhO7cE7kbq63XrPRQLQ@mail.gmail.com>
Message-ID: <875zqt4igg.fsf@notabene.neil.brown.name>
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

On Wed, May 01 2019, Amir Goldstein wrote:

> On Wed, May 1, 2019 at 10:03 PM NeilBrown <neilb@suse.com> wrote:
>>
>> On Tue, Dec 06 2016, J. Bruce Fields wrote:
>>
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
>> >>
>> >> That's how the protocol is specified.
>> >
>> > Yep, even if we could make that change to nfsd it wouldn't help the
>> > client with the large number of other servers that are out there
>> > (including older knfsd's).
>> >
>> > --b.
>> >
>> >> (I'm not saying that that's very helpful.)
>> >>
>> >> Andreas
>>
>> Hi everyone.....
>>  I have a customer facing this problem, and so stumbled onto the email
>>  thread.
>>  Unfortunately it didn't resolve anything.  Maybe I can help kick things
>>  along???
>>
>>  The core problem here is that NFSv4 and ext4 use different and largely
>>  incompatible ACL implementations.  There is no way to accurately
>>  translate from one to the other in general (common specific examples
>>  can be converted).
>>
>>  This means that either:
>>    1/ overlayfs cannot use ext4 for upper and NFS for lower (or vice
>>       versa) or
>>    2/ overlayfs need to accept that sometimes it cannot copy ACLs, and
>>       that is OK.
>>
>>  Silently not copying the ACLs is probably not a good idea as it might
>>  result in inappropriate permissions being given away.
>
> For example? permissions given away to do what?
> Note that ovl_permission() only check permissions of *mounter*
> to read the lower NFS file and ovl_open()/ovl_read_iter() access
> the lower file with *mounter* credentials.
>
> I might be wrong, but seems to me that once admin mounted
> overlayfs with lower NFS, NFS ACLs are not being enforced at all
> even before copy up.

I guess it is just as well that copy-up fails then - if the lower-level
permission check is being ignored.

>
>> So if the
>>  sysadmin wants this (and some clearly do), they need a way to
>>  explicitly say "I accept the risk".  If only standard Unix permissions
>>  are used, there is no risk, so this seems reasonable.
>>
>>  So I would like to propose a new option for overlayfs
>>     nocopyupacl:   when overlayfs is copying a file (or directory etc)
>>         from the lower filesystem to the upper filesystem, it does not
>>         copy extended attributes with the "system." prefix.  These are
>>         used for storing ACL information and this is sometimes not
>>         compatible between different filesystem types (e.g. ext4 and
>>         NFSv4).  Standard Unix ownership permission flags (rwx) *are*
>>         copied so this option does not risk giving away inappropriate
>>         permissions unless the lowerfs uses unusual ACLs.
>>
>>
>
> I am wondering if it would make more sense for nfs to register a
> security_inode_copy_up_xattr() hook.
> That is the mechanism that prevents copying up other security.*
> xattrs?

No, I don't think that would make sense.
Support some day support for nfs4 acls were added to ext4 (not a totally
ridiculous suggestion).  We would then want NFS to allow it's ACLs to be
copied up.

Thanks,
NeilBrown


>
> Thanks,
> Amir.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlzKao8ACgkQOeye3VZi
gblRlBAAvBfk2jX/vg9m1uaP0EEz3Ta0ixcKfA562CyVPtxCJ1i2folavvKXbA7i
zUK9ZURimMkmGoN06wIepjCJRaaCA3G9Q2fw03Z2+LQdzecbfzsWKNQgITJ5IUP9
q3114hOw+oKFPMKDpJBYqwWQfP0gc7mTC114UhTm8gpBfbSwNVeNFzNYO+XX7cjx
VLVvzjNXNgTcSRv3ojhcR3nKE29eCwGlQM4Adr0GEcvUW6lfh/6A89jEHegXmH+j
AJ+15UjNSMNB2MXMT0hZ1GVj1DFPfSu64iP1ZRInVVnYGSphp0EB3atok65dDWU7
TxCgvHU1mOXb8wXY2zQxF+XxZ1Mw+70ADX2JVhFYqJ/aT4FKH9xeHg+AGgXZOv0s
0GhTLr5ffcVDLCcD+Q0MGvEMJDlVEwrjzt8gFNtXbhAQSumkURuDWqJlen+M6GAn
jN0+qRbDZ3fKdlLQOLVdwgdeAxSZmLMPnnbNwt6REFiT7htF67sQUY1wA04lh4o0
rnodztakNYHAUdxM/9mUH66UZuWGvKG7ap+VHjawvboIW788iKLuhAz4PsFyBJW3
v+RMsD/4H2EvrSQN1IzeU5qz1HiPdsbF3QgkFLuciEpfIs8nkNKnnWViNC/hB7tn
Q+VRDogKoYelNX3tlq4812N2EccBkTbQykyayhMiEvzugKsmDvA=
=eO7x
-----END PGP SIGNATURE-----
--=-=-=--
