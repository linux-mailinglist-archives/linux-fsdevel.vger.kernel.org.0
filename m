Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44604D9E6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2019 00:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbfD1W5s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 28 Apr 2019 18:57:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:60790 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726393AbfD1W5s (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 28 Apr 2019 18:57:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E1A09AD26;
        Sun, 28 Apr 2019 22:57:45 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Date:   Mon, 29 Apr 2019 08:57:37 +1000
Cc:     Andreas Dilger <adilger@dilger.ca>,
        "J. Bruce Fields" <bfields@redhat.com>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>, abe@purdue.edu,
        lsof-l@lists.purdue.edu, util-linux@vger.kernel.org,
        Jeff Layton <jlayton@redhat.com>,
        James Simmons <uja.ornl@gmail.com>
Subject: Re: [PATCH 00/10] exposing knfsd opens to userspace
In-Reply-To: <20190427190038.GB9568@fieldses.org>
References: <1556201060-7947-1-git-send-email-bfields@redhat.com> <B37B2837-E8C8-41EA-9A2D-3F8B93304FDD@dilger.ca> <87lfzx65ax.fsf@notabene.neil.brown.name> <60EB550C-B79C-4DB4-AE3D-F1FCEB49EDA1@dilger.ca> <20190426125611.GA23112@fieldses.org> <87imv05nkk.fsf@notabene.neil.brown.name> <20190427190038.GB9568@fieldses.org>
Message-ID: <874l6h68m6.fsf@notabene.neil.brown.name>
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

On Sat, Apr 27 2019, J. Bruce Fields wrote:

> On Sat, Apr 27, 2019 at 09:55:23AM +1000, NeilBrown wrote:
>> On Fri, Apr 26 2019, J. Bruce Fields wrote:
>> > But it's true that from the start nfsd didn't really fit the model
>> > of a single (possibly writeable) attribute per file.
>>=20
>> Depends on what you mean by that.  Original files where write-only and
>> where slightly complex attributes.
>
> Yes I thought it was just those too, but then I looked at the original
> commit it also included at least the "exports" file.

Maybe it depends on how one chooses to interpret history - never an
exact science.

The "exports" file pre-existed the nfsd filesystem - it was (and still
is) a file in procfs: /proc/fs/nfs/exports.  So the nfsd filesystem was
not created to provide that file.  It was created to replace a
systemcall.
As I said, it subsequently had a variety of things added to it.  exports
was just the first of these.  At least, that is how I choose to see it.

>
>> Writing performed an action, like
>> adding an entry to the export table (first you add a client, then add a
>> client+filesystem to export it).
>>=20
>> This idea for a file performing an action, rather than presenting an
>> attribute, is much the same as the "bind" and "unbind" files you can
>> find in sysfs.
>>=20
>> (see also https://lwn.net/Articles/378884/ for examples of sysfs files
>> that are not one-attribute-per-file)
>
> I'll give that a re-read, thanks.
>
> I did spend maybe a few minutes looking into basing nfsd code on kernfs
> and didn't think it was worth it.  I could take a more serious look.

I think that in your use-case it make lots of sense to have a structured
file for the "opens" (similar to /proc/locks and /proc/mounts).
The "info" could reasonably be several attribute files (clientid,
address, name, minor_version), but I don't think it benefits anyone for
'opens' to be a directory full of directories each with a file for each
of the fields.

So using kernfs would mean pushing for allowing structured files in
kernfs.  I'd be happy to support that, but I think you would need to go
into it convinced that you really wanted to persist.

I think using kernfs is mostly about embedding a kobject in everything,
then setting an appropriate ktype with appropriate attributes.  Not
particularly complex, but certainly a bit of work.

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlzGL+EACgkQOeye3VZi
gbmMyA/+ME5rGGmVjkyQE7H1PGOBxDOJcQsPj/u3COjlH2+UyJzPMU7snDNu1TpC
CosUrgtcqTAY1qDILiMrTrHWpKYK8nXknxEJpJ9Xt6DDy4r3j8KFwM4Q7EO7VPLG
wPV/NCmAmdKWbxhLFt8AelLenp/vHdcvZUUtLHVJFjdTLusya+9I4YZopUOEfKr7
fa4E3I5zLfFhO9ypippDtBVEaplXHLD3/Zg4qemInNkRpzZG4am526CPS7Q+mYwz
ky3cKrY01E6dnJiXDIB/RX9C7MjSE2c5q6lHZIfBbhxF0OTwajTYBtfj4iGznSCz
TjXH5d4yrMgQybamrjAgmUrT/ZEm8iYVenCz4fvyRDYZY8XDrtGQp03XhXGFVB8W
3k5jkWFvUFU0YiRmjueP2D5uBhqOnxYFpJn/sPaD+3SHCDCGBO31snjN/VKdrlsJ
0oQWdrmt2o6F3jjMsBgkmatw/m3oTsP/CiTPjfFtsaXa6QU6EfhDqV13seHvQi+U
p67moc4KoULsd7QnRW0Mi74zaRP9cbNPOhcY0cZfM8eJIXZklO+LoAm86Sc44FFX
RbwqtdsAIn0QgZndLvP8v2oEiMw/QU5ZTzYCrhXTfmOHs5eAVUvbNoqVOao7cmWK
OVOR0RBiYhi3ilwPKFKksRsk8wNSZL2Oy5yD48F7akjjx155erk=
=Z1Pe
-----END PGP SIGNATURE-----
--=-=-=--
