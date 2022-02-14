Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39ABD4B5D6B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Feb 2022 23:08:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231705AbiBNWIa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Feb 2022 17:08:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbiBNWIa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Feb 2022 17:08:30 -0500
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6426F13C391;
        Mon, 14 Feb 2022 14:08:21 -0800 (PST)
Received: from dread.disaster.area (pa49-186-85-251.pa.vic.optusnet.com.au [49.186.85.251])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 793C852DCD8;
        Tue, 15 Feb 2022 09:08:12 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nJjW0-00C4n4-91; Tue, 15 Feb 2022 09:08:12 +1100
Date:   Tue, 15 Feb 2022 09:08:12 +1100
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
Message-ID: <20220214220741.GB2872883@dread.disaster.area>
References: <CGME20220214080551epcas5p201d4d85e9d66077f97585bb3c64517c0@epcas5p2.samsung.com>
 <20220214080002.18381-1-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220214080002.18381-1-nj.shetty@samsung.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=deDjYVbe c=1 sm=1 tr=0 ts=620ad2d3
        a=2CV4XU02g+4RbH+qqUnf+g==:117 a=2CV4XU02g+4RbH+qqUnf+g==:17
        a=IkcTkHD0fZMA:10 a=oGFeUVbbRNcA:10 a=7-415B0cAAAA:8
        a=JFXMuzjNVKxm2W9Oq_QA:9 a=QEXdDO2ut3YA:10 a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 14, 2022 at 01:29:50PM +0530, Nitesh Shetty wrote:
> The patch series covers the points discussed in November 2021 virtual call
> [LSF/MM/BFP TOPIC] Storage: Copy Offload[0].
> We have covered the Initial agreed requirements in this patchset.
> Patchset borrows Mikulas's token based approach for 2 bdev
> implementation.
> 
> Overall series supports –
> 
> 1. Driver
> - NVMe Copy command (single NS), including support in nvme-target (for
> 	block and file backend)
> 
> 2. Block layer
> - Block-generic copy (REQ_COPY flag), with interface accommodating
> 	two block-devs, and multi-source/destination interface
> - Emulation, when offload is natively absent
> - dm-linear support (for cases not requiring split)
> 
> 3. User-interface
> - new ioctl
> 
> 4. In-kernel user
> - dm-kcopyd

The biggest missing piece - and arguably the single most useful
piece of this functionality for users - is hooking this up to the
copy_file_range() syscall so that user file copies can be offloaded
to the hardware efficiently.

This seems like it would relatively easy to do with an fs/iomap iter
loop that maps src + dst file ranges and issues block copy offload
commands on the extents. We already do similar "read from source,
write to destination" operations in iomap, so it's not a huge
stretch to extent the iomap interfaces to provide an copy offload
mechanism using this infrastructure.

Also, hooking this up to copy-file-range() will also get you
immediate data integrity testing right down to the hardware via fsx
in fstests - it uses copy_file_range() as one of it's operations and
it will find all the off-by-one failures in both the linux IO stack
implementation and the hardware itself.

And, in reality, I wouldn't trust a block copy offload mechanism
until it is integrated with filesystems, the page cache and has
solid end-to-end data integrity testing available to shake out all
the bugs that will inevitably exist in this stack....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
