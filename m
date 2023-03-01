Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A13AC6A6768
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Mar 2023 06:42:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbjCAFmc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Mar 2023 00:42:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjCAFmb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Mar 2023 00:42:31 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E27D30EBC;
        Tue, 28 Feb 2023 21:42:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=v2VBdt3kHKVqHXSdicN5o2cil7i5B6UknsXaVF5uIhU=; b=DywQDkHUM4ppZeg43fbbwjP2M2
        /oZO+6xgBiP8hwhJbgWiTP69FQRD4/TRYreUdNCf3f3ItX6aQ6ooZyRGSKDJtl2hi5PQQX4aIklSg
        kkxhaosMgcf/f6Edwdrw1DDqkninZ/HzXgIXFhn/IsHGBU/TBcbzb2xHGu9Ge9dvTSbOdP41aX/Sh
        NIew+5py+V0Pp6iglRuW2MOGodiC7wk4PmF/ZPgOsEUOKjaPdnWOi84FNtU1EKrNdgUVc3JCRjj5s
        /u6r9TIoXEQj3dEuOpitvrS7BGqiK8TJuB/+BKvrrHw8PmEb8VEyY72snQpJ4SwUWiQcPA/Z8Hxe1
        m4zgbPmg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pXFEK-001Ph8-Mb; Wed, 01 Mar 2023 05:42:20 +0000
Date:   Wed, 1 Mar 2023 05:42:20 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     Theodore Ts'o <tytso@mit.edu>, lsf-pc@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-block@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] Cloud storage optimizations
Message-ID: <Y/7lvBfzJXntfWal@casper.infradead.org>
References: <Y/7L74P6jSWwOvWt@mit.edu>
 <Y/7WJMNLjrQ+/+Vs@casper.infradead.org>
 <c6612406-11c7-2158-5186-ebee72c9b698@linux.alibaba.com>
 <Y/7cNU2TRIVl/I85@casper.infradead.org>
 <49b6d3de-e5c7-73fc-fa43-5c068426619b@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49b6d3de-e5c7-73fc-fa43-5c068426619b@linux.alibaba.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 01, 2023 at 01:09:34PM +0800, Gao Xiang wrote:
> On 2023/3/1 13:01, Matthew Wilcox wrote:
> > On Wed, Mar 01, 2023 at 12:49:10PM +0800, Gao Xiang wrote:
> > > > The only problem is that the readahead code doesn't tell the filesystem
> > > > whether the request is sync or async.  This should be a simple matter
> > > > of adding a new 'bool async' to the readahead_control and then setting
> > > > REQ_RAHEAD based on that, rather than on whether the request came in
> > > > through readahead() or read_folio() (eg see mpage_readahead()).
> > > 
> > > Great!  In addition to that, just (somewhat) off topic, if we have a
> > > "bool async" now, I think it will immediately have some users (such as
> > > EROFS), since we'd like to do post-processing (such as decompression)
> > > immediately in the same context with sync readahead (due to missing
> > > pages) and leave it to another kworker for async readahead (I think
> > > it's almost same for decryption and verification).
> > > 
> > > So "bool async" is quite useful on my side if it could be possible
> > > passed to fs side.  I'd like to raise my hands to have it.
> > 
> > That's a really interesting use-case; thanks for bringing it up.
> > 
> > Ideally, we'd have the waiting task do the
> > decompression/decryption/verification for proper accounting of CPU.
> > Unfortunately, if the folio isn't uptodate, the task doesn't even hold
> > a reference to the folio while it waits, so there's no way to wake the
> > task and let it know that it has work to do.  At least not at the moment
> > ... let me think about that a bit (and if you see a way to do it, feel
> > free to propose it)
> 
> Honestly, I'd like to take the folio lock until all post-processing is
> done and make it uptodate and unlock so that only we need is to pass
> locked-folios requests to kworkers for async way or sync handling in
> the original context.
> 
> If we unlocked these folios in advance without uptodate, which means
> we have to lock it again (which could have more lock contention) and
> need to have a way to trace I/Oed but not post-processed stuff in
> addition to no I/Oed stuff.

Right, look at how it's handled right now ...

sys_read() ends up in filemap_get_pages() which (assuming no folio in
cache) calls page_cache_sync_readahead().  That creates locked, !uptodate
folios and asks the filesystem to fill them.  Unless that completes
incredibly quickly, filemap_get_pages() ends up in filemap_update_page()
which calls folio_put_wait_locked().

If the filesystem BIO completion routine could identify if there was
a task waiting and select one of them, it could wake up the waiter and
pass it a description of what work it needed to do (with the folio still
locked), rather than do the postprocessing itself and unlock the folio.

But that all seems _very_ hard to do with 100% reliability.  Note the
comment in folio_wait_bit_common() which points out that the waiters
bit may be set even when there are no waiters.  The wake_up code
doesn't seem to support this kind of thing (all waiters are
non-exclusive, but only wake up one of them).

