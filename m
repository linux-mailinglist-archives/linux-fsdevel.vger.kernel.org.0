Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DFF14C231C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Feb 2022 05:43:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbiBXEoD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Feb 2022 23:44:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiBXEoB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Feb 2022 23:44:01 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FAFA1693BE;
        Wed, 23 Feb 2022 20:43:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CFF5BB8235F;
        Thu, 24 Feb 2022 04:43:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70B43C340E9;
        Thu, 24 Feb 2022 04:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645677809;
        bh=8cBvGxy3VCDC4OF7i4i8LxGFxNOh0EKujiWm61cvBMc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cxjdsRzCYulrgUkeSKx3sL8S4jycxmZ4TVM645J/BpwMagmGDXb6YZj8JtSQstxUm
         rGJG+TvotHPMjvAyZ8QooXLSuro64qjgePDtD4Ucu8tg+d55YFZNClSyHqZ2JK6jUn
         uSM/awR0ZROE4s13kyPVUPCv6Kb+PkfKboHOy/P3Ms4EvvE9ER0c5EnPthn9MRjv18
         J875b+aFclm4DzoPRYpGykRxOAhLLAmS1AoVNVW+3tnmwNpjA4CkwcJivciY5WEDfv
         T/IYjTrkvJnzBtkqhozw1YcCspaV8VBxL4vg/ET4D1x3tnRFYqvmnh6nH+W+HXcRbZ
         yTE8ApBlTeqOQ==
Date:   Wed, 23 Feb 2022 20:43:28 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     NeilBrown <neilb@suse.de>, Al Viro <viro@zeniv.linux.org.uk>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Daire Byrne <daire@dneg.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Subject: Re: [PATCH/RFC] VFS: support parallel updates in the one directory.
Message-ID: <20220224044328.GB8269@magnolia>
References: <164549669043.5153.2021348013072574365@noble.neil.brown.name>
 <20220222224546.GE3061737@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220222224546.GE3061737@dread.disaster.area>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 23, 2022 at 09:45:46AM +1100, Dave Chinner wrote:
> On Tue, Feb 22, 2022 at 01:24:50PM +1100, NeilBrown wrote:
> > 
> > Hi Al,
> >  I wonder if you might find time to have a look at this patch.  It
> >  allows concurrent updates to a single directory.  This can result in
> >  substantial throughput improvements when the application uses multiple
> >  threads to create lots of files in the one directory, and there is
> >  noticeable per-create latency, as there can be with NFS to a remote
> >  server.
> > Thanks,
> > NeilBrown
> > 
> > Some filesystems can support parallel modifications to a directory,
> > either because the modification happen on a remote server which does its
> > own locking (e.g.  NFS) or because they can internally lock just a part
> > of a directory (e.g.  many local filesystems, with a bit of work - the
> > lustre project has patches for ext4 to support concurrent updates).
> > 
> > To allow this, we introduce VFS support for parallel modification:
> > unlink (including rmdir) and create.  Parallel rename is not (yet)
> > supported.
> 
> Yay!
> 
> > If a filesystem supports parallel modification in a given directory, it
> > sets S_PAR_UNLINK on the inode for that directory.  lookup_open() and
> > the new lookup_hash_modify() (similar to __lookup_hash()) notice the
> > flag and take a shared lock on the directory, and rely on a lock-bit in
> > d_flags, much like parallel lookup relies on DCACHE_PAR_LOOKUP.
> 
> I suspect that you could enable this for XFS right now. XFS has internal
> directory inode locking that should serialise all reads and writes
> correctly regardless of what the VFS does. So while the VFS might
> use concurrent updates (e.g. inode_lock_shared() instead of
> inode_lock() on the dir inode), XFS has an internal metadata lock
> that will then serialise the concurrent VFS directory modifications
> correctly....

I don't think that will work because xfs_readdir doesn't hold the
directory ILOCK while it runs, which means that readdir will see garbage
if other threads now only hold inode_lock_shared while they update the
directory.

--D

> Yeah, I know, this isn't true concurrent dir updates, but it should
> allow multiple implementations of the concurrent dir update VFS APIs
> across multiple filesystems and shake out any assumptions that might
> arise from a single implementation target (e.g. silly rename
> quirks).
> 
> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
