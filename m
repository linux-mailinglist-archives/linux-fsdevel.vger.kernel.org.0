Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1109E74E196
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jul 2023 00:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbjGJWzW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Jul 2023 18:55:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjGJWzU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Jul 2023 18:55:20 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7409BC4;
        Mon, 10 Jul 2023 15:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=773eVrjDA0354m4Bp93hxWSrwXbzOVlmM5a7fOySKRc=; b=vElAcDTia2lQzMxXLwlOp9LAZb
        ZbxzL5TsrUqB3kJU85zizv7DvUuQpF3I3FqwALykzhC7JAoOK4TOKcF4c7eizSE6KnntNXNIxu9a7
        suWAQyxMHi76JLL/gHwcHsNQ4TZECVrl4qT307LvsvgtZszNvMA0hyH3X1ab6eVXk9LM1WcJMLuyZ
        glHSBkS91iCUR06jOnMBvgj4iXPXQn3Vxe28lwQXtzDbzcnVUhs9HqDgVt2Zt1/j8ii4opNSf6JRD
        1hN5lfyOc6lf23wQWXFiiDA1qWWifcFOrUr72UcrLHboewRhDUgCevh1Ak7hq/0iG/QflTgzQce2M
        EpWxrb+Q==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qIzmn-00Ctp0-1j;
        Mon, 10 Jul 2023 22:55:17 +0000
Date:   Mon, 10 Jul 2023 15:55:17 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Wang Yugui <wangyugui@e16-tech.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Kent Overstreet <kent.overstreet@linux.dev>, mcgrof@kernel.org
Subject: Re: [PATCH v4 0/9] Create large folios in iomap buffered write path
Message-ID: <ZKyMVRDhwYWvqyvv@bombadil.infradead.org>
References: <20230710130253.3484695-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230710130253.3484695-1-willy@infradead.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 10, 2023 at 02:02:44PM +0100, Matthew Wilcox (Oracle) wrote:
> Commit ebb7fb1557b1 limited the length of ioend chains to 4096 entries
> to improve worst-case latency.  Unfortunately, this had the effect of
> limiting the performance of:
> 
> fio -name write-bandwidth -rw=write -bs=1024Ki -size=32Gi -runtime=30 \
>         -iodepth 1 -ioengine sync -zero_buffers=1 -direct=0 -end_fsync=1 \
>         -numjobs=4 -directory=/mnt/test

When you say performance, do you mean overall throughput / IOPS /
latency or all?

And who noticed it / reported it? The above incantation seems pretty
specific so I'm curious who runs that test and what sort of work flow
is it trying to replicate.

> The problem ends up being lock contention on the i_pages spinlock as we
> clear the writeback bit on each folio (and propagate that up through
> the tree).  By using larger folios, we decrease the number of folios
> to be processed by a factor of 256 for this benchmark, eliminating the
> lock contention.

Implied here seems to suggest that the associated cost for the search a
larger folio is pretty negligable compared the gains of finding one.
That seems to be nice but it gets me wondering if there are other
benchmarks under which there is any penalties instead.

Ie, is the above a microbenchmark where this yields good results?

> It's also the right thing to do.  This is a project that has been on
> the back burner for years, it just hasn't been important enough to do
> before now.

Commit ebb7fb1557b1 (xfs, iomap: limit individual ioend chain lengths in
writeback") dates back to just one year, and so it gets me wondering
how a project in the back burner for years now finds motivation for
just a one year old regression.

What was the original motivation of the older project dating this
effort back to its inception?

  Luis
