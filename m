Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF0F23FF793
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Sep 2021 01:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347855AbhIBXDb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Sep 2021 19:03:31 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:48734 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348000AbhIBXDa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Sep 2021 19:03:30 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id F3C171FFE4;
        Thu,  2 Sep 2021 23:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1630623751; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sU28DzaSgjn8Ql/BUOqdBFP2o4qesH20RR4IjIyMuF4=;
        b=BV/Y1O2QOlMnvcDCFHBW5u4CZzwb5UwK+14iVsUp8deI6QkiBxqDD6rTgDljwOJCATC64V
        BIG6Tl0KEevu9CuYZYLZReHxXiLeh4tKIDcJhX8VD3XaSe3OFwHv/qBvZRdaqRu+LOrSaZ
        cfVQ8ETVtOe6uU0VXy/vlsnrsLyubyc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1630623751;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sU28DzaSgjn8Ql/BUOqdBFP2o4qesH20RR4IjIyMuF4=;
        b=5x4AdmosLbJvXRAfIJVIUF+zN5yMnEllEraQRyxt2IgxIrkG1mgfEkLVNEe3ZEHfZDYbKi
        bhnkEEby14DNpsAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 99D4C13AAB;
        Thu,  2 Sep 2021 23:02:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id iiklFgRYMWH9RwAAMHmgww
        (envelope-from <neilb@suse.de>); Thu, 02 Sep 2021 23:02:28 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Frank Filz" <ffilzlnx@mindspring.com>
Cc:     "'Miklos Szeredi'" <miklos@szeredi.hu>,
        "'Christoph Hellwig'" <hch@infradead.org>,
        "'J. Bruce Fields'" <bfields@fieldses.org>,
        "'Chuck Lever'" <chuck.lever@oracle.com>,
        "'Linux NFS list'" <linux-nfs@vger.kernel.org>,
        "'Josef Bacik'" <josef@toxicpanda.com>,
        linux-fsdevel@vger.kernel.org
Subject: RE: [PATCH v2] BTRFS/NFSD: provide more unique inode number for btrfs export
In-reply-to: <024601d7a005$1b3863c0$51a92b40$@mindspring.com>
References: <162995209561.7591.4202079352301963089@noble.neil.brown.name>,
 <162995778427.7591.11743795294299207756@noble.neil.brown.name>,
 <YSkQ31UTVDtBavOO@infradead.org>,
 <163010550851.7591.9342822614202739406@noble.neil.brown.name>,
 <YSnhHl0HDOgg07U5@infradead.org>,
 <163038594541.7591.11109978693705593957@noble.neil.brown.name>,
 <YS8ppl6SYsCC0cql@infradead.org>,
 <163055561473.24419.12486186372497472066@noble.neil.brown.name>,
 <YTB6NacU9bIOz2vf@infradead.org>,
 <CAJfpegu7rwoFXdtLusyRhrtFgMPxRShesxnBT2Q6iiC_iSGsfg@mail.gmail.com>,
 <024601d7a005$1b3863c0$51a92b40$@mindspring.com>
Date:   Fri, 03 Sep 2021 09:02:25 +1000
Message-id: <163062374563.24419.8930722817731828791@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 03 Sep 2021, Frank Filz wrote:
> > On Thu, 2 Sept 2021 at 09:18, Christoph Hellwig <hch@infradead.org> wrote:
> >=20
> > > >  Your attitude seems to be that this is a btrfs problem and must be
> > > > fixed in btrfs.
> > >
> > > Yes.
> >=20
> > st_ino space issues affect overlayfs as well.   The two problems are
> > not the same, but do share some characteristics.  And this limitation wil=
l likely
> > come up again in the future.
> >=20
> > I suspect the long term solution would involve introducing new userspace =
API
> > (variable length inode numbers) and deprecating st_ino.
> > E.g. make stat return an error if the inode number doesn't fit into st_in=
o and add
> > a statx extension to return the full number.  But this would be a long pr=
ocess...
>=20
> But then what do we do where fileid in NFS is only 64 bits?

Hence my suggestion that user-space should move to using the filehandle.

Two file handles being different doesn't guarantee that the two objects
are different, but the problems caused by incorrectly assuming two
things are different are much less than the problems caused by
incorrectly assuming two things are the same.

>=20
> The solution of giving each subvol a separate fsid is the only real
> solution to enlarging the NFS fileid space, however that has downsides
> on the client side.

And this doesn't help overlayfs... =20

NeilBrown
