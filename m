Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E98C2679918
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 14:18:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234107AbjAXNS4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Jan 2023 08:18:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234205AbjAXNSj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Jan 2023 08:18:39 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D24E46712;
        Tue, 24 Jan 2023 05:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HTTBGfjn7nRkSukN0saTCzZiE/bxcd4l/l4Ax47zdsU=; b=GhSP7kMTmQvV91SOWLa+z+5Wfm
        DLMaXzL855XpJ273A6saQAsgAijJyKQuGH1FMtelh6lfkjN/Xg3BSVnWRTubPM4QVDLVrBvUEAzcp
        xt8Nkkr4ntZLRjTvdZd6uvckAq0XupErlSbwg8lQKTLWYibyFUDWs1iu/+Gvu7P7wfZ9siBeLMyir
        bAydGKjzGgMknI6XORTajsUe0zCAfpsMZcjl4Xj/n6R6ko5/Tr29TfeBROUw2Z0JZwW8qBENvQ4D+
        9JhToKv8qUQ6AgZ5WwG8boOrTzibQaFmFgal5rIFH6XPCdExHFHiVLst6rqJ/dZBbT8MGI7BA398Y
        vG+84tiA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pKJBf-003vM7-PB; Tue, 24 Jan 2023 13:18:07 +0000
Date:   Tue, 24 Jan 2023 05:18:07 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     John Hubbard <jhubbard@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        linux-mm@kvack.org
Subject: Re: [PATCH v8 10/10] mm: Renumber FOLL_PIN and FOLL_GET down
Message-ID: <Y8/ajxH0PF8PaiA9@infradead.org>
References: <20230123173007.325544-1-dhowells@redhat.com>
 <20230123173007.325544-11-dhowells@redhat.com>
 <31f7d71d-0eb9-2250-78c0-2e8f31023c66@nvidia.com>
 <84721e8d-d40e-617c-b75e-ead51c3e1edf@nvidia.com>
 <Y8/ZekMEAfi8VeFl@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8/ZekMEAfi8VeFl@nvidia.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 24, 2023 at 09:13:30AM -0400, Jason Gunthorpe wrote:
> Yeah, I already wrote a similar patch, using the 1<< notation, 
> splitting the internal/external, and rebasing on the move to
> mm_types.. I can certainly drop that patch if we'd rather do this.

Given that you are doing more work in that area it might be best
to drop this patch from this series.

> Though, I'm not so keen on using FOLL_ internal flags inside the block
> layer.. Can you stick with the BIO versions of these?

The block layer doesn't really use it - the new helper in iov_iter.c
returns it, and the block layer instantly turns it into an internal
flag.  But maybe it should just return a bool pinned (by reference)
now?
