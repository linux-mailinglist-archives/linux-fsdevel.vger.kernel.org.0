Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C70545AFF7E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Sep 2022 10:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbiIGIpo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Sep 2022 04:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiIGIpm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Sep 2022 04:45:42 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86E3C72EE1;
        Wed,  7 Sep 2022 01:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=EBn6+PekQ9HgWpOyL3HjDLpM5I9iK8a5/LWby5GXm9w=; b=oVetsvWLvH5eTqsi2zWONtOAC3
        rpZ6+qvDKI37kr2ze2cMlVgkhAfvPg6uiUWsrUYR9ZcUyYQNl4xeK1t6c4whmVHD1E23Mhxgz01wR
        vXF5bBSal2savl00zL3GewiEwtqdPIW0eH0UH4EbDt3Wi2PxSzFltT2mdaBrlbik3gmpqAjya3jSQ
        NGIUR67sBaEfsENy+OvVHmXQ7qCuMwLTtqbOKQl1Wv+5Kl/t2anvwTp1DeYUFuU8DAs/eLpqyNY3y
        FxW4UOxkCgD0Il8Z5AF1hAzQ0cfHvx1nSsH2xsI4w6iHAzjsFq53EgVIyPzPpxzmtV9iZ+vo4btdE
        qjixFbYg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oVqgY-004SGZ-4V; Wed, 07 Sep 2022 08:45:26 +0000
Date:   Wed, 7 Sep 2022 01:45:26 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Christoph Hellwig <hch@infradead.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
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
Message-ID: <YxhaJktqtHw3QTSG@infradead.org>
References: <20220831041843.973026-1-jhubbard@nvidia.com>
 <20220831041843.973026-5-jhubbard@nvidia.com>
 <YxbtF1O8+kXhTNaj@infradead.org>
 <103fe662-3dc8-35cb-1a68-dda8af95c518@nvidia.com>
 <Yxb7YQWgjHkZet4u@infradead.org>
 <20220906102106.q23ovgyjyrsnbhkp@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220906102106.q23ovgyjyrsnbhkp@quack3>
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

On Tue, Sep 06, 2022 at 12:21:06PM +0200, Jan Kara wrote:
> > For FOLL_PIN callers, never pin bvec and kvec pages:  For file systems
> > not acquiring a reference is obviously safe, and the other callers will
> > need an audit, but I can't think of why it woul  ever be unsafe.
> 
> Are you sure about "For file systems not acquiring a reference is obviously
> safe"? I can see places e.g. in orangefs, afs, etc. which create bvec iters
> from pagecache pages. And then we have iter_file_splice_write() which
> creates bvec from pipe pages (which can also be pagecache pages if
> vmsplice() is used). So perhaps there are no lifetime issues even without
> acquiring a reference (but looking at the code I would not say it is
> obvious) but I definitely don't see how it would be safe to not get a pin
> to signal to filesystem backing the pagecache page that there is DMA
> happening to/from the page.

I mean in the context of iov_iter_get_pages callers, that is direct
I/O.  Direct callers of iov_iter_bvec which then pass that iov to
->read_iter / ->write_iter will need to hold references (those are
the references that the callers of iov_iter_get_pages rely on!).
