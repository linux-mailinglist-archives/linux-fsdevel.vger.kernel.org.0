Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D612D7A22A7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Sep 2023 17:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235842AbjIOPld (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Sep 2023 11:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236207AbjIOPlP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Sep 2023 11:41:15 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BDB1E50;
        Fri, 15 Sep 2023 08:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ynT1nLavvHmZ9Y3KmC8cEJGBrfw6nFzCLS4ybzmu8CI=; b=LiB16jYTkCJkA/Ev76u4JJuDY6
        L7IDRqRgcgjkVp76JL9fktoTVPA9u0sAyvGaZX8A8K/ju+OcT8pWv28oMtxf17xXvtled4yuHA3ZZ
        an1KyUV184vlKwtURQSshBebJwypj5jEtJfcSc5WadN1mywYPQ8rmh9oYbZTvSbBKHF4eMj3J3oFL
        qaJXN+M6e/cjcl8/vg5YWF3sYkvaV32MOH3mZoq9VpW6rKio9NYd/DPu5nIOgbs8vWfk2g9dpyU1l
        dUVn4x+OmUsHm2XZ76jXaBiSEMMkOOnrH6wVii6yIA6YTxw4nAUDJTUAqCSQcUDl1QLr4EyBmL8TR
        tXm4OiZA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qhAwF-00AZVJ-Q8; Fri, 15 Sep 2023 15:40:59 +0000
Date:   Fri, 15 Sep 2023 16:40:59 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Daniel Gomez <da.gomez@samsung.com>,
        "minchan@kernel.org" <minchan@kernel.org>,
        "senozhatsky@chromium.org" <senozhatsky@chromium.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "hughd@google.com" <hughd@google.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "gost.dev@samsung.com" <gost.dev@samsung.com>,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH 0/6] shmem: high order folios support in write path
Message-ID: <ZQR7CyddIQQAs3yb@casper.infradead.org>
References: <CGME20230915095123eucas1p2c23d8a8d910f5a8e9fd077dd9579ad0a@eucas1p2.samsung.com>
 <20230915095042.1320180-1-da.gomez@samsung.com>
 <b8f75b8e-77f5-4aa1-ce73-6c90f7d87d43@redhat.com>
 <ZQR5nq7mKBJKEFHL@casper.infradead.org>
 <a5c37d6e-ca0f-65cf-a264-d1220d3c3c6d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5c37d6e-ca0f-65cf-a264-d1220d3c3c6d@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 15, 2023 at 05:36:27PM +0200, David Hildenbrand wrote:
> On 15.09.23 17:34, Matthew Wilcox wrote:
> > No, it can't.  This patchset triggers only on write, not on read or page
> > fault, and it's conservative, so it will only allocate folios which are
> > entirely covered by the write.  IOW this is memory we must allocate in
> > order to satisfy the write; we're just allocating it in larger chunks
> > when we can.
> 
> Oh, good! I was assuming you would eventually over-allocate on the write
> path.

We might!  But that would be a different patchset, and it would be
subject to its own discussion.

Something else I've been wondering about is possibly reallocating the
pages on a write.  This would apply to both normal files and shmem.
If you read in a file one byte at a time, then overwrite a big chunk of
it with a large single write, that seems like a good signal that maybe
we should manage that part of the file as a single large chunk instead
of individual pages.  Maybe.

Lots of things for people who are obsessed with performance to play
with ;-)
