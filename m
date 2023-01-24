Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E38B67908B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 06:58:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233023AbjAXF6c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Jan 2023 00:58:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232977AbjAXF63 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Jan 2023 00:58:29 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAF6D303C8;
        Mon, 23 Jan 2023 21:58:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MWNNRHw2sWxkb7fRYPZPKkDs8yAj4vB10hhJP/CIuZk=; b=KOkZfWHE68/PeSOfME2tee5dDa
        JkGrAYpWiQ1HobLr3Xq2I7iD3zq0otuz8oGO2tXGm4dJ1IKX2rNc+K7JD28EhK8j2IXdFoNuHyAiP
        CbvzZ1ajVll/vWzV6Ybsqo4o3C38aGXBqOhWAQY+rmSuV2oKTj0gIiAmP6A4el9dv8wGAEicPjDit
        SoWBYSIhq/qXQXz2Tn0yGQsh0ijeYSkiy+iZE4/r+MLTq1wnbn/eP2I6mul4Xu2Ri4EEEq18IXh/O
        TxDDMSA1V8zwm2iTXu11GRC/YevpRlxnxJ7plHMSaizi5/nBVfKGJBKgHCzSoQVSnKtpIUmNVhUM8
        QmIqEn0g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pKCJi-002T1k-5W; Tue, 24 Jan 2023 05:57:58 +0000
Date:   Mon, 23 Jan 2023 21:57:58 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Jan Kara <jack@suse.cz>, David Howells <dhowells@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        linux-mm@kvack.org
Subject: Re: [PATCH v7 2/8] iov_iter: Add a function to extract a page list
 from an iterator
Message-ID: <Y89zZofd63LCZYcG@infradead.org>
References: <c742e47b-dcc0-1fef-dc8c-3bf85d26b046@redhat.com>
 <7bbcccc9-6ebf-ffab-7425-2a12f217ba15@redhat.com>
 <246ba813-698b-8696-7f4d-400034a3380b@redhat.com>
 <20230120175556.3556978-1-dhowells@redhat.com>
 <20230120175556.3556978-3-dhowells@redhat.com>
 <3814749.1674474663@warthog.procyon.org.uk>
 <3903251.1674479992@warthog.procyon.org.uk>
 <3911637.1674481111@warthog.procyon.org.uk>
 <20230123161114.4jv6hnnbckqyrurs@quack3>
 <c3e0b810-9f17-edb7-de6b-7849273381d0@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3e0b810-9f17-edb7-de6b-7849273381d0@nvidia.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 23, 2023 at 03:07:48PM -0800, John Hubbard wrote:
> On 1/23/23 08:11, Jan Kara wrote:
> > > For cifs RDMA, do I need to make it pass in FOLL_LONGTERM?  And does that need
> > > a special cleanup?
> > 
> > FOLL_LONGTERM doesn't need a special cleanup AFAIK. It should be used
> > whenever there isn't reasonably bound time after which the page is
> > unpinned. So in case CIFS sets up RDMA and then it is up to userspace how
> > long the RDMA is going to be running it should be using FOLL_LONGTERM. The
> 
> Yes, we have been pretty consistently deciding that RDMA generally
> implies FOLL_LONGTERM. (And furthermore, FOLL_LONGTERM implies
> FOLL_PIN--that one is actually enforced by the gup/pup APIs.)

That's weird.  For storage or file systems, pages are pinnen just as
long when using RDMA as when using local DMA, in fact if you do RDMA
to really fast remote media vs slow local media (e.g. SSD vs disk) you
might pin it shorter when using RDMA.

I think FOLL_LONGTERM makes sense for non-ODP user space memory
registrations for RDMA, which will last basically forever.  It does
not really make much sense at all for in-kernel memory registration for
RDMA that are very short term.
