Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6FC55EAD54
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Sep 2022 18:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbiIZQ6I (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Sep 2022 12:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbiIZQ5w (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Sep 2022 12:57:52 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB07293;
        Mon, 26 Sep 2022 08:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GLjOCldwMSYbtIvOp9MNc738nkI+qSWqG0cQCtDGyYs=; b=iKgsgckx1BpnYBt1Ml1luRzlNo
        UEaD93VJ/NaxUNW6l6hN4BiK/C+lXg9TvmRBVZsr6VTRgniAUARhROkGwU1gb/+ga6hgyHbqIk4/Z
        MZ2vk2dp+YZ4n0PysUqI70IA94ZPELr3jKfzqB+j9wqcDa40U1/yUR6ed5i6U/Ooq6akJwUIH9LCc
        4FE9DI2L7LRdgnfG+csHbDb8jVG/m3HrQoeTsrshIrc6b/uSVjKzkoMcldkhksDV/gf35W549vzaw
        QW3k1gYHecYAhnbGFnhN3AfKto9jFnIhYWcwx925qCXeqVUi440PLfDtd4qG2idoghktcU6o/gEhs
        CpXOoeeQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ocqQR-005okf-Pg; Mon, 26 Sep 2022 15:53:43 +0000
Date:   Mon, 26 Sep 2022 08:53:43 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/7] iov_iter: new iov_iter_pin_pages*() routines
Message-ID: <YzHLB4lGa2vktN7W@infradead.org>
References: <YxhaJktqtHw3QTSG@infradead.org>
 <YyFPtTtxYozCuXvu@ZenIV>
 <20220914145233.cyeljaku4egeu4x2@quack3>
 <YyIEgD8ksSZTsUdJ@ZenIV>
 <20220915081625.6a72nza6yq4l5etp@quack3>
 <YyvG+Oih2A37Grcf@ZenIV>
 <YyxzYTlyGhbb2MOu@infradead.org>
 <Yy00eSjyxvUIp7D5@ZenIV>
 <Yy1x8QE9YA4HHzbQ@infradead.org>
 <Yy3bNjaiUoGv/djG@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yy3bNjaiUoGv/djG@ZenIV>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 23, 2022 at 05:13:42PM +0100, Al Viro wrote:
> You are mixing two issues here - holding references to pages while using
> iov_iter instance is obvious; holding them until async IO is complete, even
> though struct iov_iter might be long gone by that point is a different
> story.

But someone needs to hold a refernce until the I/O is completed, because
the I/O obviously needs the pages.  Yes, we could say the callers holds
them and can drop the references right after I/O submission, while
the method needs to grab another reference.  But that is more
complicated and is more costly than just holding the damn reference.

> And originating iov_iter instance really can be long-gone by the time
> of IO completion - requirement to keep it around would be very hard to
> satisfy.  I've no objections to requiring the pages in ITER_BVEC to be
> preserved at least until the IO completion by means independent of
> whatever ->read_iter/->write_iter does to them, but
> 	* that needs to be spelled out very clearly and
> 	* we need to verify that it is, indeed, the case for all existing
> iov_iter_bvec callers, preferably with comments next to non-obvious ones
> (something that is followed only by the sync IO is obvious)

Agreed.

> That goes not just for bio - if we make get_pages *NOT* grab references
> on ITER_BVEC (and I'm all for it), we need to make sure that those
> pages won't be retained after the original protection runs out.

Yes.
