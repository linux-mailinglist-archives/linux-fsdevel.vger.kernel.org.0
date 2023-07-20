Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79B5375A61A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jul 2023 08:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbjGTGPX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jul 2023 02:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjGTGPW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jul 2023 02:15:22 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03F1919B2;
        Wed, 19 Jul 2023 23:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=z8bMcYL2sfItal6IPN1MaB7xzF8i69WDSnHwMDnwZ2A=; b=iCftUFPYgfzlWh7j3fpyVulRXo
        ba4PcyoOflOzDAEsmAZv96NBFLZKtt9i6/HxH6cktJPdkgDWm8jJ5w8TquEBW3dYmxQNZxR8LOz3J
        9kdB7IRUvPKYHLXTAAdhCQLz5Ux13wtOjtXuseNEDLVvqOQUB9kAXvC27L791ckcJS5Dqjh8laT8d
        2fiuDjLMqnOxXvsCAhrFY0ClDR7ARN9aGZCw2wDvcHyJKEquXCzkLMb0CAxd8FG9Ug3vB29G1lkg7
        6xUZG29bDDGCOhSfITFLVEYxZdZ0ZhpUYHRk/gef+6Hr2LP0+yeBijY5QVk/scwD3ASrcyZ67hLxE
        9CKqaO5w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qMMvx-009uI8-1n;
        Thu, 20 Jul 2023 06:14:41 +0000
Date:   Wed, 19 Jul 2023 23:14:41 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     Sergei Shtepa <sergei.shtepa@veeam.com>, axboe@kernel.dk,
        hch@infradead.org, corbet@lwn.net, snitzer@kernel.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com,
        willy@infradead.org, dlemoal@kernel.org, linux@weissschuh.net,
        jack@suse.cz, ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Donald Buczek <buczek@molgen.mpg.de>,
        "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH v5 02/11] block: Block Device Filtering Mechanism
Message-ID: <ZLjQ0YfH7JyQyMyJ@infradead.org>
References: <20230612135228.10702-1-sergei.shtepa@veeam.com>
 <20230612135228.10702-3-sergei.shtepa@veeam.com>
 <f935840e-12a7-c37b-183c-27e2d83990ea@huaweicloud.com>
 <90f79cf3-86a2-02c0-1887-d3490f9848bb@veeam.com>
 <d929eaa7-61d6-c4c4-aabc-0124c3693e10@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d929eaa7-61d6-c4c4-aabc-0124c3693e10@huaweicloud.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 18, 2023 at 09:37:33AM +0800, Yu Kuai wrote:
> I haven't review blksnap code yet, but this sounds like a problem.
> 
> possible solutions I have in mind:
> 
> 1. Store blkfilter for each partition from bdev_disk_changed() before
> delete_partition(), and add blkfilter back after add_partition().
> 
> 2. Store blkfilter from gendisk as a xarray, and protect it by
> 'open_mutex' like 'part_tbl', block_device can keep the pointer to
> reference blkfilter so that performance from fast path is ok, and the
> lifetime of blkfiter can be managed separately.

The whole point of bdev_disk_changed is that the partitions might not
be the same ones as before..
