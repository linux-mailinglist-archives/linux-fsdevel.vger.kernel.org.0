Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 813C257B91D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Jul 2022 17:02:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232919AbiGTPCi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Jul 2022 11:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232220AbiGTPCh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Jul 2022 11:02:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E9E453D0B;
        Wed, 20 Jul 2022 08:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tsZFbCOwOTa4oL/6rESxgKwXoLmWNvHKzpr9YmtZRaE=; b=qEp4AJK/ZMf2KCQNeSIMBOFd+r
        MvznfKwn6C4jvzlfMfVXM3sprf0yDb4V0L1LL90AxHGUTk228C8mq6jkL5GhSbqyPOrl54GdBdRlJ
        mPUy7x8FH+mM5e6Y+piFeWpmNUfUB/MCkae2iU+WAoElccNFkGQS/d/ADd2t1idqR71GhY1alOLfk
        UgjBwLO/w1b+bKgTB2ogiF1TeQkTJ6txDrTuZv0EBYnHB1dER8gTpPqd/PhxEfUT04UqoIuRQSmGe
        kVb0tfmk6vacAajpHhPNzQbqOgJxeuWoL/bkIyYoKvNhZuIE8pZdvcae4fzuFF9ORJqOtUa1jbr+n
        EgHu4xiQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oEBDA-00EYbB-PB; Wed, 20 Jul 2022 15:02:04 +0000
Date:   Wed, 20 Jul 2022 16:02:04 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     CGEL <cgel.zte@gmail.com>
Cc:     viro@zeniv.linux.org.uk, hughd@google.com,
        akpm@linux-foundation.org, hch@infradead.org,
        hsiangkao@linux.alibaba.com, yang.yang29@zte.com.cn,
        axboe@kernel.dk, yangerkun@huawei.com, johannes.thumshirn@wdc.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Ran Xiaokai <ran.xiaokai@zte.com.cn>
Subject: Re: [PATCH] fs: drop_caches: skip dropping pagecache which is always
 dirty
Message-ID: <YtgY7CEWvcqywK1/@casper.infradead.org>
References: <20220720022118.1495752-1-yang.yang29@zte.com.cn>
 <YtdwULpWfSR3JI/u@casper.infradead.org>
 <62d79a79.1c69fb81.e4cba.37f5@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62d79a79.1c69fb81.e4cba.37f5@mx.google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 20, 2022 at 06:02:32AM +0000, CGEL wrote:
> On Wed, Jul 20, 2022 at 04:02:40AM +0100, Matthew Wilcox wrote:
> > On Wed, Jul 20, 2022 at 02:21:19AM +0000, cgel.zte@gmail.com wrote:
> > > From: Yang Yang <yang.yang29@zte.com.cn>
> > > 
> > > Pagecache of some kind of fs has PG_dirty bit set once it was
> > > allocated, so it can't be dropped. These fs include ramfs and
> > > tmpfs. This can make drop_pagecache_sb() more efficient.
> > 
> > Why do we want to make drop_pagecache_sb() more efficient?
> 
> Some users may use drop_caches besides testing or debugging.

This is a terrible reason.

> For example, some systems will create a lot of pagecache when boot up
> while reading bzImage, ramdisk, docker images etc. Most of this pagecache
> is useless after boot up. It may has a longterm negative effects for the
> workload when trigger page reclaim. It is especially harmful when trigger
> direct_reclaim or we need allocate pages in atomic context. So users may
> chose to drop_caches after boot up.

If that's actually a problem, work on fixing that.
