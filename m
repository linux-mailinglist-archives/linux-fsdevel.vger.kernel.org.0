Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52D945B294E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Sep 2022 00:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbiIHW37 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Sep 2022 18:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbiIHW35 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Sep 2022 18:29:57 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59555399C3;
        Thu,  8 Sep 2022 15:29:54 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0DD3E1F88C;
        Thu,  8 Sep 2022 22:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1662676193; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XYi+pBRvFMvFKXrZibMQyGhv2Fxedtu18zU52J+7zKo=;
        b=twHBnF2wVKZz1IS9qZbEMJXKJ1DPXeUZvzOpj3kgfapp+yBlVl8RD0f+CbRjO89h/Ji1xX
        yJf+3kJd8R4XTqWK3P+jWunDQ5vHupX3/p9WeWQ3kVOe/VigMOHeiBWAP00Ukd9/c7rpmI
        oTnL3xgh5Zfa4gThb2CJAzIisZV6iR0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1662676193;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XYi+pBRvFMvFKXrZibMQyGhv2Fxedtu18zU52J+7zKo=;
        b=cjwnsYR1mNWlOekSsTFJ9B2EEyfgw0A3y6EzirZ7inWDoQmE2PezK7XeNV2TYwm84AXq+p
        nJ1PJdtyoSeDfOAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CDBBB1322C;
        Thu,  8 Sep 2022 22:29:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id B442IdlsGmMhBwAAMHmgww
        (envelope-from <neilb@suse.de>); Thu, 08 Sep 2022 22:29:45 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Jeff Layton" <jlayton@kernel.org>
Cc:     "Trond Myklebust" <trondmy@hammerspace.com>,
        "bfields@fieldses.org" <bfields@fieldses.org>,
        "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "xiubli@redhat.com" <xiubli@redhat.com>,
        "brauner@kernel.org" <brauner@kernel.org>,
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
        "lczerner@redhat.com" <lczerner@redhat.com>,
        "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Subject: Re: [man-pages RFC PATCH v4] statx, inode: document the new
 STATX_INO_VERSION field
In-reply-to: <f7f852c2cd7757646d9ad8e822f7fd04c467df7d.camel@kernel.org>
References: <20220907111606.18831-1-jlayton@kernel.org>,
 <166255065346.30452.6121947305075322036@noble.neil.brown.name>,
 <79aaf122743a295ddab9525d9847ac767a3942aa.camel@kernel.org>,
 <20220907125211.GB17729@fieldses.org>,
 <771650a814ab1ff4dc5473d679936b747d9b6cf5.camel@kernel.org>,
 <8a71986b4fb61cd9b4adc8b4250118cbb19eec58.camel@hammerspace.com>,
 <c22baa64133a23be3aba81df23b4af866df51343.camel@kernel.org>,
 <166259764365.30452.5588074352157110414@noble.neil.brown.name>,
 <f7f852c2cd7757646d9ad8e822f7fd04c467df7d.camel@kernel.org>
