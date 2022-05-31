Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07E19538B71
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 May 2022 08:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244286AbiEaGag (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 May 2022 02:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232025AbiEaGaf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 May 2022 02:30:35 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 211C695DFC;
        Mon, 30 May 2022 23:30:35 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 134AC68AFE; Tue, 31 May 2022 08:30:32 +0200 (CEST)
Date:   Tue, 31 May 2022 08:30:31 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Eric Biggers <ebiggers@kernel.org>, Keith Busch <kbusch@fb.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        axboe@kernel.dk, Kernel Team <Kernel-team@fb.com>, hch@lst.de,
        bvanassche@acm.org, damien.lemoal@opensource.wdc.com,
        pankydev8@gmail.com
Subject: Re: [PATCHv4 8/9] block: relax direct io memory alignment
Message-ID: <20220531063031.GF21098@lst.de>
References: <20220526010613.4016118-1-kbusch@fb.com> <20220526010613.4016118-9-kbusch@fb.com> <Yo8sZWNNTKM2Kwqm@sol.localdomain> <Yo+FtQ8GlHtMT3pT@kbusch-mbp.dhcp.thefacebook.com> <Yo/DYI17KWgXJNyB@sol.localdomain> <Yo/NNiGbnHw/G9Lc@kbusch-mbp.dhcp.thefacebook.com> <Yo/jzEDENPKpD8Al@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yo/jzEDENPKpD8Al@kbusch-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 26, 2022 at 02:32:12PM -0600, Keith Busch wrote:
> On Thu, May 26, 2022 at 12:55:50PM -0600, Keith Busch wrote:
> > 
> > Let me see how difficult it would be catch it early in blkdev_dio_aligned().
> 
> Something like this appears to work:

This looks reasonable to me.  Nits below:

> +	if (!iov_iter_aligned(iter, bdev_dma_alignment(bdev),
> +			      bdev_logical_block_size(bdev) - 1))

This probably wants a helper so that it can also be reused by e.g.
iomap.
