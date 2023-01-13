Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A4DE668B60
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jan 2023 06:31:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbjAMFba (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Jan 2023 00:31:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234010AbjAMFaj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Jan 2023 00:30:39 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7442262191;
        Thu, 12 Jan 2023 21:30:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jrUNW0xvWBPVni6kRybH/pnEJwmHcW0kAeuuygbCWoQ=; b=UgohmtQp7jIUoaBa1Vo/vb8yqI
        Q52BrZrOyE6yqQHYWt64OFIeUBtdL7/4p3f3y08dcdM7ThVYhgDVNEUG0wr+y1wYhkkLzwEFJolR3
        1KtB9755ALoc9mSUEnZjjdCddlACdu9+YlJp8Kn3OV//MhuA3dIv/mbSnxRwYGVvDkAbxCGvFbnpK
        +QEzBluchlXTr5YC5Ft7wUawwZkxWJB1AsplUQd4XQRzFQovlLQlhkEP2IcX8mA8FQ5S/YtvJQbF2
        W6RR50AVfNM4hZd0Xgif3p70XCQaaSZQCeI7MddCsJ//e0BhnBbMp4FXgwad38H8PkKVMmPELvRws
        tlxUF0jg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pGCe7-000V7w-Sc; Fri, 13 Jan 2023 05:30:31 +0000
Date:   Thu, 12 Jan 2023 21:30:31 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v5 3/9] iov_iter: Use IOCB/IOMAP_WRITE if available
 rather than iterator direction
Message-ID: <Y8Dsd5ZvkXHxCdxr@infradead.org>
References: <Y7+8r1IYQS3sbbVz@infradead.org>
 <167344725490.2425628.13771289553670112965.stgit@warthog.procyon.org.uk>
 <167344727810.2425628.4715663653893036683.stgit@warthog.procyon.org.uk>
 <15330.1673519461@warthog.procyon.org.uk>
 <Y8AUTlRibL+pGDJN@infradead.org>
 <Y8BFVgdGYNQqK3sB@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8BFVgdGYNQqK3sB@ZenIV>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 12, 2023 at 05:37:26PM +0000, Al Viro wrote:
> I have no problem with getting rid of iov_iter_rw(), but I would really like to
> keep ->data_source.  If nothing else, any place getting direction wrong is
> a trouble waiting to happen - something that is currently dealing only with
> iovec and bvec might be given e.g. a pipe.

But the calling code knows the direction, in fact it is generally
encoded in the actual operation we do on the iov_iter.  The only
exception is iov_iter_get_pages and friends.  So I'd much rather pass
make the lass operation that does not explicitly encode a direction
explicit rather than carrying this duplicate information.

The direction of the iov_iter has been a major source of confusing,
and getting rid of it removes that confusion.
