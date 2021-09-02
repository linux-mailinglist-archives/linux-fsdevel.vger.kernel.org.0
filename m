Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CBFC3FEF6A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Sep 2021 16:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345507AbhIBOZu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Sep 2021 10:25:50 -0400
Received: from mta-202a.oxsus-vadesecure.net ([51.81.232.240]:52685 "EHLO
        mta-202a.oxsus-vadesecure.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345278AbhIBOZl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Sep 2021 10:25:41 -0400
X-Greylist: delayed 390 seconds by postgrey-1.27 at vger.kernel.org; Thu, 02 Sep 2021 10:25:41 EDT
DKIM-Signature: v=1; a=rsa-sha256; bh=0znQ0bZJnEmWup+geyVO0VNC/rch+QaShXhPsF
 RITrw=; c=relaxed/relaxed; d=earthlink.net; h=from:reply-to:subject:
 date:to:cc:resent-date:resent-from:resent-to:resent-cc:in-reply-to:
 references:list-id:list-help:list-unsubscribe:list-subscribe:list-post:
 list-owner:list-archive; q=dns/txt; s=dk12062016; t=1630592181;
 x=1631196981; b=WLdI8UGRB+XHZiDg/kGw2Et3f6J7ygDCeJ663aqkdy13p64uflmUWCw
 huUsS+YFW4sp6aMFUFUrKP055Xaqka04eYyMGOuU9TEcfVakjy/LexdyyJp6LMe+KDroYrb
 fe7QNED1q85rhb6HNX2x15szteFqkiT0JQc1F+mQqfbgKkwMVa/qGkY9LORBGdQjHFpwykt
 DOnWNBeB+9AYUKWtRgod3UaWE2CF8HcoUVXj5YLmmB9OxotZchqHK491Vka7q6/G+pRRZFf
 EB5QqH97EzYE4crrExRl+QcnvMCqgr/3K8DG5XBILN32YkfraT++2klt2EBCH7s4e6z8RGA
 muw==
Received: from FRANKSTHINKPAD ([76.105.143.216])
 by smtp.oxsus-vadesecure.net ESMTP oxsus2nmtao02p with ngmta
 id 7b29f58e-16a106f312cff353; Thu, 02 Sep 2021 14:16:21 +0000
From:   "Frank Filz" <ffilzlnx@mindspring.com>
To:     "'Miklos Szeredi'" <miklos@szeredi.hu>,
        "'Christoph Hellwig'" <hch@infradead.org>
Cc:     "'NeilBrown'" <neilb@suse.de>,
        "'J. Bruce Fields'" <bfields@fieldses.org>,
        "'Chuck Lever'" <chuck.lever@oracle.com>,
        "'Linux NFS list'" <linux-nfs@vger.kernel.org>,
        "'Josef Bacik'" <josef@toxicpanda.com>,
        <linux-fsdevel@vger.kernel.org>
References: <162995209561.7591.4202079352301963089@noble.neil.brown.name> <162995778427.7591.11743795294299207756@noble.neil.brown.name> <YSkQ31UTVDtBavOO@infradead.org> <163010550851.7591.9342822614202739406@noble.neil.brown.name> <YSnhHl0HDOgg07U5@infradead.org> <163038594541.7591.11109978693705593957@noble.neil.brown.name> <YS8ppl6SYsCC0cql@infradead.org> <163055561473.24419.12486186372497472066@noble.neil.brown.name> <YTB6NacU9bIOz2vf@infradead.org> <CAJfpegu7rwoFXdtLusyRhrtFgMPxRShesxnBT2Q6iiC_iSGsfg@mail.gmail.com>
In-Reply-To: <CAJfpegu7rwoFXdtLusyRhrtFgMPxRShesxnBT2Q6iiC_iSGsfg@mail.gmail.com>
Subject: RE: [PATCH v2] BTRFS/NFSD: provide more unique inode number for btrfs export
Date:   Thu, 2 Sep 2021 07:16:21 -0700
Message-ID: <024601d7a005$1b3863c0$51a92b40$@mindspring.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 15.0
Content-Language: en-us
Thread-Index: AQIrHUOuRItKwhPpv5iuHWFXVceYzwFdY2wGAe8fACcBhmh95QIesfONAO3IHPoCbGx/fAGLnZteAStbb/8CEbYDYapxJ5Xg
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> On Thu, 2 Sept 2021 at 09:18, Christoph Hellwig <hch@infradead.org> =
wrote:
>=20
> > >  Your attitude seems to be that this is a btrfs problem and must =
be
> > > fixed in btrfs.
> >
> > Yes.
>=20
> st_ino space issues affect overlayfs as well.   The two problems are
> not the same, but do share some characteristics.  And this limitation =
will likely
> come up again in the future.
>=20
> I suspect the long term solution would involve introducing new =
userspace API
> (variable length inode numbers) and deprecating st_ino.
> E.g. make stat return an error if the inode number doesn't fit into =
st_ino and add
> a statx extension to return the full number.  But this would be a long =
process...

But then what do we do where fileid in NFS is only 64 bits?

The solution of giving each subvol a separate fsid is the only real =
solution to enlarging the NFS fileid space, however that has downsides =
on the client side.

Frank

