Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C506A7168BA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 May 2023 18:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233315AbjE3QHZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 May 2023 12:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233210AbjE3QHK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 May 2023 12:07:10 -0400
Received: from out-8.mta1.migadu.com (out-8.mta1.migadu.com [95.215.58.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94705C9
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 May 2023 09:07:00 -0700 (PDT)
Date:   Tue, 30 May 2023 12:06:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1685462818;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GvzDBLaFoADOumJHcj6o4wathgB48XH/zOUCBfWh1rI=;
        b=sy7Fwk/kgvokmeLr0X9kOdkzIshmz3RIjnrrzA/Q5pwbmqQc5EKb47hfIQJddkEkTXT/qF
        N5qMsH6OoZcTKHOXD4mh38mYq+Qkw0vb6xhb2K2mzIN38Sl8V2TiggGBWUVtydQngHKQTi
        ML9bOGFfq2i0evMAHiRrTLfgOfmzqoM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/7] block layer patches for bcachefs
Message-ID: <ZHYfGvPJFONm58dA@moria.home.lan>
References: <20230525214822.2725616-1-kent.overstreet@linux.dev>
 <ee03b7ce-8257-17f9-f83e-bea2c64aff16@kernel.dk>
 <ZHEaKQH22Uxk9jPK@moria.home.lan>
 <8e874109-db4a-82e3-4020-0596eeabbadf@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e874109-db4a-82e3-4020-0596eeabbadf@kernel.dk>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 30, 2023 at 08:22:50AM -0600, Jens Axboe wrote:
> On 5/26/23 2:44?PM, Kent Overstreet wrote:
> > On Fri, May 26, 2023 at 08:35:23AM -0600, Jens Axboe wrote:
> >> On 5/25/23 3:48?PM, Kent Overstreet wrote:
> >>> Jens, here's the full series of block layer patches needed for bcachefs:
> >>>
> >>> Some of these (added exports, zero_fill_bio_iter?) can probably go with
> >>> the bcachefs pull and I'm just including here for completeness. The main
> >>> ones are the bio_iter patches, and the __invalidate_super() patch.
> >>>
> >>> The bio_iter series has a new documentation patch.
> >>>
> >>> I would still like the __invalidate_super() patch to get some review
> >>> (from VFS people? unclear who owns this).
> >>
> >> I wanted to check the code generation for patches 4 and 5, but the
> >> series doesn't seem to apply to current -git nor my for-6.5/block.
> >> There's no base commit in this cover letter either, so what is this
> >> against?
> >>
> >> Please send one that applies to for-6.5/block so it's a bit easier
> >> to take a closer look at this.
> > 
> > Here you go:
> > git pull https://evilpiepirate.org/git/bcachefs.git block-for-bcachefs
> 
> Thanks
> 
> The re-exporting of helpers is somewhat odd - why is bcachefs special
> here and needs these, while others do not?

It's not iomap based.

> But the main issue for me are the iterator changes, which mostly just
> seems like unnecessary churn. What's the justification for these? The
> commit messages don;t really have any. Doesn't seem like much of a
> simplification, and in fact it's more code than before and obviously
> more stack usage as well.

I need bio_for_each_folio().

The approach taken by the bcachefs IO paths is to first build up bios,
then walk the extents btree to determine where to send them, splitting
as needed.

For reading into the page cache we additionally need to initialize our
private state based on what we're reading from that says what's on disk
(unallocated, reservation, or normal allocation) and how many replicas.
This is used for both i_blocks accounting and for deciding when we need
to get a disk reservation. Since we're doing this post split, it needs
bio_for_each_folio, not the _all variant.

Yes, the iterator changes are a bit more code - but it's split up into
better helpers now, the pointer arithmetic before was a bit dense; I
found the result to be more readable. I'm surprised at more stack usage;
I would have expected _less_ for bio_for_each_page_all() since it gets
rid of a pointer into the bvec_iter_all. How did you measure that?