Date:   Fri, 09 Sep 2022 08:29:41 +1000
Message-id: <166267618149.30452.1385850427092221026@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 08 Sep 2022, Jeff Layton wrote:
> On Thu, 2022-09-08 at 10:40 +1000, NeilBrown wrote:
> > On Thu, 08 Sep 2022, Jeff Layton wrote:
> > > On Wed, 2022-09-07 at 13:55 +0000, Trond Myklebust wrote:
> > > > On Wed, 2022-09-07 at 09:12 -0400, Jeff Layton wrote:
> > > > > On Wed, 2022-09-07 at 08:52 -0400, J. Bruce Fields wrote:
> > > > > > On Wed, Sep 07, 2022 at 08:47:20AM -0400, Jeff Layton wrote:
> > > > > > > On Wed, 2022-09-07 at 21:37 +1000, NeilBrown wrote:
> > > > > > > > On Wed, 07 Sep 2022, Jeff Layton wrote:
> > > > > > > > > +The change to \fIstatx.stx_ino_version\fP is not atomic wi=
th
> > > > > > > > > respect to the
> > > > > > > > > +other changes in the inode. On a write, for instance, the
> > > > > > > > > i_version it usually
> > > > > > > > > +incremented before the data is copied into the pagecache.
> > > > > > > > > Therefore it is
> > > > > > > > > +possible to see a new i_version value while a read still
> > > > > > > > > shows the old data.
> > > > > > > >=20
> > > > > > > > Doesn't that make the value useless?
> > > > > > > >=20
> > > > > > >=20
> > > > > > > No, I don't think so. It's only really useful for comparing to =
an
> > > > > > > older
> > > > > > > sample anyway. If you do "statx; read; statx" and the value
> > > > > > > hasn't
> > > > > > > changed, then you know that things are stable.=20
> > > > > >=20
> > > > > > I don't see how that helps.=C2=A0 It's still possible to get:
> > > > > >=20
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0reader=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0writer
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0------=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0------
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0i_version++
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0statx
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0read
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0statx
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0update page cache
> > > > > >=20
> > > > > > right?
> > > > > >=20
> > > > >=20
> > > > > Yeah, I suppose so -- the statx wouldn't necessitate any locking. In
> > > > > that case, maybe this is useless then other than for testing purpos=
es
> > > > > and userland NFS servers.
> > > > >=20
> > > > > Would it be better to not consume a statx field with this if so? Wh=
at
> > > > > could we use as an alternate interface? ioctl? Some sort of global
> > > > > virtual xattr? It does need to be something per-inode.
> > > >=20
> > > > I don't see how a non-atomic change attribute is remotely useful even
> > > > for NFS.
> > > >=20
> > > > The main problem is not so much the above (although NFS clients are
> > > > vulnerable to that too) but the behaviour w.r.t. directory changes.
> > > >=20
> > > > If the server can't guarantee that file/directory/... creation and
> > > > unlink are atomically recorded with change attribute updates, then the
> > > > client has to always assume that the server is lying, and that it has
> > > > to revalidate all its caches anyway. Cue endless readdir/lookup/getat=
tr
> > > > requests after each and every directory modification in order to check
> > > > that some other client didn't also sneak in a change of their own.
> > > >=20
> > >=20
> > > We generally hold the parent dir's inode->i_rwsem exclusively over most
> > > important directory changes, and the times/i_version are also updated
> > > while holding it. What we don't do is serialize reads of this value vs.
> > > the i_rwsem, so you could see new directory contents alongside an old
> > > i_version. Maybe we should be taking it for read when we query it on a
> > > directory?
> >=20
> > We do hold i_rwsem today.  I'm working on changing that.  Preserving
> > atomic directory changeinfo will be a challenge.  The only mechanism I
> > can think if is to pass a "u64*" to all the directory modification ops,
> > and they fill in the version number at the point where it is incremented
> > (inode_maybe_inc_iversion_return()).  The (nfsd) caller assumes that
> > "before" was one less than "after".  If you don't want to internally
> > require single increments, then you would need to pass a 'u64 [2]' to
> > get two iversions back.
> >=20
>=20
> That's a major redesign of what the i_version counter is today. It may
> very well end up being needed, but that's going to touch a lot of stuff
> in the VFS. Are you planning to do that as a part of your locking
> changes?
>=20

"A major design"?  How?  The "one less than" might be, but allowing a
directory morphing op to fill in a "u64 [2]" is just a new interface to
existing data.  One that allows fine grained atomicity.

This would actually be really good for NFS.  nfs_mkdir (for example)
could easily have access to the atomic pre/post changedid provided by
the server, and so could easily provide them to nfsd.

I'm not planning to do this as part of my locking changes.  In the first
instance only NFS changes behaviour, and it doesn't provide atomic
changeids, so there is no loss of functionality.

When some other filesystem wants to opt-in to shared-locking on
directories - that would be the time to push through a better interface.


> > >=20
> > > Achieving atomicity with file writes though is another matter entirely.
> > > I'm not sure that's even doable or how to approach it if so.
> > > Suggestions?
> >=20
> > Call inode_maybe_inc_version(page->host) in __folio_mark_dirty() ??
> >=20
>=20
> Writes can cover multiple folios so we'd be doing several increments per
> write. Maybe that's ok? Should we also be updating the ctime at that
> point as well?

You would only do several increments if something was reading the value
concurrently, and then you really should to several increments for
correctness.

>=20
> Fetching the i_version under the i_rwsem is probably sufficient to fix
> this though. Most of the write_iter ops already bump the i_version while
> holding that lock, so this wouldn't add any extra locking to the write
> codepaths.

Adding new locking doesn't seem like a good idea.  It's bound to have
performance implications.  It may well end up serialising the directory
op that I'm currently trying to make parallelisable.

Thanks,
NeilBrown


>=20
> --=20
> Jeff Layton <jlayton@kernel.org>
>=20
