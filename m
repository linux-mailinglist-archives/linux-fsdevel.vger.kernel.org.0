Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 578655B2B36
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Sep 2022 02:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbiIIAv0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Sep 2022 20:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiIIAvZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Sep 2022 20:51:25 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ACB86F578;
        Thu,  8 Sep 2022 17:51:24 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6F3A622489;
        Fri,  9 Sep 2022 00:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1662684682; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uJrkLicI11WUzFSmHsR6j0qEX6vlZwIWXYopZyqiH1o=;
        b=W4vWiN3j780ufqqMCmR4iZjxK1/yIvp2uKT8o5Zg8YJTuaw5FB+SQFTq2GG7ItDt/D5Dfm
        jljkvdxE4ogUe1WkAyryWYnDZV22C1MjjemV7i6nlAli3znLOCk4/Cw51/cekQjTIxjRjl
        tOhl3guhcH/h4wb6CHPjq0EK8mFTdc8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1662684682;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uJrkLicI11WUzFSmHsR6j0qEX6vlZwIWXYopZyqiH1o=;
        b=4vycGZktGLinhYrYvkt9CrUg6ZKIcfBOKy5bMA7UxZGMSlA6fMxGi5noqLmzg1rpet4M8i
        8+5e0oIzXrzmjlAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CD91813A93;
        Fri,  9 Sep 2022 00:51:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ocW4IAKOGmPZNwAAMHmgww
        (envelope-from <neilb@suse.de>); Fri, 09 Sep 2022 00:51:14 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Trond Myklebust" <trondmy@hammerspace.com>
Cc:     "jlayton@kernel.org" <jlayton@kernel.org>,
        "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "xiubli@redhat.com" <xiubli@redhat.com>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "bfields@fieldses.org" <bfields@fieldses.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>,
        "linux-man@vger.kernel.org" <linux-man@vger.kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "tytso@mit.edu" <tytso@mit.edu>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "jack@suse.cz" <jack@suse.cz>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
        "lczerner@redhat.com" <lczerner@redhat.com>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Subject: Re: [man-pages RFC PATCH v4] statx, inode: document the new
 STATX_INO_VERSION field
In-reply-to: <91e31d20d66d6f47fe12c80c34b1cffdfc202b6a.camel@hammerspace.com>
References: <20220907111606.18831-1-jlayton@kernel.org>,
 <166255065346.30452.6121947305075322036@noble.neil.brown.name>,
 <79aaf122743a295ddab9525d9847ac767a3942aa.camel@kernel.org>,
 <20220907125211.GB17729@fieldses.org>,
 <771650a814ab1ff4dc5473d679936b747d9b6cf5.camel@kernel.org>,
 <20220907135153.qvgibskeuz427abw@quack3>,
 <166259786233.30452.5417306132987966849@noble.neil.brown.name>,
 <20220908083326.3xsanzk7hy3ff4qs@quack3>, <YxoIjV50xXKiLdL9@mit.edu>,
 <02928a8c5718590bea5739b13d6b6ebe66cac577.camel@kernel.org>,
 <166267775728.30452.17640919701924887771@noble.neil.brown.name>,
 <91e31d20d66d6f47fe12c80c34b1cffdfc202b6a.camel@hammerspace.com>
