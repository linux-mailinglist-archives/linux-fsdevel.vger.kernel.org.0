Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D98514F57E2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Apr 2022 10:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350356AbiDFIgN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Apr 2022 04:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386180AbiDFIeK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Apr 2022 04:34:10 -0400
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 567853A7ABF;
        Tue,  5 Apr 2022 21:05:11 -0700 (PDT)
Received: from dread.disaster.area (pa49-186-233-190.pa.vic.optusnet.com.au [49.186.233.190])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 0ACAE534493;
        Wed,  6 Apr 2022 14:05:10 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nbwuq-00EJao-I2; Wed, 06 Apr 2022 14:05:08 +1000
Date:   Wed, 6 Apr 2022 14:05:08 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Ritesh Harjani <ritesh.list@gmail.com>
Cc:     fstests <fstests@vger.kernel.org>, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: Re: [PATCHv3 1/4] generic/468: Add another falloc test entry
Message-ID: <20220406040508.GC1609613@dread.disaster.area>
References: <cover.1648730443.git.ritesh.list@gmail.com>
 <75f4c780e8402a8f993cb987e85a31e4895f13de.1648730443.git.ritesh.list@gmail.com>
 <20220403232823.GS1609613@dread.disaster.area>
 <20220405110603.qqxyivpo4vzj5tlt@riteshh-domain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220405110603.qqxyivpo4vzj5tlt@riteshh-domain>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=VuxAv86n c=1 sm=1 tr=0 ts=624d1176
        a=bHAvQTfMiaNt/bo4vVGwyA==:117 a=bHAvQTfMiaNt/bo4vVGwyA==:17
        a=kj9zAlcOel0A:10 a=z0gMJWrwH1QA:10 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
        a=7-415B0cAAAA:8 a=YONGHUKn3BUHUCDE1yQA:9 a=CjuIK1q_8ugA:10
        a=AjGcO6oz07-iQ99wixmX:22 a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 05, 2022 at 04:36:03PM +0530, Ritesh Harjani wrote:
> On 22/04/04 09:28AM, Dave Chinner wrote:
> > On Thu, Mar 31, 2022 at 06:24:20PM +0530, Ritesh Harjani wrote:
> > > From: Ritesh Harjani <riteshh@linux.ibm.com>
> > >
> > > Add another falloc test entry which could hit a kernel bug
> > > with ext4 fast_commit feature w/o below kernel commit [1].
> > >
> > > <log>
> > > [  410.888496][ T2743] BUG: KASAN: use-after-free in ext4_mb_mark_bb+0x26a/0x6c0
> > > [  410.890432][ T2743] Read of size 8 at addr ffff888171886000 by task mount/2743
> > >
> > > This happens when falloc -k size is huge which spans across more than
> > > 1 flex block group in ext4. This causes a bug in fast_commit replay
> > > code which is fixed by kernel commit at [1].
> > >
> > > [1]: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git/commit/?h=dev&id=bfdc502a4a4c058bf4cbb1df0c297761d528f54d
> > >
> > > Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
> > > ---
> > >  tests/generic/468     | 8 ++++++++
> > >  tests/generic/468.out | 2 ++
> > >  2 files changed, 10 insertions(+)
> > >
> > > diff --git a/tests/generic/468 b/tests/generic/468
> > > index 95752d3b..5e73cff9 100755
> > > --- a/tests/generic/468
> > > +++ b/tests/generic/468
> > > @@ -34,6 +34,13 @@ _scratch_mkfs >/dev/null 2>&1
> > >  _require_metadata_journaling $SCRATCH_DEV
> > >  _scratch_mount
> > >
> > > +# blocksize and fact are used in the last case of the fsync/fdatasync test.
> > > +# This is mainly trying to test recovery operation in case where the data
> > > +# blocks written, exceeds the default flex group size (32768*4096*16) in ext4.
> > > +blocks=32768
> > > +blocksize=4096
> >
> > Block size can change based on mkfs parameters. You should extract
> > this dynamically from the filesystem the test is being run on.
> >
> 
> Yes, but we still have kept just 4096 because, anything bigger than that like
> 65536 might require a bigger disk size itself to test. The overall size
> requirement of the disk will then become ~36G (32768 * 65536 * 18)
> Hence I went ahead with 4096 which is good enough for testing.

If the test setup doesn't have a disk large enough, then the test
should be skipped. That's what '_require_scratch_size' is for.

i.e. _require_scratch_size $larger_than_ext4_fg_size

Will do that check once we've calculated the size needed.

> But sure, I will add a comment explaining why we have hardcoded it to 4096
> so that others don't get confused. Larger than this size disk anyway doesn't get
> tested much right?

You shouldn't be constricting the test based on assumptions about
test configurations. If someone decides to test 64k block size, then
they can size their devices appropriately for the configuration they
want to test.  If a 64kB block size filesystem can overrun the
on-disk structure and fail, then the test should exercise that and
fail appropriately.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
