Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 107B06DD720
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Apr 2023 11:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbjDKJt4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Apr 2023 05:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjDKJty (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Apr 2023 05:49:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C4BD10E5;
        Tue, 11 Apr 2023 02:49:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D9ADC62040;
        Tue, 11 Apr 2023 09:49:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97AB7C433EF;
        Tue, 11 Apr 2023 09:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681206592;
        bh=hzb6wsanj9Fhf6S8pGb/e2aVLbUsS5asCQMLgnR7mM8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OUYi46PpybHUmEZuZz0R5HvPSgOCWQe0cOlz9ZuTb8867N4tKgxPP3oopT8s6gUbe
         xg9Uzos7+5zE7Q0d7eIdsyo9+xLObClXJF7cSGcCD0Clal3FCRr4ujW5rRImBaJLjf
         +SwJWRKmM6G7wP0siQnWUb32/VJtqc3na7m0a4YaMju9YRUp4Sd34OxiDU9nXiu4qY
         SSk/P/j55OxzHW+d0VnMUhITkjS/6vu1+poHzaxWKbY8giDDRsr4hNrKiB+YY2sPLl
         qiM68B2iaUof1ojRjMixAi9rjczFuRRuMnUbxTuGrSS8jr2FFvPDU+g4RuNom+E0ga
         6NzyjLsO7p2MQ==
Date:   Tue, 11 Apr 2023 11:49:46 +0200
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
Message-ID: <20230411-holzbalken-stuben-6cea8b722a1b@brauner>
References: <20230407-trasse-umgearbeitet-d580452b7a9b@brauner>
 <90a25725b4b3c96e84faefdb827b261901022606.camel@kernel.org>
 <20230409-genick-pelikan-a1c534c2a3c1@brauner>
 <b2591695afc11a8924a56865c5cd2d59e125413c.camel@kernel.org>
 <20230411-umgewandelt-gastgewerbe-870e4170781c@brauner>
 <8f5cc243398d5bae731a26e674bdeff465da3968.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8f5cc243398d5bae731a26e674bdeff465da3968.camel@kernel.org>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 11, 2023 at 05:32:11AM -0400, Jeff Layton wrote:
> On Tue, 2023-04-11 at 10:38 +0200, Christian Brauner wrote:
> > On Sun, Apr 09, 2023 at 06:12:09PM -0400, Jeff Layton wrote:
> > > On Sun, 2023-04-09 at 17:22 +0200, Christian Brauner wrote:
> > > > On Fri, Apr 07, 2023 at 09:29:29AM -0400, Jeff Layton wrote:
> > > > > > > > > 
> > > > > > > > > I would ditch the original proposal in favor of this 2-line patch shown here:
> > > > > > > > > 
> > > > > > > > > https://lore.kernel.org/linux-integrity/a95f62ed-8b8a-38e5-e468-ecbde3b221af@linux.ibm.com/T/#m3bd047c6e5c8200df1d273c0ad551c645dd43232
> > > > > > 
> > > > > > We should cool it with the quick hacks to fix things. :)
> > > > > > 
> > > > > 
> > > > > Yeah. It might fix this specific testcase, but I think the way it uses
> > > > > the i_version is "gameable" in other situations. Then again, I don't
> > > > > know a lot about IMA in this regard.
> > > > > 
> > > > > When is it expected to remeasure? If it's only expected to remeasure on
> > > > > a close(), then that's one thing. That would be a weird design though.
> > > > > 
> > > > > > > > > 
> > > > > > > > > 
> > > > > > > > 
> > > > > > > > Ok, I think I get it. IMA is trying to use the i_version from the
> > > > > > > > overlayfs inode.
> > > > > > > > 
> > > > > > > > I suspect that the real problem here is that IMA is just doing a bare
> > > > > > > > inode_query_iversion. Really, we ought to make IMA call
> > > > > > > > vfs_getattr_nosec (or something like it) to query the getattr routine in
> > > > > > > > the upper layer. Then overlayfs could just propagate the results from
> > > > > > > > the upper layer in its response.
> > > > > > > > 
> > > > > > > > That sort of design may also eventually help IMA work properly with more
> > > > > > > > exotic filesystems, like NFS or Ceph.
> > > > > > > > 
> > > > > > > > 
> > > > > > > > 
> > > > > > > 
> > > > > > > Maybe something like this? It builds for me but I haven't tested it. It
> > > > > > > looks like overlayfs already should report the upper layer's i_version
> > > > > > > in getattr, though I haven't tested that either:
> > > > > > > 
> > > > > > > -----------------------8<---------------------------
> > > > > > > 
> > > > > > > [PATCH] IMA: use vfs_getattr_nosec to get the i_version
> > > > > > > 
> > > > > > > IMA currently accesses the i_version out of the inode directly when it
> > > > > > > does a measurement. This is fine for most simple filesystems, but can be
> > > > > > > problematic with more complex setups (e.g. overlayfs).
> > > > > > > 
> > > > > > > Make IMA instead call vfs_getattr_nosec to get this info. This allows
> > > > > > > the filesystem to determine whether and how to report the i_version, and
> > > > > > > should allow IMA to work properly with a broader class of filesystems in
> > > > > > > the future.
> > > > > > > 
> > > > > > > Reported-by: Stefan Berger <stefanb@linux.ibm.com>
> > > > > > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > > > > > ---
> > > > > > 
> > > > > > So, I think we want both; we want the ovl_copyattr() and the
> > > > > > vfs_getattr_nosec() change:
> > > > > > 
> > > > > > (1) overlayfs should copy up the inode version in ovl_copyattr(). That
> > > > > >     is in line what we do with all other inode attributes. IOW, the
> > > > > >     overlayfs inode's i_version counter should aim to mirror the
> > > > > >     relevant layer's i_version counter. I wouldn't know why that
> > > > > >     shouldn't be the case. Asking the other way around there doesn't
> > > > > >     seem to be any use for overlayfs inodes to have an i_version that
> > > > > >     isn't just mirroring the relevant layer's i_version.
> > > > > 
> > > > > It's less than ideal to do this IMO, particularly with an IS_I_VERSION
> > > > > inode.
> > > > > 
> > > > > You can't just copy up the value from the upper. You'll need to call
> > > > > inode_query_iversion(upper_inode), which will flag the upper inode for a
> > > > > logged i_version update on the next write. IOW, this could create some
> > > > > (probably minor) metadata write amplification in the upper layer inode
> > > > > with IS_I_VERSION inodes.
> > > > 
> > > > I'm likely just missing context and am curious about this so bear with me. Why
> > > > do we need to flag the upper inode for a logged i_version update? Any required
> > > > i_version interactions should've already happened when overlayfs called into
> > > > the upper layer. So all that's left to do is for overlayfs' to mirror the
> > > > i_version value after the upper operation has returned.
> > > 
> > > > ovl_copyattr() - which copies the inode attributes - is always called after the
> > > > operation on the upper inode has finished. So the additional query seems odd at
> > > > first glance. But there might well be a good reason for it. In my naive
> > > > approach I would've thought that sm along the lines of:
> > > > 
> > > > diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
> > > > index 923d66d131c1..8b089035b9b3 100644
> > > > --- a/fs/overlayfs/util.c
> > > > +++ b/fs/overlayfs/util.c
> > > > @@ -1119,4 +1119,5 @@ void ovl_copyattr(struct inode *inode)
> > > >         inode->i_mtime = realinode->i_mtime;
> > > >         inode->i_ctime = realinode->i_ctime;
> > > >         i_size_write(inode, i_size_read(realinode));
> > > > +       inode_set_iversion_raw(inode, inode_peek_iversion_raw(realinode));
> > > >  }
> > > > 
> > > > would've been sufficient.
> > > > 
> > > 
> > > Nope, because then you wouldn't get any updates to i_version after that
> > > point.
> > > 
> > > Note that with an IS_I_VERSION inode we only update the i_version when
> > > there has been a query since the last update. What you're doing above is
> > > circumventing that mechanism. You'll get the i_version at the time of of
> > > the ovl_copyattr, but there won't be any updates of it after that point
> > > because the QUERIED bit won't end up being set on realinode.
> > 
> > I get all that.
> > But my understanding had been that the i_version value at the time of
> > ovl_copyattr() would be correct. Because when ovl_copyattr() is called
> > the expected i_version change will have been done in the relevant layer
> > includig raising the QUERIED bit. Since the layers are not allowed to be
> > changed outside of the overlayfs mount any change to them can only
> > originate from overlayfs which would necessarily call ovl_copyattr()
> > again. IOW, overlayfs would by virtue of its implementation keep the
> > i_version value in sync.
> >
> > Overlayfs wouldn't even raise SB_I_VERSION. It would indeed just be a
> > cache of i_version of the relevant layer.
> > 
> > > 
> > > 
> > > > Since overlayfs' does explicitly disallow changes to the upper and lower trees
> > > > while overlayfs is mounted it seems intuitive that it should just mirror the
> > > > relevant layer's i_version.
> > > > 
> > > > 
> > > > If we don't do this, then we should probably document that i_version doesn't
> > > > have a meaning yet for the inodes of stacking filesystems.
> > > > 
> > > 
> > > Trying to cache the i_version is counterproductive, IMO, at least with
> > > an IS_I_VERSION inode.
> > > 
> > > The problem is that a query against the i_version has a side-effect. It
> > > has to (atomically) mark the inode for an update on the next change.
> > > 
> > > If you try to cache that value, you'll likely end up doing more queries
> > > than you really need to (because you'll need to keep the cache up to
> > > date) and you'll have an i_version that will necessarily lag the one in
> > > the upper layer inode.
> > > 
> > > The whole point of the change attribute is to get the value as it is at
> > > this very moment so we can check whether there have been changes. A
> > > laggy value is not terribly useful.
> > > 
> > > Overlayfs should just always call the upper layer's ->getattr to get the
> > > version. I wouldn't even bother copying it up in the first place. Doing
> > > so is just encouraging someone to try use the value in the overlayfs
> > > inode, when they really need to go through ->getattr and get the one
> > > from the upper layer.
> > 
> > That seems reasonable to me. I read this as an agreeing with my earlier
> > suggestion to document that i_version doesn't have a meaning for the
> > inodes of stacking filesystems and that we should spell out that
> > vfs_getattr()/->getattr() needs to be used to interact with i_version.
> > 
> 
> It really has no meaning in the stacked filesystem's _inode_. The only
> i_version that has any meaning in a (simple) stacking setup is the upper
> layer inode.

