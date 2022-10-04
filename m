Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3325F4067
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Oct 2022 11:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbiJDJyK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Oct 2022 05:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbiJDJxr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Oct 2022 05:53:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 595CA2AED;
        Tue,  4 Oct 2022 02:53:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 01B16B819A4;
        Tue,  4 Oct 2022 09:53:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C0AEC433D6;
        Tue,  4 Oct 2022 09:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664877203;
        bh=Lcm5DsmdT6s0+13Ek1ZhJ1nnCH8WL7KDsCfyE0AR28k=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=e8aU6nknPS+eCkpFWPQAFi4MFM2uqpAs0uM1G+sMu622Tmr3LRNF1x++A77qlJomS
         /CcK6quci+o2aGxHd5B7/XHNVTEzUpld8dZ4u8+u/uSt6QcuctANGUdLwUNdf+6Uy+
         u2KtCpKal1H7Um4EnGPmuFbCdGj3D3xx6K1/CGcTBBCN4bVSaQHGT02OGnLwKMezFl
         t1nrIk44kmY6ZY0mi7cpCw8xPYkITqtwZnHjPbPusfyeHl8ZJzeV5M3uyQvakf5NCZ
         w6V08tQzUtwrlE4W1/BnQebNEmER0iSETzo71O8tbh7BSI4KvueTz9n8zHAttplRsY
         AJ+meFxM/vi/g==
Message-ID: <b23540ef848fa670b9bc3feff6ea4eb023d67861.camel@kernel.org>
Subject: Re: [PATCH v6 2/9] iversion: clarify when the i_version counter
 must be updated
From:   Jeff Layton <jlayton@kernel.org>
To:     NeilBrown <neilb@suse.de>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, djwong@kernel.org,
        david@fromorbit.com, trondmy@hammerspace.com,
        viro@zeniv.linux.org.uk, zohar@linux.ibm.com, xiubli@redhat.com,
        chuck.lever@oracle.com, lczerner@redhat.com, jack@suse.cz,
        bfields@fieldses.org, brauner@kernel.org, fweimer@redhat.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-xfs@vger.kernel.org, Colin Walters <walters@verbum.org>
Date:   Tue, 04 Oct 2022 05:53:20 -0400
In-Reply-To: <166483861470.14457.7243696062075946548@noble.neil.brown.name>
References: <20220930111840.10695-1-jlayton@kernel.org>
        , <20220930111840.10695-3-jlayton@kernel.org>
         <166483861470.14457.7243696062075946548@noble.neil.brown.name>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2022-10-04 at 10:10 +1100, NeilBrown wrote:
> On Fri, 30 Sep 2022, Jeff Layton wrote:
> > The i_version field in the kernel has had different semantics over
> > the decades, but NFSv4 has certain expectations. Update the comments
> > in iversion.h to describe when the i_version must change.
> >=20
> > Cc: Colin Walters <walters@verbum.org>
> > Cc: NeilBrown <neilb@suse.de>
> > Cc: Trond Myklebust <trondmy@hammerspace.com>
> > Cc: Dave Chinner <david@fromorbit.com>
> > Link: https://lore.kernel.org/linux-xfs/166086932784.5425.1713471269496=
1326033@noble.neil.brown.name/#t
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  include/linux/iversion.h | 10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/include/linux/iversion.h b/include/linux/iversion.h
> > index 6755d8b4f20b..9925cac1fa94 100644
> > --- a/include/linux/iversion.h
> > +++ b/include/linux/iversion.h
> > @@ -9,8 +9,14 @@
> >   * ---------------------------
> >   * The change attribute (i_version) is mandated by NFSv4 and is mostly=
 for
> >   * knfsd, but is also used for other purposes (e.g. IMA). The i_versio=
n must
> > - * appear different to observers if there was a change to the inode's =
data or
> > - * metadata since it was last queried.
> > + * appear larger to observers if there was an explicit change to the i=
node's
> > + * data or metadata since it was last queried.
> > + *
> > + * An explicit change is one that would ordinarily result in a change =
to the
> > + * inode status change time (aka ctime). i_version must appear to chan=
ge, even
> > + * if the ctime does not (since the whole point is to avoid missing up=
dates due
> > + * to timestamp granularity). If POSIX mandates that the ctime must ch=
ange due
> > + * to an operation, then the i_version counter must be incremented as =
well.
>=20
> POSIX doesn't (that I can see) describe when the ctime changes w.r.t
> when the file changes.  For i_version we do want to specify that
> i_version change is not visible before the file change is visible.
> So this goes beyond the POSIX mandate.  I might be worth making that
> explicit.
> But this patch is nonetheless an improvement, so:
>=20
> Reviewed-by: NeilBrown <neilb@suse.de>
>=20
>=20

Thanks,

Now that we're looking at setting the ctime and i_version separately,
I'll plan to add something that makes this explict.

> >   *
> >   * Observers see the i_version as a 64-bit number that never decreases=
. If it
> >   * remains the same since it was last checked, then nothing has change=
d in the
> > --=20
> > 2.37.3
> >=20
> >=20

--=20
Jeff Layton <jlayton@kernel.org>
