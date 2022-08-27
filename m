Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7478D5A3876
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Aug 2022 17:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233675AbiH0PrF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 27 Aug 2022 11:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbiH0Pq7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 27 Aug 2022 11:46:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2E9C696C7;
        Sat, 27 Aug 2022 08:46:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 479C760DEC;
        Sat, 27 Aug 2022 15:46:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C58DC433D6;
        Sat, 27 Aug 2022 15:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661615217;
        bh=/g+1KdMdMMNwBH5rRGp0ItfxfLzwtuxoX3XdO7k3htM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EMze+ZL51PBzh0ugehl3d1rCw6hmKjllsOO6lis5BNnf+mr2usiNTGG9H7Bs00ArA
         aIXjeRLikNioydqEJB5dk1PIlqT5QEopXmPQrFCjQ5dHOMaIQq+UTjYrUweW81OfiV
         BMImzDKfXQ+v1+JS+KAm6mfzFXto1YChg2ia1G10e92N9pHNDSj/Hznk3RSgnK/+zK
         fxdiRpGnwv/uTTPcupth0OZYWCBVq8/bhDUFGSnRlM54Hxba8xaJILjrY6+QTmJm3l
         xPPxOgJtqajNPqYTQFUDqlrSHkzDkDTLhV+VJVS+W92EhAmapwqIp6vfDhCcJF69nx
         uMnU1n9GdP1pQ==
Date:   Sat, 27 Aug 2022 08:46:57 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Amir Goldstein <amir73il@gmail.com>, Theodore Tso <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Dave Chinner <david@fromorbit.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Neil Brown <neilb@suse.de>, Al Viro <viro@zeniv.linux.org.uk>,
        Mimi Zohar <zohar@linux.ibm.com>, xiubli@redhat.com,
        Chuck Lever <chuck.lever@oracle.com>,
        Lukas Czerner <lczerner@redhat.com>, Jan Kara <jack@suse.cz>,
        Christian Brauner <brauner@kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux Btrfs <linux-btrfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ext4 <linux-ext4@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        David Wysochanski <dwysocha@redhat.com>,
        ceph-devel <ceph-devel@vger.kernel.org>
Subject: Re: [PATCH v3 4/7] xfs: don't bump the i_version on an atime update
 in xfs_vn_update_time
Message-ID: <Ywo8cWRcJUpLFMxJ@magnolia>
References: <20220826214703.134870-1-jlayton@kernel.org>
 <20220826214703.134870-5-jlayton@kernel.org>
 <CAOQ4uxjzE_B_EQktLr8z8gXOhFDNm-_YpUTycfZCdaZNp-i0hQ@mail.gmail.com>
 <CAOQ4uxge86g=+HPnds-wRXkFHg67G=m9rGK7V_T8yS+2=w9tmg@mail.gmail.com>
 <35d31d0a5c6c9a20c58f55ef62355ff39a3f18c6.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35d31d0a5c6c9a20c58f55ef62355ff39a3f18c6.camel@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Aug 27, 2022 at 09:14:30AM -0400, Jeff Layton wrote:
> On Sat, 2022-08-27 at 11:01 +0300, Amir Goldstein wrote:
> > On Sat, Aug 27, 2022 at 10:26 AM Amir Goldstein <amir73il@gmail.com> wrote:
> > > 
> > > On Sat, Aug 27, 2022 at 12:49 AM Jeff Layton <jlayton@kernel.org> wrote:
> > > > 
> > > > xfs will update the i_version when updating only the atime value, which
> > > > is not desirable for any of the current consumers of i_version. Doing so
> > > > leads to unnecessary cache invalidations on NFS and extra measurement
> > > > activity in IMA.
> > > > 
> > > > Add a new XFS_ILOG_NOIVER flag, and use that to indicate that the
> > > > transaction should not update the i_version. Set that value in
> > > > xfs_vn_update_time if we're only updating the atime.
> > > > 
> > > > Cc: Dave Chinner <david@fromorbit.com>
> > > > Cc: NeilBrown <neilb@suse.de>
> > > > Cc: Trond Myklebust <trondmy@hammerspace.com>
> > > > Cc: David Wysochanski <dwysocha@redhat.com>
> > > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > > ---
> > > >  fs/xfs/libxfs/xfs_log_format.h  |  2 +-
> > > >  fs/xfs/libxfs/xfs_trans_inode.c |  2 +-
> > > >  fs/xfs/xfs_iops.c               | 11 +++++++++--
> > > >  3 files changed, 11 insertions(+), 4 deletions(-)
> > > > 
> > > > Dave has NACK'ed this patch, but I'm sending it as a way to illustrate
> > > > the problem. I still think this approach should at least fix the worst
> > > > problems with atime updates being counted. We can look to carve out
> > > > other "spurious" i_version updates as we identify them.
> > > > 
> > > 
> > > AFAIK, "spurious" is only inode blocks map changes due to writeback
> > > of dirty pages. Anybody know about other cases?
> > > 
> > > Regarding inode blocks map changes, first of all, I don't think that there is
> > > any practical loss from invalidating NFS client cache on dirty data writeback,
> > > because NFS server should be serving cold data most of the time.
> > > If there are a few unneeded cache invalidations they would only be temporary.
> > > 
> > 
> > Unless there is an issue with a writer NFS client that invalidates its
> > own attribute
> > caches on server data writeback?
> > 
> 
> The client just looks at the file attributes (of which i_version is but
> one), and if certain attributes have changed (mtime, ctime, i_version,
> etc...) then it invalidates its cache.
> 
> In the case of blocks map changes, could that mean a difference in the
> observable sparse regions of the file? If so, then a READ_PLUS before
> the change and a READ_PLUS after could give different results. Since
> that difference is observable by the client, I'd think we'd want to bump
> i_version for that anyway.

