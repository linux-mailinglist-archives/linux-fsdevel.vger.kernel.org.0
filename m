Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D777C55DA76
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jun 2022 15:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243575AbiF1IAj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jun 2022 04:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231845AbiF1IAi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jun 2022 04:00:38 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 757AD22520;
        Tue, 28 Jun 2022 01:00:37 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 363E821ED6;
        Tue, 28 Jun 2022 08:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1656403236; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=P3A27r/kSwr6T7VG1EuklWndLTcxlL+fD6RWbS+cxGM=;
        b=ELkHQnEwtogDNZly5I9OPhR4v3RB10rrvIKbPPGmvl9z+kiV0uy6fez88ye32fo6xAYdph
        dkDWm6ipNTMGOY/L8bk1SQcR5VZ7K2gXknbhmxfy7ZYCeSj7cuo7KUmrXfU9C0WLhUOfSv
        1qRojIX4r8872KBW5+HgmIyMy6KbEbk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1656403236;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=P3A27r/kSwr6T7VG1EuklWndLTcxlL+fD6RWbS+cxGM=;
        b=uvH83FLVX/GUhW8PEh5YlRy38mB+VfvnqN8TL9IXzyeIwqwzred6g/r7uEsBoP1FCA3Tmv
        MzTlaPFDEZBVNpAw==
Received: from quack3.suse.cz (dhcp194.suse.cz [10.100.51.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 238152C142;
        Tue, 28 Jun 2022 08:00:36 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id F0906A062F; Tue, 28 Jun 2022 10:00:35 +0200 (CEST)
Date:   Tue, 28 Jun 2022 10:00:35 +0200
From:   Jan Kara <jack@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
        clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] btrfs: remove btrfs_writepage_cow_fixup
Message-ID: <20220628080035.qlbdib7zh3zd2zfq@quack3>
References: <20220624122334.80603-1-hch@lst.de>
 <7c30b6a4-e628-baea-be83-6557750f995a@gmx.com>
 <20220624125118.GA789@lst.de>
 <20220624130750.cu26nnm6hjrru4zd@quack3.lan>
 <20220625091143.GA23118@lst.de>
 <20220627101914.gpoz7f6riezkolad@quack3.lan>
 <e73be42e-fce5-733a-310d-db9dc5011796@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e73be42e-fce5-733a-310d-db9dc5011796@gmx.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 28-06-22 08:24:07, Qu Wenruo wrote:
> On 2022/6/27 18:19, Jan Kara wrote:
> > On Sat 25-06-22 11:11:43, Christoph Hellwig wrote:
> > > On Fri, Jun 24, 2022 at 03:07:50PM +0200, Jan Kara wrote:
> > > > I'm not sure I get the context 100% right but pages getting randomly dirty
> > > > behind filesystem's back can still happen - most commonly with RDMA and
> > > > similar stuff which calls set_page_dirty() on pages it has got from
> > > > pin_user_pages() once the transfer is done. page_maybe_dma_pinned() should
> > > > be usable within filesystems to detect such cases and protect the
> > > > filesystem but so far neither me nor John Hubbart has got to implement this
> > > > in the generic writeback infrastructure + some filesystem as a sample case
> > > > others could copy...
> > > 
> > > Well, so far the strategy elsewhere seems to be to just ignore pages
> > > only dirtied through get_user_pages.  E.g. iomap skips over pages
> > > reported as holes, and ext4_writepage complains about pages without
> > > buffers and then clears the dirty bit and continues.
> > > 
> > > I'm kinda surprised that btrfs wants to treat this so special
> > > especially as more of the btrfs page and sub-page status will be out
> > > of date as well.
> > 
> > I agree btrfs probably needs a different solution than what it is currently
> > doing if they want to get things right. I just wanted to make it clear that
> > the code you are ripping out may be a wrong solution but to a real problem.
> 
> IHMO I believe btrfs should also ignore such dirty but not managed by fs
> pages.
> 
> But I still have a small concern here.
> 
> Is it ensured that, after RDMA dirtying the pages, would we finally got
> a proper notification to fs that those pages are marked written?

So there is ->page_mkwrite() notification happening when RDMA code calls
pin_user_pages() when preparing buffers. The trouble is that although later
page_mkclean() makes page not writeable from page tables, it may be still
written by RDMA code (even hours after ->page_mkwrite() notification, RDMA
buffers are really long-lived) and that's what eventually confuses the
filesystem.  Otherwise set_page_dirty() is the notification that page
contents was changed and needs writing out...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
