Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14C2A153B9D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2020 00:06:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbgBEXGb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Feb 2020 18:06:31 -0500
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:48826 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727237AbgBEXGb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Feb 2020 18:06:31 -0500
Received: from dread.disaster.area (pa49-181-161-120.pa.nsw.optusnet.com.au [49.181.161.120])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 14B6F8204F1;
        Thu,  6 Feb 2020 10:06:27 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1izTkY-0006PA-46; Thu, 06 Feb 2020 10:06:26 +1100
Date:   Thu, 6 Feb 2020 10:06:26 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Jeff Moyer <jmoyer@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        fstests@vger.kernel.org
Subject: Re: [PATCH 0/3] fstests: fixes for 64k pages and dax
Message-ID: <20200205230626.GO20628@dread.disaster.area>
References: <20200205224818.18707-1-jmoyer@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200205224818.18707-1-jmoyer@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=LYdCFQXi c=1 sm=1 tr=0
        a=SkgQWeG3jiSQFIjTo4+liA==:117 a=SkgQWeG3jiSQFIjTo4+liA==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=l697ptgUJYAA:10
        a=VwQbUJbxAAAA:8 a=7-415B0cAAAA:8 a=Hdpg4Cy1Pty9vVzyJowA:9
        a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[cc fstests@vger.kernel.org]

On Wed, Feb 05, 2020 at 05:48:15PM -0500, Jeff Moyer wrote:
> This set of patches fixes a few false positives I encountered when
> testing DAX on ppc64le (which has a 64k page size).
> 
> Patch 1 is actually not specific to non-4k page sizes.  Right now we
> only test for dax incompatibility in the dm flakey target.  This means
> that tests that use dm-thin or the snapshot target will still try to
> run.  Moving the check to _require_dm_target fixes that problem.
> 
> Patches 2 and 3 get rid of hard coded block/page sizes in the tests.
> They run just fine on 64k pages and 64k block sizes.
> 
> Even after these patches, there are many more tests that fail in the
> following configuration:
> 
> MKFS_OPTIONS="-b size=65536 -m reflink=0" MOUNT_OPTIONS="-o dax"
> 
> One class of failures is tests that create a really small file system
> size.  Some of those tests seem to require the very small size, but
> others seem like they could live with a slightly bigger size that
> would then fit the log (the typical failure is a mkfs failure due to
> not enough blocks for the log).  For the former case, I'm tempted to
> send patches to _notrun those tests, and for the latter, I'd like to
> bump the file system sizes up.  300MB seems to be large enough to
> accommodate the log.  Would folks be opposed to those approaches?
> 
> Another class of failure is tests that either hard-code a block size
> to trigger a specific error case, or that test a multitude of block
> sizes.  I'd like to send a patch to _notrun those tests if there is
> a user-specified block size.  That will require parsing the MKFS_OPTIONS
> based on the fs type, of course.  Is that something that seems
> reasonable?
> 
> I will follow up with a series of patches to implement those changes
> if there is consensus on the approach.  These first three seemed
> straight-forward to me, so that's where I'm starting.
> 
> Thanks!
> Jeff
> 
> [PATCH 1/3] dax/dm: disable testing on devices that don't support dax
> [PATCH 2/3] t_mmap_collision: fix hard-coded page size
> [PATCH 3/3] xfs/300: modify test to work on any fs block size

Hi Jeff,

You probably should be sending fstests patches to
fstests@vger.kernel.org, otherwise they probably won't get noticed
by the fstests maintainer...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