Ok, we're on the same page then.

> 
> > We need to explain to subsystems such as IMA somwhere what the correct
> > way to query i_version agnostically is; independent of filesystem
> > implementation details.
> > 
> > Looking at IMA, it queries the i_version directly without checking
> > whether it's an IS_I_VERSION() inode first. This might make a
> > difference.
> > 
> 
> IMA should just use getattr. That allows the filesystem to present the
> i_version to the caller as it sees fit. Fetching i_version directly
> without testing for IS_I_VERSION is wrong, because you don't know what
> that field contains, or whether the fs supports it at all.

Yep, same page again.

> 
> > Afaict, filesystems that persist i_version to disk automatically raise
> > SB_I_VERSION. I would guess that it be considered a bug if a filesystem
> > would persist i_version to disk and not raise SB_I_VERSION. If so IMA
> > should probably be made to check for IS_I_VERSION() and it will probably
> > get that by switching to vfs_getattr_nosec().
> 
> Not quite. SB_I_VERSION tells the vfs that the filesystem wants the
> kernel to manage the increment of the i_version for it. The filesystem
> is still responsible for persisting that value to disk (if appropriate).

Yes, sure it's the filesystems responsibility to persist it to disk or
not. What I tried to ask was that when a filesystem does persist
i_version to disk then would it be legal to mount it without
SB_I_VERSION (because ext2/ext3 did use to have that mount option)? If
it would then the filesystem would probably need to take care to leave
the i_version field in struct inode uninitialized to avoid confusion or
would that just work? (Mere curiosity, don't feel obligated to go into
detail here. I don't want to hog your time.)

> 
> Switching to vfs_getattr_nosec should make it so IMA doesn't need to
> worry about the gory details of all of this. If STATX_CHANGE_COOKIE is
> set in the response, then it can trust that value. Otherwise, it's no
> good.

Yep, same page again.
