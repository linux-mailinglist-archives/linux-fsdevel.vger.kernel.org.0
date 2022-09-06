Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD33E5AE035
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Sep 2022 08:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238707AbiIFGuJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Sep 2022 02:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238690AbiIFGuB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Sep 2022 02:50:01 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D75D1CFFD;
        Mon,  5 Sep 2022 23:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=29BCCHFkbIUvIEkJ/NT2axzz3sINy2OSORQKgk8fFZA=; b=RxGtQVXb+DTaBvy7bbOri5nYAg
        Vlb1SRCZHEDoJqUOVg0QSh7MMLoV+F9l+kk4YFZmCrpL4bfLviIzZt86aP7PMF/Sx755TIndJqbn2
        vUYABmKgOwA6ZRqXcimL9pgJJ/QYUIHXV5GPYKvCROQx062hhMR+mCOgD1Tn18Us8aW8nvBeVfpny
        Umh8wtLdaRIrBIAzAa53a/M3auCX0EPffzuBfmut/XNIDXEkkgr0EosOkxeA2x9Vhb+scbIFZ1v0Z
        GytoOg3FHHaIiluF0aHHfUt7G5QMYlm5BzF4uSByddA4H+J+Sl3785RSLNpiy5z62/QmKRpYIwMBR
        0e7+915A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oVSP8-00AYGR-D8; Tue, 06 Sep 2022 06:49:50 +0000
Date:   Mon, 5 Sep 2022 23:49:50 -0700
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
Subject: Re: [PATCH v2 6/7] NFS: direct-io: convert to FOLL_PIN pages
Message-ID: <YxbtjijmfGaKIbIV@infradead.org>
References: <20220831041843.973026-1-jhubbard@nvidia.com>
 <20220831041843.973026-7-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220831041843.973026-7-jhubbard@nvidia.com>
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

On Tue, Aug 30, 2022 at 09:18:42PM -0700, John Hubbard wrote:
static void nfs_direct_release_pages(struct iov_iter *iter, struct page **pages,
				     unsigned int npages)
>  {
> -	unsigned int i;
> -	for (i = 0; i < npages; i++)
> -		put_page(pages[i]);
> +	if (user_backed_iter(iter) || iov_iter_is_bvec(iter))
> +		dio_w_unpin_user_pages(pages, npages);
> +	else
> +		release_pages(pages, npages);

Instead of having this magic in all kinds of places, we need a helper
that takes the page array, npages and iter->type and does the right
thing.
