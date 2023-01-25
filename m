Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5547967B6F0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jan 2023 17:28:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235283AbjAYQ2m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Jan 2023 11:28:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234844AbjAYQ2l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Jan 2023 11:28:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 788482B634;
        Wed, 25 Jan 2023 08:28:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 311F1B81AD5;
        Wed, 25 Jan 2023 16:28:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E0CBC433D2;
        Wed, 25 Jan 2023 16:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674664117;
        bh=EFtrI+qkMXtuqv2/AauSnQYLbjXALjHF58RitU958dY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H66lRNm1bH8ABZeGBLaQk11C4esX8FmvjWLeRmGDWDbm2Mg3g3NuDCyyaTpayLpwC
         4sBV7g/avgr7fLS5n+EjEM+SjaS0g0pmJArbUpnbEdmDHtJHsC+tjmvcz4bjAVRq4+
         4a5JyRYcGcyao7yE9sc2wYYkpapmvdsB/FlaoCRTDeIxsc6Srlkqa/1X1BPzpGP/p5
         iCX6c+D/PHkT9D4K10VHOEhDhQwW93Idm/oNezpjLANXPDWaC9lHCIqtYifhENXuQe
         RLw1KyXCdcnCUZMS93kV2vX48UzFSeewNTORHXQLaDnVLdz6FDsLwB2D8Pgh/zESjh
         9G6SmhI66fG8A==
Date:   Wed, 25 Jan 2023 09:28:33 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-block@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 7/7] block: remove ->rw_page
Message-ID: <Y9FYsXgo9pVJ5weX@kbusch-mbp.dhcp.thefacebook.com>
References: <20230125133436.447864-1-hch@lst.de>
 <20230125133436.447864-8-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230125133436.447864-8-hch@lst.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 25, 2023 at 02:34:36PM +0100, Christoph Hellwig wrote:
> @@ -363,8 +384,10 @@ void __swap_writepage(struct page *page, struct writeback_control *wbc)
>  	 */
>  	if (data_race(sis->flags & SWP_FS_OPS))
>  		swap_writepage_fs(page, wbc);
> +	else if (sis->flags & SWP_SYNCHRONOUS_IO)
> +		swap_writepage_bdev_sync(page, wbc, sis);

For an additional cleanup, it looks okay to remove the SWP_SYNCHRONOUS_IO flag
entirely and just check bdev_synchronous(sis->bdev)) directly instead.
