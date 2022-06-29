Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA6BE55FABF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jun 2022 10:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231656AbiF2Iim (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Jun 2022 04:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbiF2Iil (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Jun 2022 04:38:41 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76F161DA41;
        Wed, 29 Jun 2022 01:38:40 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id D53C667373; Wed, 29 Jun 2022 10:38:36 +0200 (CEST)
Date:   Wed, 29 Jun 2022 10:38:36 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>, josef@toxicpanda.com,
        dsterba@suse.com, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] btrfs: remove btrfs_writepage_cow_fixup
Message-ID: <20220629083836.GA25088@lst.de>
References: <20220624122334.80603-1-hch@lst.de> <7c30b6a4-e628-baea-be83-6557750f995a@gmx.com> <20220624125118.GA789@lst.de> <20220624130750.cu26nnm6hjrru4zd@quack3.lan> <20220625091143.GA23118@lst.de> <c4af4c49-c537-bd6d-c27e-fe9ed71b9a8e@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c4af4c49-c537-bd6d-c27e-fe9ed71b9a8e@fb.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 28, 2022 at 10:29:00AM -0400, Chris Mason wrote:
> As Sterba points out later in the thread, btrfs cares more because of 
> stable page requirements to protect data during COW and to make sure the 
> crcs we write to disk are correct.

I don't think this matters here.  What the other file systems do is to
simply not ever write a page that has the dirty bit set, but never had
->page_mkwrite called on it, which is the case that is getting fixed up
here.

I did a little research and this post from Jan describes the problem
best:

https://lore.kernel.org/linux-mm/20180103100430.GE4911@quack2.suse.cz/

So the problem is that while get_user_pages takes a write fault and
marks the page dirty, the page could have been claned just after
that, and then receive a set_page/folio_dirty after that.  The
canonical example would be the direct I/O read completion calling
into that.

> I'd love a proper fix for this on the *_user_pages() side where 
> page_mkwrite() style notifications are used all the time.  It's just a huge 
> change, and my answer so far has always been that using btrfs mmap'd memory 
> for this kind of thing isn't a great choice either way.

Everyone else has the same problem, but decided that you can't get
full data integrity out of this workload.

I think the sane answers are:  simply don't writeback pages that
are held by a get_user_pages with writable pages, or try to dirty
the pages from set_page_dirtẏ.  The set_page_dirty contexts are
somewhat iffy, but would probably be a better place to kick off the
btrfs writepage fixup.
