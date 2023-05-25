Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE6F71093B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 May 2023 11:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240649AbjEYJwX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 May 2023 05:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240596AbjEYJwV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 May 2023 05:52:21 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7204F12E;
        Thu, 25 May 2023 02:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nTS/g9fJs1n3cdqbVQhwwN534SXRQ6PP71rBH26gs+o=; b=p6e1VERz8010nQ39lyNEHKlZBJ
        u9uCZI7CPHvLK/QvHgpdsWDLzUhplfc6m6cEzj55zPcPok5rXriocAueZ1L7Ki/vq26U2hpg5MZsm
        1yfwE4fnYycZ5TFY4ZKPWVnReI263wRCmC4HazkrJ0eux7gIHW/BqfQmLKEN3i+9iCWObA//GMWYP
        dCXg2ypvVErRh3xsgKvmYz4gsBD7MxC0PSkssl7fofWrUTvacF23jY8czbQSQYguj0z6jHHWEfCTO
        OxCsTp8QjVVMEcONNlV88MyIBTwC+QiOz3MHJU7cNVzxST4eLSM0aeP+cJeKSPlOHdZ4uQgr72pKp
        1+4+U46Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q27dX-00GC8e-19;
        Thu, 25 May 2023 09:51:59 +0000
Date:   Thu, 25 May 2023 02:51:59 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Christian Brauner <brauner@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: Extending page pinning into fs/direct-io.c
Message-ID: <ZG8vvzbUdFmsLv5Z@infradead.org>
References: <ZG2m0PGztI2BZEn9@infradead.org>
 <ZGxfrOLZ4aN9/MvE@infradead.org>
 <20230522205744.2825689-1-dhowells@redhat.com>
 <3068545.1684872971@warthog.procyon.org.uk>
 <3215177.1684918030@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3215177.1684918030@warthog.procyon.org.uk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 24, 2023 at 09:47:10AM +0100, David Howells wrote:
> True - but I was thinking of just treating the zero_page specially and never
> hold a pin or a ref on it.  It can be checked by address, e.g.:
> 
>     static inline void bio_release_page(struct bio *bio, struct page *page)
>     {
> 	    if (page == ZERO_PAGE(0))
> 		    return;
> 	    if (bio_flagged(bio, BIO_PAGE_PINNED))
> 		    unpin_user_page(page);
> 	    else if (bio_flagged(bio, BIO_PAGE_REFFED))
> 		    put_page(page);
>     }

That does sound good as well to me.

> I was looking at this:
> 
>     static inline void dio_bio_submit(struct dio *dio, struct dio_submit *sdio)
>     {
>     ...
> 	    if (dio->is_async && dio_op == REQ_OP_READ && dio->should_dirty)
> 		    bio_set_pages_dirty(bio);
>     ...
>     }
> 
> but looking again, the lock is taken briefly and the dirty bit is set - which
> is reasonable.  However, should we be doing it before starting the I/O?

It is done before starting the I/O - the submit_bio is just below this.

