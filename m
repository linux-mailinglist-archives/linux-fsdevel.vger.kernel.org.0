Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 787166D6C0E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Apr 2023 20:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236432AbjDDSaX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Apr 2023 14:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236624AbjDDS3z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Apr 2023 14:29:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8CB276B3;
        Tue,  4 Apr 2023 11:27:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 598D263873;
        Tue,  4 Apr 2023 18:26:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 117CDC433D2;
        Tue,  4 Apr 2023 18:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680632804;
        bh=x2wyUxBizg5qidb4H+M74LzbnnW05NTYCqgru/fINxI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=XOTcdld9uG1GKtPDTrmdNRirxmLz4r/kc2PmPEvW9ik/76ho6EVxAfHvDE3Hk57nE
         Vkl4zjfJeqbvmi9jI+0qPNaM6ARzU44sEcE0lsWwr9c8coaDAUYVcZL/mlmL+jPkfP
         6oDIY8VBRQPVbHXqV8rjueqDUq0S17slhHz8WI438K7rVhe8FlFjLXjTJtbW4ReEse
         GNlLqRnFfMg1Vi80nuAP5C2Tqcx4Gn464M3lkQL3Z0hYYjnvVsQulQ4v/rUeJ+60b2
         4NAQLdYZzJ8mmf1bhNeSJ4mWDbP8aY048zY6/QihWJGEjrfv3YMxn6oFKjWkAwt0PZ
         hXhtipRRrrapw==
Message-ID: <a7458f6fdfcf902e620fefb7f44a7e4700f761ae.camel@kernel.org>
Subject: Re: [PATCH] fs/9p: Add new options to Documentation
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Schoenebeck <linux_oss@crudebyte.com>,
        Eric Van Hensbergen <ericvh@gmail.com>
Cc:     v9fs-developer@lists.sourceforge.net,
        Eric Van Hensbergen <ericvh@kernel.org>,
        asmadeus@codewreck.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 04 Apr 2023 14:26:42 -0400
In-Reply-To: <5898218.pUKYPoVZaQ@silver>
References: <ZCEIEKC0s/MFReT0@7e9e31583646> <3443961.DhAEVoPbTG@silver>
         <CAFkjPT=j1esw=q-w5KTyHKDZ42BEKCERy-56TiP+Z7tdC=y05w@mail.gmail.com>
         <5898218.pUKYPoVZaQ@silver>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, 2023-04-02 at 16:07 +0200, Christian Schoenebeck wrote:
> +CC: Jeff for experience on this caching issue with NFS ...
>=20
> On Tuesday, March 28, 2023 5:51:51 PM CEST Eric Van Hensbergen wrote:
> > As I work through the documentation rework and to some extent the
> > testing matrix -- I am reconsidering some choices and wanted to open
> > up the discussion here.
> >=20
> > TLDR; I'm thinking of reworking the cache options before the merge
> > window to keep things simple while setting up for some of the future
> > options.
>=20
> Yeah, revising the 9p cache options highly makes sense!
>=20
> So what is the plan on this now? I saw you sent a new patch with the "old=
"
> options today? So is this one here deferred?
>=20
> > While we have a bunch of new options, in practice I expect users to
> > probably consolidate around three models: no caching, tight caches,
> > and expiring caches with fscache being an orthogonal add-on to the
> > last two.
>=20
> Actually as of today I don't know why somebody would want to use fscache
> instead of loose. Does it actually make sense to keep fscache and if yes =
why?
>=20
> > The ultimate goal is to simplify the options based on expected use mode=
ls:
> >=20
> > - cache=3D[ none, file, all ] (none is currently default)
>=20
> dir?
>=20
> > - write_policy =3D [ *writethrough, writeback ] (writethrough would be =
default)
> > - cache_validate =3D [ never, *open, x (seconds) ]  (cache_validate
> > would default to open)
>=20
> Jeff came up with the point that NFS uses a slicing time window for NFS. =
So
> the question is, would it make sense to add an option x seconds that migh=
t be
> dropped soon anyway?

See the acregmin/acregmax/acdirmin/acdirmax settings in nfs(5). What
you're talking about is basically adding an actimeo=3D option.

If you're revising options for this stuff, then consider following NFS's
naming. Not that they are better in any sense, but they are at least
familiar to administrators.

As far as the sliding window goes, the way it tracks that is a bit
arcane, but in include/linux/nfs_fs.h:


        /*
         * read_cache_jiffies is when we started read-caching this inode.
         * attrtimeo is for how long the cached information is assumed
         * to be valid. A successful attribute revalidation doubles
         * attrtimeo (up to acregmax/acdirmax), a failure resets it to
         * acregmin/acdirmin.
         *
         * We need to revalidate the cached attrs for this inode if
         *
         *      jiffies - read_cache_jiffies >=3D attrtimeo
         *
         * Please note the comparison is greater than or equal
         * so that zero timeout values can be specified.
         */


That's probably what I'd aim for here.

