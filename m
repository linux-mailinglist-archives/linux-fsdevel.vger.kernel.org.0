Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81F1D681E00
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jan 2023 23:25:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbjA3WZG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Jan 2023 17:25:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjA3WZF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Jan 2023 17:25:05 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C277310E3;
        Mon, 30 Jan 2023 14:25:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=twT5S8u7PW7laIo0LdGU22R/Gr574Yog/UWagHcbgj8=; b=Sei3X+9jhML/yRX6ih1bP9rLzs
        cldpRi5uk2ROKMT3acOWUN/OCtE7wzGQr5jUB46m3yBSaIPg1s8h3IHhrK0mqEIn4edms40xpIReV
        3VtC9U//oSbxckotjgqOg0QPc+e4hUS022QfsP7wg71Z2vUy8Mu0w70oJ49gXRFkiIbvPMbbHgAtZ
        GFfdOJnBkff33ubGgaLln7C+alsEaNVOvR0NMs2uKzNJ/k+VuAQKzkano/Pzp4Uj/tDF28Em3X9UZ
        PcGllHEAwzn/UiHXmSPnyDoEXdYVWDY+40RpC8kBb0J8x3s8td3eeGM10SgYtpEca5ZLmJSc63nAR
        L4N5ZnVg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pMcaB-00AkCS-Kd; Mon, 30 Jan 2023 22:24:59 +0000
Date:   Mon, 30 Jan 2023 22:24:59 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Aravinda Herle <araherle@in.ibm.com>
Subject: Re: [RFCv2 2/3] iomap: Change uptodate variable name to state
Message-ID: <Y9hDu8hVBa3qJTNw@casper.infradead.org>
References: <cover.1675093524.git.ritesh.list@gmail.com>
 <bf30b7bfb03ef368e6e744b3c63af3dbfa11304d.1675093524.git.ritesh.list@gmail.com>
 <20230130215623.GP360264@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230130215623.GP360264@dread.disaster.area>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 31, 2023 at 08:56:23AM +1100, Dave Chinner wrote:
> > +	spinlock_t		state_lock;
> > +	unsigned long		state[];
> 
> I don't realy like this change, nor the followup in the next patch
> that puts two different state bits somewhere inside a single bitmap.

I think that's due to the open-coding of accesses to those bits.
Which was why I questioned the wisdom of sending out this patchset
without having introduced the accessors.

> This is the reason I don't like it - we lose the self-documenting
> aspect of the code. bitmap_fill(iop->uptodate, nr_blocks) is
> obviously correct, the new version isn't because "state" has no
> obvious meaning, and it only gets worse in the next patch where
> state is changed to have a magic "2 * nr_blocks" length and multiple
> state bits per block.

Completely agreed.

> Having an obvious setup where there are two bitmaps, one for dirty
> and one for uptodate, and the same bit in each bitmap corresponds to
> the state for that sub-block region, it is easy to see that the code
> is operating on the correct bit, to look at the bitmap and see what
> bits are set, to compare uptodate and dirty bitmaps side by side,
> etc. It's a much easier setup to read, code correctly, analyse and
> debug than putting multiple state bits in the same bitmap array at
> different indexes.
> 
> If you are trying to keep this down to a single allocation by using
> a single bitmap of undefined length, then change the declaration and
> the structure size calculation away from using array notation and
> instead just use pointers to the individual bitmap regions within
> the allocated region.

Hard to stomach that solution when the bitmap is usually 2 bytes long
(in Ritesh's case).  Let's see a version of this patchset with
accessors before rendering judgement.

Although to my mind, we still want a solution that scales beyond
a bitmap.  But a proper set of accessors will abstract that away.
