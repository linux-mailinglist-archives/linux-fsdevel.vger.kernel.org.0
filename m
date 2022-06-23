Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 795F15588FA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jun 2022 21:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbiFWTdQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Jun 2022 15:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232273AbiFWTcx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Jun 2022 15:32:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 042E05DF01;
        Thu, 23 Jun 2022 12:12:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8FE1660DE1;
        Thu, 23 Jun 2022 19:12:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB333C341C0;
        Thu, 23 Jun 2022 19:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656011520;
        bh=2vFS5ecHYj7lFUc7JnMpmVqJneVrPDUFMqR3YyGroMQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dglapzEvUizu4TJLaOScyRQb674dhVNYAwjiELs76w3pGcYX8SsrULa3MSpyJZWjK
         oG5vwu/O8N4r5pTVvFrdw4knikfA3RoLKzIDn1FHYLSz9F22Me7u9O2Y7m5fzr/gta
         4rYtJZDLSInC7tRUjsJKjTbGZJzNLZWdVg37zh0RJ7k2lbJb9vtYdlGPid0w2d3meJ
         UATjOKK5xij1Oii0yIF8aNW8gBkiP6H7rI+xVIyfTjTxrFXGiH94XcXAXmGVUzrMwO
         ruCxSPhOTaKCFakDxlc9AN8MexKuBY+8GzRYiA5qBYzRhy6/e4vNdzaAYmeXW4JwwL
         vXFky3n51iGVg==
Date:   Thu, 23 Jun 2022 13:11:57 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Eric Farman <farman@linux.ibm.com>
Cc:     Keith Busch <kbusch@fb.com>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        axboe@kernel.dk, Kernel Team <Kernel-team@fb.com>, hch@lst.de,
        bvanassche@acm.org, damien.lemoal@opensource.wdc.com,
        ebiggers@kernel.org, pankydev8@gmail.com
Subject: Re: [PATCHv6 11/11] iomap: add support for dma aligned direct-io
Message-ID: <YrS6/chZXbHsrAS8@kbusch-mbp>
References: <20220610195830.3574005-1-kbusch@fb.com>
 <20220610195830.3574005-12-kbusch@fb.com>
 <ab1bc062b4a1d0ad7f974b6068dc3a6dbf624820.camel@linux.ibm.com>
 <YrS2HLsYOe7vnbPG@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YrS2HLsYOe7vnbPG@kbusch-mbp>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 23, 2022 at 12:51:08PM -0600, Keith Busch wrote:
> On Thu, Jun 23, 2022 at 02:29:13PM -0400, Eric Farman wrote:
> > On Fri, 2022-06-10 at 12:58 -0700, Keith Busch wrote:
> > > From: Keith Busch <kbusch@kernel.org>
> > > 
> > > Use the address alignment requirements from the block_device for
> > > direct
> > > io instead of requiring addresses be aligned to the block size.
> > 
> > Hi Keith,
> > 
> > Our s390 PV guests recently started failing to boot from a -next host,
> > and git blame brought me here.
> > 
> > As near as I have been able to tell, we start tripping up on this code
> > from patch 9 [1] that gets invoked with this patch:
> > 
> > >	for (k = 0; k < i->nr_segs; k++, skip = 0) {
> > >		size_t len = i->iov[k].iov_len - skip;
> > >
> > >		if (len > size)
> > >			len = size;
> > >		if (len & len_mask)
> > >			return false;
> > 
> > The iovec we're failing on has two segments, one with a len of x200
> > (and base of x...000) and another with a len of xe00 (and a base of
> > x...200), while len_mask is of course xfff.
> > 
> > So before I go any further on what we might have broken, do you happen
> > to have any suggestions what might be going on here, or something I
> > should try?
> 
> Thanks for the notice, sorry for the trouble. This check wasn't intended to
> have any difference from the previous code with respect to the vector lengths.
> 
> Could you tell me if you're accessing this through the block device direct-io,
> or through iomap filesystem?

If using iomap, the previous check was this:

	unsigned int blkbits = blksize_bits(bdev_logical_block_size(iomap->bdev));
	unsigned int align = iov_iter_alignment(dio->submit.iter);
	...
	if ((pos | length | align) & ((1 << blkbits) - 1))
		return -EINVAL;

And if raw block device, it was this:

	if ((pos | iov_iter_alignment(iter)) &
	    (bdev_logical_block_size(bdev) - 1))
		return -EINVAL;

The result of "iov_iter_alignment()" would include "0xe00 | 0x200" in your
example, and checked against 0xfff should have been failing prior to this
patch. Unless I'm missing something...
