Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2BF75129DE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Apr 2022 05:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242048AbiD1DPp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Apr 2022 23:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239209AbiD1DPo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Apr 2022 23:15:44 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1988661280;
        Wed, 27 Apr 2022 20:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=u5MprlGxwLuMeWMkjHBy4vIDeEb5oazei8joHtscDTs=; b=H9bflCLL95BVz2RxPRaVlr45re
        Psvhz3jOnF454l40wvcNhO1TBHmtfZC1zTXaSCG2OIIWgyCs+b7KYukjXj+SQoEsPIoQrCmoGlp+Y
        A7SJGCpp+FOGMG+oARDByfNznzbTuQcD8BBHs9XZiTubwmOtH9gabuCypjo60mcbwnWL5mBF4YLJz
        Eqmfh7n7ZCQZJCytVpb5IHrGE5ibo3Cpq67lvI+f0bZ68dxhR5ntDqaDXUWImOwo57zhCwVD3EXNN
        z9ORXbHYapzBv4vDJyyERV6yNYXT0Ivl93II93YRdA0g2O6qLIqHiFbkDhaHsC6qysRX8FWBzCGq/
        OCquSB6Q==;
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1njuZy-00A6sh-GA; Thu, 28 Apr 2022 03:12:30 +0000
Date:   Thu, 28 Apr 2022 03:12:30 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jann Horn <jannh@google.com>
Subject: Re: [PATCH v8 1/4] fs: add mode_strip_sgid() helper
Message-ID: <YmoGHrNVtfXsl6vM@zeniv-ca.linux.org.uk>
References: <1650971490-4532-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <Ymn05eNgOnaYy36R@zeniv-ca.linux.org.uk>
 <Ymn4xPXXWe4LFhPZ@zeniv-ca.linux.org.uk>
 <626A08DA.3060802@fujitsu.com>
 <YmoAp+yWBpH5T8rt@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmoAp+yWBpH5T8rt@zeniv-ca.linux.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 28, 2022 at 02:49:11AM +0000, Al Viro wrote:
> On Thu, Apr 28, 2022 at 02:23:25AM +0000, xuyang2018.jy@fujitsu.com wrote:
> 
> > > BTW, xfs has grpid option as well:
> > > 	if (dir&&  !(dir->i_mode&  S_ISGID)&&  xfs_has_grpid(mp)) {
> > > 		inode_fsuid_set(inode, mnt_userns);
> > > 		inode->i_gid = dir->i_gid;
> > > 		inode->i_mode = mode;
> > > 	} else {
> > > 		inode_init_owner(mnt_userns, inode, dir, mode);
> > > 	}
> > >
> > > We could lift that stuff into VFS, but it would require lifting that flag
> > > (BSD vs. SysV behaviour wrt GID - BSD *always* inherits GID from parent
> > > and ignores SGID on directories) into generic superblock.  Otherwise we'd
> > > be breaking existing behaviour for ext* and xfs...
> > 
> > I also mentioned it in my previous version(in the 3/4 patch)
> > "This patch also changed grpid behaviour for ext4/xfs because the mode 
> > passed to them may been changed by vfs_prepare_mode.
> > "
> > 
> > I guess we can add a  grpid option check in vfs_prepare_mode or in 
> > mode_strip_sgid, then it should not break the existing behaviour for 
> > ext* and xfs.
> 
> I don't like it, TBH.  That way we have
> 	1) caller mangles mode (after having looked at grpid, etc.)
> 	2) filesystem checks grpid and either calls inode_init_owner(),
> which might (or might not) modify the gid to be used or skips the
> call and assigns gid directly.
> 
> It's asking for trouble.  We have two places where the predicate is
> checked; the first mangles mode (and I'm still not convinced that we
> need to bother with that at all), the second affects gid (and for
> mkdir in sgid directory on non-grpid ones inherits sgid).
> 
> That kind of structure is asking for trouble.  *IF* we make inode_init_owner()
> aware of grpid (and make that predicate usable from generic helper), we might
> as well just make inode_init_owner() mandatory (for the first time ever) and
> get rid of grpid checks in filesystems themselves.  But then there's no point
> doing it in method callers.
> 
> Note, BTW, that while XFS has inode_fsuid_set() on the non-inode_init_owner()
> path, it doesn't have inode_fsgid_set() there.  Same goes for ext4, while
> ext2 doesn't bother with either in such case...
> 
> Let's try to separate the issues here.  Jann, could you explain what makes
> empty sgid files dangerous?

Found the original thread in old mailbox, and the method of avoiding the
SGID removal on modification is usable.  Which answers the question above...
