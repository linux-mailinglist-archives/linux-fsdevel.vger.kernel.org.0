Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7DE5E65CC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Sep 2022 16:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbiIVOg3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Sep 2022 10:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbiIVOg1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Sep 2022 10:36:27 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8846F50A0;
        Thu, 22 Sep 2022 07:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=02+QEmbVk9AVv9jEQgWKTTpXwGOiCyNcTFilArR3/C0=; b=POG8m7fdprEJLvFevbUlMRiZP0
        1WqOY/+mhbT6uL6MLBd2M+9I++CBs1HDQYdONcZ3V0xwcZgXu+85xDEBnJHS37XJJRnqcKLU0SsWp
        wkSvLy6u88CwMk1WkgPa4W0wmkxh4n+NUa7jKeQ0EKrIhFhPImmCug7TT8YbE/fz5n+sAqaTI7tjV
        IztsB6PCr1wt4VGkjoE3msb8tbK0qVBl9TTz1Jl8llcH2HiRHQyAR8QuHbde3VMsu+B+rpHNxG1E9
        Tm4Vb0V7JkeAKKqqBB4tTzV1V5LOXBmYkriDO6x65Hk/KS4XGO8woeVzT+PoapOYprl1c4tyjSBeA
        RVCrwhGg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1obNJI-00G5Be-RS; Thu, 22 Sep 2022 14:36:16 +0000
Date:   Thu, 22 Sep 2022 07:36:16 -0700
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
Message-ID: <Yyxy4HFMhpbU/wLu@infradead.org>
References: <103fe662-3dc8-35cb-1a68-dda8af95c518@nvidia.com>
 <Yxb7YQWgjHkZet4u@infradead.org>
 <20220906102106.q23ovgyjyrsnbhkp@quack3>
 <YxhaJktqtHw3QTSG@infradead.org>
 <YyFPtTtxYozCuXvu@ZenIV>
 <20220914145233.cyeljaku4egeu4x2@quack3>
 <YyIEgD8ksSZTsUdJ@ZenIV>
 <20220915081625.6a72nza6yq4l5etp@quack3>
 <YyPXqfyf37CUbOf0@ZenIV>
 <YylJU+BKw5R8u7dw@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YylJU+BKw5R8u7dw@ZenIV>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 20, 2022 at 06:02:11AM +0100, Al Viro wrote:
> nvme target: nvme read requests end up with somebody allocating and filling
> sglist, followed by reading from file into it (using ITER_BVEC).  Then the
> pages are sent out, presumably

Yes.

> .  I would be very surprised if it turned out
> to be anything other than anon pages allocated by the driver, but I'd like
> to see that confirmed by nvme folks.  Probably doesn't need pinning.

They are anon pages allocated by the driver using sgl_alloc().

> drivers/target/target_core_file.c:292:  iov_iter_bvec(&iter, is_write, aio_cmd->bvecs, sgl_nents, len);

Same as nvme target.

> The picture so far looks like we mostly need to take care of pinning when
> we obtain the references from iov_iter_get_pages().  What's more, it looks
> like ITER_BVEC/ITER_XARRAY/ITER_PIPE we really don't need to pin anything on
> get_pages/pin_pages - they are already protected (or, in case of ITER_PIPE,
> allocated by iov_iter itself and not reachable by anybody outside).

That's what I've been trying to say for a while..

