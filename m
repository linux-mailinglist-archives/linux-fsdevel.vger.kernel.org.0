Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B42955D96E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jun 2022 15:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233642AbiF0KPd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Jun 2022 06:15:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231776AbiF0KPc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Jun 2022 06:15:32 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 052F0643A;
        Mon, 27 Jun 2022 03:15:32 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id AF65D21D01;
        Mon, 27 Jun 2022 10:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1656324930; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f4i8EpuFC0Iz4R6tvc8piLc9Aj4lNzzq0A2dDYo6eyw=;
        b=iFDzTp2xNH+qkBmzsulUqBjY3YbzAtk+TlMt+o5U+846pecMgsi9cUrBBY8I3J/81tkTga
        eSDWH5flXP7wVqupXSz5gSM9Dl8Jn6g6qZuwQY1WyIP6bCnSL+ng7eZov8GT5r04lnXA37
        Rxeg4lSGJtusSVyn4osr+eZ+Vt/JPvk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1656324930;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f4i8EpuFC0Iz4R6tvc8piLc9Aj4lNzzq0A2dDYo6eyw=;
        b=lH8yYTcg0HAs8/BgNEk3Xhzkuuzqt2UYfY4KzraflAHNkUUx8Gnt1CHjqWnNYV+21+0iGW
        mMjH2fF+3OGta2Dw==
Received: from quack3.suse.cz (unknown [10.163.43.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 8484C2C141;
        Mon, 27 Jun 2022 10:15:30 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 3DAAAA062F; Mon, 27 Jun 2022 12:15:29 +0200 (CEST)
Date:   Mon, 27 Jun 2022 12:15:29 +0200
From:   Jan Kara <jack@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
        clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] btrfs: remove btrfs_writepage_cow_fixup
Message-ID: <20220627101529.egrspyq2o5l3f6d4@quack3.lan>
References: <20220624122334.80603-1-hch@lst.de>
 <7c30b6a4-e628-baea-be83-6557750f995a@gmx.com>
 <20220624125118.GA789@lst.de>
 <20220624130750.cu26nnm6hjrru4zd@quack3.lan>
 <1b37cfc6-7369-69c1-bd90-5851cc79960d@gmx.com>
 <20220624134041.ktqj3af7lysaszrc@quack3.lan>
 <568f1582-3ff2-aae5-cd98-cf76172d89cb@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <568f1582-3ff2-aae5-cd98-cf76172d89cb@gmx.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 24-06-22 21:56:57, Qu Wenruo wrote:
> On 2022/6/24 21:40, Jan Kara wrote:
> > On Fri 24-06-22 21:19:04, Qu Wenruo wrote:
> > > 
> > > 
> > > On 2022/6/24 21:07, Jan Kara wrote:
> > > > On Fri 24-06-22 14:51:18, Christoph Hellwig wrote:
> > > > > On Fri, Jun 24, 2022 at 08:30:00PM +0800, Qu Wenruo wrote:
> > > > > > But from my previous feedback on subpage code, it looks like it's some
> > > > > > hardware archs (S390?) that can not do page flags update atomically.
> > > > > > 
> > > > > > I have tested similar thing, with extra ASSERT() to make sure the cow
> > > > > > fixup code never get triggered.
> > > > > > 
> > > > > > At least for x86_64 and aarch64 it's OK here.
> > > > > > 
> > > > > > So I hope this time we can get a concrete reason on why we need the
> > > > > > extra page Private2 bit in the first place.
> > > > > 
> > > > > I don't think atomic page flags are a thing here.  I remember Jan
> > > > > had chased a bug where we'd get into trouble into this area in
> > > > > ext4 due to the way pages are locked down for direct I/O, but I
> > > > > don't even remember seeing that on XFS.  Either way the PageOrdered
> > > > > check prevents a crash in that case and we really can't expect
> > > > > data to properly be written back in that case.
> > > > 
> > > > I'm not sure I get the context 100% right but pages getting randomly dirty
> > > > behind filesystem's back can still happen - most commonly with RDMA and
> > > > similar stuff which calls set_page_dirty() on pages it has got from
> > > > pin_user_pages() once the transfer is done.
> > > 
> > > Just curious, things like RMDA can mark those pages dirty even without
> > > letting kernel know, but how could those pages be from page cache? By
> > > mmap()?
> > 
> > Yes, you pass virtual address to RDMA ioctl and it uses memory at that
> > address as a target buffer for RDMA. If the target address happens to be
> > mmapped file, filesystem has problems...
> 
> Oh my god, this is going to be disaster.
> 
> RDMA is really almost a blackbox which can do anything to the pages.
> 
> If some RDMA drivers choose to screw up with Private2, the btrfs
> workaround is also screwed up.
> 
> Another problem is related to subpage.
> 
> Btrfs (and iomap) all uses page->private to store extra bitmaps for
> subpage usage.
> If RDMA is changing page flags, it can easily lead to de-sync between
> subpage bitmaps with real page flags.

Well, RDMA could do this (in fact any kernel code can do this, can't it? ;)
but RDMA is not expected to mess with page state arbitrarily. The only
thing it should be doing (and that is kind of the whole point of RDMA) is
that it allows RDMA card to alter page contents through DMA and then
dirties those pages to tell the rest of the kernel that page contents
changed.

So practically we need to treat pages pinned by RDMA drivers as "writeably
mapped to userspace" without a chance to unmap them.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
