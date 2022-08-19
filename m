Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 999125991CA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Aug 2022 02:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242619AbiHSAfg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Aug 2022 20:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239261AbiHSAff (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Aug 2022 20:35:35 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8672BD743D;
        Thu, 18 Aug 2022 17:35:34 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 377BB5C6C1;
        Fri, 19 Aug 2022 00:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1660869333; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/44KqjNp2sTT5jyoewJero6r42cWyXC7xw0mb2OtfGw=;
        b=xpy2L5sOsp0OmPTf6ha64HZJNr0IcXAmcULRIboLhLwkVHNzT3+LS21ZQUOFn2HLRL2EYT
        wKTUwE3Wi7CM+Bnv2v7xAa8wXHs74hFEBYqtnxUt4VeEG4njdj8R1darDoQB2fKfnIUlUx
        U3vpMCcrVHMtxdFE6yhavqZEfxPlM7A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1660869333;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/44KqjNp2sTT5jyoewJero6r42cWyXC7xw0mb2OtfGw=;
        b=v6GjiTs/8TcT7ZB5j8zTkVtKsXGnOkjppbrpULgCSy1feKYl/oyWM4c6x9jYO6WEORZmxh
        r4i/WX5fNFddb2AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 369BA139F0;
        Fri, 19 Aug 2022 00:35:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kzMkONLa/mJDUAAAMHmgww
        (envelope-from <neilb@suse.de>); Fri, 19 Aug 2022 00:35:30 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Dave Chinner" <david@fromorbit.com>
Cc:     "Jeff Layton" <jlayton@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        "Darrick J . Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH] xfs: fix i_version handling in xfs
In-reply-to: <20220818030048.GE3600936@dread.disaster.area>
References: <20220816131736.42615-1-jlayton@kernel.org>,
 <Yvu7DHDWl4g1KsI5@magnolia>,
 <e77fd4d19815fd661dbdb04ab27e687ff7e727eb.camel@kernel.org>,
 <20220816224257.GV3600936@dread.disaster.area>,
 <166078288043.5425.8131814891435481157@noble.neil.brown.name>,
 <20220818013251.GC3600936@dread.disaster.area>,
 <166078753200.5425.8997202026343224290@noble.neil.brown.name>,
 <20220818030048.GE3600936@dread.disaster.area>
Date:   Fri, 19 Aug 2022 10:35:27 +1000
Message-id: <166086932784.5425.17134712694961326033@noble.neil.brown.name>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 18 Aug 2022, Dave Chinner wrote:
> On Thu, Aug 18, 2022 at 11:52:12AM +1000, NeilBrown wrote:
> > On Thu, 18 Aug 2022, Dave Chinner wrote:
> > >=20
> > > > Maybe we should just go back to using ctime.  ctime is *exactly* what
> > > > NFSv4 wants, as long as its granularity is sufficient to catch every
> > > > single change.  Presumably XFS doesn't try to ensure this.  How hard
> > > > would it be to get any ctime update to add at least one nanosecond?
> > > > This would be enabled by a mount option, or possibly be a direct requ=
est
> > > > from nfsd.
> > >=20
> > > We can't rely on ctime to be changed during a modification because
> > > O_NOCMTIME exists to enable "user invisible" modifications to be
> > > made. On XFS these still bump iversion, so while they are invisible
> > > to the user, they are still tracked by the filesystem and anything
> > > that wants to know if the inode data/metadata changed.
> > >=20
> >=20
> > O_NOCMTIME isn't mentioned in the man page, so it doesn't exist :-(
> >=20
> > If they are "user invisible", should they then also be "NFS invisible"?
> > I think so.
>=20
> Maybe, but now you're making big assumptions about what is being
> done by those operations. Userspace can write whatever it likes,
> nothing says that O_NOCMTIME can't change user visible data or
> metadata.

Nope.  The only assumption I'm making is that if the ctime/mtime don't
change, then it is safe to trust any cached content.  I think that is
broadly assumed in the Posix world.  Anyone who uses O_NOCMTIME must
understand the risks (not currently documented ....) and it must be
assumed they will handled them properly.  We cannot allow the addition
of O_NOCMTIME to make us think "ctime and mtime don't mean what they
used to, we cannot trust them any more".

> But having uses of it that don't change user visible data does not
> mean it can't be used for changing user visible data. Hence we made
> the defensive assumption that O_NOCMTIME was a mechanism that could
> be used to hide data changes from forensic analysis. With that in
> mind, it was important that the change counter captured changes made
> even when O_NOCMTIME was specified to leave behind a breadcrumb to
> indicate unexpected changes may had been made to the file.

Having a breadcrumb seems reasonable.  Calling that breadcrumb "i_version"
might be questionable - though specifications seem to be vague so this
decision is probably defensible.

>=20
> Yeah, we had lots of different requirements for the XFS on-disk
> change counter when we were considering adding it. NFSv4 was one of
> the least demanding and least defined requirements; it's taken a
> *decade* for this atime issue to be noticed, so I really don't think
> there's anything wrong with how XFs has implemented persistent
> change counters.
>=20
> What it tells me is that the VFS needs more appropriate atime
> filtering for NFSv4's change attribute requirements....

I don't agree with that last point.  I think "atime =3D=3D mtime" and=20
"atime > mtime" are distinctly different states which should recorded.

I think Trond's' observation about implicit updates is on-point.
There is no need to include implicit atime updates in i_version.  If
anyone cares about those they can combine i_version and atime into a
single value.  If that value changes, then something changed, possibly
an implicit atime update. =20

Excluding implicit atime updates makes i_version strictly more useful.
It doesn't lose any value and does gain some.

NeilBrown
