Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B45A22F666
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jul 2020 19:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730657AbgG0RQS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Jul 2020 13:16:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:47900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728021AbgG0RQR (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Jul 2020 13:16:17 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A9042206E7;
        Mon, 27 Jul 2020 17:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595870176;
        bh=7UCQgSoiooCyBil8fOSJp8RobRWZr1sCpOea8qGPx3c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xLeAxijvamdVYBWP2+Xvnj2jRciZbuOyQV+Kr2OvyHP74SUbz5bInn0yjxVioK8iA
         8RWxuGNDB39zHQEMFVvnNN+Y241XtQ8jBcC1cBB46iXnudHmAJqjUxgGzvnF30XsHK
         t5+RylcDIYaB/36yRNq39qkw5MkMKxUWNmCGlon4=
Date:   Mon, 27 Jul 2020 10:16:15 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Satya Tangirala <satyat@google.com>, linux-fscrypt@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: Re: [PATCH v4 3/7] iomap: support direct I/O with fscrypt using
 blk-crypto
Message-ID: <20200727171615.GJ1138@sol.localdomain>
References: <20200722211629.GE2005@dread.disaster.area>
 <20200722223404.GA76479@sol.localdomain>
 <20200723220752.GF2005@dread.disaster.area>
 <20200723230345.GB870@sol.localdomain>
 <20200724013910.GH2005@dread.disaster.area>
 <20200724034628.GC870@sol.localdomain>
 <20200724053130.GO2005@dread.disaster.area>
 <20200724174132.GB819@sol.localdomain>
 <20200725234751.GR2005@dread.disaster.area>
 <20200726024211.GA14321@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200726024211.GA14321@sol.localdomain>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jul 25, 2020 at 07:42:11PM -0700, Eric Biggers wrote:
> > Exactly my point. Requiring infrastructure and storage layers to
> > obey completely new, undefined, undiscoverable, opaque and variable
> > definition of the block devices' "atomic unit of IO", then that's
> > simply a non-starter. That requires a complete re-architecture of
> > the block layers and how things interface and transmit information
> > through them. At minimum, high level IO alignment constraints must
> > be generic and not be hidden in context specific crypto structures.
> 
> Do you have any specific examples in mind of where *encrypted* I/O may broken at
> only a logical_block_size boundary?  Remember that encrypted I/O with a
> particular data_unit_size is only issued if the request_queue has declared that
> it supports encryption with that data_unit_size.  In the case of a layered
> device, that means that every layer would have to opt-into supporting encryption
> as well as the specific data_unit_size.
> 
> Also, the alignment requirement is already passed down the stack as part of the
> bio_crypt_ctx.  If there do turn out to be places that need to use it, we could
> easily define generic helper functions:
> 
> unsigned int bio_required_alignment(struct bio *bio)
> {
>         unsigned int alignmask = queue_logical_block_size(bio->bi_disk->queue) - 1;
> 
> #ifdef CONFIG_BLK_INLINE_ENCRYPTION
>         if (bio->bi_crypt_context)
>                 alignmask |= bio->bi_crypt_context->bc_key->crypto_cfg.data_unit_size - 1;
> #endif
> 
>         return alignmask + 1;
> }
> 
> unsigned int rq_required_alignment(struct request *rq)
> {
>         unsigned int alignmask = queue_logical_block_size(rq->q) - 1;
> 
> #ifdef CONFIG_BLK_INLINE_ENCRYPTION
>         if (rq->crypt_ctx)
>                 alignmask |= rq->crypt_ctx->bc_key->crypto_cfg.data_unit_size - 1;
> #endif
> 
>         return alignmask + 1;
> }
> 
> Sure, we could also add a new alignment_required field to struct bio and struct
> request, but it would be unnecessary since all the information is already there.
> 
> > > Is it your opinion that inline encryption should only be supported when
> > > data_unit_size <= logical_block_size?  The problems with that are
> > 
> > Pretty much.
> > 
> > >     (a) Using an unnecessarily small data_unit_size degrades performance a
> > > 	lot -- for *all* I/O, not just direct I/O.  This is because there are a
> > > 	lot more separate encryptions/decryptions to do, and there's a fixed
> > > 	overhead to each one (much of which is intrinsic in the crypto
> > > 	algorithms themselves, i.e. this isn't simply an implementation quirk).
> > 
> > Performance is irrelevant if correctness is not possible.
> > 
> 
> As far as I know, data_unit_size > logical_block_size is working for everyone
> who has used it so far.
> 
> So again, I'm curious if you have any specific examples in mind.  Is this a
> real-world problem, or just a theoretical case where (in the future) someone
> could declare support for some data_unit_size in their 'struct request_queue'
> (possibly for a layered device) without correctly handling alignment in all
> cases?
> 
> I do see that logical_block_size is used for discard, write_same, and zeroout.
> But that isn't encrypted I/O.
> 
> BTW, there might very well be hardware that *only* supports
> data_unit_size > logical_block_size.

I found get_max_io_size() in block/blk-merge.c.  I'll check if that needs to be
updated.

Let me know if you have any objection to the fscrypt inline encryption patches
*without direct I/O support* going into 5.9.  Note that fscrypt doesn't directly
care about this block layer stuff at all; instead it uses
blk_crypto_config_supported() to check whether inline encryption with the
specified (crypto_mode, data_unit_size, dun_bytes) combination is supported on
the filesystem's device(s).  Only then will fscrypt use inline encryption
instead of the traditional filesystem-layer encryption.

So if blk_crypto_config_supported() is saying that some crypto configuration is
supported when it isn't, then that's a bug in the blk-crypto patches that went
into the block layer in 5.8, which we need to fix there.  (Ideally by fixing any
cases where encrypted I/O may be split in the middle of a data unit.  But in the
worst case, we could easily make blk_crypto_config_supported() return false when
'data_unit_size > logical_block_size' for now.)

- Eric
