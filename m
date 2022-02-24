Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC4774C214A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Feb 2022 02:49:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbiBXBtS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Feb 2022 20:49:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbiBXBtQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Feb 2022 20:49:16 -0500
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6C5B1D1985;
        Wed, 23 Feb 2022 17:48:47 -0800 (PST)
Received: from dread.disaster.area (pa49-186-17-0.pa.vic.optusnet.com.au [49.186.17.0])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 1FBA553306C;
        Thu, 24 Feb 2022 12:48:43 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nN3FK-00FgMA-GD; Thu, 24 Feb 2022 12:48:42 +1100
Date:   Thu, 24 Feb 2022 12:48:42 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Lee Jones <lee.jones@linaro.org>, linux-ext4@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Dave Chinner <dchinner@redhat.com>,
        Goldwyn Rodrigues <rgoldwyn@suse.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Bob Peterson <rpeterso@redhat.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        Johannes Thumshirn <jth@kernel.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, cluster-devel@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [REPORT] kernel BUG at fs/ext4/inode.c:2620 - page_buffers()
Message-ID: <20220224014842.GM59715@dread.disaster.area>
References: <Yg0m6IjcNmfaSokM@google.com>
 <82d0f4e4-c911-a245-4701-4712453592d9@nvidia.com>
 <Yg8bxiz02WBGf6qO@mit.edu>
 <Yg9QGm2Rygrv+lMj@kroah.com>
 <YhbE2nocBMtLc27C@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YhbE2nocBMtLc27C@mit.edu>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=VuxAv86n c=1 sm=1 tr=0 ts=6216e3fe
        a=+dVDrTVfsjPpH/ci3UuFng==:117 a=+dVDrTVfsjPpH/ci3UuFng==:17
        a=kj9zAlcOel0A:10 a=oGFeUVbbRNcA:10 a=7-415B0cAAAA:8
        a=-kggqxpRYmVVPZmSJLkA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 23, 2022 at 06:35:54PM -0500, Theodore Ts'o wrote:
> On Fri, Feb 18, 2022 at 08:51:54AM +0100, Greg Kroah-Hartman wrote:
> > > The challenge is that fixing this "the right away" is probably not
> > > something we can backport into an LTS kernel, whether it's 5.15 or
> > > 5.10... or 4.19.
> > 
> > Don't worry about stable backports to start with.  Do it the "right way"
> > first and then we can consider if it needs to be backported or not.
> 
> Fair enough; on the other hand, we could also view this as making ext4
> more robust against buggy code in other subsystems, and while other
> file systems may be losing user data if they are actually trying to do
> remote memory access to file-backed memory, apparently other file
> systems aren't noticing and so they're not crashing.

Oh, we've noticed them, no question about that.  We've got bug
reports going back years for systems being crashed, triggering BUGs
and/or corrupting data on both XFS and ext4 filesystems due to users
trying to run RDMA applications with file backed pages.

Most of the people doing this now know that we won't support such
applications until the RDMA stack/hardware can trigger on-demand
write page faults the same way CPUs do when they first write to a
clean page. They don't have this, so mostly these people don't
bother reporting these class of problems to us anymore.  The
gup/RDMA infrastructure to make this all work is slowly moving
forwards, but it's not here yet.

> Issuing a
> warning and then not crashing is arguably a better way for ext4 to
> react, especially if there are other parts of the kernel that are
> randomly calling set_page_dirty() on file-backed memory without
> properly first informing the file system in a context where it can
> block and potentially do I/O to do things like allocate blocks.

I'm not sure that replacing the BUG() with a warning is good enough
- it's still indicative of an application doing something dangerous
that could result in silent data corruption and/or other problems.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
