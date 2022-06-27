Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94F3B55CA1D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jun 2022 14:57:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238761AbiF0PhN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Jun 2022 11:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238819AbiF0PhE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Jun 2022 11:37:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 512551AD92;
        Mon, 27 Jun 2022 08:37:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 09C11B8187D;
        Mon, 27 Jun 2022 15:37:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93DFCC3411D;
        Mon, 27 Jun 2022 15:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656344220;
        bh=CuWQqDJRWxJQ6RoyWnytqv86/5mnNlfI8V08ozRBjFI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cTyii0/1g8OM0TNyfu2I1K6ecK0kjKlapjUP1nhlKneu1qzZn+cM4GzTZsKO08b32
         fOldkFG8sR3Ggx0khePLHV63JLu+VXzpLZn3/mTD8Cm1pSaNzLoKO60o/7Xrkk6p92
         9ejBxUWiEoUoWj3ImtuJMh4UmBU0i3n+fFqOIKzaBovRZj1r74so+mqbH/C7OV9BNL
         TUVCP76VntSyT9KLb+Nna9QYxXCW85vDcOFey31DbB9TsyYdzgkJBlkOnD6k/qXTT5
         LsCcyxad+npePYbFp6JHYUBqEKF8i95hI6ywxRoiJ3zURfRE9IS2ur7tH15Uennbdz
         seaO7RMKDoSSw==
Date:   Mon, 27 Jun 2022 09:36:56 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Eric Farman <farman@linux.ibm.com>
Cc:     Keith Busch <kbusch@fb.com>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        axboe@kernel.dk, Kernel Team <Kernel-team@fb.com>, hch@lst.de,
        bvanassche@acm.org, damien.lemoal@opensource.wdc.com,
        ebiggers@kernel.org, pankydev8@gmail.com,
        Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCHv6 11/11] iomap: add support for dma aligned direct-io
Message-ID: <YrnOmOUPukGe8xCq@kbusch-mbp.dhcp.thefacebook.com>
References: <20220610195830.3574005-1-kbusch@fb.com>
 <20220610195830.3574005-12-kbusch@fb.com>
 <ab1bc062b4a1d0ad7f974b6068dc3a6dbf624820.camel@linux.ibm.com>
 <YrS2HLsYOe7vnbPG@kbusch-mbp>
 <YrS6/chZXbHsrAS8@kbusch-mbp>
 <e2b08a5c452d4b8322566cba4ed33b58080f03fa.camel@linux.ibm.com>
 <e0038866ac54176beeac944c9116f7a9bdec7019.camel@linux.ibm.com>
 <c5affe3096fd7b7996cb5fbcb0c41bbf3dde028e.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5affe3096fd7b7996cb5fbcb0c41bbf3dde028e.camel@linux.ibm.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 27, 2022 at 11:21:20AM -0400, Eric Farman wrote:
> 
> Apologies, it took me an extra day to get back to this, but it is
> indeed this pass through that's causing our boot failures. I note that
> the old code (in iomap_dio_bio_iter), did:
> 
>         if ((pos | length | align) & ((1 << blkbits) - 1))
>                 return -EINVAL;
> 
> With blkbits equal to 12, the resulting mask was 0x0fff against an
> align value (from iov_iter_alignment) of x200 kicks us out.
> 
> The new code (in iov_iter_aligned_iovec), meanwhile, compares this:
> 
>                 if ((unsigned long)(i->iov[k].iov_base + skip) &
> addr_mask)
>                         return false;
> 
> iov_base (and the output of the old iov_iter_aligned_iovec() routine)
> is x200, but since addr_mask is x1ff this check provides a different
> response than it used to.
> 
> To check this, I changed the comparator to len_mask (almost certainly
> not the right answer since addr_mask is then unused, but it was good
> for a quick test), and our PV guests are able to boot again with -next
> running in the host.

This raises more questions for me. It sounds like your process used to get an
EINVAL error, and it wants to continue getting an EINVAL error instead of
letting the direct-io request proceed. Is that correct? If so, could you
provide more details on what issue occurs with dispatching this request?

If you really need to restrict address' alignment to the storage's logical
block size, I think your storage driver needs to set the dma_alignment queue
limit to that value.
