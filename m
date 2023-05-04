Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F3036F6F26
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 May 2023 17:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbjEDPhN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 May 2023 11:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbjEDPhM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 May 2023 11:37:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D28D6271C;
        Thu,  4 May 2023 08:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=Z5IJ8FitUNE2QS2yiRa5LLKouEb3BUu8Rhl1OJu2hKU=; b=MSdkdD0qO3wkiTc43I6g/CK525
        NThglTciRNY0CbdtLzYc0+HZeFwB0/O4H8/cgVgu2Vwlw51PqdXUmwek3jo/t1skKYvZc1IPp/ktH
        sjSW9KL09POnrtGCs5kLSvHAGLjpjfB4OBwQnXLorcP2+XQnOf4Be34bkTpXMqP/qm2jdteh11d7i
        IilJHox0DblPQ0oLOTL2RYqwQHrF/FII5beIIuWK5o85k6zGXYG635uSSE5sNYBOwVu7gIPKdlM4q
        /mDAAZVNLCVEZfcpGppVu56tKUqP1ikHDF12r7bKFcZQElUiF0nRVpHdBBR0Xd18shtd+bwWqrzhE
        AfCUFQ3g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pub10-00Aiya-8C; Thu, 04 May 2023 15:37:06 +0000
Date:   Thu, 4 May 2023 16:37:06 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Ilya Dryomov <idryomov@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: always respect QUEUE_FLAG_STABLE_WRITES on the block
 device
Message-ID: <ZFPRIq/4T6GPN07T@casper.infradead.org>
References: <20230504105624.9789-1-idryomov@gmail.com>
 <20230504135515.GA17048@lst.de>
 <ZFO+R0Ud6Yx546Tc@casper.infradead.org>
 <CAOi1vP_sEab6A3hsdZbVjvOXzWgFBJzrBZ4o9zNr7TT6fivTQg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOi1vP_sEab6A3hsdZbVjvOXzWgFBJzrBZ4o9zNr7TT6fivTQg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 04, 2023 at 05:07:10PM +0200, Ilya Dryomov wrote:
> On Thu, May 4, 2023 at 4:16 PM Matthew Wilcox <willy@infradead.org> wrote:
> > I hate both of these patches ;-)  What we should do is add
> > AS_STABLE_WRITES, have the appropriate places call
> > mapping_set_stable_writes() and then folio_wait_stable() becomes
> >
> >         if (mapping_test_stable_writes(folio->mapping))
> >                 folio_wait_writeback(folio);
> >
> > and we remove all the dereferences (mapping->host->i_sb->s_iflags, plus
> > whatever else is going on there)
> 
> Hi Matthew,
> 
> We would still need something resembling Christoph's suggestion for
> 5.10 and 5.15 (at least).  Since this fixes a regression, would you
> support merging the "ugly" version to facilitate backports or would
> you rather see the AS/mapping-based refactor first?

That's a terrible way of developing for Linux.  First, do it the right
way for mainline.  Then, see how easy the patch is to backport to relevant
kernel versions; if it's too ugly to cherry-pick, do something equivalent.
But never start out with the premise "This must be backported, so do it
as simply as possible first".
