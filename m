Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8E4B5169B8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 May 2022 06:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352984AbiEBEN3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 May 2022 00:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349366AbiEBEN0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 May 2022 00:13:26 -0400
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au [211.29.132.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BFBDB3A6;
        Sun,  1 May 2022 21:09:57 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-2-147.pa.nsw.optusnet.com.au [49.181.2.147])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 71FEB10E608C;
        Mon,  2 May 2022 14:09:53 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nlNNf-006zFQ-FJ; Mon, 02 May 2022 14:09:51 +1000
Date:   Mon, 2 May 2022 14:09:51 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Nitesh Shetty <nj.shetty@samsung.com>
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        dm-devel@redhat.com, linux-nvme@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, nitheshshetty@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 00/10] Add Copy offload support
Message-ID: <20220502040951.GC1360180@dread.disaster.area>
References: <CGME20220426101804epcas5p4a0a325d3ce89e868e4924bbdeeba6d15@epcas5p4.samsung.com>
 <20220426101241.30100-1-nj.shetty@samsung.com>
 <6a85e8c8-d9d1-f192-f10d-09052703c99a@opensource.wdc.com>
 <20220427124951.GA9558@test-zns>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220427124951.GA9558@test-zns>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=e9dl9Yl/ c=1 sm=1 tr=0 ts=626f5993
        a=ivVLWpVy4j68lT4lJFbQgw==:117 a=ivVLWpVy4j68lT4lJFbQgw==:17
        a=IkcTkHD0fZMA:10 a=oZkIemNP1mAA:10 a=7-415B0cAAAA:8
        a=ldjz8t_eVu9c6UoTg2wA:9 a=QEXdDO2ut3YA:10 a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 27, 2022 at 06:19:51PM +0530, Nitesh Shetty wrote:
> O Wed, Apr 27, 2022 at 11:19:48AM +0900, Damien Le Moal wrote:
> > On 4/26/22 19:12, Nitesh Shetty wrote:
> > > The patch series covers the points discussed in November 2021 virtual call
> > > [LSF/MM/BFP TOPIC] Storage: Copy Offload[0].
> > > We have covered the Initial agreed requirements in this patchset.
> > > Patchset borrows Mikulas's token based approach for 2 bdev
> > > implementation.
> > > 
> > > Overall series supports –
> > > 
> > > 1. Driver
> > > - NVMe Copy command (single NS), including support in nvme-target (for
> > >     block and file backend)
> > 
> > It would also be nice to have copy offload emulation in null_blk for testing.
> >
> 
> We can plan this in next phase of copy support, once this series settles down.

Why not just hook the loopback driver up to copy_file_range() so
that the backend filesystem can just reflink copy the ranges being
passed? That would enable testing on btrfs, XFS and NFSv4.2 hosted
image files without needing any special block device setup at all...

i.e. I think you're doing this compeltely backwards by trying to
target non-existent hardware first....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
