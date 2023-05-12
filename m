Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79A19700ED3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 May 2023 20:30:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238847AbjELSak (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 May 2023 14:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238860AbjELSad (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 May 2023 14:30:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DD2D59E4;
        Fri, 12 May 2023 11:29:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 33B2D657E4;
        Fri, 12 May 2023 18:28:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88631C433EF;
        Fri, 12 May 2023 18:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683916111;
        bh=oFn6kTrQB5X+BdUNZ09gyWmaepLu3LinttkMwo7NC9M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bGKKspqhQTtaA0BwgEBc4s+CHOK2W8+I60ncCpAoA0oP3wi0GmY5bouKvT19n0Yql
         Usf/OHDj8qnBNO6gXE8kRv49KORT6rNQRbdQf49Nsl08CqX6bBr3yCIWFADOKfIMVm
         Ju0aV3wESe6qeWkXZLPGZWnKiojw5JgNy706asoDezBT1P+vR0C60vyZrPJqeo8zki
         f7PegWFlrjV4ACTWr528Nxz2AHjx/UDBnCKW44lMDqWA70aA8EBv3X1M7T2+JR2f9d
         TNN1JJYDr2QWBOwot1i+cgaBLLmbHpAwgbDMmp+uxhmYfgDD8KvlaM9YPI2hcu0J7p
         korFm5yaF5dig==
Date:   Fri, 12 May 2023 11:28:31 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Sarthak Kukreti <sarthakkukreti@chromium.org>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Brian Foster <bfoster@redhat.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Bart Van Assche <bvanassche@google.com>
Subject: Re: [PATCH v6 0/5] Introduce block provisioning primitives
Message-ID: <20230512182831.GC858791@frogsfrogsfrogs>
References: <20230420004850.297045-1-sarthakkukreti@chromium.org>
 <20230506062909.74601-1-sarthakkukreti@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230506062909.74601-1-sarthakkukreti@chromium.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 05, 2023 at 11:29:04PM -0700, Sarthak Kukreti wrote:
> Hi,
> 
> This patch series covers iteration 6 of adding support for block
> provisioning requests.

I didn't even notice there was a v6.  Could you start a fresh thread
when you bump the revision count, please?

--D

> Changes from v5:
> - Remove explicit supports_provision from dm devices.
> - Move provision sectors io hint to pool_io_hint. Other devices
>   will derive the provisioning limits from the stack.
> - Remove artifact from v4 to omit cell_defer_no_holder for
>   REQ_OP_PROVISION.
> - Fix blkdev_fallocate() called with invalid fallocate
>   modes to propagate errors correctly.
> 
> Sarthak Kukreti (5):
>   block: Don't invalidate pagecache for invalid falloc modes
>   block: Introduce provisioning primitives
>   dm: Add block provisioning support
>   dm-thin: Add REQ_OP_PROVISION support
>   loop: Add support for provision requests
> 
>  block/blk-core.c              |  5 +++
>  block/blk-lib.c               | 53 ++++++++++++++++++++++++++
>  block/blk-merge.c             | 18 +++++++++
>  block/blk-settings.c          | 19 ++++++++++
>  block/blk-sysfs.c             |  9 +++++
>  block/bounce.c                |  1 +
>  block/fops.c                  | 31 +++++++++++++---
>  drivers/block/loop.c          | 42 +++++++++++++++++++++
>  drivers/md/dm-crypt.c         |  4 +-
>  drivers/md/dm-linear.c        |  1 +
>  drivers/md/dm-snap.c          |  7 ++++
>  drivers/md/dm-table.c         | 23 ++++++++++++
>  drivers/md/dm-thin.c          | 70 +++++++++++++++++++++++++++++++++--
>  drivers/md/dm.c               |  6 +++
>  include/linux/bio.h           |  6 ++-
>  include/linux/blk_types.h     |  5 ++-
>  include/linux/blkdev.h        | 16 ++++++++
>  include/linux/device-mapper.h | 17 +++++++++
>  18 files changed, 319 insertions(+), 14 deletions(-)
> 
> -- 
> 2.40.1.521.gf1e218fcd8-goog
> 
