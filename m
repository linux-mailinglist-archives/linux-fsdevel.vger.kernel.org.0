Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDCB174CAE9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jul 2023 05:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbjGJD5o (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 9 Jul 2023 23:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjGJD5n (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 9 Jul 2023 23:57:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 056C9DF;
        Sun,  9 Jul 2023 20:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2qzxQ/U29AAMtWwNP3rLM0qX4x6jBe46q+doSefeGW8=; b=kYCmKaXWAWvdqEgtKb2AmWPad+
        E1somgHI19G3qCoH2lAIuhagCnbOGGhBMFtqVqXTk1E+newmS4lstiQMEv+/wejAklSwDDqDBgQfU
        wf7deYXCK+RfCBmLc2R9cLPZwMidskp8DLhYjG/hWMuN/tTQkud//sPS/62Sel8mDpy2w3bZ6qf2M
        Mdo0gYG27hM/x5xQmqq5OzART9hS3dzo1j1OPNE21ubFoyJKUOEqMSAjckoG/B8+/gMpbNYgc2926
        i5DYLHHe7SgVmNWLpa+OIwY5tRZHVc1s4sl0tMLVrHY8/nSTDORVhTbhrfB32yStl7mGv/1MrM44y
        MwwtJBgQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qIi1s-00EFpE-Bi; Mon, 10 Jul 2023 03:57:40 +0000
Date:   Mon, 10 Jul 2023 04:57:40 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Ritesh Harjani <ritesh.list@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Wang Yugui <wangyugui@e16-tech.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>
Subject: Re: [PATCH v3 8/8] iomap: Copy larger chunks from userspace
Message-ID: <ZKuBtB/Ie62Lx6Qw@casper.infradead.org>
References: <20230612203910.724378-9-willy@infradead.org>
 <877cs2o91k.fsf@doe.com>
 <ZJCL1phh2UOqrM8J@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJCL1phh2UOqrM8J@casper.infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 19, 2023 at 06:09:42PM +0100, Matthew Wilcox wrote:
> > > @@ -835,6 +837,8 @@ static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
> > >  			 */
> > >  			if (copied)
> > >  				bytes = copied;
> > 
> > I think with your code change which changes the label position of
> > "again", the above lines doing bytes = copied becomes dead code.
> > We anyway recalculate bytes after "again" label. 
> 
> Yes, you're right.  Removed.  I had a good think about whether this
> forgotten removal meant an overlooked problem, but I can't see one.

... also, removing this means that 'goto again' has the same effect as
'continue' ... which means we can actually restructure the loop slightly
and avoid the again label, the goto and even the continue.  Patch to
follow in a few hours.
