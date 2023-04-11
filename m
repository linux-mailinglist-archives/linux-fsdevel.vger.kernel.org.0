Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A6B86DD5C2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Apr 2023 10:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbjDKIjC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Apr 2023 04:39:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbjDKIjB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Apr 2023 04:39:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC72097;
        Tue, 11 Apr 2023 01:38:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 87A7661DBF;
        Tue, 11 Apr 2023 08:38:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C04AC433D2;
        Tue, 11 Apr 2023 08:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681202338;
        bh=doffEh9CtBer7lQj+1eJsJCGu5/vEBuyc0wZT4N77Wo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jwELSjTfTWSFvxeF1xC17kD8yikVInP9XdjePpQSFKe83r9cGmimrS7+XPQ9adJ5t
         lvPMyggvL8WsuDI5cDocYF0S9ds5+TULHtGJ8gmBU+07JM6Ay22D60M/GNTAQ3aIpI
         6b/DCv4MTUMXBm/e3iwTrtoFlxR91W90HKcZ+CTBpxCACclPulpf1hfxAiltsbQh07
         kkyCqF7vk7PUwVqrYkTLvVWQiSNFhfgHAI9xip573PoJcrfKuygPXQwCDskV76yLdD
         LqbVlr8gGUtULJecf9gtfR7Qux+II3g2av3CVXfXoQyeVhwtCp47LfU6iuFhZmxUff
         lnKkCIFk2carA==
Date:   Tue, 11 Apr 2023 10:38:52 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Stefan Berger <stefanb@linux.ibm.com>,
        Paul Moore <paul@paul-moore.com>, zohar@linux.ibm.com,
        linux-integrity@vger.kernel.org, miklos@szeredi.hu,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Subject: Re: [PATCH] overlayfs: Trigger file re-evaluation by IMA / EVM after
 writes
Message-ID: <20230411-umgewandelt-gastgewerbe-870e4170781c@brauner>
References: <20230407-trasse-umgearbeitet-d580452b7a9b@brauner>
 <90a25725b4b3c96e84faefdb827b261901022606.camel@kernel.org>
 <20230409-genick-pelikan-a1c534c2a3c1@brauner>
 <b2591695afc11a8924a56865c5cd2d59e125413c.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b2591695afc11a8924a56865c5cd2d59e125413c.camel@kernel.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Apr 09, 2023 at 06:12:09PM -0400, Jeff Layton wrote:
> On Sun, 2023-04-09 at 17:22 +0200, Christian Brauner wrote:
> > On Fri, Apr 07, 2023 at 09:29:29AM -0400, Jeff Layton wrote:
> > > > > > > 
> > > > > > > I would ditch the original proposal in favor of this 2-line patch shown here:
> > > > > > > 
> > > > > > > https://lore.kernel.org/linux-integrity/a95f62ed-8b8a-38e5-e468-ecbde3b221af@linux.ibm.com/T/#m3bd047c6e5c8200df1d273c0ad551c645dd43232
> > > > 
> > > > We should cool it with the quick hacks to fix things. :)
> > > > 
> > > 
> > > Yeah. It might fix this specific testcase, but I think the way it uses
> > > the i_version is "gameable" in other situations. Then again, I don't
> > > know a lot about IMA in this regard.
> > > 
> > > When is it expected to remeasure? If it's only expected to remeasure on
> > > a close(), then that's one thing. That would be a weird design though.
> > > 
> > > > > > > 
> > > > > > > 
> > > > > > 
> > > > > > Ok, I think I get it. IMA is trying to use the i_version from the
> > > > > > overlayfs inode.
> > > > > > 
> > > > > > I suspect that the real problem here is that IMA is just doing a bare
> > > > > > inode_query_iversion. Really, we ought to make IMA call
> > > > > > vfs_getattr_nosec (or something like it) to query the getattr routine in
> > > > > > the upper layer. Then overlayfs could just propagate the results from
> > > > > > the upper layer in its response.
> > > > > > 
> > > > > > That sort of design may also eventually help IMA work properly with more
> > > > > > exotic filesystems, like NFS or Ceph.
> > > > > > 
> > > > > > 
> > > > > > 
> > > > > 
> > > > > Maybe something like this? It builds for me but I haven't tested it. It
> > > > > looks like overlayfs already should report the upper layer's i_version
> > > > > in getattr, though I haven't tested that either:
> > > > > 
> > > > > -----------------------8<---------------------------
> > > > > 
> > > > > [PATCH] IMA: use vfs_getattr_nosec to get the i_version
> > > > > 
> > > > > IMA currently accesses the i_version out of the inode directly when it
> > > > > does a measurement. This is fine for most simple filesystems, but can be
> > > > > problematic with more complex setups (e.g. overlayfs).
> > > > > 
> > > > > Make IMA instead call vfs_getattr_nosec to get this info. This allows
> > > > > the filesystem to determine whether and how to report the i_version, and
> > > > > should allow IMA to work properly with a broader class of filesystems in
> > > > > the future.
> > > > > 
> > > > > Reported-by: Stefan Berger <stefanb@linux.ibm.com>
> > > > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > > > ---
> > > > 
> > > > So, I think we want both; we want the ovl_copyattr() and the
> > > > vfs_getattr_nosec() change:
> > > > 
> > > > (1) overlayfs should copy up the inode version in ovl_copyattr(). That
> > > >     is in line what we do with all other inode attributes. IOW, the
> > > >     overlayfs inode's i_version counter should aim to mirror the
> > > >     relevant layer's i_version counter. I wouldn't know why that
> > > >     shouldn't be the case. Asking the other way around there doesn't
> > > >     seem to be any use for overlayfs inodes to have an i_version that
> > > >     isn't just mirroring the relevant layer's i_version.
> > > 
> > > It's less than ideal to do this IMO, particularly with an IS_I_VERSION
> > > inode.
> > > 
> > > You can't just copy up the value from the upper. You'll need to call
> > > inode_query_iversion(upper_inode), which will flag the upper inode for a
> > > logged i_version update on the next write. IOW, this could create some
> > > (probably minor) metadata write amplification in the upper layer inode
> > > with IS_I_VERSION inodes.
> > 
> > I'm likely just missing context and am curious about this so bear with me. Why
> > do we need to flag the upper inode for a logged i_version update? Any required
> > i_version interactions should've already happened when overlayfs called into
> > the upper layer. So all that's left to do is for overlayfs' to mirror the
> > i_version value after the upper operation has returned.
> 
> > ovl_copyattr() - which copies the inode attributes - is always called after the
> > operation on the upper inode has finished. So the additional query seems odd at
> > first glance. But there might well be a good reason for it. In my naive
> > approach I would've thought that sm along the lines of:
> >
> > diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
> > index 923d66d131c1..8b089035b9b3 100644
> > --- a/fs/overlayfs/util.c
> > +++ b/fs/overlayfs/util.c
> > @@ -1119,4 +1119,5 @@ void ovl_copyattr(struct inode *inode)
> >         inode->i_mtime = realinode->i_mtime;
> >         inode->i_ctime = realinode->i_ctime;
> >         i_size_write(inode, i_size_read(realinode));
> > +       inode_set_iversion_raw(inode, inode_peek_iversion_raw(realinode));
> >  }
> > 
> > would've been sufficient.
> > 
> 
> Nope, because then you wouldn't get any updates to i_version after that
> point.
> 
> Note that with an IS_I_VERSION inode we only update the i_version when
> there has been a query since the last update. What you're doing above is
> circumventing that mechanism. You'll get the i_version at the time of of
> the ovl_copyattr, but there won't be any updates of it after that point
> because the QUERIED bit won't end up being set on realinode.

