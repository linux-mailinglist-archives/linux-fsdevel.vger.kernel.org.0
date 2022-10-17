Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB8D601C27
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Oct 2022 00:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbiJQWOu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Oct 2022 18:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbiJQWOp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Oct 2022 18:14:45 -0400
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au [211.29.132.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6F5D11A223;
        Mon, 17 Oct 2022 15:14:42 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-106-210.pa.nsw.optusnet.com.au [49.181.106.210])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id E29F0110211B;
        Tue, 18 Oct 2022 09:14:35 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1okYNV-003Do8-W5; Tue, 18 Oct 2022 09:14:34 +1100
Date:   Tue, 18 Oct 2022 09:14:33 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, djwong@kernel.org,
        trondmy@hammerspace.com, neilb@suse.de, viro@zeniv.linux.org.uk,
        zohar@linux.ibm.com, xiubli@redhat.com, chuck.lever@oracle.com,
        lczerner@redhat.com, jack@suse.cz, bfields@fieldses.org,
        brauner@kernel.org, fweimer@redhat.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-xfs@vger.kernel.org, Jeff Layton <jlayton@redhat.com>
Subject: Re: [RFC PATCH v7 9/9] vfs: expose STATX_VERSION to userland
Message-ID: <20221017221433.GT3600936@dread.disaster.area>
References: <20221017105709.10830-1-jlayton@kernel.org>
 <20221017105709.10830-10-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221017105709.10830-10-jlayton@kernel.org>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=VuxAv86n c=1 sm=1 tr=0 ts=634dd3d0
        a=j6JUzzrSC7wlfFge/rmVbg==:117 a=j6JUzzrSC7wlfFge/rmVbg==:17
        a=kj9zAlcOel0A:10 a=Qawa6l4ZSaYA:10 a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8
        a=7-415B0cAAAA:8 a=-cKyABg0kL-CqEoa6E0A:9 a=CjuIK1q_8ugA:10
        a=AjGcO6oz07-iQ99wixmX:22 a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 17, 2022 at 06:57:09AM -0400, Jeff Layton wrote:
> From: Jeff Layton <jlayton@redhat.com>
> 
> Claim one of the spare fields in struct statx to hold a 64-bit inode
> version attribute. When userland requests STATX_VERSION, copy the
> value from the kstat struct there, and stop masking off
> STATX_ATTR_VERSION_MONOTONIC.

Can we please make the name more sepcific than "version"? It's way
too generic and - we already have userspace facing "version" fields
for inodes that refer to the on-disk format version exposed in
various UAPIs. It's common for UAPI structures used for file
operations to have a "version" field that refers to the *UAPI
structure version* rather than file metadata or data being retrieved
from the file in question.

The need for an explanatory comment like this:

> +	__u64	stx_version; /* Inode change attribute */

demonstrates it is badly named. If you want it known as an inode
change attribute, then don't name the variable "version". In
reality, it really needs to be an opaque cookie, not something
applications need to decode directly to make sense of.

> Update the test-statx sample program to output the change attr and
> MountId.
> 
> Reviewed-by: NeilBrown <neilb@suse.de>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/stat.c                 | 12 +++---------
>  include/linux/stat.h      |  9 ---------
>  include/uapi/linux/stat.h |  6 ++++--
>  samples/vfs/test-statx.c  |  8 ++++++--
>  4 files changed, 13 insertions(+), 22 deletions(-)
> 
> Posting this as an RFC as we're still trying to sort out what semantics
> we want to present to userland. In particular, this patch leaves the
> problem of crash resilience in to userland applications on filesystems
> that don't report as MONOTONIC.

Firstly, if userspace wants to use the change attribute, they are
going to have to detect crashes themselves anyway because no fs in
the kernel can set the MONOTONIC flag right now and it may be years
before kernels/filesystems actually support it in production
systems.

But more fundamentally, I think this monotonic increase guarantee is
completely broken by the presence of snapshots and snapshot
rollbacks. If you change something, then a while later decide it
broke (e.g. a production system upgrade went awry) and you roll back
the filesystem to the pre-upgrade snapshot, then all the change
counters and m/ctimes are guaranteed to go backwards because they
will revert to the snapshot values. Maybe the filesystem can bump
some internal counter for the snapshot when the revert happens, but
until that is implemented, filesystems that support snapshots and
rollback can't assert MONOTONIC.

And that's worse for other filesystems, because if you put them on
dm-thinp and roll them back, they are completely unaware of the fact
that a rollback happened and there's *nothing* the filesystem can do
about this. Indeed, snapshots are suppose to be done on clean
filesystems so snapshot images don't require journal recovery, so
any crash detection put in the filesystem recovery code to guarantee
MONOTONIC behaviour will be soundly defeated by such block device
snapshot rollbacks.

Hence I think MONOTONIC is completely unworkable for most existing
filesystems because snapshots and rollbacks completely break the
underlying assumption MONOTONIC relies on: that filesystem
modifications always move forwards in both the time and modification
order dimensions....

This means that monotonicity is probably not acheivable by any
existing filesystem and so should not ever be mentioned in the UAPI.
I think userspace semantics can be simplified down to "if the change
cookie does not match exactly, caches are invalid" combined with
"applications are responsible for detecting temporal discontiguities
in filesystem presentation at start up (e.g. after a crash, unclean
shutdown, restoration from backup, snapshot rollback, etc) for
persistent cache invalidation purposes"....

> Trond is of the opinion that monotonicity is a hard requirement, and
> that we should not allow filesystems that can't provide that quality to
> report STATX_VERSION at all.  His rationale is that one of the main uses
> for this is for backup applications, and for those a counter that could
> go backward is worse than useless.

From the perspective of a backup program doing incremental backups,
an inode with a change counter that has a different value to the
current backup inventory means the file contains different
information than what the current backup inventory holds. Again,
snapshots, rollbacks, etc.

Therefore, regardless of whether the change counter has gone
forwards or backwards, the backup program needs to back up this
current version of the file in this backup because it is different
to the inventory copy.  Hence if the backup program fails to back it
up, it will not be creating an exact backup of the user's data at
the point in time the backup is run...

Hence I don't see that MONOTONIC is a requirement for backup
programs - they really do have to be able to handle filesystems that
have modifications that move backwards in time as well as forwards...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
