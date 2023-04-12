Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA2836DEFF4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Apr 2023 10:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbjDLI7A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Apr 2023 04:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbjDLI67 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Apr 2023 04:58:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6189883DE;
        Wed, 12 Apr 2023 01:58:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DF5CE631EE;
        Wed, 12 Apr 2023 08:58:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B61BC433EF;
        Wed, 12 Apr 2023 08:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681289917;
        bh=gPq043utUs6vGpTj521da5rkcFzomQPjKBNSTssrroo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Lxf5Toj26s7hLfVEqbE7Q5jleBdWRUze8l7oi7slbCFsOIEEApZdF5lkE2/WKbJg3
         Ua1p/X8m5G4dWmt4B76B2nDBNycrfzMVb8v3Ri+Lgj+Egz25t3MBB6vdW9GnOnjeqb
         U4ajd8zGiFM9a9+UADrZIvGXorAtjF5PatItkUEqKcOCGtWri0Q2pZgKxPInC/IGKo
         59TzAkh7vWjY30FdYiGacw8moJVeIfpBrnck5pCRQN6+QQqMwPX4Eaw/7Qmth+tyY8
         dO/xqqxC8V7f3J8G1M+h0w9DfGPbZ+Ktj06eYqL6/MDqTiD8wW84lGWIcXwovtf+C2
         q+RikUpKBBgrA==
Date:   Wed, 12 Apr 2023 10:58:31 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Anna Schumaker <anna@kernel.org>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>,
        Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2] nfs: use vfs setgid helper
Message-ID: <20230412-parodie-leitung-9da1a5dbf9ef@brauner>
References: <20230313-fs-nfs-setgid-v2-1-9a59f436cfc0@kernel.org>
 <CAFX2JfkZr4qC9dgxsUxUqsLVKhosmn59BoKig4o5oPT_jBUodg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFX2JfkZr4qC9dgxsUxUqsLVKhosmn59BoKig4o5oPT_jBUodg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 11, 2023 at 12:54:25PM -0400, Anna Schumaker wrote:
> Hi Christian,
> 
> On Tue, Mar 14, 2023 at 7:51 AM Christian Brauner <brauner@kernel.org> wrote:
> >
> > We've aligned setgid behavior over multiple kernel releases. The details
> > can be found in the following two merge messages:
> > cf619f891971 ("Merge tag 'fs.ovl.setgid.v6.2')
> > 426b4ca2d6a5 ("Merge tag 'fs.setgid.v6.0')
> > Consistent setgid stripping behavior is now encapsulated in the
> > setattr_should_drop_sgid() helper which is used by all filesystems that
> > strip setgid bits outside of vfs proper. Switch nfs to rely on this
> > helper as well. Without this patch the setgid stripping tests in
> > xfstests will fail.
> >
> > Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
> > ---
> > Changes in v2:
> > - Christoph Hellwig <hch@lst.de>:
> >   * Export setattr_should_sgid() so it actually can be used by filesystems
> > - Link to v1: https://lore.kernel.org/r/20230313-fs-nfs-setgid-v1-1-5b1fa599f186@kernel.org
> > ---
> >  fs/attr.c          | 1 +
> >  fs/internal.h      | 2 --
> >  fs/nfs/inode.c     | 4 +---
> >  include/linux/fs.h | 2 ++
> >  4 files changed, 4 insertions(+), 5 deletions(-)
> >
> > diff --git a/fs/attr.c b/fs/attr.c
> > index aca9ff7aed33..d60dc1edb526 100644
> > --- a/fs/attr.c
> > +++ b/fs/attr.c
> > @@ -47,6 +47,7 @@ int setattr_should_drop_sgid(struct mnt_idmap *idmap,
> >                 return ATTR_KILL_SGID;
> >         return 0;
> >  }
> > +EXPORT_SYMBOL(setattr_should_drop_sgid);
> >
> >  /**
> >   * setattr_should_drop_suidgid - determine whether the set{g,u}id bit needs to
> > diff --git a/fs/internal.h b/fs/internal.h
> > index dc4eb91a577a..ab36ed8fa41c 100644
> > --- a/fs/internal.h
> > +++ b/fs/internal.h
> > @@ -259,8 +259,6 @@ ssize_t __kernel_write_iter(struct file *file, struct iov_iter *from, loff_t *po
> >  /*
> >   * fs/attr.c
> >   */
> > -int setattr_should_drop_sgid(struct mnt_idmap *idmap,
> > -                            const struct inode *inode);
> >  struct mnt_idmap *alloc_mnt_idmap(struct user_namespace *mnt_userns);
> >  struct mnt_idmap *mnt_idmap_get(struct mnt_idmap *idmap);
> >  void mnt_idmap_put(struct mnt_idmap *idmap);
> > diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
> > index 222a28320e1c..97a76706fd54 100644
> > --- a/fs/nfs/inode.c
> > +++ b/fs/nfs/inode.c
> > @@ -717,9 +717,7 @@ void nfs_setattr_update_inode(struct inode *inode, struct iattr *attr,
> >                 if ((attr->ia_valid & ATTR_KILL_SUID) != 0 &&
> >                     inode->i_mode & S_ISUID)
> >                         inode->i_mode &= ~S_ISUID;
> > -               if ((attr->ia_valid & ATTR_KILL_SGID) != 0 &&
> > -                   (inode->i_mode & (S_ISGID | S_IXGRP)) ==
> > -                    (S_ISGID | S_IXGRP))
> > +               if (setattr_should_drop_sgid(&nop_mnt_idmap, inode))
> >                         inode->i_mode &= ~S_ISGID;
> >                 if ((attr->ia_valid & ATTR_MODE) != 0) {
> >                         int mode = attr->ia_mode & S_IALLUGO;
> 
> Will this be going through your tree (due to the VFS leve changes)?
> If so, you can add:
> 
> Acked-by: Anna Schumaker <anna.schumaker@netapp.com>

Yes, I have it applied to fs.misc. There should be a corresponding
"applied message" I've sent last week. Thanks for taking a look!

Christian
