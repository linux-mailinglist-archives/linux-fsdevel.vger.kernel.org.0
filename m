Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F78055F37E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jun 2022 04:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbiF2Cts (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jun 2022 22:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiF2Cto (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jun 2022 22:49:44 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C60E22506
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jun 2022 19:49:43 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 37AF621E3D;
        Wed, 29 Jun 2022 02:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1656470982; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xKRc4WwEjybUrjHRLoWT3s8rXnexBo8TiwxExotykDI=;
        b=qhtTfohe7X2KieQ534b/fU/lLFu6GT6AbMYlJ3T0yZs67RR0EnSr7kDjnJClBYxThQesJe
        SzS2jY/MIVQx+VUnRBZvzE6jauTcpCb16MCZmNZpweKHeu9yf5ecdhIz536Vxj8zHZ6Aql
        LNR2x4JH4xN7KukG0NnD3awN8sbuqEA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1656470982;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xKRc4WwEjybUrjHRLoWT3s8rXnexBo8TiwxExotykDI=;
        b=XeLIJ0AcQMntavGdAeN4joDfZ8QUoKiWXmSqtPpdodZgCBH2SzU6AySVdSyh9+5COr4vV7
        tDnEOJ1XQf1kNpAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8932913AB2;
        Wed, 29 Jun 2022 02:49:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id QEmVEcS9u2KTawAAMHmgww
        (envelope-from <neilb@suse.de>); Wed, 29 Jun 2022 02:49:40 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Dave Chinner" <david@fromorbit.com>
Cc:     "James Yonan" <james@openvpn.net>,
        "Amir Goldstein" <amir73il@gmail.com>,
        "Al Viro" <viro@zeniv.linux.org.uk>,
        "linux-fsdevel" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] namei: implemented RENAME_NEWER flag for renameat2()
 conditional replace
In-reply-to: <20220629023557.GN1098723@dread.disaster.area>
References: <20220627221107.176495-1-james@openvpn.net>,
 <Yrs7lh6hG44ERoiM@ZenIV>,
 <CAOQ4uxgoZe8UUftRKf=b--YmrKJ4wdDX99y7G8U2WTuuVsyvdA@mail.gmail.com>,
 <03ee39fa-7cfd-5155-3559-99ec8c8a2d32@openvpn.net>,
 <20220629014323.GM1098723@dread.disaster.area>,
 <165646842481.15378.14054777682756518611@noble.neil.brown.name>,
 <20220629023557.GN1098723@dread.disaster.area>
Date:   Wed, 29 Jun 2022 12:49:37 +1000
Message-id: <165647097715.15378.14537296125194430268@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 29 Jun 2022, Dave Chinner wrote:
> On Wed, Jun 29, 2022 at 12:07:04PM +1000, NeilBrown wrote:
> > On Wed, 29 Jun 2022, Dave Chinner wrote:
> > > On Tue, Jun 28, 2022 at 05:19:12PM -0600, James Yonan wrote:
> > > > On 6/28/22 12:34, Amir Goldstein wrote:
> > > > > On Tue, Jun 28, 2022 at 8:44 PM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
> > > > > > On Mon, Jun 27, 2022 at 04:11:07PM -0600, James Yonan wrote:
> > > > > >=20
> > > > > > >            && d_is_positive(new_dentry)
> > > > > > >            && timespec64_compare(&d_backing_inode(old_dentry)->=
i_mtime,
> > > > > > >                                  &d_backing_inode(new_dentry)->=
i_mtime) <=3D 0)
> > > > > > >                goto exit5;
> > > > > > >=20
> > > > > > > It's pretty cool in a way that a new atomic file operation can =
even be
> > > > > > > implemented in just 5 lines of code, and it's thanks to the exi=
sting
> > > > > > > locking infrastructure around file rename/move that these opera=
tions
> > > > > > > become almost trivial.  Unfortunately, every fs must approve a =
new
> > > > > > > renameat2() flag, so it bloats the patch a bit.
> > > > > > How is it atomic and what's to stabilize ->i_mtime in that test?
> > > > > > Confused...
> > > > > Good point.
> > > > > RENAME_EXCHANGE_WITH_NEWER would have been better
> > > > > in that regard.
> > > > >=20
> > > > > And you'd have to check in vfs_rename() after lock_two_nondirectori=
es()
> > > >=20
> > > > So I mean atomic in the sense that you are comparing the old and new =
mtimes
> > > > inside the lock_rename/unlock_rename critical section in do_renameat2=
(), so
> > >=20
> > > mtime is not stable during rename, even with the inode locked. e.g. a
> > > write page fault occurring concurrently with rename will change
> > > mtime, and so which inode is "newer" can change during the rename
> > > syscall...
> >=20
> > I don't think that is really important for the proposed use case.
>=20
> Sure, but that's not the point. How do you explain it the API
> semantics to an app developer that might want to use this
> functionality? RENAME_EXCHANGE_WITH_NEWER would be atomic in the
> sense you either get the old or new file at the destination, but
> it's not atomic in the sense that it is serialised against all other
> potential modification operations against either the source or
> destination. Hence the "if newer" comparison is not part of the
> "atomic rename" operation that is supposedly being performed...
>=20
> I'm also sceptical of the use of mtime - we can't rely on mtime to
> determine the newer file accurately on all filesystems. e.g. Some
> fileystems only have second granularity in their timestamps, so
> there's a big window where "newer" cannot actually be determined by
> timestamp comparisons.
>=20
> /me is having flashbacks to the bad old days of NFS using inode
> timestamps for change ordering and cache consistency....
>=20
> > In any case where you might be using this new rename flag, the target
> > file wouldn't be open for write, so the mtime wouldn't change.
> > The atomicity is really wanted to make sure the file at the destination
> > name is still the one that was expected (I think).
>=20
> How would you document this, and how would the application be
> expected to handle such a "someone else has this open for write"
> error? There's nothing the app can do about the cause of the
> failure, so how is it expected to handle such an error?

I would document this by saying "The rename will fail if either file is open
for write access as in that case the mtimes cannot be considered to be
stable".

The app would respond as it would to any other unexpected error.

The expectation, as I understand it, is that this is used in situations
when the target file is only changed by a rename.  Someone else opening
the file for O_WRITE would be just as bad as someone else unlinking the
source file so renameat2 gets ENOENT.  In both cases, the new
renameat2() cannot do anything useful, so it shouldn't try.  Equally in
both cases the application cannot do anything useful.

NeilBrown


>=20
> I'm not opposed to adding functionality like this, I'm just pointing
> out problems that I see arising from the insufficiently
> constrained/specified behaviour of the proposed functionality.
>=20
> Cheers,
>=20
> Dave.
> --=20
> Dave Chinner
> david@fromorbit.com
>=20
