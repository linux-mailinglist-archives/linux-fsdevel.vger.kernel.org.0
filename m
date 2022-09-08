Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE9E15B11A3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Sep 2022 02:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbiIHAyC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Sep 2022 20:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbiIHAyB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Sep 2022 20:54:01 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 897431A812;
        Wed,  7 Sep 2022 17:54:00 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 32F7020A2D;
        Thu,  8 Sep 2022 00:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1662598439; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R8Iu4FM2zldNHQkNV6Nu5dZQzcCSA2VlVjgRccQaV5E=;
        b=pG7jBRfjKAxooVMpjdQN6pPNAP5vPLTNYpmRLh4K9j4keuGLgXaAJG2uxTPQ9PukBJiYUr
        s6HUBHh76OOsG657aRAhPxPZdeaYDooNX3u43+8575fHUK7a5NS4s+ov/cjcD1TB+J54vN
        B04XSOcKEJtD+G94bxuaS1+T9xSJp3k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1662598439;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R8Iu4FM2zldNHQkNV6Nu5dZQzcCSA2VlVjgRccQaV5E=;
        b=xq4QQnNCrxZRtzC/NolV/wIBoeRjsWxc1LfwG7RDJdLDewsqQg8DIzKpUmp/6hDZ3u3Nhl
        8+hu1ihMhxHTg4DQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B4C1D1339E;
        Thu,  8 Sep 2022 00:53:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id j4RdGh89GWPMDAAAMHmgww
        (envelope-from <neilb@suse.de>); Thu, 08 Sep 2022 00:53:51 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Trond Myklebust" <trondmy@hammerspace.com>
Cc:     "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "xiubli@redhat.com" <xiubli@redhat.com>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "bfields@fieldses.org" <bfields@fieldses.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
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
In-reply-to: <9f8b9ee28dcc479ab6fb1105fc12ff190a9b5c48.camel@hammerspace.com>
References: <20220907111606.18831-1-jlayton@kernel.org>,
 <166255065346.30452.6121947305075322036@noble.neil.brown.name>,
 <79aaf122743a295ddab9525d9847ac767a3942aa.camel@kernel.org>,
 <20220907125211.GB17729@fieldses.org>,
 <771650a814ab1ff4dc5473d679936b747d9b6cf5.camel@kernel.org>,
 <8a71986b4fb61cd9b4adc8b4250118cbb19eec58.camel@hammerspace.com>,
 <166259706887.30452.6749778447732126953@noble.neil.brown.name>,
 <9f8b9ee28dcc479ab6fb1105fc12ff190a9b5c48.camel@hammerspace.com>
Date:   Thu, 08 Sep 2022 10:53:35 +1000
Message-id: <166259841505.30452.6627904866093896202@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 08 Sep 2022, Trond Myklebust wrote:
> On Thu, 2022-09-08 at 10:31 +1000, NeilBrown wrote:
> > On Wed, 07 Sep 2022, Trond Myklebust wrote:
> > > On Wed, 2022-09-07 at 09:12 -0400, Jeff Layton wrote:
> > > > On Wed, 2022-09-07 at 08:52 -0400, J. Bruce Fields wrote:
> > > > > On Wed, Sep 07, 2022 at 08:47:20AM -0400, Jeff Layton wrote:
> > > > > > On Wed, 2022-09-07 at 21:37 +1000, NeilBrown wrote:
> > > > > > > On Wed, 07 Sep 2022, Jeff Layton wrote:
> > > > > > > > +The change to \fIstatx.stx_ino_version\fP is not atomic
> > > > > > > > with
> > > > > > > > respect to the
> > > > > > > > +other changes in the inode. On a write, for instance,
> > > > > > > > the
> > > > > > > > i_version it usually
> > > > > > > > +incremented before the data is copied into the
> > > > > > > > pagecache.
> > > > > > > > Therefore it is
> > > > > > > > +possible to see a new i_version value while a read still
> > > > > > > > shows the old data.
> > > > > > >=20
> > > > > > > Doesn't that make the value useless?
> > > > > > >=20
> > > > > >=20
> > > > > > No, I don't think so. It's only really useful for comparing
> > > > > > to an
> > > > > > older
> > > > > > sample anyway. If you do "statx; read; statx" and the value
> > > > > > hasn't
> > > > > > changed, then you know that things are stable.=20
> > > > >=20
> > > > > I don't see how that helps.=C2=A0 It's still possible to get:
> > > > >=20
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0reader=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0writer
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0------=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0------
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0i_version++
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0statx
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0read
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0statx
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0update page cache
> > > > >=20
> > > > > right?
> > > > >=20
> > > >=20
> > > > Yeah, I suppose so -- the statx wouldn't necessitate any locking.
> > > > In
> > > > that case, maybe this is useless then other than for testing
> > > > purposes
> > > > and userland NFS servers.
> > > >=20
> > > > Would it be better to not consume a statx field with this if so?
> > > > What
> > > > could we use as an alternate interface? ioctl? Some sort of
> > > > global
> > > > virtual xattr? It does need to be something per-inode.
> > >=20
> > > I don't see how a non-atomic change attribute is remotely useful
> > > even
> > > for NFS.
> > >=20
> > > The main problem is not so much the above (although NFS clients are
> > > vulnerable to that too) but the behaviour w.r.t. directory changes.
> > >=20
> > > If the server can't guarantee that file/directory/... creation and
> > > unlink are atomically recorded with change attribute updates, then
> > > the
> > > client has to always assume that the server is lying, and that it
> > > has
> > > to revalidate all its caches anyway. Cue endless
> > > readdir/lookup/getattr
> > > requests after each and every directory modification in order to
> > > check
> > > that some other client didn't also sneak in a change of their own.
> >=20
> > NFS re-export doesn't support atomic change attributes on
> > directories.
> > Do we see the endless revalidate requests after directory
> > modification
> > in that situation?=C2=A0 Just curious.
>=20
> Why wouldn't NFS re-export be capable of supporting atomic change
> attributes in those cases, provided that the server does? It seems to
> me that is just a question of providing the correct information w.r.t.
> atomicity to knfsd.

I don't know if it "could" but as far as I can see the Linux nfsd server
doesn't.
NFS sets EXPORT_OP_NOATOMIC_ATTR which causes ->fs_no_atomic_attr to be
set so cinfo->atomic reported back to the client is always false.

>=20
> ...but yes, a quick glance at nfs4_update_changeattr_locked(), and what
> happens when !cinfo->atomic should tell you all you need to know.

Yep, I can see that all the directory cache is invalidated.  I was more
wondering if anyone had noticed this causing performance problems.  I
suspect there are some workloads where is isn't noticeable, and others
where it would be quite unpleasant.

Chuck said recently:

> My impression is that pre/post attributes in NFSv3 have not
> turned out to be as useful as their inventors predicted.

https://lore.kernel.org/linux-nfs/8F16D957-F43A-4E5B-AA28-AAFCF43222E2@oracle=
.com/

I wonder how accurate that impression is.

Thanks,
NeilBrown



>=20
> --=20
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
>=20
>=20
>=20
