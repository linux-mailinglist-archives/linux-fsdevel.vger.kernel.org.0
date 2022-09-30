Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD73A5F083D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Sep 2022 12:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230442AbiI3KGH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Sep 2022 06:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbiI3KGG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Sep 2022 06:06:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8827EE665;
        Fri, 30 Sep 2022 03:06:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 63DD9B82698;
        Fri, 30 Sep 2022 10:06:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39444C433C1;
        Fri, 30 Sep 2022 10:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664532362;
        bh=SZoVfKMiuL2CaWcPoxwXVi2mVl6d7mnyJe83W4wW6Ls=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UGJGW5UU3Rwg7Xy0iELKEtiiPdNA/jLtf3Ser6hjR6NfT+33WPkxkfOoqeBCiGYRd
         15ZHwQMR0ucATMyCVZcwkwYV6VoYhlJ4mV+qCG2oyzl5d1Efd4yGv42izEKAZlPcay
         g+Ot+nX7LEKdlVtZfgv343JvokXaLgsKaKlYJDt5Oo3hcj/3DOphw+DEtP5XTlIIKB
         qPfMgyMcqAIdSmr3QKLo2vUmxIioj+msBZXsh2IP84xXDcUA7zJnVOepA7daYeErpY
         FxU7QFUHuJu1I7a/5YZVjbKOTpn5YBSeTffEy7k5MPivp4OIlsPwQjMKDZcWCMHPfa
         cF1a0uUtsNNtQ==
Date:   Fri, 30 Sep 2022 12:05:57 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-security-module@vger.kernel.org,
        Steve French <sfrench@samba.org>
Subject: Re: [PATCH v4 04/30] fs: add new get acl method
Message-ID: <20220930100557.7hqjrz77s3wcbrxx@wittgenstein>
References: <20220929153041.500115-1-brauner@kernel.org>
 <20220929153041.500115-5-brauner@kernel.org>
 <CAJfpegterbOyGGDbHY8LidzR45TTbhHdRG728mQQi_LaNMS3PA@mail.gmail.com>
 <20220930090949.cl3ajz7r4ub6jrae@wittgenstein>
 <CAJfpegsu9r84J-3wN=z8OOzHd+7YRBn9CNFMDWSbftCEm0e27A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJfpegsu9r84J-3wN=z8OOzHd+7YRBn9CNFMDWSbftCEm0e27A@mail.gmail.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 30, 2022 at 11:43:07AM +0200, Miklos Szeredi wrote:
> On Fri, 30 Sept 2022 at 11:09, Christian Brauner <brauner@kernel.org> wrote:
> >
> > On Fri, Sep 30, 2022 at 10:53:05AM +0200, Miklos Szeredi wrote:
> > > On Thu, 29 Sept 2022 at 17:31, Christian Brauner <brauner@kernel.org> wrote:
> > >
> > > > This adds a new ->get_acl() inode operations which takes a dentry
> > > > argument which filesystems such as 9p, cifs, and overlayfs can implement
> > > > to get posix acls.
> > >
> > > This is confusing.   For example overlayfs ends up with two functions
> > > that are similar, but not quite the same:
> > >
> > >  ovl_get_acl -> ovl_get_acl_path -> vfs_get_acl -> __get_acl(mnt_userns, ...)
> > >
> > >  ovl_get_inode_acl -> get_inode_acl -> __get_acl(&init_user_ns, ...)
> > >
> > > So what's the difference and why do we need both?  If one can retrive
> > > the acl without dentry, then why do we need the one with the dentry?
> >
> > The ->get_inode_acl() method is called during generic_permission() and
> > inode_permission() both of which are called from various filesystems in
> > their ->permission inode operations. There's no dentry available during
> > the permission inode operation and there are filesystems like 9p and
> > cifs that need a dentry.
> 
> This doesn't answer the question about why we need two for overlayfs
> and what's the difference between them.

Oh sorry, I misunderstood your questions then. The reason why I didn't
consolidate them was simply the different in permission checking.
So currently in current mainline overlayfs does acl = get_acl() in it's
get acl method and does vfs_getxattr() in ovl_posix_acl_xattr_get().

The difference is that vfs_getxattr() goes through regular lsm hooks
checking whereas get_acl() does not. So I thought that using get_acl()
was done to not call lsm hooks in there. If that's not the case then I
can consolidate both into one implementation.
