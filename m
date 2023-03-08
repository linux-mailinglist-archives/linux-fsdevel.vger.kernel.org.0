Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A13586B005B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Mar 2023 09:00:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbjCHIAA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Mar 2023 03:00:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbjCHH76 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Mar 2023 02:59:58 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 859AC95E1B
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Mar 2023 23:59:56 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id y19so9119313pgk.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Mar 2023 23:59:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20210112.gappssmtp.com; s=20210112; t=1678262396;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oErMbovgNlM1fHmldHtqwkgHhSfzOswt1j6nL2mFsxo=;
        b=fiikSj48Ilmf1vGJNiI3Bq/tguYc41vQm7Wv71k+P26+1xYdYHczpadicL85OTqWpl
         U6NgRMu82A0NHUhz+qaoqyMW/MBvAos1JcIz5Ci30MHMEgpN3Efy5wucE0LVoqE02Rn4
         GqceS5pTWt5mQ6VyIQboQr6gW3TVX/RlrbPi6hPLu1VhuQyw5IQIpJhcLRKbnd+S1RsE
         RuHTYzkLCyADd8bKD0vBez9bXsu1UTO6mx2e09vG0uGkUYtnWlz7XW/yqw7MKzE3kvL5
         JPf+3rN6lFzPWYllqvI4I8A5EZfdXQcNqF0hbc4jXIbMi7pITxFgi4Q61TmDsGQ+kaJy
         5MBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678262396;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oErMbovgNlM1fHmldHtqwkgHhSfzOswt1j6nL2mFsxo=;
        b=cCB06fdZwxJFasY5nMiFoAJYjYXkcCvMrCzMCX9h7Z9Qk2okcmmqjVDDRDfWob6Uln
         p0tSjWFchVsNY9WX6MgO4KO8c3Zp4D0vTHlfMSfBGztd0RCDUiIE3LNbJRutzC3pKbRm
         hBrJX2wn+R5Y80m+J1Koyt9oNZEKsYhkM5Iam6FdfHvd1GL2xBFzpd9f+13e8eH2PddH
         TlTB9sWG//Z4NqCze4Ysr9pdweqzq9ZOqs42jzsPZ01M/TNk2x6dTCgQl6dmNUSP7xO0
         +ESUoY3kCgBs/tcMFbOWa6fwSLavMXHoUIaEw41Y824WI5xJrYIIlbmFvjdbUGsBJB6H
         yEeg==
X-Gm-Message-State: AO0yUKVzTUkhHhecEg4tfmoR/SayStn5orL0wBi/wEXz1lS+gUUN5oPO
        XsAP3TkybVxCP9WluL+oniQwrQ==
X-Google-Smtp-Source: AK7set8bsOinXE0KQbcPQOZUDb0oKVCU2EyTeRsMoZqI+23n5Roy2RhtB13Lmukyu/y+AOZsaMHOxg==
X-Received: by 2002:a62:1991:0:b0:5e2:434d:116b with SMTP id 139-20020a621991000000b005e2434d116bmr13162108pfz.23.1678262395850;
        Tue, 07 Mar 2023 23:59:55 -0800 (PST)
Received: from dread.disaster.area (pa49-186-4-237.pa.vic.optusnet.com.au. [49.186.4.237])
        by smtp.gmail.com with ESMTPSA id s1-20020aa78281000000b0059435689e36sm9159908pfm.170.2023.03.07.23.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 23:59:55 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1pZoiG-006DN9-PH; Wed, 08 Mar 2023 18:59:52 +1100
Date:   Wed, 8 Mar 2023 18:59:52 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Keith Busch <kbusch@kernel.org>, Theodore Ts'o <tytso@mit.edu>,
        Pankaj Raghav <p.raghav@samsung.com>,
        Daniel Gomez <da.gomez@samsung.com>,
        lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-block@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] Cloud storage optimizations
