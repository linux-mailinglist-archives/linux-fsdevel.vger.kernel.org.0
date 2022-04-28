Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1162B513AF3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Apr 2022 19:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350526AbiD1Rc7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Apr 2022 13:32:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348393AbiD1Rc6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Apr 2022 13:32:58 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67D3149F14;
        Thu, 28 Apr 2022 10:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M77UyFZc/CQOenG5boLjqoc0qTJMwAANdJbVnxb68KE=; b=JWA7yBd2WgLv8JgmAvqWwyoH7N
        CbCI23q7BAOQJ0ekZUG/FMPi05rdlj74q9wztR9r4BIk+quAD2WWbX+5hu0/Tn9NNZBjpH7On+mMo
        VC6igZust8a3wLGSg61u8qnlyDLLzOqnSRuUT272lK0I/PfG3acjO4xrDkVkSKqZP881da1wHQb0o
        YPusvURC9voi3RnaJh4nT8b+IVwjMG6wfxev2aPSyh9jfbfzwITiAEf0dPZe2VsVzZunc5WtOly+c
        R1yUG4N0F25z4sNcXZVg07M81adkeM3AyCXsGszurdLc5pViE/I3gVGt7mNG8XZe7KQhBn80LujAv
        8QWTtyqQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nk7xL-0082dM-NY; Thu, 28 Apr 2022 17:29:31 +0000
Date:   Thu, 28 Apr 2022 10:29:31 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Pankaj Raghav <p.raghav@samsung.com>, jaegeuk@kernel.org,
        axboe@kernel.dk, snitzer@kernel.org, hch@lst.de,
        naohiro.aota@wdc.com, sagi@grimberg.me, dsterba@suse.com,
        johannes.thumshirn@wdc.com, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, clm@fb.com, gost.dev@samsung.com,
        chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        josef@toxicpanda.com, jonathan.derrick@linux.dev, agk@redhat.com,
        kbusch@kernel.org, kch@nvidia.com, linux-nvme@lists.infradead.org,
        dm-devel@redhat.com, bvanassche@acm.org, jiangbo.365@bytedance.com,
        linux-fsdevel@vger.kernel.org, matias.bjorling@wdc.com,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 04/16] block: allow blk-zoned devices to have
 non-power-of-2 zone size
Message-ID: <YmrO+2sexVkJEaIr@bombadil.infradead.org>
References: <20220427160255.300418-1-p.raghav@samsung.com>
 <CGME20220427160300eucas1p1470fe30535849de6204bb78d7083cb3a@eucas1p1.samsung.com>
 <20220427160255.300418-5-p.raghav@samsung.com>
 <eeb86052-399c-a79b-32ab-1ed1b2d05e07@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eeb86052-399c-a79b-32ab-1ed1b2d05e07@opensource.wdc.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 28, 2022 at 08:37:27AM +0900, Damien Le Moal wrote:
> Also, the entire premise of this patch series is that it is hard for
> people to support the unusable sectors between zone capacity and zone end
> for drives with a zone capacity smaller than the zone size.
> 
> Yet, here you do not check that zone capacity == zone size for drives that
> do not have a zone size equal to a power of 2 number of sectors. This
> means that we can still have drives with ZC < ZS AND ZS not equal to a
> power of 2. So from the point of view of your arguments, no gains at all.
> Any thoughts on this ?

You are right, a check should be added on bringup so that if npo2 is
used, zone cap == zone size. That should be added on the next iteration
of this patch.

  Luis
