Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 892F364C380
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Dec 2022 06:25:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236681AbiLNFZo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Dec 2022 00:25:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiLNFZm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Dec 2022 00:25:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E39C23E87;
        Tue, 13 Dec 2022 21:25:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2A06F617CB;
        Wed, 14 Dec 2022 05:25:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54F53C433D2;
        Wed, 14 Dec 2022 05:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670995540;
        bh=6SZxn5T0dWfYyIClX/JnaceH+9CDr2rxvDXyECFfu7I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZOt6nsjHTf+jzGnhGDmX/FM/yVeVkVAgrnljNXiEzfQlgFKMQ3Qgp0ILTZIloEBc+
         Y9Rw412fQCBleHcLqwIAoBE5Ot0MW9VXN3k4jhtJxWa900ooyrkbPPUBODpM4F0BOb
         yhz6dd3EX6wyy3c01Wg5dQ5hgDINRcQjT7cVxsMOrUeRGbb0UYhlUP8v4xkEUakaVN
         of3N9tA3YD5WzBwY4/xYL41xWb56NTs5RtQKpmnkuPRMIAIY//aaLyweGffNrPAxBP
         bCgEZMOpchae8dyLIA+ifyx6oXqWidAA9SNEez1W9IZt0iSRQcbK9KHpoQDi8tCYMg
         op7wLKPhXcNEw==
Date:   Tue, 13 Dec 2022 21:25:38 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Andrey Albershteyn <aalbersh@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH 06/11] xfs: initialize fs-verity on file open and
 cleanup on inode destruction
Message-ID: <Y5leUu9cnFbN0OM1@sol.localdomain>
References: <20221213172935.680971-1-aalbersh@redhat.com>
 <20221213172935.680971-7-aalbersh@redhat.com>
 <20221214013524.GF3600936@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221214013524.GF3600936@dread.disaster.area>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 14, 2022 at 12:35:24PM +1100, Dave Chinner wrote:
> On Tue, Dec 13, 2022 at 06:29:30PM +0100, Andrey Albershteyn wrote:
> > fs-verity will read and attach metadata (not the tree itself) from
> > a disk for those inodes which already have fs-verity enabled.
> > 
> > Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
> > ---
> >  fs/xfs/xfs_file.c  | 8 ++++++++
> >  fs/xfs/xfs_super.c | 2 ++
> >  2 files changed, 10 insertions(+)
> > 
> > diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> > index 242165580e682..5eadd9a37c50e 100644
> > --- a/fs/xfs/xfs_file.c
> > +++ b/fs/xfs/xfs_file.c
> > @@ -32,6 +32,7 @@
> >  #include <linux/mman.h>
> >  #include <linux/fadvise.h>
> >  #include <linux/mount.h>
> > +#include <linux/fsverity.h>
> >  
> >  static const struct vm_operations_struct xfs_file_vm_ops;
> >  
> > @@ -1170,9 +1171,16 @@ xfs_file_open(
> >  	struct inode	*inode,
> >  	struct file	*file)
> >  {
> > +	int		error = 0;
> > +
> >  	if (xfs_is_shutdown(XFS_M(inode->i_sb)))
> >  		return -EIO;
> >  	file->f_mode |= FMODE_NOWAIT | FMODE_BUF_RASYNC | FMODE_BUF_WASYNC;
> > +
> > +	error = fsverity_file_open(inode, file);
> > +	if (error)
> > +		return error;
> 
> This is a hot path, so shouldn't we elide the function call
> altogether if verity is not enabled on the inode? i.e:
> 
> 	if (IS_VERITY(inode)) {
> 		error = fsverity_file_open(inode, file);
> 		if (error)
> 			return error;
> 	}
> 
> It doesn't really matter for a single file open, but when you're
> opening a few million inodes every second the function call overhead
> only to immediately return because IS_VERITY() is false adds up...
> 
> >  	return generic_file_open(inode, file);
> >  }
> >  
> > diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
> > index 8f1e9b9ed35d9..50c2c819ba940 100644
> > --- a/fs/xfs/xfs_super.c
> > +++ b/fs/xfs/xfs_super.c
> > @@ -45,6 +45,7 @@
> >  #include <linux/magic.h>
> >  #include <linux/fs_context.h>
> >  #include <linux/fs_parser.h>
> > +#include <linux/fsverity.h>
> >  
> >  static const struct super_operations xfs_super_operations;
> >  
> > @@ -647,6 +648,7 @@ xfs_fs_destroy_inode(
> >  	ASSERT(!rwsem_is_locked(&inode->i_rwsem));
> >  	XFS_STATS_INC(ip->i_mount, vn_rele);
> >  	XFS_STATS_INC(ip->i_mount, vn_remove);
> > +	fsverity_cleanup_inode(inode);
> 
> Similarly, shouldn't this be:
> 
> 	if (fsverity_active(inode))
> 		fsverity_cleanup_inode(inode);
> 

If you actually want to do that, then we should instead make these functions
inline functions that do the "is anything needed?" check, then call a
double-underscored version that does the actual work.  Some of the fscrypt
functions are like that.  Then all filesystems would get the benefit.

Funnily enough, I had actually wanted to do that for fsverity_file_open()
originally, but Ted had preferred the simpler version.

Anyway, if this is something you want, I can change it to be that way.

- Eric
