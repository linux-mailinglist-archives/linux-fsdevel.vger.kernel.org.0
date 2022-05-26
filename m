Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4520F534ACE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 May 2022 09:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346393AbiEZHbA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 May 2022 03:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234616AbiEZHa5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 May 2022 03:30:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C399D814B8;
        Thu, 26 May 2022 00:30:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 85FD2B81EBC;
        Thu, 26 May 2022 07:30:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3B16C385A9;
        Thu, 26 May 2022 07:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653550254;
        bh=CdhXMr2z/7slm/5lryO+Ce4aix/nGhmEL+MBV11+SLE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lDbRqYDEvX2gmsbfB4+wc23c4CIicNZ/rXo+Ar2kvB9Q3+lziMedOlvNKHDF5A4Z+
         59ivhSGnlg07tGfKvNoEP2ZKkdYIqKTBB+mYoVBlzxKALq4e6kaxsbrc/hJusiiZuU
         bhuxB6cIzC7cOVrgnDF+SUar9rZ/X5e2X35V61FH+jAZIh7LbDf9KshdOfEMGSezRr
         C7dLqewkRPX12Ld16LIz9yGnnkmpje82McLLQz3rO4/u/LAlZTA6OeXNCy4LEHynhs
         LL0sgL8zPgSA4FNwITZ1nGeVv3tqR9ojB5bYV45ojlJSodRJnAzVFlFJBev7VzxMBe
         ZU4KOxPpZ6C1Q==
Date:   Thu, 26 May 2022 00:30:52 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Keith Busch <kbusch@fb.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        axboe@kernel.dk, Kernel Team <Kernel-team@fb.com>, hch@lst.de,
        bvanassche@acm.org, damien.lemoal@opensource.wdc.com,
        pankydev8@gmail.com, Keith Busch <kbusch@kernel.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCHv4 3/9] block: export dma_alignment attribute
Message-ID: <Yo8srMJEWkr3JIhe@sol.localdomain>
References: <20220526010613.4016118-1-kbusch@fb.com>
 <20220526010613.4016118-4-kbusch@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220526010613.4016118-4-kbusch@fb.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 25, 2022 at 06:06:07PM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> User space may want to know how to align their buffers to avoid
> bouncing. Export the queue attribute.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>  Documentation/ABI/stable/sysfs-block | 9 +++++++++
>  block/blk-sysfs.c                    | 7 +++++++
>  2 files changed, 16 insertions(+)
> 
> diff --git a/Documentation/ABI/stable/sysfs-block b/Documentation/ABI/stable/sysfs-block
> index e8797cd09aff..08f6d00df138 100644
> --- a/Documentation/ABI/stable/sysfs-block
> +++ b/Documentation/ABI/stable/sysfs-block
> @@ -142,6 +142,15 @@ Description:
>  		Default value of this file is '1'(on).
>  
>  
> +What:		/sys/block/<disk>/queue/dma_alignment
> +Date:		May 2022
> +Contact:	linux-block@vger.kernel.org
> +Description:
> +		Reports the alignment that user space addresses must have to be
> +		used for raw block device access with O_DIRECT and other driver
> +		specific passthrough mechanisms.
> +

Please keep this file in alphabetical order.

- Eric