How /is/ READ_PLUS supposed to detect sparse regions, anyway?  I know
that's been the subject of recent debate.  At least as far as XFS is
concerned, a file range can go from hole -> delayed allocation
reservation -> unwritten extent -> (actual writeback) -> written extent.
The dance became rather more complex when we added COW.  If any of that
will make a difference for READ_PLUS, then yes, I think you'd want file
writeback activities to bump iversion to cause client invalidations,
like (I think) Dave said.

The fs/iomap/ implementation of SEEK_DATA/SEEK_HOLE reports data for
written and delalloc extents; and an unwritten extent will report data
for any pagecache it finds.

> > > One may even consider if NFSv4 server should not flush dirty data of an inode
> > > before granting a read lease to client.
> > > After all, if read lease was granted, client cached data and then server crashed
> > > before persisting the dirty data, then client will have cached a
> > > "future" version
> > > of the data and if i_version on the server did not roll back in that situation,
> > > we are looking at possible data corruptions.
> > > 
> 
> We don't hand out read leases if there are file descriptions open for
> write. NFS clients usually issue a COMMIT before closing a stateid in
> order to satisfy close-to-open cache coherency.
> 
> So in most cases, this is probably not an issue. It might still be
> worthwhile to make sure of it by doing a filemap_write_and_wait before
> we hand out a delegation, but that's likely to be a no-op in most cases
> anyway.
> 
> Note too that the client will still revalidate its caches when it
> receives attributes even when it holds a read delegation. In fact, this
> behavior mostly papered over a rather nasty knfsd bug we found recently
> where it was allowing conflicting activity to proceed even when there
> was a read delegation outstanding.
>  
> > > Same goes for IMA. IIUC, IMA data checksum would be stored in xattr?
> > > Storing in xattr a data checksum for data that is not persistent on disk
> > > would be an odd choice.
> > > 
> > > So in my view, I only see benefits to current i_version users in the xfs
> > > i_version implementations and I don't think that it contradicts the
> > > i_version definition in the man page patch.
> > > 
> > > > If however there are offline analysis tools that require atime updates
> > > > to be counted, then we won't be able to do this. If that's the case, how
> > > > can we fix this such that serving xfs via NFSv4 doesn't suck?
> > > > 
> > > 
> > > If I read the arguments correctly, implicit atime updates could be relaxed
> > > as long as this behavior is clearly documented and coherent on all
> > > implementations.
> > > 
> > > Forensics and other applications that care about atime updates can and
> > > should check atime and don't need i_version to know that it was changed.
> > > The reliability of atime as an audit tool has dropped considerably since
> > > the default in relatime.

I've been waiting for Amir to appear in this discussion -- ISTR that a
few years ago you were wanting the ability to scan a filesystem to look
for files that have changed since a given point.  If XFS exported its
di_changecount file attribute (as it currently behaves) via BULKSTAT,
you'd have the ability to do that, so long as your application could
persist bulkstat data and compare.

--D

> > > If we want to be paranoid, maybe we can leave i_version increment on
> > > atime updates in case the user opted-in to strict '-o atime' updates, but
> > > IMO, there is no need for that.
> > > 
> 
> Thanks,
> -- 
> Jeff Layton <jlayton@kernel.org>
