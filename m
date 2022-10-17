Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 995A4601007
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Oct 2022 15:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbiJQNQN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Oct 2022 09:16:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiJQNQM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Oct 2022 09:16:12 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A3E167DE;
        Mon, 17 Oct 2022 06:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=aGtg2Qj2UsZ6c2ADL+W0CG9O1Y771EKXkyHyvj1eDO0=; b=I+MvpcvCzDPis8piDJr5WJCHXZ
        8osuIpox/vJzj2b2p2TeK14qywkWvP07p0lrq6d+TD/3fYVV1N7hFqmwxB+99V3ABhWIWgt8GAKag
        hsTszpBAI2lmS8pwjDahw6JDAfE8IFsIhQibctK4XJVsRTWktl9e9DwRyZvU7Nh81mWGFgUN3L0Ow
        +Ryo7NBlnOtAbJX9iBL6tprVdn8TO16zTzurZeUuycJkL42F1zapbNRmkUZ6CEqrBSMHKWZ6HgwBd
        NJRjs4ObvIb+5SDZEZq2UiQqckr78+0hTLCya4Mgnmu95vFB1ItKRGBZKzLGugB1Elxx5xZIqPYG/
        BhjSgSEA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1okPyH-00C5kl-0a; Mon, 17 Oct 2022 13:15:57 +0000
Date:   Mon, 17 Oct 2022 06:15:56 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>, willy@infradead.org,
        dchinner@redhat.com, Steve French <smfrench@gmail.com>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        torvalds@linux-foundation.org, linux-cifs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: How to convert I/O iterators to iterators, sglists and RDMA lists
Message-ID: <Y01VjOE2RrLVA2T6@infradead.org>
References: <1762414.1665761217@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1762414.1665761217@warthog.procyon.org.uk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 14, 2022 at 04:26:57PM +0100, David Howells wrote:
>  (1) Async direct I/O.
> 
>      In the async case direct I/O, we cannot hold on to the iterator when we
>      return, even if the operation is still in progress (ie. we return
>      EIOCBQUEUED), as it is likely to be on the caller's stack.
> 
>      Also, simply copying the iterator isn't sufficient as virtual userspace
>      addresses cannot be trusted and we may have to pin the pages that
>      comprise the buffer.

This is very related to the discussion we are having related to pinning
for O_DIRECT with Ira and Al.  What block file systems do is to take
the pages from the iter and some flags on what is pinned.  We can
generalize this to store all extra state in a flags word, or byte the
bullet and allow cloning of the iter in one form or another.

>  (2) Crypto.
> 
>      The crypto interface takes scatterlists, not iterators, so we need to be
>      able to convert an iterator into a scatterlist in order to do content
>      encryption within netfslib.  Doing this in netfslib makes it easier to
>      store content-encrypted files encrypted in fscache.

Note that the scatterlist is generally a pretty bad interface.  We've
been talking for a while to have an interface that takes a page array
as an input and return an array of { dma_addr, len } tuples.  Thinking
about it taking in an iter might actually be an even better idea.

>  (3) RDMA.
> 
>      To perform RDMA, a buffer list needs to be presented as a QPE array.
>      Currently, cifs converts the iterator it is given to lists of pages, then
>      each list to a scatterlist and thence to a QPE array.  I have code to
>      pass the iterator down to the bottom, using an intermediate BVEC iterator
>      instead of a page list if I can't pass down the original directly (eg. an
>      XARRAY iterator on the pagecache), but I still end up converting it to a
>      scatterlist, which is then converted to a QPE.  I'm trying to go directly
>      from an iterator to a QPE array, thus avoiding the need to allocate an
>      sglist.

I'm not sure what you mean with QPE.  The fundamental low-level
interface in RDMA is the ib_sge.  If you feed it to RDMA READ/WRITE
requests the interface for that is the RDMA R/W API in
drivers/infiniband/core/rw.c, which currently takes a scatterlist but
to which all of the above remarks on DMA interface apply.  For RDMA
SEND that ULP has to do a dma_map_single/page to fill it, which is a
quite horrible layering violation and should move into the driver, but
that is going to a massive change to the whole RDMA subsystem, so
unlikely to happen anytime soon.

Neither case has anything to do with what should be in common iov_iter
code, all this needs to live in the RDMA subsystem as a consumer.
