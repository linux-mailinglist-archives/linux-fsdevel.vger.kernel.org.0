Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 646882BA46E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Nov 2020 09:17:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbgKTIOd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Nov 2020 03:14:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbgKTIOc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Nov 2020 03:14:32 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98662C0613CF;
        Fri, 20 Nov 2020 00:14:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9eTcmneDEkMa+Ci3UvbK1WCqbss7MNqMPJgSFOsLpRE=; b=Bt4O35kZ1R0xwyIj1tfdoQRbiJ
        RLqNsohzyZnBavvjnUbi4J/vPlbtPqB0v+F8c9zPB+fUoVnbd5Idu9mS2GlQ+pcXguuGCx/m7HvTA
        vWp0oGm/wap0CLaD/6FSdL+5SJQdQ1D22M5Nc/fSvF8QKUUcpZPbxF7f0OKNadAZ9KCx5afiHjIhD
        lXYwI7oXj9FkegV6Qo7M6ozH/OSVrzhzBDaVnEtIbHPaq0cd+VyRHyq8CsUPSducO55uG+cCDLXa0
        gRXxiOW5Jhre/lGXZA2QM46wS3mieoX8TC4q9IMumt8zorTdWo3Cs+0B7vkl/+8qTQuSXsxf1+eUU
        zoXCegvA==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kg1Yr-0000Ag-Fs; Fri, 20 Nov 2020 08:14:29 +0000
Date:   Fri, 20 Nov 2020 08:14:29 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Pavel Begunkov <asml.silence@gmail.com>,
        Ming Lei <ming.lei@redhat.com>, linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] iov_iter: optimise iov_iter_npages for bvec
Message-ID: <20201120081429.GA30801@infradead.org>
References: <cover.1605827965.git.asml.silence@gmail.com>
 <ab04202d0f8c1424da47251085657c436d762785.1605827965.git.asml.silence@gmail.com>
 <20201120012017.GJ29991@casper.infradead.org>
 <35d5db17-f6f6-ec32-944e-5ecddcbcb0f1@gmail.com>
 <20201120022200.GB333150@T590>
 <e70a3c05-a968-7802-df81-0529eaa7f7b4@gmail.com>
 <20201120025457.GM29991@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201120025457.GM29991@casper.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 20, 2020 at 02:54:57AM +0000, Matthew Wilcox wrote:
> On Fri, Nov 20, 2020 at 02:25:08AM +0000, Pavel Begunkov wrote:
> > On 20/11/2020 02:22, Ming Lei wrote:
> > > iov_iter_npages(bvec) still can be improved a bit by the following way:
> > 
> > Yep, was doing exactly that, +a couple of other places that are in my way.
> 
> Are you optimising the right thing here?  Assuming you're looking at
> the one in do_blockdev_direct_IO(), wouldn't we be better off figuring
> out how to copy the bvecs directly from the iov_iter into the bio
> rather than calling dio_bio_add_page() for each page?

Which is most effectively done by stopping to to use *blockdev_direct_IO
and switching to iomap instead :)
