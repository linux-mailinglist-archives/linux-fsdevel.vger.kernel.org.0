Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD53455FCCC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jun 2022 12:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233245AbiF2KDI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Jun 2022 06:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbiF2KDG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Jun 2022 06:03:06 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C06D91E3;
        Wed, 29 Jun 2022 03:03:04 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id BC10622045;
        Wed, 29 Jun 2022 10:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1656496982; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BO/Fxl9X0wsYE0HIz9g9iiRY5jd6PMadH/nQK4vmenw=;
        b=p7GWYaWtdbxAvxdRmred4Ci/2dO2gtYEQcXvXhoGp+rLXqE7YK4Qch6AIgDzVpBoaFqI7V
        tvqo+ZbwQzaWhx8yJ1+fX2MC78BpIn4m2ZqvWK7FBLqvzerzMy25nvvoTyHrbWZk5knhyx
        HDVdNJe8C1IDKqNLUv7r3iPnBbyVH9c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1656496982;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BO/Fxl9X0wsYE0HIz9g9iiRY5jd6PMadH/nQK4vmenw=;
        b=XzYNuErxc6hNE+9/hza5QfmkWDA0oQhWoU7nUFQlcsh0QDi6R676xtHM3F/BQVgIdJE94e
        noT8lmkPiwgo6ZCg==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 97F2E2C141;
        Wed, 29 Jun 2022 10:03:02 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 3DDB3A062F; Wed, 29 Jun 2022 12:03:02 +0200 (CEST)
Date:   Wed, 29 Jun 2022 12:03:02 +0200
From:   Jan Kara <jack@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
        clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] btrfs: remove btrfs_writepage_cow_fixup
Message-ID: <20220629100302.s7zy6mrez6cawgim@quack3>
References: <20220624122334.80603-1-hch@lst.de>
 <7c30b6a4-e628-baea-be83-6557750f995a@gmx.com>
 <20220624125118.GA789@lst.de>
 <20220624130750.cu26nnm6hjrru4zd@quack3.lan>
 <20220625091143.GA23118@lst.de>
 <20220627101914.gpoz7f6riezkolad@quack3.lan>
 <e73be42e-fce5-733a-310d-db9dc5011796@gmx.com>
 <20220628080035.qlbdib7zh3zd2zfq@quack3>
 <77cb547c-a4d8-cca9-3889-872ebfed2859@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77cb547c-a4d8-cca9-3889-872ebfed2859@gmx.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 29-06-22 09:33:23, Qu Wenruo wrote:
> 
> 
> On 2022/6/28 16:00, Jan Kara wrote:
> > On Tue 28-06-22 08:24:07, Qu Wenruo wrote:
> > > On 2022/6/27 18:19, Jan Kara wrote:
> > > > On Sat 25-06-22 11:11:43, Christoph Hellwig wrote:
> > > > > On Fri, Jun 24, 2022 at 03:07:50PM +0200, Jan Kara wrote:
> > > > > > I'm not sure I get the context 100% right but pages getting randomly dirty
> > > > > > behind filesystem's back can still happen - most commonly with RDMA and
> > > > > > similar stuff which calls set_page_dirty() on pages it has got from
> > > > > > pin_user_pages() once the transfer is done. page_maybe_dma_pinned() should
> > > > > > be usable within filesystems to detect such cases and protect the
> > > > > > filesystem but so far neither me nor John Hubbart has got to implement this
> > > > > > in the generic writeback infrastructure + some filesystem as a sample case
> > > > > > others could copy...
> > > > > 
> > > > > Well, so far the strategy elsewhere seems to be to just ignore pages
> > > > > only dirtied through get_user_pages.  E.g. iomap skips over pages
> > > > > reported as holes, and ext4_writepage complains about pages without
> > > > > buffers and then clears the dirty bit and continues.
> > > > > 
> > > > > I'm kinda surprised that btrfs wants to treat this so special
> > > > > especially as more of the btrfs page and sub-page status will be out
> > > > > of date as well.
> > > > 
> > > > I agree btrfs probably needs a different solution than what it is currently
> > > > doing if they want to get things right. I just wanted to make it clear that
> > > > the code you are ripping out may be a wrong solution but to a real problem.
> > > 
> > > IHMO I believe btrfs should also ignore such dirty but not managed by fs
> > > pages.
> > > 
> > > But I still have a small concern here.
> > > 
> > > Is it ensured that, after RDMA dirtying the pages, would we finally got
> > > a proper notification to fs that those pages are marked written?
> > 
> > So there is ->page_mkwrite() notification happening when RDMA code calls
> > pin_user_pages() when preparing buffers.
> 
> I'm wondering why page_mkwrite() is only called when preparing the buffer?

Because that's the moment when the page fault happens. After this moment we
simply give the page physical address to the HW card and the card is free
to modify that memory as it wishes without telling the kernel about it.
That is simply how the HW is designed.

> Wouldn't it make more sense to call page_mkwrite() when the buffered is
> released from RDMA?

Well, but this is long after the page contents have been modified and in
fact the page need not be mapped to process' virtual address space anymore
by that time (it is perfectly fine to do: addr = mmap(file), pass addr to
HW, munmap(addr)). So we don't have enough context for page_mkwrite()
callback anymore. Essentially all we can provide is already provided in the
->set_page_dirty() callback the filesystem gets.

> Sorry for all these dumb questions, as the core-api/pin_user_pages.rst
> still doesn't explain thing to my dumb brain...

Yeah, these things are subtle and somewhat hard to grasp...

> Another thing is, RDMA doesn't really need to respect things like page
> locked/writeback, right?

Correct.

> As to RDMA calls, all pages should be pinned and seemingly exclusive to
> them.
> 
> And in that case, I think btrfs should ignore writing back those pages,
> other than doing fixing ups.
> 
> As the btrfs csum requires everyone modifying the page to wait for
> writeback, or the written data will be out-of-sync with the calculated
> csum and cause future -EIO when reading it from disk.

Yes, I know. Ignoring writeback of page_maybe_dma_pinned() pages is a
reasonable choice the fs can do. The only exception tends to be data
integrity writeback - stuff like fsync(2) or sync(2). There the filesystem
might need to writeback the page to make sure everything is consistent on
disk (and stale data is not exposed) in case of a crash. So in these
special cases it may be necessary to use bounce pages for submitting the IO
(and computing checksums etc.) so that inconsistencies you mention above
are not possible.

> > The trouble is that although later
> > page_mkclean() makes page not writeable from page tables, it may be still
> > written by RDMA code (even hours after ->page_mkwrite() notification, RDMA
> > buffers are really long-lived) and that's what eventually confuses the
> > filesystem.  Otherwise set_page_dirty() is the notification that page
> > contents was changed and needs writing out...
> 
> Another thing I still didn't get is, is there any explicit
> mkwrite()/set_page_dirty() calls when those page are unpinned.
> 
> If no such explicit calls, these dirty pages caused by RDMA would always
> be ignored by fses (except btrfs), and would never got proper written back.

When the pages are unpinned the holder must call set_page_dirty() to let
the rest of the kernel know that the hardware may be modified the page
contents. The filesystem can hook there with ->set_page_dirty() hook if it
needs to do some action.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
