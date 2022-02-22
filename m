Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 531904C04D6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Feb 2022 23:45:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236113AbiBVWqQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Feb 2022 17:46:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231479AbiBVWqP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Feb 2022 17:46:15 -0500
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au [211.29.132.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 804D9128647;
        Tue, 22 Feb 2022 14:45:49 -0800 (PST)
Received: from dread.disaster.area (pa49-186-17-0.pa.vic.optusnet.com.au [49.186.17.0])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 57F1910E0F91;
        Wed, 23 Feb 2022 09:45:46 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nMduk-00FEq0-BE; Wed, 23 Feb 2022 09:45:46 +1100
Date:   Wed, 23 Feb 2022 09:45:46 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     NeilBrown <neilb@suse.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Daire Byrne <daire@dneg.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Subject: Re: [PATCH/RFC] VFS: support parallel updates in the one directory.
Message-ID: <20220222224546.GE3061737@dread.disaster.area>
References: <164549669043.5153.2021348013072574365@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <164549669043.5153.2021348013072574365@noble.neil.brown.name>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=VuxAv86n c=1 sm=1 tr=0 ts=6215679c
        a=+dVDrTVfsjPpH/ci3UuFng==:117 a=+dVDrTVfsjPpH/ci3UuFng==:17
        a=kj9zAlcOel0A:10 a=oGFeUVbbRNcA:10 a=7-415B0cAAAA:8
        a=yXyu7VD68H5JFmdjK-oA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 22, 2022 at 01:24:50PM +1100, NeilBrown wrote:
> 
> Hi Al,
>  I wonder if you might find time to have a look at this patch.  It
>  allows concurrent updates to a single directory.  This can result in
>  substantial throughput improvements when the application uses multiple
>  threads to create lots of files in the one directory, and there is
>  noticeable per-create latency, as there can be with NFS to a remote
>  server.
> Thanks,
> NeilBrown
> 
> Some filesystems can support parallel modifications to a directory,
> either because the modification happen on a remote server which does its
> own locking (e.g.  NFS) or because they can internally lock just a part
> of a directory (e.g.  many local filesystems, with a bit of work - the
> lustre project has patches for ext4 to support concurrent updates).
> 
> To allow this, we introduce VFS support for parallel modification:
> unlink (including rmdir) and create.  Parallel rename is not (yet)
> supported.

Yay!

> If a filesystem supports parallel modification in a given directory, it
> sets S_PAR_UNLINK on the inode for that directory.  lookup_open() and
> the new lookup_hash_modify() (similar to __lookup_hash()) notice the
> flag and take a shared lock on the directory, and rely on a lock-bit in
> d_flags, much like parallel lookup relies on DCACHE_PAR_LOOKUP.

I suspect that you could enable this for XFS right now. XFS has internal
directory inode locking that should serialise all reads and writes
correctly regardless of what the VFS does. So while the VFS might
use concurrent updates (e.g. inode_lock_shared() instead of
inode_lock() on the dir inode), XFS has an internal metadata lock
that will then serialise the concurrent VFS directory modifications
correctly....

Yeah, I know, this isn't true concurrent dir updates, but it should
allow multiple implementations of the concurrent dir update VFS APIs
across multiple filesystems and shake out any assumptions that might
arise from a single implementation target (e.g. silly rename
quirks).

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
