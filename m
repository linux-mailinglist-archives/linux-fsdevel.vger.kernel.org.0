Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6657A5AE191
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Sep 2022 09:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239085AbiIFHtA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Sep 2022 03:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233978AbiIFHs5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Sep 2022 03:48:57 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 222AB5F98C;
        Tue,  6 Sep 2022 00:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=//VHbIAzK137JUV3wdYi+bkIg+RFNtTNOapoAnB6JWQ=; b=ClmaQqYV3Rr7HMvl1VZYIfZnCR
        jRe7hf3xcMU++YZlWuqWFGV7yOxXgIpw5cfVwrcGrONCrbaLvQbyG3imcg0L5ArK9A2drD7kyElWW
        nXQKaVxFJrG3tR0Z4U4Px3R7OpWn36TNcpqBIShyq99RxBc7AjqZgGjYsk8t2hNNt06e5WjA8H/ty
        RyHuTiOQV01VXnapEk24jH+CnWL3HTVChFhLI0VOiL1YDAush7xV3xHWLUNZICcRFCQ+31s25Ab2f
        NJZGx1AeyvkBlwLScjl7adl9Vy5CQ+Nyntlh4EwdZzr43wsKaXw1wEaH0wDR88TobrWWo+qXS2DCW
        PiCuP0Rg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oVTKD-00Avjf-6M; Tue, 06 Sep 2022 07:48:49 +0000
Date:   Tue, 6 Sep 2022 00:48:49 -0700
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
Message-ID: <Yxb7YQWgjHkZet4u@infradead.org>
References: <20220831041843.973026-1-jhubbard@nvidia.com>
 <20220831041843.973026-5-jhubbard@nvidia.com>
 <YxbtF1O8+kXhTNaj@infradead.org>
 <103fe662-3dc8-35cb-1a68-dda8af95c518@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <103fe662-3dc8-35cb-1a68-dda8af95c518@nvidia.com>
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

On Tue, Sep 06, 2022 at 12:44:28AM -0700, John Hubbard wrote:
> OK, that part is clear.
> 
> >  - for the pin case don't use the existing bvec helper at all, but
> >    copy the logic for the block layer for not pinning.
> 
> I'm almost, but not quite sure I get the idea above. Overall, what
> happens to bvec pages? Leave the get_page() pin in place for FOLL_GET
> (or USE_FOLL_GET), I suppose, but do...what, for FOLL_PIN callers?

Do not change anyhing for FOLL_GET callers, as they are on the way out
anyway.

For FOLL_PIN callers, never pin bvec and kvec pages:  For file systems
not acquiring a reference is obviously safe, and the other callers will
need an audit, but I can't think of why it woul  ever be unsafe.
