Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD0871EEE80
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jun 2020 01:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726142AbgFDXuv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Jun 2020 19:50:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbgFDXuv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Jun 2020 19:50:51 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50ABFC08C5C0;
        Thu,  4 Jun 2020 16:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zd4mes2BosmuFtfxX993NYsNl3JofXApEXaS2L2Ahxo=; b=oZKNYYSdr+hQlwG33pEv98hFFt
        xKb+ex6ntArPYooazlnjnglvCWH60//QaGdgMpdLZqxxQzSV5+wtnBxJTA4qidME6oTOXT087jtkT
        ZRogGDJAhYiUY40e+NMTbxpLiU8lKVM2m/arjiaYuKUWo+PqodhzOn8Ws87yUhUb2xt2TauhtV2ty
        p6cw9t+luO4t1VXTMyew+jpImhI6hDJWVLbqlJ5NobIkV7SYl1BGH0dTLU51i9vWK47MlZJw3Qn7g
        pHZj2mstwkP3dplf9FnNJ7RZ1cFRJOAGsnth2NCphWWWDYquZH4w8kc3+nJmXY6ZiA00C28O3WPCN
        FU24Ks1w==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jgzdK-0000wH-IF; Thu, 04 Jun 2020 23:50:50 +0000
Date:   Thu, 4 Jun 2020 16:50:50 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iomap: Handle I/O errors gracefully in page_mkwrite
Message-ID: <20200604235050.GX19604@bombadil.infradead.org>
References: <20200604202340.29170-1-willy@infradead.org>
 <20200604225726.GU2040@dread.disaster.area>
 <20200604230519.GW19604@bombadil.infradead.org>
 <20200604233053.GW2040@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200604233053.GW2040@dread.disaster.area>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 05, 2020 at 09:30:53AM +1000, Dave Chinner wrote:
> On Thu, Jun 04, 2020 at 04:05:19PM -0700, Matthew Wilcox wrote:
> > On Fri, Jun 05, 2020 at 08:57:26AM +1000, Dave Chinner wrote:
> > > On Thu, Jun 04, 2020 at 01:23:40PM -0700, Matthew Wilcox wrote:
> > > > From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> > > > 
> > > > Test generic/019 often results in:
> > > > 
> > > > WARNING: at fs/iomap/buffered-io.c:1069 iomap_page_mkwrite_actor+0x57/0x70
> > > > 
> > > > Since this can happen due to a storage error, we should not WARN for it.
> > > > Just return -EIO, which will be converted to a SIGBUS for the hapless
> > > > task attempting to write to the page that we can't read.
> > > 
> > > Why didn't the "read" part of the fault which had the EIO error fail
> > > the page fault? i.e. why are we waiting until deep inside the write
> > > fault path to error out on a failed page read?
> > 
> > I have a hypothesis that I don't know how to verify.
> > 
> > First the task does a load from the page and we put a read-only PTE in
> > the page tables.  Then it writes to the page using write().  The page
> > gets written back, but hits an error in iomap_writepage_map()
> > which calls ClearPageUptodate().  Then the task with it mapped attempts
> > to store to it.
> 
> Sure, but that's not really what I was asking: why isn't this
> !uptodate state caught before the page fault code calls
> ->page_mkwrite? The page fault code has a reference to the page,
> after all, and in a couple of paths it even has the page locked.

If there's already a PTE present, then the page fault code doesn't
check the uptodate bit.  Here's the path I'm looking at:

do_wp_page()
 -> vm_normal_page()
 -> wp_page_shared()
     -> do_page_mkwrite()

I don't see anything in there that checked Uptodate.

> What I'm trying to understand is why this needs to be fixed inside
> ->page_mkwrite, because AFAICT if we have to fix this in the iomap
> code, we have the same "we got handed a bad page by the page fault"
> problem in every single ->page_mkwrite implementation....

I think the iomap code is the only filesystem which clears PageUptodate
on errors.  I know we've argued about whether that's appropriate or not
in the past.

> > I haven't dug through what generic/019 does, so I don't know how plausible
> > this is.
> 
> # Run fsstress and fio(dio/aio and mmap) and simulate disk failure
> # check filesystem consistency at the end.
> 
> I don't think it is mixing buffered writes and mmap writes on the
> same file via fio. Maybe fsstress is triggering that, but the
> fsstress workload is single threaded so, again, I'm not sure it will
> do this.

Maybe that's not how we end up with a read-only PTE in the process's
page tables.  Perhaps it starts out with a store, then on an fsync()
we mark it read-only, then try to do another store.
