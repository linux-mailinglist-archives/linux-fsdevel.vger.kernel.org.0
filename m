Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB9875EDD5C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Sep 2022 15:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233487AbiI1NAk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Sep 2022 09:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233247AbiI1NAh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Sep 2022 09:00:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3045D5BC1B;
        Wed, 28 Sep 2022 06:00:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E787AB8205D;
        Wed, 28 Sep 2022 13:00:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 935D6C433D6;
        Wed, 28 Sep 2022 13:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664370026;
        bh=6Plk2FQMLoQz2N+IjumMqtplgUTDGnYPF6Nv6GQhRNo=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Ay67VgSuT1NiQhXFkbJpXpoaU+VoqWPs93W6Y30xzeDDn2RVfeJxXjiKxNd5g94lX
         Tyish0mvFiaer03rTB349TKk6SzTkrWvjt2PWVg/5cLXMfzqslMZ+vRYtnLfTzpLUE
         GXJ63hNNkeUuqs2d2vsIgnnFwpZ3raHliWBhcmmqQJadG6qTK8goxINqhyM4PFoNWm
         ecYEKiEFD4aa+36ie0VHW2NIn85vlpZHG4qqKHwybO9i5bBBTmYppNRYUgSGJDxx2A
         jdTyWKuh+tMQaD/uZlRD6EA+oH1Bxj2b4QBSK/7UnhQUa9nuCluBu/ZMixo2BDPHQM
         rNpHaVWWmTAgg==
Message-ID: <78d8154b3deddf2e9674323a0066db4270eb5b59.camel@kernel.org>
Subject: Re: [PATCH] statx, inode: document the new STATX_VERSION field
From:   Jeff Layton <jlayton@kernel.org>
To:     NeilBrown <neilb@suse.de>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, djwong@kernel.org,
        david@fromorbit.com, trondmy@hammerspace.com,
        viro@zeniv.linux.org.uk, zohar@linux.ibm.com, xiubli@redhat.com,
        chuck.lever@oracle.com, lczerner@redhat.com, jack@suse.cz,
        bfields@fieldses.org, brauner@kernel.org, fweimer@redhat.com,
        linux-man@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ceph-devel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-xfs@vger.kernel.org
Date:   Wed, 28 Sep 2022 09:00:23 -0400
In-Reply-To: <166432039241.17572.3454219701145225283@noble.neil.brown.name>
References: <20220927203550.331261-1-jlayton@kernel.org>
         <166432039241.17572.3454219701145225283@noble.neil.brown.name>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2022-09-28 at 09:13 +1000, NeilBrown wrote:
