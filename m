Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65FAF533EF1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 May 2022 16:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234522AbiEYORi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 May 2022 10:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231388AbiEYORh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 May 2022 10:17:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3262C9B197;
        Wed, 25 May 2022 07:17:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BFCB261958;
        Wed, 25 May 2022 14:17:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A586C385B8;
        Wed, 25 May 2022 14:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653488255;
        bh=1yp5Ble5uDzfuesJi+POU3g1TE1Jb6FNCYTMfPzNmcw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tyiG/jb+v5KsE13rf/3eqQBcxUeMEkdLI7hTTEjhKPxvNftQNpKccqD2odHQPWagR
         CwbCw+c/hyfopEDsSZsXvEoQqvgjWcDXSdGP4Wwaa3dM5qu9BGVJ+O8pY2kLbtRh8Y
         f9ZvWHCDwEMZbwr0vZM9RHlxvMyX4CM+rPE77yZvTr2zN2INPTY2W6ByZ+Tf4z1e3n
         /m96Zbgd6fHAMVwKb2VmS7FLOluQuc9yA/25Dyy2A4qvehV+IljpeD3j2MX8Wo5XkL
         OUUDvOjkP2D8QYera0mNafm3RIiNyrl+R3vLHPxYh9SLMh9ej9WRTLQWTmiCkLWy3k
         VgvKkhoc9Oyzg==
Date:   Wed, 25 May 2022 08:17:29 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Keith Busch <kbusch@fb.com>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, axboe@kernel.dk,
        Kernel Team <Kernel-team@fb.com>, bvanassche@acm.org,
        damien.lemoal@opensource.wdc.com, ebiggers@kernel.org
Subject: Re: [PATCHv3 5/6] block/bounce: count bytes instead of sectors
Message-ID: <Yo46eYw1oyq/h5BN@kbusch-mbp.dhcp.thefacebook.com>
References: <20220523210119.2500150-1-kbusch@fb.com>
 <20220523210119.2500150-6-kbusch@fb.com>
 <20220524060921.GE24737@lst.de>
 <Yo44R5lhdNkZPGjF@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yo44R5lhdNkZPGjF@kbusch-mbp.dhcp.thefacebook.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 25, 2022 at 08:08:07AM -0600, Keith Busch wrote:
> On Tue, May 24, 2022 at 08:09:21AM +0200, Christoph Hellwig wrote:
> > >  	bio_for_each_segment(from, *bio_orig, iter) {
> > >  		if (i++ < BIO_MAX_VECS)
> > > -			sectors += from.bv_len >> 9;
> > > +			bytes += from.bv_len;
> > >  		if (PageHighMem(from.bv_page))
> > >  			bounce = true;
> > >  	}
> > >  	if (!bounce)
> > >  		return;
> > >  
> > > +	sectors = ALIGN_DOWN(bytes, queue_logical_block_size(q)) >> 9;
> > 
> > Same comment about SECTOR_SHIFT and a comment here.  That being said,
> > why do we even align here?  Shouldn't bytes always be setor aligned here
> > and this should be a WARN_ON or other sanity check?  Probably the same
> > for the previous patch.
> 
> Yes, the total bytes should be sector aligned.
> 
> I'm not exactly sure why we're counting it this way, though. We could just skip
> the iterative addition and get the total from bio->bi_iter.bi_size. Unless
> bio_orig has more segments that BIO_MAX_VECS, which doesn't seem possible.

Oh, there's a comment explaining the original can have more than BIO_MAX_VECS,
so the ALIGN_DOWN is necessary to ensure a logical block sized split.
