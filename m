Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77F88533DFF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 May 2022 15:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242149AbiEYNhz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 May 2022 09:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231968AbiEYNhx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 May 2022 09:37:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A37E6BFD9;
        Wed, 25 May 2022 06:37:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B7C38B81D99;
        Wed, 25 May 2022 13:37:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93C71C34117;
        Wed, 25 May 2022 13:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653485869;
        bh=xlUASOGBdGw6fvHq4BDNMenv9iWftkupHWxoGxdfLaw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eE28Gc/PPxzo7SmaqHsc80YkSvcgEe/itl6cQrG/3QpssQkcnYHDGOXl+slhMlm7q
         zcpWmuSWKAyaJKTcRh5SRNz8n0dUeKH1RgxmPcixzUYsmaGIjoae7unscy85w7rCcR
         nuXh1fdaroFusYK9lbpZZ6sJxDFE8XShoa4Ga7nxP1tIBMIzxhJYBl+X7QwqB1hBf2
         ZN08pUufYR8X4ycr3pcd/BnZJp/2vGtwx97d3SYjIwzYY1pct9lfztsdG+r/aSnj/s
         f5rzOK9B+poekFzTHVGZAEPnr+0JH0lgsw0aaH7u/BpiSvanJ0m+Bk3haO2emQqHUp
         jRdA5R7pVP/AA==
Date:   Wed, 25 May 2022 07:37:45 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Pankaj Raghav <pankydev8@gmail.com>
Cc:     Keith Busch <kbusch@fb.com>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, axboe@kernel.dk,
        Kernel Team <Kernel-team@fb.com>, hch@lst.de,
        bvanassche@acm.org, damien.lemoal@opensource.wdc.com,
        ebiggers@kernel.org, Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCHv3 1/6] block/bio: remove duplicate append pages code
Message-ID: <Yo4xKSEI9Kh93gtf@kbusch-mbp.dhcp.thefacebook.com>
References: <20220523210119.2500150-1-kbusch@fb.com>
 <20220523210119.2500150-2-kbusch@fb.com>
 <20220524141754.msmt6s4spm4istsb@quentin>
 <Yoz7+O2CAQTNfvlV@kbusch-mbp.dhcp.thefacebook.com>
 <20220525074941.2biavbbrjdjcnlsd@quentin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220525074941.2biavbbrjdjcnlsd@quentin>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 25, 2022 at 09:49:41AM +0200, Pankaj Raghav wrote:
> On Tue, May 24, 2022 at 09:38:32AM -0600, Keith Busch wrote:
> > On Tue, May 24, 2022 at 04:17:54PM +0200, Pankaj Raghav wrote:
> > > On Mon, May 23, 2022 at 02:01:14PM -0700, Keith Busch wrote:
> > > > -	if (WARN_ON_ONCE(!max_append_sectors))
> > > > -		return 0;
> > > I don't see this check in the append path. Should it be added in
> > > bio_iov_add_zone_append_page() function?
> > 
> > I'm not sure this check makes a lot of sense. If it just returns 0 here, then
> > won't that get bio_iov_iter_get_pages() stuck in an infinite loop? The bio
> > isn't filling, the iov isn't advancing, and 0 indicates keep-going.
> Yeah but if max_append_sectors is zero, then bio_add_hw_page() also
> returns 0 as follows:
> ....
> 	if (((bio->bi_iter.bi_size + len) >> 9) > max_sectors)
> 		return 0;
> ....
> With WARN_ON_ONCE, we at least get a warning message if it gets stuck in an
> infinite loop because of max_append_sectors being zero right?

The return for this function is the added length, not an indicator of success.
And we already handle '0' as an error from bio_iov_add_zone_append_page():

	if (bio_add_hw_page(q, bio, page, len, offset,
			queue_max_zone_append_sectors(q), &same_page) != len)
		return -EINVAL;
