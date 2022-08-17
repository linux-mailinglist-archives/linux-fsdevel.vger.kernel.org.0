Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6DF597959
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Aug 2022 23:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242427AbiHQV5r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Aug 2022 17:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241904AbiHQV5q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Aug 2022 17:57:46 -0400
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 30473A9241;
        Wed, 17 Aug 2022 14:57:45 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-52-176.pa.nsw.optusnet.com.au [49.181.52.176])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id AFEC662E875;
        Thu, 18 Aug 2022 07:57:43 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1oOR2j-00ELqT-7J; Thu, 18 Aug 2022 07:57:41 +1000
Date:   Thu, 18 Aug 2022 07:57:41 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     David Wysochanski <dwysocha@redhat.com>, djwong@kernel.org,
        linux-xfs@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "Darrick J . Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH] xfs: fix i_version handling in xfs
Message-ID: <20220817215741.GA3600936@dread.disaster.area>
References: <20220816131736.42615-1-jlayton@kernel.org>
 <CALF+zO=OrT5tBvyL1ERD+YDSXkSAFvqQu-cQkSgWvQN8z+E_rA@mail.gmail.com>
 <20220816233729.GX3600936@dread.disaster.area>
 <939469eb788014a76d5e85b4534ceb8045332622.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <939469eb788014a76d5e85b4534ceb8045332622.camel@kernel.org>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=VuxAv86n c=1 sm=1 tr=0 ts=62fd6458
        a=O3n/kZ8kT9QBBO3sWHYIyw==:117 a=O3n/kZ8kT9QBBO3sWHYIyw==:17
        a=kj9zAlcOel0A:10 a=biHskzXt2R4A:10 a=VwQbUJbxAAAA:8 a=7-415B0cAAAA:8
        a=uB0Jnoe4snWBMMnf3kEA:9 a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22
        a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 17, 2022 at 08:10:22AM -0400, Jeff Layton wrote:
> On Wed, 2022-08-17 at 09:37 +1000, Dave Chinner wrote:
> > On Tue, Aug 16, 2022 at 01:14:55PM -0400, David Wysochanski wrote:
> > > On Tue, Aug 16, 2022 at 9:19 AM Jeff Layton <jlayton@kernel.org> wrote:
> > > I have a test (details below) that shows an open issue with NFSv4.x +
> > > fscache where an xfs exported filesystem would trigger unnecessary
> > > over the wire READs after a umount/mount cycle of the NFS mount.  I
> > > previously tracked this down to atime updates, but never followed
> > > through on any patch.  Now that Jeff worked it out and this patch is
> > > under review, I built 5.19 vanilla, retested, then built 5.19 + this
> > > patch and verified the problem is fixed.
> > 
> > And so the question that needs to be answered is "why isn't relatime
> > working for this workload to avoid unnecessary atime updates"?
> > 
> > Which then makes me ask "what's changing atime on the server between
> > client side reads"?
> > 
> > Which then makes me wonder "what's actually changing iversion on the
> > server?" because I don't think atime is the issue here.
> > 
> > I suspect that Jeff's patch is affecting this test case by removing
> > iversion updates when the data is written back on the server. i.e.
> > delayed allocation and unwritten extent conversion will no longer
> > bump iversion when they log the inode metadata changes associated
> > with extent allocation to store the data being written.  There may
> > be other places where Jeff's patch removes implicit iversion
> > updates, too, so it may not be writeback that is the issue here.
> > 
> > How that impacts on the observed behaviour is dependent on things I
> > don't know, like what cachefiles is doing in the background,
> > especially across NFS client unmount/mount cycles. However, this all
> > makes me think the "atime is updated" behaviour is an observed
> > symptom of something else changing iversion and/or cmtime between
> > reads from the server...
> > 
> 
> You may be right here.
> 
> What I see with both noatime and relatime is that the first read after a
> write to a file results in the i_version being incremented, but then it
> doesn't change on subsequent reads. Write to the file again, and the
> i_version will get incremented again on the next read and then not again
> until there is a write.

Yup, that is exactly the behaviour relatime encodes at the VFS. THe
data write updates mtime (or is it ctime? doesn't matter, though)
and the very next atime access check done by the VFS sees that the
mtime is more recent than the atime, so it asks the filesystem to do
an atime update.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
