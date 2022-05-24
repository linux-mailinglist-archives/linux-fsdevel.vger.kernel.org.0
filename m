Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B0985322DB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 May 2022 08:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234721AbiEXGJ0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 May 2022 02:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232516AbiEXGJZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 May 2022 02:09:25 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 321CA6A07A;
        Mon, 23 May 2022 23:09:24 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8F7C368AFE; Tue, 24 May 2022 08:09:21 +0200 (CEST)
Date:   Tue, 24 May 2022 08:09:21 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Keith Busch <kbusch@fb.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        axboe@kernel.dk, Kernel Team <Kernel-team@fb.com>, hch@lst.de,
        bvanassche@acm.org, damien.lemoal@opensource.wdc.com,
        ebiggers@kernel.org, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv3 5/6] block/bounce: count bytes instead of sectors
Message-ID: <20220524060921.GE24737@lst.de>
References: <20220523210119.2500150-1-kbusch@fb.com> <20220523210119.2500150-6-kbusch@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220523210119.2500150-6-kbusch@fb.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 23, 2022 at 02:01:18PM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Individual bv_len's may not be a sector size.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>  block/bounce.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/block/bounce.c b/block/bounce.c
> index 8f7b6fe3b4db..20a43c4dbdda 100644
> --- a/block/bounce.c
> +++ b/block/bounce.c
> @@ -207,17 +207,18 @@ void __blk_queue_bounce(struct request_queue *q, struct bio **bio_orig)
>  	struct bvec_iter iter;
>  	unsigned i = 0;
>  	bool bounce = false;
> -	int sectors = 0;
> +	int sectors = 0, bytes = 0;
>  
>  	bio_for_each_segment(from, *bio_orig, iter) {
>  		if (i++ < BIO_MAX_VECS)
> -			sectors += from.bv_len >> 9;
> +			bytes += from.bv_len;
>  		if (PageHighMem(from.bv_page))
>  			bounce = true;
>  	}
>  	if (!bounce)
>  		return;
>  
> +	sectors = ALIGN_DOWN(bytes, queue_logical_block_size(q)) >> 9;

Same comment about SECTOR_SHIFT and a comment here.  That being said,
why do we even align here?  Shouldn't bytes always be setor aligned here
and this should be a WARN_ON or other sanity check?  Probably the same
for the previous patch.
