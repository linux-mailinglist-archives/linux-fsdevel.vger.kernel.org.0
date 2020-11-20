Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC372BAF7D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Nov 2020 17:03:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728919AbgKTQAP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Nov 2020 11:00:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728200AbgKTQAO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Nov 2020 11:00:14 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88B73C0613CF;
        Fri, 20 Nov 2020 08:00:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=K5DwT3XZlV3t3RqqSgbM35Y3HrzhNkm8y+Dk2IlqgSg=; b=dKbyJHe0CTU5aQ7qzS3y+R7HzS
        IKnP9HvhkePlkizqwksisFX9ItaAwMtV42JJBmP3ZX68rybYyhhyxN6HF+4s2kqLrzwOxCN590LXF
        ym0WaBVLMdq9rLFtADBHBTFGjcyPZEqJfC7pbYTLnera5pnBeS3gKB7QoEHsSi8lIOiJp2cbk5Dht
        3B0uQlIfZ8f/1YczBdK4QRRNeBKzTo4B1VHMay+VPY7OTUi8keSXIo2ShWdFB8ho8zwbUkIe8+1eP
        wuIgrB00p1rgPw8SIw6y1czXZtN+QrCR9MWZkdKvvhRmCPfud3TmejnBZGx0dJq2Oq4i98pjwEUY2
        dBwSlL3g==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kg8pI-0005Bl-Jz; Fri, 20 Nov 2020 15:59:56 +0000
Date:   Fri, 20 Nov 2020 15:59:56 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Coly Li <colyli@suse.de>, Mike Snitzer <snitzer@redhat.com>,
        dm-devel@redhat.com, Richard Weinberger <richard@nod.at>,
        Jan Kara <jack@suse.com>, linux-block@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-bcache@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 14/20] block: remove the nr_sects field in struct
 hd_struct
Message-ID: <20201120155956.GB4327@casper.infradead.org>
References: <20201118084800.2339180-1-hch@lst.de>
 <20201118084800.2339180-15-hch@lst.de>
 <20201119120525.GW1981@quack2.suse.cz>
 <20201120090820.GD21715@lst.de>
 <20201120112121.GB15537@quack2.suse.cz>
 <20201120153253.GA18990@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201120153253.GA18990@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 20, 2020 at 04:32:53PM +0100, Christoph Hellwig wrote:
> On Fri, Nov 20, 2020 at 12:21:21PM +0100, Jan Kara wrote:
> > > > AFAICT bd_size_lock is pointless after these changes so we can just remove
> > > > it?
> > > 
> > > I don't think it is, as reuqiring bd_mutex for size updates leads to
> > > rather awkward lock ordering problems.
> > 
> > OK, let me ask differently: What is bd_size_lock protecting now? Ah, I see,
> > on 32-bit it is needed to prevent torn writes to i_size, right?
> 
> Exactly.  In theory we could skip it for 64-bit, but as updating the
> size isn't a fast path, and struct block_device isn't super size critical
> I'd rather keep the same code for 32 vs 64-bit builds.

Is it better to switch to i_size_write() / i_size_read()?
