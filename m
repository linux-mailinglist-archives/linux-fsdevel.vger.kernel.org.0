Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9BCE5AE0E4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Sep 2022 09:22:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238845AbiIFHWO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Sep 2022 03:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231398AbiIFHWN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Sep 2022 03:22:13 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1695F7393C;
        Tue,  6 Sep 2022 00:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=EHkWMjiSw6sMSHyk1j8ZDqGlGyNnE9pNuM0MT92Hdqk=; b=sEDZ5UjlGn93jHjXSEkts3JDd6
        FWZwllRmftVq6Bf3K9hrkiAayQf7kTE1lZmaT2SaA7oLv1PyExzyofzMNCgBS1C2Z6rsSugqADthJ
        7VpRieGXMNQBFDYEnXqb/VWQL8U1iFVztWKLDvSycJb+MN3aGWOLjHyONWzFsW2SIoopERqYNVAUX
        lbagcl6lzY277wvyHs4mJwfxbv8/uEpjjD66JSj5xWw4zoBWDRleTqK2DHTB+/wJ0mbEDX/vP87mF
        DyzJnia5+03A6jPHKeKFvBiC10WJBwHgsJmzrg2wwv4DfNCJPQ1iDBZ7izyurOhu0WggtuqNHjI5o
        cfTLMbDA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oVSuG-00Akwx-OK; Tue, 06 Sep 2022 07:22:00 +0000
Date:   Tue, 6 Sep 2022 00:22:00 -0700
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
Subject: Re: [PATCH v2 0/7] convert most filesystems to pin_user_pages_fast()
Message-ID: <Yxb1GKaiVkz7Bn2K@infradead.org>
References: <20220831041843.973026-1-jhubbard@nvidia.com>
 <YxbqUvDJ/rJsLMPZ@infradead.org>
 <50d1d649-cb41-3031-c459-bbd38295c619@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50d1d649-cb41-3031-c459-bbd38295c619@nvidia.com>
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

On Tue, Sep 06, 2022 at 12:10:54AM -0700, John Hubbard wrote:
> I would be delighted if that were somehow possible. Every time I think
> it's possible, it has fallen apart. The fact that bio_release_pages()
> will need to switch over from put_page() to unpin_user_page(), combined
> with the fact that there are a lot of callers that submit bios, has
> led me to the current approach.

We can (temporarily) pass the gup flag to bio_release_pages or even
better add a new bio_unpin_pages helper that undoes the pin side.
That is: don't try to reuse the old APIs, but ad new ones, just like
we do on the lower layers.
