Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4084C6DC08E
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Apr 2023 17:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbjDIPW5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 9 Apr 2023 11:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjDIPW4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 9 Apr 2023 11:22:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E802D4A;
        Sun,  9 Apr 2023 08:22:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B564060C08;
        Sun,  9 Apr 2023 15:22:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71EE2C433D2;
        Sun,  9 Apr 2023 15:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681053774;
        bh=JoFbzbecQMar72QvO0uBIMm1UiIbJWJem2Ie54x9qbA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ESnq4grFoKkT4WAbHlcu94zOs2tgO4EKL0auznMVcvldsb9SuYy0kJPvOZWsLb5+X
         ZVBGj9jj2B9melGWpNTqh6CJqzokKZFxLNGokUTE7Q9KbzLXbBkuuJrE0aw3B9+4cR
         fXbEEBHNndTwwFzevhNcaroQm50QPgFUdni4i1ii/x/nLWMvTi5N67rwqobmJ6y3IA
         oqRUa5pENSBGdmF5o6+cTQ2LxoOc2wAmJtrWLQlHpH03x9E3PI/mX6i4Yj9M9XP1pv
         k628DafFoMZXLLlfuKJApX8XgTAxPD/vW8yOA36uHZ1BWoGK3VOMQcbzDLFz1O1bAs
         QxzLSBDS2+gow==
Date:   Sun, 9 Apr 2023 17:22:47 +0200
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
Message-ID: <20230409-genick-pelikan-a1c534c2a3c1@brauner>
References: <20230407-trasse-umgearbeitet-d580452b7a9b@brauner>
 <90a25725b4b3c96e84faefdb827b261901022606.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <90a25725b4b3c96e84faefdb827b261901022606.camel@kernel.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 07, 2023 at 09:29:29AM -0400, Jeff Layton wrote:
> > > > > 
> > > > > I would ditch the original proposal in favor of this 2-line patch shown here:
> > > > > 
> > > > > https://lore.kernel.org/linux-integrity/a95f62ed-8b8a-38e5-e468-ecbde3b221af@linux.ibm.com/T/#m3bd047c6e5c8200df1d273c0ad551c645dd43232
> > 
> > We should cool it with the quick hacks to fix things. :)
> > 
> 
> Yeah. It might fix this specific testcase, but I think the way it uses
> the i_version is "gameable" in other situations. Then again, I don't
> know a lot about IMA in this regard.
> 
> When is it expected to remeasure? If it's only expected to remeasure on
> a close(), then that's one thing. That would be a weird design though.
> 
> > > > > 
> > > > > 
> > > > 
> > > > Ok, I think I get it. IMA is trying to use the i_version from the
> > > > overlayfs inode.
> > > > 
> > > > I suspect that the real problem here is that IMA is just doing a bare
> > > > inode_query_iversion. Really, we ought to make IMA call
> > > > vfs_getattr_nosec (or something like it) to query the getattr routine in
> > > > the upper layer. Then overlayfs could just propagate the results from
> > > > the upper layer in its response.
> > > > 
> > > > That sort of design may also eventually help IMA work properly with more
> > > > exotic filesystems, like NFS or Ceph.
> > > > 
> > > > 
> > > > 
> > > 
> > > Maybe something like this? It builds for me but I haven't tested it. It
> > > looks like overlayfs already should report the upper layer's i_version
> > > in getattr, though I haven't tested that either:
> > > 
> > > -----------------------8<---------------------------
> > > 
> > > [PATCH] IMA: use vfs_getattr_nosec to get the i_version
> > > 
> > > IMA currently accesses the i_version out of the inode directly when it
> > > does a measurement. This is fine for most simple filesystems, but can be
> > > problematic with more complex setups (e.g. overlayfs).
> > > 
> > > Make IMA instead call vfs_getattr_nosec to get this info. This allows
> > > the filesystem to determine whether and how to report the i_version, and
> > > should allow IMA to work properly with a broader class of filesystems in
> > > the future.
> > > 
> > > Reported-by: Stefan Berger <stefanb@linux.ibm.com>
> > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > ---
> > 
> > So, I think we want both; we want the ovl_copyattr() and the
> > vfs_getattr_nosec() change:
> > 
> > (1) overlayfs should copy up the inode version in ovl_copyattr(). That
> >     is in line what we do with all other inode attributes. IOW, the
> >     overlayfs inode's i_version counter should aim to mirror the
> >     relevant layer's i_version counter. I wouldn't know why that
> >     shouldn't be the case. Asking the other way around there doesn't
> >     seem to be any use for overlayfs inodes to have an i_version that
> >     isn't just mirroring the relevant layer's i_version.
> 
> It's less than ideal to do this IMO, particularly with an IS_I_VERSION
> inode.
> 
> You can't just copy up the value from the upper. You'll need to call
> inode_query_iversion(upper_inode), which will flag the upper inode for a
> logged i_version update on the next write. IOW, this could create some
> (probably minor) metadata write amplification in the upper layer inode
> with IS_I_VERSION inodes.

I'm likely just missing context and am curious about this so bear with me. Why
do we need to flag the upper inode for a logged i_version update? Any required
i_version interactions should've already happened when overlayfs called into
the upper layer. So all that's left to do is for overlayfs' to mirror the
i_version value after the upper operation has returned.

ovl_copyattr() - which copies the inode attributes - is always called after the
operation on the upper inode has finished. So the additional query seems odd at
first glance. But there might well be a good reason for it. In my naive
approach I would've thought that sm along the lines of:

diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index 923d66d131c1..8b089035b9b3 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -1119,4 +1119,5 @@ void ovl_copyattr(struct inode *inode)
        inode->i_mtime = realinode->i_mtime;
        inode->i_ctime = realinode->i_ctime;
        i_size_write(inode, i_size_read(realinode));
+       inode_set_iversion_raw(inode, inode_peek_iversion_raw(realinode));
 }

would've been sufficient.

Since overlayfs' does explicitly disallow changes to the upper and lower trees
while overlayfs is mounted it seems intuitive that it should just mirror the
relevant layer's i_version.

If we don't do this, then we should probably document that i_version doesn't
have a meaning yet for the inodes of stacking filesystems.

> 
> 
> > (2) Jeff's changes for ima to make it rely on vfs_getattr_nosec().
> >     Currently, ima assumes that it will get the correct i_version from
> >     an inode but that just doesn't hold for stacking filesystem.
> > 
> > While (1) would likely just fix the immediate bug (2) is correct and
> > _robust_. If we change how attributes are handled vfs_*() helpers will
> > get updated and ima with it. Poking at raw inodes without using
> > appropriate helpers is much more likely to get ima into trouble.
> 
> This will fix it the right way, I think (assuming it actually works),
> and should open the door for IMA to work properly with networked
> filesystems that support i_version as well.
> 
> Note that there Stephen is correct that calling getattr is probably
> going to be less efficient here since we're going to end up calling
> generic_fillattr unnecessarily, but I still think it's the right thing
> to do.
> 
> If it turns out to cause measurable performance regressions though,
> maybe we can look at adding a something that still calls ->getattr if it
> exists but only returns the change_cookie value.

Sounds good to me.
