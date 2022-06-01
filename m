Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E085D53A937
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Jun 2022 16:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355030AbiFAO3U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Jun 2022 10:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355026AbiFAO3K (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Jun 2022 10:29:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 075F8338BC;
        Wed,  1 Jun 2022 07:28:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B53C3B81AFD;
        Wed,  1 Jun 2022 14:28:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 726A0C385B8;
        Wed,  1 Jun 2022 14:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654093715;
        bh=Ec+zMVVKrO00wokaNCpHD7B2w9xPUMaWVPh3i5kRk/k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HQMzxI85XfijhGCJjmQB3WIT5rNx6fMwGub/IZd5uRVMkJ4POuA5V2GYRreQfi5V3
         Gv9KgKeR7hO/S9+i7QOcekhbAEY0SEmks6JMIqFOQb+jk0PxtqefWvXxoy1tsoebUO
         rQKOlA4Gvu1nWUQQrbPyrN4iVpR9WXuZRxYlAEJxFJWtOUM1DHBknDgbcu1gFi65PL
         /JuLOlIV7t94R1CF5VdBr0aGP5PUHSjMIc6YK0COHtQWaftZdaZ0hR/eaXb0A4h3NV
         ty7YXBL8VtTFJxURMBmem7iU0O/UbwSHZq0neEpjGH2EbfnTaQxk5dtaCiB85YYLQa
         xXzNmNSIzxk8Q==
Date:   Wed, 1 Jun 2022 08:28:31 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Keith Busch <kbusch@fb.com>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        axboe@kernel.dk, Kernel Team <Kernel-team@fb.com>, hch@lst.de,
        bvanassche@acm.org, damien.lemoal@opensource.wdc.com,
        pankydev8@gmail.com
Subject: Re: [PATCHv5 00/11] direct-io dma alignment
Message-ID: <Ypd3j9ABXhIuQDbt@kbusch-mbp.dhcp.thefacebook.com>
References: <20220531191137.2291467-1-kbusch@fb.com>
 <YpcRLKwZpN+NQRxn@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YpcRLKwZpN+NQRxn@sol.localdomain>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 01, 2022 at 12:11:40AM -0700, Eric Biggers wrote:
> On Tue, May 31, 2022 at 12:11:26PM -0700, Keith Busch wrote:
> > From: Keith Busch <kbusch@kernel.org>
> > 
> > The most significant change from v4 is the alignment is now checked
> > prior to building the bio. This gets the expected EINVAL error for
> > misaligned userspace iovecs in all cases now (Eric Biggers).
> > 
> > I've removed the legacy fs change, so only iomap filesystems get to use
> > this alignement capability (Christoph Hellwig).
> > 
> > The block fops check for alignment returns a bool now (Damien).
> > 
> > Adjusted some comments, docs, and other minor style issues.
> > 
> > Reviews added for unchanged or trivially changed patches, removed
> > reviews for ones that changed more significantly.
> > 
> > As before, I tested using 'fio' with forced misaligned user buffers on
> > raw block, xfs, and ext4 (example raw block profile below).
> > 
> 
> I still don't think you've taken care of all the assumptions that bv_len is a
> multiple of logical block size, or at least SECTOR_SIZE.  Try this:
> 
> 	git grep -E 'bv_len (>>|/)'

There are only 8 drivers that set the request_queue's dma alignment, which are
the only ones that could be affected from this patch series. The drivers
returned from the above don't set dma alignment, so they're fine to assume
those lengths.

I don't think the above query captures enough since it misses things like
nfhd_submit_bio() that shifts 9 on the following line. Not that that example
matters either for the same reason.
 
> Also:
> 
> 	git grep '<.*bv_len;'
>
> Also take a look at bio_for_each_segment(), specifically how iter->bi_sector is
> updated.

I'm not finding any driver user of this macro that's set the dma alignment
where this would break. They either never set it, or they're stacking drivers
that always get the safe default.

Outside drivers, blk-integrity doesn't operate on sector lengths, so that's
fine, and blk-crypto would prevent such unalignment much earlier. And btrfs
bounces this type of direct IO, so that's also fine.

Even if we assume all the existing users are safe, I suppose we could say this
type of assumption is potentially fragile. For example, I think drivers like
pmem or null_blk could readily reduce their queue's dma alignment limit, but
that may break their current usage.
