Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9024E5B116B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Sep 2022 02:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbiIHAlJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Sep 2022 20:41:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbiIHAlI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Sep 2022 20:41:08 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2760BA2DB7;
        Wed,  7 Sep 2022 17:41:04 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B34C634354;
        Thu,  8 Sep 2022 00:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1662597662; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DXkLrKWAeng9ZlknGIJRMzqYnfyfiNyF+D0MYokrvKk=;
        b=wJTQgySftEaJuPWbXF0S3EeRvrD2OgFrw2ueiBIwrwZJ8Kf+b2G5p8jP090g+oYzvb7y0/
        RCMTlI8wU0h9SNpaKrOrsmiGKhcUEpD3S82AOEhkcSPOJ+GhlScEr7g+/kpi604PBUbDVP
        NOW04pJhrMnIceboj2BK4gs4YDRdDHk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1662597662;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DXkLrKWAeng9ZlknGIJRMzqYnfyfiNyF+D0MYokrvKk=;
        b=VNBG0nPIzUuGJ0mWppNb3KYt0fmLgUxTJdHPKz3xDDUirPnO23qb7r0yUpGaJW3bwvQpIp
        9nAHFq78stNDANAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 81E431339E;
        Thu,  8 Sep 2022 00:40:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id lQrFDhc6GWNeCQAAMHmgww
        (envelope-from <neilb@suse.de>); Thu, 08 Sep 2022 00:40:55 +0000
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
In-reply-to: <c22baa64133a23be3aba81df23b4af866df51343.camel@kernel.org>
References: <20220907111606.18831-1-jlayton@kernel.org>,
 <166255065346.30452.6121947305075322036@noble.neil.brown.name>,
 <79aaf122743a295ddab9525d9847ac767a3942aa.camel@kernel.org>,
 <20220907125211.GB17729@fieldses.org>,
 <771650a814ab1ff4dc5473d679936b747d9b6cf5.camel@kernel.org>,
 <8a71986b4fb61cd9b4adc8b4250118cbb19eec58.camel@hammerspace.com>,
 <c22baa64133a23be3aba81df23b4af866df51343.camel@kernel.org>
Date:   Thu, 08 Sep 2022 10:40:43 +1000
Message-id: <166259764365.30452.5588074352157110414@noble.neil.brown.name>
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
> On Wed, 2022-09-07 at 13:55 +0000, Trond Myklebust wrote:
> > On Wed, 2022-09-07 at 09:12 -0400, Jeff Layton wrote:
> > > On Wed, 2022-09-07 at 08:52 -0400, J. Bruce Fields wrote:
> > > > On Wed, Sep 07, 2022 at 08:47:20AM -0400, Jeff Layton wrote:
> > > > > On Wed, 2022-09-07 at 21:37 +1000, NeilBrown wrote:
> > > > > > On Wed, 07 Sep 2022, Jeff Layton wrote:
> > > > > > > +The change to \fIstatx.stx_ino_version\fP is not atomic with
> > > > > > > respect to the
> > > > > > > +other changes in the inode. On a write, for instance, the
> > > > > > > i_version it usually
> > > > > > > +incremented before the data is copied into the pagecache.
> > > > > > > Therefore it is
> > > > > > > +possible to see a new i_version value while a read still
> > > > > > > shows the old data.
> > > > > >=20
> > > > > > Doesn't that make the value useless?
> > > > > >=20
> > > > >=20
> > > > > No, I don't think so. It's only really useful for comparing to an
> > > > > older
> > > > > sample anyway. If you do "statx; read; statx" and the value
> > > > > hasn't
> > > > > changed, then you know that things are stable.=20
> > > >=20
> > > > I don't see how that helps.=C2=A0 It's still possible to get:
> > > >=20
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0reader=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0writer
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0------=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0------
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0i_version++
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0statx
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0read
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0statx
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0update page cache
> > > >=20
> > > > right?
> > > >=20
> > >=20
> > > Yeah, I suppose so -- the statx wouldn't necessitate any locking. In
> > > that case, maybe this is useless then other than for testing purposes
> > > and userland NFS servers.
> > >=20
> > > Would it be better to not consume a statx field with this if so? What
> > > could we use as an alternate interface? ioctl? Some sort of global
> > > virtual xattr? It does need to be something per-inode.
> >=20
> > I don't see how a non-atomic change attribute is remotely useful even
> > for NFS.
> >=20
> > The main problem is not so much the above (although NFS clients are
> > vulnerable to that too) but the behaviour w.r.t. directory changes.
> >=20
> > If the server can't guarantee that file/directory/... creation and
> > unlink are atomically recorded with change attribute updates, then the
> > client has to always assume that the server is lying, and that it has
> > to revalidate all its caches anyway. Cue endless readdir/lookup/getattr
> > requests after each and every directory modification in order to check
> > that some other client didn't also sneak in a change of their own.
> >=20
>=20
> We generally hold the parent dir's inode->i_rwsem exclusively over most
> important directory changes, and the times/i_version are also updated
> while holding it. What we don't do is serialize reads of this value vs.
> the i_rwsem, so you could see new directory contents alongside an old
> i_version. Maybe we should be taking it for read when we query it on a
> directory?

We do hold i_rwsem today.  I'm working on changing that.  Preserving
atomic directory changeinfo will be a challenge.  The only mechanism I
can think if is to pass a "u64*" to all the directory modification ops,
and they fill in the version number at the point where it is incremented
(inode_maybe_inc_iversion_return()).  The (nfsd) caller assumes that
"before" was one less than "after".  If you don't want to internally
require single increments, then you would need to pass a 'u64 [2]' to
get two iversions back.

>=20
> Achieving atomicity with file writes though is another matter entirely.
> I'm not sure that's even doable or how to approach it if so.
> Suggestions?

Call inode_maybe_inc_version(page->host) in __folio_mark_dirty() ??

NeilBrown
