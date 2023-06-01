Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE8371A388
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Jun 2023 18:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233969AbjFAP7a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Jun 2023 11:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233685AbjFAP73 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Jun 2023 11:59:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A10B9189;
        Thu,  1 Jun 2023 08:59:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 381E764723;
        Thu,  1 Jun 2023 15:59:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37EF3C4339B;
        Thu,  1 Jun 2023 15:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685635164;
        bh=v6Me0Vi0OPMjC4Nwo6IILVCGNcxNvRB+M3qtqySEtLs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M2nxWuMGbsdaBc/My2KiKfzRvTPW51vmdYdTMrRn94G3k+0Q33JsvISp8r4BMAnlt
         UEcpP/g+vfFU5G6PKwaNiMED3A57qys/JWvTwvDrwjkfEKd1h9RQ5dJRaC6nHX8n1B
         Kswoql+MByzej5ONv+dxgUOpeIZmhQHhxhq174OGKozqyTzQ3wG38mMhJW6vJoORDK
         Mmizpps1cxv8LaU/pN6OGDLUSSpK84xNw/CBS5sYJtrTf4l/rZXT6hcRjMt2iecuc0
         xEtMUwQvXFY9QvlYGYPIIiGFUECaSR/S0iv51Jd2zl5PIqCx6rj8bc+ujPd706f586
         gPb3KXAU+/vlA==
Date:   Thu, 1 Jun 2023 17:59:19 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Al Viro <viro@ZenIV.linux.org.uk>, linux-fsdevel@vger.kernel.org,
        Miklos Szeredi <miklos@szeredi.hu>,
        "Darrick J. Wong" <djwong@kernel.org>, Ted Tso <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        stable@vger.kernel.org
Subject: Re: [PATCH v2 4/6] fs: Establish locking order for unrelated
 directories
Message-ID: <20230601-laube-golfball-c31fb218a534@brauner>
References: <20230601104525.27897-1-jack@suse.cz>
 <20230601105830.13168-4-jack@suse.cz>
 <20230601-gebracht-gesehen-c779a56b3bf3@brauner>
 <20230601152449.h4ur5zrfqjqygujd@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230601152449.h4ur5zrfqjqygujd@quack3>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 01, 2023 at 05:24:49PM +0200, Jan Kara wrote:
> On Thu 01-06-23 15:58:58, Christian Brauner wrote:
> > On Thu, Jun 01, 2023 at 12:58:24PM +0200, Jan Kara wrote:
> > > Currently the locking order of inode locks for directories that are not
> > > in ancestor relationship is not defined because all operations that
> > > needed to lock two directories like this were serialized by
> > > sb->s_vfs_rename_mutex. However some filesystems need to lock two
> > > subdirectories for RENAME_EXCHANGE operations and for this we need the
> > > locking order established even for two tree-unrelated directories.
> > > Provide a helper function lock_two_inodes() that establishes lock
> > > ordering for any two inodes and use it in lock_two_directories().
> > > 
> > > CC: stable@vger.kernel.org
> > > Signed-off-by: Jan Kara <jack@suse.cz>
> > > ---
> > >  fs/inode.c    | 42 ++++++++++++++++++++++++++++++++++++++++++
> > >  fs/internal.h |  2 ++
> > >  fs/namei.c    |  4 ++--
> > >  3 files changed, 46 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/fs/inode.c b/fs/inode.c
> > > index 577799b7855f..4000ab08bbc0 100644
> > > --- a/fs/inode.c
> > > +++ b/fs/inode.c
> > > @@ -1103,6 +1103,48 @@ void discard_new_inode(struct inode *inode)
> > >  }
> > >  EXPORT_SYMBOL(discard_new_inode);
> > >  
> > > +/**
> > > + * lock_two_inodes - lock two inodes (may be regular files but also dirs)
> > > + *
> > > + * Lock any non-NULL argument. The caller must make sure that if he is passing
> > > + * in two directories, one is not ancestor of the other.  Zero, one or two
> > > + * objects may be locked by this function.
> > > + *
> > > + * @inode1: first inode to lock
> > > + * @inode2: second inode to lock
> > > + * @subclass1: inode lock subclass for the first lock obtained
> > > + * @subclass2: inode lock subclass for the second lock obtained
> > > + */
> > > +void lock_two_inodes(struct inode *inode1, struct inode *inode2,
> > > +		     unsigned subclass1, unsigned subclass2)
> > > +{
> > > +	if (!inode1 || !inode2)
> > 
> > I think you forgot the opening bracket...
> > I can just fix this up for you though.
> 
> Oh, yes. Apparently I forgot to rerun git-format-patch after fixing up this
> bit. I'm sorry for that. The patch series has survived full ext4 fstests

No problem at all!
