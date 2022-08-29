Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB3795A4757
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Aug 2022 12:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbiH2KjK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Aug 2022 06:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiH2KjJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Aug 2022 06:39:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B599C5AC7B;
        Mon, 29 Aug 2022 03:39:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 354146117D;
        Mon, 29 Aug 2022 10:39:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83BE1C433C1;
        Mon, 29 Aug 2022 10:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661769547;
        bh=V4aLsCPDGVtW//0i+K135v/Na+wqz9kBREO4TmBK1Rk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=vRxLMITbLt6tbQVwa55RNWcYCZgr55yM7X31fRcmA1RJlwZ1XT46NVb3MKfu8uEBR
         yA6zT5xHb+8WQMHQvTlElrrvJLYH8Ce+sE4P45zgjCr3voS+DOcq7BPQvtksX9LcRv
         ymywyxtw7EbGkukKphe35wK53Zr+Pi9nx7r8CYdh3u1qnHtc4+4JYTH8aLJZsKN4Yy
         6/pSNfxOdi1fF43U66YbiQfk9pObDT1BQOYwyc7yf7j72qva902fg0RPP/i0GdX/4P
         TDABo4YsesJU8HVVi+GaW23FS81aECaEhCl4BXOV18Y1G9XofVc1zkCizMmHyT2vdP
         MdPY3xoGIvvFw==
Message-ID: <549776abfaddcc936c6de7800b6d8249d97d9f28.camel@kernel.org>
Subject: Re: [PATCH v3 1/7] iversion: update comments with info about atime
 updates
From:   Jeff Layton <jlayton@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, djwong@kernel.org,
        trondmy@hammerspace.com, neilb@suse.de, viro@zeniv.linux.org.uk,
        zohar@linux.ibm.com, xiubli@redhat.com, chuck.lever@oracle.com,
        lczerner@redhat.com, jack@suse.cz, brauner@kernel.org,
        linux-api@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ceph@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-xfs@vger.kernel.org,
        Colin Walters <walters@verbum.org>
Date:   Mon, 29 Aug 2022 06:39:04 -0400
In-Reply-To: <20220829075651.GS3600936@dread.disaster.area>
References: <20220826214703.134870-1-jlayton@kernel.org>
         <20220826214703.134870-2-jlayton@kernel.org>
         <20220829075651.GS3600936@dread.disaster.area>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2022-08-29 at 17:56 +1000, Dave Chinner wrote:
> On Fri, Aug 26, 2022 at 05:46:57PM -0400, Jeff Layton wrote:
> > The i_version field in the kernel has had different semantics over
> > the decades, but we're now proposing to expose it to userland via
> > statx. This means that we need a clear, consistent definition of
> > what it means and when it should change.
> >=20
> > Update the comments in iversion.h to describe how a conformant
> > i_version implementation is expected to behave. This definition
> > suits the current users of i_version (NFSv4 and IMA), but is
> > loose enough to allow for a wide range of possible implementations.
> >=20
> > Cc: Colin Walters <walters@verbum.org>
> > Cc: NeilBrown <neilb@suse.de>
> > Cc: Trond Myklebust <trondmy@hammerspace.com>
> > Cc: Dave Chinner <david@fromorbit.com>
> > Link: https://lore.kernel.org/linux-xfs/166086932784.5425.1713471269496=
1326033@noble.neil.brown.name/#t
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  include/linux/iversion.h | 23 +++++++++++++++++++++--
> >  1 file changed, 21 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/include/linux/iversion.h b/include/linux/iversion.h
> > index 3bfebde5a1a6..45e93e1b4edc 100644
> > --- a/include/linux/iversion.h
> > +++ b/include/linux/iversion.h
> > @@ -9,8 +9,19 @@
> >   * ---------------------------
> >   * The change attribute (i_version) is mandated by NFSv4 and is mostly=
 for
> >   * knfsd, but is also used for other purposes (e.g. IMA). The i_versio=
n must
> > - * appear different to observers if there was a change to the inode's =
data or
> > - * metadata since it was last queried.
> > + * appear different to observers if there was an explicit change to th=
e inode's
> > + * data or metadata since it was last queried.
> > + *
> > + * An explicit change is one that would ordinarily result in a change =
to the
> > + * inode status change time (aka ctime). The version must appear to ch=
ange, even
> > + * if the ctime does not (since the whole point is to avoid missing up=
dates due
> > + * to timestamp granularity). If POSIX mandates that the ctime must ch=
ange due
> > + * to an operation, then the i_version counter must be incremented as =
well.
> > + *
> > + * A conformant implementation is allowed to increment the counter in =
other
> > + * cases, but this is not optimal. NFSv4 and IMA both use this value t=
o determine
> > + * whether caches are up to date. Spurious increments can cause false =
cache
> > + * invalidations.
>=20
> "not optimal", but never-the-less allowed - that's "unspecified
> behaviour" if I've ever seen it. How is userspace supposed to
> know/deal with this?
>=20
> Indeed, this loophole clause doesn't exist in the man pages that
> define what statx.stx_ino_version means. The man pages explicitly
> define that stx_ino_version only ever changes when stx_ctime
> changes.
>=20

We can fix the manpage to make this more clear.

> IOWs, the behaviour userspace developers are going to expect *does
> not include* stx_ino_version changing it more often than ctime is
> changed. Hence a kernel iversion implementation that bumps the
> counter more often than ctime changes *is not conformant with the
> statx version counter specification*. IOWs, we can't export such
> behaviour to userspace *ever* - it is a non-conformant
> implementation.
>=20

Nonsense. The statx version counter specification is *whatever we decide
to make it*. If we define it to allow for spurious version bumps, then
these implementations would be conformant.

Given that you can't tell what or how much changed in the inode whenever
the value changes, allowing it to be bumped on non-observable changes is
ok and the counter is still useful. When you see it change you need to
go stat/read/getxattr etc, to see what actually happened anyway.

Most applications won't be interested in every possible explicit change
that can happen to an inode. It's likely these applications would check
the parts of the inode they're interested in, and then go back to
waiting for the next bump if the change wasn't significant to them.


> Hence I think anything that bumps iversion outside the bounds of the
> statx definition should be declared as such:
>=20
> "Non-conformant iversion implementations:
> 	- MUST NOT be exported by statx() to userspace
> 	- MUST be -tolerated- by kernel internal applications that
> 	  use iversion for their own purposes."
>=20

I think this is more strict than is needed. An implementation that bumps
this value more often than is necessary is still useful. It's not
_ideal_, but it still meets the needs of NFSv4, IMA and other potential
users of it. After all, this is basically the definition of i_version
today and it's still useful, even if atime update i_version bumps are
currently harmful for performance.

--=20
Jeff Layton <jlayton@kernel.org>
