Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 362995F0C05
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Sep 2022 14:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231631AbiI3Muo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Sep 2022 08:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231442AbiI3MuN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Sep 2022 08:50:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72CCD386B2;
        Fri, 30 Sep 2022 05:49:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 90EB862319;
        Fri, 30 Sep 2022 12:49:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 169B8C433C1;
        Fri, 30 Sep 2022 12:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664542194;
        bh=D4oBTaBwVeWJ35Yt/yHt4NADM31T29ztR6d2vheFl28=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tBWE4qkHD7CRmNAapEHnorhelPof37BhI+v0QKXsT2pIj9fc1IZpYbmgAkpQLQFj6
         XhG11jhnCc0YvtQHswGaJVtf3YKcV0Ch+EL0tdVVy8deXA1LOSSiA78SJvtENBqkbv
         5NC5uVP8ntmqTYyshe8FVSRhj73ppvukeFDCMJKKnd65uEb1oUPgrXFW1LmDRrfYTL
         hRpiZW1xzrOhEecYSmQTTMeiwDneAkJsKUAx411fQI0tFWDKGKAucjyWboSgl7Cx5S
         w5SwuBqa46o3FMgkYQrPvEcemU3kSiU42w1FLzlH3SHN36USicwkv0GzQLCJBrxmoH
         ksLUHncNh3g0Q==
Date:   Fri, 30 Sep 2022 14:49:48 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-security-module@vger.kernel.org,
        Steve French <sfrench@samba.org>
Subject: Re: [PATCH v4 04/30] fs: add new get acl method
Message-ID: <20220930124948.2mhh4bsojrlqbsmu@wittgenstein>
References: <20220929153041.500115-1-brauner@kernel.org>
 <20220929153041.500115-5-brauner@kernel.org>
 <CAJfpegterbOyGGDbHY8LidzR45TTbhHdRG728mQQi_LaNMS3PA@mail.gmail.com>
 <20220930090949.cl3ajz7r4ub6jrae@wittgenstein>
 <CAJfpegsu9r84J-3wN=z8OOzHd+7YRBn9CNFMDWSbftCEm0e27A@mail.gmail.com>
 <20220930100557.7hqjrz77s3wcbrxx@wittgenstein>
 <CAJfpegvJUSowMaS7s_vLWvznLmfpkEfbvZbb_Vo-H8VewucByA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJfpegvJUSowMaS7s_vLWvznLmfpkEfbvZbb_Vo-H8VewucByA@mail.gmail.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 30, 2022 at 02:24:33PM +0200, Miklos Szeredi wrote:
> On Fri, 30 Sept 2022 at 12:06, Christian Brauner <brauner@kernel.org> wrote:
> >
> > On Fri, Sep 30, 2022 at 11:43:07AM +0200, Miklos Szeredi wrote:
> > > On Fri, 30 Sept 2022 at 11:09, Christian Brauner <brauner@kernel.org> wrote:
> > > >
> > > > On Fri, Sep 30, 2022 at 10:53:05AM +0200, Miklos Szeredi wrote:
> > > > > On Thu, 29 Sept 2022 at 17:31, Christian Brauner <brauner@kernel.org> wrote:
> > > > >
> > > > > > This adds a new ->get_acl() inode operations which takes a dentry
> > > > > > argument which filesystems such as 9p, cifs, and overlayfs can implement
> > > > > > to get posix acls.
> > > > >
> > > > > This is confusing.   For example overlayfs ends up with two functions
> > > > > that are similar, but not quite the same:
> > > > >
> > > > >  ovl_get_acl -> ovl_get_acl_path -> vfs_get_acl -> __get_acl(mnt_userns, ...)
> > > > >
> > > > >  ovl_get_inode_acl -> get_inode_acl -> __get_acl(&init_user_ns, ...)
> > > > >
> > > > > So what's the difference and why do we need both?  If one can retrive
> > > > > the acl without dentry, then why do we need the one with the dentry?
> > > >
> > > > The ->get_inode_acl() method is called during generic_permission() and
> > > > inode_permission() both of which are called from various filesystems in
> > > > their ->permission inode operations. There's no dentry available during
> > > > the permission inode operation and there are filesystems like 9p and
> > > > cifs that need a dentry.
> > >
> > > This doesn't answer the question about why we need two for overlayfs
> > > and what's the difference between them.
> >
> > Oh sorry, I misunderstood your questions then. The reason why I didn't
> > consolidate them was simply the different in permission checking.
> > So currently in current mainline overlayfs does acl = get_acl() in it's
> > get acl method and does vfs_getxattr() in ovl_posix_acl_xattr_get().
> >
> > The difference is that vfs_getxattr() goes through regular lsm hooks
> > checking whereas get_acl() does not. So I thought that using get_acl()
> > was done to not call lsm hooks in there. If that's not the case then I
> > can consolidate both into one implementation.
> 
> So there are two paths to getting an acl: 1) permission checking and
> 2) retrieving the value via getxattr(2).
> 
> This is a similar situation as reading a symlink vs. following it.
> When following a symlink overlayfs always reads the link on the
> underlying fs just as if it was a readlink(2) call, calling
> security_inode_readlink() instead of security_inode_follow_link().
> This is logical: we are reading the link from the underlying storage,
> and following it on overlayfs.
> 
> Applying the same logic to acl: we do need to call the
> security_inode_getxattr() on the underlying fs, even if just want to
> check permissions on overlay.  This is currently not done, which is an
> inconsistency.
> 
> Maybe adding the check to ovl_get_acl() is the right way to go, but
> I'm a little afraid of a performance regression.  Will look into that.

Ok, sounds good. I can probably consolidate the two versions but retain
the difference in permission checking or would you prefer I leave them
distinct for now?

> 
> So this patchset nicely reveals how acl retrieval could be done two
> ways, and how overlayfs employed both for different purposes.  But
> what would be even nicer if there was just one way to retrieve the acl
> and overlayfs and cifs be moved over to that.

I think this is a good long term goal to have. We're certainly not done
with improving things after this work. Sometimes it just takes a little
time to phase out legacy baggage as we all are well aware.
