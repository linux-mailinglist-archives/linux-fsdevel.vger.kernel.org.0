Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 458495800EE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Jul 2022 16:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234315AbiGYOrC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Jul 2022 10:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiGYOrB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Jul 2022 10:47:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9243C13F1A;
        Mon, 25 Jul 2022 07:47:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3D037B80DE9;
        Mon, 25 Jul 2022 14:46:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12A5DC341C6;
        Mon, 25 Jul 2022 14:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658760418;
        bh=PZKVLgIIqdh9g4wPfJ5NHR7BP7/xQGyMshytByH1RJM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dmS4DNDrLhJ9CA/GNgiKyZDaLdV2ZqESyyBrwX5Anr3zbwmlC1Amcvm+cxJKZtQFf
         A5qRBVTOO0svm8DcPHWQREspfRrbKbEnZaPgemr6LNsWMT+YMiL6DO/VXbgLE7Siq1
         jB1WtmFqomimhIRA2JXinRRzjMeQg4LHCNjMDGFty2LHhtLN+XrYTQULac6rfd1HnR
         wqs8aa3KpPYNMU/iS8RU7gujJmvwcZei2+8mgr4biHSxlEDfK/fEJMBQrg4Ov6WQMn
         Xd6uKDKNKxDjF4h0wpfyPRjUbewJEUxWHeQ+ESR7RovV5uy1MEdFVZMXmtuwup6PpK
         gelQyAxIBu9xQ==
Date:   Mon, 25 Jul 2022 08:46:54 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Keith Busch <kbusch@fb.com>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        axboe@kernel.dk, Kernel Team <Kernel-team@fb.com>, hch@lst.de,
        damien.lemoal@opensource.wdc.com, ebiggers@kernel.org,
        pankydev8@gmail.com, Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCHv6 07/11] block/bounce: count bytes instead of sectors
Message-ID: <Yt6s3uh5UijlYACV@kbusch-mbp.dhcp.thefacebook.com>
References: <20220610195830.3574005-1-kbusch@fb.com>
 <20220610195830.3574005-8-kbusch@fb.com>
 <a1cceb79-c72c-5a76-ed7a-156c09505692@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1cceb79-c72c-5a76-ed7a-156c09505692@acm.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 22, 2022 at 03:01:06PM -0700, Bart Van Assche wrote:
> On 6/10/22 12:58, Keith Busch wrote:
> > From: Keith Busch <kbusch@kernel.org>
> > 
> > Individual bv_len's may not be a sector size.
> > 
> > Signed-off-by: Keith Busch <kbusch@kernel.org>
> > Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> > Reviewed-by: Pankaj Raghav <p.raghav@samsung.com>
> > ---
> >   block/bounce.c | 13 ++++++++++---
> >   1 file changed, 10 insertions(+), 3 deletions(-)
> > 
> > diff --git a/block/bounce.c b/block/bounce.c
> > index 8f7b6fe3b4db..fbadf179601f 100644
> > --- a/block/bounce.c
> > +++ b/block/bounce.c
> > @@ -205,19 +205,26 @@ void __blk_queue_bounce(struct request_queue *q, struct bio **bio_orig)
> >   	int rw = bio_data_dir(*bio_orig);
> >   	struct bio_vec *to, from;
> >   	struct bvec_iter iter;
> > -	unsigned i = 0;
> > +	unsigned i = 0, bytes = 0;
> >   	bool bounce = false;
> > -	int sectors = 0;
> > +	int sectors;
> >   	bio_for_each_segment(from, *bio_orig, iter) {
> >   		if (i++ < BIO_MAX_VECS)
> > -			sectors += from.bv_len >> 9;
> > +			bytes += from.bv_len;
> >   		if (PageHighMem(from.bv_page))
> >   			bounce = true;
> >   	}
> >   	if (!bounce)
> >   		return;
> > +	/*
> > +	 * Individual bvecs might not be logical block aligned. Round down
> > +	 * the split size so that each bio is properly block size aligned,
> > +	 * even if we do not use the full hardware limits.
> > +	 */
> > +	sectors = ALIGN_DOWN(bytes, queue_logical_block_size(q)) >>
> > +			SECTOR_SHIFT;
> >   	if (sectors < bio_sectors(*bio_orig)) {
> >   		bio = bio_split(*bio_orig, sectors, GFP_NOIO, &bounce_bio_split);
> >   		bio_chain(bio, *bio_orig);
> 
> Do I see correctly that there are two changes in this patch: counting bytes
> instead of sectors and also splitting at logical block boundaries instead of
> a 512-byte boundary? Should this patch perhaps be split?

The code previously would only split on a bvec boundary. All bvecs were logical
block sized, so that part is not changing. We just needed to be able to split
mid-bvec since the series enables unaligned offsets to match hardware
capabilities.
