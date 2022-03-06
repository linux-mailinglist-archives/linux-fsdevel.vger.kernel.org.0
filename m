Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39BE54CEE5B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Mar 2022 00:17:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233352AbiCFXS2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Mar 2022 18:18:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbiCFXS0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Mar 2022 18:18:26 -0500
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 320252BFA;
        Sun,  6 Mar 2022 15:17:32 -0800 (PST)
Received: from dread.disaster.area (pa49-186-17-0.pa.vic.optusnet.com.au [49.186.17.0])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 3710D530183;
        Mon,  7 Mar 2022 10:17:29 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nR07z-002NgX-MB; Mon, 07 Mar 2022 10:17:27 +1100
Date:   Mon, 7 Mar 2022 10:17:27 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>, sagi@grimberg.me,
        kbusch@kernel.org, song@kernel.org, linux-block@vger.kernel.org,
        linux-raid@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/2] block: remove the per-bio/request write hint
Message-ID: <20220306231727.GP3927073@dread.disaster.area>
References: <20220304175556.407719-1-hch@lst.de>
 <20220304175556.407719-2-hch@lst.de>
 <20220304221255.GL3927073@dread.disaster.area>
 <20220305051929.GA24696@lst.de>
 <20220305214056.GO3927073@dread.disaster.area>
 <2241127c-c600-529a-ae41-30cbcc6b281d@kernel.dk>
 <20220306180115.GA8777@lst.de>
 <f08db783-a665-2df6-5d8e-597aacd1e687@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f08db783-a665-2df6-5d8e-597aacd1e687@kernel.dk>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=e9dl9Yl/ c=1 sm=1 tr=0 ts=6225410a
        a=+dVDrTVfsjPpH/ci3UuFng==:117 a=+dVDrTVfsjPpH/ci3UuFng==:17
        a=kj9zAlcOel0A:10 a=o8Y5sQTvuykA:10 a=JfrnYn6hAAAA:8 a=7-415B0cAAAA:8
        a=iA7CECttYVG2FqG4ICsA:9 a=CjuIK1q_8ugA:10 a=1CNFftbPRP8L7MoqJWF3:22
        a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Mar 06, 2022 at 11:06:12AM -0700, Jens Axboe wrote:
> On 3/6/22 11:01 AM, Christoph Hellwig wrote:
> > On Sun, Mar 06, 2022 at 10:11:46AM -0700, Jens Axboe wrote:
> >> Yes, I think we should kill it. If we retain the inode hint, the f2fs
> >> doesn't need a any changes. And it should be safe to make the per-file
> >> fcntl hints return EINVAL, which they would on older kernels anyway.
> >> Untested, but something like the below.
> > 
> > I've sent this off to the testing farm this morning, but EINVAL might
> > be even better:
> > 
> > http://git.infradead.org/users/hch/block.git/shortlog/refs/heads/more-hint-removal

Yup, I like that.

> I do think EINVAL is better, as it just tells the app it's not available
> like we would've done before. With just doing zeroes, that might break
> applications that set-and-verify. Of course there's also the risk of
> that since we retain inode hints (so they work), but fail file hints.
> That's a lesser risk though, and we only know of the inode hints being
> used.

Agreed, I think EINVAL would be better here - jsut make it behave
like it would on a kernel that never supported this functionality in
the first place. Seems simpler to me for user applications if we do
that.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
