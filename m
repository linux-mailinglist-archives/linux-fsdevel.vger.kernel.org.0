Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 413035588BF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jun 2022 21:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbiFWT12 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Jun 2022 15:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230357AbiFWT1G (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Jun 2022 15:27:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CCDE62DC;
        Thu, 23 Jun 2022 11:51:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 34C6BB821D9;
        Thu, 23 Jun 2022 18:51:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D0B8C341C6;
        Thu, 23 Jun 2022 18:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656010273;
        bh=cbD20UwC8oOUpq5UYj5xBgop/ExPATTZ6FsYqYNjLi0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VKT6NC+nP8k5wRC0GlhXy6y6DX7KB7fs606SVycppCPL2vCd5OocUHlWm5lUC0Fn7
         tyaV8Y3JcNuX1LvOOZ6lFqmiG/RzDdXcge0ySuZjK7HjVfVlMtt7LC4ePQRn/uu4a6
         QdZPwg4GiwUGFQkyfP7xNRtA7sdymY0onWh7rKG0yMHZuBJjdA9DFOg7slhP3E+OID
         Lr4RBB9Jj5RVkpSWflzAuENevdnbiEXvRTkAPEkVlHL1GF/AxsU3oitVSviohKKOTI
         e3AdsEEjuzDfzOii4IQC6MEbV/fUZTnmdSyUROsSbnm9/YcHncb4126Owty2uDfJ+j
         mqVjD/KULrh3A==
Date:   Thu, 23 Jun 2022 12:51:08 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Eric Farman <farman@linux.ibm.com>
Cc:     Keith Busch <kbusch@fb.com>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        axboe@kernel.dk, Kernel Team <Kernel-team@fb.com>, hch@lst.de,
        bvanassche@acm.org, damien.lemoal@opensource.wdc.com,
        ebiggers@kernel.org, pankydev8@gmail.com
Subject: Re: [PATCHv6 11/11] iomap: add support for dma aligned direct-io
Message-ID: <YrS2HLsYOe7vnbPG@kbusch-mbp>
References: <20220610195830.3574005-1-kbusch@fb.com>
 <20220610195830.3574005-12-kbusch@fb.com>
 <ab1bc062b4a1d0ad7f974b6068dc3a6dbf624820.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab1bc062b4a1d0ad7f974b6068dc3a6dbf624820.camel@linux.ibm.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 23, 2022 at 02:29:13PM -0400, Eric Farman wrote:
> On Fri, 2022-06-10 at 12:58 -0700, Keith Busch wrote:
> > From: Keith Busch <kbusch@kernel.org>
> > 
> > Use the address alignment requirements from the block_device for
> > direct
> > io instead of requiring addresses be aligned to the block size.
> 
> Hi Keith,
> 
> Our s390 PV guests recently started failing to boot from a -next host,
> and git blame brought me here.
> 
> As near as I have been able to tell, we start tripping up on this code
> from patch 9 [1] that gets invoked with this patch:
> 
> >	for (k = 0; k < i->nr_segs; k++, skip = 0) {
> >		size_t len = i->iov[k].iov_len - skip;
> >
> >		if (len > size)
> >			len = size;
> >		if (len & len_mask)
> >			return false;
> 
> The iovec we're failing on has two segments, one with a len of x200
> (and base of x...000) and another with a len of xe00 (and a base of
> x...200), while len_mask is of course xfff.
> 
> So before I go any further on what we might have broken, do you happen
> to have any suggestions what might be going on here, or something I
> should try?

Thanks for the notice, sorry for the trouble. This check wasn't intended to
have any difference from the previous code with respect to the vector lengths.

Could you tell me if you're accessing this through the block device direct-io,
or through iomap filesystem?
