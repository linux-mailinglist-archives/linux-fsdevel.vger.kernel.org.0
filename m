Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69F79678202
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jan 2023 17:43:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233383AbjAWQne (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Jan 2023 11:43:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233314AbjAWQnZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Jan 2023 11:43:25 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E1892D173;
        Mon, 23 Jan 2023 08:43:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=p4HgFxy6mLo8zzLlEGW1QRWEKxassPu4wwIJpwTVZHU=; b=gPLkQUa/b4j+aQ8Sl5cIlUfqSj
        Ft2dnwqr+/hclbHhFT9bUZA0dszqDhZbBNRYLsmKM/zHlCkcW62BFzmzhqwynry183IZXdPjxxRa7
        hUMdiJg/5y7IZqSEOS1ZbUWsbqwEeZat121QtlfnCLi6DBpMbKyVOurxaNtYifTnlxn24BhiSWNn7
        fl0sRy8xvrN7vjsQqkxxsnbM5Sx7SKfc0di2RugQzKGSl52EkRaTZ3jhMsmK6iPv4JlkpVY5cFEQL
        UoNkPcirQCAUwirqvcezrUFt/fSIJNLNMpLeMy2Sr3FgKX1g1fRkYE8Jfii5oOefMBrx2MK31xYyQ
        gR0EeOjw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pJzuK-004NNk-4c; Mon, 23 Jan 2023 16:42:56 +0000
Date:   Mon, 23 Jan 2023 16:42:56 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     John Hubbard <jhubbard@nvidia.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 0/8] iov_iter: Improve page extraction (ref, pin or
 just list)
Message-ID: <Y865EIsHv3oyz+8U@casper.infradead.org>
References: <Y862ZL5umO30Vu/D@casper.infradead.org>
 <20230120175556.3556978-1-dhowells@redhat.com>
 <318138.1674491927@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <318138.1674491927@warthog.procyon.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 23, 2023 at 04:38:47PM +0000, David Howells wrote:
> Matthew Wilcox <willy@infradead.org> wrote:
> 
> > Why do we want to track that information on a per-page basis?  Wouldn't it
> > be easier to have a VM_NOCOW flag in vma->vm_flags?  Set it the first
> > time somebody does an O_DIRECT read or RDMA pin.  That's it.  Pages in
> > that VMA will now never be COWed, regardless of their refcount/mapcount.
> > And the whole "did we pin or get this page" problem goes away.  Along
> > with folio->pincount.
> 
> Wouldn't that potentially make someone's entire malloc() heap entirely NOCOW
> if they did a single DIO to/from it.

Yes.  Would that be an actual problem for any real application?

We could do this with a vm_pincount if it's essential to be able to
count how often it's happened and be able to fork() without COW if it's
something that happened in the past and is now not happening.

> Also you only mention DIO read - but what about "start DIO write; fork(); touch
> buffer" in the parent - now the write buffer belongs to the child and they can
> affect the parent's write.

I'm struggling to see the problem here.  If the child hasn't exec'd, the
parent and child are still in the same security domain.  The parent
could have modified the buffer before calling fork().
