Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8169351E41B
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 May 2022 06:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445501AbiEGEcW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 7 May 2022 00:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1445489AbiEGEcU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 7 May 2022 00:32:20 -0400
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au [211.29.132.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EF2E76160E
        for <linux-fsdevel@vger.kernel.org>; Fri,  6 May 2022 21:28:34 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-2-147.pa.nsw.optusnet.com.au [49.181.2.147])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id C095410E64E8;
        Sat,  7 May 2022 14:28:31 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nnC3R-008ybS-6z; Sat, 07 May 2022 14:28:29 +1000
Date:   Sat, 7 May 2022 14:28:29 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Liang Chen <liangchen.linux@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, hch@infradead.org,
        jmoyer@redhat.com, jack@suse.cz, lczerner@redhat.com
Subject: Re: [PATCH v2] fs: Fix page cache inconsistency when mixing buffered
 and AIO DIO for bdev
Message-ID: <20220507042829.GN1949718@dread.disaster.area>
References: <20220507041033.9588-1-lchen@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220507041033.9588-1-lchen@localhost.localdomain>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=deDjYVbe c=1 sm=1 tr=0 ts=6275f571
        a=ivVLWpVy4j68lT4lJFbQgw==:117 a=ivVLWpVy4j68lT4lJFbQgw==:17
        a=kj9zAlcOel0A:10 a=oZkIemNP1mAA:10 a=pGLkceISAAAA:8 a=7-415B0cAAAA:8
        a=eFi3qrmQF13hplW5bdIA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, May 07, 2022 at 12:10:33PM +0800, Liang Chen wrote:
> From: Liang Chen <liangchen.linux@gmail.com>
> 
> As pointed out in commit 332391a, mixing buffered reads and asynchronous
> direct writes risks ending up with a situation where stale data is left
> in page cache while new data is already written to disk. The same problem
> hits block dev fs too. A similar approach needs to be taken here.
> 
> Signed-off-by: Liang Chen <liangchen.linux@gmail.com>
> ---
> V2: declare blkdev_sb_init_dio_done_wq static
> ---
>  block/fops.c | 87 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 87 insertions(+)

Rather than copying functionality from the two other generic DIO
paths (which we really want to get down to 1!) into this cut down,
less functional DIO path, shouldn't we be spending the effort to
convert the blkdev device to use one of the other generic DIO paths
that already solves this problem and likely gets a lot more test
coverage?

Cheers,

Dave.

-- 
Dave Chinner
david@fromorbit.com