Date:   Fri, 09 Sep 2022 10:51:11 +1000
Message-id: <166268467103.30452.1687952324107257676@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 09 Sep 2022, Trond Myklebust wrote:
> On Fri, 2022-09-09 at 08:55 +1000, NeilBrown wrote:
> > On Fri, 09 Sep 2022, Jeff Layton wrote:
> > > On Thu, 2022-09-08 at 11:21 -0400, Theodore Ts'o wrote:
> > > > On Thu, Sep 08, 2022 at 10:33:26AM +0200, Jan Kara wrote:
> > > > > It boils down to the fact that we don't want to call
> > > > > mark_inode_dirty()
> > > > > from IOCB_NOWAIT path because for lots of filesystems that
> > > > > means journal
> > > > > operation and there are high chances that may block.
> > > > >=20
> > > > > Presumably we could treat inode dirtying after i_version change
> > > > > similarly
> > > > > to how we handle timestamp updates with lazytime mount option
> > > > > (i.e., not
> > > > > dirty the inode immediately but only with a delay) but then the
> > > > > time window
> > > > > for i_version inconsistencies due to a crash would be much
> > > > > larger.
> > > >=20
> > > > Perhaps this is a radical suggestion, but there seems to be a lot
> > > > of
> > > > the problems which are due to the concern "what if the file
> > > > system
> > > > crashes" (and so we need to worry about making sure that any
> > > > increments to i_version MUST be persisted after it is
> > > > incremented).
> > > >=20
> > > > Well, if we assume that unclean shutdowns are rare, then perhaps
> > > > we
> > > > shouldn't be optimizing for that case.=C2=A0 So.... what if a file
> > > > system
> > > > had a counter which got incremented each time its journal is
> > > > replayed
> > > > representing an unclean shutdown.=C2=A0 That shouldn't happen often,
> > > > but if
> > > > it does, there might be any number of i_version updates that may
> > > > have
> > > > gotten lost.=C2=A0 So in that case, the NFS client should invalidate
> > > > all of
> > > > its caches.
> > > >=20
> > > > If the i_version field was large enough, we could just prefix the
> > > > "unclean shutdown counter" with the existing i_version number
> > > > when it
> > > > is sent over the NFS protocol to the client.=C2=A0 But if that field
> > > > is too
> > > > small, and if (as I understand things) NFS just needs to know
> > > > when
> > > > i_version is different, we could just simply hash the "unclean
> > > > shtudown counter" with the inode's "i_version counter", and let
> > > > that
> > > > be the version which is sent from the NFS client to the server.
> > > >=20
> > > > If we could do that, then it doesn't become critical that every
> > > > single
> > > > i_version bump has to be persisted to disk, and we could treat it
> > > > like
> > > > a lazytime update; it's guaranteed to updated when we do an clean
> > > > unmount of the file system (and when the file system is frozen),
> > > > but
> > > > on a crash, there is no guaranteee that all i_version bumps will
> > > > be
> > > > persisted, but we do have this "unclean shutdown" counter to deal
> > > > with
> > > > that case.
> > > >=20
> > > > Would this make life easier for folks?
> > > >=20
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0- Ted
> > >=20
> > > Thanks for chiming in, Ted. That's part of the problem, but we're
> > > actually not too worried about that case:
> > >=20
> > > nfsd mixes the ctime in with i_version, so you'd have to
> > > crash+clock
> > > jump backward by juuuust enough to allow you to get the i_version
> > > and
> > > ctime into a state it was before the crash, but with different
> > > data.
> > > We're assuming that that is difficult to achieve in practice.
> > >=20
> > > The issue with a reboot counter (or similar) is that on an unclean
> > > crash
> > > the NFS client would end up invalidating every inode in the cache,
> > > as
> > > all of the i_versions would change. That's probably excessive.
> > >=20
> > > The bigger issue (at the moment) is atomicity: when we fetch an
> > > i_version, the natural inclination is to associate that with the
> > > state
> > > of the inode at some point in time, so we need this to be updated
> > > atomically with certain other attributes of the inode. That's the
> > > part
> > > I'm trying to sort through at the moment.
> >=20
> > I don't think atomicity matters nearly as much as ordering.
> >
> > The i_version must not be visible before the change that it reflects.
> > It is OK for it to be after.=C2=A0 Even seconds after without great cost.=
=C2=A0
> > It
> > is bad for it to be earlier.=C2=A0 Any unlocked gap after the i_version
> > update and before the change is visible can result in a race and
> > incorrect caching.
> >=20
> > Even for directory updates where NFSv4 wants atomic before/after
> > version
> > numbers, they don't need to be atomic w.r.t. the change being
> > visible.
> >=20
> > If three concurrent file creates cause the version number to go from
> > 4
> > to 7, then it is important that one op sees "4,5", one sees "5,6" and
> > one sees "6,7", but it doesn't matter if concurrent lookups only see
> > version 4 even while they can see the newly created names.
> >=20
> > A longer gap increases the risk of an unnecessary cache flush, but it
> > doesn't lead to incorrectness.
> >=20
>=20
> I'm not really sure what you mean when you say that a 'longer gap
> increases the risk of an unnecessary cache flush'. Either the change
> attribute update is atomic with the operation it is recording, or it is
> not. If that update is recorded in the NFS reply as not being atomic,
> then the client will evict all cached data that is associated with that
> change attribute at some point.
>=20
> > So I think we should put the version update *after* the change is
> > visible, and not require locking (beyond a memory barrier) when
> > reading
> > the version. It should be as soon after as practical, bit no sooner.
> >=20
>=20
> Ordering is not a sufficient condition. The guarantee needs to be that
> any application that reads the change attribute, then reads file data
> and then reads the change attribute again will see the 2 change
> attribute values as being the same *if and only if* there were no
> changes to the file data made after the read and before the read of the
> change attribute.

I'm say that only the "only if" is mandatory - getting that wrong has a
correctness cost.
BUT the "if" is less critical.  Getting that wrong has a performance
cost.  We want to get it wrong as rarely as possible, but there is a
performance cost to the underlying filesystem in providing perfection,
and that must be balanced with the performance cost to NFS of providing
imperfect results.

For NFSv4, this is of limited interest for files.
If the client has a delegation, then it is certain that no other client
or server-side application will change the file, so it doesn't need to
pay much attention to change ids.
If the client doesn't have a delegation, then if there is any change to
the changeid, the client cannot be certain that the change wasn't due to
some other client, so it must purge its cache on close or lock.  So fine
details of the changeid aren't interesting (as long as we have the "only
if").=20

For directories, NFSv4 does want precise changeids, but directory ops
needs to be sync for NFS anyway, so the extra burden on the fs is small.


> That includes the case where data was written after the read, and a
> crash occurred after it was committed to stable storage. If you only
> update the version after the written data is visible, then there is a
> possibility that the crash could occur before any change attribute
> update is committed to disk.

I think we all agree that handling a crash is hard.  I think that
should be a separate consideration to how i_version is handled during
normal running.

>=20
> IOW: the minimal condition needs to be that for all cases below, the
> application reads 'state B' as having occurred if any data was
> committed to disk before the crash.
>=20
> Application				Filesystem
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D				=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> read change attr <- 'state A'
> read data <- 'state A'
> 					write data -> 'state B'
> 					<crash>+<reboot>
> read change attr <- 'state B'

The important thing here is to not see 'state A'.  Seeing 'state C'
should be acceptable.  Worst case we could merge in wall-clock time of
system boot, but the filesystem should be able to be more helpful than
that.

NeilBrown


>=20
>=20
> --=20
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
>=20
>=20
>=20
