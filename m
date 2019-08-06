Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F504828AB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2019 02:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731167AbfHFAZF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Aug 2019 20:25:05 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:39628 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731081AbfHFAZE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Aug 2019 20:25:04 -0400
Received: from dread.disaster.area (pa49-181-167-148.pa.nsw.optusnet.com.au [49.181.167.148])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id B1D1D43F8BC;
        Tue,  6 Aug 2019 10:25:00 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92)
        (envelope-from <david@fromorbit.com>)
        id 1hunGb-0005bA-93; Tue, 06 Aug 2019 10:23:53 +1000
Date:   Tue, 6 Aug 2019 10:23:53 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        xfs <linux-xfs@vger.kernel.org>
Subject: Re: Block device direct read EIO handling broken?
Message-ID: <20190806002353.GC7777@dread.disaster.area>
References: <20190805181524.GE7129@magnolia>
 <66bd785d-7598-5cc2-5e98-447fd128c153@kernel.dk>
 <36973a52-e876-fc09-7a63-2fc16b855f8d@kernel.dk>
 <BYAPR04MB5816246256B1333C048EB0A1E7DA0@BYAPR04MB5816.namprd04.prod.outlook.com>
 <474c560f-5de0-6082-67ac-f7c640d9b346@kernel.dk>
 <BYAPR04MB5816C3B24310C1E18F9E024CE7DA0@BYAPR04MB5816.namprd04.prod.outlook.com>
 <f3f98663-8f92-c933-c7c0-8db6635e6112@kernel.dk>
 <BYAPR04MB581644536C6EAEA36E3B4912E7DA0@BYAPR04MB5816.namprd04.prod.outlook.com>
 <BYAPR04MB5816C7D04915AF7B656F900BE7DA0@BYAPR04MB5816.namprd04.prod.outlook.com>
 <BYAPR04MB5816D1AB6B586FAD664F8D79E7D50@BYAPR04MB5816.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR04MB5816D1AB6B586FAD664F8D79E7D50@BYAPR04MB5816.namprd04.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=D+Q3ErZj c=1 sm=1 tr=0 cx=a_idp_d
        a=gu9DDhuZhshYSb5Zs/lkOA==:117 a=gu9DDhuZhshYSb5Zs/lkOA==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=FmdZ9Uzk2mMA:10
        a=7-415B0cAAAA:8 a=_vcUoB3Bm8cU6SNf8L0A:9 a=CjuIK1q_8ugA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 06, 2019 at 12:05:51AM +0000, Damien Le Moal wrote:
> On 2019/08/06 7:05, Damien Le Moal wrote:
> > On 2019/08/06 6:59, Damien Le Moal wrote:
> >> On 2019/08/06 6:28, Jens Axboe wrote:
> >>> On 8/5/19 2:27 PM, Damien Le Moal wrote:
> >>>> On 2019/08/06 6:26, Jens Axboe wrote:
> >>>>>> In any case, looking again at this code, it looks like there is a
> >>>>>> problem with dio->size being incremented early, even for fragments
> >>>>>> that get BLK_QC_T_EAGAIN, because dio->size is being used in
> >>>>>> blkdev_bio_end_io(). So an incorrect size can be reported to user
> >>>>>> space in that case on completion (e.g. large asynchronous no-wait dio
> >>>>>> that cannot be issued in one go).
> >>>>>>
> >>>>>> So maybe something like this ? (completely untested)
> >>>>>
> >>>>> I think that looks pretty good, I like not double accounting with
> >>>>> this_size and dio->size, and we retain the old style ordering for the
> >>>>> ret value.
> >>>>
> >>>> Do you want a proper patch with real testing backup ? I can send that
> >>>> later today.
> >>>
> >>> Yeah that'd be great, I like your approach better.
> >>>
> >>
> >> Looking again, I think this is not it yet: dio->size is being referenced after
> >> submit_bio(), so blkdev_bio_end_io() may see the old value if the bio completes
> >> before dio->size increment. So the use-after-free is still there. And since
> >> blkdev_bio_end_io() processes completion to user space only when dio->ref
> >> becomes 0, adding an atomic_inc/dec(&dio->ref) over the loop would not help and
> >> does not cover the single BIO case. Any idea how to address this one ?
> >>
> > 
> > May be add a bio_get/put() over the 2 places that do submit_bio() would work,
> > for all cases (single/multi BIO, sync & async). E.g.:
> > 
> > +                       bio_get(bio);
> >                         qc = submit_bio(bio);
> >                         if (qc == BLK_QC_T_EAGAIN) {
> >                                 if (!dio->size)
> >                                         ret = -EAGAIN;
> > +                               bio_put(bio);
> >                                 goto error;
> >                         }
> >                         dio->size += bio_size;
> > +                       bio_put(bio);
> > 
> > Thoughts ?
> > 
> 
> That does not work since the reference to dio->size in blkdev_bio_end_io()
> depends on atomic_dec_and_test(&dio->ref) which counts the BIO fragments for the
> dio (+1 for async multi-bio case). So completion of the last bio can still
> reference the old value of dio->size.

Didn't we fix this same use-after-free in iomap_dio_rw() in commit
4ea899ead278 ("iomap: fix a use after free in iomap_dio_rw")?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
