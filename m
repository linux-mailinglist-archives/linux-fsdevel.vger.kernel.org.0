Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1CD6563A29
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Jul 2022 21:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231485AbiGAT5A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Jul 2022 15:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbiGAT47 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Jul 2022 15:56:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70C1644A06
        for <linux-fsdevel@vger.kernel.org>; Fri,  1 Jul 2022 12:56:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0B30E621B4
        for <linux-fsdevel@vger.kernel.org>; Fri,  1 Jul 2022 19:56:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE140C3411E;
        Fri,  1 Jul 2022 19:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656705417;
        bh=eMMErDoUkPGsFMBxf9g4jMrG4O2H77+Yx1BMYrhxkBM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cgDl3UhT1RL2ok2ONrGbuKgKM5hboL3WpfRWfOxwNaGB9Nxu4ugfyIwgrwLxrEIyr
         PMOdb2Y69R0JTIg/U7kdlp626Zp1KScf7XP/IP5X2UR9cfEzh48/SI2813Iza4qgUK
         fby8JA5+dNRIKeD9AeGPutOAauc4wLa7MRrgy1pWrpuWDYcRwlqafqkmaz55FbQQPD
         beReQEPN02xPNIBdmgyvOfgVMzqe5qRPzvn648BETtN2Kpp4hepWZscYUQtDFoGjZ5
         3erXqr8GAmrGmKceZok5CDD2JjOVuFE83ZOGPAwwIpaic5fDxNhYMIHuo+7+8fzG5v
         NVLbkjBetW8sA==
Date:   Fri, 1 Jul 2022 13:56:53 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [block.git conflicts] Re: [PATCH 37/44] block: convert to
 advancing variants of iov_iter_get_pages{,_alloc}()
Message-ID: <Yr9Rhem4LH3i978m@kbusch-mbp.dhcp.thefacebook.com>
References: <Yr4mKJvzdrUsssTh@ZenIV>
 <Yr5W3G19zUQuCA7R@kbusch-mbp.dhcp.thefacebook.com>
 <Yr8xmNMEOJke6NOx@ZenIV>
 <Yr80qNeRhFtPb/f3@kbusch-mbp.dhcp.thefacebook.com>
 <Yr838ci8FUsiZlSW@ZenIV>
 <Yr85AaNqNAEr+5ve@ZenIV>
 <Yr8/LLXaEIa7KPDT@kbusch-mbp.dhcp.thefacebook.com>
 <Yr9GNfmeO/xCjzD4@ZenIV>
 <Yr9KzV6u2iTPPQmq@kbusch-mbp.dhcp.thefacebook.com>
 <Yr9OZJ9Usn24XYFG@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yr9OZJ9Usn24XYFG@ZenIV>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 01, 2022 at 08:43:32PM +0100, Al Viro wrote:
> On Fri, Jul 01, 2022 at 01:28:13PM -0600, Keith Busch wrote:
> > On Fri, Jul 01, 2022 at 08:08:37PM +0100, Al Viro wrote:
> > > On Fri, Jul 01, 2022 at 12:38:36PM -0600, Keith Busch wrote:
> > > > >  	size = iov_iter_get_pages(iter, pages, LONG_MAX, nr_pages, &offset);
> > > > > -	if (size > 0)
> > > > > -		size = ALIGN_DOWN(size, bdev_logical_block_size(bio->bi_bdev));
> > > > >  	if (unlikely(size <= 0))
> > > > >  		return size ? size : -EFAULT;
> > > > > +	nr_pages = DIV_ROUND_UP(offset + size, PAGE_SIZE);
> > > > >  
> > > > > +	size = ALIGN_DOWN(size, bdev_logical_block_size(bio->bi_bdev));
> > > > 
> > > > We still need to return EFAULT if size becomes 0 because that's the only way
> > > > bio_iov_iter_get_pages()'s loop will break out in this condition.
> > > 
> > > I really don't like these calling conventions ;-/
> > 
> > No argument here; I'm just working in the space as I found it. :)
> >  
> > > What do you want to happen if we have that align-down to reduce size?
> > > IOW, what should be the state after that loop in the caller?
> > 
> > We fill up the bio to bi_max_vecs. If there are more pages than vectors, then
> > the bio is submitted as-is with the partially drained iov_iter. The remainder
> > of the iov is left for a subsequent bio to deal with.
> > 
> > The ALIGN_DOWN is required because I've replaced the artificial kernel aligment
> > with the underlying hardware's alignment. The hardware's alignment is usually
> > smaller than a block size. If the last bvec has a non-block aligned offset,
> > then it has to be truncated down, which could result in a 0 size when bi_vcnt
> > is already non-zero. If that happens, we just submit the bio as-is, and
> > allocate a new one to deal with the rest of the iov.
> 
> Wait a sec.  Looks like you are dealing with the round-down in the wrong place -
> it applies to the *total* you've packed into the bio, no matter how it is
> distributed over the segments you've gathered it from.  Looks like it would
> be more natural to handle it after the loop in the caller, would it not?
> 
> I.e.
> 	while bio is not full
> 		grab pages
> 		if got nothing
> 			break
> 		pack pages into bio
> 		if can't add a page (bio_add_hw_page() failure)
> 			drop the ones not shoved there
> 			break
> 	see how much had we packed into the sucker
> 	if not a multiple of logical block size
> 		trim the bio, dropping what needs to be dropped
> 		iov_iter_revert()
> 	if nothing's packed
> 		return -EINVAL if it was a failed bio_add_hw_page()
> 		return -EFAULT otherwise
> 	return 0

Validating user requests gets really messy if we allow arbitrary segment
lengths. This particular patch just enables arbitrary address alignment, but
segment size is still required to be a block size. You found the commit that
enforces that earlier, "iov: introduce iov_iter_aligned", two commits prior.

The rest of the logic simplifies when we are guaranteed segment size is a block
size mulitple: truncating a segment at a block boundary ensures both sides are
block size aligned, and we don't even need to consult lower level queue limits,
like segment count or segment length. The bio is valid after this step, and can
be split into valid bios later if needed.
