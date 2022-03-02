Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E22B64CB2D9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Mar 2022 00:51:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbiCBXuA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Mar 2022 18:50:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiCBXt7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Mar 2022 18:49:59 -0500
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3CDD217924D;
        Wed,  2 Mar 2022 15:49:13 -0800 (PST)
Received: from dread.disaster.area (pa49-186-17-0.pa.vic.optusnet.com.au [49.186.17.0])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 5C23C5355EA;
        Thu,  3 Mar 2022 10:12:08 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nPY8c-000nz7-NA; Thu, 03 Mar 2022 10:12:06 +1100
Date:   Thu, 3 Mar 2022 10:12:06 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Filipe Manana <fdmanana@kernel.org>,
        Michael Kerrisk <mtk@man7.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-xfs@vger.kernel.org,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        cluster-devel <cluster-devel@redhat.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Filipe Manana <fdmanana@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] iomap: fix incomplete async dio reads when using
 IOMAP_DIO_PARTIAL
Message-ID: <20220302231206.GV59715@dread.disaster.area>
References: <1f34c8435fed21e9583492661ceb20d642a75699.1646058596.git.fdmanana@suse.com>
 <20220228223830.GR59715@dread.disaster.area>
 <Yh9EHfl3sYJHeo3T@debian9.Home>
 <CAHc6FU7jBeUEAaB0BupypG1zdxf4shF5T56cHZCD_xXi-jeB+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHc6FU7jBeUEAaB0BupypG1zdxf4shF5T56cHZCD_xXi-jeB+Q@mail.gmail.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=e9dl9Yl/ c=1 sm=1 tr=0 ts=621ff9ca
        a=+dVDrTVfsjPpH/ci3UuFng==:117 a=+dVDrTVfsjPpH/ci3UuFng==:17
        a=kj9zAlcOel0A:10 a=o8Y5sQTvuykA:10 a=VwQbUJbxAAAA:8 a=iox4zFpeAAAA:8
        a=7-415B0cAAAA:8 a=kOgEMRnqgivgxslKRJ4A:9 a=CjuIK1q_8ugA:10
        a=AjGcO6oz07-iQ99wixmX:22 a=WzC6qhA0u3u7Ye7llzcV:22
        a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 02, 2022 at 02:03:28PM +0100, Andreas Gruenbacher wrote:
> On Wed, Mar 2, 2022 at 11:17 AM Filipe Manana <fdmanana@kernel.org> wrote:
> > On Tue, Mar 01, 2022 at 09:38:30AM +1100, Dave Chinner wrote:
> > > On Mon, Feb 28, 2022 at 02:32:03PM +0000, fdmanana@kernel.org wrote:
> > > > From: Filipe Manana <fdmanana@suse.com>
> > > .....
> > >
> > > > 11) At iomap_dio_complete() we adjust the iocb->ki_pos from X to X + 4K
> > > >     and return 4K (the amount of io done) to iomap_dio_complete_work();
> > > >
> > > > 12) iomap_dio_complete_work() calls the iocb completion callback,
> > > >     iocb->ki_complete() with a second argument value of 4K (total io
> > > >     done) and the iocb with the adjust ki_pos of X + 4K. This results
> > > >     in completing the read request for io_uring, leaving it with a
> > > >     result of 4K bytes read, and only the first page of the buffer
> > > >     filled in, while the remaining 3 pages, corresponding to the other
> > > >     3 extents, were not filled;
> > > >
> > > > 13) For the application, the result is unexpected because if we ask
> > > >     to read N bytes, it expects to get N bytes read as long as those
> > > >     N bytes don't cross the EOF (i_size).
> > >
> > > Yeah, that's exactly the sort of problem we were having with XFS
> > > with partial DIO completions due to needing multiple iomap iteration
> > > loops to complete a single IO. Hence IOMAP_NOWAIT now triggers the
> > > above range check and aborts before we start...
> >
> > Interesting.
> 
> Dave, this seems to affect all users of iomap_dio_rw in the same way,
> so would it make sense to move this check there?

Perhaps, but I'm not sure it makes sense because filesystems need to
abort ->iomap_begin with -EAGAIN in IOMAP_NOWAIT contexts before
they make any changes.

Hence detecting short extents in the generic code becomes ...
difficult because we might now need to undo changes that have been
made in ->iomap_begin. e.g. if the filesystem allocates space and
the iomap core says "not long enough" because IOMAP_NOWAIT is set,
then we may have to punch out that allocation in ->iomap_end beforei
returning -EAGAIN.

That means filesystems like XFS may now need to supply a ->iomap_end
function to undo stuff the core decides it shouldn't have done,
instead of the filesystem ensuring it never does the operation it in
the first place...

IOWs, the correct behaviour here is for the filesystem ->iomap_begin
method to see that it needs to allocate and return -EAGAIN if
IOMAP_NOWAIT is set, not do the allocation and hope it that it ends
up being long enough to cover the entire IO we have to do.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
