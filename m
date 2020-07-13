Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF55221A0F4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jul 2020 15:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbgGINcw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Jul 2020 09:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbgGINcv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Jul 2020 09:32:51 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91ECDC08C5CE;
        Thu,  9 Jul 2020 06:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0gGNHKM2ZqkJaYiaW1AZt7LL2IetnqBy8kFTuQiL4bo=; b=MiBl3pGLBwpSRcWZyz1mS/fd2N
        kjJ3uFquSnFMed6RZRnkiKVo1YzgxY8yEP3Ixuu4t54iAWc6ELxgTFFvVi/7N9pZDGfuug/ymK9d7
        VBIDZw/zLA4PhSCql5x3y4vLCkdDKm9BbjwnPS0oInR7JyKJQTqPgFrEh7j75RH/8+4eFJ3aadMM0
        QtrtaXPhgetei4O8IWo877ozl1QPEWR51VkR91KYF03EsIrNyJTPzcy7korpcTmV1gZmmyeab/Vko
        TYnlSXWMQ6+2R5xsOUGp46HdIyp5bq1229BB0/IXXlS369clZOi+Bbu23PYiIRfnHRU6/mD0QJa2I
        AM7uvYOw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jtWfR-0000qC-As; Thu, 09 Jul 2020 13:32:49 +0000
Date:   Thu, 9 Jul 2020 14:32:49 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        io-uring@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kanchan Joshi <joshi.k@samsung.com>,
        Javier Gonzalez <javier.gonz@samsung.com>
Subject: Re: [PATCH 0/2] Remove kiocb ki_complete
Message-ID: <20200709133249.GC12769@casper.infradead.org>
References: <20200708222637.23046-1-willy@infradead.org>
 <20200709101705.GA2095@infradead.org>
 <20200709111036.GA12769@casper.infradead.org>
 <20200709132611.GA1382@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200709132611.GA1382@infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 09, 2020 at 02:26:11PM +0100, Christoph Hellwig wrote:
> On Thu, Jul 09, 2020 at 12:10:36PM +0100, Matthew Wilcox wrote:
> > On Thu, Jul 09, 2020 at 11:17:05AM +0100, Christoph Hellwig wrote:
> > > I really don't like this series at all.  If saves a single pointer
> > > but introduces a complicated machinery that just doesn't follow any
> > > natural flow.  And there doesn't seem to be any good reason for it to
> > > start with.
> > 
> > Jens doesn't want the kiocb to grow beyond a single cacheline, and we
> > want the ability to set the loff_t in userspace for an appending write,
> > so the plan was to replace the ki_complete member in kiocb with an
> > loff_t __user *ki_posp.
> > 
> > I don't think it's worth worrying about growing kiocb, personally,
> > but this seemed like the easiest way to make room for a new pointer.
> 
> The user offset pointer has absolutely no business in the the kiocb
> itself - it is a io_uring concept which needs to go into the io_kiocb,
> which has 14 bytes left in the last cache line in my build.  It would
> fit in very well there right next to the result and user pointer.

I agree.  Jens doesn't.
