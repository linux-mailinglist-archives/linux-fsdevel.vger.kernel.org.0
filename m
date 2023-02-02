Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F838688A0C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Feb 2023 23:51:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbjBBWvh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Feb 2023 17:51:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231442AbjBBWvf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Feb 2023 17:51:35 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A326C6C118;
        Thu,  2 Feb 2023 14:51:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wNaqigkQxIukar7avGzK7dviESW0b0iyFkV+nOTVZXI=; b=YJLI29zIn6dVUJAjAkE9q8ztpi
        gHxij6TvruKtv2kYPv8fiA8fX8hIgk/40xQxFu7tbrUtLoQdssiWrdPsSCWWE/iW5IFtFYXaomcD2
        k2EgenkMRZjLFqEDMMUzy3/Snacp65dogGgCCpgnTMAkQFEmefzXKo83u78QhYEToWN5F4PTGMRgB
        LVSsxLSWjssLl3o2BIpQeb19HNFfHguT3ME/cQXCnIZmK4AiU4gIVwOt9IPOdvX00nNNanHxHAzQv
        J59t6aOaMUJg/fqNLwx8ptqtiFq8DNM0g1cPeZ38/kAiKESZuWJrc9cCntXfqyKDAs7/x+7sd8KGR
        bCh+B5HQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pNiQS-00DnTW-1U; Thu, 02 Feb 2023 22:51:28 +0000
Date:   Thu, 2 Feb 2023 22:51:27 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Marcelo Tosatti <mtosatti@redhat.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Frederic Weisbecker <frederic@kernel.org>,
        Leonardo Bras <leobras@redhat.com>,
        Yair Podemsky <ypodemsk@redhat.com>, P J P <ppandit@redhat.com>
Subject: Re: [PATCH v3] fs/buffer.c: update per-CPU bh_lru cache via RCU
Message-ID: <Y9w+b1MJ10uPDROI@casper.infradead.org>
References: <Y9qM68F+nDSYfrJ1@tpad>
 <20230202223653.GF937597@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230202223653.GF937597@dread.disaster.area>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 03, 2023 at 09:36:53AM +1100, Dave Chinner wrote:
> On Wed, Feb 01, 2023 at 01:01:47PM -0300, Marcelo Tosatti wrote:
> > 
> > umount calls invalidate_bh_lrus which IPIs each
> 
> via invalidate_bdev(). So this is only triggered on unmount of
> filesystems that use the block device mapping directly, right?
> 
> Or is the problem that userspace is polling the block device (e.g.
> udisks, blkid, etc) whilst the filesystem is mounted and populating
> the block device mapping with cached pages so invalidate_bdev()
> always does work even when the filesystem doesn't actually use the
> bdev mapping?
> 
> > CPU that has non empty per-CPU buffer_head cache:
> > 
> >        	on_each_cpu_cond(has_bh_in_lru, invalidate_bh_lru, NULL, 1);
> > 
> > This interrupts CPUs which might be executing code sensitive
> > to interferences.
> > 
> > To avoid the IPI, free the per-CPU caches remotely via RCU.
> > Two bh_lrus structures for each CPU are allocated: one is being
> > used (assigned to per-CPU bh_lru pointer), and the other is
> > being freed (or idle).
> 
> Rather than adding more complexity to the legacy bufferhead code,
> wouldn't it be better to switch the block device mapping to use
> iomap+folios and get rid of the use of bufferheads altogether?

Pretty sure ext4's journalling relies on the blockdev using
buffer_heads.  At least, I did a conversion of blockdev to use
mpage_readahead() and ext4 stopped working.
