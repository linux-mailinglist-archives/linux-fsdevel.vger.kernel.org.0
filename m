Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 720415B042F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Sep 2022 14:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbiIGMr1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Sep 2022 08:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiIGMr0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Sep 2022 08:47:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FF57B99EB;
        Wed,  7 Sep 2022 05:47:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CD91F618AC;
        Wed,  7 Sep 2022 12:47:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 337EEC433D6;
        Wed,  7 Sep 2022 12:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662554844;
        bh=KwuVTdSi4g/A+wQFC39m73YAhBoRhEhLLXwztluQVs4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=D1ZxLLGMhMF9KvxxQ2fWiZLBOm8D/KLxKm7+5K81ML9beEoreeQ+MPEKrRhEIyK2D
         vXg2Hb9XhcS/DXIhIdAk6OD4VlBJiqQ3cfkjUevIjcfG5B4S96NQDopvhbQqKVbKKo
         P7+BCrlVvJRZqR1j/xHcYs3IBijJFc8mMOx72Op0grUOInGYbEnxajJcsYH9jkih6f
         pZe2c1R4GgABxcaW4J7NXjOUaNEqXeILriAhSWb0KlccrqoeSffkdiSZWzkASL6BPg
         YNCfTbdg8L2OYuELzsrZBs/acUK+w49/NITRLlPo0eYfVS5z0bmqt4F9eoDepkqm5p
         9ttkvPFxHUI0w==
Message-ID: <79aaf122743a295ddab9525d9847ac767a3942aa.camel@kernel.org>
Subject: Re: [man-pages RFC PATCH v4] statx, inode: document the new
 STATX_INO_VERSION field
From:   Jeff Layton <jlayton@kernel.org>
To:     NeilBrown <neilb@suse.de>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, djwong@kernel.org,
        david@fromorbit.com, trondmy@hammerspace.com,
        viro@zeniv.linux.org.uk, zohar@linux.ibm.com, xiubli@redhat.com,
        chuck.lever@oracle.com, lczerner@redhat.com, jack@suse.cz,
        bfields@fieldses.org, brauner@kernel.org, fweimer@redhat.com,
        linux-man@vger.kernel.org, linux-api@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-xfs@vger.kernel.org
Date:   Wed, 07 Sep 2022 08:47:20 -0400
In-Reply-To: <166255065346.30452.6121947305075322036@noble.neil.brown.name>
References: <20220907111606.18831-1-jlayton@kernel.org>
         <166255065346.30452.6121947305075322036@noble.neil.brown.name>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2022-09-07 at 21:37 +1000, NeilBrown wrote:
> On Wed, 07 Sep 2022, Jeff Layton wrote:
> > I'm proposing to expose the inode change attribute via statx [1]. Docum=
ent
> > what this value means and what an observer can infer from it changing.
> >=20
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> >=20
> > [1]: https://lore.kernel.org/linux-nfs/20220826214703.134870-1-jlayton@=
kernel.org/T/#t
> > ---
> >  man2/statx.2 |  8 ++++++++
> >  man7/inode.7 | 39 +++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 47 insertions(+)
> >=20
> > v4: add paragraph pointing out the lack of atomicity wrt other changes
> >=20
> > I think these patches are racing with another change to add DIO
> > alignment info to statx. I imagine this will go in after that, so this
> > will probably need to be respun to account for contextual differences.
> >=20
> > What I'm mostly interested in here is getting the sematics and
> > description of the i_version counter nailed down.
> >=20
> > diff --git a/man2/statx.2 b/man2/statx.2
> > index 0d1b4591f74c..d98d5148a442 100644
> > --- a/man2/statx.2
> > +++ b/man2/statx.2
> > @@ -62,6 +62,7 @@ struct statx {
> >      __u32 stx_dev_major;   /* Major ID */
> >      __u32 stx_dev_minor;   /* Minor ID */
> >      __u64 stx_mnt_id;      /* Mount ID */
> > +    __u64 stx_ino_version; /* Inode change attribute */
> >  };
> >  .EE
> >  .in
> > @@ -247,6 +248,7 @@ STATX_BTIME	Want stx_btime
> >  STATX_ALL	The same as STATX_BASIC_STATS | STATX_BTIME.
> >  	It is deprecated and should not be used.
> >  STATX_MNT_ID	Want stx_mnt_id (since Linux 5.8)
> > +STATX_INO_VERSION	Want stx_ino_version (DRAFT)
> >  .TE
> >  .in
> >  .PP
> > @@ -407,10 +409,16 @@ This is the same number reported by
> >  .BR name_to_handle_at (2)
> >  and corresponds to the number in the first field in one of the records=
 in
> >  .IR /proc/self/mountinfo .
> > +.TP
> > +.I stx_ino_version
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
> > diff --git a/man7/inode.7 b/man7/inode.7
> > index 9b255a890720..8e83836594d8 100644
> > --- a/man7/inode.7
> > +++ b/man7/inode.7
> > @@ -184,6 +184,12 @@ Last status change timestamp (ctime)
> >  This is the file's last status change timestamp.
> >  It is changed by writing or by setting inode information
> >  (i.e., owner, group, link count, mode, etc.).
> > +.TP
> > +Inode version (i_version)
> > +(not returned in the \fIstat\fP structure); \fIstatx.stx_ino_version\f=
P
> > +.IP
> > +This is the inode change counter. See the discussion of
> > +\fBthe inode version counter\fP, below.
> >  .PP
> >  The timestamp fields report time measured with a zero point at the
> >  .IR Epoch ,
> > @@ -424,6 +430,39 @@ on a directory means that a file
> >  in that directory can be renamed or deleted only by the owner
> >  of the file, by the owner of the directory, and by a privileged
> >  process.
> > +.SS The inode version counter
> > +.PP
> > +The
> > +.I statx.stx_ino_version
> > +field is the inode change counter. Any operation that would result in =
a
> > +change to \fIstatx.stx_ctime\fP must result in an increase to this val=
ue.
> > +The value must increase even in the case where the ctime change is not
> > +evident due to coarse timestamp granularity.
> > +.PP
> > +An observer cannot infer anything from amount of increase about the
> > +nature or magnitude of the change. If the returned value is different
> > +from the last time it was checked, then something has made an explicit
> > +data and/or metadata change to the inode.
> > +.PP
> > +The change to \fIstatx.stx_ino_version\fP is not atomic with respect t=
o the
> > +other changes in the inode. On a write, for instance, the i_version it=
 usually
> > +incremented before the data is copied into the pagecache. Therefore it=
 is
> > +possible to see a new i_version value while a read still shows the old=
 data.
>=20
> Doesn't that make the value useless?
>=20

No, I don't think so. It's only really useful for comparing to an older
sample anyway. If you do "statx; read; statx" and the value hasn't
changed, then you know that things are stable.=20

> Surely the change number must
> change no sooner than the change itself is visible, otherwise stale data
> could be cached indefinitely.
>=20
> If currently implementations behave this way, surely they are broken.

It's certainly not ideal but we've never been able to offer truly atomic
behavior here given that Linux is a general-purpose OS. The behavior is
a little inconsistent too:

The c/mtime update and i_version bump on directories (mostly) occur
after the operation. c/mtime updates for files however are mostly driven
by calls to file_update_time, which happens before data is copied to the
pagecache.

It's not clear to me why it's done this way. Maybe to ensure that the
metadata is up to date in the event that a statx comes in? Improving
this would be nice, but I don't see a way to do that without regressing
performance.
--=20
Jeff Layton <jlayton@kernel.org>
