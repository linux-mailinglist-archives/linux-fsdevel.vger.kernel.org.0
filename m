Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C433B513E48
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Apr 2022 00:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352768AbiD1WKK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Apr 2022 18:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347740AbiD1WKJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Apr 2022 18:10:09 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F5233EA9;
        Thu, 28 Apr 2022 15:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9v/jwR+R8u87FL4qORMMhnuwU+FONow5gj9ZK60JlpI=; b=s7tZJeCHXPydeNyzQuN8NsfxgP
        eu4k6UGhsVLB00xCdra8ScX0cG22vl4diUOaGh9FKdX7ZbDm54F7Sz0V6dDshrJNi6/wT9TaTLE7L
        4lziHtohweA2A/pEGRkEQA/vjgE7pbVRnrWniCsX9yEkpQ2hMs2CWXd+7aGj4ahpDbzBv+jVDj0ap
        JdQw0FhqNuU0KC9UTqrHuy4JXz7tHdwXRx/xwjjzvCWyXUc2CceR12Gm2rzyMoXNmRGC7jZDfM/Sd
        fASKdOUqjIoKv+PaYoM25kjeVCygCtv96ptD2wNPrJ0lPiZpRzZ7Jn+O1gxO1aN3k4eGnAkBe8P/F
        +J/VDTRA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nkCHX-008hOx-BO; Thu, 28 Apr 2022 22:06:39 +0000
Date:   Thu, 28 Apr 2022 15:06:39 -0700
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
Subject: Re: [PATCH 16/16] dm-zoned: ensure only power of 2 zone sizes are
 allowed
Message-ID: <YmsP7wQAyDx9g8gy@bombadil.infradead.org>
References: <20220427160255.300418-1-p.raghav@samsung.com>
 <CGME20220427160313eucas1p1feecf74ec15c8c3d9250444710fd1676@eucas1p1.samsung.com>
 <20220427160255.300418-17-p.raghav@samsung.com>
 <2ffc46c7-945f-ba26-90db-737fccd74fdf@opensource.wdc.com>
 <YmrQFu9EbMmrL2Ys@bombadil.infradead.org>
 <ce56cb7d-f184-aad1-4935-5f622e7afe5d@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce56cb7d-f184-aad1-4935-5f622e7afe5d@opensource.wdc.com>
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

On Fri, Apr 29, 2022 at 06:43:58AM +0900, Damien Le Moal wrote:
> On 4/29/22 02:34, Luis Chamberlain wrote:
> > One step at a time.
> 
> Yes, in general, I agree. But in this case, that will create kernel
> versions that end up having partial support for zoned drives. Not ideal to
> say the least. So if the patches are not that big, I would rather like to
> see everything go into a single release.

This would have delayed the patches more, and I see no rush for npo2 to
use dm-zoned really. Just as with f2fs, we can take priorities at a
time.

  Luis
