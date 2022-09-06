Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1552B5AE021
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Sep 2022 08:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238648AbiIFGsE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Sep 2022 02:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238495AbiIFGsC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Sep 2022 02:48:02 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B65846FA2A;
        Mon,  5 Sep 2022 23:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=oFuTZk4zKE5mAVI0W5HcV1QEwth0M1OUe/8JfOFc7i4=; b=qu2isCifsZ2DAo2Q5ZJ8unnHj8
        lYJqoyJRc11lTwpPaUNVLA+1+Y87Tvpx76OepMVZu+0gIu/+vIuNEeff37Z4KS8KT//T7tAbGaLko
        XyDJaWYJhzxKG8CK4N4THMRd/2w88PEn3nJp0mia12EUesXoFRN4lHfipW1PMHBt6cJA88nJzgmQv
        XpF7iA46K9x9Mp0blxVRAOYNNICAbtjNtF+rYr+zfhmIpxZDK4CKNHRp6VKJpXp5gwGZFE0pc2KY9
        WGnsJmMDwaaAi+FpCAyEsH5JCqI8U2PJBGjMc4jwhsPw+cHPHYzJolat+Lpf3slGwBhEmDxRmrJ58
        M9K8XWLQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oVSND-00AXVf-Qh; Tue, 06 Sep 2022 06:47:51 +0000
Date:   Mon, 5 Sep 2022 23:47:51 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>, Jan Kara <jack@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/7] iov_iter: new iov_iter_pin_pages*() routines
Message-ID: <YxbtF1O8+kXhTNaj@infradead.org>
References: <20220831041843.973026-1-jhubbard@nvidia.com>
 <20220831041843.973026-5-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220831041843.973026-5-jhubbard@nvidia.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I'd it one step back.  For BVECS we never need a get or pin.  The
block layer already does this, an the other callers should as well.
For KVEC the same is true.  For PIPE and xarray as you pointed out
we can probably just do the pin, it is not like these are performance
paths.

So, I'd suggest to:

 - factor out the user backed and bvec cases from
   __iov_iter_get_pages_alloc into helper just to keep
   __iov_iter_get_pages_alloc readable.
 - for the pin case don't use the existing bvec helper at all, but
   copy the logic for the block layer for not pinning.
