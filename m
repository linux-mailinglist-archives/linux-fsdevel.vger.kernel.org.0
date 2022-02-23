Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC3B4C0747
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Feb 2022 02:44:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236767AbiBWBox (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Feb 2022 20:44:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236794AbiBWBol (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Feb 2022 20:44:41 -0500
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0E71753E29;
        Tue, 22 Feb 2022 17:43:41 -0800 (PST)
Received: from dread.disaster.area (pa49-186-17-0.pa.vic.optusnet.com.au [49.186.17.0])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id C1E5D52F66C;
        Wed, 23 Feb 2022 12:43:36 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nMggp-00FHrN-4M; Wed, 23 Feb 2022 12:43:35 +1100
Date:   Wed, 23 Feb 2022 12:43:35 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Nitesh Shetty <nj.shetty@samsung.com>
Cc:     javier@javigon.com, chaitanyak@nvidia.com,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        dm-devel@redhat.com, linux-nvme@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, axboe@kernel.dk,
        msnitzer@redhat.com, bvanassche@acm.org,
        martin.petersen@oracle.com, hare@suse.de, kbusch@kernel.org,
        hch@lst.de, Frederick.Knight@netapp.com, osandov@fb.com,
        lsf-pc@lists.linux-foundation.org, djwong@kernel.org,
        josef@toxicpanda.com, clm@fb.com, dsterba@suse.com, tytso@mit.edu,
        jack@suse.com, joshi.k@samsung.com, arnav.dawn@samsung.com,
        nitheshshetty@gmail.com, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        James Smart <james.smart@broadcom.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/10] Add Copy offload support
Message-ID: <20220223014335.GH3061737@dread.disaster.area>
References: <CGME20220214080551epcas5p201d4d85e9d66077f97585bb3c64517c0@epcas5p2.samsung.com>
 <20220214080002.18381-1-nj.shetty@samsung.com>
 <20220214220741.GB2872883@dread.disaster.area>
 <20220217130215.GB3781@test-zns>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220217130215.GB3781@test-zns>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=e9dl9Yl/ c=1 sm=1 tr=0 ts=6215914d
        a=+dVDrTVfsjPpH/ci3UuFng==:117 a=+dVDrTVfsjPpH/ci3UuFng==:17
        a=kj9zAlcOel0A:10 a=oGFeUVbbRNcA:10 a=7-415B0cAAAA:8
        a=ejYDZuiVgDdOHNFj5oEA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 17, 2022 at 06:32:15PM +0530, Nitesh Shetty wrote:
>  Tue, Feb 15, 2022 at 09:08:12AM +1100, Dave Chinner wrote:
> > On Mon, Feb 14, 2022 at 01:29:50PM +0530, Nitesh Shetty wrote:
> > > [LSF/MM/BFP TOPIC] Storage: Copy Offload[0].
> > The biggest missing piece - and arguably the single most useful
> > piece of this functionality for users - is hooking this up to the
> > copy_file_range() syscall so that user file copies can be offloaded
> > to the hardware efficiently.
> > 
> > This seems like it would relatively easy to do with an fs/iomap iter
> > loop that maps src + dst file ranges and issues block copy offload
> > commands on the extents. We already do similar "read from source,
> > write to destination" operations in iomap, so it's not a huge
> > stretch to extent the iomap interfaces to provide an copy offload
> > mechanism using this infrastructure.
> > 
> > Also, hooking this up to copy-file-range() will also get you
> > immediate data integrity testing right down to the hardware via fsx
> > in fstests - it uses copy_file_range() as one of it's operations and
> > it will find all the off-by-one failures in both the linux IO stack
> > implementation and the hardware itself.
> > 
> > And, in reality, I wouldn't trust a block copy offload mechanism
> > until it is integrated with filesystems, the page cache and has
> > solid end-to-end data integrity testing available to shake out all
> > the bugs that will inevitably exist in this stack....
> 
> We had planned copy_file_range (CFR) in next phase of copy offload patch series.
> Thinking that we will get to CFR when everything else is robust.
> But if that is needed to make things robust, will start looking into that.

How do you make it robust when there is no locking/serialisation to
prevent overlapping concurrent IO while the copy-offload is in
progress? Or that you don't have overlapping concurrent
copy-offloads running at the same time?

You've basically created a block dev ioctl interface that looks
impossible to use safely. It doesn't appear to be coherent with the
blockdev page cache nor does it appear to have any documented data
integrity semantics, either. e.g. how does this interact with the
guarantees that fsync_bdev() and/or sync_blockdev() are supposed to
provide?

IOWs, if you don't have either CFR or some other strictly bound
kernel user with well defined access, synchronisation and integrity
semantics, how can anyone actually robustly test these ioctls to be
working correctly in all situations they might be called?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
