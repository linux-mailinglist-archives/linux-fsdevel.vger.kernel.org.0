Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB2DF5EB1B2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Sep 2022 21:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbiIZTzi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Sep 2022 15:55:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbiIZTz1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Sep 2022 15:55:27 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56D5A2633;
        Mon, 26 Sep 2022 12:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BCNxkn1cjjmSTz0F2QcnuWmtFkHDRw/dUVSXShbYPtk=; b=ofdS4CZ7qJGuelZ07G6x4wyeEq
        o4+hP4T1gJZQnEOjyxGireIZZ1+MEg9aoxeDeG/R2AvDSx4S7qCp8P5aZVOnHfxeOFc8cMCjgbXXk
        Z07GM4aucnTmj7FnuBlJNT9iTC861d2/5SW4rZtQ98JFH0QB7wuN5CKl7YicCNrwYElAn1ggLn9Ve
        3hSS4/UMsj31cJRSiaLYOkcjjsgeIhghk7MnSbCwU+QqyAt2lz7kiBvCnwOP1+RtF0dnUSI/UdcwZ
        jgaZXePZnUP3ebMoUoLAECO5gB01LB4t609jzxdzCKZe6oVVhGyVslpBCj8yWuLLW8GQi5ebLXOS9
        /ef2RS2g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1ocuC1-0048RF-0x;
        Mon, 26 Sep 2022 19:55:05 +0000
Date:   Mon, 26 Sep 2022 20:55:05 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jan Kara <jack@suse.cz>, John Hubbard <jhubbard@nvidia.com>,
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
Message-ID: <YzIDmUzPh3hikmP3@ZenIV>
References: <YyFPtTtxYozCuXvu@ZenIV>
 <20220914145233.cyeljaku4egeu4x2@quack3>
 <YyIEgD8ksSZTsUdJ@ZenIV>
 <20220915081625.6a72nza6yq4l5etp@quack3>
 <YyvG+Oih2A37Grcf@ZenIV>
 <YyxzYTlyGhbb2MOu@infradead.org>
 <Yy00eSjyxvUIp7D5@ZenIV>
 <Yy1x8QE9YA4HHzbQ@infradead.org>
 <Yy3bNjaiUoGv/djG@ZenIV>
 <YzHLB4lGa2vktN7W@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzHLB4lGa2vktN7W@infradead.org>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 26, 2022 at 08:53:43AM -0700, Christoph Hellwig wrote:
> On Fri, Sep 23, 2022 at 05:13:42PM +0100, Al Viro wrote:
> > You are mixing two issues here - holding references to pages while using
> > iov_iter instance is obvious; holding them until async IO is complete, even
> > though struct iov_iter might be long gone by that point is a different
> > story.
> 
> But someone needs to hold a refernce until the I/O is completed, because
> the I/O obviously needs the pages.  Yes, we could say the callers holds
> them and can drop the references right after I/O submission, while
> the method needs to grab another reference.  But that is more
> complicated and is more costly than just holding the damn reference.

Take a look at __nfs_create_request().  And trace the call chains leading
to nfs_clear_request() where the corresponding put_page() happens.

What I'm afraid of is something similar in the bowels of some RDMA driver.
With upper layers shoving page references into sglist using iov_iter_get_pages(),
then passing sglist to some intermediate layer, then *that* getting passed down
into a driver which grabs references for its own use and releases them from
destructor of some private structure.  Done via kref_put().  Have that
delayed by, hell - anything, up to and including debugfs shite somewhere
in the same driver, iterating through those private structures, grabbing
a reference to do some pretty-print into kmalloc'ed buffer, then drooping it.
Voila - we have page refs duplicated from ITER_BVEC and occasionally staying
around after the ->ki_complete() of async ->write_iter() that got that
ITER_BVEC.

It's really not a trivial rule change.
