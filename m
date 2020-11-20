Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CDDF2BA0AA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Nov 2020 03:55:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbgKTCzA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Nov 2020 21:55:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbgKTCzA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Nov 2020 21:55:00 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29C9EC0613CF;
        Thu, 19 Nov 2020 18:55:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jvn+KMDsmyCAOnl/eEDj/eaq4/3pkp2Gxkg1M/4pZI8=; b=i7WxRkyicXc6O7brzAVt9euJqe
        xVEYhNtsX+CyrrZn1V9r2jBaqTzeEIEr1Wl8gcNsZSsPBVGLMBKLElxsNihdHmkKwK7IfxomLu/D3
        k90+JnnsxS4TAwx0GQzE49IU9t/bzgRAaXE5MMFjWhHCsN7nWU9ov1HN7qpVz7p+QaD9yPAthQZrh
        b8X1oBRPsZ17dqZbrw9owqEHTkIA4rnbBcePv/7srH3gkjgnEE/41prmMxMQmpj8xpZxydBuJ77CY
        tGyHb2em2SoD0LML6yOeInxpoHV0gOMjQIuoHAAVKbWJtqzfuAAbIDf2lSOr8JQ7cmqk0YB6aES/h
        KkuveGDA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kfwZd-00018i-9A; Fri, 20 Nov 2020 02:54:57 +0000
Date:   Fri, 20 Nov 2020 02:54:57 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Pavel Begunkov <asml.silence@gmail.com>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] iov_iter: optimise iov_iter_npages for bvec
Message-ID: <20201120025457.GM29991@casper.infradead.org>
References: <cover.1605827965.git.asml.silence@gmail.com>
 <ab04202d0f8c1424da47251085657c436d762785.1605827965.git.asml.silence@gmail.com>
 <20201120012017.GJ29991@casper.infradead.org>
 <35d5db17-f6f6-ec32-944e-5ecddcbcb0f1@gmail.com>
 <20201120022200.GB333150@T590>
 <e70a3c05-a968-7802-df81-0529eaa7f7b4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e70a3c05-a968-7802-df81-0529eaa7f7b4@gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 20, 2020 at 02:25:08AM +0000, Pavel Begunkov wrote:
> On 20/11/2020 02:22, Ming Lei wrote:
> > iov_iter_npages(bvec) still can be improved a bit by the following way:
> 
> Yep, was doing exactly that, +a couple of other places that are in my way.

Are you optimising the right thing here?  Assuming you're looking at
the one in do_blockdev_direct_IO(), wouldn't we be better off figuring
out how to copy the bvecs directly from the iov_iter into the bio
rather than calling dio_bio_add_page() for each page?
