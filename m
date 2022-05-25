Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05804533ECB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 May 2022 16:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232992AbiEYOIS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 May 2022 10:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241670AbiEYOIQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 May 2022 10:08:16 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5082CA339D;
        Wed, 25 May 2022 07:08:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 45904CE1F7D;
        Wed, 25 May 2022 14:08:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C22ABC385B8;
        Wed, 25 May 2022 14:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653487691;
        bh=M32Cv42KhCgxAYvFmIzz1pJJHtfAIQEzlNRd6Opbuo8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XLTrS3wxdU0a5wLcqXZniXSex5G2wAocUezu9GHouPbd6F6Pvw+ARTOYsvQTJVffv
         Lmt8P1l4hPt3Zm28BPPreduj5MKaqmLkvVJCTivLyenmRj2lgRK7Nw06/79r7Vods2
         fEnA/wEhYRr59I6jXp/Z/OUkMFTLAFnuCK1pBm5zR5YGVQCuC92QHcBxaU114crTW2
         fLeOc144bxljHaD46ap4F50NsmQyBCL7+KPL3cBTXkaRa+bcvcTCCwXCK/OxqlnvaL
         YQ/zM90bWRlcSN66SvcjF7i9JjrL6u4gFFKTkecg2kcSHZcr+if6pp67r13oNjF+sT
         7BmWLUS1Zv4pg==
Date:   Wed, 25 May 2022 08:08:07 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Keith Busch <kbusch@fb.com>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, axboe@kernel.dk,
        Kernel Team <Kernel-team@fb.com>, bvanassche@acm.org,
        damien.lemoal@opensource.wdc.com, ebiggers@kernel.org
Subject: Re: [PATCHv3 5/6] block/bounce: count bytes instead of sectors
Message-ID: <Yo44R5lhdNkZPGjF@kbusch-mbp.dhcp.thefacebook.com>
References: <20220523210119.2500150-1-kbusch@fb.com>
 <20220523210119.2500150-6-kbusch@fb.com>
 <20220524060921.GE24737@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220524060921.GE24737@lst.de>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 24, 2022 at 08:09:21AM +0200, Christoph Hellwig wrote:
> On Mon, May 23, 2022 at 02:01:18PM -0700, Keith Busch wrote:
> > From: Keith Busch <kbusch@kernel.org>
> > 
> > Individual bv_len's may not be a sector size.
> > 
> > Signed-off-by: Keith Busch <kbusch@kernel.org>
> > ---
> >  block/bounce.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/block/bounce.c b/block/bounce.c
> > index 8f7b6fe3b4db..20a43c4dbdda 100644
> > --- a/block/bounce.c
> > +++ b/block/bounce.c
> > @@ -207,17 +207,18 @@ void __blk_queue_bounce(struct request_queue *q, struct bio **bio_orig)
> >  	struct bvec_iter iter;
> >  	unsigned i = 0;
> >  	bool bounce = false;
> > -	int sectors = 0;
> > +	int sectors = 0, bytes = 0;
> >  
> >  	bio_for_each_segment(from, *bio_orig, iter) {
> >  		if (i++ < BIO_MAX_VECS)
> > -			sectors += from.bv_len >> 9;
> > +			bytes += from.bv_len;
> >  		if (PageHighMem(from.bv_page))
> >  			bounce = true;
> >  	}
> >  	if (!bounce)
> >  		return;
> >  
> > +	sectors = ALIGN_DOWN(bytes, queue_logical_block_size(q)) >> 9;
> 
> Same comment about SECTOR_SHIFT and a comment here.  That being said,
> why do we even align here?  Shouldn't bytes always be setor aligned here
> and this should be a WARN_ON or other sanity check?  Probably the same
> for the previous patch.

Yes, the total bytes should be sector aligned.

I'm not exactly sure why we're counting it this way, though. We could just skip
the iterative addition and get the total from bio->bi_iter.bi_size. Unless
bio_orig has more segments that BIO_MAX_VECS, which doesn't seem possible.