Message-ID: <20230308075952.GU2825702@dread.disaster.area>
References: <Y/7L74P6jSWwOvWt@mit.edu>
 <ZAFUYqAcPmRPLjET@kbusch-mbp.dhcp.thefacebook.com>
 <ZAFuSSZ5vZN7/UAa@casper.infradead.org>
 <f68905c5785b355b621847974d620fb59f021a41.camel@HansenPartnership.com>
 <ZAL0ifa66TfMinCh@casper.infradead.org>
 <2600732b9ed0ddabfda5831aff22fd7e4270e3be.camel@HansenPartnership.com>
 <ZAN0JkklyCRIXVo6@casper.infradead.org>
 <ZAQXduwAcAtIZHkB@bombadil.infradead.org>
 <ZAQicyYR0kZgrzIr@casper.infradead.org>
 <ZAgnHzUYkpQB+Uzi@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZAgnHzUYkpQB+Uzi@bombadil.infradead.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 07, 2023 at 10:11:43PM -0800, Luis Chamberlain wrote:
> On Sun, Mar 05, 2023 at 05:02:43AM +0000, Matthew Wilcox wrote:
> > On Sat, Mar 04, 2023 at 08:15:50PM -0800, Luis Chamberlain wrote:
> > > On Sat, Mar 04, 2023 at 04:39:02PM +0000, Matthew Wilcox wrote:
> > > > XFS already works with arbitrary-order folios. 
> > > 
> > > But block sizes > PAGE_SIZE is work which is still not merged. It
> > > *can* be with time. That would allow one to muck with larger block
> > > sizes than 4k on x86-64 for instance. Without this, you can't play
> > > ball.
> > 
> > Do you mean that XFS is checking that fs block size <= PAGE_SIZE and
> > that check needs to be dropped?  If so, I don't see where that happens.
> 
> None of that. Back in 2018 Chinner had prototyped XFS support with
> larger block size > PAGE_SIZE:
> 
> https://lwn.net/ml/linux-fsdevel/20181107063127.3902-1-david@fromorbit.com/

Having a working BS > PS implementation on XFS based on variable
page order support in the page cache goes back over a
decade before that.

Christoph Lameter did the page cache work, and I added support for
XFS back in 2007. THe total change to XFS required can be seen in
this simple patch:

https://lore.kernel.org/linux-mm/20070423093152.GI32602149@melbourne.sgi.com/

That was when the howls of anguish about high order allocations
Willy mentioned started....

> I just did a quick attempt to rebased it and most of the left over work
> is actually on IOMAP for writeback and zero / writes requiring a new
> zero-around functionality. All bugs on the rebase are my own, only compile
> tested so far, and not happy with some of the changes I had to make so
> likely could use tons more love:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/log/?h=20230307-larger-bs-then-ps-xfs

On a current kernel, that patchset is fundamentally broken as we
have multi-page folio support in XFS and iomap - the patchset is
inherently PAGE_SIZE based and it will do the the wrong thing with
PAGE_SIZE based zero-around.

IOWs, IOMAP_F_ZERO_AROUND does not need to exist any more, nor
should any of the custom hooks it triggered in different operations
for zero-around.  That's because we should now be using the same
approach to BS > PS as we first used back in 2007. We already
support multi-page folios in the page cache, so all the zero-around
and partial folio uptodate tracking we need is already in place.

Hence, like Willy said, all we need to do is have
filemap_get_folio(FGP_CREAT) always allocate at least filesystem
block sized and aligned folio and insert them into the mapping tree.
Multi-page folios will always need to be sized as an integer
multiple of the filesystem block size, but once we ensure size and
alignment of folios in the page cache, we get everything else for
free.

/me cues the howls of anguish over memory fragmentation....

> But it should give you an idea of what type of things filesystems need to do.

Not really. it gives you an idea of what filesystems needed to do 5
years ago to support BS > PS. We're living in the age of folios now,
not pages.  Willy starting work on folios was why I dropped that
patch set, firstly because it was going to make the iomap conversion
to folios harder, and secondly, we realised that none of it was
necessary if folios supported multi-page constructs in the page
cache natively.

IOWs, multi-page folios in the page cache should make BS > PS mostly
trivial to support for any filesystem or block device that doesn't
have some other dependency on PAGE_SIZE objects in the page cache
(e.g. bufferheads).

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
