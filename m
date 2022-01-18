Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DDDD491F2F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jan 2022 06:58:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239857AbiARF6X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Jan 2022 00:58:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235645AbiARF6W (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Jan 2022 00:58:22 -0500
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA0FEC061574;
        Mon, 17 Jan 2022 21:58:22 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n9hVW-002k2l-CE; Tue, 18 Jan 2022 05:58:14 +0000
Date:   Tue, 18 Jan 2022 05:58:14 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Brian Foster <bfoster@redhat.com>, Ian Kent <raven@themaw.net>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Miklos Szeredi <miklos@szeredi.hu>,
        David Howells <dhowells@redhat.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        xfs <linux-xfs@vger.kernel.org>
Subject: Re: [PATCH] vfs: check dentry is still valid in get_link()
Message-ID: <YeZW9s7x2uCBfNJD@zeniv-ca.linux.org.uk>
References: <164180589176.86426.501271559065590169.stgit@mickey.themaw.net>
 <YeJr7/E+9stwEb3t@zeniv-ca.linux.org.uk>
 <275358741c4ee64b5e4e008d514876ed4ec1071c.camel@themaw.net>
 <YeV+zseKGNqnSuKR@bfoster>
 <YeWZRL88KPtLWlkI@zeniv-ca.linux.org.uk>
 <20220118030041.GB59729@dread.disaster.area>
 <YeYxOadA0HgYfBjt@zeniv-ca.linux.org.uk>
 <20220118041253.GC59729@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220118041253.GC59729@dread.disaster.area>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 18, 2022 at 03:12:53PM +1100, Dave Chinner wrote:

> No, that just creates a black hole where the VFS inode has been
> destroyed but the XFS inode cache doesn't know it's been trashed.
> Hence setting XFS_IRECLAIMABLE needs to remain in the during
> ->destroy_inode, otherwise the ->lookup side of the cache will think
> that are currently still in use by the VFS and hand them straight
> back out without going through the inode recycling code.
> 
> i.e. XFS_IRECLAIMABLE is the flag that tells xfs_iget() that the VFS
> part of the inode has been torn down, and that it must go back
> through VFS re-initialisation before it can be re-instantiated as a
> VFS inode.

OK...

> It would also mean that the inode will need to go through two RCU
> grace periods before it gets reclaimed, because XFS uses RCU
> protected inode cache lookups internally (e.g. for clustering dirty
> inode writeback) and so freeing the inode from the internal
> XFS inode cache requires RCU freeing...

Wait a minute.  Where is that RCU delay of yours, relative to
xfs_vn_unlink() and xfs_vn_rename() (for target)?  And where does
it happen in case of e.g. open() + unlink() + close()?
