Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 192D4741BC9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jun 2023 00:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbjF1Wlq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 18:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjF1Wli (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 18:41:38 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D56A8271B
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jun 2023 15:41:32 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-262e04a6f66so43434a91.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jun 2023 15:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1687992092; x=1690584092;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xLXUl2Tk0+P6DRD+I41VSis+LbcCFfMCosnmOvt+AFQ=;
        b=BjOxi0YKXWP6xbtMC4KqXMsjQXant5uSjCSys7eCT3rBvFh1C7uDBUqM67RzMdsC5J
         blTYSX15XpEef2iRiEobTv+4Bj+Nbq/Fy+KtEUn97fpXHIlF9qmECWomjtriQspvRt3T
         F0+9qSXfYzvmPMKOTbI1ptpMSgoK5HLs2jnnOQ7WAL4evI9SL0HHsA2pOEHgAhsHDlGD
         WJvBMK6jjmdq5ZXSHFFzo6N7BKDUmiV/I2iXGwEDO6qSc9ri2I9QyWqMRnV1IBnhVFHV
         0EJAPf2ZG1ZiC/6blZ3D5sjNmUNXkQM4ufqkTmEnQwnatUfvajmj4AjalcVT/bSJWet3
         82mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687992092; x=1690584092;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xLXUl2Tk0+P6DRD+I41VSis+LbcCFfMCosnmOvt+AFQ=;
        b=M/g1lyAn/J8widxWTizTJrtn6t/fgbV9rZCVNT59XomMH5VpIY3HN32iK03gkAJneV
         55QZBKWjzFsrAGPd3M4OfKjhebOjlNFKvEUAlNBluz3y2Lbl3BVK4VLy1KahpiLo7JXt
         7P4YefCYSwCTbX//MJlPPELjWVIS3RNpCIxqZAtXes97sJZbhX6n2+UBoytpf7GwFScA
         +5TGNfPwjJOnI/bKtLKOXjHH8ozY/vlgA2i/evliVcqDxcXSJHcIgEDRh7QOdS/edLE8
         CjxXmT47hz62zjvBMab0fu9WlMZ3MajfxWeRBkv1gbUDOqjkfWmKZQHwjfZ+lEbgJFWf
         oWZQ==
X-Gm-Message-State: AC+VfDwm8JnmFtE3rNDaFfxyXZS6T3tu4KAkCU7Nb9EXKg3yr3GHsMwS
        tfY91n1FMJFscOaKznKdEi8+Pw==
X-Google-Smtp-Source: ACHHUZ7tOUKSmzmwCQwlobHgf6cBQy3Jl13bsk3DWngxyvHraXdF5J+s+D9fyVAIQ2FaD9EF7RG5rw==
X-Received: by 2002:a17:90a:c685:b0:262:ecd9:ed09 with SMTP id n5-20020a17090ac68500b00262ecd9ed09mr7829994pjt.33.1687992092277;
        Wed, 28 Jun 2023 15:41:32 -0700 (PDT)
Received: from dread.disaster.area (pa49-186-94-37.pa.vic.optusnet.com.au. [49.186.94.37])
        by smtp.gmail.com with ESMTPSA id co21-20020a17090afe9500b00262dbf8648esm7014384pjb.34.2023.06.28.15.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 15:41:31 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1qEdqr-00HOhv-0A;
        Thu, 29 Jun 2023 08:41:29 +1000
Date:   Thu, 29 Jun 2023 08:41:29 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     David Howells <dhowells@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Matt Whitlock <kernel@mattwhitlock.name>,
        linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [Reproducer] Corruption, possible race between splice and
 FALLOC_FL_PUNCH_HOLE
Message-ID: <ZJy3GdhU8LOabvoC@dread.disaster.area>
References: <ZJvsJJKMPyM77vPv@dread.disaster.area>
 <ZJq6nJBoX1m6Po9+@casper.infradead.org>
 <ec804f26-fa76-4fbe-9b1c-8fbbd829b735@mattwhitlock.name>
 <ZJp4Df8MnU8F3XAt@dread.disaster.area>
 <3299543.1687933850@warthog.procyon.org.uk>
 <3388728.1687944804@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3388728.1687944804@warthog.procyon.org.uk>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 28, 2023 at 10:33:24AM +0100, David Howells wrote:
> Dave Chinner <david@fromorbit.com> wrote:
> 
> > On Wed, Jun 28, 2023 at 07:30:50AM +0100, David Howells wrote:
> > > Matthew Wilcox <willy@infradead.org> wrote:
> > > > > > Expected behavior:
> > > > > > Punching holes in a file after splicing pages out of that file into
> > > > > > a pipe should not corrupt the spliced-out pages in the pipe buffer.
> > > 
> > > I think this bit is the key.  Why would this be the expected behaviour?
> > > As you say, splice is allowed to stuff parts of the pagecache into a pipe
> > > and these may get transferred, say, to a network card at the end to
> > > transmit directly from.  It's a form of direct I/O.
> 
> Actually, it's a form of zerocopy, not direct I/O.
> 
> > > If someone has the pages mmapped, they can change the data that will be
> > > transmitted; if someone does a write(), they can change that data too.
> > > The point of splice is to avoid the copy - but it comes with a tradeoff.
> > 
> > I wouldn't call "post-splice filesystem modifications randomly
> > corrupts pipe data" a tradeoff. I call that a bug.
> 
> Would you consider it a kernel bug, then, if you use sendmsg(MSG_ZEROCOPY) to
> send some data from a file mmapping that some other userspace then corrupts by
> altering the file before the kernel has managed to send it?

Yes.

We had this exact discussion a few months ago w.r.t. OTW checksums
being invalid because data was changing mid-checksum.

I consider that a bug, and in most cases this is avoided by the
hardware checksum offloads. i.e. the checksum doesn't occur until
after the data is DMAd to the hardware out of the referenced page
so it is immune to tearing caused by 3rd party access to the data.

That doesn't mean the data being delivered is valid or correct;
fundamentally this is a use-after-free situation.

> Anyway, if you think the splice thing is a bug, we have to fix splice from a
> buffered file that is shared-writably mmapped as well as fixing
> fallocate()-driven mangling.  There are a number of options:
> 
>  (0) Document the bug as a feature: "If this is a problem, don't use splice".

That's the primary issue right now - the behaviour is not documented
anywhere.

> 
>  (1) Always copy the data into the pipe.

We always copy non-pipe data. Only pipes are considered special
here...

>  (2) Always unmap and steal the pages from the pagecache, copying if we can't.

That's effectively the definition of SPLICE_F_GIFT behaviour, yes?

>  (3) R/O-protect any PTEs mapping those pages and implement CoW.

Another mechanism for stable pages, but can we do CoW for kernel
only mappings easily?

>  (4) Disallow splice() from any region that's mmapped, disallow mmap() on or
>      make page_mkwrite wait for any region that's currently spliced.  Disallow
>      fallocate() on or make fallocate() wait for any pages that are spliced.

fallocate() is already protected against splice(2) operations via
exclusive i_rwsem, mapping->invalidate_lock, DIO drains and internal
filesystem locking.

The problem is that splicing to a pipe hands page cache pages to a
pipe that is not under the control (or is even visible) to the
filesystem, so the filesystem can do *nothing* to serialise against
these anonymous references that the pipe holds to page caceh pages.

So the filesystem would require a page/folio based synchronisation
mechanism, kinda like writeback and stable pages, and we'd have to
issue that wait everywhere we currently have a folio_wait_stable()
IO barrier. fallocate() would also need this, too.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
