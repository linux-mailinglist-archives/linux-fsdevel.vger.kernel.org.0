Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB56595BA6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Aug 2022 14:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235020AbiHPMT2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Aug 2022 08:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235519AbiHPMTD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Aug 2022 08:19:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C71452ED55;
        Tue, 16 Aug 2022 05:18:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0A9EDB8188B;
        Tue, 16 Aug 2022 12:18:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 182F5C433D6;
        Tue, 16 Aug 2022 12:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660652311;
        bh=lVuHZlXCysWvSyziVBnQ0xLbK0P/XDoMU71MHD6jX/4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=B3aamhQEXyGx2bLPjOgSJu00//ZPXVIhuvJKNpFjccTzbtcG1TL9/+NESLXyryJvA
         HyxnRPVn0dhKi36T6NyoFW3UJM6Q+N+vD74pJvXXYIqRnsT/U05SzyNugVvKe62kmb
         gZ+acnTkiguVbawp2B6h8zbyD6hR3/yT7m37IpuA1nYXGoY4RcQBZmFA1UquOW4wvu
         WjCIQV07kgTj3/EUqdS2ibdNFMDgbw1GZJzMoMewaiXBSu6WveGeQKMvXufDDLkgZy
         WULAWf3s1Z+0d8YsQzHrQGZn0RXBeHSMAM4/4ykB3MQBaVHIkncaizDIMVRvhONGFx
         64gKhzwsc3u0w==
Message-ID: <45b34bba8bd32df382f76261e783b7f4b173b682.camel@kernel.org>
Subject: Re: [PATCH v3 1/3] ext4: don't increase iversion counter for
 ea_inodes
From:   Jeff Layton <jlayton@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Lukas Czerner <lczerner@redhat.com>, linux-ext4@vger.kernel.org,
        tytso@mit.edu, linux-fsdevel@vger.kernel.org, ebiggers@kernel.org,
        david@fromorbit.com
Date:   Tue, 16 Aug 2022 08:18:29 -0400
In-Reply-To: <20220816115248.2xj25pcays7dkrpp@quack3>
References: <20220812123727.46397-1-lczerner@redhat.com>
         <b2e18765bc22ea851c2293c15a8aa4c3cec0fde5.camel@kernel.org>
         <20220816115248.2xj25pcays7dkrpp@quack3>
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

On Tue, 2022-08-16 at 13:52 +0200, Jan Kara wrote:
> On Fri 12-08-22 14:42:36, Jeff Layton wrote:
> > On Fri, 2022-08-12 at 14:37 +0200, Lukas Czerner wrote:
> > > ea_inodes are using i_version for storing part of the reference count=
 so
> > > we really need to leave it alone.
> > >=20
> > > The problem can be reproduced by xfstest ext4/026 when iversion is
> > > enabled. Fix it by not calling inode_inc_iversion() for EXT4_EA_INODE=
_FL
> > > inodes in ext4_mark_iloc_dirty().
> > >=20
> > > Signed-off-by: Lukas Czerner <lczerner@redhat.com>
> > > Reviewed-by: Jan Kara <jack@suse.cz>
> > > Reviewed-by: Jeff Layton <jlayton@kernel.org>
> > > ---
> > > v2, v3: no change
> > >=20
> > >  fs/ext4/inode.c | 7 ++++++-
> > >  1 file changed, 6 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> > > index 601214453c3a..2a220be34caa 100644
> > > --- a/fs/ext4/inode.c
> > > +++ b/fs/ext4/inode.c
> > > @@ -5731,7 +5731,12 @@ int ext4_mark_iloc_dirty(handle_t *handle,
> > >  	}
> > >  	ext4_fc_track_inode(handle, inode);
> > > =20
> > > -	if (IS_I_VERSION(inode))
> > > +	/*
> > > +	 * ea_inodes are using i_version for storing reference count, don't
> > > +	 * mess with it
> > > +	 */
> > > +	if (IS_I_VERSION(inode) &&
> > > +	    !(EXT4_I(inode)->i_flags & EXT4_EA_INODE_FL))
> > >  		inode_inc_iversion(inode)
> > > =20
> > >  	/* the do_update_inode consumes one bh->b_count */
> >=20
> >=20
> > I've spent some time writing tests for the i_version counter (still
> > quite rough right now), and what I've found is that this particular
> > inode_inc_iversion results in the counter being bumped on _reads_ as
> > well as writes, due to the atime changing. This call to
> > inode_inc_iversion seems to make no sense, as we aren't bumping the
> > mtime here.
> >=20
> > I'm still working on and testing this, but I think we'll probably just
> > want to remove this inode_inc_iversion entirely, and leave the i_versio=
n
> > bumping for normal files to happen when the timestamps are updated. So
> > far, my testing seems to indicate that that does the right thing.
>=20
> I agree that inode_inc_iversion() may be overly agressive here but where
> else does get iversion updated for things like inode owner update or
> permission changes?
>=20
> 								Honza

If we remove it here, then both the setattr and setxattr codepaths will
need to explicitly bump the iversion counter. Note that we update the
ctime in those paths too, so that gives us a guidepost as to when we
should update i_version. xfs will need similar changes, but btrfs turns
out to already do the right thing.

I'm planning to post my latest patches in just a bit.
--=20
Jeff Layton <jlayton@kernel.org>
