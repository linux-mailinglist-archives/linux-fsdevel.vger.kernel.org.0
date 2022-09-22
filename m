Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F2685E65EF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Sep 2022 16:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231849AbiIVOjy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Sep 2022 10:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231852AbiIVOje (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Sep 2022 10:39:34 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35D94FE057;
        Thu, 22 Sep 2022 07:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=37n5cEapWKfoXE8Bf6DFAQZkuLu5DdKO4tw3Xp6LEvs=; b=FfVJkqpELYi6tUWlw6XBYIh7FT
        cWh9uVle8XDuwjuWYQR7SN1CwxKbgC8IOozJlvUjB50JnIniobV6Y/7H/n7GaTcM6W7nmT+kfNmMM
        pcKqI6xgwg2aRQ2/Sk7jtmn37eOCC9uFFrvCI/c7TqnVNK1m6Bnuy/yIhpXHUwfE6om6kLOuDMbPm
        VotYmqPnWO7ReMpJ/3mnqQBu/UUSBIb8Zn1S6C0aStVqoEOYwN3ZF+IbMHvZme0ZoGXKJ7gLGOfC+
        PGGHJ8xKRfNzS1osbImT9twYd9U9wT7xq4uFsoCA3AKCTZ4/JpGwzpgTCLrYK2iPGctspqRqUxttn
        ppGH0Oxw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1obNLN-00G6BV-1d; Thu, 22 Sep 2022 14:38:25 +0000
Date:   Thu, 22 Sep 2022 07:38:25 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>,
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
Message-ID: <YyxzYTlyGhbb2MOu@infradead.org>
References: <YxbtF1O8+kXhTNaj@infradead.org>
 <103fe662-3dc8-35cb-1a68-dda8af95c518@nvidia.com>
 <Yxb7YQWgjHkZet4u@infradead.org>
 <20220906102106.q23ovgyjyrsnbhkp@quack3>
 <YxhaJktqtHw3QTSG@infradead.org>
 <YyFPtTtxYozCuXvu@ZenIV>
 <20220914145233.cyeljaku4egeu4x2@quack3>
 <YyIEgD8ksSZTsUdJ@ZenIV>
 <20220915081625.6a72nza6yq4l5etp@quack3>
 <YyvG+Oih2A37Grcf@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YyvG+Oih2A37Grcf@ZenIV>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 22, 2022 at 03:22:48AM +0100, Al Viro wrote:
> What I'd like to have is the understanding of the places where we drop
> the references acquired by iov_iter_get_pages().  How do we decide
> whether to unpin?

Add a iov_iter_unpin_pages that does the right thing based on the
type.  (block will need a modified copy of it as it doesn't keep
the pages array around, but logic will be the same).

> E.g. pipe_buffer carries a reference to page and no
> way to tell whether it's a pinned one; results of iov_iter_get_pages()
> on ITER_IOVEC *can* end up there, but thankfully only from data-source
> (== WRITE, aka.  ITER_SOURCE) iov_iter.  So for those we don't care.
> Then there's nfs_request; AFAICS, we do need to pin the references in
> those if they are coming from nfs_direct_read_schedule_iovec(), but
> not if they come from readpage_async_filler().  How do we deal with
> coalescence, etc.?  It's been a long time since I really looked at
> that code...  Christoph, could you give any comments on that one?

I think the above should work, but I'll need to look at the NFS code
in more detail to be sure.
