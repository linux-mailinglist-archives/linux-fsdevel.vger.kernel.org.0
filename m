Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34C3C5E661B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Sep 2022 16:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231649AbiIVOp5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Sep 2022 10:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbiIVOp4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Sep 2022 10:45:56 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5088EC55D;
        Thu, 22 Sep 2022 07:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5kHgWCwEbxWgmMTo+jNfFcNjbPacO3aCj4iIOLbRicU=; b=2vNBwsjTTn0LUzW+5rfX5DzXI5
        TtTFhfRXDFW9bxswhf5umeUoHtQWTq494DPJyBDzsBDF+Hzd0O4OQl1hbhet7nu0uxIy3LVqS3jq4
        mmRRlHSH6lMf+EVh5Bg0CCptDYO+kgsxNDmFi0oKZ5eFoKri3/nKBMvPbIaXrSN5nZsNnKa2hp+0u
        loVHOn5Rl3eRq1aVFDWBsGY2aWKTN+VErE1Ub+Mq7/lsBCzYbOQN4MFiTfKVdAov5FfZTpOvmIHhi
        Yf6igs3SHVMhbmBQgLfRksuQYYs4EXrd+/kAGW1nVLuZxVs0TwN2uLhANKB0eNq63SmTPCQBKMVhc
        Vs04x6Jw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1obNSU-00G9HJ-Ui; Thu, 22 Sep 2022 14:45:46 +0000
Date:   Thu, 22 Sep 2022 07:45:46 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/7] iov_iter: new iov_iter_pin_pages*() routines
Message-ID: <Yyx1GtvLe2fkCtbP@infradead.org>
References: <20220906102106.q23ovgyjyrsnbhkp@quack3>
 <YxhaJktqtHw3QTSG@infradead.org>
 <YyFPtTtxYozCuXvu@ZenIV>
 <20220914145233.cyeljaku4egeu4x2@quack3>
 <YyIEgD8ksSZTsUdJ@ZenIV>
 <20220915081625.6a72nza6yq4l5etp@quack3>
 <YyPXqfyf37CUbOf0@ZenIV>
 <YylJU+BKw5R8u7dw@ZenIV>
 <Yyxy4HFMhpbU/wLu@infradead.org>
 <c100fcd6-60fb-6650-fdac-7cc3a3bbc464@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c100fcd6-60fb-6650-fdac-7cc3a3bbc464@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 22, 2022 at 04:43:57PM +0200, David Hildenbrand wrote:
> I assume they are not anon pages as in "PageAnon()", but simply not
> pagecache pages, correct?

Yes, sorry.  From the page allocator and not added to the page cache.
