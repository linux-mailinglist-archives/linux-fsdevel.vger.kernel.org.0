Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8AA45B2F2D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Sep 2022 08:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbiIIGmB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Sep 2022 02:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbiIIGl7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Sep 2022 02:41:59 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F086C10043D;
        Thu,  8 Sep 2022 23:41:53 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 63F58223CF;
        Fri,  9 Sep 2022 06:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1662705712; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yu9RUrvQxAp2Fwf5ytrIMONKOHocNgrjkYLX/KWmaXI=;
        b=fnx4L3TRvm7ivccqTWoZ0YtWUYcY+D9ZxAZGDhBgo37sBA/T0aQbgG6OHbtlGec9adsq8E
        5HzIEN6DRXftpAKhAUJNpLoKQPTW6mcV+tw35b0VOy4ilMlRbstQPo11SkefQxxUAlodRb
        UJ/mgeNoLD9djtqe0p2bvwr0xGWzjsw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1662705712;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yu9RUrvQxAp2Fwf5ytrIMONKOHocNgrjkYLX/KWmaXI=;
        b=o7rI0SCETDdSZb5fZLS/rndvwmAOsDGOGxBlP8QvX3nqHAyoPxX9zWeZ73w4A6jtSgij2C
        FeUntuj8ItjuWfCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 016AC139D5;
        Fri,  9 Sep 2022 06:41:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id osOjKSjgGmOTHwAAMHmgww
        (envelope-from <neilb@suse.de>); Fri, 09 Sep 2022 06:41:44 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Trond Myklebust" <trondmy@hammerspace.com>
Cc:     "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "xiubli@redhat.com" <xiubli@redhat.com>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "bfields@fieldses.org" <bfields@fieldses.org>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
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
In-reply-to: <8d638cb3c63b0d2da8679b5288d1622fdb387f83.camel@hammerspace.com>
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
 <91e31d20d66d6f47fe12c80c34b1cffdfc202b6a.camel@hammerspace.com>,
 <166268467103.30452.1687952324107257676@noble.neil.brown.name>,
 <166268566751.30452.13562507405746100242@noble.neil.brown.name>,
 <29a6c2e78284e7947ddedf71e5cb9436c9330910.camel@hammerspace.com>,
 <8d638cb3c63b0d2da8679b5288d1622fdb387f83.camel@hammerspace.com>
Date:   Fri, 09 Sep 2022 16:41:41 +1000
Message-id: <166270570118.30452.16939807179630112340@noble.neil.brown.name>
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
> On Fri, 2022-09-09 at 01:10 +0000, Trond Myklebust wrote:
> > On Fri, 2022-09-09 at 11:07 +1000, NeilBrown wrote:
> > > On Fri, 09 Sep 2022, NeilBrown wrote:
> > > > On Fri, 09 Sep 2022, Trond Myklebust wrote:
> > > >=20
> > > > >=20
> > > > > IOW: the minimal condition needs to be that for all cases
> > > > > below,
> > > > > the
> > > > > application reads 'state B' as having occurred if any data was
> > > > > committed to disk before the crash.
> > > > >=20
> > > > > Application=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Filesystem
> > > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> > > > > read change attr <- 'state A'
> > > > > read data <- 'state A'
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0write data -> 'state B'
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0<crash>+<reboot>
> > > > > read change attr <- 'state B'
> > > >=20
> > > > The important thing here is to not see 'state A'.=C2=A0 Seeing 'state
> > > > C'
> > > > should be acceptable.=C2=A0 Worst case we could merge in wall-clock
> > > > time
> > > > of
> > > > system boot, but the filesystem should be able to be more helpful
> > > > than
> > > > that.
> > > >=20
> > >=20
> > > Actually, without the crash+reboot it would still be acceptable to
> > > see
> > > "state A" at the end there - but preferably not for long.
> > > From the NFS perspective, the changeid needs to update by the time
> > > of
> > > a
> > > close or unlock (so it is visible to open or lock), but before that
> > > it
> > > is just best-effort.
> >=20
> > Nope. That will inevitably lead to data corruption, since the
> > application might decide to use the data from state A instead of
> > revalidating it.
> >=20
>=20
> The point is, NFS is not the only potential use case for change
> attributes. We wouldn't be bothering to discuss statx() if it was.

My understanding is that it was primarily a desire to add fstests to
exercise the i_version which motivated the statx extension.
Obviously we should prepare for other uses though.

>=20
> I could be using O_DIRECT, and all the tricks in order to ensure that
> my stock broker application (to choose one example) has access to the
> absolute very latest prices when I'm trying to execute a trade.
> When the filesystem then says 'the prices haven't changed since your
> last read because the change attribute on the database file is the
> same' in response to a statx() request with the AT_STATX_FORCE_SYNC
> flag set, then why shouldn't my application be able to assume it can
> serve those prices right out of memory instead of having to go to disk?

I would think that such an application would be using inotify rather
than having to poll.  But certainly we should have a clear statement of
quality-of-service parameters in the documentation.
If we agree that perfect atomicity is what we want to promise, and that
the cost to the filesystem and the statx call is acceptable, then so be it.

My point wasn't to say that atomicity is bad.  It was that:
 - if the i_version change is visible before the change itself is
   visible, then that is a correctness problem.
 - if the i_version change is only visible some time after the change
   itself is visible, then that is a quality-of-service issue.
I cannot see any room for debating the first.  I do see some room to
debate the second.

Cached writes, directory ops, and attribute changes are, I think, easy
enough to provide truly atomic i_version updates with the change being
visible.

Changes to a shared memory-mapped files is probably the hardest to
provide timely i_version updates for.  We might want to document an
explicit exception for those.  Alternately each request for i_version
would need to find all pages that are writable, remap them read-only to
catch future writes, then update i_version if any were writable (i.e.
->mkwrite had been called).  That is the only way I can think of to
provide atomicity.

O_DIRECT writes are a little easier than mmapped files.  I suspect we
should update the i_version once the device reports that the write is
complete, but a parallel reader could have seem some of the write before
that moment.  True atomicity could only be provided by taking some
exclusive lock that blocked all O_DIRECT writes.  Jeff seems to be
suggesting this, but I doubt the stock broker application would be
willing to make the call in that case.  I don't think I would either.

NeilBrown

>=20
> --=20
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
>=20
>=20
>=20
