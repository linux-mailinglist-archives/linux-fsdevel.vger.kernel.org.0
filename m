Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D26E35322D8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 May 2022 08:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234706AbiEXGIC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 May 2022 02:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232516AbiEXGIA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 May 2022 02:08:00 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBDCC6A07A;
        Mon, 23 May 2022 23:07:58 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 29D0568AFE; Tue, 24 May 2022 08:07:55 +0200 (CEST)
Date:   Tue, 24 May 2022 08:07:55 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Keith Busch <kbusch@fb.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        axboe@kernel.dk, Kernel Team <Kernel-team@fb.com>, hch@lst.de,
        bvanassche@acm.org, damien.lemoal@opensource.wdc.com,
        ebiggers@kernel.org, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv3 4/6] block/merge: count bytes instead of sectors
Message-ID: <20220524060754.GD24737@lst.de>
References: <20220523210119.2500150-1-kbusch@fb.com> <20220523210119.2500150-5-kbusch@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220523210119.2500150-5-kbusch@fb.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 23, 2022 at 02:01:17PM -0700, Keith Busch wrote:
> +	const unsigned max_bytes = get_max_io_size(q, bio) << 9;

> +	return bio_split(bio, bytes >> 9, GFP_NOIO, bs);

These should use SECTOR_SHIFT.

>  split:
>  	*segs = nsegs;
> +	bytes = ALIGN_DOWN(bytes, queue_logical_block_size(q));

Please add a comment explaining the added alignment here.
