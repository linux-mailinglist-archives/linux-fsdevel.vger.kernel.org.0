Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3AD74E2AE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jul 2023 02:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbjGKAmw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Jul 2023 20:42:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjGKAmv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Jul 2023 20:42:51 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9F981B0;
        Mon, 10 Jul 2023 17:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HpuCUZb2f48UIm658h4OAVOVtyttzCpjEbk83B2wiGI=; b=Cf/Fqi85CIj4+9JriBAdxLX0BW
        V2hQexU7UDKxBXIX6HGyWVd0diKb7Gigwjqec6afVqK5MKsn+2zrGrjuUqn2oNeWhZRVLHNM0oc2m
        BhKh4jP6I5BgCKS5W5wSvZKGRKjsYtusB34q9ShINya9DtwAQpruIVWIO9BO3qmLGEt8ZA2gqvTvv
        hKKGqIv2GfpWEsi8/U4tAybfOxdT1l9WphhydYpHFFo0pYAYv+mzmG7kccoEthvE+r/72yn+EKIfM
        V5cynfAT4vmZTDcTvha4sCmCHVGWR/y8IYozl6wGucvBIjUYPVxgdkzDcEWkeX/IQKmxiJB82B8UF
        2YlxKBiw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qJ1Sn-00F77Z-H8; Tue, 11 Jul 2023 00:42:45 +0000
Date:   Tue, 11 Jul 2023 01:42:45 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Wang Yugui <wangyugui@e16-tech.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Kent Overstreet <kent.overstreet@linux.dev>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v4 7/9] filemap: Allow __filemap_get_folio to allocate
 large folios
Message-ID: <ZKylhWKed7Zraclk@casper.infradead.org>
References: <20230710130253.3484695-1-willy@infradead.org>
 <20230710130253.3484695-8-willy@infradead.org>
 <ZKybP22DRs1w4G3a@bombadil.infradead.org>
 <ZKydSZM70Fd2LW/q@casper.infradead.org>
 <ZKygcP5efM2AE/nr@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZKygcP5efM2AE/nr@bombadil.infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 10, 2023 at 05:21:04PM -0700, Luis Chamberlain wrote:
> On Tue, Jul 11, 2023 at 01:07:37AM +0100, Matthew Wilcox wrote:
> > The caller hints at the
> > folio size it wants, and this code you're highlighting limits it to be
> > less than MAX_PAGECACHE_ORDER.
> 
> Yes sorry, if the write size is large we still max out at MAX_PAGECACHE_ORDER
> naturally. I don't doubt the rationale that that is a good idea.
> 
> What I'm curious about is why are we OK to jump straight to MAX_PAGECACHE_ORDER
> from the start and if there are situations where perhaps a a
> not-so-aggressive high order may be desriable. How do we know?

The page cache trusts the filesystem to make a good guess.  Dave had some
ideas about how XFS might make different guesses from the one in this
patchset, and I encourage people to experiment with different algorithms.

Intuitively "size of the write" is probably not a bad guess.  If userspace
is writing 400kB in a single write, it proabbly makes sense to writeback
& age and eventually reclaim that entire 400kB at the same time.  If we
guess wrong, the downside probably isn't too bad either.

But we need data!  And merging this patch set & gathering real world
experience with it is a good start.
