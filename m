Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A217E12501
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2019 01:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbfEBXUJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 May 2019 19:20:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:54912 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726022AbfEBXUI (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 May 2019 19:20:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BE18FAE2C;
        Thu,  2 May 2019 23:20:06 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 03 May 2019 09:19:58 +1000
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
Subject: Re: [PATCH] OVL: add honoracl=off mount option.
In-Reply-To: <CAOQ4uxgREaBznnr-jNy-g1oX2gH6dXx9zj8wrs5JBJuVMv_9Pw@mail.gmail.com>
References: <CAJfpeguwUtRWRGmNmimNp-FXzWqMCCQMb24iWPu0w_J0_rOnnw@mail.gmail.com> <20161205151933.GA17517@fieldses.org> <CAJfpegtpkavseTFLspaC7svbvHRq-0-7jvyh63+DK5iWHTGnaQ@mail.gmail.com> <20161205162559.GB17517@fieldses.org> <CAHpGcMKHjic6L+J0qvMYNG9hVCcDO1hEpx4BiEk0ZCKDV39BmA@mail.gmail.com> <266c571f-e4e2-7c61-5ee2-8ece0c2d06e9@web.de> <CAHpGcMKmtppfn7PVrGKEEtVphuLV=YQ2GDYKOqje4ZANhzSgDw@mail.gmail.com> <CAHpGcMKjscfhmrAhwGes0ag2xTkbpFvCO6eiLL_rHz87XE-ZmA@mail.gmail.com> <CAJfpegvRFGOc31gVuYzanzWJ=mYSgRgtAaPhYNxZwHin3Wc0Gw@mail.gmail.com> <CAHc6FU4JQ28BFZE9_8A06gtkMvvKDzFmw9=ceNPYvnMXEimDMw@mail.gmail.com> <20161206185806.GC31197@fieldses.org> <87bm0l4nra.fsf@notabene.neil.brown.name> <8736lx4goa.fsf@notabene.neil.brown.name> <CAOQ4uxgREaBznnr-jNy-g1oX2gH6dXx9zj8wrs5JBJuVMv_9Pw@mail.gmail.com>
Message-ID: <87tvec30m9.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--=-=-=
Content-Type: text/plain

On Thu, May 02 2019, Amir Goldstein wrote:

> On Thu, May 2, 2019 at 12:35 AM NeilBrown <neilb@suse.com> wrote:
>>
>>
>> If the upper and lower layers use incompatible ACL formats, it is not
>> possible to copy the ACL xttr from one to the other, so overlayfs
>> cannot work with them.
>> This happens particularly with NFSv4 which uses system.nfs4_acl, and
>> ext4 which uses system.posix_acl_access.
>>
>> If all ACLs actually make to Unix permissions, then there is no need
>> to copy up the ACLs, but overlayfs cannot determine this.
>>
>> So allow the sysadmin it assert that ACLs are not needed with a mount
>> option
>>   honoracl=off
>> This causes the ACLs to not be copied, so filesystems with different
>> ACL formats can be overlaid together.
>>
>> Signed-off-by: NeilBrown <neilb@suse.com>
>> ---
>>  Documentation/filesystems/overlayfs.txt | 24 ++++++++++++++++++++++++
>>  fs/overlayfs/copy_up.c                  |  9 +++++++--
>>  fs/overlayfs/dir.c                      |  2 +-
>>  fs/overlayfs/overlayfs.h                |  2 +-
>>  fs/overlayfs/ovl_entry.h                |  1 +
>>  fs/overlayfs/super.c                    | 15 +++++++++++++++
>>  6 files changed, 49 insertions(+), 4 deletions(-)
>>
>> diff --git a/Documentation/filesystems/overlayfs.txt b/Documentation/filesystems/overlayfs.txt
>> index eef7d9d259e8..7ad675940c93 100644
>> --- a/Documentation/filesystems/overlayfs.txt
>> +++ b/Documentation/filesystems/overlayfs.txt
>> @@ -245,6 +245,30 @@ filesystem - future operations on the file are barely noticed by the
>>  overlay filesystem (though an operation on the name of the file such as
>>  rename or unlink will of course be noticed and handled).
>>
>> +ACL copy-up
>> +-----------
>> +
>> +When a file that only exists on the lower layer is modified it needs
>> +to be copied up to the upper layer.  This means copying the metadata
>> +and (usually) the data (though see "Metadata only copy up" below).
>> +One part of the metadata can be problematic: the ACLs.
>> +
>> +Now all filesystems support ACLs, and when they do they don't all use
>> +the same format.  A significant conflict appears between POSIX acls
>> +used on many local filesystems, and NFSv4 ACLs used with NFSv4.  There
>> +two formats are, in general, not inter-convertible.
>> +
>> +If a site only uses regular Unix permissions (Read, Write, eXecute by
>> +User, Group and Other), then as these permissions are compatible with
>> +all ACLs, there is no need to copy ACLs.  overlayfs cannot determine
>> +if this is the case itself.
>> +
>> +For this reason, overlayfs supports a mount option "honoracl=off"
>> +which causes ACLs, any "system." extended attribute, on the lower
>> +layer to be ignored and, particularly, not copied to the upper later.
>> +This allows NFSv4 to be overlaid with a local filesystem, but should
>> +only be used if the only access controls used on the filesystem are
>> +Unix permission bits.
>>
>
> I don't know. On the one hand "system." is not only ACLs.

Isn't it?  What else goes in "system." "??

"man xattr" says:

   Extended system attributes
       Extended system attributes are used by the kernel to store system
       objects  such  as  Access Control Lists.  Read and write access
       permissions to system attributes depend on the policy implemented
       for each system attribute implemented by filesystems in the
       kernel.

so it *allows* things other than ACLs, but doesn't confirm that there
are any.

In the kernel source, "XATTR_SYSTEM_PREFIX" is only used with POSIX acls
and "system.sockprotoname" - which is socket specific and no likely to
be found on a filesystem.

"system.
also appears in
   CIFS_XATTR_CIFS_ACL
   SMB3_XATTR_CIFS_ACL
   F2FS_SYSTEM_ADVISE_NAME
   XATTR_NAME_NFSV4_ACL
   SYSTEM_ORANGEFS_KEY

which should all use XATTR_SYSTEM_PREFIX ...

So yes,  I guess they aren't (quite) all ACLs.  Bother.


> On the other hand, "honoracl=off" is not the same as -o noacl,
> but it sure sounds the same.
>
> I'd be a lot more comfortable with "ignore_xattrs=system.nfs4_acl"
> argument takes a comma separated list of xattr prefixes to ignore.

That requires the sysadmin to know a lot more about the internals of the
relevant filesystems.... Maybe that is a good idea, but it feels rather
clunky.

In each of these cases, except maybe POSIX_ACLs, it doesn't make sense
to copy-up the "system." xattr unless it is the exact same filesystem
type.

So if given a "noacl" flag (or similar), ignoring copy-up failure for
all "system." attributes is probably the right thing to do, as ACLs are
the only system. attribute for which it can make any sense at all to
copy them.

Thanks,
NeilBrown


>
> ovl_is_private_xattr() can be generalized to ovl_is_ignored_xattr(),
> going over a blacklist of N>=1 which will also be called from
> ovl_can_list(), because there is no point in listing the ACLs that
> are ignored. right?
>
> Thanks,
> Amir.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlzLex4ACgkQOeye3VZi
gbnB6Q//WricnDPQVD7qTilrjxqd7c8+zXeiH4QHyEC0tIRP4960ZORnDmAGkSr4
Cn+D/sUGpJmH5b6wybid4b8zhhZRdUqYqL7bXQX2Ut5lnjljQv9LeV9ZkQlUXMMU
F11AURU0GmLK7RRZ0eqVz++tIX2rc542cIpXpkVg4GX0L22ww71aNB4S8HdZNbi0
z4jRCuPl7I+aSpnRDkFk380KplHwEWWLXUYJjmNeSWsEte0FKPnPe2HYyv1u+4D1
Q3RxgIh7pMTHdnZ8hsAdVNG6s9cLQiKPu7kpcjddAzZdR50r7RZV5A0ZEmQvde6j
v0c5hjvo+4nHS1/erEf6FbnSCWog6eNV5lQ112RwhgkHmwflZMyzIM+DjOQCSly/
A1fhOgSwSaI4PNt5Ds40WS5MVwFRjTyWN9sLtgIBNzwbXQmzlF/rJvywcMUhplO0
eugtUYpLuFNqrf8K7w5ghenOfbLrYQnq8SPqyrBqLM4dikwbttQY1LgZ1xi3tUM4
TLQzHqK12/BXImd7ZHPqrbdY2jGWCPi/h0VW2PHBNkuYtOoK+lHqCbipteo4CKSb
tbg6fhYCMij39OAFO/pmycVCfoXn73z1vHTuPYUFhRT3nSmABIzcr5MI30ZEk9uB
fm+lAwEoEC8pG2aoWehdAspDRIncZKV6sBGHVCsg+PKPuJoNmD4=
=7gNZ
-----END PGP SIGNATURE-----
--=-=-=--
