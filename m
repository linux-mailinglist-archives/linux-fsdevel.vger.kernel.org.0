Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29F49689461
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Feb 2023 10:51:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232940AbjBCJtn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Feb 2023 04:49:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232056AbjBCJtl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Feb 2023 04:49:41 -0500
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D8CE79C90;
        Fri,  3 Feb 2023 01:49:39 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0VaoUwBD_1675417773;
Received: from 30.221.129.149(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VaoUwBD_1675417773)
          by smtp.aliyun-inc.com;
          Fri, 03 Feb 2023 17:49:35 +0800
Message-ID: <160b9e99-bff6-e37c-5f16-00157766535e@linux.alibaba.com>
Date:   Fri, 3 Feb 2023 17:49:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: make alloc_anon_inode more useful
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Daniel Vetter <daniel@ffwll.ch>, Nadav Amit <namit@vmware.com>,
        "VMware, Inc." <pv-drivers@vmware.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Al Viro <viro@zeniv.linux.org.uk>
References: <20210309155348.974875-1-hch@lst.de>
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <20210309155348.974875-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

Sorry for digging...

This patch series seems useful for fs developers.  I'm not sure its
current status and why it doesn't get merged.


On 3/9/21 11:53 PM, Christoph Hellwig wrote:
> Hi all,
> 
> this series first renames the existing alloc_anon_inode to
> alloc_anon_inode_sb to clearly mark it as requiring a superblock.
> 
> It then adds a new alloc_anon_inode that works on the anon_inode
> file system super block, thus removing tons of boilerplate code.
> 
> The few remainig callers of alloc_anon_inode_sb all use alloc_file_pseudo
> later, but might also be ripe for some cleanup.
> 
> Diffstat:
>  arch/powerpc/platforms/pseries/cmm.c |   27 +-------------
>  drivers/dma-buf/dma-buf.c            |    2 -
>  drivers/gpu/drm/drm_drv.c            |   64 +----------------------------------
>  drivers/misc/cxl/api.c               |    2 -
>  drivers/misc/vmw_balloon.c           |   24 +------------
>  drivers/scsi/cxlflash/ocxl_hw.c      |    2 -
>  drivers/virtio/virtio_balloon.c      |   30 +---------------
>  fs/aio.c                             |    2 -
>  fs/anon_inodes.c                     |   15 +++++++-
>  fs/libfs.c                           |    2 -
>  include/linux/anon_inodes.h          |    1 
>  include/linux/fs.h                   |    2 -
>  kernel/resource.c                    |   30 ++--------------
>  mm/z3fold.c                          |   38 +-------------------
>  mm/zsmalloc.c                        |   48 +-------------------------
>  15 files changed, 39 insertions(+), 250 deletions(-)
> 

-- 
Thanks,
Jingbo