I get all that.
But my understanding had been that the i_version value at the time of
ovl_copyattr() would be correct. Because when ovl_copyattr() is called
the expected i_version change will have been done in the relevant layer
includig raising the QUERIED bit. Since the layers are not allowed to be
changed outside of the overlayfs mount any change to them can only
originate from overlayfs which would necessarily call ovl_copyattr()
again. IOW, overlayfs would by virtue of its implementation keep the
i_version value in sync.

Overlayfs wouldn't even raise SB_I_VERSION. It would indeed just be a
cache of i_version of the relevant layer.

> 
> 
> > Since overlayfs' does explicitly disallow changes to the upper and lower trees
> > while overlayfs is mounted it seems intuitive that it should just mirror the
> > relevant layer's i_version.
> >
> >
> > If we don't do this, then we should probably document that i_version doesn't
> > have a meaning yet for the inodes of stacking filesystems.
> > 
> 
> Trying to cache the i_version is counterproductive, IMO, at least with
> an IS_I_VERSION inode.
> 
> The problem is that a query against the i_version has a side-effect. It
> has to (atomically) mark the inode for an update on the next change.
> 
> If you try to cache that value, you'll likely end up doing more queries
> than you really need to (because you'll need to keep the cache up to
> date) and you'll have an i_version that will necessarily lag the one in
> the upper layer inode.
> 
> The whole point of the change attribute is to get the value as it is at
> this very moment so we can check whether there have been changes. A
> laggy value is not terribly useful.
> 
> Overlayfs should just always call the upper layer's ->getattr to get the
> version. I wouldn't even bother copying it up in the first place. Doing
> so is just encouraging someone to try use the value in the overlayfs
> inode, when they really need to go through ->getattr and get the one
> from the upper layer.

That seems reasonable to me. I read this as an agreeing with my earlier
suggestion to document that i_version doesn't have a meaning for the
inodes of stacking filesystems and that we should spell out that
vfs_getattr()/->getattr() needs to be used to interact with i_version.

We need to explain to subsystems such as IMA somwhere what the correct
way to query i_version agnostically is; independent of filesystem
implementation details.

Looking at IMA, it queries the i_version directly without checking
whether it's an IS_I_VERSION() inode first. This might make a
difference.

Afaict, filesystems that persist i_version to disk automatically raise
SB_I_VERSION. I would guess that it be considered a bug if a filesystem
would persist i_version to disk and not raise SB_I_VERSION. If so IMA
should probably be made to check for IS_I_VERSION() and it will probably
get that by switching to vfs_getattr_nosec().
