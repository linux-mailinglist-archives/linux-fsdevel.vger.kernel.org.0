Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31A1B5AFF8F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Sep 2022 10:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbiIGIuV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Sep 2022 04:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiIGIuU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Sep 2022 04:50:20 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7524A21821;
        Wed,  7 Sep 2022 01:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/OVlAwW7sTMujMAdfroN1GdwN81L832uh1HMrI/nvGo=; b=asGZyz3lnIp+c/31yhqNB3FuPy
        f6fsq8p0L7wSMvyxGmWAQ7k7NZXA1eW8Fz4M0BSsCva1X4pxrgUa0Jj5EZlR2l9B+vXdgDCPTT/ei
        hv27ApJ2tQ1Ap90kCx4akyi+6uLb9NhAhoyT9jCkH1RmNwcPq9Ca6MseOuKJ0IMa6ti04OfbSe/JT
        DHTLaZJKlRvDjpAARCk/hWwaebAM/2UdDrmcSqemR/RFF5H6Oz786lTv/ItQr3quy73LaWz0rz4Eb
        dGT3Cmwwf81BAHOyPBy3bfIK7zHFQ3qQTzQlvU5XEaKcPTYksp4/xPJnO9DpwqIAtcbV156GaV/b7
        Cx8x3Nng==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oVql9-004Ux0-J9; Wed, 07 Sep 2022 08:50:11 +0000
Date:   Wed, 7 Sep 2022 01:50:11 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>, Jan Kara <jack@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/7] iov_iter: new iov_iter_pin_pages*() routines
Message-ID: <YxhbQ/oVMvt3nG9i@infradead.org>
References: <20220831041843.973026-1-jhubbard@nvidia.com>
 <20220831041843.973026-5-jhubbard@nvidia.com>
 <YxbtF1O8+kXhTNaj@infradead.org>
 <103fe662-3dc8-35cb-1a68-dda8af95c518@nvidia.com>
 <Yxb7YQWgjHkZet4u@infradead.org>
 <d1535f25-b252-ee38-8eb8-94af9367d5f1@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1535f25-b252-ee38-8eb8-94af9367d5f1@nvidia.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 06, 2022 at 12:58:59AM -0700, John Hubbard wrote:
> > For FOLL_PIN callers, never pin bvec and kvec pages:  For file systems
> > not acquiring a reference is obviously safe, and the other callers will
> > need an audit, but I can't think of why it woul  ever be unsafe.
> 
> In order to do that, one would need to be confident that such bvec and kvec
> pages do not get passed down to bio_release_pages() (or the new
> bio_unpin_pages()). Also, I'm missing a key point, because today bvec pages get
> a get_page() reference from __iov_iter_get_pages_alloc(). If I just skip
> that, then the get/put calls are unbalanced...

Except that for the most relevant callers (bdev and iomap) we never
end up in __iov_iter_get_pages_alloc. What I suggest is that, with
the move to the pin helper, we codify that logic.

For callers of the bio_iov_iter_pin_pages helper, the corresponding
bio_unpin_pages helper will encapsulate that logic.  For direct calls
to iov_iter_pin_pages, we should add a iov_iter_unpin_pages helper that
also encapsulates the logic.  The beauty is that this means the caller
itself does not have to care about any of thise, and the logic is in
one (well two due to the block special case that reuses the bio_vec
array for the pages space) place.

> I can just hear Al Viro repeating his points about splice() and vmsplice(),
> heh. :)

splice does take these references before calling into the file system
(see my reply to Jan).