> On Wed, 28 Sep 2022, Jeff Layton wrote:
> > I'm proposing to expose the inode change attribute via statx [1]. Docum=
ent
> > what this value means and what an observer can infer from it changing.
> >=20
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> >=20
> > [1]: https://lore.kernel.org/linux-nfs/d9c065939af2728b1c0768d5ef752699=
5b634902.camel@kernel.org/T/#t
> > ---
> >  man2/statx.2 | 13 +++++++++++++
> >  man7/inode.7 | 31 +++++++++++++++++++++++++++++++
> >  2 files changed, 44 insertions(+)
> >=20
> > Another RFC posting to hopefully nail down the desired semantics. I
> > purposefully left out verbiage around atomicity, with the expectation
> > that we should be able to make the existing filesystems that support
> > i_version bump the counter after a write instead of before.
>=20
> I think we do need documentation about ordering.  Users will depend on
> the version number not being seen to increase before the change is
> visible.  They may also depend on the increase being visible when a
> {f,i,fa}notify event is generated.  Having this explicitly documented
> gives fs/vfs developers a clear reference, and application developers a
> clear promise.
>=20
> >=20
> > Also, for v5:
> > - drop _INO/_ino from the name (it's redunant)
> > - add STATX_ATTR_VERSION_MONOTONIC
> >=20
> > diff --git a/man2/statx.2 b/man2/statx.2
> > index 0d1b4591f74c..b2fdb5ddf97a 100644
> > --- a/man2/statx.2
> > +++ b/man2/statx.2
> > @@ -62,6 +62,7 @@ struct statx {
> >      __u32 stx_dev_major;   /* Major ID */
> >      __u32 stx_dev_minor;   /* Minor ID */
> >      __u64 stx_mnt_id;      /* Mount ID */
> > +    __u64 stx_version; /* Inode change attribute */
> >  };
> >  .EE
> >  .in
> > @@ -247,6 +248,7 @@ STATX_BTIME	Want stx_btime
> >  STATX_ALL	The same as STATX_BASIC_STATS | STATX_BTIME.
> >  	It is deprecated and should not be used.
> >  STATX_MNT_ID	Want stx_mnt_id (since Linux 5.8)
> > +STATX_VERSION	Want stx_version (DRAFT)
> >  .TE
> >  .in
> >  .PP
> > @@ -407,10 +409,16 @@ This is the same number reported by
> >  .BR name_to_handle_at (2)
> >  and corresponds to the number in the first field in one of the records=
 in
> >  .IR /proc/self/mountinfo .
> > +.TP
> > +.I stx_version
> > +The inode version, also known as the inode change attribute. See
> > +.BR inode (7)
> > +for details.
> >  .PP
> >  For further information on the above fields, see
> >  .BR inode (7).
> >  .\"
> > +.TP
> >  .SS File attributes
> >  The
> >  .I stx_attributes
> > @@ -489,6 +497,11 @@ without an explicit
> >  See
> >  .BR mmap (2)
> >  for more information.
> > +.TP
> > +.BR STATX_ATTR_VERSION_MONOTONIC " (since Linux 6.?)"
> > +The stx_version value monotonically increases over time and will never=
 appear
> > +to go backward, even in the event of a crash. This can allow an applic=
ation to
> > +make a better determination about ordering when viewing different vers=
ions.
> >  .SH RETURN VALUE
> >  On success, zero is returned.
> >  On error, \-1 is returned, and
> > diff --git a/man7/inode.7 b/man7/inode.7
> > index 9b255a890720..ec7f80dacaa8 100644
> > --- a/man7/inode.7
> > +++ b/man7/inode.7
> > @@ -184,6 +184,12 @@ Last status change timestamp (ctime)
> >  This is the file's last status change timestamp.
> >  It is changed by writing or by setting inode information
> >  (i.e., owner, group, link count, mode, etc.).
> > +.TP
> > +Inode version (version)
> > +(not returned in the \fIstat\fP structure); \fIstatx.stx_version\fP
> > +.IP
> > +This is the inode change counter. See the discussion of
> > +\fBthe inode version counter\fP, below.
> >  .PP
> >  The timestamp fields report time measured with a zero point at the
> >  .IR Epoch ,
> > @@ -424,6 +430,31 @@ on a directory means that a file
> >  in that directory can be renamed or deleted only by the owner
> >  of the file, by the owner of the directory, and by a privileged
> >  process.
> > +.SS The inode version counter
> > +.PP
> > +The
> > +.I statx.stx_version
> > +field is the inode change counter. Any operation that would result in =
a
> > +change to \fIstatx.stx_ctime\fP must result in an increase to this val=
ue.
> > +The value must increase even in the case where the ctime change is not
> > +evident due to coarse timestamp granularity.
>=20
> I think "could result" rather than "would result".
>=20
> I'm a little uncomfortable with "must result" given that we don't
> increase the value when the previous value hasn't been seen.
> We could say "must cause subsequent reads of this counter to be larger
> than any previous read", but that is somewhat verbose.
>=20

Phrasing this is tricky. We want to start incrementing i_version after a
write rather than before, but that means there will be a window where a
read would show the new data but the stx_version hasn't been incremented
yet. I think I'll just add a separate paragraph spelling that out.

> > +.PP
> > +An observer cannot infer anything from amount of increase about the
> > +nature or magnitude of the change. If the returned value is different
> > +from the last time it was checked, then something has made an explicit
> > +data and/or metadata change to the inode.
>=20
> Maybe it would be enough to be more explicit here:
>  ...  or magnitude of that change.  In fact, a single increment can
>  reflect multiple discrete changes if the value was not checked during
>  those changes.
> ??
>=20
> Maybe it is a small point, but these two paragraphs seem to be
> contradictory.  If a change MUST increase the counter, then surely 6
> changes MUST increase the counter by at least 6, so you CAN infer
> something from the magnitude..
>=20
>=20
> I would also prefer using the passive voice rather than the vague
> "something".
> ...  then an explicit data and/or metadata change has been made to the
> inode.
>=20

Good points. I made those changes.

> > +.PP
> > +In the event of a system crash this value can appear to go backward,
> > +if it were queried before being written to the backing store. If
> > +the value were then incremented again after restart, then an observer
>=20
> I think the "incremented after restart" is irrelevant.  If the value is
> queried before being written to backing store, and then after a crash
> the value from backing store is used, the value will appear to go
> backwards.  This is enough to mean it isn't MONOTONIC.
>=20

Ok.

> > +could miss noticing a change. Applications that persist stx_version va=
lues
> > +across a reboot should take care to mitigate this problem. If the file=
system
> > +reports \fISTATX_ATTR_VERSION_MONOTONIC\fP in stx_attributes, then it =
is not
> > +subject to this problem.
>=20
> I do like the addition of STATX_ATTR_VERSION_MONOTONIC here.
>=20

I like communicating this to userland. I wish we had a different way to
do it than using stx_attributes.

According to RFC7862, this has to be a property of the filesystem, not
of an individual inode. You can't have a mix of monotonic and undefined
change attrs on a filesystem. Reporting this per-inode makes it seem
like you can though.

This would probably have been better expressed via something like
fsinfo(). Unfortunately, that didn't make it in, so this is probably the
next best thing. When we document the internal kernel interfaces, we'll
want to ensure that filesystems don't try to set this to different
values on the the same filesystem.



> > +.PP
> > +The stx_version is a Linux extension and is not supported by all files=
ystems.
> > +The application must verify that the \fISTATX_VERSION\fP bit is set in=
 the
> > +returned \fIstatx.stx_mask\fP before relying on this field.
> >  .SH STANDARDS
> >  If you need to obtain the definition of the
> >  .I blkcnt_t
> > --=20
> > 2.37.3
> >=20
> >=20
>=20
> Thanks,
> NeilBrown

Thanks for the input, Neil!

I'll send out a v6 patch in a bit with some revisions.
--=20
Jeff Layton <jlayton@kernel.org>
