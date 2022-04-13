Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A914A4FEF86
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Apr 2022 08:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231855AbiDMGMt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Apr 2022 02:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232277AbiDMGMP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Apr 2022 02:12:15 -0400
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 56C1F35DE1;
        Tue, 12 Apr 2022 23:09:53 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-115-138.pa.nsw.optusnet.com.au [49.181.115.138])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id E9AFA53458F;
        Wed, 13 Apr 2022 16:09:48 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1neWCI-00H7H4-RH; Wed, 13 Apr 2022 16:09:46 +1000
Date:   Wed, 13 Apr 2022 16:09:46 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Linux MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Jane Chu <jane.chu@oracle.com>
Subject: Re: [PATCH v12 6/7] xfs: Implement ->notify_failure() for XFS
Message-ID: <20220413060946.GL1544202@dread.disaster.area>
References: <20220410160904.3758789-1-ruansy.fnst@fujitsu.com>
 <20220410160904.3758789-7-ruansy.fnst@fujitsu.com>
 <20220413000423.GK1544202@dread.disaster.area>
 <CAPcyv4jKLZhcCiSEU+O+OJ2e+y9_B2CvaEfAKyBnhhSd+da=Zg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4jKLZhcCiSEU+O+OJ2e+y9_B2CvaEfAKyBnhhSd+da=Zg@mail.gmail.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=deDjYVbe c=1 sm=1 tr=0 ts=62566930
        a=/kVtbFzwtM2bJgxRVb+eeA==:117 a=/kVtbFzwtM2bJgxRVb+eeA==:17
        a=kj9zAlcOel0A:10 a=z0gMJWrwH1QA:10 a=7-415B0cAAAA:8
        a=1SRcz3ERVth_psKDs80A:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 12, 2022 at 07:06:40PM -0700, Dan Williams wrote:
> On Tue, Apr 12, 2022 at 5:04 PM Dave Chinner <david@fromorbit.com> wrote:
> > On Mon, Apr 11, 2022 at 12:09:03AM +0800, Shiyang Ruan wrote:
> > > Introduce xfs_notify_failure.c to handle failure related works, such as
> > > implement ->notify_failure(), register/unregister dax holder in xfs, and
> > > so on.
> > >
> > > If the rmap feature of XFS enabled, we can query it to find files and
> > > metadata which are associated with the corrupt data.  For now all we do
> > > is kill processes with that file mapped into their address spaces, but
> > > future patches could actually do something about corrupt metadata.
> > >
> > > After that, the memory failure needs to notify the processes who are
> > > using those files.
...
> > > @@ -1964,8 +1965,8 @@ xfs_alloc_buftarg(
> > >       btp->bt_mount = mp;
> > >       btp->bt_dev =  bdev->bd_dev;
> > >       btp->bt_bdev = bdev;
> > > -     btp->bt_daxdev = fs_dax_get_by_bdev(bdev, &btp->bt_dax_part_off, NULL,
> > > -                                         NULL);
> > > +     btp->bt_daxdev = fs_dax_get_by_bdev(bdev, &btp->bt_dax_part_off, mp,
> > > +                                         &xfs_dax_holder_operations);
> >
> > I see a problem with this: we are setting up notify callbacks before
> > we've even read in the superblock during mount. i.e. we don't even
> > kow yet if we've got an XFS filesystem on this block device.
> > Hence these notifications need to be delayed until after the
> > filesystem is mounted, all the internal structures have been set up
> > and log recovery has completed.
> 
> So I think this gets back to the fact that there will eventually be 2
> paths into this notifier.

I'm not really concerned by how the notifications are generated;
my concern is purely that notifications can be handled safely.

> All that to say, I think it is ok / expected for the filesystem to
> drop notifications on the floor when it is not ready to handle them.

Well, yes. The whole point of notifications is the consumer makes
the decision on what to do with the notification it receives - the
producer of the notification does not (and can not) dictate what
policy the consumer(s) implement...

> For example there are no processes to send SIGBUS to if the filesystem
> has not even finished mount.

There may be not processes to send SIGBUS to even if the filesystem
has finished mount. But we still want the notifications to be
delivered and we still need to handle them safely.

IOWs, while we might start by avoiding notifications during mount,
this doesn't mean we will never have reason to process events during
mount. What we do with this notification is going to evolve over
time as we add new and adapt existing functionality....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
