Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 963AD55F498
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jun 2022 05:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbiF2DwN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jun 2022 23:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiF2DwM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jun 2022 23:52:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C2325C53;
        Tue, 28 Jun 2022 20:52:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0D7ABB82142;
        Wed, 29 Jun 2022 03:52:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC645C34114;
        Wed, 29 Jun 2022 03:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656474727;
        bh=g4zzHulG7GEAulCIuTQXR87g3faKAviePs7vVysrZVY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CU/JyhXgpmfz4YLj08Kz1NhuQAAHT1lu62q+NTk66UWeOLW1EmysLLkGr+PTLWM8T
         tNvO+mKZsiPMrRo3ZcC3PCAKkmfJQwsAUINx4frjPs1pz9P42zbm3IHzKF+p88kPhP
         Lp095hZbD9frg2rlaIGrJmHHiU4/MpO2S/Kzx7gBhyl8tQVovjqE9iL7cSJ7uORQLV
         w4Ttw3mzCDfXzoYWXf+W49fTAk6rwRDqlnWHNEVFmLlOJTnXUvDdjnb4K2mAgEl2vS
         58riKEzOHtZOHhWEeegTuuYjztX9JgK1KIrmnx+h9OTxApVzbTLJQ6gwCdwtM7ykKh
         eE4ridlaUcK2w==
Date:   Tue, 28 Jun 2022 21:52:03 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Eric Farman <farman@linux.ibm.com>
Cc:     Halil Pasic <pasic@linux.ibm.com>, Keith Busch <kbusch@fb.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        axboe@kernel.dk, Kernel Team <Kernel-team@fb.com>, hch@lst.de,
        bvanassche@acm.org, damien.lemoal@opensource.wdc.com,
        ebiggers@kernel.org, pankydev8@gmail.com
Subject: Re: [PATCHv6 11/11] iomap: add support for dma aligned direct-io
Message-ID: <YrvMY7oPnhIka4IF@kbusch-mbp.dhcp.thefacebook.com>
References: <ab1bc062b4a1d0ad7f974b6068dc3a6dbf624820.camel@linux.ibm.com>
 <YrS2HLsYOe7vnbPG@kbusch-mbp>
 <YrS6/chZXbHsrAS8@kbusch-mbp>
 <e2b08a5c452d4b8322566cba4ed33b58080f03fa.camel@linux.ibm.com>
 <e0038866ac54176beeac944c9116f7a9bdec7019.camel@linux.ibm.com>
 <c5affe3096fd7b7996cb5fbcb0c41bbf3dde028e.camel@linux.ibm.com>
 <YrnOmOUPukGe8xCq@kbusch-mbp.dhcp.thefacebook.com>
 <20220628110024.01fcf84f.pasic@linux.ibm.com>
 <83e65083890a7ac9c581c5aee0361d1b49e6abd9.camel@linux.ibm.com>
 <a765fff67679155b749aafa90439b46ab1269a64.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a765fff67679155b749aafa90439b46ab1269a64.camel@linux.ibm.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 28, 2022 at 11:18:34PM -0400, Eric Farman wrote:
> Sort of. In the working case, I see a set of iovecs come through with
> different counts:
> 
> base	count
> 0000	0001
> 0000	0200
> 0000	0400
> 0000	0800
> 0000	1000
> 0001	1000
> 0200	1000 << Change occurs here
> 0400	1000
> 0800	1000
> 1000	1000
> 
> EINVAL was being returned for any of these iovecs except the page-
> aligned ones. Once the x200 request returns 0, the remainder of the
> above list was skipped and the requests continue elsewhere on the file.
> 
> Still not sure how our request is getting us into this process. We're
> simply asking to read a single block, but that's somewhere within an
> image file.

I thought this was sounding like some kind of corruption. I tested ext4 on
various qemu devices with 4k logical block sizes, and it all looks okay there.

What block driver are you observing this with?