> > - fscache
> >=20
> > So, mapping of existing (deprecated) legacy modes:
> > - none (obvious) write_policy=3Dwritethrough
> > - *readahead -> cache=3Dfile cache_validate_open write_policy=3Dwriteth=
rough
> > - mmap -> cache=3Dfile cache_validate=3Dopen write_policy=3Dwriteback
>=20
> Mmm, why is that "file"? To me "file" sounds like any access to files is
> cached, whereas cache=3Dmmap just uses the cache if mmap() was called, no=
t for
> any other file access.
>=20
> > - loose -> cache=3Dall cache_validate=3Dnever write_policy=3Dwriteback
> > - fscache -> cache=3Dall cache_validate=3Dnever write_policy=3Dwritebac=
k &
> > fscache enabled
> >=20
> > Some things I'm less certain of: cache_validation is probably an
> > imperfect term as is using 'open' as one of the options, in this case
> > I'm envisioning 'open' to mean open-to-close coherency for file
> > caching (cache is only validated on open) and validation on lookup for
> > dir-cache coherency (using qid.version). Specifying a number here
> > expires existing caches and requires validation after a certain number
> > of seconds (is that the right granularity)?
>=20
> Personally I would then really call it open-to-close or opentoclose and w=
aste
> some more characters in favour of clarity.
>=20
> > So, I think this is more clear from a documentation standpoint, but
> > unfortuantely I haven't reduced the test matrix much - in fact I've
> > probably made it worse. I expect the common cases to basically be:
> > - cache=3Dnone
> > - new default? (cache=3Dall, write_policy=3Dwriteback, cache_validate=
=3Dopen)
> > - fscache w/(cache=3Dall, write_policy=3Dwriteback, cache_validate=3D5)
> >=20
> > Which would give us 3 configurations to test against versus 25
> > (assuming testing for one time value for cache-validate=3Dx). Important
> > to remember that this is just cache mode tests, the other mount
> > options act as multipliers.
> >=20
> > Thoughts?  Alternatives?
> >=20
> >         -eric
> >=20
> > On Mon, Mar 27, 2023 at 10:38=E2=80=AFAM Christian Schoenebeck
> > <linux_oss@crudebyte.com> wrote:
> > >=20
> > > On Monday, March 27, 2023 5:05:52 AM CEST Eric Van Hensbergen wrote:
> > > > Need to update the documentation for new mount flags
> > > > and cache modes.
> > > >=20
> > > > Signed-off-by: Eric Van Hensbergen <ericvh@kernel.org>
> > > > ---
> > > >  Documentation/filesystems/9p.rst | 29 ++++++++++++++++------------=
-
> > > >  1 file changed, 16 insertions(+), 13 deletions(-)
> > > >=20
> > > > diff --git a/Documentation/filesystems/9p.rst b/Documentation/files=
ystems/9p.rst
> > > > index 0e800b8f73cc..6d257854a02a 100644
> > > > --- a/Documentation/filesystems/9p.rst
> > > > +++ b/Documentation/filesystems/9p.rst
> > > > @@ -78,19 +78,18 @@ Options
> > > >               offering several exported file systems.
> > > >=20
> > > >    cache=3Dmode specifies a caching policy.  By default, no caches =
are used.
> > > > -
> > > > -                        none
> > > > -                             default no cache policy, metadata and=
 data
> > > > -                                alike are synchronous.
> > > > -                     loose
> > > > -                             no attempts are made at consistency,
> > > > -                                intended for exclusive, read-only =
mounts
> > > > -                        fscache
> > > > -                             use FS-Cache for a persistent, read-o=
nly
> > > > -                             cache backend.
> > > > -                        mmap
> > > > -                             minimal cache that is only used for r=
ead-write
> > > > -                                mmap.  Northing else is cached, li=
ke cache=3Dnone
> > > > +             Modes are progressive and inclusive.  For example, sp=
ecifying fscache
> > > > +             will use loose caches, writeback, and readahead.  Due=
 to their
> > > > +             inclusive nature, only one cache mode can be specifie=
d per mount.
> > >=20
> > > I would highly recommend to rather specify below for each option "thi=
s option
> > > implies writeback, readahead ..." etc., as it is not obvious otherwis=
e which
> > > option would exactly imply what. It is worth those extra few lines IM=
O to
> > > avoid confusion.
> > >=20
> > > > +
> > > > +                     =3D=3D=3D=3D=3D=3D=3D=3D=3D       =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > +                     none            no cache of file or metadata
> > > > +                     readahead       readahead caching of files
> > > > +                     writeback       delayed writeback of files
> > > > +                     mmap            support mmap operations read/=
write with cache
> > > > +                     loose           meta-data and file cache with=
 no coherency
> > > > +                     fscache         use FS-Cache for a persistent=
 cache backend
> > > > +                     =3D=3D=3D=3D=3D=3D=3D=3D=3D       =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > >=20
> > > >    debug=3Dn    specifies debug level.  The debug level is a bitmas=
k.
> > > >=20
> > > > @@ -137,6 +136,10 @@ Options
> > > >               This can be used to share devices/named pipes/sockets=
 between
> > > >               hosts.  This functionality will be expanded in later =
versions.
> > > >=20
> > > > +  directio   bypass page cache on all read/write operations
> > > > +
> > > > +  ignoreqv   ignore qid.version=3D=3D0 as a marker to ignore cache
> > > > +
> > > >    noxattr    do not offer xattr functions on this mount.
> > > >=20
> > > >    access     there are four access modes.
> > > >=20
> > >=20
> > >=20
> > >=20
> > >=20
> >=20
>=20
>=20
>=20
>=20

--=20
Jeff Layton <jlayton@kernel.org>
