Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDFA64CE73F
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Mar 2022 22:41:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232327AbiCEVlv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 5 Mar 2022 16:41:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbiCEVlu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 5 Mar 2022 16:41:50 -0500
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2615637022;
        Sat,  5 Mar 2022 13:41:00 -0800 (PST)
Received: from dread.disaster.area (pa49-186-17-0.pa.vic.optusnet.com.au [49.186.17.0])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 91F0F53071C;
        Sun,  6 Mar 2022 08:40:57 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nQc92-001xlk-2s; Sun, 06 Mar 2022 08:40:56 +1100
Date:   Sun, 6 Mar 2022 08:40:56 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, sagi@grimberg.me, kbusch@kernel.org,
        song@kernel.org, linux-block@vger.kernel.org,
        linux-raid@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/2] block: remove the per-bio/request write hint
Message-ID: <20220305214056.GO3927073@dread.disaster.area>
References: <20220304175556.407719-1-hch@lst.de>
 <20220304175556.407719-2-hch@lst.de>
 <20220304221255.GL3927073@dread.disaster.area>
 <20220305051929.GA24696@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220305051929.GA24696@lst.de>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=deDjYVbe c=1 sm=1 tr=0 ts=6223d8ea
        a=+dVDrTVfsjPpH/ci3UuFng==:117 a=+dVDrTVfsjPpH/ci3UuFng==:17
        a=kj9zAlcOel0A:10 a=o8Y5sQTvuykA:10 a=7-415B0cAAAA:8
        a=PBs3jEgWuutBivueVwoA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Mar 05, 2022 at 06:19:29AM +0100, Christoph Hellwig wrote:
> On Sat, Mar 05, 2022 at 09:12:55AM +1100, Dave Chinner wrote:
> > AFAICT, all the filesystem/IO path passthrough plumbing for hints is
> > now gone, and no hardware will ever receive hints.  Doesn't this
> > mean that file_write_hint(), file->f_write_hint and iocb->ki_hint
> > are now completely unused, too?
> 
> No, for the reason tha you state below.  f2fs still uses it.

My point is that f2fs uses i_write_hint, not f_write_hint or
ki_hint. IOWs, nothing in the IO path use the iocb or file write
hints anymore because they only ever got used to set the hint for
bios. It's now unused information.

According to the io_uring ppl, setup of unnecessary fields in the
iocb has a measurable cost and they've done work to minimise it in
the past. So if these fields are not actually used by anyone in the
IO path, why should we still pay the cost calling
ki_hint_validate(file_write_hint(file)) when setting up an iocb?

> > AFAICT, this patch leaves just the f2fs allocator usage of
> > inode->i_rw_hint to select a segment to allocate from as the
> > remaining consumer of this entire plumbing and user API. Is that
> > used by applications anywhere, or can that be removed and so the
> > rest of the infrastructure get removed and the fcntl()s no-op'd or
> > -EOPNOTSUPP?
> 
> I was told it is used quite heavily in android.

So it's primarily used by out of tree code? And that after this
patch, there's really no way to test that this API does anything
useful at all?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
