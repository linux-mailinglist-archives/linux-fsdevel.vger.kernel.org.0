Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED14861310F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Oct 2022 08:09:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbiJaHJA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Oct 2022 03:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbiJaHI6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Oct 2022 03:08:58 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD1419595
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Oct 2022 00:08:57 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id m6so9969809pfb.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Oct 2022 00:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=129190ubM3xU7nxJsk44KGJFSeALp4i9xsUuUgjhGbI=;
        b=GsycPg3GW7y2TIV6orCuUXV0qlblV8bINebBaWrxvewUvEoEUAjAzN2YkXPZZ97/No
         sq8cG5q1KFrrDMTg5CIQNuOsfJCF22/qWuXb1HSrY2CWFsdcyI16ZaqjPJJoCbB9WOhp
         ytLpXTejzng5HRQgnskTwD5u8bbYEyy9r/UhavTt3K2nQ/49eIZu0eY/chbRfc4gq5DI
         qZ6Bjqt7Sg/+7zmRs3BeBbYwChqhRcw6w6/hrmjYak/3pkq3LoB2BECUhOr4pM3gxH+p
         iPW6riB1XlOIGE6yH7oShfLWjYmYUGvztNOwg9Ua5pvBRmJIhemALGxaCio/NsJ3vAO5
         d1LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=129190ubM3xU7nxJsk44KGJFSeALp4i9xsUuUgjhGbI=;
        b=0EtII8Cwl7jBhulwgz8jgXm/V/rt1mBQ5lijS28MIbnO8x94bh/fT7pQG8WC1leaPH
         OWjFCgUwCel8LnNIlyLOz9OmDvqzZbOSlK5Q7BXQ8BXNwM/XCVkMzKY4ShR7xsT2NTtO
         tFSEzJm5WMwDVE3tqTejW2y5WGDZP+rt9G5egrVESXxVXbjcUPlkmgKarck3/O7K0r36
         Lz/TTr1PrjBIgOFMubvrG3kWc/3trhbnNT6A7YPrni7OTuG/bab/eqbU8Aj8zWI1yDFA
         2deMyWYnmN1LPlmzus1Ru9u3nwFCH8TRy2fP2w9hIn8SiURH7JxjDFlpdUKk4GHN7IAN
         0XUA==
X-Gm-Message-State: ACrzQf1xnkr2eFzSTdgb2pyMGwzrKHPFW4TuCWF5WC6vKiemDq7mmk7I
        MhqRIPeFedgsf6MDFwHclXK/Gw==
X-Google-Smtp-Source: AMsMyM5uFu56UJLcjQSHG9Yf+bPECu2PhjaIgrkbd4t2+j+IElfeV7pF7cbFTcpQ+sLHh/MFByDZuw==
X-Received: by 2002:a05:6a00:1253:b0:56d:8742:a9ff with SMTP id u19-20020a056a00125300b0056d8742a9ffmr2408260pfi.5.1667200137292;
        Mon, 31 Oct 2022 00:08:57 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-106-210.pa.nsw.optusnet.com.au. [49.181.106.210])
        by smtp.gmail.com with ESMTPSA id s11-20020a65644b000000b0043c80e53c74sm3456907pgv.28.2022.10.31.00.08.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 00:08:56 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1opOuj-008V2d-3o; Mon, 31 Oct 2022 18:08:53 +1100
Date:   Mon, 31 Oct 2022 18:08:53 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Aravinda Herle <araherle@in.ibm.com>,
        David Howells <dhowells@redhat.com>
Subject: Re: [RFC 2/2] iomap: Support subpage size dirty tracking to improve
 write performance
Message-ID: <20221031070853.GL3600936@dread.disaster.area>
References: <cover.1666928993.git.ritesh.list@gmail.com>
 <886076cfa6f547d22765c522177d33cf621013d2.1666928993.git.ritesh.list@gmail.com>
 <20221028210422.GC3600936@dread.disaster.area>
 <Y19EXLfn8APg3adO@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y19EXLfn8APg3adO@casper.infradead.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 31, 2022 at 03:43:24AM +0000, Matthew Wilcox wrote:
> On Sat, Oct 29, 2022 at 08:04:22AM +1100, Dave Chinner wrote:
> > As it is, we already have the capability for the mapping tree to
> > have multiple indexes pointing to the same folio - perhaps it's time
> > to start thinking about using filesystem blocks as the mapping tree
> > index rather than PAGE_SIZE chunks, so that the page cache can then
> > track dirty state on filesystem block boundaries natively and
> > this whole problem goes away. We have to solve this sub-folio dirty
> > tracking problem for multi-page folios anyway, so it seems to me
> > that we should solve the sub-page block size dirty tracking problem
> > the same way....
> 
> That's an interesting proposal.  From the page cache's point of
> view right now, there is only one dirty bit per folio, not per page.

Per folio, yes, but I thought we also had a dirty bit per index
entry in the mapping tree. Writeback code uses the
PAGECACHE_TAG_DIRTY mark to find the dirty folios efficiently (i.e.
the write_cache_pages() iterator), so it's not like this is
something new. i.e. we already have coherent, external dirty bit
tracking mechanisms outside the folio itself that filesystems
use.

That's kinda what I'm getting at here - we already have coherent
dirty state tracking outside of the individual folios themselves.
Hence if we have to track sub-folio up-to-date state, sub-folio
dirty state and, potentially, sub-folio writeback state outside the
folio itself, why not do it by extending the existing coherent dirty
state tracking that is built into the mapping tree itself?

Folios + Xarray have given us the ability to disconnect the size of
the cached item at any given index from the index granularity - why
not extend that down to sub-page folio granularity in addition to
the scaling up we've been doing for large (multipage) folio
mappings?

Then we don't need any sort of filesystem specific "add-on" that sits
alongside the mapping tree that tries to keep track of dirty state
in addition to the folio and the mapping tree tracking that already
exists...

> We have a number of people looking at the analogous problem for network
> filesystems right now.  Dave Howells' netfs infrastructure is trying
> to solve the problem for everyone (and he's been looking at iomap as
> inspiration for what he's doing).  I'm kind of hoping we end up with one
> unified solution that can be used for all filesystems that want sub-folio
> dirty tracking.  His solution is a bit more complex than I really want
> to see, at least partially because he's trying to track dirtiness at
> byte granularity, no matter how much pain that causes to the server.

Byte range granularity is probably overkill for block based
filesystems - all we need is a couple of extra bits per block to be
stored in the mapping tree alongside the folio....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
