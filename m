Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0087B5AE17F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Sep 2022 09:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239022AbiIFHqh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Sep 2022 03:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238970AbiIFHqd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Sep 2022 03:46:33 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 289FF6FA37;
        Tue,  6 Sep 2022 00:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=h9eaPItotJ7UIpRDKaJ9/my+8DVdUgH18U/XWRw9gVo=; b=SCvMLvtlCWYzBebXM8+WkKDrjo
        ymTnnTY52kxYFnUiA7OTVNS90YUq+kTYFgbjNWAuKGJ1QUdWwKQmu/AQlrqji5v3r433FIog5S7GM
        CTNKqeQaustPu5E1Z2coPLUA1ovGNEALpYvfdIhaKAa1u246QTcS96pf5SR6Mk6ERVk/i1F46Ux48
        8yglEbpXh4+GYqEWV2oxHIdfsk3Q0SNZYqjPSe2QnhIY6zTUsDocMzZ7nDFkFnmsuv7dnfrLvHZNv
        FDWqRXMlHaQmtBt30Vz0Z8RXXV3zY8Y0c7UBJiD110xs5iCZHGkAQijzg3Gn4QCza4UVETpoPvC8m
        /y4OZTWw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oVTHj-00AuQK-AA; Tue, 06 Sep 2022 07:46:15 +0000
Date:   Tue, 6 Sep 2022 00:46:15 -0700
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
Message-ID: <Yxb6x50XqTfxrqB1@infradead.org>
References: <20220831041843.973026-1-jhubbard@nvidia.com>
 <YxbqUvDJ/rJsLMPZ@infradead.org>
 <50d1d649-cb41-3031-c459-bbd38295c619@nvidia.com>
 <Yxb1GKaiVkz7Bn2K@infradead.org>
 <ebdbc31d-68a3-e168-7344-6b1e3aa86e28@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ebdbc31d-68a3-e168-7344-6b1e3aa86e28@nvidia.com>
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

On Tue, Sep 06, 2022 at 12:37:00AM -0700, John Hubbard wrote:
> On 9/6/22 00:22, Christoph Hellwig wrote:
> > On Tue, Sep 06, 2022 at 12:10:54AM -0700, John Hubbard wrote:
> >> I would be delighted if that were somehow possible. Every time I think
> >> it's possible, it has fallen apart. The fact that bio_release_pages()
> >> will need to switch over from put_page() to unpin_user_page(), combined
> >> with the fact that there are a lot of callers that submit bios, has
> >> led me to the current approach.
> > 
> > We can (temporarily) pass the gup flag to bio_release_pages or even
> > better add a new bio_unpin_pages helper that undoes the pin side.
> > That is: don't try to reuse the old APIs, but ad new ones, just like
> > we do on the lower layers.
> 
> OK...so, to confirm: the idea is to convert these callsites (below) to
> call a new bio_unpin_pages() routine that does unpin_user_page().

Yeah.  And to stay symmetric also a new bio_iov_iter_pin_pages for
the pin side.
