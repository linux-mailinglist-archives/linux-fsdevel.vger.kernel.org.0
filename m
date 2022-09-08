Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95CE15B29B8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Sep 2022 00:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbiIHW5c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Sep 2022 18:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbiIHW5E (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Sep 2022 18:57:04 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A537A61D4;
        Thu,  8 Sep 2022 15:56:26 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 827F4336AE;
        Thu,  8 Sep 2022 22:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1662677770; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V/LYZrcvNodh/7MwFf1oux5I1ZCF23mKPOyEkmy1bmY=;
        b=yf86J7MMb0nSJGInF2byX3Gx0TVw6ItHMAwhXNkBV93Lxnb84Qkn0RyR7Tf8XQUPqMgnMU
        oKzYjq7adc4eDLEE2j7RQZV8Vuz7Gaz4IwoFQlV90InDd76vyTEJ3hWZmtAGfa2/NLUJKV
        vy/EMltmy0OecdJgQ2Sw95MVDk3B5ro=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1662677770;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V/LYZrcvNodh/7MwFf1oux5I1ZCF23mKPOyEkmy1bmY=;
        b=bpUSGYajGzTyZf5k90o8rBQqb6HoSS09yv2OsUMZ63gqKCCwDDr93pY/nvFh4RrB4YTiWg
        l9kL/8PM8/6souCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E523113A6D;
        Thu,  8 Sep 2022 22:56:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id hDpRJgBzGmPODwAAMHmgww
        (envelope-from <neilb@suse.de>); Thu, 08 Sep 2022 22:56:00 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Jeff Layton" <jlayton@kernel.org>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, "Jan Kara" <jack@suse.cz>,
        "J. Bruce Fields" <bfields@fieldses.org>, adilger.kernel@dilger.ca,
        djwong@kernel.org, david@fromorbit.com, trondmy@hammerspace.com,
        viro@zeniv.linux.org.uk, zohar@linux.ibm.com, xiubli@redhat.com,
        chuck.lever@oracle.com, lczerner@redhat.com, brauner@kernel.org,
        fweimer@redhat.com, linux-man@vger.kernel.org,
        linux-api@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ceph-devel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [man-pages RFC PATCH v4] statx, inode: document the new
 STATX_INO_VERSION field
In-reply-to: <02928a8c5718590bea5739b13d6b6ebe66cac577.camel@kernel.org>
References: <20220907111606.18831-1-jlayton@kernel.org>,
 <166255065346.30452.6121947305075322036@noble.neil.brown.name>,
 <79aaf122743a295ddab9525d9847ac767a3942aa.camel@kernel.org>,
 <20220907125211.GB17729@fieldses.org>,
 <771650a814ab1ff4dc5473d679936b747d9b6cf5.camel@kernel.org>,
 <20220907135153.qvgibskeuz427abw@quack3>,
 <166259786233.30452.5417306132987966849@noble.neil.brown.name>,
 <20220908083326.3xsanzk7hy3ff4qs@quack3>, <YxoIjV50xXKiLdL9@mit.edu>,
 <02928a8c5718590bea5739b13d6b6ebe66cac577.camel@kernel.org>
Date:   Fri, 09 Sep 2022 08:55:57 +1000
Message-id: <166267775728.30452.17640919701924887771@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 09 Sep 2022, Jeff Layton wrote:
> On Thu, 2022-09-08 at 11:21 -0400, Theodore Ts'o wrote:
> > On Thu, Sep 08, 2022 at 10:33:26AM +0200, Jan Kara wrote:
> > > It boils down to the fact that we don't want to call mark_inode_dirty()
> > > from IOCB_NOWAIT path because for lots of filesystems that means journal
> > > operation and there are high chances that may block.
> > >=20
> > > Presumably we could treat inode dirtying after i_version change similar=
ly
> > > to how we handle timestamp updates with lazytime mount option (i.e., not
> > > dirty the inode immediately but only with a delay) but then the time wi=
ndow
> > > for i_version inconsistencies due to a crash would be much larger.
> >=20
> > Perhaps this is a radical suggestion, but there seems to be a lot of
> > the problems which are due to the concern "what if the file system
> > crashes" (and so we need to worry about making sure that any
> > increments to i_version MUST be persisted after it is incremented).
> >=20
> > Well, if we assume that unclean shutdowns are rare, then perhaps we
> > shouldn't be optimizing for that case.  So.... what if a file system
> > had a counter which got incremented each time its journal is replayed
> > representing an unclean shutdown.  That shouldn't happen often, but if
> > it does, there might be any number of i_version updates that may have
> > gotten lost.  So in that case, the NFS client should invalidate all of
> > its caches.
> >=20
> > If the i_version field was large enough, we could just prefix the
> > "unclean shutdown counter" with the existing i_version number when it
> > is sent over the NFS protocol to the client.  But if that field is too
> > small, and if (as I understand things) NFS just needs to know when
> > i_version is different, we could just simply hash the "unclean
> > shtudown counter" with the inode's "i_version counter", and let that
> > be the version which is sent from the NFS client to the server.
> >=20
> > If we could do that, then it doesn't become critical that every single
> > i_version bump has to be persisted to disk, and we could treat it like
> > a lazytime update; it's guaranteed to updated when we do an clean
> > unmount of the file system (and when the file system is frozen), but
> > on a crash, there is no guaranteee that all i_version bumps will be
> > persisted, but we do have this "unclean shutdown" counter to deal with
> > that case.
> >=20
> > Would this make life easier for folks?
> >=20
> > 						- Ted
>=20
> Thanks for chiming in, Ted. That's part of the problem, but we're
> actually not too worried about that case:
>=20
> nfsd mixes the ctime in with i_version, so you'd have to crash+clock
> jump backward by juuuust enough to allow you to get the i_version and
> ctime into a state it was before the crash, but with different data.
> We're assuming that that is difficult to achieve in practice.
>=20
> The issue with a reboot counter (or similar) is that on an unclean crash
> the NFS client would end up invalidating every inode in the cache, as
> all of the i_versions would change. That's probably excessive.
>=20
> The bigger issue (at the moment) is atomicity: when we fetch an
> i_version, the natural inclination is to associate that with the state
> of the inode at some point in time, so we need this to be updated
> atomically with certain other attributes of the inode. That's the part
> I'm trying to sort through at the moment.

I don't think atomicity matters nearly as much as ordering.
The i_version must not be visible before the change that it reflects.
It is OK for it to be after.  Even seconds after without great cost.  It
is bad for it to be earlier.  Any unlocked gap after the i_version
update and before the change is visible can result in a race and
incorrect caching.

Even for directory updates where NFSv4 wants atomic before/after version
numbers, they don't need to be atomic w.r.t. the change being visible.

If three concurrent file creates cause the version number to go from 4
to 7, then it is important that one op sees "4,5", one sees "5,6" and
one sees "6,7", but it doesn't matter if concurrent lookups only see
version 4 even while they can see the newly created names.

A longer gap increases the risk of an unnecessary cache flush, but it
doesn't lead to incorrectness.

So I think we should put the version update *after* the change is
visible, and not require locking (beyond a memory barrier) when reading
the version. It should be as soon after as practical, bit no sooner.

NeilBrown

